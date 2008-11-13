/* 
Copyright (c) 2008 AOL LLC
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
Neither the name of the AOL LCC nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
*/

package com.aol.api.wim.data
{
    /**
     * This class represents the properties available in all WIM requests. 
     * It is used by some of the transaction classes, which dispatch events 
     * to notify the result of a request.
     */    
    public class ResultData
    {
        /**
         * This represents the type of response generated by the server. 
         */        
        public var statusCode:int       =   0;
        /**
         * This represents a human-readable string to represent the status code. 
         */        
        public var statusText:String    =   null;
        /**
         * This represents extra information generated by the server. 
         */        
        public var statusDetailCode:int       =   0;
        
        /**
         * Creates a new ResultData object. 
         * @param statusCode
         * @param statusText
         * 
         */        
        public function ResultData(statusCode:int=0, statusText:String=null)
        {
            this.statusCode = statusCode;
            this.statusText = statusText;
        }
        
        /**
         * Prints out the ResultData object in a human-readable format 
         * @return 
         * 
         */        
        public function toString():String 
        {
            return "[ResultData:" + 
                   " statusCode=" + statusCode + 
                   " statusText=" + statusText + 
                   "]";
        }

    }
}