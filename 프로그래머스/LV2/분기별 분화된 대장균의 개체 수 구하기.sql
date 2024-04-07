/*
**문제 설명**
대장균들은 일정 주기로 분화하며, 분화를 시작한 개체를 부모 개체, 분화가 되어 나온 개체를 자식 개체라고 합니다.
다음은 실험실에서 배양한 대장균들의 정보를 담은 ECOLI_DATA 테이블입니다. ECOLI_DATA 테이블의 구조는 다음과 같으며, ID, PARENT_ID, SIZE_OF_COLONY, DIFFERENTIATION_DATE, GENOTYPE 은 각각 대장균 개체의 ID, 부모 개체의 ID, 개체의 크기, 분화되어 나온 날짜, 개체의 형질을 나타냅니다.
최초의 대장균 개체의 PARENT_ID 는 NULL 값입니다.
**문제**
각 분기(QUARTER)별 분화된 대장균의 개체의 총 수(ECOLI_COUNT)를 출력하는 SQL 문을 작성해주세요. 이때 각 분기에는 'Q' 를 붙이고 분기에 대해 오름차순으로 정렬해주세요. 대장균 개체가 분화되지 않은 분기는 없습니다.
*/

SELECT 
    CASE
        WHEN MONTH(DIFFERENTIATION_DATE) IN (1, 2, 3) THEN '1Q'
        WHEN MONTH(DIFFERENTIATION_DATE) IN (4, 5, 6) THEN '2Q'
        WHEN MONTH(DIFFERENTIATION_DATE) IN (7, 8, 9) THEN '3Q'
        WHEN MONTH(DIFFERENTIATION_DATE) IN (10, 11, 12) THEN '4Q'
    END AS QUARTER, 
COUNT(ID) AS ECOLI_COUNT
FROM ECOLI_DATA
GROUP BY QUARTER
ORDER BY QUARTER;
