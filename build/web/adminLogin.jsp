<%-- 
    Document   : adminLogin
    Created on : 08.Ara.2021, 09:54:43
    Author     : Cüneyt
--%>

<%@page import="com.envanter.javabean.User"%>
<%@page import="com.envanter.veritabani.UserDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <link rel="stylesheet" href="css/style.css" type="text/css">
    <title>Yönetici Girişi</title>
</head>
<body>
    <header>Envanter Yönetim Sistemi <br>
    Yönetici Girişi
    </header>
    
    <div class="kullanici">
        <form action=""  method="POST">
            <input class="txtbox" type="text" name="adminName" value="" placeholder="Kullanıcı Adı" />
            <input class="txtbox" type="password" name="adminPass" value="" placeholder="Şifre" /><br>
            <input class="loginBtn"  type="submit" value="Giriş" name="adminLoginBtn" /><br>
                <%
        String isim = request.getParameter("adminName");
        String sifre = request.getParameter("adminPass");
        UserDB user = new UserDB();
        
        HttpSession oturum = request.getSession(true);
        oturum.setAttribute("Uname", isim);
  
            
        if (isim != null && sifre != null) {
                if (user.hesapKontrol(isim, sifre)) {
                    response.sendRedirect("adminAccount.jsp");
                   %>
                   
              <%      }
else{
                out.println("Yanlış");

            }
                
            }
            

    %>
        </form>
    </div>
<footer>©2021</footer>

</body>
</html>
