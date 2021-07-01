let modal;
let previes;
let original
let thisImg;

let infinityNumber = 16;



window.onload = function() {
	// 모달창 흑백화면
	modal = document.querySelector(".modal1");
	// 이미지들
	previews = document.querySelectorAll(".photo-gallery img");
	// 나오는 창
	original = document.querySelector(".full-img");
	// 원래 이미지 파일
	thisImg = document.querySelector(".thisImg");

	console.log(modal);
	console.log(previews);
	console.log(original);
}
// 비동기 함수를 동기처럼 실행할 수 있게 만들어 주는것
window.onscroll = async function() {
	// 윈도우 스크롤은 스크롤 위치, 홈페이지 안보이는 부분까지, 이너헤잇은 창 크기
	// 스크롤을 최대 밑으로 내렸을 때 동작
	if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
		await request(infinityNumber);
		infinityNumber += 6;
		console.log("infinityNumber : " + infinityNumber)
	}
}

async function request(infinityNumber) {
	// fetch는 아작스랑 같다.
	const response = await fetch('infinitContent.do?infinityNumber=' + infinityNumber, { method: 'GET', }).then((res)=>{return res.text()});
	console.log(response);
	/*let savedata = document.createElement('div');
	savedata.innerHTML = savedata.innerHTML + response;*/
	
	document.getElementById('photo-gallery').innerHTML = document.getElementById('photo-gallery').innerHTML + response;

}


function clicks(e) {
	// modal 과 origianl 에 open class 를 추가한다.
	modal.classList.add("open");
	original.classList.add("open");
	let ArticleNo = e.getAttribute('articleNo');
	console.log(ArticleNo);
	document.getElementById('TextArticleNo').value = ArticleNo;

	requestData(ArticleNo);

	const originalSrc = e.getAttribute("data-original");
	if (e.hasAttribute('chk')) {
		// 입양대기일 경우 입양신청 버튼 on / 이미지 경로 수정
		// 오리지날 속성을 가지고 오고 클릭한 이미지의 를 오리지날 속성 이미지로 변경한다.
		document.getElementById('apply').style.display = "inline";
		thisImg.src = `resources/saveFile/${originalSrc}`;
	} else {
		// 입양후기일 경우 입양신청 버튼 off / 이미지 경로 수정
		// 오리지날 속성을 가지고 오고 클릭한 이미지의 를 오리지날 속성 이미지로 변경한다.
		document.getElementById('apply').style.display = "none";
		thisImg.src = `savefile/${originalSrc}`;
	}

}

function CloseModal(e) {
	if (e.classList.contains('modal1')) {
		e.classList.remove("open");
		//original.classList.add("open");
	}
}

// 누른 이미지 번호에 따른 data 요청
async function requestData(ArticleNo) {
	let data = await fetch("pet.do?command=titleContent&ArticleNo=" + ArticleNo).then(function(res) {
		return res.json();
	});
	console.log("data : " + data);
	let title = data.title;
	console.log("title : " + title);
	document.getElementById('title').innerHTML = data.title;
	let content = data.content;
	console.log("content :" + content);
	document.getElementById('content').innerHTML = data.content;
}

// 글 삭제
function deleteData() {
	let ArticleNo = document.getElementById('TextArticleNo').value;
	location.href = "pet.do?command=delete&ArticleNo=" + ArticleNo;
}

// 글 업데이트
function updateData() {
	let ArticleNo = document.getElementById('TextArticleNo').value;
	location.href = "pet.do?command=updateform&ArticleNo=" + ArticleNo
}

function applyData() {
	let ArticleNo = document.getElementById('TextArticleNo').value;
	location.href = "petboard_adopt_info.jsp";
}
