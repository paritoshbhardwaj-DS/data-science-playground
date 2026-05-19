CREATE OR REPLACE VIEW loms_opportunity AS
SELECT
    lo.opportunity_id,
    l.site_id,
    CAST(l.creation_date AS date)                                          AS creation_date,
    CASE WHEN l.is_verified = 1 THEN 'Yes' ELSE 'No' END                    AS site_verified,
    l.stage_of_construction,
    l.platform,
    g.depot_name,
    g.region_name,
    g.zone_name,
    l.site_status,
    lst.name                                                                AS stage,
    lo.opportunity_type,
    lo.opportunity_owner_id,
    oo.owner,
    COALESCE(lm.materials_opportunity_name, ls.service_opportunity_name)    AS opportunity_name,
    lu1.unit_name                                                           AS unit,
    lo.opportunity_status,
    lo.opportunity_total_qty,
    lo.opportunity_total_sold_qty,
    lo.opportunity_total_remain_qty,
    lo.stage_potential,
    lo.stage_total_qty,
    lo.stage_sold_qty,
    lo.stage_remain_qty,
    CAST(lo.created_at AS date)                                             AS opp_creation_date,
    CAST(lo.updated_at AS date)                                             AS opp_update_date,
    lo.dealer_id,
    lo.dealer_name,
    opportunity_type_id, construction_stage_id
FROM database_utec_raw.lomsdb_sites l
LEFT JOIN database_utec_raw.utecalpha_utech_idp_utec_geography g
    ON l.pin = g.pincode
LEFT JOIN database_utec_raw.lomsdb_opportunity lo
    ON lo.utec_site_id = l.site_id
LEFT JOIN database_utec_raw.lomsdb_materials_opportunity lm
    ON lm.id = lo.opportunity_type_id
   AND lo.opportunity_type = 'material'
LEFT JOIN database_utec_raw.lomsdb_service_opportunity ls
    ON ls.id = lo.opportunity_type_id
   AND lo.opportunity_type = 'service'
LEFT JOIN database_utec_raw.lomsdb_units lu1
    ON lu1.id = lm.unit
LEFT JOIN database_utec_raw.lomsdb_construction_stages lst
    ON lo.construction_stage_id = lst.id
LEFT JOIN database_utec_raw.lomsdb_opportunity_owner oo
    ON lo.opportunity_owner_id = oo.id
WHERE CAST(l.creation_date AS date) >= DATE '2025-01-01'
;