<%-- 
    Document   : urunler
    Created on : 09.Ara.2021, 20:54:49
    Author     : Cüneyt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/panelcss.css" type="text/css">
    <title>Yönetici</title>
</head>
<body>
   <% 
       request.setCharacterEncoding("utf-8");
       HttpSession oturum = request.getSession(), prevPage = request.getSession() ;
       String ad = oturum.getAttribute("Uname").toString(), oncekiSayfa = prevPage.getAttribute("prevPage").toString();
       
    %>
    <div class="bos" > 
        <%
            out.print("<h1>Hoş geldiniz " + ad + "</h1>");
            %>
        <div class="solMenu">
             <form name="frm" method="post" action="">
        
        <input  class="btn" type="submit" value="Geri" name="geri"/>
</form>        
        </div>
</div>
</body>
</html>
