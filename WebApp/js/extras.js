//extras 

/*this.houses  = null;
		$http.get('houses.json').then(function(res){
			this.houses = res.data;
		});*/
		/*this.houses = (function () {
			var json = null;
			$.ajax({
				'async': false,
				'global': false,
				'url': 'houses.json',
				'dataType': "json",
				'success': function (data) {
					json = data;
				}
			});
			return json;
		})(); */

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
				console.log();
				this.houseJson = tempJson;

			/*$http.get(this.item+'.json').then(function(res){
				this.houseJson = res.data;
			}.bind(this)); //need to bind to refer to this object
			//console.log(this.houseJson);
			*/



				  //"imgs": ["img/plumbing/plumb.jpg","img/electricity/electricity.jpg","img/lawn.jpg","img/bathroom.jpg",
//				"img/bedrooms","img/roof","img/AC/ac.jpg","img/heating/heating.jpg","img/windows/window.jpg"],