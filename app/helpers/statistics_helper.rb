module StatisticsHelper
	def render_top10_activista
		first_date = Interaction.first_interaction_date
		last_date = Interaction.last_interaction_date

		html_generated = ""
		html_generated <<
			"<p>Date: <input type=\"text\" id=\"datepicker\" /></p>
			<div id=\"tabela_resultados\"></div>
			  <script type=\"text/javascript\">
			 	$(document).ready(function() {
			    	$( \"#datepicker\" ).datepicker({
			    		 changeMonth: true,
						 changeYear: true,
						 minDate: new Date(#{first_date.year}, #{first_date.month - 1}, #{first_date.day} ), 
						 maxDate: new Date(#{last_date.year}, #{last_date.month - 1}, #{last_date.day} ),
						 showWeek: true,
						 firstDay: 1,
						 onSelect: function(dateText) {
						 	$.ajax({
								type: \"GET\",
								url: \"/activista_summary/top10_activista_by_week\",
								data: { day_of_the_week: dateText },
								dataType: \"json\"
							}).done(function(data) {
								$(\"#tabela_resultados\").html(\"<table class='table_statistics'>\");
								var temp_table;
								var temp_date = Date.parseExact(dateText, \"d/M/yyyy\");

								if(temp_date.is().monday())
									$(\"#tabela_resultados\").append(\"<caption>\" + dateText + \" - \" + temp_date.add(6).days().toString(\"dd/MM/yyyy\") + \"<caption>\");
								else if(temp_date.is().sunday())
									$(\"#tabela_resultados\").append(\"<caption>\" + temp_date.add(-6).days().toString(\"dd/MM/yyyy\") + \" - \" + dateText + \"<caption>\");
								else
									$(\"#tabela_resultados\").append(\"<caption>\" + temp_date.last().monday().toString(\"dd/MM/yyyy\") + \" - \" + temp_date.next().sunday().toString(\"dd/MM/yyyy\") + \"<caption>\");

								temp_table = dateText + \"<tr><td> USER ID </td><td> #Interactions </td><td> Start Time </td><td> End Time </td></tr>\" ;
								
								console.log(data.week_data);
								$.each(data.week_data, function(i, elem){
									temp_table += \"<tr><td>\" + elem[0].toString() + \"</td><td>\" + elem[1].toString() + \"</td><td>\" + elem[2] + \"</td><td>\" + elem[3] + \"</td></tr>\"
								});
								temp_table += \"</table>\";

								$(\"#tabela_resultados\").append(temp_table);
							});
						 },
						 dateFormat: \"dd/mm/yy\"
					});
			  	});
			  </script>"

		return html_generated.html_safe 		  
	end	

end
