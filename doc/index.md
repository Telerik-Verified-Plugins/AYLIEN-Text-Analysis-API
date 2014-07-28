<!---
    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.
-->

# com.aylien.text

This plugin exracts structured information and insights from text. Based on [AYLIEN Text Analysis API](http://aylien.com/text-api), it performs Summarization and Hashtag Suggestion for any piece of text (more features to be added soon).

The plugin defines a global `aylien` object, which defines various operations that are used for data extraction.

Although the object is in the global scope, it is not available until after the `deviceready` event.

    document.addEventListener("deviceready", onDeviceReady, false);
    function onDeviceReady() {
        console.log(device.cordova);
    }

## Installation

You need a Text Analysis API key for using this plugin, which you can obtain by subscribing to the API on [Mashape](https://www.mashape.com/aylien/text-analysis). Once you have your API key, you can install the plugin as below:

    cordova plugin add url —variable API_KEY="YOUR_API_KEY"

## Methods

- aylien.summarize
- aylien.hashtags


# aylien.summarize

Summarization is used to summarize long articles by extracting a small number of key sentences.

## Example

    aylien.summarize("http://www.bbc.com/sport/0/football/25912393", function(result){
        alert("Sentences:" + result.sentences);
    });


# aylien.hashtags

Using our automatic hashtag suggestion system, you can get a list of highly-relevant hashtags that will help you get more exposure for your content on Social Media.

## Example

    aylien.hashtags("http://www.bbc.com/sport/0/football/25912393", function(result){
        alert("Hash:" + result.hashtags);
    });

## Supported Platforms

- iOS

## Resources

For more information, please refer to the [Text Analysis API documentation](http://aylien.com/text-api-doc) on AYLIEN.
