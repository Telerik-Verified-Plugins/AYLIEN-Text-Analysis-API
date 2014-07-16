var exec = require('cordova/exec');
var channel = require('cordova/channel');

// channel.waitForInitialization('onCordovaInfoReady');

function Aylien(){
	var me = this;
	// channel.onCordovaReady.subscribe(function(){
	// 	me.suggestHashtags("Test", function(result){
	// 		me.tags = result;
	// 	})
	// 	channel.onCordovaInfoReady.fire();
	// })
}

Aylien.prototype.extract = function(arg, successCallback){
    exec(successCallback,null, "Aylien", "extract", [encodeURIComponent(arg)]);
}

module.exports = new Aylien();
