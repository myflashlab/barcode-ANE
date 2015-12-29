# Barcode ANE V3.0.0 (Android+iOS)
This ANE enables AS3 air developers, to easily use the native camera on device and scan for almost all different barcodes and get the result to their air project.

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

checkout here for the commercial version: http://www.myflashlabs.com/product/qr-code-ane-adobe-air-native-extension/

![Barcode code scanner ANE](http://www.myflashlabs.com/wp-content/uploads/2015/11/product_adobe-air-ane-extension-qr-code-595x738.jpg)

you may like to see the ANE in action? check this out: https://github.com/myflashlab/barcode-ANE/tree/master/FD/dist

**NOTICE: the demo ANE works only after you hit the "OK" button in the dialog which opens. in your tests make sure that you are NOT calling other ANE methods prior to hitting the "OK" button.**

# AS3 API:
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

# Air .xml manifest
```xml
  <android>
    <manifestAdditions><![CDATA[<manifest android:installLocation="auto">
	<uses-permission android:name="android.permission.INTERNET" />
		
	<!--You surely need permission to use the camera, right?-->
	<uses-permission android:name="android.permission.CAMERA" />
	<uses-feature android:name="android.hardware.camera" />
	<uses-feature android:name="android.hardware.camera.autofocus" android:required="false" />
	<uses-feature android:name="android.hardware.screen.landscape" />
		
	<!--If you wish to use the vibration when a barcode is detected, you need to set the permission like below-->
	<uses-permission android:name="android.permission.VIBRATE"/>
	
	<!--Android 15 or higher can support this ANE-->
	<uses-sdk android:minSdkVersion="15" />
		
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
</manifest>]]></manifestAdditions>
  </android>
  <iPhone>
    <InfoAdditions><![CDATA[
	
		<!--iOS 8.0 or higher can support this ANE-->
		<key>MinimumOSVersion</key>
		<string>8.0</string>
			
		<key>UIStatusBarStyle</key>
		<string>UIStatusBarStyleBlackOpaque</string>
			
		<key>UIRequiresPersistentWiFi</key>
		<string>NO</string>
			
		<key>UIDeviceFamily</key>
		<array>
			<string>1</string>
			<string>2</string>
		</array>
		
	]]></InfoAdditions>
    <requestedDisplayResolution>high</requestedDisplayResolution>
  </iPhone>
```

# Requirements:
* Android SDK 15 or higher
* iOS 8.0 or higher