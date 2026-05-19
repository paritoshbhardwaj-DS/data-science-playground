CREATE OR REPLACE VIEW loms_opportunity_assignement AS
WITH unified_config AS (

    /* ===================== SERVICE CONFIG ===================== */
    SELECT
        'service'                                            AS opportunity_type,

        id                                                   AS config_id,
        Service_Opportunity                                  AS opportunity_name,
        Service_Opportunity_Id                               AS opportunity_id,

        Construction_Stage                                   AS construction_stage,
        Stage_Id                                             AS stage_id,

        Depot_Id                                             AS depot_id,
        Depot_Name                                           AS depot_name,

        Level1_Owner                                         AS level1_owner,
        Level1_Channel_Partner_List                          AS level1_channel_partner_list,
        CAST(NULL AS varchar)                                AS level1_channel_partner_name_1,
        CAST(NULL AS varchar)                                AS level1_channel_partner_name_2,
        Level1_Threshold                                     AS level1_threshold,
        Level1_Threshold_Period                              AS level1_threshold_period,
        Level1_Nudge                                         AS level1_nudge,
        Level1_Nudge_Period                                  AS level1_nudge_period,
        Level1_Escalation                                    AS level1_escalation,
        Level1_Escalation_Period                             AS level1_escalation_period,
        Level1_Escalation_Team                               AS level1_escalation_team,
        Level1_Workgroup                                     AS level1_workgroup,
        Level1_Role                                          AS level1_role,

        Level2_Owner                                         AS level2_owner,
        Level2_Channel_Partner_List                          AS level2_channel_partner_list,
        CAST(NULL AS varchar)                                AS level2_channel_partner_name_1,
        CAST(NULL AS varchar)                                AS level2_channel_partner_name_2,
        Level2_Threshold                                     AS level2_threshold,
        Level2_Threshold_Period                              AS level2_threshold_period,
        Level2_Nudge                                         AS level2_nudge,
        Level2_Nudge_Period                                  AS level2_nudge_period,
        Level2_Escalation                                    AS level2_escalation,
        Level2_Escalation_Period                             AS level2_escalation_period,
        Level2_Escalation_Team                               AS level2_escalation_team,
        Level2_Workgroup                                     AS level2_workgroup,
        Level2_Role                                          AS level2_role
    FROM loms_service_assignment_config

    UNION ALL

    /* ===================== MATERIAL CONFIG ===================== */
    SELECT
        'material'                                           AS opportunity_type,

        id                                                   AS config_id,
        "Materials Opportunity"                              AS opportunity_name,
        "Materials Opportunity Id"                           AS opportunity_id,

        "Construction Stage"                                 AS construction_stage,
        "Stage Id"                                           AS stage_id,

        "Depot Id"                                           AS depot_id,
        "Depot Name"                                         AS depot_name,

        "Level1 Owner"                                       AS level1_owner,
        CAST(NULL AS varchar)                                AS level1_channel_partner_list,
        "Level1 Channel Partner Name 1"                      AS level1_channel_partner_name_1,
        "Level1 Channel Partner Name 2"                      AS level1_channel_partner_name_2,
        "Level1 Threshold"                                   AS level1_threshold,
        "Level1 Threshold Period"                            AS level1_threshold_period,
        "Level1 Nudge"                                       AS level1_nudge,
        "Level1 Nudge Period"                                AS level1_nudge_period,
        "Level1 Escalation"                                  AS level1_escalation,
        "Level1 Escalation Period"                           AS level1_escalation_period,
        "Level1 Escalation Team"                             AS level1_escalation_team,
        "Level1 Workgroup"                                   AS level1_workgroup,
        "Level1 Role"                                        AS level1_role,

        "Level2 Owner"                                       AS level2_owner,
        CAST(NULL AS varchar)                                AS level2_channel_partner_list,
        "Level2 Channel Partner Name 1"                      AS level2_channel_partner_name_1,
        "Level2 Channel Partner Name 2"                      AS level2_channel_partner_name_2,
        "Level2 Threshold"                                   AS level2_threshold,
        "Level2 Threshold Period"                            AS level2_threshold_period,
        "Level2 Nudge"                                       AS level2_nudge,
        "Level2 Nudge Period"                                AS level2_nudge_period,
        "Level2 Escalation"                                  AS level2_escalation,
        "Level2 Escalation Period"                           AS level2_escalation_period,
        "Level2 Escalation Team"                             AS level2_escalation_team,
        "Level2 Workgroup"                                   AS level2_workgroup,
        "Level2 Role"                                        AS level2_role
    FROM loms_material_assignment_config
)

SELECT
    l.*,

    /* NEW: days since opportunity was created */
    date_diff('day', CAST(l.opp_creation_date AS date), current_date) AS days_opportunity_creation,

    -- rename config fields to avoid collision with l.*
    uc.config_id                          AS cfg_config_id,
    uc.opportunity_name                   AS cfg_opportunity_name,
    uc.opportunity_id                     AS cfg_opportunity_id,
    uc.construction_stage                 AS cfg_construction_stage,
    uc.stage_id                           AS cfg_stage_id,
    uc.depot_id                           AS cfg_depot_id,
    uc.depot_name                         AS cfg_depot_name,

    uc.level1_owner                       AS cfg_level1_owner,
    uc.level1_channel_partner_list        AS cfg_level1_channel_partner_list,
    uc.level1_channel_partner_name_1      AS cfg_level1_channel_partner_name_1,
    uc.level1_channel_partner_name_2      AS cfg_level1_channel_partner_name_2,
    uc.level1_threshold                   AS cfg_level1_threshold,
    uc.level1_threshold_period            AS cfg_level1_threshold_period,
    uc.level1_nudge                       AS cfg_level1_nudge,
    uc.level1_nudge_period                AS cfg_level1_nudge_period,
    uc.level1_escalation                  AS cfg_level1_escalation,
    uc.level1_escalation_period           AS cfg_level1_escalation_period,
    uc.level1_escalation_team             AS cfg_level1_escalation_team,
    uc.level1_workgroup                   AS cfg_level1_workgroup,
    uc.level1_role                        AS cfg_level1_role,

    uc.level2_owner                       AS cfg_level2_owner,
    uc.level2_channel_partner_list        AS cfg_level2_channel_partner_list,
    uc.level2_channel_partner_name_1      AS cfg_level2_channel_partner_name_1,
    uc.level2_channel_partner_name_2      AS cfg_level2_channel_partner_name_2,
    uc.level2_threshold                   AS cfg_level2_threshold,
    uc.level2_threshold_period            AS cfg_level2_threshold_period,
    uc.level2_nudge                       AS cfg_level2_nudge,
    uc.level2_nudge_period                AS cfg_level2_nudge_period,
    uc.level2_escalation                  AS cfg_level2_escalation,
    uc.level2_escalation_period           AS cfg_level2_escalation_period,
    uc.level2_escalation_team             AS cfg_level2_escalation_team,
    uc.level2_workgroup                   AS cfg_level2_workgroup,
    uc.level2_role                        AS cfg_level2_role,

    -- rename ssd fields too (in case l has same column names)
    ssd.current_stage                     AS site_current_stage,
    ssd.days_since_stage_update           AS site_days_since_stage_update

FROM loms_opportunity l
LEFT JOIN unified_config uc
    ON l.opportunity_type = uc.opportunity_type
   AND l.opportunity_type_id = uc.opportunity_id
   AND l.construction_stage_id = uc.stage_id
   AND l.depot_name = uc.depot_name
LEFT JOIN database_utec_tableau.site_stage_days ssd
    ON l.site_id = ssd.site_id
