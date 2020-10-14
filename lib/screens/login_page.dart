import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manan_mobile/services/auth.dart';
import 'package:manan_mobile/services/firestore_methods.dart';
import 'package:manan_mobile/size_config.dart';
import 'package:manan_mobile/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Sign In",
          style: GoogleFonts.muli(
            color: Colors.black54,
            fontSize: getProportionateScreenHeight(20.0),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Body(formKey: _formKey),
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    Key key,
    @required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthServices _authServices = AuthServices();
  var emailCon = TextEditingController();
  var passCon = TextEditingController();
  String email = '', password = '';
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenHeight(35.0),
              ),
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: getProportionateScreenHeight(35)),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25),
              ),
              Text(
                "sign in with email and password or \n with a social account",
                style: TextStyle(fontSize: getProportionateScreenHeight(18)),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: getProportionateScreenHeight(60.0),
              ),
              Form(
                key: widget._formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(35),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(25),
                      ),
                      CustomInput(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter the email';
                          }
                        },
                        hintText: "Enter the Email",
                        textInputAction: TextInputAction.next,
                        label: "Email",
                        iconData: Icon(
                          EvaIcons.emailOutline,
                          color: Colors.orange,
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                        onSubmitted: (value) {
                          _passwordFocusNode.requestFocus();
                        },
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      CustomInput(
                        validator: (value) {
                          if (value.length < 6) {
                            return 'Enter the 6+ character long password';
                          }
                        },
                        focusNode: _passwordFocusNode,
                        hintText: "Enter the Password",
                        label: "Password",
                        iconData: Icon(
                          EvaIcons.lockOutline,
                          color: Colors.orange,
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                        obscuredText: true,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: getProportionateScreenHeight(56),
                        child: FlatButton(
                          onPressed: () async {
                            if (widget._formKey.currentState.validate()) {
                              await _authServices.signInWithEmailAndPass(
                                  email, password);
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(20.0),
                              color: Colors.white,
                            ),
                          ),
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              getProportionateScreenHeight(18.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(120.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSocialAccountButton(
                    icon: Icon(EvaIcons.google),
                    onTap: () async {
                      await _authServices.googleSignIn().then((user) {
                        if (user != null) {
                          FireStoreMethods().addUserToFireStore(user);
                        }
                      });
                    },
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(20.0),
                  ),
                  CustomSocialAccountButton(
                    icon: Icon(EvaIcons.facebook),
                    onTap: () async {},
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(20.0),
                  ),
                  CustomSocialAccountButton(
                    icon: Icon(EvaIcons.phone),
                    onTap: () async {},
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have any account? ",
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(8.0),
                  ),
                  GestureDetector(
                    child: Text(
                      "Create New",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: getProportionateScreenHeight(25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSocialAccountButton extends StatelessWidget {
  final Function onTap;
  final Icon icon;
  CustomSocialAccountButton({this.onTap, this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: getProportionateScreenHeight(80.0),
        width: getProportionateScreenWidth(100.0),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          shape: BoxShape.circle,
        ),
        child: icon,
      ),
    );
  }
}

// RaisedButton(
// onPressed: () async {
// await _authServices.googleSignIn().then((dynamic user){
// if(user != null){
// FireStoreMethods().addUserToFireStore(user).then((value)=>print("success"));
// }
// });
// },
// child: Text("LogIn"),
// )
