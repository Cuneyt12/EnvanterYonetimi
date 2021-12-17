<%-- 
    Document   : staffLogin
    Created on : 08.Ara.2021, 10:02:53
    Author     : Cüneyt
--%>

<%@page import="com.envanter.veritabani.UserDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/style.css" type="text/css">
    <title>Personel Girişi</title>
</head>
<body>
    <header>Envanter Yönetim Sistemi <br>
    Personel Girişi
    </header>
    <div class="kullanici">
        <form action="staffAccount.jsp" method="POST">
            <input class="txtbox" type="text" name="staffName" value="" placeholder="Kullanıcı Adı" />
            <input class="txtbox" type="password" name="staffPass" value="" placeholder="Şifre" /><br>
            <input class="loginBtn"  type="submit" value="Giriş" name="staffLoginBtn" />
        </form>
    </div>
<footer>©2021</footer>
 
</body>
</html>
