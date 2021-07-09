import 'package:tech_talk_app/authentication/Authenticate.dart';
import 'package:tech_talk_app/services/postService.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './Post.dart';
import './EditPost.dart';

class StarredPosts extends StatefulWidget {
  StarredPosts({Key? key}) : super(key: key);

  @override
  _StarredPostsState createState() => _StarredPostsState();
}

class _StarredPostsState extends State<StarredPosts> {
  final String userEmail = currentUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tech Talk"),
          backgroundColor: Colors.blueGrey,
        ),
        body: StreamBuilder(
          stream: fetchStarredPosts(userEmail),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(180.0, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                ),
              );
            }

            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot ds = snapshot.data!.docs[index];
                    return new Card(
                      elevation: 0.0,
                      margin: EdgeInsets.all(10.0),
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  child: Text(ds['title'],
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.blueAccent),
                                      maxLines: 1),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => Post(
                                                ds.id,
                                                ds['title'],
                                                ds['description'],
                                                ds['author'],
                                                ds['likes'],
                                                ds['stars'])));
                                  },
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: ds['author'] != userEmail
                                      ? null
                                      : () {
                                          deletePost(ds.id);
                                          setState(() {});
                                        },
                                  child: Text(
                                    "Delete",
                                  ),
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.redAccent,
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                TextButton(
                                  onPressed: ds['author'] != userEmail
                                      ? null
                                      : () {
                                          Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditPost(
                                                          ds.id,
                                                          ds['title'],
                                                          ds['description'])));
                                        },
                                  child: Text(
                                    "Edit",
                                  ),
                                  style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Colors.greenAccent),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
