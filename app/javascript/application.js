// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "semantic-ui" 
import "channels"

window.scroll_bottom = function() {
  if ($('#messages').length > 0) {
    $('#messages').scrollTop($('#messages')[0].scrollHeight);
  }
}

window.submit_message = function() {
  $('#message_body').on('keydown', function(e) {
    if(e.key == "Enter") { 
      $('button').click();
      $('#message_body').val('');
    }
  })
}

window.add_user_label = function(e) {  
  if(e){
    $('#user-container').append('<a class="user-color userid'+e.user.id+' ui '+e.user.color+' label no-pointer" id="'+e.user.id+'" >'+e.user.username+'</a>');
  }    
}

window.remove_user_label = function(e) {  
  if(e){
    $('#'+e).remove();}
  }
    

window.update_user_color = function(e) {  
  if(e){
    $('.user-color.userid'+e.user.id).removeClass(e.last_color).addClass(e.user.color);
  }    
}

$(document).on('turbo:load', function() {
  $('.ui.dropdown').dropdown();
  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  });
  submit_message();
  scroll_bottom();
})