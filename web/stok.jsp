<%-- 
    Document   : stok
    Created on : 10.Ara.2021, 16:52:29
    Author     : Cüneyt
--%>

<%@page import="com.envanter.javabean.Products"%>
<%@page import="com.envanter.veritabani.UserDB"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="css/stok.css" type="text/css">
    <title>JSP Page</title>
</head>
<body>
<div class="hizala">
<div class="urunListe">
    <form action="" method="post">
        <div>
            <input class="geri" type="submit" value="Geri" name="geri"></input>
        </div>
        <table>
        <tr>
            <th>Ürün Kodu</th>
            <th>Kategori</th>
            <th>Ürün Adı</th>
            <th>Adet</th>
            <th>Alış Fiyatı</th>
            <th>Satış Fiyati</th>
            <th colspan="2">İşlem</th>
        </tr>
        <%
            UserDB us = new UserDB();
            ResultSet satilan = us.urunListele("urunler");
            String ek = request.getParameter("ekle");
            HttpSession oturum = request.getSession();
            String prevPage = oturum.getAttribute("oncekiSayfa").toString();
            
            
           
            while(satilan.next()){
                if(Integer.valueOf(satilan.getString("adet")) > 0){
                         out.print("<tr>");
                out.print("<td>" + satilan.getString("urunKodu") + "</td>");
                out.print("<td>" + satilan.getString("kategori") + "</td>");
                out.print("<td>" + satilan.getString("urunAdi") + "</td>");
                out.print("<td>" + satilan.getString("adet") + "</td>");
                out.print("<td>" + satilan.getString("alisFiyat") + " TL</td>");
                out.print("<td>" + satilan.getString("satisFiyat") + " TL</td>");
                 %>
                 <%
                      
                 %>
                <td><a href="stok.jsp?id=<%= satilan.getString("urunKodu") %>">Satışa Hazırla</a></td>
                <td><a href="stok.jsp?edit=<%= satilan.getString("urunKodu") %>">Düzenle</a></td>
                <%out.print("</tr>");
                }
            }
String guncelle = request.getParameter("edit");
           HttpSession ses = request.getSession(true);
           ses.setAttribute("kod", guncelle);
        String ad = request.getParameter("id");

    if(ad != null){

    UserDB.isAddedToCart = true;
    UserDB.eksilt++;
    us.sepeteEkle(Integer.valueOf(ad));
    response.sendRedirect("stok.jsp");
 }
if(guncelle != null){
response.sendRedirect("update.jsp");
}
String g = request.getParameter("geri");
                    if(g != null){
                        response.sendRedirect(prevPage);
UserDB.isAddedToCart = false;
                    }
        %>
        
    </table> 
   </form>
</div>
</div>
</body>
</html>
