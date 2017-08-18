# Barcode ANE V3.3.0 (Android+iOS)
This ANE enables AS3 AIR developers, to easily use the native camera on device and scan for almost all different barcodes and get the result to their AIR project.

## Supported barcodes:
* UPCE
* CODE39
* EAN13
* EAN8
* CODE128
* PDF417
* QR
* AZTEC
* ITF14
* DATAMATRIX

# asdoc
[find the latest asdoc for this ANE here.](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/barcode/package-detail.html)

# Demo .apk
you may like to see the ANE in action? [Download demo .apk](https://github.com/myflashlab/barcode-ANE/tree/master/FD/dist)

**NOTICE**: the demo ANE works only after you hit the "OK" button in the dialog which opens. in your tests make sure that you are NOT calling other ANE methods prior to hitting the "OK" button.
[Download the ANE](https://github.com/myflashlab/barcode-ANE/tree/master/FD/lib)

# AIR Usage
For the complete AS3 code usage, see the [demo project here](https://github.com/myflashlab/barcode-ANE/blob/master/FD/src/MainFinal.as).

```actionscript
import com.myflashlab.air.extensions.barcode.Barcode;
import com.myflashlab.air.extensions.barcode.BarcodeEvent;

var _ex:Barcode = new Barcode();
_ex.addEventListener(BarcodeEvent.RESULT, onResult);
_ex.addEventListener(BarcodeEvent.CANCEL, onCancel);

if (_ex.isSupported())
{
	trace("Please wait...");

	// to read only the selected barcode types. use an array to read one or more barcodes
    //_ex.open([Barcode.QR], File.applicationDirectory.resolvePath("com_doitflash_barcode_beep.mp3"), true, "Cancel");
	
	// to read all barcodes supported by the extension. read documentations to know which barcodes are supported.
	_ex.open(null, File.applicationDirectory.resolvePath("com_doitflash_barcode_beep.mp3"), true, "Cancel");
}
else
{
	trace("isSupported: ", _ex.isSupported());
}

function onCancel(e:BarcodeEvent):void
{
    trace("scan canceled")
}

function onResult(e:BarcodeEvent):void
{
    trace("type is: ", e.param.type)
	trace("data is: ", e.param.data);
}
```

# AIR .xml manifest
```xml
<!--
FOR ANDROID:
-->
<manifest android:installLocation="auto">
	
	<!--You surely need permission to use the camera, right?-->
	<uses-permission android:name="android.permission.CAMERA" />
	<uses-feature android:name="android.hardware.camera" />
	<uses-feature android:name="android.hardware.camera.autofocus" android:required="false" />
	<uses-feature android:name="android.hardware.screen.landscape" />
	
	<!--If you wish to use the vibration when a barcode is detected, you need to set the permission like below-->
	<uses-permission android:name="android.permission.VIBRATE"/>
	
	<!--Android 15 or higher can support this ANE-->
	<uses-sdk android:minSdkVersion="15" />
	
	<!--The new Permission thing on Android works ONLY if you are targetting Android SDK 23 or higher-->
	<uses-sdk android:targetSdkVersion="23"/>
	
	<!--Zxing lib requires you to set this screen supports-->
	<supports-screens 	android:anyDensity="true" 
						android:largeScreens="true" 
						android:normalScreens="true" 
						android:smallScreens="true" 
						android:xlargeScreens="true" />
		
	<application>
		
		<activity>
			<intent-filter>
				<action android:name="android.intent.action.MAIN" />
				<category android:name="android.intent.category.LAUNCHER" />
			</intent-filter>
			<intent-filter>
				<action android:name="android.intent.action.VIEW" />
				<category android:name="android.intent.category.BROWSABLE" />
				<category android:name="android.intent.category.DEFAULT" />
			</intent-filter>
		</activity>
		
		<!--Main activity for detecting barcodes-->
		<activity 	android:name="com.google.zxing.client.android.CaptureActivity" 
					android:clearTaskOnLaunch="true" 
					android:screenOrientation="landscape" 
					android:configChanges="orientation|keyboardHidden" 
					android:stateNotNeeded="true" 
					android:theme="@android:style/Theme.NoTitleBar.Fullscreen" 
					android:windowSoftInputMode="stateAlwaysHidden" />
		
		<!--bridge activity between Native Android and Adobe Air-->
		<activity 	android:name="com.doitflash.barcode.utils.ExBridge" 
					android:theme="@style/Theme.Transparent" />
		
	</application>
</manifest>







<!--
FOR iOS:
-->
<InfoAdditions>
	
	<!--iOS 8.0 or higher can support this ANE-->
	<key>MinimumOSVersion</key>
	<string>8.0</string>
	
	<!--A new feature for iOS 10 submissions requires you to add the 'purpose string' to your app when accessing a user's private data-->
	<key>NSCameraUsageDescription</key>
	<string>My description about why I need this feature in my app</string>
	
</InfoAdditions>






<!--
Embedding the ANE:
-->
<extensions>

	<extensionID>com.myflashlab.air.extensions.barcode</extensionID>
	
	<!-- Required if you are targeting AIR 24+ and have to take care of Permissions mannually -->
	<extensionID>com.myflashlab.air.extensions.permissionCheck</extensionID>
	
	<!-- download the dependency ANEs from https://github.com/myflashlab/common-dependencies-ANE -->
	<extensionID>com.myflashlab.air.extensions.dependency.androidSupport</extensionID>
	<extensionID>com.myflashlab.air.extensions.dependency.overrideAir</extensionID>
	
</extensions>
```

# Requirements
* This ANE is dependent on **androidSupport-lite.ane** and **overrideAir.ane**. Download them from [here](https://github.com/myflashlab/common-dependencies-ANE).
* Adobe AIR SDK 19 or higher
* Android 15 or higher
* iOS 8.0 or higher

# Permissions
If you are targeting AIR 24 or higher, you need to [take care of the permissions manually](http://www.myflashlabs.com/adobe-air-app-permissions-android-ios/). Below are the list of Permissions this ANE might require. (Note: *Necessary Permissions* are those that the ANE will NOT work without them and *Optional Permissions* are those which are needed only if you are using some specific features in the ANE.)

Check out the demo project available at this repository to see how we have used our [PermissionCheck ANE](http://www.myflashlabs.com/product/native-access-permission-check-settings-menu-air-native-extension/) to ask for the permissions.

**Necessary Permissions:**  

1. PermissionCheck.SOURCE_CAMERA

**Optional Permissions:**  
none

# Commercial Version
http://www.myflashlabs.com/product/qr-code-ane-adobe-air-native-extension/

![Barcode code scanner ANE](http://www.myflashlabs.com/wp-content/uploads/2015/11/product_adobe-air-ane-extension-qr-code-595x738.jpg)

# Tutorials
[How to embed ANEs into **FlashBuilder**, **FlashCC** and **FlashDevelop**](https://www.youtube.com/watch?v=Oubsb_3F3ec&list=PL_mmSjScdnxnSDTMYb1iDX4LemhIJrt1O)  

# Changelog
*Mar 17, 2017 - 3.3.0*
* Fixed [issue 34](https://github.com/myflashlab/barcode-ANE/issues/34)
* Updated with the new OverrideAir ANE.
* Even if you are building for iOS only, you still need to add the OverrideAir dependency.

*Nov 11, 2016 - 3.2.0*
* Optimized for Android manual permissions if you are targeting AIR SDK 24+
* From now on, this ANE will depend on androidSupport.ane and overrideAir.ane on the Android side

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