class BeanSignUp {
  bool status;
  String message;
  Data data;

  BeanSignUp({this.status, this.message, this.data});

  BeanSignUp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int usertype;
  String kitchenname;
  String email;
  int riderid;
  String cityid;
  String mobilenumber;
  String biketype;
  String youhavelicense;
  int userstatus;
  int status;
  String createddate;
  String modifieddate;
  String password;
  String userId;

  Data(
      {this.usertype,
        this.kitchenname,
        this.email,
        this.riderid,
        this.cityid,
        this.mobilenumber,
        this.biketype,
        this.youhavelicense,
        this.userstatus,
        this.status,
        this.createddate,
        this.modifieddate,
        this.password,
        this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    usertype = json['usertype'];
    kitchenname = json['kitchenname'];
    email = json['email'];
    riderid = json['riderid'];
    cityid = json['cityid'];
    mobilenumber = json['mobilenumber'];
    biketype = json['biketype'];
    youhavelicense = json['youhavelicense'];
    userstatus = json['userstatus'];
    status = json['status'];
    createddate = json['createddate'];
    modifieddate = json['modifieddate'];
    password = json['password'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usertype'] = this.usertype;
    data['kitchenname'] = this.kitchenname;
    data['email'] = this.email;
    data['riderid'] = this.riderid;
    data['cityid'] = this.cityid;
    data['mobilenumber'] = this.mobilenumber;
    data['biketype'] = this.biketype;
    data['youhavelicense'] = this.youhavelicense;
    data['userstatus'] = this.userstatus;
    data['status'] = this.status;
    data['createddate'] = this.createddate;
    data['modifieddate'] = this.modifieddate;
    data['password'] = this.password;
    data['user_id'] = this.userId;
    return data;
  }
}


