Return-Path: <stable+bounces-203114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A872CD191E
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 20:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19BAE3020344
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 19:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AAB2BE032;
	Fri, 19 Dec 2025 19:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EAvUJWcz"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3A12459D1;
	Fri, 19 Dec 2025 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766171798; cv=none; b=fkvzmXfmpEc8mkFJURpl144kEWpVV8lfVI7Y5yO0Y5ekXi9eWU1YaPahRG7KqYUCvpiC9QkckuJVjojENltuf+5mj1VBogs6diClVf1liKsRjPYxHfhc520m031B23mC79V/caAGsqkKezEUdIiVDmszZivAGs7gfcEdrGrVG5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766171798; c=relaxed/simple;
	bh=V+qUJ9Rwb4sHPzcy78mi+Xi9npeXs4W4RiTMCBZYyqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcfU931qTbjods7pbEoMBL4WepBnAZffm3/ZZYlkDOT58cKXs6UDl8o4Vn4yjfRXg+iXVgbK9/cKR+zwXsJIK8RFLHi5ULsbGRh8ASF6vl4O/C1tOXPACLqJR3jiNMO9uWra8112V9N6LKmn7AS83RdN03Q6fx5myHA0SKY8nXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EAvUJWcz; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJJCG1M239035;
	Fri, 19 Dec 2025 19:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=xQZOjOLqndItDxSuuICusJe4gUprj
	MDmTGesnzlyh7Y=; b=EAvUJWczU3KZmpDENoU1rVm6BEmCh/lADK3UGE3pYCJfm
	gYkMewkWHn4bSU269POXPIr6RYGSdklt2zDgBlbdbw86Ao4fu8DzjvhWkn/RP9Di
	XOOPA3ICDUFGfqShJJjNtmaD1V9ta/SGhs1SMdRUlGCJF3Dj9gH97zFbcEB+MHV/
	JoE9Dy5gHBeKBvOAkC/BzskCAlvOgjGUiulH5Er/DuXeL7V3d55ZwEPArrTlagSg
	/V1xv7wu6zkb1p45Z6wwKPKMfRlbdjyHyR7Wah7ai6GMOTfOkEdWKBjLxaALIfrN
	071T0oH0pgNyzdwDgYVusbMDtnUHVzNiK85lu8y+A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r291mtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 19:16:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJJBerX034854;
	Fri, 19 Dec 2025 19:16:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtdvjju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 19:16:13 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BJJGDK4028211;
	Fri, 19 Dec 2025 19:16:13 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4b4qtdvjj1-1;
	Fri, 19 Dec 2025 19:16:13 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, stable@vger.kernel.org, muchun.song@linux.dev,
        osalvador@suse.de, david@kernel.org, linmiaohe@huawei.com,
        jiaqiyan@google.com, william.roche@oracle.com, rientjes@google.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@Oracle.com, rppt@kernel.org, surenb@google.com,
        mhocko@suse.com
Subject: [PATCH v2] mm/memory-failure: fix missing ->mf_stats count in hugetlb poison
Date: Fri, 19 Dec 2025 12:15:58 -0700
Message-ID: <20251219191559.2962716-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_07,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512190161
X-Authority-Analysis: v=2.4 cv=WZgBqkhX c=1 sm=1 tr=0 ts=6945a47e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=0f2F8jj5qo72ZdTnQt8A:9
X-Proofpoint-ORIG-GUID: AJaM2KpF6RXVrX7m5onzSgpPauQZeLvK
X-Proofpoint-GUID: AJaM2KpF6RXVrX7m5onzSgpPauQZeLvK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDE2MSBTYWx0ZWRfX4IhXefT2nOw0
 JivMV3mtwoxrk0TbHY4W6YiyYW5BlptMqmYvVUi5ZeOxoC8+EAtk3kh1Y8plPQfPz9yDQGZAG0G
 L3lgLFPMPZTuPYhAVHytjWLo+VFt16TGrt3kNa04nO/XFtcJyf3wcoXAOFZfiPk3ZYGE/eYv3xK
 JVUeBi9sqdpJPqajn7P/cLCZPbSHQGTlBVdwXz7JuFCVpxQKkNVt92u/ENUHfVfhy3fjXWe4Um0
 Y6SQ/QFL4u5nuFvZi3YMUDGThezskxIEGZ5z5xeROCfIX+p6UDVwylFd1erYuR621AuqLhV5U/B
 WM6rFHN+zin7eZ622EDb+ut+prihC4YmCZjUT2/1BK3FPeUDO1R+mBFD7swSZmmGzMkRZoJYJ1X
 0NkRkJX4w/0pWdR3rXfUK1JLHkWbHx21zOZB92aKq0o7CipDXM1pIf3/1Uq8aXg8rDAupo8+GCT
 6EzwRq0R5sw6+IFuohA==

When a newly poisoned subpage ends up in an already poisoned hugetlb
folio, 'num_poisoned_pages' is incremented, but the per node ->mf_stats
is not. Fix the inconsistency by designating action_result() to update
them both.

While at it, define __get_huge_page_for_hwpoison() return values in terms
of symbol names for better readibility. Also rename
folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison() since the
function does more than the conventional bit setting and the fact
three possible return values are expected.

Fixes: 18f41fa616ee4 ("mm: memory-failure: bump memory failure stats to pglist_data")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
v1 -> v2:
  adapted David and Liam's comment, define __get_huge_page_for_hwpoison()
return values in terms of symbol names instead of naked integers for better
readibility.  #define instead of enum is used since the function has footprint
outside MF, just try to limit the MF specifics local.
  also renamed folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison()
since the function does more than the conventional bit setting and the
fact three possible return values are expected.
---
 mm/memory-failure.c | 56 ++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 3edebb0cda30..3eb9d23a4ad0 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1873,12 +1873,18 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 	return count;
 }
 
-static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
+#define	MF_HUGETLB_ALREADY_POISONED	3  /* already poisoned */
+#define	MF_HUGETLB_ACC_EXISTING_POISON	4  /* accessed existing poisoned page */
+/*
+ * Set hugetlb folio as hwpoisoned, update folio private raw hwpoison list
+ * to keep track of the poisoned pages.
+ */
+static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
 {
 	struct llist_head *head;
 	struct raw_hwp_page *raw_hwp;
 	struct raw_hwp_page *p;
-	int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
+	int ret = folio_test_set_hwpoison(folio) ? MF_HUGETLB_ALREADY_POISONED : 0;
 
 	/*
 	 * Once the hwpoison hugepage has lost reliable raw error info,
@@ -1886,20 +1892,18 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
 	 * so skip to add additional raw error info.
 	 */
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
-		return -EHWPOISON;
+		return MF_HUGETLB_ALREADY_POISONED;
+
 	head = raw_hwp_list_head(folio);
 	llist_for_each_entry(p, head->first, node) {
 		if (p->page == page)
-			return -EHWPOISON;
+			return MF_HUGETLB_ACC_EXISTING_POISON;
 	}
 
 	raw_hwp = kmalloc(sizeof(struct raw_hwp_page), GFP_ATOMIC);
 	if (raw_hwp) {
 		raw_hwp->page = page;
 		llist_add(&raw_hwp->node, head);
-		/* the first error event will be counted in action_result(). */
-		if (ret)
-			num_poisoned_pages_inc(page_to_pfn(page));
 	} else {
 		/*
 		 * Failed to save raw error info.  We no longer trace all
@@ -1945,32 +1949,30 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
 	folio_free_raw_hwp(folio, true);
 }
 
+#define	MF_HUGETLB_FREED			0	/* freed hugepage */
+#define	MF_HUGETLB_IN_USED			1	/* in-use hugepage */
+#define	MF_NOT_HUGETLB				2	/* not a hugepage */
+
 /*
  * Called from hugetlb code with hugetlb_lock held.
- *
- * Return values:
- *   0             - free hugepage
- *   1             - in-use hugepage
- *   2             - not a hugepage
- *   -EBUSY        - the hugepage is busy (try to retry)
- *   -EHWPOISON    - the hugepage is already hwpoisoned
  */
 int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 				 bool *migratable_cleared)
 {
 	struct page *page = pfn_to_page(pfn);
 	struct folio *folio = page_folio(page);
-	int ret = 2;	/* fallback to normal page handling */
+	int ret = MF_NOT_HUGETLB;
 	bool count_increased = false;
+	int rc;
 
 	if (!folio_test_hugetlb(folio))
 		goto out;
 
 	if (flags & MF_COUNT_INCREASED) {
-		ret = 1;
+		ret = MF_HUGETLB_IN_USED;
 		count_increased = true;
 	} else if (folio_test_hugetlb_freed(folio)) {
-		ret = 0;
+		ret = MF_HUGETLB_FREED;
 	} else if (folio_test_hugetlb_migratable(folio)) {
 		ret = folio_try_get(folio);
 		if (ret)
@@ -1981,8 +1983,9 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
 			goto out;
 	}
 
-	if (folio_set_hugetlb_hwpoison(folio, page)) {
-		ret = -EHWPOISON;
+	rc = hugetlb_update_hwpoison(folio, page);
+	if (rc >= MF_HUGETLB_ALREADY_POISONED) {
+		ret = rc;
 		goto out;
 	}
 
@@ -2019,22 +2022,29 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	*hugetlb = 1;
 retry:
 	res = get_huge_page_for_hwpoison(pfn, flags, &migratable_cleared);
-	if (res == 2) { /* fallback to normal page handling */
+	switch (res) {
+	case MF_NOT_HUGETLB:	/* fallback to normal page handling */
 		*hugetlb = 0;
 		return 0;
-	} else if (res == -EHWPOISON) {
+	case MF_HUGETLB_ALREADY_POISONED:
+	case MF_HUGETLB_ACC_EXISTING_POISON:
 		if (flags & MF_ACTION_REQUIRED) {
 			folio = page_folio(p);
 			res = kill_accessing_process(current, folio_pfn(folio), flags);
 		}
-		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
+		if (res == MF_HUGETLB_ALREADY_POISONED)
+			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
+		else
+			action_result(pfn, MF_MSG_HUGE, MF_FAILED);
 		return res;
-	} else if (res == -EBUSY) {
+	case -EBUSY:
 		if (!(flags & MF_NO_RETRY)) {
 			flags |= MF_NO_RETRY;
 			goto retry;
 		}
 		return action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
+	default:
+		break;
 	}
 
 	folio = page_folio(p);
-- 
2.43.5


