<%-- 
    Document   : adminAccount
    Created on : 08.Ara.2021, 09:58:00
    Author     : Cüneyt
--%>

<%@page import="com.envanter.javabean.SoldProducts"%>
<%@page import="com.envanter.javabean.Cart"%>
<%@page import="com.envanter.veritabani.UserDB"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.envanter.javabean.User"%>
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
       UserDB us = new UserDB();
       request.setCharacterEncoding("utf-8");
       HttpSession prevPage = request.getSession();
       prevPage.setAttribute("oncekiSayfa", "adminAccount.jsp");
       String ad = "";
       String userName = "";
       Cookie[] ccc = request.getCookies();
       boolean durum = true;
       
       for(Cookie ca: ccc){
           if(ca.getName().contains("durum")){
               if(ca.getValue().contains("false")){
                   //ad =prevPage.getAttribute("Uname").toString();
                   durum = false;
                   break;
               }
           }
           else if(ca.getName().equalsIgnoreCase("username") && ca.getValue().contains("admin")){
                    userName = ca.getValue();
                    
                }
                             
            }
       
if(!durum){
    ad = prevPage.getAttribute("Uname").toString();
}
else{
    ad = userName;
}
    
       
       
       
       
       
    %>
    <div class="bos" > 
        <%
           
            
            out.print("<h1>Hoş geldiniz " + ad + "</h1>");
            
            
            
             
            %>
            <div class="hizala">
                 <div class="solMenu">
             <form name="frm" method="post" action="">
        <input class="btn" type="submit" value="Ürün Ekle" name="urunEkleBtn"/><br>
        <input  class="btn" type="submit" value="Stok Görüntüle" name="stokGetirBtn"/>
        <input  class="btn" type="submit" value="Kullanıcı Ekle" name="hesapEkleBtn"/>
        <input  class="btn" type="submit" value="Çıkış Yap" name="cikis"/>
</form>        
        </div>
                <div class="urunListe">
                    <p>Son Satılanlar</p>
    <table>
        <tr>
            <th>Ürün Kodu</th>         
            <th>Ürün Adı</th>
            <th>Adet</th>
            <th>Fiyat</th>
            <%
                 /*ResultSet satilan = us.urunListele("satilan");
                while(satilan.next()){
                out.print("<tr>");
                out.print("<td>" + satilan.getString("urunKodu") + "</td>");
                out.print("<td>" + satilan.getString("urunAdi") + "</td>");
                out.print("<td>" + satilan.getString("adet") + "</td>");
                out.print("<td>" + satilan.getString("fiyat") + "</td>");
                out.print("</tr>");
                }*/
                 for(SoldProducts sol: UserDB.satilanlarList){
                out.print("<tr>");
                out.print("<td>" + sol.getUrunKodu() + "</td>");
                out.print("<td>" + sol.getUrunAdi() + "</td>");
                out.print("<td>" + sol.getAdet() + "</td>");
                out.print("<td>" + sol.getFiyat() + " TL</td>");
                out.print("</tr>");
                 }
            %>
                
    </table>
</div>
                 <div class="urunListe">
                    <p>Onay Bekleyen Ürünler</p>
    <table>
        <tr>
            <th>Ürün Kodu</th>         
            <th>Ürün Adı</th>
            <th>Adet</th>
            <th>Fiyat</th>
            <th>İşlem</th>
            <%
                ResultSet sepet = us.urunListele("sepet");
                while(sepet.next()){
                out.print("<tr>");
                out.print("<td>" + sepet.getString("urunKodu") + "</td>");
                out.print("<td>" + sepet.getString("urunAdi") + "</td>");
                out.print("<td>" + sepet.getString("adet") + "</td>");
                out.print("<td>" + sepet.getString("fiyat") + " TL</td>");
                %>
            <td><a href="adminAccount.jsp?id=<%= sepet.getString("urunKodu") %>">Listeden Çıkart</a></td>
            <%
                out.print("</tr>");
               }
            %>
                
    </table>
            <form action="" method="post">
                <input class ="onay" type="submit" name="onay" value="Satışı Onayla"></input>
             <input class ="onay" type="submit" name="temizle" value="Listeyi Temizle"></input>
            </form>
</div>
                
            </div>
</div> 
    <%
        String ekle = request.getParameter("urunEkleBtn");
        String stok = request.getParameter("stokGetirBtn");
        String hesap = request.getParameter("hesapEkleBtn");
        String cikis = request.getParameter("cikis");
        String idd = request.getParameter("id");
        String temizle = request.getParameter("temizle");
        String onay = request.getParameter("onay");
        
        Cookie urunKodu = null;
        Cookie urunAdi = null;
        Cookie adet = null;
        Cookie fiyat = null;
        
        
        if(onay != null){
            UserDB.isForSell = true;
             us.satilaniSil();
             us.satilaniBosalt();
             
            for(SoldProducts s: UserDB.satilanlarList){
                us.satisListesineEkle(s.getUrunKodu(), s.getUrunAdi(), s.getAdet(), s.getFiyat());
                
            }
            response.sendRedirect("fatura.jsp");
        }
        
        if(temizle != null){
            UserDB.isRemovedAll = true;
            us.sepetiTemizle("sepet");
            response.sendRedirect("adminAccount.jsp");
        }
        if(idd != null){
            UserDB.isRemovedFromCart = true;
            us.urunSil("sepet", Integer.valueOf(idd));
            response.sendRedirect("adminAccount.jsp"); 
        }
       
        if(ekle != null){
            response.sendRedirect("urunEkle.jsp");
        }
        if(stok != null){
            response.sendRedirect("stok.jsp");
        }
        if(hesap != null){
            response.sendRedirect("kullaniciEkle.jsp");
        }
        if(cikis != null){
            Cookie[] co = request.getCookies();
            for(Cookie c: co){
                if(c.getName().equalsIgnoreCase("username")){
                    c.setMaxAge(0);
                    response.addCookie(c);
                }
                if(c.getName().equalsIgnoreCase("password")){
                    c.setMaxAge(0);
                    response.addCookie(c);
                }
            }
             response.sendRedirect("index.jsp");
           
        }
        
    %>
</body>
</html>