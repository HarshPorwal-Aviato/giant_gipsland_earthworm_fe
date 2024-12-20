import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double _screenWidth;
  static late double _screenHeight;
  static double _blockSizeHorizontal = 0;
  static double _blockSizeVertical = 0;

  static late double _textMultiplier;
  static double _heightMultiplier = 0;
  static double _widthMultiplier = 0;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    isPortrait = _mediaQueryData.orientation == Orientation.portrait;
    isMobilePortrait =
        isPortrait && getDeviceType(_mediaQueryData) == DeviceScreenType.mobile;

    if (isPortrait) {
      _screenWidth = _mediaQueryData.size.width;
      _screenHeight = _mediaQueryData.size.height;
    } else {
      _screenWidth = _mediaQueryData.size.height;
      _screenHeight = _mediaQueryData.size.width;
    }

    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;

    _textMultiplier = _blockSizeVertical;
    _heightMultiplier = _blockSizeVertical;
    _widthMultiplier = _blockSizeHorizontal;
  }

  static double getVerticalSize(double height) {
    return (height / 8.12) * (num.tryParse(_heightMultiplier.toString()) ?? 0);
  }

  static double getHorizontalSize(double width) {
    return (width / 3.75) * _widthMultiplier;
  }

  static double getTextSize(double textSize) {
    return (textSize / 8.12) * _textMultiplier;
  }

  static double getTopScreenPadding() {
    return _mediaQueryData.padding.top;
  }

  static double getBottomScreenPadding() {
    return _mediaQueryData.padding.bottom;
  }

  static double getLeftScreenPadding() {
    return _mediaQueryData.padding.left;
  }

  static double getRightScreenPadding() {
    return _mediaQueryData.padding.right;
  }
}

extension SizeConfigExtension on num {
  double vdp() {
    var value = this;
    return value is double
        ? SizeConfig.getVerticalSize(value)
        : SizeConfig.getVerticalSize(value.toDouble());
  }

  double hdp() {
    var value = this;
    return value is double
        ? SizeConfig.getHorizontalSize(value)
        : SizeConfig.getHorizontalSize(value.toDouble());
  }

  double sp() {
    return vdp();
  }
}

DeviceScreenType getDeviceType(MediaQueryData mediaQueryData) {
  double deviceWidth = mediaQueryData.size.width;

  if (deviceWidth > 1280) {
    return DeviceScreenType.desktop;
  } else if (deviceWidth < 1280 && deviceWidth > 600) {
    return DeviceScreenType.tablet;
  } else {
    return DeviceScreenType.mobile;
  }
}

enum DeviceScreenType {
  mobile,
  tablet,
  desktop,
}
