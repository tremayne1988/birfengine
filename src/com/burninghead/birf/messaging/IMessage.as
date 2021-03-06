package com.burninghead.birf.messaging
{
	/**
	 * @author tomas.augustinovic
	 */
	public interface IMessage
	{
		/**
		 * Return the string type identifier of the message.
		 * @return String
		 */
		function get type():String;
		/**
		 * Return reference to the sender of the message.
		 * @return *
		 */
		function get sender():*;
		/**
		 * Return the payload object holding message specific information.
		 * @return *
		 */
		function get payload():*;
	}
}
