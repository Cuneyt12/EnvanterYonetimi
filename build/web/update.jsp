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
        <link rel="stylesheet" href="css/update.css" type="text/css">
    <title>Yönetici</title>
</head>
<body>
   <% 
       UserDB us = new UserDB();
       request.setCharacterEncoding("utf-8");
       HttpSession oturum = request.getSession();
       String ad = oturum.getAttribute("kod").toString();
       
       
    %>
   
       
<div class="hizala">
           <div class="solMenu"  >
              
             <form  method="post" action="">
                    <label for="urunKodu">Ürün Kodu:</label>
                    <input class="urunTxt" type="text" name="urunKodu" value="<%=ad%>"/>
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
                    <input id="btnEkle" class="btn" type="submit" value="Güncelle" name="guncelle"/>
                    
                    </div>
                    
                    <%
                 
            
            String guncelle = request.getParameter("guncelle");
            String geri = request.getParameter("geri");
            
                  if(geri != null){
                response.sendRedirect("stok.jsp");
            }
           int result = 0;
            
           String urunKodu = request.getParameter("urunKodu");
           String kategori = request.getParameter("kategori");
           String urunAdi = request.getParameter("urunAdi");
           String adet = request.getParameter("adet");
           String alisFiyat = request.getParameter("alisFiyat");
           String satisFiyat = request.getParameter("satisFiyat");
           
           if(guncelle != null){
       
               if(urunKodu.equals("") || kategori.equals("") || urunAdi.equals("") ||
                        adet.equals("") || alisFiyat.equals("") || satisFiyat.equals("")){
                  %>
                  <p style="color: red; margin-top: 25px; margin-left: 50px;">Bütün alanlar doldurulmalıdır!</p>
             <%
               
         }
               else{
        us.urunGuncelle(Integer.valueOf(urunKodu), kategori, urunAdi, Integer.valueOf(adet), Integer.valueOf(alisFiyat), Integer.valueOf(satisFiyat));
                
               }
%>
            <p style="color: green; margin-top: 25px; margin-left: 120px;">Ürün Güncellendi</p>
                  <%
           }
             %> 
              
</form>  
             
            
        </div>

<p style="margin-top: 275px; color: red; margin-left: -40px;">*Ürün kodu güncellenmez</p>
  
</div>  
</body>
</html>
