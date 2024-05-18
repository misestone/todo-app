import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireData{
  final FirebaseFirestore firestore =FirebaseFirestore.instance;
  final String myUid =FirebaseAuth.instance.currentUser!.uid;

  Future editeProfile(String name , String about) async{
    await firestore
        .collection('users')
        .doc(myUid)
        .update({
      'name': name,
      'about' : about
    });

}
}