$(function() {
  $('.fond').hide();  // hide it initially.
  $(document)
    .ajaxStart(function() {
      $('.fond').show(); // show on any Ajax event.
    })
    .ajaxStop(function() {
      $('.fond').hide(); // hide it when it is done.
  });
});
