package  
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author umhr
	 */
	public class Canvas extends Sprite 
	{
		private var _getLocalAddressByUDP:GetLocalAddressByUDP = new GetLocalAddressByUDP();
		private var _textField:TextField = new TextField();
		public function Canvas() 
		{
			init();
		}
		private function init():void 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			_textField.width = _textField.height = 400;
			addChild(_textField);
			
			byNetworkInfo();
			
			byUDP();
		}
		
		private function byNetworkInfo():void {
			var localAddressList:Array/*String*/ = GetLocalAddressByNetworkInfo.localAddressList;
			_textField.appendText("Reads "+ localAddressList.length +" IP(s) from the NetworkInfo.\n");
			_textField.appendText(localAddressList.join(",") + "\n");
			_textField.appendText("============================\n");
		}
		
		
		private function byUDP():void {
			_getLocalAddressByUDP.addEventListener(Event.COMPLETE, getLocalAddressByUDP_complete);
			_getLocalAddressByUDP.addEventListener(IOErrorEvent.IO_ERROR, getLocalAddressByUDP_ioError);
			_getLocalAddressByUDP.start();
		}
		
		private function getLocalAddressByUDP_complete(e:Event):void 
		{
			_textField.appendText("Reads a IP from the DatagramSocket.\n");
			_textField.appendText(_getLocalAddressByUDP.localAddress);
		}
		
		private function getLocalAddressByUDP_ioError(e:IOErrorEvent):void 
		{
			_textField.appendText("Can't reads a IP from the DatagramSocket.");
		}
	}
	
}