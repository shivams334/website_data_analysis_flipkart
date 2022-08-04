select 
	website_session_id,
	max(products_pages) as product_made_it,
    	max(mr_fuzzy_pages) as mr_fuzzy_made_it,
    	max(cart_pages) as cart_made_it
from (
select 
	website_sessions.website_session_id, 
    	website_pageviews.pageview_url, 
    	website_pageviews.created_at as pageview_created_at,
    	case when website_pageviews.pageview_url = '/products' then 1 else 0 end as products_pages,
    	case when website_pageviews.pageview_url = '/the-original-mr-fuzzy' then 1 else 0 end as mr_fuzzy_pages,
    	case when website_pageviews.pageview_url = '/cart' then 1 else 0 end as cart_pages
from website_sessions
left join website_pageviews
on website_sessions.website_session_id = website_pageviews.website_session_id
where website_sessions.created_at between '2014-01-01' and '2014-02-01'
and website_pageviews.pageview_url in ('/lander-2','/products','/the-original-mr-fuzzy','/cart')
order by website_sessions.website_session_id, website_pageviews.created_at
) as pageview_level

group by website_session_id;

