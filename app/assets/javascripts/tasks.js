//turbolinkが適用されていた場合はwindow.onloadではなくこれでページ読み込み時に処理が実行される
document.addEventListener('turbolinks:load', function() {
  //すべてのtdタグを取得し、すべてに適用する
  document.querySelectorAll('td').forEach(function(td) {
    //マウスオーバー時の処理を追加
    td.addEventListener('mouseover', function(e) {
      //currentTarget.styleでイベントを検知したターゲットだけにスタイルを適用する
      e.currentTarget.style.backgroundColor = '#eff';
    });

    //マウスアウト時の処理
    td.addEventListener('mouseout', function(e) {
      e.currentTarget.style.backgroundColor = '';
    });
  });
});
