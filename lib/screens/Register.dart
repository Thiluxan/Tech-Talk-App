import 'package:tech_talk_app/screens/Login.dart';
import 'package:flutter/material.dart';
import '../../authentication/Authenticate.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
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
          padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Register Here",
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(borderSide: BorderSide())),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name Field Should not be Empty";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20.0,
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
                  height: 20.0,
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
                  height: 20.0,
                ),
                TextButton(
                  onPressed: () {
                    //if (_formKey.currentState!.validate()) {
                    register(emailController.text, passwordController.text,
                        nameController.text, context);
                    //}
                  },
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(100.0, 10.0, 100.0, 10.0),
                    child: Text("Register"),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.blue[800], primary: Colors.white),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Text("Already Have an account: "),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => Login()));
                      },
                      child: Text(
                        "Login",
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