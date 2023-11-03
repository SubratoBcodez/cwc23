import 'package:flutter/material.dart';

import '../bcodez/color.dart';
import '../bcodez/widget.dart';

class PlayingXI extends StatefulWidget {
  final List<dynamic> playingxi;
  PlayingXI({required this.playingxi});

  @override
  State<PlayingXI> createState() => _PlayingXIState();
}

class _PlayingXIState extends State<PlayingXI> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> facea = (widget.playingxi[0]['face'] as List<dynamic>);
    final List<dynamic> kita = (widget.playingxi[0]['kit'] as List<dynamic>);
    final List<dynamic> playera =
        (widget.playingxi[0]['player'] as List<dynamic>);

    final List<dynamic> txt2a = (widget.playingxi[0]['txt2'] as List<dynamic>);
    final List<dynamic> faceb = (widget.playingxi[1]['face'] as List<dynamic>);
    final List<dynamic> kitb = (widget.playingxi[1]['kit'] as List<dynamic>);
    final List<dynamic> playerb =
        (widget.playingxi[1]['player'] as List<dynamic>);
    final List<dynamic> txt2b = (widget.playingxi[1]['txt2'] as List<dynamic>);

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
                      itemCount: facea.length, // Number of items in the grid
                      itemBuilder: (BuildContext context, int index) {
                        return tColumn(facea[index], kita[0], playera[index],
                            txt2a[index]);
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
                      itemCount: faceb.length, // Number of items in the grid
                      itemBuilder: (BuildContext context, int index) {
                        return tColumn(faceb[index], kitb[0], playerb[index],
                            txt2b[index]);
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
