# QR code reader ANE (Android+iOS)
Air QR scanner extension enables AS3 air developers, to easily use the native camera on device and scan for QR codes and get the result to their air project.

checkout here for the commercial version: http://www.myflashlabs.com/product/qr-code-ane-adobe-air-native-extension/

![QR code reader ANE](http://myappsnippet.com/wp-content/uploads/2015/01/adobe-air-extension_qrcode-reader.jpg)

you may like to see the ANE in action? check this out: https://github.com/myflashlab/barcode-ANE/tree/master/FD/dist

**NOTICE: the demo ANE works only after you hit the "OK" button in the dialog which opens. in your tests make sure that you are NOT calling other ANE methods prior to hitting the "OK" button.**

# AS3 API:
```actionscript
import com.myflashlab.air.extensions.barcode.Barcode;
import com.myflashlab.air.extensions.barcode.BarcodeEvent;

var _ex:Barcode = new Barcode();
_ex.addEventListener(BarcodeEvent.CANCEL, onCancel);
_ex.addEventListener(BarcodeEvent.RESULT, onResult);
_ex.setBtns("OK", "RETRY", "CANCEL");
_ex.closeOnResultFounded = true;

if (_ex.isSupported())
{
    _ex.open();
}

function onCancel(e:BarcodeEvent):void
{
    trace("canceled")
}
     
function onResult(e:BarcodeEvent):void
{
    trace("result >> QR type is: ", e.param.type);
    trace("QR data is: ", e.param.data);
}
```
**NOTICE:** on the manifest below, make sure to change ```<action android:name="air.com.doitflash.exBarcode" />``` to your own app package name.

# Air .xml manifest
```xml
  <android>
    <manifestAdditions><![CDATA[<manifest android:installLocation="auto">
    <uses-permission android:name="android.permission.CAMERA" />
   <uses-feature android:name="android.hardware.camera" />
   <uses-feature
       android:name="android.hardware.camera.autofocus"
       android:required="false" />
   <uses-feature
       android:name="android.hardware.camera.flash"
       android:required="false" />
   <uses-feature android:name="android.hardware.screen.landscape" />
   <uses-feature
       android:name="android.hardware.touchscreen"
       android:required="false" />
   <supports-screens
       android:anyDensity="true"
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
       
       
           
       <activity
           android:name="com.google.zxing.client.android.CaptureActivity"
           android:clearTaskOnLaunch="true"
           android:configChanges="orientation|keyboardHidden"
           
           android:stateNotNeeded="true"
           android:theme="@android:style/Theme.NoTitleBar.Fullscreen"
           android:windowSoftInputMode="stateAlwaysHidden" >
           <intent-filter>
               <action android:name="air.com.doitflash.exBarcode" />
               <category android:name="android.intent.category.DEFAULT" />
           </intent-filter>
       </activity>
       <activity
           android:name="com.google.zxing.client.android.PreferencesActivity"
           android:label="Settings"
           android:stateNotNeeded="true" >
       </activity>
       
        <activity
           android:name="com.doitflash.barcode.MainActivity"
           android:label="Barcode Scanner" >
            <intent-filter>
               <category android:name="android.intent.category.DEFAULT" />
           </intent-filter>
       </activity>
   
    </application>
</manifest>]]></manifestAdditions>
  </android>
 
  <iPhone>
    <!--https://developer.apple.com/library/ios/documentation/general/reference/infoplistkeyreference/Articles/iPhoneOSKeys.html-->
    <!--http://help.adobe.com/en_US/air/build/WSfffb011ac560372f7e64a7f12cd2dd1867-8000.html-->
    <InfoAdditions>
        <![CDATA[<key>MinimumOSVersion</key>
        <string>6.1</string>
        <key>UIStatusBarStyle</key>
        <string>UIStatusBarStyleBlackOpaque</string>
        <key>UIRequiresPersistentWiFi</key>
        <string>NO</string>
        <key>UIPrerenderedIcon</key>
        <true />
        <key>UIDeviceFamily</key>
        <array>
            <!-- iPhone support -->
            <string>1</string>
            <!-- iPad support -->
            <string>2</string>
        </array>]]>
    </InfoAdditions>
    <requestedDisplayResolution>high</requestedDisplayResolution>
  </iPhone>
```