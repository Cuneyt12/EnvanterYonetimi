<%-- 
    Document   : urunEkle
    Created on : 09.Ara.2021, 20:53:35
    Author     : Cüneyt
--%>

<%@page import="com.envanter.javabean.Cart"%>
<%@page import="com.envanter.javabean.Products"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.envanter.veritabani.UserDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/urunekle.css" type="text/css">
    <title>Yönetici</title>
</head>
<body>
   <% 
       UserDB us = new UserDB();
       request.setCharacterEncoding("utf-8");
       HttpSession oturum = request.getSession();
       String prevPage = oturum.getAttribute("oncekiSayfa").toString();
       
    %>
   
       
<div class="hizala">
           <div class="solMenu"  >
               <%/*
            out.print("<h1>Hoş geldiniz " + ad + "</h1>");*/
            %>
             <form  method="post" action="">
                    <label for="urunKodu">Ürün Kodu:</label>
                    <input class="urunTxt" type="text" name="urunKodu" value="" />
                    <label for="kategori">Kategori:</label>
                    <input class="urunTxt" type="text" name="kategori" value="" />
                    <label for="urunAdi">Ürün Adı:</label>
                    <input class="urunTxt" type="text" name="urunAdi" value="" />
                    <label for="adet">Adet:</label>
                    <input class="urunTxt" type="text" name="adet" value="" />
                    <label for="alisFiyat">Alış Fiyatı:</label>
                    <input class="urunTxt" type="text" name="alisFiyat" value="" />
                    <label for="satisFiyat">Satış Fiyatı:</label>
                    <input class="urunTxt" type="text" name="satisFiyat" value="" />
                    <div class="btnHiza">
                    <input id="btnGeri"  class="btn" type="submit" value="Geri" name="geri"/>
                    <input id="btnEkle" class="btn" type="submit" value="Ekle" name="ekle"/>
                    </div>
                    
                
</form>  
             
             <%
                 
            String kod = request.getParameter("urunKodu");
            String ek = request.getParameter("ekle");
            String geri = request.getParameter("geri");
            
                  if(geri != null){
                response.sendRedirect(prevPage);
            }
           int result = 0;
            
           String urunKodu = request.getParameter("urunKodu");
           String kategori = request.getParameter("kategori");
           String urunAdi = request.getParameter("urunAdi");
           String adet = request.getParameter("adet");
           String alisFiyat = request.getParameter("alisFiyat");
           String satisFiyat = request.getParameter("satisFiyat");
           
           if(ek != null){
       
               if(urunKodu.equals("") || kategori.equals("") || urunAdi.equals("") ||
                        adet.equals("") || alisFiyat.equals("") || satisFiyat.equals("")){
                  %>
                  <p style="color: red; margin-top: 25px; margin-left: 50px">Bütün alanlar doldurulmalıdır!</p>
             <%  }
               else{
                   
                    us.urunEkle(urunKodu, kategori, urunAdi, adet, alisFiyat, satisFiyat);
                
               }
           }
             %>
        </div>

<div class="urunListe">
    <table>
        <tr>
            <th>Ürün Kodu</th>
            <th>Kategori</th>
            <th>Ürün Adı</th>
            <th>Adet</th>
            <th>Alış Fiyatı</th>
            <th>Satış Fiyati</th>
        </tr>
        <%
            
            Products p = new Products();
            
            
             ResultSet rs = us.urunListele("urunler");
            
            while(rs.next()){
                if (Integer.valueOf(rs.getString("adet")) > 0) {
                        out.print("<tr>");
                out.print("<td>" + rs.getString("urunKodu") + "</td>");
                out.print("<td>" + rs.getString("kategori") + "</td>");
                out.print("<td>" + rs.getString("urunAdi") + "</td>");
                out.print("<td>" + rs.getString("adet") + "</td>");
                out.print("<td>" + rs.getString("alisFiyat") + " TL</td>");
                out.print("<td>" + rs.getString("satisFiyat") + " TL</td>");
                out.print("</tr>");
                  }
            }
       
     %>  
    </table>
</div>
  
</div>  
</body>
</html>
