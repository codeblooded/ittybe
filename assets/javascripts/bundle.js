function colorize(inputField, type, error) {
  if (type === 'normal') {
    inputField.css({
      'background-color': 'white',
      'border-style': 'none',
      'color': 'black'
    });
  } else {
    if (type === 'warning') {
      inputField.css({
        'background-color': '#fffec8',
        'border': '1px solid #e4d046',
        'color': 'black'
      });
    } else if (type === 'error') {
      inputField.css({
        'background-color': '#ffc8c8',
        'border': '1px solid #e44646',
        'color': 'white'
      });
    }

    inputField.attr('placeholder', error);
    inputField.val('');
  }
}

function shorten(val) {
  if (!val || val.length < 1) { return; }

  const inputField = $('#input-field');
  const data = JSON.stringify({
    url: val
  });

  $.ajax({
    type: 'POST',
    url: 'shorten',

    dataType: 'json',
    data: data,

    timeout: 5000,

    success: function(data, status) {
      if (status == 'success') {

        colorize(inputField, 'normal');
        inputField.val(data.url.short);
        inputField.focus();
        inputField.select();

        const copyBtn = $('.copy-btn');
        copyBtn.show();
      }
    },

    error: function(e) {
      if (e.status == 400) {
        colorize(inputField, 'error', 'Please enter a correctly formatted url...');
      } else {
        colorize(inputField, 'warning', "We're facing some problems. Please try again later...");
      }

      $('.copy-btn').hide();
    }
  });
}

$(function() {
  new Clipboard('.copy-btn');

  const inputField = $('#input-field');
  inputField.focus();
  
  inputField.on('paste', function(e) {
    shorten(e.originalEvent.clipboardData.getData('text'));
  });

  inputField.keyup(function(e) {
    const key = e.keyCode || e.which;
    if (key == '13') {
      shorten(inputField.val());
    }
    if (inputField.val().length < 1) {
      colorize(inputField, 'normal');
      $('.copy-btn').hide();
    }
  });



  console.log('Hola, Hacker! Welcome to the JavaScript console.\nThe itty.be project is actually open source.\nCheck it out at http://github.com/codeblooded/ittybe.');
});
