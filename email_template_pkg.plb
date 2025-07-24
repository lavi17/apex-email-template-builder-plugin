create or replace PACKAGE BODY EMAIL_TEMPLATE_PKG
AS

    PROCEDURE RENDER_EMAIL_TEMPLATE_BUILDER (
        p_region IN apex_plugin.t_region,
        p_plugin IN apex_plugin.t_plugin,
        p_param  IN apex_plugin.t_region_render_param,
        p_result OUT apex_plugin.t_region_render_result
    )
    AS
    BEGIN

        sys.htp.p('<script> var ajaxIdentifier = "' || apex_plugin.get_ajax_identifier || '"; </script>');

        HTP.P(
            '<div id="email-template-builder-container" data-pluginid="' || p_region.id || '">'||

                -------------------------------- Palette HTML --------------------------------

                '<div id="etb-palette">'||

                    -------------------------------- Body HTML --------------------------------
                    
                    '<div id="etb-g-prop" class="prop_menu">'||

                        '<h5 style="margin: 5px;text-align: center;background-color: cadetblue;color: white;">BODY</h5>'||

                        '<div id="etb-column-prop" class="etb_prop">'||
                            
                            '<div class="etb_prop_child_head">'||
                                '<b class="etb_prop_header">'||
                                    'Columns <span id="etb-column-prop-collap" onclick="collapToggle(`etb-column-prop`)" '||
                                                'class="rot_icon fa fa-angle-down cursor_pointer rotate"></span>'||
                                '</b>'||
                            '</div>'||
                            
                            '<div class="etb_prop_child_det">'||
                                '<div class="etb_prop_det">'||
                                    '<label>1 Column</label>'||
                                    '<div id="1-col-struc" class="col_struc dot_brdr" draggable="true" ondragstart="dragstartHandler(event)" dt1="G"'||
                                    ' dt=''<tr>
                                            <td colspan="12" class="tab_dot_brdr cursor_pointer" onclick="hideShowPropMenu(event,`etb-blk-prop`,`IS`);" '||
                                            'style="width:100%;"></td>
                                            <td class="remove_td"><span class="fa fa-remove remove"></span></td>
                                           </tr>''></div>'||
                                '</div>'||
                                '<div class="etb_prop_det">'||
                                    '<label>2 Columns</label>'||
                                    '<div id="2-col-struc" class="col_struc" draggable="true" ondragstart="dragstartHandler(event)" dt1="G"'||
                                    ' dt=''
                                        <tr>
                                            <td colspan="6" class="tab_dot_brdr cursor_pointer" onclick="hideShowPropMenu(event,`etb-blk-prop`,`IS`);" style="width:50%;"></td>
                                            <td colspan="6" class="tab_dot_brdr cursor_pointer" onclick="hideShowPropMenu(event,`etb-blk-prop`,`IS`);" style="width:50%;"></td>
                                            <td class="remove_td"><span class="fa fa-remove remove"></span></td>
                                        </tr>''>'||
                                        '<div class="dot_brdr"></div>'||
                                        '<div class="dot_brdr"></div>'||
                                    '</div>'||
                                '</div>'||
                                '<div class="etb_prop_det">'||
                                    '<label>3 Columns</label>'||
                                    '<div id="3-col-struc" class="col_struc" draggable="true" ondragstart="dragstartHandler(event)" dt1="G"'||
                                    ' dt=''
                                        <tr>
                                            <td colspan="4" class="tab_dot_brdr cursor_pointer" onclick="hideShowPropMenu(event,`etb-blk-prop`,`IS`);" style="width:33%;"></td>
                                            <td colspan="4" class="tab_dot_brdr cursor_pointer" onclick="hideShowPropMenu(event,`etb-blk-prop`,`IS`);" style="width:33%;"></td>
                                            <td colspan="4" class="tab_dot_brdr cursor_pointer" onclick="hideShowPropMenu(event,`etb-blk-prop`,`IS`);" style="width:33%;"></td>
                                            <td class="remove_td"><span class="fa fa-remove remove"></span></td>
                                        </tr>''>'||
                                        '<div class="dot_brdr"></div>'||
                                        '<div class="dot_brdr"></div>'||
                                        '<div class="dot_brdr"></div>'||
                                    '</div>'||
                                '</div>'||
                            '</div>'||

                        '</div>'||

                        '<div id="etb-global-prop" class="etb_prop">'||
     
                            '<div class="etb_prop_child_head">'||
                                '<b class="etb_prop_header">'||
                                    'Body <span id="etb-body-prop-collap" onclick="collapToggle(`etb-global-prop`)" '||
                                            'class="rot_icon fa fa-angle-down cursor_pointer rotate"></span>'||
                                '</b>'||
                            '</div>'||

                            '<div class="etb_prop_child_det">'||
                                '<div class="etb_prop_det">'||
                                    '<label>Background Color</label>'||
                                    '<div>
                                        <input type="color" id="bg-clr" style="width: 100%;" onchange="setGlobalProp(`background-color`,`bg-clr`)">
                                    </div>'||
                                '</div>'||

                                '<div class="etb_prop_det">'||
                                    '<label>Gradient Color</label>'||
                                    '<div style="display: flex;align-items: center;gap: 1rem;">
                                        <input type="color" id="bg-g-clr1" style="width: 50%;" onchange="setGlobalProp(`background`,`bg-g-clr1`,`GC`)">
                                        <input type="color" id="bg-g-clr2" style="width: 50%;" onchange="setGlobalProp(`background`,`bg-g-clr2`,`GC`)">
                                    </div>
                                    <input type="range" id="bg-g-range" value="0" min="-180" max="180" '||
                                            'style="width: 100%;" onchange="setGlobalProp(`background`,`bg-g-range`,`GC`)">'||
                                '</div>'||

                                '<div class="etb_prop_det">'||
                                    '<label>Click below to add image</label>'||
                                    '<div>
                                        <input type="file" id="file-upload-g" accept="image/*" onchange="uploadImage(`G`,`file-upload-g`)">
                                    </div>'||
                                '</div>'||
                                
                                '<div class="etb_prop_det">'||
                                    '<label>Paste URL to add image</label>'||
                                    '<div>
                                        <input type="text" id="file-upload-url2" accept="image/*" placeholder="Paste URL here"
                                            onchange="uploadImageUrl(`file-upload-url2`,`G`)">
                                    </div>'||
                                '</div>'||

                                -- '<div class="etb_prop_det">'||
                                --     '<label>Padding</label>'||
                                --     '<div style="display: flex;align-items: center;gap: 1rem;">
                                --         <input type="number" id="body-padding" min="0" value="0" style="width:95%" '||
                                --             'onchange="setGlobalProp(`padding`,`body-padding`)">px
                                --     </div>'||
                                -- '</div>'||

                                -- '<div class="etb_prop_det">'||
                                --     '<label>Margin</label>'||
                                --     '<div style="display: flex;align-items: center;gap: 1rem;">
                                --         <input type="number" id="body-margin" min="0" value="0" style="width:95%" '||
                                --             'onchange="setGlobalProp(`margin`,`body-margin`)">px
                                --     </div>'||
                                -- '</div>'||
                            '</div>'||

                        '</div>'||
                    
                    '</div>'||

                    -------------------------------- Add Block --------------------------------

                    '<div id="etb-blk-prop" class="prop_menu dis_no">'||

                        '<h5 style="margin: 5px;text-align: center;background-color: #a05f5f;color: white;">ADD BLOCK TYPE</h5>'||

                        '<div id="etb-block-prop" class="etb_prop">'||
                            
                            '<div class="etb_prop_child_head">'||
                                '<b class="etb_prop_header">'||
                                    'Blocks <span id="etb-block-prop-collap" onclick="collapToggle(`etb-block-prop`)" '||
                                                'class="rot_icon fa fa-angle-down cursor_pointer rotate"></span>'||
                                '</b>'||
                            '</div>'||
                            
                            '<div class="etb_prop_child_det">'||
                                '<div class="etb_prop_det">'||
                                    '<span id="txt-struc" class="fa fa-font sld_brdr cursor_pointer" draggable="true" '||
                                        'ondragstart="dragstartHandler(event)" dt1="I" '||
                                        'dt=''<div contenteditable="true" data-placeholder="Enter your text here" class="text_here"></div>''></span>'||
                                    '<span id="img-struc" class="fa fa-image sld_brdr cursor_pointer" draggable="true" '||
                                        'ondragstart="dragstartHandler(event)" dt1="I" '||
                                        'dt=''<div class="image_here fa fa-image"></div>''></span>'||
                                '</div>'||
                            '</div>'||

                        '</div>'||
                    
                    '</div>'||

                    -------------------------------- ELEMENT HTML --------------------------------

                    '<div id="etb-indi-prop" class="prop_menu dis_no">'||

                        '<h5 style="margin: 5px;text-align: center;background-color: #697d62;color: white;">ELEMENT</h5>'||

                        '<div id="etb-element-prop" class="etb_prop">'||
                            
                            '<div class="etb_prop_child_head">'||
                                '<b class="etb_prop_header">'||
                                    'Element Styling <span id="etb-element-prop-collap" onclick="collapToggle(`etb-element-prop`)" '||
                                                'class="rot_icon fa fa-angle-down cursor_pointer rotate"></span>'||
                                '</b>'||
                            '</div>'||
                            
                            '<div class="etb_prop_child_det">'||
                                '<div class="etb_prop_det">'||
                                    '<label>Background Color</label>'||
                                    '<div>
                                        <input type="color" id="indi-bg-clr" style="width: 100%;" onchange="setIndiProp(`background-color`,`indi-bg-clr`)">
                                    </div>'||
                                '</div>'||

                                '<div class="etb_prop_det">'||
                                    '<label>Gradient Color</label>'||
                                    '<div style="display: flex;align-items: center;gap: 1rem;">
                                        <input type="color" id="bg-i-clr1" style="width: 50%;" onchange="setIndiProp(`background`,`bg-i-clr1`,`GC`)">
                                        <input type="color" id="bg-i-clr2" style="width: 50%;" onchange="setIndiProp(`background`,`bg-i-clr2`,`GC`)">
                                    </div>
                                    <input type="range" id="bg-i-range" value="0" min="-180" max="180" '||
                                            'style="width: 100%;" onchange="setIndiProp(`background`,`bg-i-range`,`GC`)">'||
                                '</div>'||

                                '<div class="etb_prop_det">'||
                                    '<label>Padding</label>'||
                                    '<div style="display: flex;align-items: center;gap: 1rem;">
                                        <input type="number" id="indi-padding" min="0" value="0" style="width:95%" '||
                                            'onchange="setIndiProp(`padding`,`indi-padding`)">px
                                    </div>'||
                                '</div>'||
                                '<div class="etb_prop_det">'||
                                    '<label>Margin</label>'||
                                    '<div style="display: flex;align-items: center;gap: 1rem;">
                                        <input type="number" id="indi-margin" min="0" value="0" style="width:95%" '||
                                            'onchange="setIndiProp(`margin`,`indi-margin`)">px
                                    </div>'||
                                '</div>'||
                                '<div class="etb_prop_det">'||
                                    '<label>Width</label>'||
                                    '<div style="display: flex;align-items: center;gap: 1rem;">
                                        <input type="number" id="indi-width" min="0" value="0" style="width:95%" '||
                                            'onchange="setIndiProp(`width`,`indi-width`)">px
                                    </div>'||
                                '</div>'||
                                '<div class="etb_prop_det">'||
                                    '<label>Height</label>'||
                                    '<div style="display: flex;align-items: center;gap: 1rem;">
                                        <input type="number" id="indi-height" min="0" value="0" style="width:95%" '||
                                            'onchange="setIndiProp(`height`,`indi-height`)">px
                                    </div>'||
                                '</div>'||
                                '<div class="etb_prop_det">'||
                                    '<label>Alignment</label>'||
                                    '<div>
                                        <select id="indi-fnt-align" style="width: 100%;" onchange="setIndiProp(`text-align`,`indi-fnt-align`)">
                                            <option value="start">Start</option>
                                            <option value="center">Center</option>
                                            <option value="end">End</option>
                                        </select>
                                    </div>'||
                                '</div>'||
                            '</div>'||

                        '</div>'||

                        '<div id="etb-text-prop" class="etb_prop">'||
                            
                            '<div class="etb_prop_child_head">'||
                                '<b class="etb_prop_header">'||
                                    'Text Styling <span id="etb-text-prop-collap" onclick="collapToggle(`etb-text-prop`)" '||
                                                'class="rot_icon fa fa-angle-down cursor_pointer rotate"></span>'||
                                '</b>'||
                            '</div>'||
                            
                            '<div class="etb_prop_child_det">'||
                                '<div class="etb_prop_det">'||
                                    '<label>Text Size</label>'||
                                    '<div style="display: flex;align-items: center;gap: 1rem;">
                                        <input type="number" id="indi-fnt-sz" min="1" value="12" style="width:95%" '||
                                            'onchange="setIndiProp(`font-size`,`indi-fnt-sz`)">px
                                    </div>'||
                                '</div>'||
                                '<div class="etb_prop_det">'||
                                    '<label>Text Color</label>'||
                                    '<div>
                                        <input type="color" id="indi-fnt-clr" style="width: 100%;" onchange="setIndiProp(`color`,`indi-fnt-clr`)">
                                    </div>'||
                                '</div>'||
                                '<div class="etb_prop_det">'||
                                    '<label>Text Style</label>'||
                                    '<div>
                                        <select id="indi-fnt-style" style="width: 100%;" onchange="setIndiProp(`font-style`,`indi-fnt-style`)">
                                            <option value="normal">Normal</option>
                                            <option value="italic">Italic</option>
                                        </select>
                                    </div>'||
                                '</div>'||
                                '<div class="etb_prop_det">'||
                                    '<label>Text Decoration</label>'||
                                    '<div>
                                        <select id="indi-fnt-deco" style="width: 100%;" onchange="setIndiProp(`text-decoration`,`indi-fnt-deco`)">
                                            <option value="unset">Normal</option>
                                            <option value="underline">Underline</option>
                                            <option value="line-through">Line-Through</option>
                                        </select>
                                    </div>'||
                                '</div>'||
                            '</div>'||

                        '</div>'||

                        '<div id="etb-image-prop" class="etb_prop">'||
                            
                            '<div class="etb_prop_child_head">'||
                                '<b class="etb_prop_header">'||
                                    'Image <span id="etb-image-prop-collap" onclick="collapToggle(`etb-image-prop`)" '||
                                                'class="rot_icon fa fa-angle-down cursor_pointer rotate"></span>'||
                                '</b>'||
                            '</div>'||
                            
                            '<div class="etb_prop_child_det">'||
                                '<div class="etb_prop_det">'||
                                    '<label>Click below to add image</label>'||
                                    '<div>
                                        <input type="file" id="file-upload" accept="image/*" onchange="uploadImage(`I`,`file-upload`)">
                                    </div>'||
                                '</div>'||
                                '<div class="etb_prop_det">'||
                                    '<label>Paste URL to add image</label>'||
                                    '<div>
                                        <input type="text" id="file-upload-url" accept="image/*" placeholder="Paste URL here"
                                            onchange="uploadImageUrl(`file-upload-url`,`I`)">
                                    </div>'||
                                '</div>'||
                                '<div class="etb_prop_det">'||
                                    '<label>Image Width</label>'||
                                    '<div style="display: flex;align-items: center;gap: 1rem;">
                                        <input type="number" id="indi-img-width" min="0" value="0" style="width:95%" '||
                                            'onchange="setIndiProp(`width`,`indi-img-width`)">px
                                    </div>'||
                                '</div>'||
                                '<div class="etb_prop_det">'||
                                    '<label>Image Height</label>'||
                                    '<div style="display: flex;align-items: center;gap: 1rem;">
                                        <input type="number" id="indi-img-height" min="0" value="0" style="width:95%" '||
                                            'onchange="setIndiProp(`height`,`indi-img-height`)">px
                                    </div>'||
                                '</div>'||
                            '</div>'||

                        '</div>'||
                    
                    '</div>'||

                '</div>'||


                -------------------------------- Editable Region HTML --------------------------------

                '<div id="etb-editor" ondrop="dropHandler(event)" ondragover="dragoverHandler(event)" onclick="hideShowPropMenu(event,`etb-g-prop`,`G`)">'||

                    '
                    <div id="etb-preview-reg"> </div>

                    <table id="etb-table" style="width: 100%;border-collapse: collapse;background-repeat: no-repeat;background-position: center;background-size: cover;">'||
                        '<tr><th colspan="12" style="position: absolute;top: 50%;left: 50%;">Drop Here</th></tr>'||
                    '</table>'||

                '</div>'||

            '</div>'
        );

    END RENDER_EMAIL_TEMPLATE_BUILDER;

    FUNCTION clob_base64_to_blob(p_clob IN CLOB) RETURN BLOB IS
        l_blob      BLOB;
        l_raw       RAW(32767);
        l_amt       PLS_INTEGER := 32767;
        l_pos       PLS_INTEGER := 1;
        l_buffer    VARCHAR2(32767);
    BEGIN
        DBMS_LOB.createtemporary(l_blob, TRUE);
        LOOP
            l_buffer := DBMS_LOB.SUBSTR(p_clob, l_amt, l_pos);
            EXIT WHEN l_buffer IS NULL;
            l_raw := UTL_ENCODE.BASE64_DECODE(UTL_RAW.CAST_TO_RAW(l_buffer));
            DBMS_LOB.WRITEAPPEND(l_blob, UTL_RAW.LENGTH(l_raw), l_raw);
            l_pos := l_pos + l_amt;
        END LOOP;
        RETURN l_blob;
    END;


END EMAIL_TEMPLATE_PKG;
/