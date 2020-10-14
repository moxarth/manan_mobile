import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manan_mobile/models/user_model.dart';

class FireStoreMethods{
  final FirebaseFirestore root = FirebaseFirestore.instance;

  Future<dynamic> addUserToFireStore(UserModel user){
    UserModel userModel = UserModel(
      userId: user.getUserId,
      userEmail: user.getUserEmail,
      userName: user.getUserName ?? "Name",
      userProfilePicture: user.getUserProfilePic ?? "hello"
    );
    return root.collection("user").doc(user.getUserId).set(userModel.toMap(userModel));
  }

}