import 'package:cloud_firestore/cloud_firestore.dart';

addUser(String email, String name) {
  return FirebaseFirestore.instance
      .collection("users")
      .add({"name": name, "email": email});
}

fetchUser(String email) {
  return FirebaseFirestore.instance
      .collection("users")
      .where("email", isEqualTo: email)
      .get()
      .then((value) => {});
}