var exec = require('cordova/exec');
var channel = require('cordova/channel');

//channel.waitForInitialization('onCordovaInfoReady');

function Aylien(){
	var me = this;
	// channel.onCordovaReady.subscribe(function(){
	// 	me.suggestHashtags("Test", function(result){
	// 		me.tags = result;
	// 	})
	// 	channel.onCordovaInfoReady.fire();
	// })
}

Aylien.prototype.summarize = function(arg, successCallback){
    exec(successCallback,null, "Aylien", "summarize", [encodeURIComponent(arg)]);
}

Aylien.prototype.hashtags = function(arg, successCallback){
    exec(successCallback,null, "Aylien", "hashtags", [encodeURIComponent(arg)]);
}

module.exports = new Aylien();
