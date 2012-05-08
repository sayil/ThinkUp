<h1>Insights (alpha)</h1>

  {assign var='cur_date' value=''}
  {foreach from=$insights key=tid item=i name=foo}
    {if $cur_date neq $i->date}
    <br>
        {$i->date|relative_day}
        {assign var='cur_date' value=$i->date}
    {/if}
         <div class="alert {if $i->emphasis eq '2'}urgent{else}helpful{/if}">
         <p>
           <span class="ui-icon ui-icon-check" style="float: left; margin:.3em 0.3em 0 0;"></span>
            {$i->text}

<!--begin attachment data-->
            {if $i->related_data|is_a:'array'}
                {if $i->related_data[0]|is_a:'User'}
                 {foreach from=$i->related_data key=uid item=u name=bar}
                  <div class="avatar-container" style="float:left;margin:7px;">
                    <a href="https://twitter.com/intent/user?user_id={$u->user_id}" title="{$u->username} has {$u->follower_count|number_format} followers and {$u->friend_count|number_format} friends"><img src="{$u->avatar}" class="avatar2"/><img src="{$site_root_path}plugins/{$u->network}/assets/img/favicon.png" class="service-icon2"/></a>
                  </div>
                 {/foreach}
                 <br><br><br>
                {/if}
            {/if}
            
            {if $i->related_data|is_a:'Post' && isset($i->related_data->post_text)}
            <br><br>
            <div style="background-color:white">
            {$i->related_data->post_text}
            </div>
            <br><br>
            {/if}
            
<!--end attachment data-->

           </span>
         </p>
    </div>
  {/foreach}
