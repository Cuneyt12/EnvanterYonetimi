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
                    <label for="ad">Kullanıcı Adı: </label>
                    <input class="urunTxt" type="text" name="ad" value="" />
                    <label for="yeniSifre">Yeni Şifre: </label>
                    <input class="urunTxt" type="password" name="yeniSifre" value="" />
                    <label for="yeniSifreOnay">Yeni Şifre Onay: </label>
                    <input class="urunTxt" type="password" name="yeniSifreOnay" value="" />
                    <input style="margin-left: 170px;" id="btnEkle" class="btn" type="submit" value="Değiştir" name="degistir"/>
                    </div>
                    
                
</form>        
        </div>
<%
    String ad = request.getParameter("ad");
    String sifre = request.getParameter("yeniSifre");
    String sifreOnay = request.getParameter("yeniSifreOnay");
    
    String degistir = request.getParameter("degistir");
    UserDB us = new UserDB();
    
    if(degistir != null){
        if(sifre.equals("") || sifreOnay.equals("")){  
        out.print("tüm alanların doldurulması gerekmektedir..");
        }
        else{
            if(sifre.equals(sifreOnay)){
                us.sifreGuncelle(sifre, ad);
                response.sendRedirect("adminAccount.jsp");
            }
            else{
                out.print("<p style=\"color: red; margin-left: 850px;\"> Şifreler eşleşmedi! Tekrar giriniz.</p>");
            }
        }
    
    }
    
%>
</body>
</html>
