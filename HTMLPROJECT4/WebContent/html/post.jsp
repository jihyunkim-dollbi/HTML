<%@page import="com.sist.dao.ZipcodeDAO"%>
<%@page import="com.sist.dao.ZipcodeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.sist.dao.*, java.util.*"%>

<!-- 
    		주소데이터베이스를 가져오기 위해 post.jsp 파일을 만듬.
    
    
    		<table id="table_content"> css 속성 table_content를 가져와
    			 CSS의 ID가 TABLE_CONTENT. 
    			 테이블의 디자인 담당.
    			 
    			 CSS에 다양한 selector!!다양한 속성!!
    			 
    			 4개의 버튼에 각각 맞는 액션을 주기위해.. 구분이 필요함
    			 
    			 window.open("post.jsp","postfind","width=350,height=400,scrollbars=yes");
    	
    			 : hover?가상 선택자?
    			 
    			 <a href="javasctip:ok   </a>
    			 클릭했을때  선택한 우편번호 주소를 뿌리기
    			 
    			
    			 
     -->
<!--  자바로 name=dong 값을 받기 
String dong=request.getParameter("dong"); 인코딩해서 보내고
request.setCharacterEncoding("UTF-8"); 디코딩해서 받는다
	
 -->
<%

//https://www.google.com/search?q=JAVA&oq=JAVA&aqs=chrome..69i57j69i59j35i39l2j0l4.1258j0j8&sourceid=chrome&ie=UTF-8

	try
	{
		request.setCharacterEncoding("UTF-8");
		
	}catch(Exception ex) {}

	String dong=request.getParameter("dong");

	//System.out.println(dong);
	
	ArrayList<ZipcodeVO> list=null;
	if(dong!=null)
	{
		ZipcodeDAO dao=new ZipcodeDAO();
		list=dao.postFind(dong);

	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="table.css">

<script type="text/javascript">

 
function send(){

 var dong=document.frm.dong.value;
	if(dong=="")
	{
		document.frm.dong.focus();
		return;
	}
	
	document.frm.submit(); // 데이터전송

}

// 출력
function ok(zip,addr){
	
	opener.frm.post.value=zip;
	opener.frm.addr1.value=addr;
	self.close();
	
}

</script>

</head>
<body>
	<center>
		<h3>우편번호 검색</h3>
		<table id="table_content" width=420>
			<tr>
				<td width=15% class="tdright">입력</td>
				<td>
					<form mothod=post action="post.jsp" name=frm>
					<input type=text name=dong size=15> 		
			<input type="button" value="검색" onclick="send()">
				</form>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="tdcenter"><sup><font color="red">※동/읍/면을입력하세요※</font></sup></td>
			</tr>
		</table>

		<%
				
				if(list!=null)
				{
				%>


		<table id="table_content" width=420>
			<tr>

				<th  width=25%>우편번호</th>
				<th width=75%>주소</th>


			</tr>
		
			<%
			 for(ZipcodeVO vo:list)
			 {
			%>
			<tr class="dataTr">	
			<td width=25% align=center><%= vo.getZipcode()%>
			</td>
			<td width=75% align=left><a href="javascript:ok('<%= vo.getZipcode()%>','<%= vo.getAddress()%>')"><%= vo.getAddress()%></a>
			</td>
		</tr>
		<%  
			}
		%>
		</table>
		<%
			}
		%>
	</center>
</body>
</html>