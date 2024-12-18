Return-Path: <stable+bounces-105114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B339F5EA7
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 07:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031F616387E
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 06:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8E7154C17;
	Wed, 18 Dec 2024 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="gQjiwuHy"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC90A14D430;
	Wed, 18 Dec 2024 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734503686; cv=none; b=nhIpbYkIQzthuLk7iFVqNpdGUL0pkjSXn1grnwZhul1cvDjO4oScdJiQpPjj0Fduypebc531KjlWzaX6E3dYgAuU1idTX2GavbIbhrn3NJhgKqwv5qV5bZAJsIto+10Om+FR+oHYE06u6319+VgSF+so8X8S6OTUjx/6ZxiqtuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734503686; c=relaxed/simple;
	bh=UXtSWeC2qaI3NDGyLmM3UDvC7qtbSBxUP7fLLnhoxmA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tY+xFk7ugLxW6jTsQ0TY/xZcDYqYBeF/IMyFk1HL8xUSsnwt4UlMQo5fDVZqUfMRS4/E0LbMemz2hh0nNtkVmyitZMqiD3HiM8ift6qTSxn6s5yYHWofbl0cT0eacIwh69O9jsB17cOQFXE9/gGlaRtDaZ+AznATbS26nfQfEHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=gQjiwuHy; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=B89UrKJxzsrE/qA+PJ
	a0BPmtaZIYFDVivwLXz6i3bRo=; b=gQjiwuHy9ZGXQGT7HSCOOlur7RBM/E6IIF
	oDMOSFyItErSjROI1Yy0yw+d1QLJ6xzpB3Ovmj1N65AkJQziOkhxMs6mjqXVRNw/
	wyiXp83sUiOuSzvcZyTum35vLN8fJ4f4Q4kw0e5E1ZyLRZww/SPxxF6NgvhYFE4u
	GEbuptIKE=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzsmtp5 (Coremail) with SMTP id qSkvCgAXrFSmbGJnzL0lCg--.36335S2;
	Wed, 18 Dec 2024 14:33:11 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	21cnbao@gmail.com,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	muchun.song@linux.dev,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>
Subject: [PATCH] replace free hugepage folios after migration
Date: Wed, 18 Dec 2024 14:33:08 +0800
Message-Id: <1734503588-16254-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:qSkvCgAXrFSmbGJnzL0lCg--.36335S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr15GFW3Cr1DuF47JF4rGrg_yoWrtF15pF
	y8Grn8GrWDJr9xur4xtan8Ar1avrWkZayjyFWfJ3sxZF13tr9F9Fyqywn0v3yrAr97CF4x
	ZFZIqFWkuF1UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoGQDUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQS5G2diZLmDAAAAsk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: yangge <yangge1116@126.com>

My machine has 4 NUMA nodes, each equipped with 32GB of memory. I
have configured each NUMA node with 16GB of CMA and 16GB of in-use
hugetlb pages. The allocation of contiguous memory via the
cma_alloc() function can fail probabilistically.

The cma_alloc() function may fail if it sees an in-use hugetlb page
within the allocation range, even if that page has already been
migrated. When in-use hugetlb pages are migrated, they may simply
be released back into the free hugepage pool instead of being
returned to the buddy system. This can cause the
test_pages_isolated() function check to fail, ultimately leading
to the failure of the cma_alloc() function:
cma_alloc()
    __alloc_contig_migrate_range() // migrate in-use hugepage
    test_pages_isolated()
        __test_page_isolated_in_pageblock()
             PageBuddy(page) // check if the page is in buddy

To address this issue, we will add a function named
replace_free_hugepage_folios(). This function will replace the
hugepage in the free hugepage pool with a new one and release the
old one to the buddy system. After the migration of in-use hugetlb
pages is completed, we will invoke the replace_free_hugepage_folios()
function to ensure that these hugepages are properly released to
the buddy system. Following this step, when the test_pages_isolated()
function is executed for inspection, it will successfully pass.

Signed-off-by: yangge <yangge1116@126.com>
---
 include/linux/hugetlb.h |  6 ++++++
 mm/hugetlb.c            | 37 +++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c         | 13 ++++++++++++-
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ae4fe86..7d36ac8 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -681,6 +681,7 @@ struct huge_bootmem_page {
 };
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
+int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
@@ -1059,6 +1060,11 @@ static inline int isolate_or_dissolve_huge_page(struct page *page,
 	return -ENOMEM;
 }
 
+int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
+{
+	return 0;
+}
+
 static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   int avoid_reserve)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 8e1db80..a099c54 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2975,6 +2975,43 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 	return ret;
 }
 
+/*
+ *  replace_free_hugepage_folios - Replace free hugepage folios in a given pfn
+ *  range with new folios.
+ *  @stat_pfn: start pfn of the given pfn range
+ *  @end_pfn: end pfn of the given pfn range
+ *  Returns 0 on success, otherwise negated error.
+ */
+int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
+{
+	struct hstate *h;
+	struct folio *folio;
+	int ret = 0;
+
+	LIST_HEAD(isolate_list);
+
+	while (start_pfn < end_pfn) {
+		folio = pfn_folio(start_pfn);
+		if (folio_test_hugetlb(folio)) {
+			h = folio_hstate(folio);
+		} else {
+			start_pfn++;
+			continue;
+		}
+
+		if (!folio_ref_count(folio)) {
+			ret = alloc_and_dissolve_hugetlb_folio(h, folio, &isolate_list);
+			if (ret)
+				break;
+
+			putback_movable_pages(&isolate_list);
+		}
+		start_pfn++;
+	}
+
+	return ret;
+}
+
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				    unsigned long addr, int avoid_reserve)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dde19db..1dcea28 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6504,7 +6504,18 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 	ret = __alloc_contig_migrate_range(&cc, start, end, migratetype);
 	if (ret && ret != -EBUSY)
 		goto done;
-	ret = 0;
+
+	/*
+	 * When in-use hugetlb pages are migrated, they may simply be
+	 * released back into the free hugepage pool instead of being
+	 * returned to the buddy system. After the migration of in-use
+	 * huge pages is completed, we will invoke the
+	 * replace_free_hugepage_folios() function to ensure that
+	 * these hugepages are properly released to the buddy system.
+	 */
+	ret = replace_free_hugepage_folios(start, end);
+	if (ret)
+		goto done;
 
 	/*
 	 * Pages from [start, end) are within a pageblock_nr_pages
-- 
2.7.4


