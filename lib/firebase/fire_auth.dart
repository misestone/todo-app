import 'package:chat_material3/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static FirebaseAuth auth= FirebaseAuth. instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static User user = auth.currentUser!;
  static Future createUser() async {
    ChatUser chatUser = ChatUser(
        id: user.uid,
        name: user.displayName ?? "",
        email: user.email ?? "",
        about: "Hi i'm using goals app",
        image:'',
        createdAt : DateTime.now().toString(),
        lastActivated: DateTime.now().toString(),
        puchToken: '',
        online: false
    );
   await firebaseFirestore.collection('users').doc(user.uid).set(chatUser.toJson());
  }
}