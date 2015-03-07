$(function (){
  $('#manager_id').bind('change', function(){
  	var user_id = $(this).attr('user_id');
    var ticket_id = $(this).attr('ticket_id');
    $.ajax({
      url: "/tickets/".concat(ticket_id, "/take_responsibility"),
      type: 'POST',
      data: {user_id: user_id, ticket_id: ticket_id }
    });
    $(document).ajaxSuccess(function(event, xhr, settings) {
      alert(xhr.responseText);
    });
  });
});
