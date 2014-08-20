package  
{
	import flash.net.InterfaceAddress;
	import flash.net.IPVersion;
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;
	/**
	 * ...
	 * @author umhr
	 */
	public class GetLocalAddressByNetworkInfo 
	{
		
		public function GetLocalAddressByNetworkInfo() 
		{
			
		}
		
		/**
		 * NetworkInfoから取得できるipアドレスを取得し、IPV4でブロードキャストアドレスを持つモノのみを返します。
		 * VirtualBoxなどを使っていると、複数のアドレスを返す場合があります。
		 * NetworkInfoをサポートしていない場合は、空の配列を返します。
		 */
		static public function get localAddressList():Array/*String*/ {
			if (!NetworkInfo.isSupported) {
				return [];
			}
            var addressList:Array/*String*/ = [];
            var networkInfo:NetworkInfo = NetworkInfo.networkInfo;
            var networkInterfaceList:Vector.<NetworkInterface> = networkInfo.findInterfaces();
            
            for each (var networkInterface:NetworkInterface  in networkInterfaceList)
            {
				if (networkInterface.active) {
					for each (var interfaceAddress:InterfaceAddress in networkInterface.addresses)
					{
						if (interfaceAddress.ipVersion == IPVersion.IPV4 && interfaceAddress.broadcast) {
							addressList.push(interfaceAddress.address);
						}
					}
                }
            }
			addressList.sort();
            return addressList;
		}
		
	}

}