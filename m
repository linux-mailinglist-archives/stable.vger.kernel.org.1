Return-Path: <stable+bounces-56304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8207491ED85
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 05:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA38B21FE7
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 03:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F92101E4;
	Tue,  2 Jul 2024 03:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="XTQKTnEs"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3A849621
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 03:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719891829; cv=none; b=dGhcnHsWq3RHfxRj3mr4CLRjYp8P0GK+gyT8PjwfLq4PkQmkvvH3kQiVGQv71vH1U5LBiwDmhNTmMkx5DSkRr0lH9QxKioTGH4MF0Z/r5HTVf+Z3A5IOoI9g1pFZirF4aDEzOV9UtmcVvk8b4e58pEa9+Y9zGpshYvZXeJkHed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719891829; c=relaxed/simple;
	bh=f3V+bNpeV1f5lEsntAD6kP/OFEO/l/mmAa2zPF9UFaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=K1uATy1LCXS6w+QLp6H+cXWcKRve5meUsTZ+XJrqMEeht8bEPPjysKK9LwOyES8ut+Jy8nL8NWFJp4TxFI8BgiDi6QPVScWizbbqGfm4727VdrvdXqRzJ8PQe9s6hQkqpSO52r6BwxNneLiQLym4k8mW+9vkMNU925Qu0kWsfRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=XTQKTnEs; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=nb2P9AK1gd6rF/+vSd
	a2YMisDHvhJ9FybRbhZi9FlSI=; b=XTQKTnEs64ieIKLjCYxy2QU0co3df48x9O
	VF1/vt4ZzPY6IoHTmOQ7mP2iCkPeOzt8uqHCIbRoAwdPHxJGqbNq7U83OvRGOv1G
	De0FTyRsVXJqLA/4z7Rr6+U8KdpMph3nkkh8a2/wIwEFqnWkZ/jB7bYKudD//hHa
	xZQ+MqQzY=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wCnT44kd4NmwUoOAQ--.6099S2;
	Tue, 02 Jul 2024 11:42:29 +0800 (CST)
From: yangge1116@126.com
To: stable@vger.kernel.org
Cc: yangge1116@126.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	mgorman@techsingularity.net,
	liuzixing@hygon.cn
Subject: [PATCH 6.6.y] mm/page_alloc: Separate THP PCP into movable and non-movable categories
Date: Tue,  2 Jul 2024 11:42:25 +0800
Message-Id: <1719891745-2219-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <2024070127-escapade-brutishly-2851@gregkh>
References: <2024070127-escapade-brutishly-2851@gregkh>
X-CM-TRANSID:_____wCnT44kd4NmwUoOAQ--.6099S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWUtF17Xw18JF1UuFWDXFb_yoWruw1rpF
	WxGr1Sy3yjqry3Aw1xA3Wqkr1rCwnxGFsrWrW09348ZwsxJFyS9as7KF1qvFy8ZrW7AF4U
	Xr9rt3s3CF4DZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j53ktUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOgoQG2VExKiA8wAAsF
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
index 1acbc6c..e46fbca 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -664,13 +664,12 @@ enum zone_watermarks {
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
index 6b4c30f..e99d322 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -519,10 +519,15 @@ static void bad_page(struct page *page, const char *reason)
 
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
@@ -536,7 +541,7 @@ static inline int pindex_to_order(unsigned int pindex)
 	int order = pindex / MIGRATE_PCPTYPES;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pindex == NR_LOWORDER_PCP_LISTS)
+	if (pindex >= NR_LOWORDER_PCP_LISTS)
 		order = pageblock_order;
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
-- 
2.7.4


