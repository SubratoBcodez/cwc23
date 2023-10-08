import 'package:cwc23/bcodez/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../bcodez/color.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  List<dynamic> fixtures = [];
  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse("https://tzbd.000webhostapp.com/fixtures.json"));

    if (response.statusCode == 200) {
      setState(() {
        fixtures = json.decode(response.body);
        print(fixtures);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10, bottom: 80),
                itemCount: fixtures.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: GestureDetector(
                      onTap: () => Get.toNamed(match_preview,
                          arguments: fixtures[index]),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      fixtures[index]['flag1'],
                                      height: 60.h,
                                      width: 60.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    fixtures[index]['t1'],
                                    style: TextStyle(
                                        fontFamily: 'INDIA23',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "vs",
                                    style: TextStyle(
                                        fontFamily: 'INDIA23', fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    fixtures[index]['date'],
                                    style: TextStyle(
                                        fontFamily: 'INDIA23', fontSize: 15),
                                  ),
                                  Text(
                                    fixtures[index]['time'],
                                    style: TextStyle(
                                        fontFamily: 'INDIA23',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      fixtures[index]['stadium'],
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontFamily: 'INDIA23', fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      fixtures[index]['flag2'],
                                      height: 60.h,
                                      width: 60.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text(
                                    fixtures[index]['t2'],
                                    style: TextStyle(
                                      fontFamily: 'INDIA23',
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        height: 150.h,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: AppColor.whiteclr,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColor.purpleclr.withOpacity(0.33),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
