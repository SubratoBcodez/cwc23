import 'package:cached_network_image/cached_network_image.dart';
import 'package:cwc23/bcodez/color.dart';
import 'package:cwc23/bcodez/route.dart';
import 'package:cwc23/bcodez/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Teams extends StatefulWidget {
  const Teams({super.key});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  List<dynamic> teams = [];
  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse("https://tzbd.000webhostapp.com/teams.json"));

    if (response.statusCode == 200) {
      setState(() {
        teams = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    initInterstitialAd();
  }

  late InterstitialAd interstitialAd;
  bool isIntAdLoaded = false;

  var initAdUnitId = "ca-app-pub-9362427100821170/3900578995";
  initInterstitialAd() {
    InterstitialAd.load(
        adUnitId: initAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          interstitialAd = ad;
          setState(() {
            isIntAdLoaded = true;
          });
        }, onAdFailedToLoad: (error) {
          interstitialAd.dispose();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteclr2,
      appBar: CustomAppBar(
        title: "TEAMS",
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.901,
              width: MediaQuery.of(context).size.width * 0.92,
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 20),
                  itemCount: teams.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Card(
                        color: AppColor.whiteclr,
                        child: ListTile(
                          leading: CircleAvatar(
                            child: CachedNetworkImage(
                              imageUrl: teams[index]['flag'],
                              width: 80.w,
                              height: 80.h,
                              fit: BoxFit.cover,
                            ),
                            radius: 40.r,
                          ),
                          title: cText(
                            teams[index]['title'],
                            AppColor.purpleclr,
                            20,
                            FontWeight.bold,
                          ),
                          subtitle: cText(
                            teams[index]['sub'],
                            AppColor.purpleclr,
                            14,
                            FontWeight.normal,
                          ),
                          trailing: Column(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Positioned(
                                    right: 3,
                                    bottom: -30,
                                    child: CachedNetworkImage(
                                      imageUrl: teams[index]['face'][0],
                                      // height: 80.h,
                                      width: 65.w,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -40,
                                    right: 0,
                                    child: CachedNetworkImage(
                                      imageUrl: teams[index]['kit'][0],
                                      width: 70.w,
                                      // height: 30.h,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            if (isIntAdLoaded) {
                              interstitialAd.show();
                            }
                            Get.toNamed(teamplayers, arguments: teams[index]);
                          },
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
