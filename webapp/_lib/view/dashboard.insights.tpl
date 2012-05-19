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
            <div style="background-color:white">
            {$i->related_data->post_text}
            </div>
            <br><br>
            {/if}
            
            {if $i->related_data_type eq 'follower_count_history'}
                <br><br>
                <div id="follower_count_history_by_week_{$i->id}"></div>
                
                <script type="text/javascript">
                // Load the Visualization API and the standard charts
                google.load('visualization', '1');
                // Set a callback to run when the Google Visualization API is loaded.
                google.setOnLoadCallback(drawChart{$i->id});
                {literal}
                var formatter = new google.visualization.NumberFormat({fractionDigits: 0});
                var formatter_date = new google.visualization.DateFormat({formatType: 'medium'});
    
                function drawChart{/literal}{$i->id}() {literal}{
                {/literal}
                  var follower_count_history_by_week_data = new google.visualization.DataTable(
                  {$i->related_data.vis_data});
                  formatter.format(follower_count_history_by_week_data, 1);
                  formatter_date.format(follower_count_history_by_week_data, 0);
                {literal}
                  var follower_count_history_by_week_chart = new google.visualization.ChartWrapper({
                  {/literal}
                      containerId: 'follower_count_history_by_week_{$i->id}',
                      {literal}
                      chartType: 'LineChart',
                      dataTable: follower_count_history_by_week_data,
                      options: {
                          width: 325,
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
                  follower_count_history_by_week_chart.draw();
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
