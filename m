Return-Path: <stable+bounces-53857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697D990EB7D
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D205E281E2C
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494A8143881;
	Wed, 19 Jun 2024 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="ZcEAFWRk"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CCCFC1F;
	Wed, 19 Jun 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801712; cv=none; b=NeV0g3BjBkAfaSFsxeFnig/F2ACXd2xMEXEGPRahdNIDj3qCvOuK3WeTeUeyTHBmGw8hVa9BqZDmYyx38aLIPjdhlxYSnIF/VgXceaZkKUhJW1G9DONtYqSURaMJondWLWhIvATtQO+Igu9/gnENZKFue+PCTuclSrAnBBQvoHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801712; c=relaxed/simple;
	bh=yF9033MtIrZltsgP5bIC3MvhEmxrCHKUFIbtWhBiDmw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=J7phNwzcuC+rPF+XQq6xtrvHCHKsPAKMA6uBvIQMLc/e4RPVbHDU4fguJwTIwABr1PJV6t88J+tridozRKaSVFPg4rjvZjDYZK0W5Ek37EbyiLUoY1hVCDewV7ry2I8cJdLRynC+oAuHAlBIAGyFFw8/N3v6wHl4fFCGplEHpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=ZcEAFWRk; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=BWbJKJrKISUYvlz18r
	IPuVxukddjG6yGS92jiK8VMdY=; b=ZcEAFWRkIYOXRuPGREZuoEQj+PNYSi0amg
	cSW0B8HdBJDzv5fbY9WWmryADS60l+TmR8RRtNs0u8JdO//qoFg4rv+mhZu7yTH/
	6lfZ7Jq4wB4CIFbGwQSNvHH1bjx3QZSU9ckVBQQSl91j06q3BmxyOrad3OzGt8YF
	WCnlZuxmk=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wCnd28K1XJmBrxyBQ--.10118S2;
	Wed, 19 Jun 2024 20:54:38 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com,
	mgorman@techsingularity.net,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>
Subject: [PATCH] mm/page_alloc: add one PCP list for THP
Date: Wed, 19 Jun 2024 20:54:32 +0800
Message-Id: <1718801672-30152-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wCnd28K1XJmBrxyBQ--.10118S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWUtF17Xw18JF1UuFWDXFb_yoWrAr18pF
	WxJr4ayayjqryYyr1xA3Wqkr1rCwnxGFsrCrW8ury8ZwsxJFyS9a4UK3WqvF95ArW7AF48
	XryDt34fCF4DZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UfhL5UUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOg8DG2VEw410VQAAsj
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: yangge <yangge1116@126.com>

Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
THP-sized allocations") no longer differentiates the migration type
of pages in THP-sized PCP list, it's possible that non-movable
allocation requests may get a CMA page from the list, in some cases,
it's not acceptable.

If a large number of CMA memory are configured in system (for
example, the CMA memory accounts for 50% of the system memory),
starting a virtual machine with device passthrough will get stuck.
During starting the virtual machine, it will call
pin_user_pages_remote(..., FOLL_LONGTERM, ...) to pin memory. Normally
if a page is present and in CMA area, pin_user_pages_remote() will
migrate the page from CMA area to non-CMA area because of
FOLL_LONGTERM flag. But if non-movable allocation requests return
CMA memory, migrate_longterm_unpinnable_pages() will migrate a CMA
page to another CMA page, which will fail to pass the check in
check_and_migrate_movable_pages() and cause migration endless.
Call trace:
pin_user_pages_remote
--__gup_longterm_locked // endless loops in this function
----_get_user_pages_locked
----check_and_migrate_movable_pages
------migrate_longterm_unpinnable_pages
--------alloc_migration_target

This problem will also have a negative impact on CMA itself. For
example, when CMA is borrowed by THP, and we need to reclaim it
through cma_alloc() or dma_alloc_coherent(), we must move those
pages out to ensure CMA's users can retrieve that contigous memory.
Currently, CMA's memory is occupied by non-movable pages, meaning
we can't relocate them. As a result, cma_alloc() is more likely to
fail.

To fix the problem above, we add one PCP list for THP, which will
not introduce a new cacheline for struct per_cpu_pages. THP will
have 2 PCP lists, one PCP list is used by MOVABLE allocation, and
the other PCP list is used by UNMOVABLE allocation. MOVABLE
allocation contains GPF_MOVABLE, and UNMOVABLE allocation contains
GFP_UNMOVABLE and GFP_RECLAIMABLE.

Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-sized allocations")
Signed-off-by: yangge <yangge1116@126.com>
---
 include/linux/mmzone.h | 9 ++++-----
 mm/page_alloc.c        | 9 +++++++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b7546dd..cb7f265 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -656,13 +656,12 @@ enum zone_watermarks {
 };
 
 /*
- * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. One additional list
- * for THP which will usually be GFP_MOVABLE. Even if it is another type,
- * it should not contribute to serious fragmentation causing THP allocation
- * failures.
+ * One per migratetype for each PAGE_ALLOC_COSTLY_ORDER. Two additional lists
+ * are added for THP. One PCP list is used by GPF_MOVABLE, and the other PCP list
+ * is used by GFP_UNMOVABLE and GFP_RECLAIMABLE.
  */
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-#define NR_PCP_THP 1
+#define NR_PCP_THP 2
 #else
 #define NR_PCP_THP 0
 #endif
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8f416a0..0a837e6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -504,10 +504,15 @@ static void bad_page(struct page *page, const char *reason)
 
 static inline unsigned int order_to_pindex(int migratetype, int order)
 {
+	bool __maybe_unused movable;
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (order > PAGE_ALLOC_COSTLY_ORDER) {
 		VM_BUG_ON(order != HPAGE_PMD_ORDER);
-		return NR_LOWORDER_PCP_LISTS;
+
+		movable = migratetype == MIGRATE_MOVABLE;
+
+		return NR_LOWORDER_PCP_LISTS + movable;
 	}
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
@@ -521,7 +526,7 @@ static inline int pindex_to_order(unsigned int pindex)
 	int order = pindex / MIGRATE_PCPTYPES;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pindex == NR_LOWORDER_PCP_LISTS)
+	if (pindex >= NR_LOWORDER_PCP_LISTS)
 		order = HPAGE_PMD_ORDER;
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
-- 
2.7.4


