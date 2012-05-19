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

      
