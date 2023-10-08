import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bcodez/color.dart';
import '../bcodez/widget.dart';

class TeamPlayers extends StatefulWidget {
  var teams;
  TeamPlayers({required this.teams});

  @override
  State<TeamPlayers> createState() => _TeamPlayersState();
}

class _TeamPlayersState extends State<TeamPlayers> {
  @override
  Widget build(BuildContext context) {
    final facea = widget.teams['face'] as List<dynamic>;
    final kita = widget.teams['kit'] as List<dynamic>;
    final playera = widget.teams['player'] as List<dynamic>;
    final txt2a = widget.teams['txt2'] as List<dynamic>;

    return Scaffold(
      backgroundColor: AppColor.whiteclr2,
      appBar: CustomAppBar(title: "PLAYERS"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: double.maxFinite,
              child: GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 10.0, // Spacing between columns
                  mainAxisSpacing: 35.0, // Spacing between rows
                ),
                itemCount: facea.length, // Number of items in the grid
                itemBuilder: (BuildContext context, int index) {
                  // Create your grid item here, for example:
                  return tColumn(
                      facea[index], kita[0], playera[index], txt2a[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
