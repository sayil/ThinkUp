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

<!--begin attachment data-->
            {if $i->related_data_type eq 'users'}
                 {foreach from=$i->related_data key=uid item=u name=bar}
                  <div class="avatar-container" style="float:left;margin:7px;">
                    <a href="https://twitter.com/intent/user?user_id={$u->user_id}" title="{$u->username} has {$u->follower_count|number_format} followers and {$u->friend_count|number_format} friends"><img src="{$u->avatar}" class="avatar2"/><img src="{$site_root_path}plugins/{$u->network}/assets/img/favicon.png" class="service-icon2"/></a>
                  </div>
                  {/foreach}
                 <br><br><br>
            {/if}

            {if $i->related_data_type eq 'post'}
            <br><br>
      <div class="post">
        {if $i->related_data->post_text}
          {if $scrub_reply_username}
            {if $reply_count && $reply_count > $top_20_post_min}
                <div class="reply_text" id="reply_text-{$smarty.foreach.foo.iteration}">
            {/if} 
            {$i->related_data->post_text|filter_xss|regex_replace:"/^@[a-zA-Z0-9_]+/":""|link_usernames_to_twitter}
            {if $reply_count && $reply_count > $top_20_post_min}</div>{/if}
          {else}
           {if $i->related_data->network == 'google+'}
            {$i->related_data->post_text}
           {else}
            {$i->related_data->post_text|filter_xss|link_usernames_to_twitter}
            {/if}
          {/if}
        {/if}
      {if $i->related_data->link->expanded_url}
        {if $i->related_data->post_text != ''}<br>{/if}
        {if $i->related_data->link->image_src}
         <div class="pic" style="float:left;margin-right:5px;margin-top:5px;"><a href="{$i->related_data->link->expanded_url}"><img src="{$i->related_data->link->image_src}" style="margin-bottom:5px;"/></a></div>
        {/if}
         <span class="small"><a href="{$i->related_data->link->url}" title="{$i->related_data->link->expanded_url}">{if $i->related_data->link->title}{$i->related_data->link->title}{else}{$i->related_data->link->url}{/if}</a>
        {if $i->related_data->link->description}<br><small>{$i->related_data->link->description}</small>{/if}</span>
      {/if}
        
        {if !$post && $i->related_data->in_reply_to_post_id }
          <a href="{$site_root_path}post/?t={$i->related_data->in_reply_to_post_id}&n={$i->related_data->network|urlencode}"><span class="ui-icon ui-icon-arrowthick-1-w" title="reply to..."></span></a>
        {/if}

      <span class="small gray">
        <br clear="all">
       <span class="metaroll">
          <a href="{$site_root_path}post/?t={$i->related_data->post_id}&n={$i->related_data->network|urlencode}">{$i->related_data->adj_pub_date|relative_datetime} ago</a>
          {if $i->related_data->is_geo_encoded < 2}
            {if $show_distance}
                {if $unit eq 'km'}
                  {$i->related_data->reply_retweet_distance|number_format} kms away
                  {else}
                  {$i->related_data->reply_retweet_distance|number_format} miles away in 
                {/if}
            {/if}
           from {$i->related_data->location|truncate:60:' ...'}
          {/if}
          {if $i->related_data->network == 'twitter'}
          <a href="http://twitter.com/intent/tweet?in_reply_to={$i->related_data->post_id}"><span class="ui-icon ui-icon-arrowreturnthick-1-w" title="reply"></a>
          <a href="http://twitter.com/intent/retweet?tweet_id={$i->related_data->post_id}"><span class="ui-icon ui-icon-arrowreturnthick-1-e" title="retweet"></a>
          <a href="http://twitter.com/intent/favorite?tweet_id={$i->related_data->post_id}"><span class="ui-icon ui-icon-star" title="favorite"></a>
          {/if}
       </span><br>&nbsp;
      </span>
 
      </div>

            
            {/if}

            {if $i->related_data_type eq 'follower_count_history'}
                <br><br>
                <div id="follower_count_history_{$i->id}"></div>
                
                <script type="text/javascript">
                // Load the Visualization API and the standard charts
                google.load('visualization', '1.0');
                // Set a callback to run when the Google Visualization API is loaded.
                google.setOnLoadCallback(drawChart{$i->id});
                {literal}
    
                function drawChart{/literal}{$i->id}() {literal}{
                  var formatter_date = new google.visualization.DateFormat({formatType: 'medium'});
                  var formatter = new google.visualization.NumberFormat({fractionDigits: 0});
                  {/literal}
                  var follower_count_history_data_{$i->id} = new google.visualization.DataTable(
                  {$i->related_data.vis_data});
                  formatter.format(follower_count_history_data_{$i->id}, 1);
                  formatter_date.format(follower_count_history_data_{$i->id}, 0);
                {literal}
                  var follower_count_history_chart_{/literal}{$i->id}{literal} = new google.visualization.ChartWrapper({
                  {/literal}
                      containerId: 'follower_count_history_{$i->id}',
                      {literal}
                      chartType: 'LineChart',
                      dataTable: follower_count_history_data_{/literal}{$i->id}{literal},
                      options: {
                          width: 625,
                          height: 250,
                          legend: "none",
                          interpolateNulls: true,
                          pointSize: 2,
                          hAxis: {
                              baselineColor: '#eee',
                              format: 'MMM d',
                              textStyle: { color: '#999' },
                              gridlines: { color: '#eee' }
                          },
                          vAxis: {
                              baselineColor: '#eee',
                              textStyle: { color: '#999' },
                              gridlines: { color: '#eee' }
                          },
                      },
                  });
                  follower_count_history_chart_{/literal}{$i->id}{literal}.draw();
                  }
                  {/literal}
                </script>
                <br><br>
            {/if}
<!--end attachment data-->

           </span>
         </p>
    </div>
  {/foreach}
