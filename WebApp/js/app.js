;(function() {
	var portfolio = angular.module('portfolioApp',[]);
 	var pageContent = { //json object
 		name: "Fannie Mae Application",
 		description: "Demo House",
		address: "New Haven, CT 06520",
		mainImg: "img/house.jpg",
		tabs: ["Plumbing","Electricity","Lawn","Bathrooms","Bedrooms","Roof","A/C","Heating","Windows"],
		imgs: ["img/plumb.jpg","img/electricity.jpg","img/lawn.jpg","img/house.jpg",
				"img/house.jpg","img/house.jpg","img/house.jpg","img/house.jpg","img/house.jpg"],
		status: [1,1,1,0,0,1,0,1,0]
 	};
	/*var houses = {
		"houses": ["0001","0002","0003","0004","0005"]
	};*/
	/*ar houseObject = {
		"id": "0001",
		"name": "Demo House",
		"address": "New Haven, CT 06520"
	};*/
 	portfolio.controller('mainController', function($http, $scope){
 		this.content = pageContent;
		
		this.houses = null;
		$http.get('houses.json').then(function(res){
			this.houses = res.data;
		}.bind(this)); //need to bind to refer to this object
		this.houseJson = null;
		$http.get('0001.json').then(function(res){
			this.houseJson = res.data;
		}.bind(this)); //need to bind to refer to this object
		this.checkStatus = function(status){
			if(status==1){
				return "tab-good";
			}
			else{
				return "tab-bad";
			}
		}
		this.updateJson = function(h){
			/*$http.get(this.item+'.json').then(function(res){
				this.houseJson = res.data;
			}.bind(this)); //need to bind to refer to this object
			//console.log(this.houseJson);
			*/
			// Create a reference to the file we want to download
			var tempJson = storageRef.child(h+'/');

			// Get the download URL
			tempJson.getDownloadURL().then(function(url) {
			// Insert url into an <img> tag to "download"
			}).catch(function(error) {
			switch (error.code) {
				case 'storage/object_not_found':
				// File doesn't exist
				break;

				case 'storage/unauthorized':
				// User doesn't have permission to access the object
				break;

				case 'storage/canceled':
				// User canceled the upload
				break;

				case 'storage/unknown':
				// Unknown error occurred, inspect the server response
				break;
			}
			});
			console.log(tempJson);
			this.houseJson = tempJson;
		}
 	});
 	portfolio.controller('tabController', function(){
 		this.tab = 1;
 		this.selectTab = function(setTab){
 			this.tab = setTab;
 		}
 		this.isSelected = function(checkTab){
 			return this.tab==checkTab;
 		}
 	});	
})();//class="navigation container" 