package com.aol.api.wim.transactions.imserv
{
    import com.aol.api.openauth.AuthToken;
    import com.aol.api.wim.Session;
    import com.aol.api.wim.data.IMServMemberResultCode;
    import com.aol.api.wim.data.ResultData;
    import com.aol.api.wim.events.IMServActionEvent;
    import com.aol.api.wim.transactions.Transaction;
    
    import flash.events.Event;

    public class InviteMembersToIMServ extends Transaction
    {
        public function InviteMembersToIMServ(session:Session)
        {
            super(session);
            addEventListener(IMServActionEvent.IMSERV_MEMBERS_INVITING, doInviteMembersToIMServ, false, 0, true);
        }
        
        public function run(imServId:String, memberIds:Array, isOwnershipTransfer:Boolean=false, optionalContext:Object = null):void
        {
            var event:IMServActionEvent = new IMServActionEvent(IMServActionEvent.IMSERV_MEMBERS_INVITING, imServId, memberIds, optionalContext, true, true);
            if(isOwnershipTransfer)
            {
                event.options = { ownershipTransfer : 1 };
            }
            dispatchEvent(event);
        }
        
        protected function doInviteMembersToIMServ(evt:IMServActionEvent):void
        {
            var method:String = "imserv/invite";
            
            //store the event to represent the request data
            var requestId:uint = storeRequest(evt);
            var queryString:String = "";

            var authToken:AuthToken = _session.authToken;
            // Set up params in alphabetical order
            queryString += "a="+authToken.a;
            queryString += "&aimsid="+_session.aimsid;
            queryString += "&f=amf3";
            queryString += "&imserv="+encodeURIComponent(evt.imServId);
            queryString += "&k="+_session.devId;
            if(evt.options && evt.options.ownershipTransfer == 1)
            {
                queryString += "&ownershipTransfer=1";
            }
            queryString += "&r="+requestId;
            for each (var memberId:String in evt.relatedMemberIds) // if the sig param is being listened for, we probably need to alphabetize the values
            {
                queryString += "&t=" + encodeURIComponent(memberId);
            }
            queryString += "&ts=" + getSigningTimestampValue(authToken);
            
            // Append the sig_sha256 data
            queryString += "&sig_sha256="+createSignatureFromQueryString(method, queryString);
            
            _logger.debug("InviteMembersToIMServ: "+queryString);
            sendRequest(_session.apiBaseURL + method + "?"+queryString);
        }
        
        override protected function requestComplete(event:Event):void
        {
            super.requestComplete(event);
            
            _logger.debug("InviteMembersToIMServ response: {0}", _response);
                        
            var statusCode:uint = _response.statusCode;
            var statusText:String = _response.statusText;
            var requestId:uint = _response.requestId;
            //get the old event so we can create the new event
            var oldEvent:IMServActionEvent = getRequest(requestId) as IMServActionEvent;
            var newEvent:IMServActionEvent = new IMServActionEvent(IMServActionEvent.IMSERV_MEMBERS_INVITE_RESULT, oldEvent.imServId, oldEvent.relatedMemberIds, oldEvent.context, true, true);
            // TODO: copy over anything else relevant from the oldEvent
            newEvent.options = oldEvent.options;
            
            var results:Array = [];
            
            if(statusCode == 200) {
                var rawResultCodes:Array = _response.data.results;
                for each(var rawResultCode:Object in rawResultCodes)
                {
                    results.push(new IMServMemberResultCode(rawResultCode.member, rawResultCode.resultCode));
                }
            }
            else
            {
                trace("Error "+statusCode+" in InviteMembersToIMServ!");
            }
            
            newEvent.results = results;
            
            newEvent.resultData = new ResultData(statusCode, statusText);
            
            dispatchEvent(newEvent);
        }
        
    }
}