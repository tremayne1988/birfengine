package com.burninghead.extensions.messaging.handlers
{
	import com.burninghead.birf.messaging.IMessage;
	import com.burninghead.birf.messaging.IMessageHandler;
	import com.jacksondunstan.signals.Signal1;
	/**
	 * @author tomas.augustinovic
	 */
	public class TurboSignalMessageHandler implements IMessageHandler
	{
		private var _listener:Signal1;
		
		public function TurboSignalMessageHandler()
		{
			_listener = new Signal1();
		}
		
		public function send(msg:IMessage):void
		{
			_listener.dispatch(msg);
		}

		public function addListener(listener:*):void
		{
			_listener.addSlot(listener);
		}

		public function removeListener(listener:*):void
		{
			_listener.removeSlot(listener);
		}

		public function clearListeners():void
		{
			_listener.removeAllSlots();
		}
	}
}
