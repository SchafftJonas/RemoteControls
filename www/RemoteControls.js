//
// RemoteControls.js
// Remote Control Cordova Plugin

// remoteControls created by Seth Hillinger on 2/21/14.
// Copyright 2013 Seth Hillinger. All rights reserved.

// updateMetas created by François LASSERRE on 12/05/13.
// Copyright 2013 François LASSERRE. All rights reserved.
// MIT Licensed
//


//------------------------------------------------------------------------------
// object that we're exporting
//------------------------------------------------------------------------------

module.exports = {
  updateMetas: function(success, fail, params) {
    cordova.exec(success, fail, 'RemoteControls', 'updateMetas', params);
    },
    
    receiveRemoteEvent:function(event) {
    var ev = document.createEvent('HTMLEvents');
    ev.remoteEvent = event;
    ev.initEvent('remote-event', true, true, arguments);
    document.dispatchEvent(ev);
    }
    
};

