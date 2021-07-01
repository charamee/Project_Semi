<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" 
integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<link rel="stylesheet" href="resources/css/style.css">
</head>
<body class="container">
	<%@ include file="Form/header.jsp"%>
    <article class="start">
        <h1 class="mt-5 text-center">나랑 꼭 닮은 동물</h1>
        <button type="button" class="btn btn-success mt-5" onclick="start();">고양이</button>
    </article>
    <article class="question">
        <div class="progress mt-5">
            <div class="progress-bar" role="progressbar" style="width: calc(100/12*1%)"></div>
        </div>
        <h2 id="title" class="text-center mt-5">문제</h2>
        <input id="type" type="hidden" value="EI">
        <button id="A" type="button" class="btn btn-secondary mt-5">Secondary</button>
        <button id="B" type="button" class="btn btn-secondary mt-5">Secondary</button>
    </article>
    <article class="result">
        <img id="img" class="rounded-circle mt-5" src="resources/image/10.an.jpg" alt="animal">
        <h2 id="animal" class="text-center mt-5">동물품종</h2>
        <h3 id="explain" class="text-center mt-5">설명</h3>
    </article>
    <input type="hidden" id="EI" value="0">
    <input type="hidden" id="SN" value="0">
    <input type="hidden" id="TF" value="0">
    <input type="hidden" id="JP" value="0">

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    <script>
		// 성향 조사 문항
        var num = 1;
        var q = {
        		1: {"title": "문제 1번", "type": "EI", "A": "바깥에 나가 활동적인 일을 하는것이 좋다", "B": "바깥에 나가는것 보다 집에서 노는 것이 더 기분이 좋다"},
                2: {"title": "문제 2번", "type": "EI", "A": "여러 사람들과 함께 있을때 에너지를 얻는다.", "B": "사교모임에 참석하는것 보다는 집에서 책이나 핸드폰을 하는게 더 즐겁다"},
                3: {"title": "문제 3번", "type": "EI", "A": "대화를 주도하는 편이다", "B": "대화를 주도하기보다는 상대방의 말을 듣고있는 편이다"},
                4: {"title": "문제 4번", "type": "SN", "A": "나는 주로 눈에 보이는것을 믿고 현실적인것을 생각한다", "B": "나는 상상력이 풍부해서 항상 머리가 복잡하다고 느낀다"},
                5: {"title": "문제 5번", "type": "SN", "A": "나는 영화를 볼때 영화 자체에 몰입하여 빠져든다", "B": "나는 영화를 볼 때 내가 주인공이 되는 상상을 한다"},
                6: {"title": "문제 6번", "type": "SN", "A": "갈등이 생겼을 때 바로 상대방과 대화를 통해 풀어나간다", "B": "갈등이 생겼을 때 혼자만의 시간이 필요하다"},
                7: {"title": "문제 7번", "type": "TF", "A": "나는 열심히 하지만 성과가 없는것 보다 결과물이 더 중요하다", "B": "나는 열심히 하지만 성과가 없는 팀원을 이름을 빼기 힘들다"},
                8: {"title": "문제 8번", "type": "TF", "A": "친구가 고민을 털어놨을 때 원인과 결과에 초점을 맞춰 조언해준다", "B": "친구가 고민을 털어놨을 때 힘들었을 친구의 마음을 다독여준다"},
                9: {"title": "문제 9번", "type": "TF", "A": "나에게 피해를 입혔을 때 바로 지적한다", "B": "나에게 피해가 있더라도 일단 참고본다"},
                10: {"title": "문제 10번", "type": "JP", "A": "여행은 발길이 닿는대로 의식의 흐름에 맡긴다", "B": "나는 여행계획을 꼼꼼하게 세운다"},
                11: {"title": "문제 11번", "type": "JP", "A": "무언가 하고싶을 때 일단 시작하고 본다", "B": "무엇을 하던 준비기간이 길다"},
                12: {"title": "문제 12번", "type": "JP", "A": "내가 놓는곳이 바로 그 물건의 자리이다", "B": "내 방의 물건은 항상 제자리에 있다"}     
        }
		// 결과 문항
        var result = {
            "ISTJ": {"animal": "카오스", "explain": "규칙적이며 착실한 타입의 당신. 주어진 일은 끝까지 완수하고 단체생활에 매우 잘 적응하는 편이에요<br> 여러가지 색이 섞여 카리스마 넘쳐보이는 외모와 충성심 강한 카오스와 닮았네요 ", "img": "resources/image/kaos.jpg"},
            "ISFJ": {"animal": "페르시안", "explain": "차분하고 헌신적이며 인내심이 강한 당신 혼자만의 시간을 즐기는군요!<br> 혼자만의 시간을 즐기는 차분한 타입의 느긋한 성격의 소유자 페르시안 고양이와 닮았어요", "img": "resources/image/persian.jpg"},
            "INFJ": {"animal": "브리티시 쇼트헤어", "explain": "계획적이고 인내심 많은 당신, 영감이 뛰어나고 깊은 통찰력이 있군요!! <br> 여유를 즐기고 침착하며 사람곁에 머물기를 좋아하는 브리티시 쇼트헤어와 잘 맞아요", "img": "resources/image/5.bri.jpg"},
            "INTJ": {"animal": "노르웨이 숲", "explain": "생각이 많고 복잡한 당신, 가끔 진지한 생각으로 상당한 시간을 보내는군요! <br> 매우 주의깊고 독립적인 성격에 복잡한 장난감을 즐기는 노르웨이숲과 잘맞아요", "img": "resources/image/6.nul.jpg"},
            "ISTP": {"animal": "스라소니", "explain": "만능재주꾼인 당신, 틀에 박힌 생활을 싫어하고 일을 효율적으로 잘하는 타입이에요<br>주의깊게 분석하고 효율적으로 행동하는 스라소니와 매우 닮았어요!", "img": "resources/image/sra.jpg"},
            "ISFP": {"animal": "아메리칸 숏헤어", "explain": "포용력과 이해력이 많고, 현재의 삶을 즐기는 당신,<br>예민한 성격이 아니며 어리광도 적어 누구와도 쉽게 친해지는 성격인 아메리칸 숏헤어와 닮았어요!!", "img": "resources/image/3.ame.jpg"},
            "INFP": {"animal": "버만", "explain": "세심하고 삶에대한 고찰이 깊은 당신은 혼자만의 시간이 중요해 보여요<br>조용하고 똑똑하며 혼자만의 시간을 좋아하는 버만과 아주 잘 맞을것 같아요", "img": "resources/image/7.be.jpg"},
            "INTP": {"animal": "터키시 앙고라", "explain": "지적인 매력이 넘치는 당신은 잠재력과 가능성을 중요시해요<br>호기심이 많고 지능적이어서 수도꼭지를 잠그기까지 하는 터키시 앙고라와 닮았네요!", "img": "resources/image/10.tuci.jpg"},
            "ESTP": {"animal": "아비시니안", "explain": "새로움에 대한 도전 욕구가 강하고 개방적인 당신은 매우 활동적이에요 <br> 민첩하고 활동적이며 사람과 상호작용도 가능한 아비시니안과 잘 어울려요", "img": "resources/image/9.abi.jpg"},
            "ESFP": {"animal": "스코티시폴드", "explain": "인기폭발 모두의 연예인인 당신은 신나고 재미있는 성격이네요 <br>애교가 많고 교감하는 것을 좋아하며 시끄러운 곳에서도 겁먹지 않는 스코티쉬폴드와 찰.떡.궁.합!", "img": "resources/image/6.sco.jpg"},
            "ENFP": {"animal": "샴", "explain": "감정이 풍부하고 정이많은 당신,<br> 온순하고 느긋한 성격으로 특유의 친밀감으로 다른이들과 잘 어울리는 샴고양이와 매우 닮았어요", "img": "resources/image/6.syam.jpg"},
            "ENTP": {"animal": "발리니즈", "lain": "무엇을 하던 평균이상 팔방미인, 두뇌 회전이 빠른 편이고 직관적이네요!<br>새로운 것을 배우고 독특한 방법으로 주변을 탐험하는 호기심쟁이 발리니즈와 잘 어울려요!", "img": "resources/image/bali.jpg"},
            "ESTJ": {"animal": "드래곤 리", "explain": "모든일을 계획하고 도전정신이 강한 야심가인 당신 <br>똑똑하고 재능있는 사냥꾼 기질의 고양이 드래곤 리와 닮았어요!", "img": "resources/image/dragon.jpg"},
            "ESFJ": {"animal": "러시안블루", "explain": "준비성과 참을성이 많고 솔직한 당신은 사교성이 좋아 사람들과 잘 어울려요<br>낯가림은 심하지만 놀기를 좋아하고 온순하며 애교가 많은 러시안블루와 친한 친구가 될 것 같아요 ", "img": "resources/image/3.resh.jpg"},
            "ENFJ": {"animal": "메인쿤", "explain": "사람을 좋아하고 마음이 약한 당신은 제 사람이라면 한없이 베풀어 주는 착한사람!<br>어떤 환경에서도 적응력이 높고 온순한 성격으로 신사라고 불리우는 메인쿤과 닮았네요~  ", "img": "resources/image/7.cun.jpg"},
            "ENTJ": {"animal": "뱅갈", "explain": "솔직,결단,통솔력을 두루 갖춘 이시대의 리더인 당신은 호기심과 지적 욕구가 많아 보여요<br>사람을 좋아하고 호기심이 많은 뱅갈고양이와 아주 닮았아요", "img": "resources/image/2.bang.jpg"},
        }
        // 성향 조사 시작
        function start() {
            $(".start").hide();
            $(".question").show();
            next();
        }
        // A 항목의 버튼을 클릭하면 +1
        $("#A").click(function() {
            var type = $("#type").val();
            var preValue = $("#"+type).val();
            $("#"+type).val(parseInt(preValue)+1);
            next();
        });
        // B 항목을 클릭하면 바로 다음으로
        $("#B").click(function() {
            next();
        });
        // 질문 항목이 항목 만큼만
        function next() { 
            if (num == 13) {
                $(".question").hide();
                $(".result").show();
                var mbti = "";
                ($("#EI").val() < 2) ? mbti += "I" : mbti += "E";
                ($("#SN").val() < 2) ? mbti += "N" : mbti += "S";
                ($("#TF").val() < 2) ? mbti += "F" : mbti += "T";
                ($("#JP").val() < 2) ? mbti += "J" : mbti += "P";
                $("#img").attr("src", result[mbti]["img"]);
                $("#animal").html(result[mbti]["animal"]);
                $("#explain").html(result[mbti]["explain"]);
                num++;
            } else {
            	// 질문을 하나씩 클릭할 때마다 프로그레스 바가 1씩 증가
                $(".progress-bar").attr('style', 'width: calc(100/12*'+num+'%)');
                $("#title").html(q[num]["title"]);
                $("#type").val(q[num]["type"]);
                $("#A").html(q[num]["A"]);
                $("#B").html(q[num]["B"]);
                num++;
            }
        }
    </script>
</body>
</html>