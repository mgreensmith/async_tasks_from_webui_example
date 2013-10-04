$( document ).ready(function() {
  var es = new EventSource('/stream');
  es.addEventListener('status_event', function(e) {
    $('#status_messages').append(e.data + '\\n')
  }, false);
});

$('#btn_run').click(function () {
  $.post('/run');
});

