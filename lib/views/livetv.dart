import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cwc23/bcodez/widget.dart';
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.80,
            width: double.maxFinite,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                padding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
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
                                  child: Image.network(
                                    livetv[index]["img"],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                child: IconButton(
                              onPressed: () => setState(() {
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
