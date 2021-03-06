package com.aol.api.wim
{
    import com.aol.api.logging.ILog;
    import com.aol.api.net.MockURLLoader;
    import com.aol.api.openauth.MockClientLogin;
    
    import flash.display.DisplayObjectContainer;

    /**
     * <p>This slightly modifies the <code>Session</code> object to support a mock server.</p>
     * 
     * @author rizwan
     * 
     */
    public class MockSession extends Session
    {
        public function MockSession(stageOrContainer:DisplayObjectContainer, developerKey:String, clientName:String=null, clientVersion:String=null, logger:ILog=null, wimBaseURL:String=null, authBaseURL:String=null)
        {
            super(stageOrContainer, developerKey, clientName, clientVersion, logger, wimBaseURL, authBaseURL);

            _authClass = MockClientLogin;
            _loaderClass = MockURLLoader;
            _fetchRequestTimeoutMs = 7000;
        }
        
        public function runFetchEventsNow():void {
            if(this._fetchDelayTimer && this._fetchDelayTimer.running) {
                this._fetchDelayTimer.stop();
            }
            this.fetchEvents(null);
        }
        
        public function set autoFetchEvents(b:Boolean):void {
            super._autoFetchEvents = b;
        }
        
        public function get autoFetchEvents():Boolean {
            return super._autoFetchEvents;
        }
    }
}