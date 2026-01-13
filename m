Return-Path: <stable+bounces-208247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFB1D17379
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 09:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D03A306B695
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 08:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E9F3793A9;
	Tue, 13 Jan 2026 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rfOQTQJx"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9830FC03;
	Tue, 13 Jan 2026 08:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768291727; cv=none; b=kOszskLAMHGGqk1NJfzsKak7yWoCZ3NDbN8WeYQjku/OoBjgpCX3MFsR1cYnDklmGPwFvGNi4j+CEkzbmlptKI+BhsMUL3sNnq6+bQyGensJek+V0gIXXRycqH29b+Ju91ods4NqcfV5LsgwdsVNb3Sj5tWiBpabTwa2/j2jiH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768291727; c=relaxed/simple;
	bh=KR8VAdXnqb1E0mDYNJ4vmRgWXwNIwB7DZgabYsG5KNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cY/8XTGZFObVyEm/w7RMe++W8KfJycUbEVjykGBXaj8rr3v46jL4nY7Ew2k0KgSnlz6gzumim92iAK/ftomKXLRnhKYN55iOkZSgaEVzA2iscnYdiNp6/dNk9kxM5rSJom6E8hppzL9D6r36s345ff0iG9iBboxbShYH6Ioja9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rfOQTQJx; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1gjdO2735854;
	Tue, 13 Jan 2026 08:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=M2pHnaFbYyc3u5HyeOUk4EYddLfH6
	c49c5EKg1ravXQ=; b=rfOQTQJxinXZ7v3YkpL/Ie1RD0j8nxMnvxNH1kQJs6nCu
	hahdK8CnqSAwyP4381E+9C/KkdfM5NhJLNlfj61Fe8xztDRQQbRFtk7o4/4iR65q
	z2FVjaW26GXmEnE1TxNuTcNtYIQ0eyht4xXquxaWboAKRk0HFpljmod+GG/EVGfm
	hg1vdhydlG3znQOJVbh+c211yAv6FQWF98TEmIISBZKH50yRYBnKtszU5bQmkK/s
	cGB4NiWBTbYoDyP+7D3ppcZX/PHPrSk5xi9a5LdZvNud/vyldfJOZOivJbJ69Olb
	7A7TbLRf0GZ1E+ow32zxeavaKqCszxj95s7sWziDA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrr8ayc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 08:08:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D659Zg034682;
	Tue, 13 Jan 2026 08:08:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd78ewwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 08:08:11 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60D88Ahg038767;
	Tue, 13 Jan 2026 08:08:10 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bkd78ewra-1;
	Tue, 13 Jan 2026 08:08:10 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, stable@vger.kernel.org, muchun.song@linux.dev,
        osalvador@suse.de, david@kernel.org, linmiaohe@huawei.com,
        jiaqiyan@google.com, william.roche@oracle.com, rientjes@google.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@Oracle.com, rppt@kernel.org, surenb@google.com,
        mhocko@suse.com, willy@infradead.org
Subject: [PATCH v4 1/2] mm/memory-failure: fix missing ->mf_stats count in hugetlb poison
Date: Tue, 13 Jan 2026 01:07:50 -0700
Message-ID: <20260113080751.2173497-1-jane.chu@oracle.com>
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
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601130067
X-Proofpoint-ORIG-GUID: CWxXQq-dC-d3SGg0oam9JGVd2TezwAtx
X-Proofpoint-GUID: CWxXQq-dC-d3SGg0oam9JGVd2TezwAtx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA2NyBTYWx0ZWRfX0EUAjrIo+1eU
 d0eVnAFk3frK9PKjzaNLcBTAz4Sg0Nl8Q5LMNo7xIPk5SjdhqdfKnHR0bgop+Iz4JWVMWp+5xay
 Y3z+flZ6B5zUJe5LbYnK60noK0SIHJVOJTdBYiSkQKjj5TfOOipnzaSRVPaD7CjSi14Ac/tYa8R
 LwTMrwZlcpMh9NCnsQ8IgJ4uPB0j++Ueqxy+yNclFKLzULERWv1H3x7gbLSNiNG/gKqE4xlQOvq
 Ah/iJvMStKgASj9PKBvxFY4Omc8znOE687QOW+HD1WcCqQnRXDvY6Ow//9VDInapYWMbIWkySu2
 zbRKErKzTTrwXBIN/Q1xq3J+mugPEtp34poSFjXbscZR2CrRtvPtoihHhHXYeYpPh8Jrkuy5CQX
 kcLkxQVooZ5xxeV82Wk6xro8QKYSMvTpcIibbfOW00IqreiihxVoJmwUWpukhf63W7WgiwsGmeu
 oyZVdg9YeOvmA0Gss8g==
X-Authority-Analysis: v=2.4 cv=QIllhwLL c=1 sm=1 tr=0 ts=6965fd6c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=8moRJLxLMB3yPiChBVEA:9

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
v3 -> v4:
  incorporate/adapt David's suggestions.
v2 -> v3:
  No change.
v1 -> v2:
  adapted David and Liam's comment, define __get_huge_page_for_hwpoison()
return values in terms of symbol names instead of naked integers for better
readibility.  #define instead of enum is used since the function has footprint
outside MF, just try to limit the MF specifics local.
  also renamed folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison()
since the function does more than the conventional bit setting and the
fact three possible return values are expected.
---
 mm/memory-failure.c | 75 +++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fbc5a01260c8..b3e27451d618 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1883,12 +1883,24 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 	return count;
 }
 
-static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
+#define	MF_HUGETLB_FOLIO_PRE_POISONED	3  /* folio already poisoned */
+#define	MF_HUGETLB_PAGE_PRE_POISON	4  /* exact page already poisoned */
+/*
+ * Set hugetlb folio as hwpoisoned, update folio private raw hwpoison list
+ * to keep track of the poisoned pages.
+ * Return:
+ *	0: folio was not already poisoned;
+ *	MF_HUGETLB_FOLIO_PRE_POISONED: folio was already poisoned: either
+ *		multiple pages being poisoned, or per page information unclear,
+ *	MF_HUGETLB_PAGE_PRE_POISON: folio was already poisoned, an exact
+ *		poisoned page is being consumed again.
+ */
+static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
 {
 	struct llist_head *head;
 	struct raw_hwp_page *raw_hwp;
 	struct raw_hwp_page *p;
-	int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
+	int ret = folio_test_set_hwpoison(folio) ? MF_HUGETLB_FOLIO_PRE_POISONED : 0;
 
 	/*
 	 * Once the hwpoison hugepage has lost reliable raw error info,
@@ -1896,20 +1908,17 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
 	 * so skip to add additional raw error info.
 	 */
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
-		return -EHWPOISON;
+		return MF_HUGETLB_FOLIO_PRE_POISONED;
 	head = raw_hwp_list_head(folio);
 	llist_for_each_entry(p, head->first, node) {
 		if (p->page == page)
-			return -EHWPOISON;
+			return MF_HUGETLB_PAGE_PRE_POISON;
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
@@ -1955,44 +1964,43 @@ void folio_clear_hugetlb_hwpoison(struct folio *folio)
 	folio_free_raw_hwp(folio, true);
 }
 
+#define	MF_HUGETLB_FREED		0	/* freed hugepage */
+#define	MF_HUGETLB_IN_USED		1	/* in-use hugepage */
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
+	int ret = -EINVAL;
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
-		ret = folio_try_get(folio);
-		if (ret)
+		if (folio_try_get(folio)) {
+			ret = MF_HUGETLB_IN_USED;
 			count_increased = true;
+		} else
+			ret = MF_HUGETLB_FREED;
 	} else {
 		ret = -EBUSY;
 		if (!(flags & MF_NO_RETRY))
 			goto out;
 	}
 
-	if (folio_set_hugetlb_hwpoison(folio, page)) {
-		ret = -EHWPOISON;
+	rc = hugetlb_update_hwpoison(folio, page);
+	if (rc >= MF_HUGETLB_FOLIO_PRE_POISONED) {
+		ret = rc;
 		goto out;
 	}
 
@@ -2029,22 +2037,29 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 	*hugetlb = 1;
 retry:
 	res = get_huge_page_for_hwpoison(pfn, flags, &migratable_cleared);
-	if (res == 2) { /* fallback to normal page handling */
+	switch (res) {
+	case -EINVAL:	/* fallback to normal page handling */
 		*hugetlb = 0;
 		return 0;
-	} else if (res == -EHWPOISON) {
-		if (flags & MF_ACTION_REQUIRED) {
-			folio = page_folio(p);
-			res = kill_accessing_process(current, folio_pfn(folio), flags);
-		}
-		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
-		return res;
-	} else if (res == -EBUSY) {
+	case -EBUSY:
 		if (!(flags & MF_NO_RETRY)) {
 			flags |= MF_NO_RETRY;
 			goto retry;
 		}
 		return action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
+	case MF_HUGETLB_FOLIO_PRE_POISONED:
+	case MF_HUGETLB_PAGE_PRE_POISON:
+		if (flags & MF_ACTION_REQUIRED) {
+			folio = page_folio(p);
+			res = kill_accessing_process(current, folio_pfn(folio), flags);
+		}
+		if (res == MF_HUGETLB_FOLIO_PRE_POISONED)
+			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
+		else
+			action_result(pfn, MF_MSG_HUGE, MF_FAILED);
+		return res;
+	default:
+		break;
 	}
 
 	folio = page_folio(p);
-- 
2.43.5


