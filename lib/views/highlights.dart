import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cwc23/bcodez/widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bcodez/color.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HighLights extends StatefulWidget {
  const HighLights({super.key});

  @override
  State<HighLights> createState() => _HighLightsState();
}

class _HighLightsState extends State<HighLights> {
  List<dynamic> highlights = [];
  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse("https://tzbd.000webhostapp.com/highlights.json"));

    if (response.statusCode == 200) {
      setState(() {
        highlights = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    // initInterstitialAd();
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
      appBar: CustomAppBar(
        title: "HIGHLIGHTS",
        // Define your custom back action here
      ),
      backgroundColor: AppColor.whiteclr2,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.90,
            width: double.maxFinite,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                itemCount: highlights.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => setState(() {
                                if (isIntAdLoaded) {
                                  interstitialAd.show();
                                }
                                launchUrl(Uri.parse(highlights[index]['url']),
                                    mode: LaunchMode.inAppWebView);
                              }),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: AppColor.whiteclr,
                                    borderRadius: BorderRadius.circular(15)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: highlights[index]["img"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                child: IconButton(
                              onPressed: () => setState(() {
                                launchUrl(Uri.parse(highlights[index]['url']),
                                    mode: LaunchMode.inAppWebView);
                              }),
                              icon: Icon(
                                Icons.play_arrow_outlined,
                                size: 145.sp,
                                color: AppColor.pinkclr,
                              ),
                            ))
                          ],
                        ),
                        cText(highlights[index]["title"], AppColor.pinkclr, 18,
                            FontWeight.bold),
                        Divider(
                          thickness: 0.5,
                          color: AppColor.pinkclr,
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
