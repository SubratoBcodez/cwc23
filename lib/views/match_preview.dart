import 'package:cached_network_image/cached_network_image.dart';
import 'package:cwc23/bcodez/color.dart';

import 'package:cwc23/bcodez/widget.dart';
import 'package:cwc23/views/playing_xi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MatchPreview extends StatefulWidget {
  var fixtures;
  MatchPreview({required this.fixtures});

  @override
  State<MatchPreview> createState() => _MatchPreviewState();
}

class _MatchPreviewState extends State<MatchPreview> {
  late Timer _timer;
  DateTime _targetTime =
      DateTime(2023, 10, 0, 0, 0, 0); // Initialize with default values
  late Duration _remainingTime = Duration(seconds: 0);

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse("https://tzbd.000webhostapp.com/matchpre.json"));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON data
      final List<dynamic> dataList = json.decode(response.body);

      // Assuming the JSON data is an array, you may want to access an element (e.g., the first element) within the list.
      if (dataList.isNotEmpty) {
        setState(() {
          // Update the target time based on JSON data
          _targetTime = DateTime(
              2023,
              int.parse(widget.fixtures["mn"]),
              int.parse(widget.fixtures["d"]),
              int.parse(widget.fixtures["h"]),
              int.parse(widget.fixtures["m"]),
              59);
          // Start the countdown timer
          startCountdown();
        });
      } else {
        // Handle the case where the JSON array is empty
      }
    } else {
      // If the server returns an error response, throw an exception
      throw Exception('Failed to load data');
    }
  }

  Duration _getTimeRemaining() {
    final now = DateTime.now();
    final difference = _targetTime.isAfter(now)
        ? _targetTime.difference(now)
        : Duration(seconds: 0);
    return difference;
  }

  void startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final remainingTime = _getTimeRemaining();
      if (remainingTime.inSeconds > 0) {
        setState(() {
          _remainingTime = remainingTime;
        });
      } else {
        // Countdown is complete, you can perform any action here.
        _timer.cancel(); // Stop the timer
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
// Fetch data when the widget is initialized
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final days = _remainingTime?.inDays.toString() ?? "0";
    final hours = ((_remainingTime?.inHours ?? 0) % 24).toString();
    final minutes = ((_remainingTime?.inMinutes ?? 0) % 60).toString();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          title: "MATCH PREVIEW",
          // Define your custom back action here
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.57,
                width: double.maxFinite,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.purpleclr,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              cTextSpan(widget.fixtures["stadium"],
                                  AppColor.whiteclr, 15, FontWeight.normal),
                            ])),
                        Divider(
                          height: 30,
                          color: Colors.transparent,
                        ),
                        cText(
                          '${widget.fixtures["tx"]} V ${widget.fixtures["ty"]}',
                          AppColor.whiteclr,
                          20,
                          FontWeight.bold,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl: widget.fixtures["flag1"],
                                  height: 70.h,
                                  width: 70.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                children: [
                                  cText(
                                    widget.fixtures["date"],
                                    AppColor.whiteclr,
                                    12,
                                    FontWeight.normal,
                                  ),
                                  cText(
                                    widget.fixtures["time"],
                                    AppColor.whiteclr,
                                    22,
                                    FontWeight.bold,
                                  ),
                                ],
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImage(
                                  imageUrl: widget.fixtures["flag2"],
                                  height: 70.h,
                                  width: 70.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              cTextSpan("MATCH STARTS IN...", AppColor.pinkclr,
                                  15, FontWeight.bold),
                            ])),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 40.h,
                                        width: 70.w,
                                        decoration: BoxDecoration(
                                            color: AppColor.pinkclr),
                                        child: cText(
                                          days.padLeft(2, '0'),
                                          AppColor.whiteclr,
                                          30,
                                          FontWeight.bold,
                                          al: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  cText("DAYS", AppColor.whiteclr, 16,
                                      FontWeight.bold)
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 40.h,
                                        width: 70.w,
                                        decoration: BoxDecoration(
                                            color: AppColor.pinkclr),
                                        child: cText(
                                          hours.padLeft(2, '0'),
                                          AppColor.whiteclr,
                                          30,
                                          FontWeight.bold,
                                          al: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  cText("HRS", AppColor.whiteclr, 16,
                                      FontWeight.bold)
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 40.h,
                                        width: 70.w,
                                        decoration: BoxDecoration(
                                            color: AppColor.pinkclr),
                                        child: cText(
                                          minutes.padLeft(2, '0'),
                                          AppColor.whiteclr,
                                          30,
                                          FontWeight.bold,
                                          al: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  cText("MINS", AppColor.whiteclr, 16,
                                      FontWeight.bold)
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.7,
                                indent: 50,
                                color: AppColor.whiteclr2,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 13),
                              height: 40.h,
                              width: 130,
                              decoration: BoxDecoration(
                                  color: AppColor.purpleclr,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.whiteclr,
                                      blurStyle: BlurStyle.solid,
                                    )
                                  ]),
                              child: cText(
                                "VANUE DETAILS",
                                AppColor.whiteclr,
                                12,
                                FontWeight.bold,
                                al: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.7,
                                endIndent: 50,
                                color: AppColor.whiteclr2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          cTextSpan("Match : ", AppColor.whiteclr, 14,
                              FontWeight.normal),
                          cTextSpan(widget.fixtures["match"], AppColor.whiteclr,
                              14, FontWeight.bold)
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          cTextSpan("Event : ", AppColor.whiteclr, 14,
                              FontWeight.normal),
                          cTextSpan("ICC Men's World Cup 2023",
                              AppColor.whiteclr, 14, FontWeight.bold)
                        ])),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              cTextSpan("Venue : ", AppColor.whiteclr, 14,
                                  FontWeight.normal),
                              cTextSpan(widget.fixtures["stadium"],
                                  AppColor.whiteclr, 14, FontWeight.bold)
                            ])),
                      ],
                    ),
                  ),
                ),
              ),
              TabBar(tabs: [
                Tab(
                    child: cText(
                  "MATCH INFO",
                  AppColor.purpleclr,
                  12,
                  FontWeight.bold,
                  al: TextAlign.center,
                )),
                Tab(
                    child: cText(
                  "PLAYING XI",
                  AppColor.purpleclr,
                  12,
                  FontWeight.bold,
                  al: TextAlign.center,
                )),
              ]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.847,
                width: double.maxFinite,
                child: TabBarView(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.847,
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        cText(
                            '${widget.fixtures["tx"]} V ${widget.fixtures["ty"]}',
                            AppColor.purpleclr,
                            20,
                            FontWeight.bold,
                            al: TextAlign.left),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                cTextSpan("Match state : ", AppColor.purpleclr,
                                    17, FontWeight.bold),
                                cTextSpan(widget.fixtures["state"],
                                    AppColor.pinkclr, 17, FontWeight.normal)
                              ])),
                              SizedBox(
                                height: 5,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                cTextSpan("Match No : ", AppColor.purpleclr, 17,
                                    FontWeight.bold),
                                cTextSpan(widget.fixtures["match"],
                                    AppColor.pinkclr, 17, FontWeight.normal)
                              ])),
                              SizedBox(
                                height: 5,
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                cTextSpan("Stadium : ", AppColor.purpleclr, 17,
                                    FontWeight.bold),
                                cTextSpan(widget.fixtures["stadium"],
                                    AppColor.pinkclr, 17, FontWeight.normal)
                              ])),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 2,
                                indent: 30,
                                endIndent: 30,
                                color: AppColor.whiteclr2,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.fixtures["flag1"],
                                      height: 70.h,
                                      width: 70.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  cText(
                                    widget.fixtures["rank2"],
                                    AppColor.pinkclr,
                                    20,
                                    FontWeight.bold,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  cText(
                                    "TEAM\n COMPARISON",
                                    AppColor.purpleclr,
                                    20,
                                    FontWeight.normal,
                                    al: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  cText(
                                    "ODI RANK",
                                    AppColor.purpleclr,
                                    18,
                                    FontWeight.bold,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.fixtures["flag2"],
                                      height: 70.h,
                                      width: 70.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  cText(
                                    widget.fixtures["rank1"],
                                    AppColor.pinkclr,
                                    20,
                                    FontWeight.bold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  PlayingXI(
                    playingxi: widget.fixtures["playxi"],
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
