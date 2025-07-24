create or replace PACKAGE EMAIL_TEMPLATE_PKG
AS

    PROCEDURE RENDER_EMAIL_TEMPLATE_BUILDER (
        p_region IN apex_plugin.t_region,
        p_plugin IN apex_plugin.t_plugin,
        p_param  IN apex_plugin.t_region_render_param,
        p_result OUT apex_plugin.t_region_render_result
    );

    FUNCTION clob_base64_to_blob(p_clob IN CLOB) RETURN BLOB;

END EMAIL_TEMPLATE_PKG;
/