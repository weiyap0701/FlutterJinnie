import 'package:jinnie/Model/UserModel.dart';

class WishComment {
  String userId;
  UserModel user;
  String message;

  WishComment(Map<String, dynamic> json) {
    this.userId = json["_id"] as String;
    this.user = UserModel(json["_user"]);
    this.message = json["message"] as String;
  }
}