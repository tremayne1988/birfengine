package com.burninghead.birf.states
{
	import flash.utils.Dictionary;
	/**
	 * @author tomas.augustinovic
	 */
	public class BaseStateMachine implements IStateMachine
	{
		private var _states:Dictionary;
		protected var _transitions:Dictionary;
		private var _currentState:IState;
		
		public function BaseStateMachine()
		{
			_states = new Dictionary();
			_transitions = new Dictionary();
			_currentState = null;
		}

		public function changeState(id:Object):void
		{
			//	Exit old state (if available).
			if (_currentState)
			{
				_currentState.exit();
			}
			
			//	Set the new state.
			_currentState = _states[id] as IState;
			
			//	Enter the new state.
			if (_currentState)
			{
				_currentState.enter();
			}
			else
			{
				throw new Error("The target transition state is not valid.");
			}
		}

		public function registerState(id:Object, state:IState):void
		{
			if (id != null && state != null)
			{
				state.transition.add(onStateTransition);
				_states[id] = state;
			}
		}
		
		public function unregisterState(id:Object):void
		{
			_states[id] = null;
		}
		
		public function registerTransition(id:Object, transition:IStateTransition):void
		{
			if (id != null && transition != null)
			{
				_transitions[id] = transition;
			}
		}

		public function unregisterTransition(id:Object):void
		{
			_transitions[id] = null;
		}
		
		protected function onStateTransition(state:IState, transitionId:Object):void
		{
			var transition:IStateTransition = _transitions[transitionId] as IStateTransition;
			
			if (transition.fromStateId == state)
			{
				changeState(transition.toStateId);
			}
		}

		public function update():void
		{
			for each (var state:IState in _states)
			{
				state.update();
			}
		}
	}
}