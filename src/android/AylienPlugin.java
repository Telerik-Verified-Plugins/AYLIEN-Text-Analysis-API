package com.telerik.aylien;

import java.io.UnsupportedEncodingException;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import org.apache.http.HttpResponse;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.util.EntityUtils;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.DefaultHttpClient;

public class AylienPlugin extends CordovaPlugin {

	private String baseUrl = "https://aylien-text.p.mashape.com/";

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        try {
			this.processCommand(callbackContext, action, args.getString(0));
		} catch (UnsupportedEncodingException e) {
			callbackContext.error(e.getMessage());
			return false;
		}
        return true;
    }

    private void processCommand(final CallbackContext callbackContext, final String method, final String endpoint) throws JSONException, UnsupportedEncodingException {

        int appResId = cordova.getActivity().getResources().getIdentifier("api_key", "string", cordova.getActivity().getPackageName());

        String apiKey = cordova.getActivity().getString(appResId);

        final HttpClient httpclient = new DefaultHttpClient();
	    final HttpPost httppost = new HttpPost(String.format("%s%s?url=%s", this.baseUrl, method, endpoint));

	    httppost.addHeader("Content-Type", "application/json");
	    httppost.addHeader("X-Mashape-Authorization", apiKey);

        cordova.getThreadPool().execute(new Runnable() {
			@Override
			public void run() {
			        try {
			          HttpResponse res = httpclient.execute(httppost);
			          HttpEntity httpEntity = res.getEntity();
			          JSONObject response = new JSONObject(EntityUtils.toString(httpEntity));
			          callbackContext.success(response);
			       	} catch (Exception e) {
			        	callbackContext.error(e.getMessage());
			        }
			}
		});
    }
}
