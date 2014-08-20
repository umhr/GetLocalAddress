package  
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.DatagramSocket;
	/**
	 * ...
	 * @author umhr
	 */
	public class GetLocalAddressByUDP extends EventDispatcher
	{
		private var _datagramSocket:DatagramSocket = new DatagramSocket();
		private var _localAddress:String = "";
		public function GetLocalAddressByUDP() 
		{
			
		}
		public function start():void {
			_datagramSocket.addEventListener(IOErrorEvent.IO_ERROR, datagramSocket_ioError);
			_datagramSocket.addEventListener(Event.ACTIVATE, datagramSocket_activate);
			try
			{
				_datagramSocket.connect("192.168.254.254", 50000 );
			}
			catch ( e:Error )
			{
				trace( e );
			}
		}
		
		private function datagramSocket_ioError(e:IOErrorEvent):void 
		{
			dispatchEvent(e);
			close();
		}
		
		private function datagramSocket_activate(e:Event):void 
		{
			_localAddress = _datagramSocket.localAddress;
			close();
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get localAddress():String {
			return _localAddress;
		}
		
		private function close():void {
			_datagramSocket.removeEventListener(IOErrorEvent.IO_ERROR, datagramSocket_ioError);
			_datagramSocket.removeEventListener(Event.ACTIVATE, datagramSocket_activate);
			_datagramSocket.close();
			_datagramSocket = null;
		}
		
	}

}