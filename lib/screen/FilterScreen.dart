import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:rider_app/model/GetOrdeHistory.dart';
import 'package:rider_app/network/ApiProvider.dart';
import 'package:rider_app/screen/OrderHistoryscreen.dart';
import 'package:rider_app/utils/Constents.dart';
import 'package:rider_app/utils/Utils.dart';
import 'package:rider_app/utils/progress_dialog.dart';

import '../res.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var startDate = "";
  var endDate = "";
  var filter = "filter";
  ProgressDialog progressDialog;
  var status="";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog=ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Image.asset(
                          Res.ic_back,
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 16, top: 16),
                      child: Text(
                        "Filter",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ],
                ),
                height: 70,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: InkWell(
                        onTap: () async {
                          var result = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2022));
                          print('$result');
                        },
                        child: Text(
                          "Date From",
                          style: TextStyle(
                              color: AppConstant.appColor,
                              fontSize: 18,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, right: 80),
                      child: Text(
                        "Date to",
                        style: TextStyle(
                            color: AppConstant.appColor,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: GestureDetector(
                          onTap: () async {
                            var result = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2022));
                            print('$result');
                            setState(() {

                              startDate = result.year.toString() + "-" + result.month.toString() + "-" + result.day.toString();
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(startDate == "" ? "Start Date" : startDate),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.grey,
                              )
                            ],
                          )

                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        var result = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2022));
                        print('$result');
                        setState(() {
                          endDate  = result.year.toString() + "-" + result.month.toString() + "-" + result.day.toString();
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.only(left: 10, top: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(endDate == "" ? "End Date" : endDate),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.grey,
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, left: 16),
                      child: Text(
                        "Status",
                        style: TextStyle(
                            color: AppConstant.appColor,
                            fontSize: 18,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10, top: 26, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () {
                                bottomsheetStatus(context);
                              },
                              child: Text(status==""?"Status":status, style: TextStyle(fontFamily: AppConstant.fontRegular, fontSize: 14),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.grey,
                          )
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only( right: 16),
                      child: Image.asset(
                        Res.ic_down_arrow,
                        width: 15,
                        height: 15,
                      )),
                ],
              ),
              SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: (){

                  validation();
                },
                child: Container(
                  height: 55,
                  margin:
                      EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff7ED39C),
                          Color(0xff7ED39C),
                          Color(0xff7ED39C),
                          Color(0xff089E90)
                        ],
                        begin: Alignment.bottomLeft,
                        stops: [0, 0, 0, 1],

                      ),
                      color: AppConstant.appColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "APPLY",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: AppConstant.fontBold,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void bottomsheetStatus(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          // <-- for border radius
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setModelState) {
            return Container(
              height: 210,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Status",
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: AppConstant.fontBold,
                          fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                        status="pending";
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "pending",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                        status="Failed";
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Failed",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                        status="Confirm";
                      });

                    },
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                          fontSize: 15,
                            color: Colors.black,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        });
  }

  void validation() {
      if(startDate.isEmpty){
        Utils.showToast("Please add start date");
      }else if(endDate.isEmpty){
        Utils.showToast("Please add end date");
      }else if(status.isEmpty){
        Utils.showToast("Please add status");
      }else{
        applyFilterOrders();
      }

  }

  Future<GetOrderHistory> applyFilterOrders() async {
    progressDialog.show();
    try {
      var user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "userid": "70",
        "token": "123456789",
        "date_from": startDate,
        "date_to": endDate,
        "status": status,
      });
      print("statussssss"+startDate.toString()+endDate.toString()+status.toString());
      GetOrderHistory bean = await ApiProvider().getOrderHistory(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast(bean.message);
        setState(() {
          Navigator.pop(context,true);
          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistoryscreen(startDate,endDate,status,filter)),);

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
