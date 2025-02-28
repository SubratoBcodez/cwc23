import 'package:cwc23/bcodez/route.dart';
import 'package:cwc23/bcodez/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  // var devices = [""];
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  // RequestConfiguration requestConfiguration =
  //     RequestConfiguration(testDeviceIds: devices);
  // MobileAds.instance.updateRequestConfiguration(requestConfiguration);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppString.app_name,
          theme: ThemeData(
            fontFamily: 'INDIA23',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: splash,
          getPages: getPages,
        );
      },
    );
  }
}
