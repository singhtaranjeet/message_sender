import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message_sender/helpers/color_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageSenderScreen extends StatefulWidget {
  @override
  _MessageSenderScreenState createState() => _MessageSenderScreenState();
}

class _MessageSenderScreenState extends State<MessageSenderScreen> {
  final _phoneNumberController = TextEditingController();
  final _optionalMessageController = TextEditingController();
  final String indianCountryCode = "+91";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Message Sender",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Text(
                  "Easily send whatsapp message to unsaved contacts without the hassle of saving them",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: _phoneNumberController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.phone,
                maxLength: 10,
                buildCounter: (context,
                        {required currentLength,
                        required isFocused,
                        maxLength}) =>
                    null,
                autofocus: true,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4),
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  labelStyle: TextStyle(color: Colors.white, letterSpacing: 1),
                  isDense: true,
                  prefix: Text(
                    indianCountryCode,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _optionalMessageController,
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Optional Message",
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: "Enter optional message",
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Send",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.send_rounded)
                    ],
                  ),
                  onPressed: () {
                    print("$indianCountryCode${_phoneNumberController.text}");

                    sendWhatsAppMessage();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sendWhatsAppMessage() async {
    final String phone = _phoneNumberController.text;
    final String message = _optionalMessageController.text;
    String whatsAppUrl =
        "whatsapp://send?phone=$indianCountryCode$phone&text=${Uri.parse(message)}";
    print(whatsAppUrl);
    if (!await canLaunch(whatsAppUrl)) {
      showSnackBar();
    }
    launch(whatsAppUrl);
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.cancel,
              color: ColorConstants.errorColor,
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
                child: Text(
                    "Cannot open this contact, please try some other one.")),
          ],
        ),
      ),
    );
  }
}
