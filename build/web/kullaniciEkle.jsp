<%-- 
    Document   : kullaniciEkle
    Created on : 11.Ara.2021, 10:51:35
    Author     : Cüneyt
--%>

<%@page import="com.envanter.veritabani.UserDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <link rel="stylesheet" href="css/kullaniciekle.css" type="text/css">

    <title>JSP Page</title>
</head>
<body>
   <div class="hizala">
           <div class="solMenu"  >
              
             <form  method="post" action="">
                    <label for="kAdi">Kullanıcı Adı: </label>
                    <input class="urunTxt" type="text" name="kAdi" value="" />
                    <label for="sifre">Şifre: </label>
                    <input class="urunTxt" type="password" name="sifre" value="" />
                    <label for="mail">E-posta: </label>
                    <input class="urunTxt" type="text" name="mail" value="" />
                    <label for="adet">Kullanıcı Tipi: </label>
                    
                    <select name="tip">
                        <option value="admin">Yönetici</option>
                        <option value="staff">Personel</option>
                    </select><br>
                    <input id="btnGeri"  class="btn" type="submit" value="Geri" name="geri"/>
                    <input id="btnEkle" class="btn" type="submit" value="Ekle" name="ekle"/>
                    </div>
                    
                
</form>        
        </div>
<%
    String isim = request.getParameter("kAdi");
    String sifre = request.getParameter("sifre");
    String mail = request.getParameter("mail");
    String hesapTipi = request.getParameter("tip");
    String geri = request.getParameter("geri");
    String ekle = request.getParameter("ekle");
    UserDB us = new UserDB();
    
    HttpSession oturum = request.getSession(true);
    String prevPage = oturum.getAttribute("oncekiSayfa").toString();
    
    
    
    if(ekle != null){
        if(isim.equals("") || sifre.equals("") || mail.equals("") || hesapTipi.equals("")){
        %>
        <p style="color: red; margin-top: 25px; margin-left: 810px">Bütün alanlar doldurulmalıdır!</p>
        
        <%
        
    }
    else{
        us.kullaniciEkle(isim, sifre, mail, hesapTipi);
        out.print("<p style=\"color: green; margin-left: 850px;\"> Kullanıcı Eklendi</p>");
    }
    }
    if(geri != null){
        response.sendRedirect(prevPage);
    }
%>
</body>
</html>
