CREATE OR REPLACE VIEW "loms_material_assignment_config" AS
WITH base AS (
    SELECT
        c.id,

        m.materials_opportunity_name                              AS "Materials Opportunity",
        c.materials_opportunity_id                                AS "Materials Opportunity Id",

        s.name                                                    AS "Construction Stage",
        c.stage_id                                                AS "Stage Id",

        c.depot_id                                                AS "Depot Id",
        c.depot_name                                              AS "Depot Name",

        /* ---------------- Level 1 ---------------- */
        o1.owner                                                  AS "Level1 Owner",
        c.sla_level1_channel_partner_list                         AS "Level1 Channel Partner List",

        /* Split Level 1 list into 2 partner IDs (internal for joins) */
        TRY_CAST(trim(element_at(split(c.sla_level1_channel_partner_list, ','), 1)) AS bigint) AS lvl1_partner_id_1,
        TRY_CAST(trim(element_at(split(c.sla_level1_channel_partner_list, ','), 2)) AS bigint) AS lvl1_partner_id_2,

        c.sla_level1_threshold                                    AS "Level1 Threshold",
        c.sla_level1_threshold_period                             AS "Level1 Threshold Period",
        c.sla_level1_nudge                                        AS "Level1 Nudge",
        c.sla_level1_nudge_period                                 AS "Level1 Nudge Period",
        c.sla_level1_esc                                          AS "Level1 Escalation",
        c.sla_level1_esc_period                                   AS "Level1 Escalation Period",
        c.sla_level1_esc_team                                     AS "Level1 Escalation Team",
        aw1.workgroup_name                                        AS "Level1 Workgroup",
        r1.role_name                                              AS "Level1 Role",

        /* ---------------- Level 2 ---------------- */
        o2.owner                                                  AS "Level2 Owner",
        c.sla_level2_channel_partner_list                         AS "Level2 Channel Partner List",

        /* Split Level 2 list into 2 partner IDs (internal for joins) */
        TRY_CAST(trim(element_at(split(c.sla_level2_channel_partner_list, ','), 1)) AS bigint) AS lvl2_partner_id_1,
        TRY_CAST(trim(element_at(split(c.sla_level2_channel_partner_list, ','), 2)) AS bigint) AS lvl2_partner_id_2,

        c.sla_level2_threshold                                    AS "Level2 Threshold",
        c.sla_level2_threshold_period                             AS "Level2 Threshold Period",
        c.sla_level2_nudge                                        AS "Level2 Nudge",
        c.sla_level2_nudge_period                                 AS "Level2 Nudge Period",
        c.sla_level2_esc                                          AS "Level2 Escalation",
        c.sla_level2_esc_period                                   AS "Level2 Escalation Period",
        c.sla_level2_esc_team                                     AS "Level2 Escalation Team",
        aw2.workgroup_name                                        AS "Level2 Workgroup",
        r2.role_name                                              AS "Level2 Role"

    FROM database_utec_raw.lomsdb_manual_config_material_opportunity c
    LEFT JOIN database_utec_raw.lomsdb_materials_opportunity m
        ON c.materials_opportunity_id = m.id
    LEFT JOIN database_utec_raw.lomsdb_construction_stages s
        ON c.stage_id = s.id

    /* Level 1 lookups */
    LEFT JOIN database_utec_raw.lomsdb_opportunity_owner o1
        ON c.sla_level1_owner = o1.id
    LEFT JOIN database_utec_raw.utecalpha_utech_idp_admin_workgroup_roles r1
        ON c.sla_level1_role = r1.id
    LEFT JOIN database_utec_raw.utecalpha_utech_idp_admin_workgroups aw1
        ON c.sla_level1_workgroup = aw1.id

    /* Level 2 lookups */
    LEFT JOIN database_utec_raw.lomsdb_opportunity_owner o2
        ON c.sla_level2_owner = o2.id
    LEFT JOIN database_utec_raw.utecalpha_utech_idp_admin_workgroup_roles r2
        ON c.sla_level2_role = r2.id
    LEFT JOIN database_utec_raw.utecalpha_utech_idp_admin_workgroups aw2
        ON c.sla_level2_workgroup = aw2.id
)

SELECT
    /* ===== Order as per your required sequence ===== */
    b.id,
    b."Materials Opportunity",
    b."Materials Opportunity Id",
    b."Construction Stage",
    b."Stage Id",
    b."Depot Id",
    b."Depot Name",

    b."Level1 Owner",
    -- b."Level1 Channel Partner List",
    cp1_1.owner                                                 AS "Level1 Channel Partner Name 1",
    cp1_2.owner                                                 AS "Level1 Channel Partner Name 2",
    b."Level1 Threshold",
    b."Level1 Threshold Period",
    b."Level1 Nudge",
    b."Level1 Nudge Period",
    b."Level1 Escalation",
    b."Level1 Escalation Period",
    b."Level1 Escalation Team",
    b."Level1 Workgroup",
    b."Level1 Role",

    b."Level2 Owner",
    -- b."Level2 Channel Partner List",
    cp2_1.owner                                                 AS "Level2 Channel Partner Name 1",
    cp2_2.owner                                                 AS "Level2 Channel Partner Name 2",
    b."Level2 Threshold",
    b."Level2 Threshold Period",
    b."Level2 Nudge",
    b."Level2 Nudge Period",
    b."Level2 Escalation",
    b."Level2 Escalation Period",
    b."Level2 Escalation Team",
    b."Level2 Workgroup",
    b."Level2 Role"

FROM base b
LEFT JOIN database_utec_raw.lomsdb_channel_partner_list cp1_1
    ON b.lvl1_partner_id_1 = cp1_1.id
LEFT JOIN database_utec_raw.lomsdb_channel_partner_list cp1_2
    ON b.lvl1_partner_id_2 = cp1_2.id
LEFT JOIN database_utec_raw.lomsdb_channel_partner_list cp2_1
    ON b.lvl2_partner_id_1 = cp2_1.id
LEFT JOIN database_utec_raw.lomsdb_channel_partner_list cp2_2
    ON b.lvl2_partner_id_2 = cp2_2.id
