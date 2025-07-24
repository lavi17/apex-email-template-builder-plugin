prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2024.11.30'
,p_release=>'24.2.6'
,p_default_workspace_id=>63038638889813338893
,p_default_application_id=>181686
,p_default_id_offset=>0
,p_default_owner=>'WKSP_LAW'
);
end;
/
 
prompt APPLICATION 181686 - Plugin Store
--
-- Application Export:
--   Application:     181686
--   Name:            Plugin Store
--   Date and Time:   06:39 Thursday July 24, 2025
--   Exported By:     LAVI19970@GMAIL.COM
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 63259090196380238710
--   Manifest End
--   Version:         24.2.6
--   Instance ID:     63113759365424
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/region_type/email_template_builder
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(63259090196380238710)
,p_plugin_type=>'REGION TYPE'
,p_name=>'EMAIL_TEMPLATE_BUILDER'
,p_display_name=>'Email Template Builder'
,p_javascript_file_urls=>'#APP_FILES#email-template-builder#MIN#.js'
,p_css_file_urls=>'#APP_FILES#email-template-builder#MIN#.css'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'PROCEDURE img_to_col (',
'    p_plugin in            apex_plugin.t_plugin,',
'    p_region in            apex_plugin.t_region,',
'    p_param  in            apex_plugin.t_region_ajax_param,',
'    p_result in out nocopy apex_plugin.t_region_ajax_result ',
')',
'AS',
'    l_blob      BLOB;',
'    l_file_name VARCHAR2(255) := apex_application.g_x03;',
'    l_mime      VARCHAR2(255) := apex_application.g_x02;',
'    l_clob      CLOB := apex_application.g_x01;',
'BEGIN',
'    -- Convert base64 CLOB to BLOB',
'    l_blob := EMAIL_TEMPLATE_PKG.clob_base64_to_blob(l_clob);',
'',
'    -- Create collection if not exists',
'    IF NOT apex_collection.collection_exists(''IMAGE_UPLOAD'') THEN',
'        apex_collection.create_collection(''IMAGE_UPLOAD'');',
'    END IF;',
'',
'    -- Add BLOB to collection with metadata',
'    apex_collection.add_member (',
'        p_collection_name => ''IMAGE_UPLOAD'',',
'        p_c001            => l_file_name,  -- optional: store file name',
'        p_c002            => l_mime,       -- optional: store MIME type',
'        p_blob001         => l_blob',
'    );',
'',
'    -- Return JSON response',
'    apex_json.open_object;',
'    apex_json.write(''status'', ''success'');',
'    apex_json.write(''message'', ''Image uploaded to collection'');',
'    apex_json.close_object;',
'END;'))
,p_api_version=>3
,p_render_function=>'EMAIL_TEMPLATE_PKG.RENDER_EMAIL_TEMPLATE_BUILDER'
,p_ajax_function=>'img_to_col'
,p_substitute_attributes=>true
,p_version_scn=>15639353303100
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false)
);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
