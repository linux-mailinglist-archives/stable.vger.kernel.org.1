Return-Path: <stable+bounces-116955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A281EA3B028
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 04:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1A03A9592
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 03:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0022917A2E7;
	Wed, 19 Feb 2025 03:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Qb8paGPI"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0968C0B;
	Wed, 19 Feb 2025 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739936883; cv=none; b=nn2XArOHZPiNm7e5dNzs91jrESYEKKeYm98uINziEAwxc+S+GnTsZNaIjvD2wt+d4Ov5HMBUqOFqMC1LfsIIBaF4pgu1ANixWs8kWDHkkucDVEHkRGE9s4O5ApErdLd5ljozz0oxoBRGypVbE7Uxc8bsfnykJaReZZkKRfzM2QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739936883; c=relaxed/simple;
	bh=ajiNqse0D4KHIzDi1im2/EXy6v44Er7rj0RjoYYrgLE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DFbvuSSL7IJM3dvCyRdAMPQrE+0ERfSxmvy/6VdIT5fltYWSteE6y2oHqBS+yLxTHLCjFHBYGpWBdndF8AQpcBuQkFz6XmZ7xyGbUktbPbYygsemVs2jCQjXyJgnQfV53jzEZONqVxMtMDAeEFTledDSIw5geBDaNvZQAQH4JmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Qb8paGPI; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=utRnI7mxe7cuiyM4Ao
	Qk1z9cSwN4I0+H9J0WiTjyXgQ=; b=Qb8paGPI2Eu5Hp0hj/r6CS6JFpiDObAueA
	Cmhgvlq/jg8w70UjZbBXP6Zo7XPhwn6OCE8qyMwOQahjch4la3E7NlUOiISNQs3/
	rUOFkGaYZ2yy+BXo9WckvIKCw7iqVCouVPAj+FFfCprVovs76g5Dh/NqPg6BDvkd
	jrzjGAC+Y=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCkvCgBXTkQlVLVnVARgAw--.36018S2;
	Wed, 19 Feb 2025 11:46:46 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	21cnbao@gmail.com,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	liuzixing@hygon.cn,
	Ge Yang <yangge1116@126.com>
Subject: [PATCH V4] mm/hugetlb: wait for hugetlb folios to be freed
Date: Wed, 19 Feb 2025 11:46:44 +0800
Message-Id: <1739936804-18199-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:PCkvCgBXTkQlVLVnVARgAw--.36018S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXryrZr43Gw13Cw48Cw45KFg_yoWrtry8pF
	yUKr13GayDJr9akrn7AwsYyr1SyrWkXFW2krWIqw45ZFnxJa4kKFy2vwn0q3yrAr93CFWI
	vrWqqrWDuF1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR1SoAUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbifgL4G2e1Un4BNgABsX
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Ge Yang <yangge1116@126.com>

Since the introduction of commit c77c0a8ac4c52 ("mm/hugetlb: defer freeing
of huge pages if in non-task context"), which supports deferring the
freeing of hugetlb pages, the allocation of contiguous memory through
cma_alloc() may fail probabilistically.

In the CMA allocation process, if it is found that the CMA area is occupied
by in-use hugetlb folios, these in-use hugetlb folios need to be migrated
to another location. When there are no available hugetlb folios in the
free hugetlb pool during the migration of in-use hugetlb folios, new folios
are allocated from the buddy system. A temporary state is set on the newly
allocated folio. Upon completion of the hugetlb folio migration, the
temporary state is transferred from the new folios to the old folios.
Normally, when the old folios with the temporary state are freed, it is
directly released back to the buddy system. However, due to the deferred
freeing of hugetlb pages, the PageBuddy() check fails, ultimately leading
to the failure of cma_alloc().

Here is a simplified call trace illustrating the process:
cma_alloc()
    ->__alloc_contig_migrate_range() // Migrate in-use hugetlb folios
        ->unmap_and_move_huge_page()
            ->folio_putback_hugetlb() // Free old folios
    ->test_pages_isolated()
        ->__test_page_isolated_in_pageblock()
             ->PageBuddy(page) // Check if the page is in buddy

To resolve this issue, we have implemented a function named
wait_for_freed_hugetlb_folios(). This function ensures that the hugetlb
folios are properly released back to the buddy system after their migration
is completed. By invoking wait_for_freed_hugetlb_folios() before calling
PageBuddy(), we ensure that PageBuddy() will succeed.

Fixes: c77c0a8ac4c52 ("mm/hugetlb: defer freeing of huge pages if in non-task context")
Signed-off-by: Ge Yang <yangge1116@126.com>
Cc: <stable@vger.kernel.org>
---

V4:
- add a check to determine if hpage_freelist is empty suggested by David

V3:
- adjust code and message suggested by Muchun and David

V2:
- flush all folios at once suggested by David

 include/linux/hugetlb.h |  5 +++++
 mm/hugetlb.c            |  8 ++++++++
 mm/page_isolation.c     | 10 ++++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6c6546b..0c54b3a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -697,6 +697,7 @@ bool hugetlb_bootmem_page_zones_valid(int nid, struct huge_bootmem_page *m);
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn);
+void wait_for_freed_hugetlb_folios(void);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, bool cow_from_owner);
 struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int preferred_nid,
@@ -1092,6 +1093,10 @@ static inline int replace_free_hugepage_folios(unsigned long start_pfn,
 	return 0;
 }
 
+static inline void wait_for_freed_hugetlb_folios(void)
+{
+}
+
 static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 					   unsigned long addr,
 					   bool cow_from_owner)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 30bc34d..8801dbc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2955,6 +2955,14 @@ int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
 	return ret;
 }
 
+void wait_for_freed_hugetlb_folios(void)
+{
+	if (llist_empty(&hpage_freelist))
+		return;
+
+	flush_work(&free_hpage_work);
+}
+
 typedef enum {
 	/*
 	 * For either 0/1: we checked the per-vma resv map, and one resv
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 8ed53ee0..b2fc526 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -615,6 +615,16 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 	int ret;
 
 	/*
+	 * Due to the deferred freeing of hugetlb folios, the hugepage folios may
+	 * not immediately release to the buddy system. This can cause PageBuddy()
+	 * to fail in __test_page_isolated_in_pageblock(). To ensure that the
+	 * hugetlb folios are properly released back to the buddy system, we
+	 * invoke the wait_for_freed_hugetlb_folios() function to wait for the
+	 * release to complete.
+	 */
+	wait_for_freed_hugetlb_folios();
+
+	/*
 	 * Note: pageblock_nr_pages != MAX_PAGE_ORDER. Then, chunks of free
 	 * pages are not aligned to pageblock_nr_pages.
 	 * Then we just check migratetype first.
-- 
2.7.4


