package com.sist.dao;
import java.util.*;
import java.sql.*;

public class ZipcodeDAO {

	// 연결도구 Connection (Socket) 
		private Connection conn;
		// 입출력 => inputStream, outputStream
		private PreparedStatement ps;
		//URL 주소
		private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
		
		//드라이버 등록 => 한번수행 => 생성자
		public ZipcodeDAO()
		{
			try
			{
				Class.forName("oracle.jdbc.driver.OracleDriver");
				
				
			}catch(Exception ex) 
			{
				// 드라이버 연결 문제시 해결
				ex.printStackTrace();
				
			}
			
		}
		
		
		//연결 - 클래스화시키기! -> jar파일로! 라이브러리화!-> Database는  보지 못하게 노출이 안되도록 만들어야한다.-> but,developesql는 누구나 볼수있다.ip만 바꾸면 가능!
		
		public void getConnection()
		{
			try
			{
				//id,pwd넘기기
			conn=DriverManager.getConnection(URL,"hr", "happy");
			//conn hr/happy
			  
				
			}catch(Exception ex){}
		}
		
		
		//해제 
		public void disConnection()
		{
			
			try
			{	
				if(ps!=null) ps.close();
				if(conn!=null) conn.close();
				
			}catch(Exception ex) {}
			
		}
		
	
		public ArrayList<ZipcodeVO> postFind(String dong)
		{
			ArrayList<ZipcodeVO> list= new ArrayList<ZipcodeVO>();
			
			try {
				
				
				getConnection(); 
				String sql="SELECT zipcode,sido,gugun,dong, NVL(bunji,' ') "   // NULL값을 포함하는 컬럼이 있기때문에 *을 사용하는 것보다 각각 불어와 NVL처리해줌
							+ "FROM zipcode "
							+ "WHERE dong LIKE '%'||?||'%'";   //while문으로 받는게 좋음 여러개 들어오니까
					
				ps=conn.prepareStatement(sql);
				ps.setString(1, dong);   // dong = ?값 // 입력받는값
				
				ResultSet rs= ps.executeQuery();
				
				while(rs.next())
				{
				
					ZipcodeVO vo=new ZipcodeVO();
					vo.setZipcode(rs.getString(1));
					vo.setSido(rs.getString(2));
					vo.setGugun(rs.getString(3));
					vo.setDong(rs.getString(4));
					vo.setBunji(rs.getString(5));
					
					list.add(vo);
				}
				rs.close();
				
				
			}catch(Exception ex) 
			{
				
				ex.printStackTrace();
				
			}finally
			{
				
				disConnection();
				
			}
			
			
			return list;
			
		}
	
	
}
