<%-- 
    Document   : fatura
    Created on : 16.Ara.2021, 14:37:48
    Author     : Cüneyt
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="com.envanter.veritabani.UserDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/fatura.css" type="text/css">
    <title>JSP Page</title>
</head>
<body>
<div class="urunListe">
    
    <table>
        <tr>
            <th>Ürün Kodu</th>
            <th>Ürün Adı</th>
            <th>Ürün Adedi</th>
            <th>Ürün Fiyatı</th>
        </tr>
    <%
        HttpSession oturum = request.getSession();
       String prevPage = oturum.getAttribute("oncekiSayfa").toString();
        
        int toplamFiyat = 0;
        UserDB db = new UserDB();
        ResultSet rs = db.urunListele("satilan");
        String geri = request.getParameter("geri");
        while(rs.next()){
            out.print("<tr>");
                out.print("<td>" + rs.getString("urunKodu") + "</td>");
                out.print("<td>" + rs.getString("urunAdi") + "</td>");
                out.print("<td>" + rs.getString("adet") + "</td>");
                out.print("<td>" + rs.getString("fiyat") + " TL </td>");
                toplamFiyat += Integer.valueOf(rs.getString("fiyat"));
        }
        
if(geri != null){
    response.sendRedirect(prevPage);
}
%>
    </table> 
    <p>Toplam Fiyat: <%= toplamFiyat%> TL</p>
    <form action="" method="post">
        <input class="onay" type="submit" name="geri" value="Geri"></input>
    </form>
</div>
</body>
</html>
