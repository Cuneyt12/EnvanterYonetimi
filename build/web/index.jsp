<%-- 
    Document   : index
    Created on : 07.Ara.2021, 14:38:50
    Author     : Cüneyt
    Community  : Türk Yazılımcıları Türkçe Kaynak Hazırlama Topluluğu  
--%>

<%@page import="com.envanter.javabean.Products"%>
<%@page import="com.envanter.veritabani.UserDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <title>Envanter Yönetim Sistemi</title>
</head>
<body>
   
    <form action="" method="post">
  <h1>Giriş Yap</h1>
  <div class="inset">
  <p>
    <label for="ad">Kullanıcı Adı</label>
    <input type="text" name="ad" id="ad">
  </p>
  <p>
    <label for="sifre">Şifre</label>
    <input type="password" name="sifre" id="sifre">
  </p>
 
  <p>
    <input type="checkbox" name="remember" id="remember">
    <label for="remember">Beni Hatırla</label>
  </p>
  </div>
  <p class="p-container">
      <span><a href="hesapOlustur.jsp"></span>
    <input type="submit" name="go" id="go" value="Giriş">
  </p>
  
   
    <%
        String isim = request.getParameter("ad");
        String sifre = request.getParameter("sifre");
        String giris = request.getParameter("go");
        HttpSession oturum = request.getSession(true);
        
        UserDB user = new UserDB();
        boolean remember = request.getParameter("remember") != null;
        Cookie ckUsername = null;
        Cookie ckPassword = null;
        Cookie durum = null;
        String passWord = "";
        String userName = "";
        
        if(!remember){
            
        }
        else{
            
        }
        
        HttpSession prevPage = request.getSession(true);
      
        
        if(isim != null && sifre != null && giris != null){
                  ckUsername = new Cookie("username", isim);
                  ckPassword = new Cookie("password", sifre);
                  durum = new Cookie("durum", "false");
                  
             }
              
        
         Cookie[] allCookies = request.getCookies();
         if (allCookies != null) {
                 for(Cookie cook: allCookies){
                     if(cook.getName().equalsIgnoreCase("username")){
                         userName = cook.getValue();
                     }
                     else if(cook.getName().equalsIgnoreCase("password")){
                         passWord = cook.getValue();
                     }
                     
                 }
             }
         
         if(allCookies != null){
             for(int i = 0; i < allCookies.length; i++){
                 System.out.println(allCookies[i].getValue());
             if(allCookies[i].getValue().contains(user.hesapKontrol(userName, passWord))){
                      response.sendRedirect(request.getContextPath() + "/adminAccount.jsp");
                      break;
                  }
             else{
                 System.out.println("bulunamadi");
             }
         }
         }
           
             if (isim != null && sifre != null) {
                if (user.hesapKontrol(isim, sifre).equals("admin")) {
                    if(UserDB.isFirstLogin){
                        response.sendRedirect("yeniSifre.jsp");
                        UserDB.isFirstLogin = false;
                    }
                    else{
                        if(remember){
                         ckUsername.setMaxAge(300);
                         response.addCookie(ckUsername);
                         ckPassword.setMaxAge(300);
                         response.addCookie(ckPassword);
                         durum.setMaxAge(0);
                         response.addCookie(durum);
        }else{          
                            durum.setMaxAge(300);
                         response.addCookie(durum);
                            oturum.setAttribute("Uname", isim);
                        }
                        
                         
                         
                        prevPage.setAttribute("oncekiSayfa", "adminAccount.jsp");
                        response.sendRedirect("adminAccount.jsp");
                    }
                   }
                else if (user.hesapKontrol(isim, sifre).equals("staff")) {
                         ckUsername.setMaxAge(-1);
                         response.addCookie(ckUsername);
                         ckPassword.setMaxAge(-1);
                         response.addCookie(ckPassword);
                    prevPage.setAttribute("oncekiSayfa", "staffAccount.jsp");
                    response.sendRedirect("staffAccount.jsp");
                   }       
else{
                out.println("\t Bilgiler yanlış");

            }
                
            }
      %>

</form>

</body>
</html>