import 'package:jinnie/Model/UserModel.dart';

class WishModel {
  String wishId;
  String message;
  UserModel user;
  List<WishImage> images;
  String itemName;
  String destinationName;
  int minPrice;
  int maxPrice;
  int totalOffer;
  int totalComment;

  WishModel(Map<String, dynamic> json) {
    this.wishId = json["_id"] as String;
    this.message = json["message"] as String;
    this.user = UserModel(json["_user"]);
    this.itemName = json["item_name"] as String;
    this.destinationName = json["destination_name"] as String;
    this.minPrice = json["min_price"] as int;
    this.maxPrice = json["max_price"] as int;
    this.totalOffer = json["total_offer"] as int;
    this.totalComment = json["total_comment"] as int;
    // selected_datetime
    images = [];
    final tempImages = json["images"];
    tempImages.forEach((image) {
      final wishImage = WishImage(image);
      images.add(wishImage);
    });
  }
  // WishModel({this.wishId, this.message});

  // factory WishModel.fromJson(Map<String, dynamic> json) {
  //   return WishModel(
  //     wishId: json["_id"] as String,
  //     message: json["message"] as String
  //   );
  // }
}

class WishImage {
  String imageId;
  String fileName;
  String mimetype;
  String createdDatetime;
  String imageUrl;

  WishImage(Map<String, dynamic> json) {
    this.imageId = json["_id"];
    this.fileName = json["file_name"];
    this.mimetype = json["mimetype"];
    this.createdDatetime = json["created_datetime"];
    this.imageUrl = json["url"];
  }

}