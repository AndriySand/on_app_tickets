$(function (){
  $('#manager_id, #select_status').bind('change', function(){
  	var user_id = $(this).attr('user_id');
    var ticket_id = $(this).attr('ticket_id');
    var status = $("#select_status option:selected").text();
      if(user_id == undefined){
        var params = {status: status };
        var url = "/tickets/".concat(ticket_id, "/change_status");
      }
      else{
        var params = {user_id: user_id, ticket_id: ticket_id };
        var url = "/tickets/".concat(ticket_id, "/take_responsibility");
      }
      $.ajax({
        url: url,
        type: 'POST',
        data: params
      });
      $(document).ajaxSuccess(function(event, xhr, settings) {
        alert(xhr.responseText);
    });
  });
});
