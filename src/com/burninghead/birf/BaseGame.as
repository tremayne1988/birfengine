package com.burninghead.birf
{
	import com.burninghead.birf.controller.BaseController;
	import com.burninghead.birf.controller.IController;
	import com.burninghead.birf.errors.AbstractMethodError;
	import com.burninghead.birf.messaging.BaseMessageHandler;
	import com.burninghead.birf.messaging.IMessageHandler;
	import com.burninghead.birf.model.BaseModel;
	import com.burninghead.birf.model.IModel;
	import com.burninghead.birf.view.IView;

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * [Abstract]
	 * Base class for a Burning Head game.
	 * 
	 * @author tomas.augustinovic
	 */
	public dynamic class BaseGame extends MovieClip
	{
		private var _view:IView;
		private var _model:IModel;
		private var _controller:IController;
		private var _messageHandler:IMessageHandler;
		
		/**
		 * Listen for the ADDED_TO_STAGE event if the game is not running stand-alone. Initialize
		 * the MVC paradigm.
		 */
		public function BaseGame()
		{
			if (stage)
			{
				onGameAddedToStage(null);
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, onGameAddedToStage);
			}
		}
		
		/**
		 * ADDED_TO_STAGE event handler. Initializes the MVC.
		 * @param event
		 */
		private function onGameAddedToStage(event:Event):void
		{
			if (hasEventListener(Event.ADDED_TO_STAGE))
			{
				removeEventListener(Event.ADDED_TO_STAGE, onGameAddedToStage);
			}

			init();
			
			initializeMVC();
		}
		
		/**
		 * Called when the game is ADDED_TO_STAGE before the MVC is initialized.
		 */
		protected function init():void
		{
			//	No-op
		}
		
		/**
		 * Initializes the MVC paradigm and registers all the game parts (commands, mediators, modelparts).
		 * Afterwards, initializes the view.
		 */
		private function initializeMVC():void
		{
			//	Create MVC.
			_messageHandler = createMessageHandler();
			_model = createModel();
			_view = createView();
			_controller = createController();
			
			//	Register everything.
			registerCommands();
			registerMediators();
			registerModelParts();

			//	Initialize view.
			_view.initialized.addOnce(onViewInitialized);
			_view.init(this);
		}
		
		/**
		 * Registers all the game commands.
		 */
		protected function registerCommands():void
		{
			//	No-op
		}
		
		/**
		 * Registers all the game mediators.
		 */
		protected function registerMediators():void
		{
			//	No-op
		}
		
		/**
		 * Registers all the game modelparts.
		 */
		protected function registerModelParts():void
		{
			//	No-op
		}

		/**
		 * Signal handler for when the view is initialized.
		 */
		protected function onViewInitialized():void
		{
		}
		
		/**
		 * Factory method for creating a instance of the game controller.
		 * @return IController
		 */
		protected function createController():IController
		{
			return new BaseController(view, model, messageHandler);
		}
		
		/**
		 * [Abstract] Return the injection class for the view.
		 * @return Class
		 */
		protected function createView():IView
		{
			throw new AbstractMethodError();
		}
		
		/**
		 * Return the injection class for the model.
		 * @return Class
		 */
		protected function createModel():IModel
		{
			return new BaseModel(messageHandler);
		}
		
		/**
		 * Return the injection class for the message handler.
		 * @return Class
		 */
		protected function createMessageHandler():IMessageHandler
		{
			return new BaseMessageHandler();
		}
		
		/**
		 * Get instance of the controller.
		 * @return IController
		 */
		public function get controller():IController
		{
			return _controller;
		}
		
		/**
		 * Get instance of the view.
		 * @return IView
		 */
		public function get view():IView
		{
			return _view;
		}
		
		/**
		 * Get instance of the model.
		 * @return IModel
		 */
		public function get model():IModel
		{
			return _model;
		}
		
		/**
		 * Get instance of the message handler.
		 * @return IMessageHandler
		 */
		public function get messageHandler():IMessageHandler
		{
			return _messageHandler;
		}
	}
}
