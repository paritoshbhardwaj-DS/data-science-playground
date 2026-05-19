CREATE OR REPLACE VIEW "loms_service_assignment_config" AS

SELECT
    c.id                                                        AS id,
    m.service_opportunity_name                                AS Service_Opportunity,
    c.service_opportunity_id                                  AS Service_Opportunity_Id,
    s.name                                                    AS Construction_Stage,
    c.stage_id                                                AS Stage_Id,
    c.depot_id                                                AS Depot_Id,
    c.depot_name                                              AS Depot_Name,

    /* -------- Level 1 -------- */
    -- c.sla_level1_owner                                        AS sla_level1_owner,
    o1.owner                                                  AS Level1_Owner,
    c.sla_level1_channel_partner_list                         AS Level1_Channel_Partner_List,
    c.sla_level1_threshold                                    AS Level1_Threshold,
    c.sla_level1_threshold_period                             AS Level1_Threshold_Period,
    c.sla_level1_nudge                                        AS Level1_Nudge,
    c.sla_level1_nudge_period                                 AS Level1_Nudge_Period,
    c.sla_level1_esc                                          AS Level1_Escalation,
    c.sla_level1_esc_period                                   AS Level1_Escalation_Period,
    c.sla_level1_esc_team                                     AS Level1_Escalation_Team,
        -- c.sla_level1_workgroup                                    AS sla_level1_workgroup,
    aw1.workgroup_name                                        AS Level1_Workgroup,
    -- c.sla_level1_role                                         AS sla_level1_role,
    r1.role_name                                              AS Level1_Role,

    /* -------- Level 2 -------- */
    -- c.sla_level2_owner                                        AS sla_level2_owner,
    o2.owner                                                  AS Level2_Owner,
    c.sla_level2_channel_partner_list                         AS Level2_Channel_Partner_List,

    c.sla_level2_threshold                                    AS Level2_Threshold,
    c.sla_level2_threshold_period                             AS Level2_Threshold_Period,
    c.sla_level2_nudge                                        AS Level2_Nudge,
    c.sla_level2_nudge_period                                 AS Level2_Nudge_Period,
    c.sla_level2_esc                                          AS Level2_Escalation,
    c.sla_level2_esc_period                                   AS Level2_Escalation_Period,
    c.sla_level2_esc_team                                     AS Level2_Escalation_Team,
    -- c.sla_level2_workgroup                                    AS sla_level2_workgroup,
    aw2.workgroup_name                                        AS Level2_Workgroup,
    -- c.sla_level2_role                                         AS sla_level2_role,
    r2.role_name                                              AS Level2_Role

FROM database_utec_raw.lomsdb_manual_config_service_opportunity c
LEFT JOIN database_utec_raw.lomsdb_service_opportunity m
    ON c.service_opportunity_id = m.id
LEFT JOIN database_utec_raw.lomsdb_construction_stages s
    ON c.stage_id = s.id

LEFT JOIN database_utec_raw.lomsdb_opportunity_owner o1
    ON c.sla_level1_owner = o1.id
LEFT JOIN database_utec_raw.utecalpha_utech_idp_admin_workgroup_roles r1
    ON c.sla_level1_role = r1.id
LEFT JOIN database_utec_raw.utecalpha_utech_idp_admin_workgroups aw1
    ON c.sla_level1_workgroup = aw1.id

LEFT JOIN database_utec_raw.lomsdb_opportunity_owner o2
    ON c.sla_level2_owner = o2.id
LEFT JOIN database_utec_raw.utecalpha_utech_idp_admin_workgroup_roles r2
    ON c.sla_level2_role = r2.id
LEFT JOIN database_utec_raw.utecalpha_utech_idp_admin_workgroups aw2
    ON c.sla_level2_workgroup = aw2.id