// $(function() {
//   $('.fond').hide();  // hide it initially.
//   $(document)
//     .ajaxStart(function() {
//       $('.fond').show(); // show on any Ajax event.
//     })
//     .ajaxStop(function() {
//       $('.fond').hide(); // hide it when it is done.
//   });
// });

//Follow Button Effect

$(document).ready(

	function iniciar(){
	$('.follow').on("click", function(){
		$('.follow').css('background-color','#34CF7A');
		$('.follow').html('<div class="icon-ok"></div> Following');
	});
	}

);
