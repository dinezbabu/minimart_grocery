import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:minimart_grocery/models/register_request_model.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../config.dart';
import '../services/api_service.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}): super (key:key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isAPICallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? userName;
  String? password;
  String? email;
  String? mobile;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: HexColor("#283B71"),
          body: ProgressHUD(
            child: Form(
              key: globalFormKey,
              child: _registerUI(context),
            ),
            inAsyncCall: isAPICallProcess,
            opacity: 0.3,
            key: UniqueKey(),
          ),
        ));
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white],
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/shopping.png",
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 30, top: 20),
              child: Text(
                "Register",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white),
              )),
          FormHelper.inputFieldWidget(
              context, const Icon(Icons.person), "username", "UserName",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Username can't be Empty.";
                }
                return null;
              }, (onSavedVal) {
            userName = onSavedVal;
          },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: FormHelper.inputFieldWidget(
                  context, const Icon(Icons.password), "password", "Password",
                      (onValidateVal) {
                    if (onValidateVal.isEmpty) {
                      return "Password can't be Empty.";
                    }
                    return null;
                  }, (onSavedVal) {
                password = onSavedVal;
              },
                  borderFocusColor: Colors.white,
                  prefixIconColor: Colors.white,
                  borderColor: Colors.white,
                  textColor: Colors.white,
                  hintColor: Colors.white.withOpacity(0.7),
                  borderRadius: 10,
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      color: Colors.white.withOpacity(0.7),
                      icon: Icon(hidePassword
                          ? Icons.visibility_off
                          : Icons.visibility))),
          ),
    Padding(
    padding: const EdgeInsets.only(top: 10),
    child:FormHelper.inputFieldWidget(
              context, const Icon(Icons.email), "email", "Email",
                  (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "Email can't be Empty.";
                }
                return null;
              }, (onSavedVal) {
            email = onSavedVal;
          },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10),
    ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child:FormHelper.inputFieldWidget(
                context, const Icon(Icons.phone), "mobile", "Mobile Number",
                    (onValidateVal) {
                  if (onValidateVal.isEmpty) {
                    return "Mobile Number can't be Empty.";
                  }
                  return null;
                }, (onSavedVal) {
              mobile = onSavedVal;
            },
                borderFocusColor: Colors.white,
                prefixIconColor: Colors.white,
                borderColor: Colors.white,
                textColor: Colors.white,
                hintColor: Colors.white.withOpacity(0.7),
                borderRadius: 10),
          ),
          SizedBox(
            height: 20,
          ),

          Center( child:
          FormHelper.submitButton("Register", () {
            if(validateAndSave()){
              setState(() {
                isAPICallProcess = true;
              });
              RegisterRequestModel model=RegisterRequestModel(userName: userName!,password: password!,email: email!,mobile: mobile!);
              APIService.register(model).then((response){
                setState(() {
                  isAPICallProcess = false;
                });
                if(response.data!=null){
                    FormHelper.showSimpleAlertDialog(context, Config.appName, "Registration Success.", "OK", (){
                      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                    });

                }
                else{
                  FormHelper.showSimpleAlertDialog(context, Config.appName,response.message, "OK", (){
                    Navigator.pop(context);
                  });
                }
              });
            }
          },
              btnColor: HexColor("#283B71"),
              borderRadius: 10,
              borderColor: Colors.white,
              txtColor: Colors.white),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool validateAndSave(){
    final form=globalFormKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }else {
      return false;
    }
  }
}
