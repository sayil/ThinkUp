<h1>Insights (alpha)</h1>

{assign var='cur_date' value=''}
{foreach from=$insights key=tid item=i name=foo}
    {if $cur_date neq $i->date}
        <h2>{$i->date|relative_day}</h2>
        {assign var='cur_date' value=$i->date}
    {/if}
    <div class="alert {if $i->emphasis eq '2'}urgent{else}helpful{/if}">
        <p>
            <span class="ui-icon ui-icon-check" style="float: left; margin:.3em 0.3em 0 0;"></span>
            {$i->text}

<!--begin {$i->related_data_type} attachment data-->
            {if $i->related_data_type eq 'users'}
                {include file="_insights.users.tpl"}
            {elseif $i->related_data_type eq 'post'}
                {include file="_insights.post.tpl"}
            {elseif $i->related_data_type eq 'follower_count_history'}
                {include file="_insights.follower_count_history.tpl"}
            {/if}
<!--end {$i->related_data_type} attachment data-->

           </span>
         </p>
    </div>
  {/foreach}
