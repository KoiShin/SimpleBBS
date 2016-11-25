function checkTextLength() {
  if (document.inputText.name.value.length > 30) {
    alert("名前は30字以内でお願いします。");
    return false;
  }
  if (document.inputText.message.value.length > 140) {
    alert("テキストは140字以内でお願いします。");
    return false;
  }
}
