;(function() {
	var portfolio = angular.module('portfolioApp',[]);
 	var pageContent = { //json object
 		name: "Fannie Mae Application",
 		description: "Demo House",
		address: "New Haven, CT 06520",
		mainImg: "img/house.jpg",
		tabs: ["Plumbing","Electricity","Lawn","Bathrooms","Bedrooms","Roof","A/C","Heating","Windows"],
		imgs: ["img/plumb.jpg","img/electricity.jpg","img/lawn.jpg","img/house.jpg",
				"img/house.jpg","img/house.jpg","img/house.jpg","img/house.jpg","img/house.jpg"]
 	};

 	portfolio.controller('mainController', function(){
 		this.content = pageContent;
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