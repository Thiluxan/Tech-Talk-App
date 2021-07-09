import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/postService.dart';
import '../authentication/Authenticate.dart';
import 'AddPost.dart';
import 'EditPost.dart';
import 'LikedPosts.dart';
import 'Post.dart';
import 'StarredPosts.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String userEmail = currentUser();

  @override
  void initState() {
    // TODO: implement initState
    //isAuthenticated(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tech Talk"),
          backgroundColor: Colors.blueGrey,
          actions: [
            new IconButton(onPressed: () {}, icon: new Icon(Icons.search)),
            new IconButton(
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => AddPost()));
                },
                icon: new Icon(Icons.add))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(''),
                accountEmail: Text(userEmail),
              ),
              ListTile(
                title: Text('Liked Posts'),
                leading: Icon(
                  Icons.thumb_up,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => LikedPosts()));
                },
              ),
              ListTile(
                  title: Text("Starred Posts"),
                  leading: Icon(
                    Icons.star,
                    color: Colors.amberAccent,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => StarredPosts()));}
                  ),
              Divider(
                height: 6.0,
                color: Colors.black,
              ),
              ListTile(
                title: Text("Sign out"),
                trailing: Icon(Icons.exit_to_app_outlined),
                onTap: () {
                  signout(context);
                },
              )
            ],
          ),
        ),
        body: StreamBuilder(
          stream: fetchPosts(),
          builder:
              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                        final DocumentSnapshot ds =
                        snapshot.data!.docs[index];
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
                                          builder: (context) => EditPost(
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