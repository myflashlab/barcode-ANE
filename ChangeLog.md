Barcode Scanner Adobe AIR Native Extension

*Aug 04, 2020 - v5.0.0*
- Upgrade dependencies to the latest version.
- Fixed and improve some minor issues and refactor native codes.

*Apr 04, 2020 - V4.0.1*
- Add androidx libraries instead of android support

*Aug 02, 2019 - V3.4.71*
* Added support for Android 64-bit
* Removed **.os** property, use `OverrideAir.os` instead.

*Nov 17, 2018 - V3.4.7*
* Works with OverrideAir ANE V5.6.1 or higher
* Works with ANELAB V1.1.26 or higher

*Sep 10, 2018 - 3.4.6*
* Removed androidSupport dependeny.

*Feb 7, 2018 - 3.4.5*
* Fixed [issue 53](https://github.com/myflashlab/barcode-ANE/issues/53)

*Dec 15, 2017 - 3.4.4*
* Optimized for [ANE-LAB software](https://github.com/myflashlab/ANE-LAB/).

*Aug 24, 2017 - 3.4.0*
* Updated to the latest version of zxing library.
* Added method `warmup()` for Android to speedup the camera launch time if you are using the full version of the [androidSupport](https://github.com/myflashlab/common-dependencies-ANE/tree/master/androidSupport)

*Mar 17, 2017 - 3.3.0*
* Fixed [issue 34](https://github.com/myflashlab/barcode-ANE/issues/34)
* Updated with the new OverrideAir ANE.
* Even if you are building for iOS only, you still need to add the OverrideAir dependency.

*Nov 11, 2016 - 3.2.0*
* Optimized for Android manual permissions if you are targeting AIR SDK 24+
* From now on, this ANE will depend on androidSupport.ane and overrideAir.ane on the Android side
* 

*Mar 28, 2016 - 3.1.1*
* Fixed a bug related to wrongly showing a broken menu on Android devices with a hardware menu key. 


*Jan 20, 2016 - 3.1.0*
* bypassing xCode 7.2 bug causing iOS conflict when compiling with AirSDK 20 without waiting on Adobe or Apple to fix the problem. This is a must have upgrade for your app to make sure you can compile multiple ANEs in your project with AirSDK 20 or greater. https://forums.adobe.com/thread/2055508 https://forums.adobe.com/message/8294948


*Dec 29, 2015 - 3.0.0*
* added optional beep sound and vibration when a barcode is detected
* Added support for almost all barcodes including: UPCE, CODE39, EAN13, EAN8, CODE128, PDF417, QR, AZTEC, ITF14, DATAMATRIX


*Dec 20, 2015 - 2.9.1*
* minor bug fixes


*Nov 02, 2015 - V2.9*
* doitflash devs merged into MyFLashLab Team.


*May 16, 2015 - V2.1*
* removed android-support-v4.jar dependency


*Jan 28, 2015 - V2.0*
* added support for iOS devices including 64-bit arch


*Mar 03, 2013 - V1.1*
* there was a bug when compiling with Flex SDK 4.6 which is now fixed


*Jan 31, 2013 - V1.0*
* beginning of the journey!
