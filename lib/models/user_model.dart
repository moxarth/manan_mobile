class UserModel{
  String userId;
  String userName;
  String userEmail;
  String userProfilePicture;
  
  UserModel({
    this.userEmail,
    this.userId,
    this.userName,
    this.userProfilePicture
  });

  String get getUserId => this.userId;
  String get getUserEmail => this.userEmail;
  String get getUserName => this.userName;
  String get getUserProfilePic => this.userProfilePicture;

  Map toMap(UserModel userModel){
    var data = Map<String, dynamic>();
    data['name'] = userModel.userName;
    data['uid'] = userModel.userId;
    data['email'] = userModel.userEmail;
    data['profile_picture'] = userModel.userProfilePicture;
    return data;
  }

  UserModel fromMap(Map map){
    this.userId = map['uid'];
    this.userEmail = map['email'];
    this.userName = map['name'];
    this.userProfilePicture = map['profile_picture'];
  }

}