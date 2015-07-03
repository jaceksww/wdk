<?php

use Symfony\Component\Routing\RouteCollection;
use Symfony\Component\Routing\Route;

$collection = new RouteCollection();


$collection->add('wmws_homepage', new Route('/hello/{name}', array(
    '_controller' => 'WMWSBundle:Default:index',
)));
$collection->add('wmws_default_dictionaries', new Route('/rest/default/dictionaries/{userid}', array(
    '_controller' => 'WMWSBundle:Default:dictionaries',
)));
$collection->add('wmws_forums_index', new Route('/rest/forums/index', array(
    '_controller' => 'WMWSBundle:Forum:index',
)));
$collection->add('wmws_forums_index', new Route('/rest/forums/index/{catId}', array(
    '_controller' => 'WMWSBundle:Forum:index',
)));
$collection->add('wmws_forums', new Route('/rest/forums/topics/{forumId}', array(
    '_controller' => 'WMWSBundle:Forum:topics',
)));
$collection->add('wmws_forums_posts', new Route('/rest/forums/posts/{topicId}', array(
    '_controller' => 'WMWSBundle:Forum:posts',
)));
$collection->add('wmws_forums_addpost', new Route('/rest/forums/addpost', array(
    '_controller' => 'WMWSBundle:Forum:addpost',
)));
$collection->add('wmws_forums_addtopic', new Route('/rest/forums/addtopic', array(
    '_controller' => 'WMWSBundle:Forum:addtopic',
)));


$collection->add('wmws_ws', new Route('/rest/ws/index/{type}/{start}/{limit}/{userid}', array(
    '_controller' => 'WMWSBundle:Ws:index',
    'limit' => 20,
    'start'=>0,
    'userid'=>0
)));

$collection->add('wmws_ws_subjects', new Route('/rest/ws/subjects', array(
    '_controller' => 'WMWSBundle:Ws:Subjects',
)));
$collection->add('wmws_ws_subjects2', new Route('/rest/ws/subjects2', array(
    '_controller' => 'WMWSBundle:Ws:Subjects2',
)));
$collection->add('wmws_ws_wsusergalleries', new Route('/rest/ws/usergalleries/{userid}', array(
    '_controller' => 'WMWSBundle:Ws:Usergalleries',
)));
$collection->add('wmws_ws_addgallery', new Route('/rest/ws/addgallery', array(
    '_controller' => 'WMWSBundle:Ws:Addgallery',
)));
$collection->add('wmws_ws_addgalleryimage', new Route('/rest/ws/addgalleryimage', array(
    '_controller' => 'WMWSBundle:Ws:Addgalleryimage',
)));

$collection->add('wmws_ws_addcomment', new Route('/rest/ws/addcomment', array(
    '_controller' => 'WMWSBundle:Ws:Addcomment',
)));
//rejestr
$collection->add('wmws_ws_addregisterfishery', new Route('/rest/ws/addregisterfishery', array(
    '_controller' => 'WMWSBundle:Ws:Addregisterfishery',
)));

$collection->add('wmws_ws_addwww', new Route('/rest/ws/addwww', array(
    '_controller' => 'WMWSBundle:Ws:Addwww',
)));
$collection->add('wmws_ws_view', new Route('/rest/ws/getwww/{wwwid}/{comments}', array(
    '_controller' => 'WMWSBundle:Ws:getwww',
    'comments' => 1
)));


$collection->add('wmws_pages', new Route('/rest/pages/{parentid}', array(
    '_controller' => 'WMWSBundle:Pages:index',
)));
$collection->add('wmws_pages_view', new Route('/rest/pages/view/{pageid}', array(
    '_controller' => 'WMWSBundle:Pages:view',
)));

$collection->add('wmws_liveboxes', new Route('/rest/liveboxes/{weekstart}/{numberofdays}', array(
    '_controller' => 'WMWSBundle:Liveboxes:index',
)));

$collection->add('wmws_users', new Route('/rest/users', array(
    '_controller' => 'WMWSBundle:Users:index',
)));
$collection->add('wmws_users_avatar', new Route('/rest/users/avatar', array(
    '_controller' => 'WMWSBundle:Users:avatar',
)));
$collection->add('wmws_users_login', new Route('/rest/users/login/{email}/{password}', array(
    '_controller' => 'WMWSBundle:Users:login',
)));
$collection->add('wmws_users_register', new Route('/rest/users/register', array(
    '_controller' => 'WMWSBundle:Users:register',
)));

$collection->add('wmws_infos_index', new Route('/rest/infos/{userid}/{start}/{limit}', array(
    '_controller' => 'WMWSBundle:Infos:index',
    'limit' => 20,
    'start' => 0
)));

//messages
$collection->add('wmws_messages_inbox', new Route('/rest/messages/inbox/{userid}/{start}/{limit}', array(
    '_controller' => 'WMWSBundle:Messages:inbox',
    'limit' => 20,
    'start' => 0
)));
$collection->add('wmws_messages_outbox', new Route('/rest/messages/outbox/{userid}/{start}/{limit}', array(
    '_controller' => 'WMWSBundle:Messages:outbox',
    'limit' => 20,
    'start' => 0
)));
$collection->add('wmws_messages_view', new Route('/rest/messages/view/{messageid}', array(
    '_controller' => 'WMWSBundle:Messages:view'
)));
$collection->add('wmws_messages_add', new Route('/rest/messages/add', array(
    '_controller' => 'WMWSBundle:Messages:add'
)));

return $collection;
