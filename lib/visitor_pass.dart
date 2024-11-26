import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:testx/models/visitor.dart';
import 'package:testx/utils/colors.dart';
import 'package:testx/utils/fonts.dart';

class VisitorPass extends StatefulWidget {
  final Visitor visitor;
  const VisitorPass({super.key, required this.visitor});

  @override
  State<VisitorPass> createState() => _VisitorPassState();
}

class _VisitorPassState extends State<VisitorPass> {
  Uint8List? _qrImage;
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> shareQrCode() async {
    // capture qr from view and share
    screenshotController.capture().then((Uint8List? image) async {
      setState(() {
        _qrImage = image;
      });

      final dir = await getApplicationDocumentsDirectory();
      final imgPath = await File('${dir.path}/Visitor_pass.png').create();
      await imgPath.writeAsBytes(_qrImage!);
      debugPrint(imgPath.path);

      // share qr
      await Share.shareXFiles([XFile(imgPath.path)], text: 'Visitor Pass');
    }).catchError((onError) {
      debugPrint('Error:  $onError');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          pageBg(context),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width / 1.8,
                height: MediaQuery.sizeOf(context).width / 1.8,
                padding: const EdgeInsets.all(25),
                color: const Color(0xFF1C2130),
                child: FittedBox(
                    child: Screenshot(
                        controller: screenshotController,
                        child: Image.asset("assets/images/qr.png"))),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Your Visitor QR Code',
                style: TextStyle(
                  fontFamily: TestXFonts.headerFontFamily,
                  color: TestXColors.secondaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 1),
              const Text(
                'was generated successfully!',
                style: TextStyle(
                  fontFamily: TestXFonts.headerFontFamily,
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: MediaQuery.sizeOf(context).width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.05),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/empty_profile.png",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.visitor.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    DateFormat('d/M/y - hh:mm a')
                                        .format(widget.visitor.date),
                                    style: TextStyle(
                                      color: Colors.white
                                          .withOpacity(0.800000011920929),
                                      fontSize: 11,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const SizedBox(
                width: 340,
                child: Text(
                  'Share this screen with your visitor so they can access it',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFF157C8C), TestXColors.secondaryColor],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(500),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x4C3596A6),
                      blurRadius: 40,
                      offset: Offset(0, 10),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: ElevatedButton(
                    onPressed: () {
                      shareQrCode();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 12,
                      ).copyWith(left: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Align(
                      child: Text(
                        "Share This QR Code",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )),
              ),
              Text.rich(
                TextSpan(
                  text: "Back To Home",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pop(context);
                    },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

Widget pageBg(BuildContext context) {
  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    // top: 300,
    top: 0,
    child: Column(
      children: [
        Image.asset(
          "assets/images/calling_large.jpg",
          fit: BoxFit.cover,
          height: 300,
          width: MediaQuery.sizeOf(context).width,
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                  color: Color(0xFF121625),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: const Alignment(0, 0),
                    radius: 1.5,
                    colors: [
                      TestXColors.secondaryColor.withOpacity(0.2),
                      const Color(0xFF157C8C).withOpacity(0.05)
                    ],
                    stops: const [0, 0.2],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
