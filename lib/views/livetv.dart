import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cwc23/bcodez/widget.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bcodez/color.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LiveTV extends StatefulWidget {
  const LiveTV({super.key});

  @override
  State<LiveTV> createState() => _LiveTVState();
}

class _LiveTVState extends State<LiveTV> {
  List<dynamic> livetv = [];
  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse("https://tzbd.000webhostapp.com/livetv.json"));

    if (response.statusCode == 200) {
      setState(() {
        livetv = json.decode(response.body);
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColor.purpleclr,
          ),
        ),
        title: Text(
          "LIVE WORLD CUP",
          style: TextStyle(color: AppColor.whiteclr),
        ),
        centerTitle: true,
        backgroundColor: AppColor.purpleclr,
      ),
      backgroundColor: AppColor.whiteclr2,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
              width: double.maxFinite,
              child: Container(
                height: double.maxFinite,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(3)),
                child: Text(
                  "Live Tv Link is Provided by Some Third Party FTP Server",
                  style: TextStyle(color: AppColor.whiteclr),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.77,
            width: double.maxFinite,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                itemCount: livetv.length,
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
                                launchUrl(Uri.parse(livetv[index]['url']),
                                    mode: LaunchMode.inAppWebView);
                              }),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.23,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: AppColor.whiteclr,
                                    borderRadius: BorderRadius.circular(15)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: livetv[index]["img"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                child: IconButton(
                              onPressed: () => setState(() {
                                if (isIntAdLoaded) {
                                  interstitialAd.show();
                                }
                                launchUrl(Uri.parse(livetv[index]['url']),
                                    mode: LaunchMode.inAppWebView);
                              }),
                              icon: Icon(
                                Icons.play_arrow_outlined,
                                size: 145.sp,
                                color: AppColor.purpleclr,
                              ),
                            ))
                          ],
                        ),
                        cText(livetv[index]["title"], AppColor.purpleclr, 18,
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
