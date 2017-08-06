function colorize(inputField, type, error) {
  if (type === 'normal') {
    inputField.css({
      'background-color': 'white',
      'border-style': 'none',
      'color': 'black'
    });
  } else {
    if (type === 'warn') {
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

function isValidUrlRegex(url) {
  const urlRegex = /^(?:(http|https)(?:(\:\/\/))){0,1}([A-Za-z0-9\-\_\.\~]+\.[A-Za-z0-9\-\_\.\~]+)(\/(.*))?$/;
  return urlRegex.test(url);
}

function shortenUrlOverAjax(inputField, val) {
  $.ajax({
    type: 'POST',
    url: 'shorten',

    dataType: 'json',
    data: JSON.stringify({ url: val }),

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
        colorize(inputField, 'warn', "We're facing some problems. Please try again later...");
      }

      $('.copy-btn').hide();
    }
  });
}

function shorten(val) {
  if (!val || val.length < 1) { return; }

  const inputField = $('#input-field');
  console.log(inputField);

  if (isValidUrlRegex(val)) {
    console.log(`Shortening url=${val}`);
    shortenUrlOverAjax(inputField, val);
  } else {
    console.log('Url is not matching standard url');
    inputField.css({
      'background-color': '#ffc8c8',
      'border': '1px solid #e44646',
      'color': 'black'
    });
  }
}

$(function() {
  const copyBtnSelector = '.copy-btn';
  const copyBtn = $(copyBtnSelector);
  const clipboard = new Clipboard(copyBtnSelector);

  clipboard.on('success', function(e) {
    copyBtn.html('<i class="fa fa-check" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;It\'s all copied!');
    copyBtn.css({
      'background-color': '#30d140',
      'color': 'white'
    });
    console.log('Link successfully copied.');
  });

  clipboard.on('error', function(e) {
    copyBtn.html('<i class="fa fa-exclamation-triangle" aria-hidden="true"></i>&nbsp;&nbsp;Try manual copy');
    copyBtn.css({
      'background-color': '#de4747',
      'color': 'white'
    });
    inputField.select();
    console.log('Link failed to copy copied.');
  });

  const inputField = $('#input-field');
  inputField.focus();

  inputField.on('paste', function(e) {
    shorten(e.originalEvent.clipboardData.getData('text'));
  });

  inputField.keyup(function(e) {
    const key = e.keyCode || e.which;
    if (key == '13') {
      shorten(inputField.val());
    } else if (inputField.val().length < 1) {
      colorize(inputField, 'normal');
      $('.copy-btn').hide();
    }
  });

  console.log('Hola, Hacker! Welcome to the JavaScript console.\nThe itty.be project is actually open source.\nCheck it out at http://github.com/codeblooded/ittybe.');
});
