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
      send_ajax(url, 'POST', params)
      $(document).ajaxSuccess(function(event, xhr, settings) {
        alert(xhr.responseText);
    });
  });
});

$(function (){
  $('#new_status').bind('blur', function(){
    var status = $(this).prop('value');
    var ticket_id = $('#select_status').attr('ticket_id');
    if(status.length < 5){
      alert("The length of new status should be longer then 4 and includes only a - z symbols")
    }
    else{
      var params = {status: status };
      var url = "/tickets/".concat(ticket_id, "/change_status");
      send_ajax(url, 'POST', params)
      $(document).ajaxSuccess(function(event, xhr, settings) {
        alert(xhr.responseText);
      });
    }
  });
});

function send_ajax(url, request_type, params){
  $.ajax({
    url: url,
    type: request_type,
    data: params
  });
};
