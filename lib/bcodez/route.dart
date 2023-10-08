import 'package:cwc23/screen/buttom_nav.dart';
import 'package:cwc23/screen/splash.dart';
import 'package:cwc23/views/about.dart';
import 'package:cwc23/views/fixture.dart';
import 'package:cwc23/views/highlights.dart';
import 'package:cwc23/views/home.dart';
import 'package:cwc23/views/livetv.dart';
import 'package:cwc23/views/match_preview.dart';
import 'package:cwc23/views/matches.dart';
import 'package:cwc23/views/playing_xi.dart';
import 'package:cwc23/views/standings.dart';
import 'package:cwc23/views/stedium.dart';
import 'package:cwc23/views/teamplayers.dart';
import 'package:cwc23/views/teams.dart';
import 'package:get/route_manager.dart';

const String splash = '/splash';
const String bottomnav = '/bottom_nav';
const String home = '/home';
const String about = '/about';
const String fixture = '/fixture';
const String highlights = '/highlights';
const String livetv = '/livetv';
const String match_preview = '/match_preview';
const String playing_xi = '/playing_xi';
const String stedium = '/stedium';
const String teamplayers = '/teamplayers';
const String teams = '/teams';
const String standings = '/standings';
const String matches = '/matches';

List<GetPage> getPages = [
  GetPage(name: splash, page: () => SplashScreen()),
  GetPage(name: bottomnav, page: () => BottomNav()),
  GetPage(name: home, page: () => HomeScreen()),
  GetPage(name: about, page: () => AboutScreen()),
  GetPage(name: fixture, page: () => FixtureScreen()),
  // GetPage(
  //     name: matches,
  //     page: () => MatchesScreen(
  //           match: Get.arguments,
  //         )),
  GetPage(name: highlights, page: () => HighLights()),
  GetPage(name: livetv, page: () => LiveTV()),
  GetPage(
      name: match_preview,
      page: () => MatchPreview(
            fixtures: Get.arguments,
          )),
  GetPage(name: playing_xi, page: () => PlayingXI()),
  GetPage(name: stedium, page: () => Stedium()),
  GetPage(
      name: teamplayers,
      page: () => TeamPlayers(
            teams: Get.arguments,
          )),
  GetPage(name: teams, page: () => Teams()),
  GetPage(name: standings, page: () => Standings())
];
