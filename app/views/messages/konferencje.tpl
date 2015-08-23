<h1>{if $smarty.session.lang=='en'}CONFERENCES{else}KONFERENCJE{/if}</h1>
	{section name=i loop=$rows}
	    <div class="konf">
        	<a class="title" href="/{if $smarty.session.lang=='en'}conferences{else}konferencje{/if}/{$rows[i].id}-{if $smarty.session.lang=='en' && $rows[i].nazwa_en != ''}{$rows[i].nazwa_en}{else}{$rows[i].nazwa}{/if}">{if $smarty.session.lang=='en' && !empty($rows[i].nazwa_en)}{$rows[i].nazwa_en}{else}{$rows[i].nazwa}{/if}</a>
    		<p>{if $smarty.session.lang=='en' && !empty($rows[i].opis_en)}{$rows[i].opis_en}{else}{$rows[i].opis}{/if}</p>
            <p class="details">{if $smarty.session.lang=='en' && !empty($rows[i].miejsce_en)}{$rows[i].miejsce_en}{else}{$rows[i].miejsce}{/if}, {$rows[i].termin} | {$rows[i].kategoria}<a class="more" href="/{if $smarty.session.lang=='en'}conferences{else}konferencje{/if}/{$rows[i].id}-{if $smarty.session.lang=='en' && $rows[i].nazwa_en != ''}{$rows[i].nazwa_en}{else}{$rows[i].nazwa}{/if}">{if $smarty.session.lang=='en'}more{else}więcej{/if} &raquo;</a></p> 
        </div>
	{/section}
    
 <p class="back"><a href="">&laquo; {if $smarty.session.lang=='en'}back{else}powrót{/if}</a></p>