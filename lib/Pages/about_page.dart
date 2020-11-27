import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  static const routeName = '/about';

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final _formKey = GlobalKey<FormState>();

  String uName;

  String body;

  String mail = "kamilanwar2001@gmail.com";

  submitForm() async {
    bool isValid = _formKey.currentState.validate();

    if (isValid) {
      _formKey.currentState.save();
      var url = 'mailto:$mail?subject=ArtistoSupport-$uName&body=$body';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "About Page",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromRGBO(112, 225, 245, 1),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(112, 225, 245, 1),
                  Color.fromRGBO(255, 209, 148, 1)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/kamil.jpg'),
                  radius: 60,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Kamil Anwar (Me)",
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w600, fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "www.kamil.digital",
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w400, fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "This app is made using flutter and dart by me , more than an app it is a learning experience like no other.",
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w400, fontSize: 18),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "In case of any Issues and Bugs feel free to ping me.",
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.w400, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        onSaved: (value) {
                          uName = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter a Value";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Your Name",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        maxLines: 3,
                        autocorrect: false,
                        onSaved: (value) {
                          body = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter a Value";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Body",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.1),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () => submitForm(),
                        child: Text('Send !'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
