import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'color.dart';

Widget tColumn(face, kit, txt, txt2) {
  return Container(
    decoration: BoxDecoration(
        color: AppColor.whiteclr,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
              color: AppColor.purpleclr.withOpacity(0.05),
              blurRadius: 10.r,
              offset: Offset(1, 15))
        ]),
    child: Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Divider(
            height: 30.h,
            color: Colors.transparent,
          ),
          Spacer(),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 0,
                left: 0,
                top: -60.sp,
                child: CachedNetworkImage(
                  imageUrl: face,
                  // height: 80.h,
                  width: 85.w,
                ),
              ),
              Positioned(
                  child: CachedNetworkImage(
                imageUrl: kit,
                width: 85.w,
                // height: 30.h,
              ))
            ],
          ),
          SizedBox(
            height: 2,
          ),
          Column(
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: txt,
                    style: TextStyle(
                        fontSize: 9.sp,
                        color: AppColor.purpleclr,
                        fontWeight: FontWeight.bold)),
                TextSpan(text: "\n"),
                TextSpan(
                    text: txt2,
                    style: TextStyle(fontSize: 9.sp, color: AppColor.purpleclr))
              ])),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget cColumn(txt0, txt1, txt2, face, kit) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                txt0,
                style: TextStyle(
                    color: AppColor.whiteclr,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                txt1,
                style: TextStyle(
                    color: AppColor.whiteclr,
                    fontSize: 28,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                txt2,
                style: TextStyle(
                    color: AppColor.whiteclr,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: 44,
                ),
                Positioned(
                  right: 3,
                  bottom: -25,
                  child: CachedNetworkImage(
                    imageUrl: face,
                    // height: 80.h,
                    width: 85.w,
                  ),
                ),
                Positioned(
                  bottom: -40,
                  right: 0,
                  child: CachedNetworkImage(
                    imageUrl: kit,
                    width: 90.w,
                    // height: 30.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Text sText(txt) {
  return Text(
    txt,
    style: TextStyle(
        color: AppColor.purpleclr, fontWeight: FontWeight.normal, fontSize: 18),
  );
}

Text cText(
  String text,
  Color clr,
  double fs,
  FontWeight fw, {
  TextAlign al = TextAlign.left,
}) {
  return Text(
    text,
    textAlign: al,
    style: TextStyle(color: clr, fontSize: fs, fontWeight: fw),
  );
}

TextSpan cTextSpan(txt, clr, double fs, fw) {
  return TextSpan(
      text: txt, style: TextStyle(color: clr, fontSize: fs, fontWeight: fw));
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColor.whiteclr,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(color: AppColor.whiteclr),
      ),
      centerTitle: true,
      backgroundColor: AppColor.purpleclr,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
