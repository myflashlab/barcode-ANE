# Barcode ANE (Android+iOS)
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

[find the latest **asdoc** for this ANE here.](http://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/barcode/package-detail.html)

# AIR Usage
For the complete AS3 code usage, see the [demo project here](https://github.com/myflashlab/barcode-ANE/blob/master/AIR/src/MainFinal.as).

```actionscript
import com.myflashlab.air.extensions.barcode.*;

var _ex:Barcode = new Barcode();
_ex.addEventListener(BarcodeEvent.RESULT, onResult);
_ex.addEventListener(BarcodeEvent.CANCEL, onCancel);

if(_ex.os == Barcode.ANDROID)
{
	// to speed up the launch time on Android, you may call the warmup method when
	// it is appropriate in your application. This may be needed if you are using the
	// full version of AndroidSupport dependency.
	// the first time you call the warmup method, your app will freeze for a few seconds...
	_ex.warmup();			
}

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
	<uses-sdk android:targetSdkVersion="26"/>
	
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
	
	<!-- http://www.myflashlabs.com/product/native-access-permission-check-settings-menu-air-native-extension/ -->
	<extensionID>com.myflashlab.air.extensions.permissionCheck</extensionID>
	
	<!-- https://github.com/myflashlab/common-dependencies-ANE -->
	<extensionID>com.myflashlab.air.extensions.dependency.overrideAir</extensionID>
	<extensionID>com.myflashlab.air.extensions.dependency.androidSupport.v4</extensionID>
	<extensionID>com.myflashlab.air.extensions.dependency.androidSupport.core</extensionID>
	
</extensions>
```

# Requirements
* This ANE is dependent on **permissionCheck**. Download it from [here](http://www.myflashlabs.com/product/native-access-permission-check-settings-menu-air-native-extension/).
* AIR SDK 30+
* Android 15+
* iOS 8.0+

# Permissions
Below are the list of Permissions this ANE might require. Check out the demo project available at this repository to see how we have used the [PermissionCheck ANE](http://www.myflashlabs.com/product/native-access-permission-check-settings-menu-air-native-extension/) to ask for the permissions.

Necessary | Optional
--------------------------- | ---------------------------
[SOURCE_CAMERA](https://myflashlab.github.io/asdoc/com/myflashlab/air/extensions/nativePermissions/PermissionCheck.html#SOURCE_CAMERA) | NONE

# Commercial Version
https://www.myflashlabs.com/product/qr-code-ane-adobe-air-native-extension/

[![Barcode code scanner ANE](https://www.myflashlabs.com/wp-content/uploads/2015/11/product_adobe-air-ane-extension-qr-code-2018-595x738.jpg)](https://www.myflashlabs.com/product/qr-code-ane-adobe-air-native-extension/)

# Tutorials
[How to embed ANEs into **FlashBuilder**, **FlashCC** and **FlashDevelop**](https://www.youtube.com/watch?v=Oubsb_3F3ec&list=PL_mmSjScdnxnSDTMYb1iDX4LemhIJrt1O)  

# Premium Support #
[![Premium Support package](https://www.myflashlabs.com/wp-content/uploads/2016/06/professional-support.jpg)](https://www.myflashlabs.com/product/myflashlabs-support/)
If you are an [active MyFlashLabs club member](https://www.myflashlabs.com/product/myflashlabs-club-membership/), you will have access to our private and secure support ticket system for all our ANEs. Even if you are not a member, you can still receive premium help if you purchase the [premium support package](https://www.myflashlabs.com/product/myflashlabs-support/).