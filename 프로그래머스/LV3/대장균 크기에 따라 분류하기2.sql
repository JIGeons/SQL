/*
**문제 설명**
대장균들은 일정 주기로 분화하며, 분화를 시작한 개체를 부모 개체, 분화가 되어 나온 개체를 자식 개체라고 합니다.
다음은 실험실에서 배양한 대장균들의 정보를 담은 ECOLI_DATA 테이블입니다. ECOLI_DATA 테이블의 구조는 다음과 같으며, ID, PARENT_ID, SIZE_OF_COLONY, DIFFERENTIATION_DATE, GENOTYPE 은 각각 대장균 개체의 ID, 부모 개체의 ID, 개체의 크기, 분화되어 나온 날짜, 개체의 형질을 나타냅니다.
최초의 대장균 개체의 PARENT_ID 는 NULL 값입니다.
**문제**
대장균 개체의 크기를 내름차순으로 정렬했을 때 상위 0% ~ 25% 를 'CRITICAL', 26% ~ 50% 를 'HIGH', 51% ~ 75% 를 'MEDIUM', 76% ~ 100% 를 'LOW' 라고 분류합니다. 대장균 개체의 ID(ID) 와 분류된 이름(COLONY_NAME)을 출력하는 SQL 문을 작성해주세요. 이때 결과는 개체의 ID 에 대해 오름차순 정렬해주세요 . 단, 총 데이터의 수는 4의 배수이며 같은 사이즈의 대장균 개체가 서로 다른 이름으로 분류되는 경우는 없습니다.
*/

WITH CTE AS (
SELECT ID, 
    RANK() OVER(ORDER BY SIZE_OF_COLONY DESC) AS RNK,
    MAX(ID) OVER() AS TOTAL
FROM ECOLI_DATA)

SELECT ID, 
    CASE
        WHEN RNK <= (TOTAL / 4) THEN 'CRITICAL'
        WHEN RNK <= (TOTAL / 2) THEN 'HIGH'
        WHEN RNK <= (TOTAL / 4 * 3) THEN 'MEDIUM'
        ELSE 'LOW'
    END AS 'COLONY_NAME'
FROM CTE
ORDER BY ID;
