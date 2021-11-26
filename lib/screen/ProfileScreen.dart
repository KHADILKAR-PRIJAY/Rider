import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:rider_app/model/BeanGetProfile.dart';
import 'package:rider_app/network/ApiProvider.dart';
import 'package:rider_app/res.dart';
import 'package:rider_app/screen/MyDrawer.dart';
import 'package:rider_app/utils/Constents.dart';
import 'package:rider_app/utils/HttpException.dart';
import 'package:rider_app/utils/Utils.dart';
import 'package:rider_app/utils/progress_dialog.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  var isSelected = 1;
  Future _future;
  var name="";
  var rating=0.0;
  var number="";
  var totalEarning="";
  var address="";
  ProgressDialog progressDialog;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _future = getProfile(context);



    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog=ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);


    return Scaffold(
        drawer: MyDrawers(),
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  color: AppConstant.lightGreen,
                  height: 150,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _scaffoldKey.currentState.openDrawer();
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 16,top: 30),
                    child: Image.asset(
                      Res.ic_menu,
                      width: 30,
                      height: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: 80),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Center(
                        child: Image.asset(Res.ic_user,width: 80,height: 80,),
                      ),
                    ),
                  ),
                )
              ],
            ),

            Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(name,style: TextStyle(fontFamily: AppConstant.fontBold,fontSize: 18),)),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: RatingBarIndicator(
                rating: rating,
                itemCount: 5,
                itemSize: 20.0,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(number,style: TextStyle(fontFamily: AppConstant.fontRegular,fontSize: 14),)),

            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Image.asset(Res.ic_location,width: 15,height: 15,)),
           Container(
             width: 200,
             child:      Padding(
                 padding: EdgeInsets.only(top: 10,left: 10),
                 child: Text(address,style: TextStyle(fontFamily: AppConstant.fontRegular,fontSize: 14),)),

           )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 20,right: 20,top: 16),
              decoration: BoxDecoration(
                color: Color(0xffF3F6FA),
                borderRadius: BorderRadius.circular(13)
              ),
              height: 100,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          child: Image.asset(Res.ic_wallet,width: 40,height: 40,),
                        padding: EdgeInsets.only(left: 16,top: 16),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10,right: 16),
                          child: Text("Total Earning",style: TextStyle(fontFamily: AppConstant.fontRegular,fontSize: 14),)),


                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child:  Padding(
                            padding: EdgeInsets.only(top: 5,left: 16),
                            child: Text("My wallet",style: TextStyle(fontFamily: AppConstant.fontRegular,fontSize: 14),)),

                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10,right: 16),
                          child: Text(AppConstant.rupee+totalEarning,style: TextStyle(fontFamily: AppConstant.fontRegular,fontSize: 20,color: AppConstant.lightGreen),)),


                    ],
                  ),

                ],
              ),
            ),
            Center(
              child: Container(
                height: 50,
                margin: EdgeInsets.only(right: 16,top: 16,left: 16),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text("+ Add Account Details",style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: AppConstant.fontBold),),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 50,
                margin: EdgeInsets.only(right: 16,top: 16,left: 16),
                decoration: BoxDecoration(
                    color: Color(0xffF3F6FA),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text("Agreement & Policy",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: AppConstant.fontBold),),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 50,
                margin: EdgeInsets.only(right: 16,top: 16,left: 16),
                decoration: BoxDecoration(
                    color: Color(0xffF3F6FA),
                    borderRadius: BorderRadius.circular(10)
                ),

                child:Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text("Help",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: AppConstant.fontBold),),
                      ),
                    ),
                    InkWell(
                        onTap: (){

                          Navigator.pushNamed(context, '/chat');
    },
                        child: Image.asset(Res.ic_chat,width: 50,height: 50,))

                  ],
                )
              ),
            ),
          ],
    )
    );
  }

  Future getProfile(BuildContext context) async {

    progressDialog.show();
    try {
      var user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "user_id": "70",
        "token": "123456789"
      });
      GetProfile bean = await ApiProvider().getProfile(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          name=bean.data[0].username;
          number=bean.data[0].mobilenumber;
          address=bean.data[0].address;
          totalEarning=bean.data[0].totalEarning;
          rating = double.parse(bean.data[0].avgRattings.toString());

        });

        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }
}
