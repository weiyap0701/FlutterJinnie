class UserModel {
  String userId;
  String email;
  String firstName;
  String lastName;
  String alias;
  int credit;
  String userProfileImageName;

  UserModel(Map<String, dynamic> json) {
    this.userId = json["_id"];
    this.email = json["email"];
    this.firstName = json["first_name"];
    this.lastName = json["last_name"];
    this.alias = json["alias"];
    this.userProfileImageName = json["profile_picture_url"];
  }


}
