
$(document).ready(function(){/* off-canvas sidebar toggle */
	if($( "#checkboxAddTopic" ).length)
	{
		$('#checkboxAddTopic').click(function(){
			if($("#checkboxAddTopic").is(':checked'))
			{
				$('#boxAddTopic').slideDown();
			}else{
				$('#boxAddTopic').slideUp();
			}
		});
		if($("#checkboxAddTopic").is(':checked'))
			{
				$('#boxAddTopic').slideDown();
			}else{
				$('#boxAddTopic').slideUp();
			}
	}
	if($( "#checkboxAddRejestr" ).length)
	{
		$('#checkboxAddRejestr').click(function(){
			if($("#checkboxAddRejestr").is(':checked'))
			{
				$('#boxAddRejestr').slideDown();
			}else{
				$('#boxAddRejestr').slideUp();
			}
		});
		if($("#checkboxAddRejestr").is(':checked'))
			{
				$('#boxAddRejestr').slideDown();
			}else{
				$('#boxAddRejestr').slideUp();
			}
	}
	
	$('#header-show-infos').mouseover(function(){
		var userid = $(this).data('userid');
		/*
		$.ajax({
		  type: "POST",
		  url: 'http://iniserwer.home.pl/wedkarstwows.swedrowski.eu/web/app_dev.php/rest/infos/reset/'+userid,
		  //data: data,
		  success: function(){
		  },
		  dataType: 'text'
		});
		*/
		$.get( 'http://iniserwer.home.pl/wedkarstwows.swedrowski.eu/web/app_dev.php/rest/infos/reset/'+userid, function( data ) {
		  $('#header-show-infos .badge').hide();
		});
	});
});
