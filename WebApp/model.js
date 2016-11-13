;(function(){
  var mod = angular.module("MyApp", ["pathgather.popeye"]);

  mod.controller("myCtrl", function($scope, Popeye) {

  $scope.openUserProfile = function(userId) {

      // Open a modal to show the selected user profile
      var modal = Popeye.openModal({
        templateUrl: "my_modal_template.html",
        controller: "myModalCtrl as ctrl",
        resolve: {
          user: function($http) {
            return $http.get("/users/" + userId);
          }
        }
      });

      // Show a spinner while modal is resolving dependencies
      $scope.showLoading = true;
      modal.resolved.then(function() {
        $scope.showLoading = false;
      });

      // Update user after modal is closed
      modal.closed.then(function() {
        $scope.updateUser();
      });
    };

  });

  app.controller('ModalController', function($scope, close) {
    
  $scope.close = function(result) {
    close(result, 500); // close, but give 500ms for bootstrap to animate
  };

  });
})();