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
 	portfolio.controller('mainController', function($http, $scope, $timeout){
 		this.content = pageContent;
		this.houses = null;
		this.item = "0001";
		this.currHouse = null;
		$http.get('houses.json').then(function(res){
			this.houses = res.data;
			this.currHouse = this.houses.housesContainer[0];
			var storageRefI = firebase.storage().ref(this.currHouse['id']+'/img/');
			var tempI = storageRefI.child("house.jpg");

			tempI.getDownloadURL().then(function(url) {
				console.log(url);
				$("#mainImg").attr("src", url);
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
		}.bind(this)); //need to bind to refer to this object
		
		// Initialize Firebase
        var config = {
            apiKey: "AIzaSyAYOjZx7LghW8XL6nSVeEtO3M66eHdwIQY",
            authDomain: "fanniemae-efcae.firebaseapp.com",
            databaseURL: "https://fanniemae-efcae.firebaseio.com",
            storageBucket: "fanniemae-efcae.appspot.com",
            messagingSenderId: "794391373641"
        };
        firebase.initializeApp(config);

		function changeMainImg(i){
			var storageRefI = firebase.storage().ref(i+'/img/');
			var tempI = storageRefI.child("house.jpg");

			tempI.getDownloadURL().then(function(url) {
				console.log(url);
				$("#mainImg").attr("src", url);
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
			}
		function changeColors(h){
			g = this.houses.status;
			console.log("hello");
			console.log(g);
		}
		
		//test image from PHONE
		var storageRefI2 = firebase.storage().ref();
		var tempI2 = storageRefI2.child("0001/test.jpeg");

		tempI2.getDownloadURL().then(function(url) {
			console.log(url);
			  $("#testMain").attr("src", url+".jpg");
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
		//upload buttons

        //get elements
        var uploader = $("#uploader")[0];
        var fileButton = $("#fileButton")[0];

        //Listen for Files
        fileButton.addEventListener("change", function(e){
            //get file
            var file = e.target.files[0];
            //create storage reference to upload
            var storageRef = firebase.storage().ref('img/'+file.name);
            //upload file
            var task = storageRef.put(file);

            //Update progress bar
            task.on('state_changed', 
                function progress(snapshot){
                    var percentage = 100*snapshot.bytesTransferred / snapshot.totalBytes;
                    uploader.value = percentage;
                },
                function error(err){

                },
                function complete(){
                    alert('Upload Success!');
                }
            );
        });

		this.checkStatus = function(status){
			if(status==1){
				return "tab-good";
			}
			else{
				return "tab-bad";
			}
		}
		this.updateJson = function(){
			// Create a reference to the file we want to download
			//h = this.item;
			console.log(this.item);
			var i = this.houses.id.indexOf(this.item);
			this.currHouse = this.houses['housesContainer'][i];
			changeMainImg(this.item);			
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
})();