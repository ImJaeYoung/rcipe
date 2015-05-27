
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<!-- id searchBoard에 전체검색,제목,작성자 0,1,2식으로 저장-->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Recipe</title>
<link rel="stylesheet"
  href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<style type="text/css">
.form-login {
  background-color: #DDDDDD;
  padding-top: 10px;
  padding-bottom: 20px;
  padding-left: 20px;
  padding-right: 20px;
  border-radius: 15px;
  border-color: #d2d2d2;
  border-width: 5px;
  box-shadow: 0 1px 0 #cfcfcf;
}

.panel.with-nav-tabs .panel-heading {
  padding: 5px 5px 0 5px;
}

.panel.with-nav-tabs .nav-tabs {
  border-bottom: none;
}

.panel.with-nav-tabs .nav-justified {
  margin-bottom: -1px;
}

.with-nav-tabs.panel-success .nav-tabs>li>a, .with-nav-tabs.panel-success .nav-tabs>li>a:hover,
  .with-nav-tabs.panel-success .nav-tabs>li>a:focus {
  color: #3c763d;
}

.with-nav-tabs.panel-success .nav-tabs>.open>a, .with-nav-tabs.panel-success .nav-tabs>.open>a:hover,
  .with-nav-tabs.panel-success .nav-tabs>.open>a:focus, .with-nav-tabs.panel-success .nav-tabs>li>a:hover,
  .with-nav-tabs.panel-success .nav-tabs>li>a:focus {
  color: #3c763d;
  background-color: #d6e9c6;
  border-color: transparent;
}

.with-nav-tabs.panel-success .nav-tabs>li.active>a, .with-nav-tabs.panel-success .nav-tabs>li.active>a:hover,
  .with-nav-tabs.panel-success .nav-tabs>li.active>a:focus {
  color: #3c763d;
  background-color: #fff;
  border-color: #d6e9c6;
  border-bottom-color: transparent;
}

.with-nav-tabs.panel-success .nav-tabs>li.dropdown .dropdown-menu {
  background-color: #dff0d8;
  border-color: #d6e9c6;
}

.with-nav-tabs.panel-success .nav-tabs>li.dropdown .dropdown-menu>li>a {
  color: #3c763d;
}

.with-nav-tabs.panel-success .nav-tabs>li.dropdown .dropdown-menu>li>a:hover,
  .with-nav-tabs.panel-success .nav-tabs>li.dropdown .dropdown-menu>li>a:focus
  {
  background-color: #d6e9c6;
}

.with-nav-tabs.panel-success .nav-tabs>li.dropdown .dropdown-menu>.active>a,
  .with-nav-tabs.panel-success .nav-tabs>li.dropdown .dropdown-menu>.active>a:hover,
  .with-nav-tabs.panel-success .nav-tabs>li.dropdown .dropdown-menu>.active>a:focus
  {
  color: #fff;
  background-color: #3c763d;
}

.select-style {
  border: 1px solid #ccc;
  width: 70px;
  height: 34px;
  border-radius: 3px;
  overflow: hidden;
  background: #fafafa url("img/icon-select.png") no-repeat 90% 50%;
}

.select-style select {
  padding: 5px 8px;
  width: 100%;
  border: none;
  box-shadow: none;
  background: transparent;
  background-image: none;
  -webkit-appearance: none;
}

.select-style select:focus {
  outline: none;
}
</style>
</head>
<script>
$("document").ready(function(){
	
	  $('li > a').click(function() {
	      $('li').removeClass();
	      $(this).parent().addClass('active');
	  });
	  
	  $('#selectList').change(function(){
		  var e = document.getElementById("selectList");
		  selectListNum = e.options[e.selectedIndex].value;
		  flag = 'Y';
		  // alert('selectListNum : '+selectListNum+' currentCategory : '+currentCategory);
		  funcTab(currentCategory);
	  });
	  
});

var currentCategory;
var selectListNum;
var flag = 'N';

  window.funcFlag = function(f){
	  flag = f;
  }

   window.funcTab = function (category) {
	   
	  currentCategory = category;
	  
	  if(typeof selectListNum === 'undefined'){
		  selectListNum = 10;
	  }
	  if(flag === 'N'){
		 // alert("flag = N");
		  selectListNum = 10;
		  $('select').find('option:first').attr('selected', 'selected'); 
	  }else{
		  //alert("flag = Y ");
	  }
    var params = 'searchCategory=' + category + '&pageSize=' + selectListNum;
   // alert('category : ' + category+' selectListNum : '+selectListNum+' params : '+params+' currentCategory : '+currentCategory+' flag : '+flag);
    
    $.ajax(
            "getBoardList",
            {
              method : 'get',
              dataType : 'json',
              data : params,
              success : function(result) {
                var list = result.list;
                $("#ref").empty();
                for ( var i in list) {
                  $("#ref")
                      .append(
                          "<tr><td class='col-xs-2'>"
                              + list[i].boardNo
                              + "</td><td class='col-xs-6'><a href='viewBoard?boardNo="+list[i].boardNo+"'>"
                              + list[i].boardTitle
                              + "</a></td><td class='col-xs-2'>"
                              + list[i].nickname
                              + "</td><td class='col-xs-1'>"
                              + list[i].boardDate
                              + "</td><td class='col-xs-1'>"+list[i].boardCount+"</tr>");

                }
              }
            });
    flag = 'N';
  }
</script>
<body>
	<jsp:include page="../main/menuBar.jsp"></jsp:include>
	<div class="container">
		<div class="col-md-12">
			<div class="panel with-nav-tabs panel-success">
				<div class="panel-heading">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#" onClick="funcTab(0);"
							data-toggle="tab">레시피</a></li>
						<li><a href="#" onClick="funcTab(1);" data-toggle="tab">추천맛집</a></li>
						<li><a href="#" onClick="funcTab(2);" data-toggle="tab">고민상담</a></li>
						<li><a href="#" onClick="funcTab(3);" data-toggle="tab">기타</a></li>
						<li class="dropdown" style="float: right;"><a href="#"
							data-toggle="dropdown">10개 <span class="caret"></span>
						</a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="#twenty" data-toggle="tab">20개</a></li>
								<li><a href="#fifty" data-toggle="tab">50개</a></li>
							</ul></li>
						<li style="float: right;"><form
								class="navbar-form navbar-left" role="search">
								<div class="form-group">
									<input type="text" class="form-control" placeholder="Search">
								</div>
								<button type="submit" class="btn btn-default">찾기</button>
								<button type="button" class="btn btn-default">글쓰기</button>
							</form>
							</li>
					</ul>
				</div>
				<div class="panel-body" id="conte">
					<div class="tab-content">
						<div class="tab-pane fade in active">
							<table class="table table-fixed">
								<thead>
									<tr>
										<th class="col-xs-2">#</th>
										<th class="col-xs-6">제목</th>
										<th class="col-xs-2">작성자</th>
										<th class="col-xs-2">올린날짜</th>
									</tr>
								</thead>
								<tbody id="ref">
									<c:set var="i" value="0" />
									<c:forEach var="board" items="${list}">
										<c:set var="i" value="${ i+1 }" />
										<tr>
											<td class="col-xs-2">${ board.boardNo }</td>
											<!--<td class="col-xs-2">10021</td> -->
											<td class="col-xs-6"><a href="/getBoard">${board.boardTitle}</a></td> 
											<!--<td class="col-xs-6"><a href="/getBoard">타이틀77</a></td> -->
											<td class="col-xs-2">${board.nickname}</td>
											<!--<td class="col-xs-2">user01</td> -->
											<td class="col-xs-2">${board.boardDate}</td>
											<!--<td class="col-xs-2">2015-05-27</td> -->
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div align="center">
							<jsp:include page="../main/pageNavigator.jsp"></jsp:include>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br />
</body>
</html>



