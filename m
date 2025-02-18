Return-Path: <stable+bounces-116739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F86A39B3A
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A537A1CEC
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4255123ED47;
	Tue, 18 Feb 2025 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Ouss9I8F"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABAC23C8DC;
	Tue, 18 Feb 2025 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878971; cv=none; b=GPeRzhouFloOldRcSsaj0nuVkzGh7eL3/LWrU0KLCV1mxG23feUdO7FbnTleAdIqxtLYDGP50MVcBRjE2+xOrmvjHYH7GaE/jdrI4OkVCRLTt6W02xrXeIWl59+aWO0bnS496hiwVt4+krLhy72IxixfD+P436Ray+1pbtNGN5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878971; c=relaxed/simple;
	bh=bBNT4QlzZXKhd7EQ9JV5YlXy79pcFJ/hqJ3SE6SkiKg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oI0YShNL59Ooq1Al9Bv36eTembA3skm1sD3uH6FHIpGuZrPfWEeYaPA3KuVVUu6uX3gryBsMf88c6Ji4hz9+Gvz5+/gLh0tkfQRk2BSd+PB7Yck5AqCJ0+m7En9mOdaeqzLCMApsFZa2Nh7aA8D/9qiJso7Y+4/UADVG2FfDRx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Ouss9I8F; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=KkHPLPhS/lcvXv2PGW
	47P5xHPzK/OHNmih6dbHFhbrA=; b=Ouss9I8Fc4R4KkbIlN1YgVgbUZ9QDDLzp7
	LBabT84KOv4vz0grUvIk/SJUAIjYP2QFgcip731TZfNOB/sxSN9aTFCAC+8YmvoN
	B3FJePlnfcoha1dN0QXxr5We+uUP1LmEoS1n4wGwzEX5hZjawI5P4wOmzXDg++x7
	tPvWiIre4=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnD9StcbRn5BnwAw--.45758S2;
	Tue, 18 Feb 2025 19:40:30 +0800 (CST)
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
Subject: [PATCH V3] mm/hugetlb: wait for hugetlb folios to be freed
Date: Tue, 18 Feb 2025 19:40:28 +0800
Message-Id: <1739878828-9960-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDnD9StcbRn5BnwAw--.45758S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXryrZr43Gw13Cw48Cw45KFg_yoWrur4rpF
	yUKr13GayDJr9akrn7AwsYyr12y3ykZFWjkrWIqw45ZFnxJas7KFy2vwn0v3y8Ar93CFWx
	ZrWqqrWDuF1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR0JmUUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbifgP3G2e0TMW1YgABsd
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

V3:
- adjust code and message suggested by Muchun and David

V2:
- flush all folios at once suggested by David

 include/linux/hugetlb.h |  5 +++++
 mm/hugetlb.c            |  5 +++++
 mm/page_isolation.c     | 10 ++++++++++
 3 files changed, 20 insertions(+)

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
index 30bc34d..b4630b3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2955,6 +2955,11 @@ int replace_free_hugepage_folios(unsigned long start_pfn, unsigned long end_pfn)
 	return ret;
 }
 
+void wait_for_freed_hugetlb_folios(void)
+{
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


