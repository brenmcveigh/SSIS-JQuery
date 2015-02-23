<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
 
  
    <script  src="jquery-2.1.3.min.js"  " type="text/javascript"></script>
 
<% if (false) { %>

 
  <script type="text/javascript" src="jquery-2.1.3-vsdoc2.js"></script>

 
<% } %>


    <script type="text/javascript">
       
        function callSSISPackage(elem) {

            var btnid = $(elem).attr("id");

            var imgid = $(elem).parent().prev();
           
            var imgcld = imgid.children("img");

            $(elem).prop("disabled", true);


            showProgress(null, imgcld );

            $.post("Default.aspx?Callback=EntryList", /*pass in id of button package*/
                     {buttonId: btnid },
                     function (data) {

                         showProgress(true,  imgcld);
                          
                         changeStatus(data, imgcld, elem);
                     })             
             };


        function showProgress(hide, imgid) {

            $(imgid).attr("src", "Images/loader.gif");
             
            if (hide)
                imgid.hide();
            else
                imgid.show();
        }

        function changeStatus(Imgstatus, imgchg, elem) {



        if (Imgstatus.toString().indexOf("Failure") !== -1)
         {
             
            imgchg.attr("src", "Images/delete-icon.png");
            imgchg.show();
            alert(Imgstatus);
        }
        else if (Imgstatus.toString().indexOf("Success:") !== -1) {
            imgchg.attr("src", "Images/accepted.png");
            imgchg.show();
        }
        $(elem).prop("disabled", false);

        }
</script>

<head runat="server">
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<link href="StyleSheet.css" rel="stylesheet" type="text/css" />


    <title></title>
 
</head>
<body>
    <form id="form1" runat="server">


    <div >
    <div style="float:left; width:25%" ><br /></div>
    <div style="float:left; width:50%">
     <div id="headerlayout">
     <table style="width: 100%;  height: 100%; background-color: rgb(0, 0, 0);">
     <tbody >
<tr>
<td style="padding-top: 20px; padding-bottom: 0px; padding-left: 20px;">
<span style="font-size: 24pt;"><strong>
<span style="font-family: arial,helvetica,sans-serif;">
<span style="color: rgb(245, 130, 30);">INTEGRATION SERVICES </span>
<span style="color: rgb(255, 255, 255);"></span> </span></strong></span></td>
<td></td>
<td style="padding-top: 10px; padding-bottom: 0px; text-align:right " rowspan="2"   >

 </td>
</tr>
<tr>
<td style="padding-top: 5px; padding-bottom: 5px; padding-left: 20px;">
<span class="CmCaReT" style="display: none;"></span>
<span class="CmCaReT" style="display: none;"></span>
</td>
</tr>
</tbody></table> 

</div>
     <div ID="mainlayout" style="margin-bottom: 6%;" runat="server">
     <table width = "100%" border = "1" >
     <thead><tr><td></td></tr></thead>
     <tbody id="buttonbody" runat="server" >
   
     </tbody>
       
         </table>
     </div>
     <div id="footerlayout">


 
<div class="footerSE"  >
<div class="footerSE_content">
<div class="address_nav">
<p style="text-align: left;"><span>Integration Sevices</span>&nbsp;</p>
<br>
 
</div>
</div>
<div class="footerSE_bottom">&nbsp;</div>
 


<p>
<span style="color: rgb(0, 0, 0);">

</span></p>
</div>
     </div>
     </div>
     <div style="width:35%; float:right"></div>
    </div>
    
    </form>
</body>
</html>
