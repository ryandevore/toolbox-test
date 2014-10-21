<?php

handleRequest();

function handleRequest()
{
    $method = $_SERVER['REQUEST_METHOD'];
    if ('GET' == $method)
        handleGetRequest();
    else if ('PUT' == $method)
        handlePutRequest();
    else if ('POST' == $method)
        handlePostRequest();
    else if ('HEAD' == $method)
        handleHeadRequest();
    else if ('DELETE' == $method)
        handleDeleteRequest();
    else
        handleUnknownRequest();
}
    
function getResponseContentType()
{
    $contentType = 'text/plain';
    
    if (isset($_GET['contentType']))
    {
        $contentType = $_GET['contentType'];
    }
    
    return $contentType;
}
    
function setContentTypeHeader($contentType)
{
    header("Content-type: $contentType");
}
    
function getForcedHttpReturnCode()
{
    $returnCode = 200;
    
    if (isset($_GET['returnCode']))
    {
        $returnCode = $_GET['returnCode'];
    }
    
    return $returnCode;
}
    
function setHttpReturnCode($code)
{
    http_response_code($code);
}
    
    
function handleGetRequest()
{
    $contentType = getResponseContentType();
    setContentTypeHeader($contentType);
    
    $httpCode = getForcedHttpReturnCode();
    setHttpReturnCode($httpCode);
    
    if ($httpCode != 200)
    {
        die();
    }
    
    $args = $_GET;
    
    $response = new stdClass();
    $response->code = 100;
    $response->message = 'Everything is awesome';
    
    $json = json_encode($response);
    echo $json;
}
    
function handlePutRequest()
{
    
}

function handlePostRequest()
{
    
}

function handleHeadRequest()
{
    
}

function handleDeleteRequest()
{
    
}
    
function handleUnknownRequest()
{
    die('Unknown request method');
}
    


?>