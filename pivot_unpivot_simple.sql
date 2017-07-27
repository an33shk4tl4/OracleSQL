--Pivot and Unpivot Examples using SH example schema in Oracle 

SELECT
  *
FROM
  (
    SELECT --s.time_id,
      --s.prod_id ,
      s.quantity_sold
      --, p.prod_name, p.prod_subcategory
      ,
      p.prod_category
      --, p.prod_status
    FROM
      sales s,
      products p
    WHERE
      s.prod_id = p.prod_id
  )
  pivot ( SUM(quantity_sold) FOR prod_category IN ('Electronics' ,'Hardware' ,
  'Peripherals and Accessories' ,'Photo','Software/Other' )) ;
  
--unpivot
SELECT
  *
FROM
  (
    SELECT
      *
    FROM
      (
        SELECT --s.time_id,
          --s.prod_id ,
          s.quantity_sold
          --, p.prod_name, p.prod_subcategory
          ,
          p.prod_category
          --, p.prod_status
        FROM
          sales s,
          products p
        WHERE
          s.prod_id = p.prod_id
      )
      pivot ( SUM(quantity_sold) FOR prod_category IN ('Electronics' AS elec ,
      'Hardware'                                                     AS hw ,
      'Peripherals and Accessories'                                  AS pa ,
      'Photo'                                                        AS photo,
      'Software/Other'                                               AS pso))
  )
  unpivot ( prod_cat_counts FOR prod_cat              IN (elec,hw, pso, photo, pa) )
  

  
  