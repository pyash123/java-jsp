<%@page import = "java.sql.*" %>
<%@page import = "java.util.*" %>
<%@page import = "javax.mail.*" %>
<%@page import = "javax.mail.internet.*" %>
<%@page import = "javax.activation.*" %>

<html>

	<head>
		<style>
			* {font-size:50px ; font-family:Cambria;}
			body{background-color:rgb(155  ,142 , 162);}
	
		</style>
		<title>NewsLetter</title>
		
	</head>
	<body>
	<center>
		<h1>NewsLetter</h1>

		<form>
			<input type = "email"  placeholder = "enter ur email"  name = "email" />
			<br/><br/>
			<input type = "submit"  name = "btnSub" value = "Sub" class = "btn" />
			<input type = "submit"  name = "btnUnSub" value = "UnSub" class = "btn" />
			
		</form>

		<% 
			if(request.getParameter("btnSub") != null )
			{
			String email = request.getParameter("email");
			
		
			try
			{
	DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());

	//get connection
	String url = "jdbc:mysql://localhost:3306/newsletter_6jan23";
	String username = "root";
	String password = "abc456";
	Connection con = DriverManager.getConnection(url , username , password);
	

	String sql = "insert into subs values(?)";
	PreparedStatement pst = con.prepareStatement(sql);	
	pst.setString(1 , email);
	pst.executeUpdate();
	out.println(" thank u for subscription");
	
	Properties p = System.getProperties();
	p.put("mail.smtp.host" , "smtp.gmail.com");
	p.put("mail.smtp.port" , 587);
	p.put("mail.smtp.auth" , true);
	p.put("mail.smtp.starttls.enable" , true);
	

	Session ms = Session.getInstance(p ,new Authenticator(){
	public PasswordAuthentication getPasswordAuthentication(){
		String un = "tester.parag.6jan23@gmail.com";
		String pw = "ikhbbzfqxawiqneg";
		return new PasswordAuthentication(un , pw);
	}
});
	
	try{
	MimeMessage msg = new MimeMessage(ms);
	String subject = "Msg from Kamal Class";
	msg.setSubject(subject);
	String txt = "Congrats for ur subs";
	msg.setText(txt);
	msg.setFrom(new InternetAddress("tester.parag.6jan23@gmail.com"));
	msg.addRecipient(Message.RecipientType.TO , new InternetAddress(email));
	Transport.send(msg);
	

}
	catch(Exception er)
	{
	out.println("issue ->" + er);

	
	}

	con.close();
	}
	


	
	catch(SQLException se)
	{
	out.println("issue " + se + "u have already subs");
	}
}
	else if(request.getParameter("btnUnSub") != null )
	{
	String email = request.getParameter("email");
			

			try
			{
	DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());

	//get connection
	String url = "jdbc:mysql://localhost:3306/newsletter_6jan23";
	String username = "root";
	String password = "abc456";
	Connection con = DriverManager.getConnection(url , username , password);
	

	String sql = "delete from subs where email = ?";
	PreparedStatement pst = con.prepareStatement(sql);	
	pst.setString(1 , email);
	long ans = pst.executeUpdate();
	if(ans == 1)
		{
		out.println(" ok u have been unsubs ");
	
		Properties p = System.getProperties();
	p.put("mail.smtp.host" , "smtp.gmail.com");
	p.put("mail.smtp.port" , 587);
	p.put("mail.smtp.auth" , true);
	p.put("mail.smtp.starttls.enable" , true);
	

	Session ms = Session.getInstance(p ,new Authenticator(){
	public PasswordAuthentication getPasswordAuthentication(){
		String un = "tester.parag.6jan23@gmail.com";
		String pw = "ikhbbzfqxawiqneg";
		return new PasswordAuthentication(un , pw);
	}
});
	
	try{
	MimeMessage msg = new MimeMessage(ms);
	String subject = "Msg from Kamal Class";
	msg.setSubject(subject);
	String txt = "Sorry for  ur subs";
	msg.setText(txt);
	msg.setFrom(new InternetAddress("tester.parag.6jan23@gmail.com"));
	msg.addRecipient(Message.RecipientType.TO , new InternetAddress(email));
	Transport.send(msg);
	

}
	catch(Exception er)
	{
	out.println("issue ->" + er);

	
	}
	}
		else 
		out.println("u have not yet subs");
		 con.close();
	}
	


	
	catch(SQLException se)
	{
	out.println("issue " + se + "u have already subs");
	}
}
	
	


	
	
		%>
		</center>
		</body>
		</html>
			