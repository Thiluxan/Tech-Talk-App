import 'package:tech_talk_app/authentication/Authenticate.dart';
import 'package:tech_talk_app/services/postService.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final String author;
  final List<dynamic> likes;
  final List<dynamic> stars;

  Post(this.id, this.title, this.description, this.author, this.likes,
      this.stars);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final String userEmail = currentUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.title}',
          maxLines: 4,
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text('${widget.author[0]}'),
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  '${widget.author}',
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  width: 20.0,
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(Icons.thumb_up_alt_outlined),
                      Text((widget.likes.length).toString())
                    ],
                  ),
                  onTap: () {
                    if (widget.likes.contains(userEmail)) {
                      widget.likes.remove(userEmail);
                    } else {
                      widget.likes.add(userEmail);
                    }
                    updateLikes(widget.id, widget.likes);
                    setState(() {});
                  },
                ),
                SizedBox(
                  width: 20.0,
                ),
                InkWell(
                  child: Row(
                    children: [
                      Icon(Icons.star_outline),
                      Text(widget.stars.length.toString())
                    ],
                  ),
                  onTap: () {
                    if (widget.stars.contains(userEmail)) {
                      widget.stars.remove(userEmail);
                    } else {
                      widget.stars.add(userEmail);
                    }
                    updateStars(widget.id, widget.stars);
                    setState(() {});
                  },
                )
              ],
            ),
            Divider(
              height: 6.0,
              color: Colors.blueGrey[200],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Text('${widget.description}')),
              ],
            )
          ],
        ),
      ),
    );
  }
}