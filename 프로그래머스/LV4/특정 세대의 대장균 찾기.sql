/*
**문제 설명**
대장균들은 일정 주기로 분화하며, 분화를 시작한 개체를 부모 개체, 분화가 되어 나온 개체를 자식 개체라고 합니다.
다음은 실험실에서 배양한 대장균들의 정보를 담은 ECOLI_DATA 테이블입니다. ECOLI_DATA 테이블의 구조는 다음과 같으며, ID, PARENT_ID, SIZE_OF_COLONY, DIFFERENTIATION_DATE, GENOTYPE 은 각각 대장균 개체의 ID, 부모 개체의 ID, 개체의 크기, 분화되어 나온 날짜, 개체의 형질을 나타냅니다.
최초의 대장균 개체의 PARENT_ID 는 NULL 값입니다.
**문제**
3세대의 대장균의 ID(ID) 를 출력하는 SQL 문을 작성해주세요. 이때 결과는 대장균의 ID 에 대해 오름차순 정렬해주세요.
*/

SELECT ID
FROM ECOLI_DATA
WHERE PARENT_ID IN (
    SELECT ID
    FROM ECOLI_DATA
    WHERE PARENT_ID IN (
        SELECT ID
        FROM ECOLI_DATA
        WHERE PARENT_ID IS NULL))
ORDER BY ID;

/*WITH 를 사용한 풀이 법 */
WITH FIRST_GENERATION AS (
  SELECT ID
  FROM ECOLI_DATA
  WHERE PARENT_ID IS NULL
)
, SECOND_GENERATION AS (
  SELECT E.ID
  FROM ECOLI_DATA E
  LEFT JOIN FIRST_GENERATION F
    ON E.PARENT_ID = F.ID
  WHERE F.ID IS NOT NULL
)
SELECT E.ID
FROM ECOLI_DATA E
LEFT JOIN SECOND_GENERATION S
  ON E.PARENT_ID = S.ID
WHERE S.ID IS NOT NULL
ORDER BY E.ID ASC;
