// This file is purely for Email Template builder JS

let htmlToDrag, dragType, currEleId, htmlToSave;

const collapToggle = (id) => {
    $(`#`+id).find(`.rot_icon`).toggleClass(`rotate`);
    $(`#`+id).find(`.etb_prop_child_det`).toggleClass(`dis_no`);
}

function dragstartHandler(ev) {
    htmlToDrag = ev.target.getAttribute('dt');
    dragType = ev.target.getAttribute('dt1');
}

function dragoverHandler(ev) {
    ev.preventDefault();
}

function dropHandler(ev) {
    ev.preventDefault();
    if ( dragType == 'G' ) {
        $('#etb-table tbody').append(htmlToDrag);
    }
    else if ( dragType == 'I' ) {
        $('#'+currEleId).append(htmlToDrag);
    }

    $('#etb-table tbody td').each(function(idx){
        $(this).attr('id','td-'+idx);
        $(this).find('div.text_here').attr('onclick','hideShowPropMenu(event,`etb-indi-prop`,`I`)');
        $(this).find('div.text_here').attr('id','div-'+idx);
        $(this).find('div.image_here').attr('onclick','hideShowPropMenu(event,`etb-indi-prop`,`I`)');
        $(this).find('div.image_here').attr('id','div-image-'+idx);
    });

    htmlToDrag = '';
    dragType = '';
    hideShowDropText();
}

const hideShowDropText = () => {
    if ( $('#etb-table').find('td').length > 0 ) {
        $('#etb-table').find('th').parent().addClass('dis_no');
    }
    else {
        $('#etb-table').find('th').parent().removeClass('dis_no');
    }
}

function hideShowPropMenu (event, id, type) {
    event.stopPropagation();
    $('.prop_menu').addClass('dis_no');
    $('#'+id).removeClass('dis_no');

    currEleId = event.target.id;
    $('#email-template-builder-container').find('.dotted_border').removeClass('dotted_border');
    $('#'+currEleId).toggleClass('dotted_border');

    if ( $('#'+currEleId).hasClass('image_here') || $('#'+currEleId).hasClass('img') ) {
        $('#etb-image-prop').removeClass('dis_no');
    }
    else {
        $('#etb-image-prop').addClass('dis_no');
    }
}

const setGlobalProp = (type, id, ele) => {
    if ( ele == 'GC' ) {
        $('#etb-table').css(type, 'linear-gradient('+
                                    $('#bg-g-range').val()+'deg, '+
                                    $('#bg-g-clr1').val()+', '+
                                    $('#bg-g-clr2').val()+')' );
    }
    else {
        $('#etb-table').css(type, $('#'+id).val() );
    }
}

const setIndiProp = (type, id, ele) => {
    if ( ele != 'GC' ) {
        if ( type == 'font-size' || type == 'margin' || type == 'width' || type == 'height' ) {
            $('#'+currEleId).css(type, $('#'+id).val() + 'px');
        }
        else {
            $('#'+currEleId).css(type, $('#'+id).val() );
        }
    }
    else {
        $('#'+currEleId).css(type, 'linear-gradient('+
                                $('#bg-i-range').val()+'deg, '+
                                $('#bg-i-clr1').val()+', '+
                                $('#bg-i-clr2').val()+')' );
    }
}

const uploadImage = (type, id) => {
    var input = document.getElementById(id);
    var preview;
    
    if ( type == 'I' ) {
        preview = document.getElementById(currEleId);
    }
    else {
        preview = document.getElementById('etb-table');
    }

    if (input.files && input.files[0]) {
        var file = input.files[0];
        var reader = new FileReader();

        reader.onload = function (e) {
            // Show preview
            if ( type == 'I' ) {
                preview.innerHTML =
                '<img src="' + e.target.result + '" class="img">';
            }
            else {
                preview.style.backgroundImage = 'url('+ e.target.result +')';
            }

            // Extract Base64 data (strip the prefix "data:*/*;base64,")
            var base64Data = e.target.result.split(',')[1];

            // Send to APEX plugin AJAX
            apex.server.plugin(
                ajaxIdentifier,
                {
                    x01: base64Data,
                    x02: file.type,
                    x03: file.name
                },
                {
                    dataType: 'json',
                    success: function (data) {
                        console.log('Upload success:', data);
                        // alert('Image uploaded successfully via plugin AJAX!');
                    },
                    error: function (xhr, status, error) {
                        console.error('Upload error:', error);
                        // alert('Upload failed: ' + error);
                    }
                }
            );
        };

        reader.readAsDataURL(file);
        $('#' + currEleId).removeClass('fa-image');
    }

    if ( type == 'I' ) {
        setTimeout(function(){
            $('.img').each(function(idx){
                $(this).attr('id','img-'+idx);
                $(this).attr('onclick','hideShowPropMenu(event,`etb-indi-prop`,`I`)');
            });  
        },700);
    }
    else {
        setTimeout(function(){
            $('.img').each(function(idx){
                $(this).attr('id','img-'+idx);
                $(this).attr('onclick','hideShowPropMenu(event,`etb-g-prop`,`G`)');
            });  
        },700);
    }
};

const uploadImageUrl = (id, type) => {
    let url = $('#'+id).val();

    if ( type == 'I' ) {

        $('#'+currEleId).append('<img src="' + url + '" class="img">');

        $('#' + currEleId).removeClass('fa-image');

        setTimeout(function(){
            $('.img').each(function(idx){
                $(this).attr('id','img-'+idx);
                $(this).attr('onclick','hideShowPropMenu(event,`etb-indi-prop`,`I`)');
            });  
        },700);
    }
    else {
        $('#etb-table').css('backgroundImage','url('+ url +')');
    }
}

function removeRow (event, id) {
    event.stopPropagation();
    
    if (event.target && event.target.classList.contains('remove')) {
        const row = event.target.closest('tr');
        if (row) {
            row.remove();
        }
    }
}

document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('etb-table').addEventListener('click', function(e) {
        e.stopPropagation();
        if (e.target && e.target.classList.contains('remove')) {
            const row = e.target.closest('tr');
            if (row) {
                row.remove();
            }
        }
    });
});

function preview(event) {
    event.stopPropagation();
    let previewWindow = window.open("", "PreviewWindow", "width=800,height=600");
    let elem = document.getElementById("etb-table");
    let html = elem.outerHTML;

    $('#etb-preview-reg').empty();
    $('#etb-preview-reg').append(html);
    $('#etb-preview-reg .remove_td, #etb-preview-reg .dis_no').remove();

    $('#etb-preview-reg div').removeAttr('data-placeholder');
    $('#etb-preview-reg div').removeAttr('contenteditable');
    $('#etb-preview-reg div, #etb-preview-reg td, #etb-preview-reg table, #etb-preview-reg img').removeAttr('id');
    $('#etb-preview-reg div, #etb-preview-reg td, #etb-preview-reg table, #etb-preview-reg img').removeAttr('class');
    $('#etb-preview-reg div, #etb-preview-reg td, #etb-preview-reg table, #etb-preview-reg img').removeAttr('onclick');

    let elem2 = document.getElementById("etb-preview-reg");
    let html2 = elem2.outerHTML;

    previewWindow.document.write(html2);
    previewWindow.document.close();
}