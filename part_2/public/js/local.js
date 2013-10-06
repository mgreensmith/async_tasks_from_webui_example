$( document ).ready(function() {
  var es = new EventSource('/stream');
  es.addEventListener('status_event', function(e) {
    $('#status_messages').append(e.data + "\n")
  }, false);

  es.addEventListener('state_change_event', function(e) {
    set_ui_state(e.data);
  }, false);

  es.addEventListener('completion_percent_event', function(e) {
    $( "#progressbar" ).progressbar( "value", parseInt(e.data) );
  }, false);

});

$('#btn_run').click(function () {
  $.post('/run');
});

function set_ui_state(state) {
  switch (state) {
    case "running":
      $('#btn_run').prop("disabled", true);
      $("#status_messages").html("");
      break;
    case "idle":
      $('#btn_run').prop("disabled", false);
      break;
  }
}