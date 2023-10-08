import 'package:cwc23/bcodez/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cwc23/bcodez/route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  chooseScreen(context){
    Get.toNamed(bottomnav);
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4),()=>chooseScreen(context));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.purpleclr,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Center(
                child: Image.asset('assets/images/icon.png',width: 150.w,height: 150.h,),
              ),
            ),
            Container(
                width: 200.w,
                child: LinearProgressIndicator(color: AppColor.pinkclr,)),
            SizedBox(
              height: 270.h,
            ),
            Text("Developed by",style: TextStyle(color: AppColor.whiteclr, fontSize: 10.sp,fontWeight: FontWeight.w500 ),),
            Text("BasakCodez",style: TextStyle(color: AppColor.whiteclr, fontSize: 15.sp,fontWeight: FontWeight.w600),),

          ],
        ),
      ),
    );
  }
}
