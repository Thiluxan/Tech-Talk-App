import 'package:tech_talk_app/screens/Register.dart';
import 'package:flutter/material.dart';
import '../authentication/Authenticate.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tech Talk"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        padding: EdgeInsets.all(11.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Login Here",
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(borderSide: BorderSide())),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email Field Should not be Empty";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(borderSide: BorderSide())),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password Field Should not be Empty";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 40.0,
                ),
                TextButton(
                  onPressed: () {
                    //if (_formKey.currentState.validate()) {
                    login(emailController.text.toString(),
                        passwordController.text.toString(), context);
                    //}
                  },
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(100.0, 10.0, 100.0, 10.0),
                    child: Text("Login"),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[800], primary: Colors.white),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: [
                    Text("Don't Have an account: "),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}