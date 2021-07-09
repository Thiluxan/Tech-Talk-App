import 'package:cloud_firestore/cloud_firestore.dart';
import '../authentication/Authenticate.dart';

final postInstance = FirebaseFirestore.instance.collection("posts");
final String userEmail = currentUser().toString();

deletePost(String id) {
  return postInstance.doc(id).delete();
}

addPost(String title, String description) {
  return postInstance.add(
      {"title": title, "description": description, "likes": [], "stars": [],"author":userEmail});
}

fetchPosts() {
  return postInstance.snapshots();
}

fetchLikedPosts(email) {
  return postInstance.where("likes", arrayContains: email).snapshots();
}

fetchStarredPosts(email) {
  return postInstance.where("stars", arrayContains: email).snapshots();
}

updatePost(id, title, description) {
  return postInstance
      .doc(id)
      .update({"title": title, "description": description});
}

updateLikes(id, likes) {
  return postInstance.doc(id).update({"likes": likes});
}

updateStars(id, stars) {
  return postInstance.doc(id).update({'stars': stars});
}