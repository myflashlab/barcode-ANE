package 
{
	import com.myflashlab.air.extensions.barcode.Barcode;
	import com.myflashlab.air.extensions.barcode.BarcodeEvent;
	import com.myflashlab.air.extensions.inspector.Inspector;
	import com.myflashlab.air.extensions.nativePermissions.PermissionCheck;
	import com.myflashlab.air.extensions.dependency.OverrideAir;
	
	import com.doitflash.consts.Direction;
	import com.doitflash.consts.Orientation;
	import com.doitflash.starling.utils.list.List;
	import com.doitflash.text.modules.MySprite;
	import com.luaye.console.C;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.InvokeEvent;
	import flash.events.MouseEvent;
	import flash.events.StageOrientationEvent;
	import flash.filesystem.File;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import com.doitflash.mobileProject.commonCpuSrc.DeviceInfo;
	import flash.events.StatusEvent;
	//import flash.display.StageOrientation;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	import flash.system.Capabilities;
	
	/**
	 * ...
	 * @author Hadi Tavakoli - 10/22/2014 12:10 PM
	 */
	public class MainFinal extends Sprite 
	{
		private var _ex:Barcode;
		private var _exPermissions:PermissionCheck = new PermissionCheck();
		
		private const BTN_WIDTH:Number = 150;
		private const BTN_HEIGHT:Number = 60;
		private const BTN_SPACE:Number = 2;
		private var _txt:TextField;
		private var _body:Sprite;
		private var _list:List;
		private var _numRows:int = 1;
		
		public function MainFinal():void 
		{
			Multitouch.inputMode = MultitouchInputMode.GESTURE;
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, handleActivate, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, handleDeactivate, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke, false, 0, true);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, handleKeys, false, 0, true);
			
			stage.addEventListener(Event.RESIZE, onResize);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			C.startOnStage(this, "`");
			C.commandLine = false;
			C.commandLineAllowed = false;
			C.x = 100;
			C.width = 500;
			C.height = 250;
			C.strongRef = true;
			C.visible = true;
			C.scaleX = C.scaleY = DeviceInfo.dpiScaleMultiplier;
			
			_txt = new TextField();
			_txt.autoSize = TextFieldAutoSize.LEFT;
			_txt.antiAliasType = AntiAliasType.ADVANCED;
			_txt.multiline = true;
			_txt.wordWrap = true;
			_txt.embedFonts = false;
			_txt.htmlText = "<font face='Arimo' color='#333333' size='20'><b>QR Scanner ANE for iOS and Android V"+Barcode.VERSION+"</b></font>";
			_txt.scaleX = _txt.scaleY = DeviceInfo.dpiScaleMultiplier;
			this.addChild(_txt);
			
			_body = new Sprite();
			this.addChild(_body);
			
			_list = new List();
			_list.holder = _body;
			_list.itemsHolder = new Sprite();
			_list.orientation = Orientation.VERTICAL;
			_list.hDirection = Direction.LEFT_TO_RIGHT;
			_list.vDirection = Direction.TOP_TO_BOTTOM;
			_list.space = BTN_SPACE;
			
			checkPermissions();
		}
		
		private function onInvoke(e:InvokeEvent):void
		{
			NativeApplication.nativeApplication.removeEventListener(InvokeEvent.INVOKE, onInvoke);
		}
		
		private function closeApp(e:MouseEvent):void
		{
			NativeApplication.nativeApplication.exit();
		}
		
		private function handleActivate(e:Event):void
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		}
		
		private function handleDeactivate(e:Event):void
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.NORMAL;
		}
		
		private function handleKeys(e:KeyboardEvent):void
		{
			if(e.keyCode == Keyboard.BACK)
            {
				e.preventDefault();
				NativeApplication.nativeApplication.exit();
            }
		}
		
		private function onResize(e:*=null):void
		{
			if (_txt)
			{
				_txt.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
				
				C.x = 0;
				C.y = _txt.y + _txt.height + 0;
				C.width = stage.stageWidth * (1 / DeviceInfo.dpiScaleMultiplier);
				C.height = 300 * (1 / DeviceInfo.dpiScaleMultiplier);
			}
			
			if (_list)
			{
				_numRows = Math.floor(stage.stageWidth / (BTN_WIDTH * DeviceInfo.dpiScaleMultiplier + BTN_SPACE));
				_list.row = _numRows;
				_list.itemArrange();
			}
			
			if (_body)
			{
				_body.y = stage.stageHeight - _body.height;
			}
		}
		
		private function checkPermissions():void
		{
			// first you need to make sure you have access to the Strorage if you are on Android?
			var permissionState:int = _exPermissions.check(PermissionCheck.SOURCE_CAMERA);
			
			if (permissionState == PermissionCheck.PERMISSION_UNKNOWN || permissionState == PermissionCheck.PERMISSION_DENIED)
			{
				_exPermissions.request(PermissionCheck.SOURCE_CAMERA, onRequestResult);
			}
			else
			{
				init();
			}
			
			function onRequestResult($state:int):void
			{
				if ($state != PermissionCheck.PERMISSION_GRANTED)
				{
					C.log("You did not allow the app the required permissions!");
				}
				else
				{
					init();
				}
			}
		}
		
		private function myDebuggerDelegate($ane:String, $class:String, $msg:String):void
		{
			trace("------------------");
			trace("$ane = " + $ane);
			trace("$class = " + $class);
			trace("$msg = " + $msg);
			trace("------------------");
		}
		
		private function init():void
		{
			/*if (!Inspector.check(Barcode, true, true))
			{
				trace("Inspector.lastError = " + Inspector.lastError);
				C.log("Inspector.lastError = " + Inspector.lastError);
				return;
			}*/
			
			// remove this line in production build or pass null as the delegate
			OverrideAir.enableDebugger(myDebuggerDelegate);
			
			
			// initialize the extension
			_ex = new Barcode();
			_ex.addEventListener(BarcodeEvent.RESULT, onResult);
			_ex.addEventListener(BarcodeEvent.CANCEL, onCancel);
			
			var btn1:MySprite = createBtn("open Scanner");
			btn1.addEventListener(MouseEvent.CLICK, open);
			_list.add(btn1);
			
			function open(e:MouseEvent):void
			{
				if (_ex.isSupported())
				{
					C.log("Please wait...");
					
					// TODO: Known bug on ios: the beep mp3 file must be in the same folder where the main Adobe Air .swf file is.
					
					
					
					// to read only the selected barcode types. use an array to read one or more barcodes
					//_ex.open([Barcode.QR], File.applicationDirectory.resolvePath("com_doitflash_barcode_beep.mp3"), true, "back to The Air APP! :D");
					
					// to read all barcodes supported by the extension. read documentations to know which barcodes are supported.
					_ex.open(null, File.applicationDirectory.resolvePath("com_doitflash_barcode_beep.mp3"), true, "back to The Air APP! :D");
				}
				else
				{
					C.log("isSupported: ", _ex.isSupported());
				}
			}
			
			onResize();
		}
		
		private function onCancel(e:BarcodeEvent):void
		{
			C.log("scan canceled")
		}
		
		private function onResult(e:BarcodeEvent):void
		{
			C.log("type is: ", e.param.type)
			C.log("data is: ", e.param.data);
			
			trace("type is: ", e.param.type)
			trace("data is: ", e.param.data);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		private function createBtn($str:String):MySprite
		{
			var sp:MySprite = new MySprite();
			sp.addEventListener(MouseEvent.MOUSE_OVER,  onOver);
			sp.addEventListener(MouseEvent.MOUSE_OUT,  onOut);
			sp.addEventListener(MouseEvent.CLICK,  onOut);
			sp.bgAlpha = 1;
			sp.bgColor = 0xDFE4FF;
			sp.drawBg();
			sp.width = BTN_WIDTH * DeviceInfo.dpiScaleMultiplier;
			sp.height = BTN_HEIGHT * DeviceInfo.dpiScaleMultiplier;
			
			function onOver(e:MouseEvent):void
			{
				sp.bgAlpha = 1;
				sp.bgColor = 0xFFDB48;
				sp.drawBg();
			}
			
			function onOut(e:MouseEvent):void
			{
				sp.bgAlpha = 1;
				sp.bgColor = 0xDFE4FF;
				sp.drawBg();
			}
			
			var format:TextFormat = new TextFormat("Arimo", 16, 0x666666, null, null, null, null, null, TextFormatAlign.CENTER);
			
			var txt:TextField = new TextField();
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.antiAliasType = AntiAliasType.ADVANCED;
			txt.mouseEnabled = false;
			txt.multiline = true;
			txt.wordWrap = true;
			txt.scaleX = txt.scaleY = DeviceInfo.dpiScaleMultiplier;
			txt.width = sp.width * (1 / DeviceInfo.dpiScaleMultiplier);
			txt.defaultTextFormat = format;
			txt.text = $str;
			
			txt.y = sp.height - txt.height >> 1;
			sp.addChild(txt);
			
			return sp;
		}
	}
	
}