package com.burninghead.birf.utils.net.rpc
{
	import org.osflash.signals.ISignal;
	/**
	 * @author tomas.augustinovic
	 */
	public interface IRPCService
	{
		function addMethodCall(method:String, params:Array = null, callback:Function = null):void;
		function addNotification(method:String, params:Array = null):void;
		function flush():void;
		function abort():void;
		
		//	Getters/setters
		function get complete():ISignal;
	}
}
