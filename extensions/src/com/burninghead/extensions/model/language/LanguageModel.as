package com.burninghead.extensions.model.language
{
	import com.burninghead.birf.messaging.IMessage;
	import com.burninghead.birf.model.BaseModelMsgType;
	import com.burninghead.birf.model.BaseProxyImpl;

	import flash.utils.Dictionary;

	/**
	 * @author BigZoulz
	 */
	public class LanguageModel extends BaseProxyImpl implements ILanguageModel
	{
		private var _strings:Dictionary;
		private var _currentLanguage:String;
		
		override protected function init():void
		{
			_strings = new Dictionary();
			_currentLanguage = LanguageEnum.EN;
		}
		
		private function addString(id:String, lang:String, translation:String):void
		{
			if (_strings[id] != null)
			{
				var obj:Object = _strings[id];
				obj[lang] = translation;
			}
			else
			{
				var obj:Object = { };
				obj[lang] = translation;
				_strings[id] = obj;
			}
		}
		
		override public function dispose():void
		{
		}
		
		override protected function onMessageReceived(msg:IMessage):void
		{
			if (msg.type == LanguageModelMsgType.SET_STRINGS)
			{
				for each (var stringObj:Object in Object(msg.payload).strings)
				{
					addString(stringObj.id, stringObj.lang, stringObj.translation);
				}
				_messenger.sendMessage(BaseModelMsgType.UPDATE);
			}
			
			if (msg.type == LanguageModelMsgType.SET_LANGUAGE)
			{
				_currentLanguage = Object(msg.payload).lang;
				_messenger.sendMessage(BaseModelMsgType.UPDATE);
			}
		}

		public function getString(id:String):String
		{
			return _strings[id][_currentLanguage];
		}

		public function get currentLanguage():String
		{
			return _currentLanguage;
		}
	}
}
