import consumer from "channels/consumer"

consumer.subscriptions.create("UserChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (window.location.pathname === '/' && data.online_toggle) {
      if(data.user.online){
        remove_user_label(data.user.id);
        add_user_label(data);
      }        
      else
        remove_user_label(data.user.id);
    }
    else if (window.location.pathname === '/' && data.color_toggle)
      update_user_color(data);  
  }
});
