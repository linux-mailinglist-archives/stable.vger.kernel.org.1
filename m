Return-Path: <stable+bounces-56302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC39F91ED4F
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 05:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1261F22CBA
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 03:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D28D15E8C;
	Tue,  2 Jul 2024 03:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="o41JgPjp"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8059A17741
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 03:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889556; cv=none; b=hyNqK4wSATGGZBPSzLF9NxCb46jmKe8CXYeZFNMuPlJeu/t+OCJObwuxLxs704mPCE+24UMyEohZCpDXVushztsubad2d6r90GiUy4FuAyGcLwTaNwCt3voi/uFbAG7Frtrh4cXXnyWFTPaONInrVRjRAeMSNSgKieG+L/mGjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889556; c=relaxed/simple;
	bh=23ph6r5VXMDQKdco/Fw+ZuEsUh+mZ//JGstrBx+X7wE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QBejHhpGzZlrel86v7/ZFFxrtXT8KkA426T1KrqzqAHNNatj9WEbG5AbPCwkZk/E5SAZDbw1AEDajtbU+8dzt4jpQkWJzVII5J/wf/s3xJO5op44zlgPL8RVx7/MeNyr6+8VKQ+6R6/mwg++quwPv7b/qUGuO0rkDPQ6Z7+uzRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=o41JgPjp; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=CNozovelqz9bThWYv4
	U1HR30BdREZsihwPC9LtuwEfw=; b=o41JgPjp7rP71Uw4jEl9i+hy4QIMGIt/U/
	nw8KrgCpyX6vRTpr7u29LnI+8A733vlsTXLl2CmQeMy8ueZm4N/CaRIIJLOS8ZE9
	M6pebmWcQ56RLAKw5auZHCEbJdlp81MaS5eHXFYpupWpr/14/9T1UqQZ50nSh6kn
	pSMBM7JAQ=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wCnT_C0aoNm2KJJAQ--.59848S2;
	Tue, 02 Jul 2024 10:49:26 +0800 (CST)
From: yangge1116@126.com
To: stable@vger.kernel.org
Cc: yangge1116@126.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	mgorman@techsingularity.net,
	liuzixing@hygon.cn
Subject: [PATCH 6.9.y] mm/page_alloc: Separate THP PCP into movable and non-movable categories
Date: Tue,  2 Jul 2024 10:49:20 +0800
Message-Id: <1719888560-570-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <2024070126-android-legume-192d@gregkh>
References: <2024070126-android-legume-192d@gregkh>
X-CM-TRANSID:_____wCnT_C0aoNm2KJJAQ--.59848S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWUtF17Xw18JF1UuFWDXFb_yoWruw1rpF
	WxGr1ay3yjqry5Aw1xA3Wqkr1rCwnxGFsrCrW09ry8ZwsxJFWS9a4xKF1qvFy8ZrW5AF4U
	Xr9rt3s3CF4DZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5-B_UUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiGBcQG2VLcJAyNwAAsP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: yangge <yangge1116@126.com>

Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
THP-sized allocations") no longer differentiates the migration type of
pages in THP-sized PCP list, it's possible that non-movable allocation
requests may get a CMA page from the list, in some cases, it's not
acceptable.

If a large number of CMA memory are configured in system (for example, the
CMA memory accounts for 50% of the system memory), starting a virtual
machine with device passthrough will get stuck.  During starting the
virtual machine, it will call pin_user_pages_remote(..., FOLL_LONGTERM,
...) to pin memory.  Normally if a page is present and in CMA area,
pin_user_pages_remote() will migrate the page from CMA area to non-CMA
area because of FOLL_LONGTERM flag.  But if non-movable allocation
requests return CMA memory, migrate_longterm_unpinnable_pages() will
migrate a CMA page to another CMA page, which will fail to pass the check
in check_and_migrate_movable_pages() and cause migration endless.

Call trace:
pin_user_pages_remote
--__gup_longterm_locked // endless loops in this function
----_get_user_pages_locked
----check_and_migrate_movable_pages
------migrate_longterm_unpinnable_pages
--------alloc_migration_target

This problem will also have a negative impact on CMA itself.  For example,
when CMA is borrowed by THP, and we need to reclaim it through cma_alloc()
or dma_alloc_coherent(), we must move those pages out to ensure CMA's
users can retrieve that contigous memory.  Currently, CMA's memory is
occupied by non-movable pages, meaning we can't relocate them.  As a
result, cma_alloc() is more likely to fail.

To fix the problem above, we add one PCP list for THP, which will not
introduce a new cacheline for struct per_cpu_pages.  THP will have 2 PCP
lists, one PCP list is used by MOVABLE allocation, and the other PCP list
is used by UNMOVABLE allocation.  MOVABLE allocation contains GPF_MOVABLE,
and UNMOVABLE allocation contains GFP_UNMOVABLE and GFP_RECLAIMABLE.

Link: https://lkml.kernel.org/r/1718845190-4456-1-git-send-email-yangge1116@126.com
Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-sized allocations")
Signed-off-by: yangge <yangge1116@126.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <21cnbao@gmail.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit bf14ed81f571f8dba31cd72ab2e50fbcc877cc31)
Signed-off-by: yangge <yangge1116@126.com>
---
 include/linux/mmzone.h | 9 ++++-----
 mm/page_alloc.c        | 9 +++++++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c11b7cd..a4f6f1f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -651,13 +651,12 @@ enum zone_watermarks {
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
index 14d39f3..00fafda 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -521,10 +521,15 @@ static void bad_page(struct page *page, const char *reason)
 
 static inline unsigned int order_to_pindex(int migratetype, int order)
 {
+	bool __maybe_unused movable;
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (order > PAGE_ALLOC_COSTLY_ORDER) {
 		VM_BUG_ON(order != pageblock_order);
-		return NR_LOWORDER_PCP_LISTS;
+
+		movable = migratetype == MIGRATE_MOVABLE;
+
+		return NR_LOWORDER_PCP_LISTS + movable;
 	}
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
@@ -538,7 +543,7 @@ static inline int pindex_to_order(unsigned int pindex)
 	int order = pindex / MIGRATE_PCPTYPES;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pindex == NR_LOWORDER_PCP_LISTS)
+	if (pindex >= NR_LOWORDER_PCP_LISTS)
 		order = pageblock_order;
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
-- 
2.7.4


