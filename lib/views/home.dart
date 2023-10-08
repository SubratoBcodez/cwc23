import 'dart:ffi';

import 'package:cwc23/bcodez/color.dart';
import 'package:cwc23/bcodez/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<ImageData>> fetchImageData() async {
    final response =
        await http.get(Uri.parse('https://tzbd.000webhostapp.com/slides.json'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ImageData.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  List Menu = [
    {
      'title': 'MATCHES',
      'img': 'assets/images/Screenshot 2023-08-18 123749.png',
      'route': 'fixture'
    },
    {'title': 'TEAMS', 'img': 'assets/images/WC-Squads.jpg', 'route': 'teams'},
    {
      'title': 'STEDIUMS',
      'img': 'assets/images/motera-stadium.jpg',
      'route': 'stedium'
    },
    {
      'title': 'STANDINGS',
      'img': 'assets/images/365968956_671663611663288_843522760291780127_n.jpg',
      'route': 'standings'
    },
    {
      'title': 'HIGHLIGHTS',
      'img': 'assets/images/BAN-vs-IND.jpg',
      'route': 'highlights'
    },
    {
      'title': 'LIVE ',
      'img': 'assets/images/Screenshot 2023-08-18 095702.png',
      'route': 'livetv'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteclr,
      body: SafeArea(
          child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.235,
                // height: 185.h,
                decoration: BoxDecoration(
                    color: AppColor.purpleclr,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.r),
                        bottomRight: Radius.circular(25.r))),
              ),
              Positioned(
                bottom: -60.sp,
                left: 0.sp,
                right: 0.sp,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.226,
                    width: double.maxFinite,
                    child: FutureBuilder<List<ImageData>>(
                      future: fetchImageData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Loading indicator while fetching data
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Text('No data available.');
                        } else {
                          return PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  snapshot.data![index].imageUrl,
                                  fit: BoxFit.fill,
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                    decoration: BoxDecoration(
                        color: AppColor.whiteclr,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: AppColor.purpleclr.withOpacity(0.53),
                              blurRadius: 30,
                              offset: Offset(0, 10))
                        ]),
                  ),
                ),
              ),
              Positioned(
                top: 10.sp,
                left: 15.sp,
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/cwc.png', height: 35.h),
                ),
              ),
              Positioned(
                  top: 10.sp,
                  right: 15.sp,
                  child: CircleAvatar(
                    radius: 30.r,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.notifications_active,
                      color: AppColor.whiteclr,
                      size: 25.sp,
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.083,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.558,
              width: MediaQuery.of(context).size.width * 0.85,
              child: GridView.builder(
                  padding:
                      EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.sp,
                      mainAxisSpacing: 10.sp,
                      childAspectRatio: 1.0),
                  itemCount: Menu.length,
                  itemBuilder: (BuildContext context, index) {
                    return Ink(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.pinkclr.withOpacity(0.15),
                                blurRadius: 20.r,
                                offset: Offset(1, 25))
                          ]),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Menu[index]['route']);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.13,
                              width: MediaQuery.of(context).size.width * 0.40,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Menu[index]['img']),
                                      fit: BoxFit.cover),
                                  color: AppColor.whiteclr,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.r),
                                      topLeft: Radius.circular(10.r))),
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.038,
                              width: MediaQuery.of(context).size.width * 0.40,
                              alignment: Alignment.center,
                              child: Text(
                                Menu[index]['title'],
                                style: TextStyle(
                                    color: AppColor.pinkclr,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    fontFamily: 'INDIA23'),
                              ),
                              decoration: BoxDecoration(
                                  color: AppColor.whiteclr,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.r),
                                      bottomRight: Radius.circular(10.r))),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      )),
    );
  }
}

class ImageData {
  final String imageUrl;

  ImageData({required this.imageUrl});

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      imageUrl: json['image_url'],
    );
  }
}
