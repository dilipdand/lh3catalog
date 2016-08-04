// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap.min
//= require_tree .



$('#filter_products').submit(function() {  
    var valuesToSubmit = $(this).serialize();

    $.ajax({
        type: "GET",
        url: "/filter_products.js", //sumbits it to the given url of the form
		format: 'js', 
		cache: false,
        data: valuesToSubmit,
        dataType: "script" // you want a difference between normal and ajax-calls, and json is standard
    }).success(function(data){
        console.log("success" + data);
    });
    return false; // prevents normal behaviour
});

 function resetFilters() {	
  $('#filters').prop('checked', false);
  $('#filters').find('label').removeClass('active');
  $('#filters').find('input:hidden').val([]);
  alert($('#filters').find('input:hidden').value);
  $("#categories_ids").val("");
  $("#related-products").html("");
  };

