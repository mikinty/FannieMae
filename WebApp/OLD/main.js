;(function(){
    var fm = angular.module('fmApp',[]);
    var pageContent = {
        //json object
        info: "This is a demo house.",
        address: "New Haven, CT 06520"
    };
    fm.controller('mainController', function(){
        this.content = pageContent;
    });
    fm.controller('secController', function(){
        this.sec = 0; //default is nothing is open
        this.selectSec = function(setSec){
            this.sec = setSec;
        }
        this.isSelected = function(checkSec){
            return this.sec==checkSec;
        }
    });
});