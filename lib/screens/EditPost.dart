import 'package:flutter/material.dart';
import '../services/postService.dart';
import 'Home.dart';

class EditPost extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  EditPost(this.id, this.title, this.description);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.title;
    descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
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
                updatePost(widget.id, widget.title, widget.description)
                    .then((value) => Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => Home())))
                    .catchError((onError) => {
                          print("Error occurred"),
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Unable to add post")))
                        });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(100.0, 10.0, 100.0, 10.0),
                child: Text("Update Post"),
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
