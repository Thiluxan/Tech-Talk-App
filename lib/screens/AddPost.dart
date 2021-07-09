import 'package:tech_talk_app/authentication/Authenticate.dart';
import 'package:tech_talk_app/screens/Home.dart';
import 'package:flutter/material.dart';
import '../services/postService.dart';
import '../services/UserService.dart';

class AddPost extends StatefulWidget {
  AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String userEmail = currentUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Post"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(borderSide: BorderSide())),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(borderSide: BorderSide())),
              maxLines: 10,
            ),
            SizedBox(
              height: 10.0,
            ),
            TextButton(
              onPressed: () {
                addPost(titleController.text, descriptionController.text)
                    .then((value) => {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => Home()))
                })
                    .catchError((onError) => {
                  print("Error: $onError"),
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Unable to add post")))
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(100.0, 10.0, 100.0, 10.0),
                child: Text("Add Post"),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Colors.blue[800], primary: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}