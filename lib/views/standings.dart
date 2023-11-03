import 'package:cached_network_image/cached_network_image.dart';
import 'package:cwc23/bcodez/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bcodez/widget.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Standings extends StatefulWidget {
  const Standings({super.key});

  @override
  State<Standings> createState() => _StandingsState();
}

class _StandingsState extends State<Standings> {
  List<dynamic> most = [];
  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse("https://tzbd.000webhostapp.com/most.json"));

    if (response.statusCode == 200) {
      setState(() {
        most = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<dynamic> standing = [];
  Future<void> fetchData2() async {
    final response = await http
        .get(Uri.parse("https://tzbd.000webhostapp.com/standings.json"));

    if (response.statusCode == 200) {
      setState(() {
        standing = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchData2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "STANDINGS"),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Container(
                height: 45.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: AppColor.pinkclr,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundColor: AppColor.pinkclr,
                    ),
                    SizedBox(
                      width: 40.w,
                    ),
                    sText(
                      "TEAM",
                    ),
                    SizedBox(
                      width: 21.w,
                    ),
                    sText(
                      "M",
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    sText(
                      "W",
                    ),
                    SizedBox(
                      width: 19.w,
                    ),
                    sText(
                      "L",
                    ),
                    SizedBox(
                      width: 35.w,
                    ),
                    sText(
                      "NRR",
                    ),
                    SizedBox(
                      width: 40.w,
                    ),
                    sText(
                      "P",
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.71,
                width: MediaQuery.of(context).size.width * 0.92,
                child: ListView.builder(
                    itemCount: standing.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 28.r,
                                backgroundColor: Colors.transparent,
                                child: CachedNetworkImage(
                                  imageUrl: standing[index]['flag'],
                                  height: 50.h,
                                  width: 50.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              sText(
                                standing[index]['team'],
                              ),
                              sText(
                                standing[index]['m'],
                              ),
                              sText(
                                standing[index]['w'],
                              ),
                              sText(
                                standing[index]['l'],
                              ),
                              sText(
                                standing[index]['nrr'],
                              ),
                              sText(
                                standing[index]['p'],
                              ),
                            ],
                          ),
                          Divider(
                            height: 1,
                          )
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width * 0.92,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: most
                      .length, // Replace with the actual length of your data list
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.10,
                        margin: EdgeInsets.symmetric(
                            vertical: 10), // Optional margin between items
                        decoration: BoxDecoration(
                          color: AppColor.pinkclr,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: cColumn(
                          most[index]['title'],
                          most[index]['most'],
                          most[index]['player'],
                          most[index]['face'],
                          most[index]['kit'],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
