import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bcodez/color.dart';
import '../bcodez/widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PlayingXI extends StatefulWidget {
  const PlayingXI({super.key});

  @override
  State<PlayingXI> createState() => _PlayingXIState();
}

class _PlayingXIState extends State<PlayingXI> {
  List<dynamic> playxi1 = [];
  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse("https://tzbd.000webhostapp.com/playxi1.json"));

    if (response.statusCode == 200) {
      setState(() {
        playxi1 = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<dynamic> playxi2 = [];
  Future<void> fetchData2() async {
    final response = await http
        .get(Uri.parse("https://tzbd.000webhostapp.com/playxi2.json"));

    if (response.statusCode == 200) {
      setState(() {
        playxi2 = json.decode(response.body);
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.whiteclr2,
        body: SingleChildScrollView(
          child: Column(
            children: [
              TabBar(tabs: [
                Tab(
                    child: cText(
                  "TEAM 1",
                  AppColor.purpleclr,
                  12,
                  FontWeight.bold,
                  al: TextAlign.center,
                )),
                Tab(
                    child: cText(
                  "TEAM 2",
                  AppColor.purpleclr,
                  12,
                  FontWeight.bold,
                  al: TextAlign.center,
                )),
              ]),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: TabBarView(
                  children: [
                    GridView.builder(
                      padding:
                          EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Number of columns
                        crossAxisSpacing: 10.0, // Spacing between columns
                        mainAxisSpacing: 35.0, // Spacing between rows
                      ),
                      itemCount: playxi1.length, // Number of items in the grid
                      itemBuilder: (BuildContext context, int index) {
                        // final facex = teams[0]['face'] as List<String>;
                        // final kitx = teams[0]['kit'] as List<String>;
                        // final playerx = teams[0]['player'] as List<String>;
                        // final txt2x = teams[0]['txt2'] as List<String>;

                        // Create your grid item here, for example:

                        return tColumn(
                            playxi1[index]["face"],
                            playxi1[index]["kit"],
                            playxi1[index]["player"],
                            playxi1[index]["txt2"]);
                      },
                    ),
                    GridView.builder(
                      padding:
                          EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Number of columns
                        crossAxisSpacing: 10.0, // Spacing between columns
                        mainAxisSpacing: 35.0, // Spacing between rows
                      ),
                      itemCount: playxi2.length, // Number of items in the grid
                      itemBuilder: (BuildContext context, int index) {
                        // final facey = teams[1]['face'] as List<String>;
                        // final kity = teams[1]['kit'] as List<String>;
                        // final playery = teams[1]['player'] as List<String>;
                        // final txt2y = teams[1]['txt2'] as List<String>;
                        // Create your grid item here, for example:
                        return tColumn(
                            playxi2[index]["face"],
                            playxi2[index]["kit"],
                            playxi2[index]["player"],
                            playxi2[index]["txt2"]);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
