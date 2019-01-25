import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

//non-library
import 'package:jinnie/Utils/Constants.dart';

//Model
import 'package:jinnie/Model/UserModel.dart';
import 'package:jinnie/Model/WishModel.dart';
import 'package:jinnie/Model/WishComment.dart';

class LoginRegApiHandler {

  static Future<UserModel> loginUser(String email, String password) async {
    var url = Constants.serverUrl + "login";

    final response = await http.post(url, body:{
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      final accessToken = response.headers["access-token"];
      // print(accessToken);
      final map = json.decode(response.body);
      final result = map["return"];
      final userModel = UserModel(result["user"]);
      return userModel;
    }
    else {
      return null;
    }
  }

  static Future<UserModel> registerUser(String email, String password, String firstName, String lastName) async {
    var url = Constants.serverUrl + "register";

    final response = await http.post(url, body: {
      "email": email,
      "password": password,
      "first_name": firstName,
      "last_name": lastName
    });

    if (response.statusCode == 200) {
      final accessToken = response.headers["access-token"];
      
      final map = json.decode(response.body);
      final result = map["return"];
      final userModel = UserModel(result["user"]);
      return userModel;
    }
    else {
      return null;
    }
  }

}

class WishApiHandler {
  static Future<List<WishModel>> getWishList(int skip) async {
    final url = Constants.serverUrl + "requests?limit=5&skip=" + skip.toString();

    final response = await http.get(url, headers: {
      "access-token": Constants.tempAccessToken,
      "user-id": Constants.tempUserId
    });

    if (response.statusCode == 200) {
      List<WishModel> wishArray = [];
      final map = json.decode(response.body);
      final result = map["return"];
      final requests = result["requests"];
      
      requests.forEach((wish) {
        final tempWish = WishModel(wish);
        wishArray.add(tempWish);
      });

      return wishArray;
    }
    else {
      return null;
    }

  }

  static Future<List<WishComment>> getWishComment(String wishId) async {
    
    final url = Constants.serverUrl + "request/" + wishId;
    final response = await http.get(url, headers: {
      "access-token": Constants.tempAccessToken,
      "user-id": Constants.tempUserId
    });

    if (response.statusCode == 200) {
      List<WishComment> commentArray = [];
      final map = json.decode(response.body);
      final result = map["return"];
      final request = result["request"];
      final comments = request["comments"];
      comments.forEach((comment){
        commentArray.add(WishComment(comment));
      });

      return commentArray;
    }
    else {
      return null;
    }

  }

}
