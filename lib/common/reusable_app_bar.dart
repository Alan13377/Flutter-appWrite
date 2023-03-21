import 'package:appwrite_flutter/constant/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReusabelAppBar extends StatelessWidget {
  const ReusabelAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
      ),
    );
  }
}
