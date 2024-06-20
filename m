Return-Path: <stable+bounces-54677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5CA90FAB8
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 03:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D69A282F9A
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 01:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B021173F;
	Thu, 20 Jun 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Evr4HUDJ"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5612211717;
	Thu, 20 Jun 2024 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718845229; cv=none; b=d+10GJXP3RK5ZsI8MhJ8fcjKimVEM5o9Tnjoo2wnw5BHxY0EnTJ0s8Ht2brYY49c46NPwrZ8Jax/OOXaUvCFMCNCYQ5iyD9TM4hsjcR5WSfaJvdJzYsgi8O+ychlmcP0qVTA9fad6yUAu3zKBs9T+Dqz+3zHrimuAY7hJKNXKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718845229; c=relaxed/simple;
	bh=HBbvf6mGWYY2vBmXTbBw4PqxmXkX8gtpifzLpLUDVeo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dLU28h0uwl+wx6Tm+P989forj22ipKtdo+kTuIs2qVBtt6Heya9kgi6nFD5pZ1v/W+i1TyAr9QLfwCNnUgZOm9P7iHuXMXQEDMDT5WuHkU9gTEHkXmTWoMvBJIfTu3w9pZFbPOixt6TIDebQuCuS7Q98tR365+xsG3+qmivpVco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Evr4HUDJ; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=WW4Jez97mtesbicc+3
	7OFwctvMHDtr7/KR4+TtH6+9g=; b=Evr4HUDJ2s/qE45eFJx7vru73EiMvFzUBC
	BvG6v9swuXJFTq6yPYE+2W7i79I0jouzFWrRJ0H9iLMl+Vdk8MwP9J4QMAuk3UNp
	FLMIbDRCNw+K+SwSGxgMMND5yBxFZyTH9VIrIhq1lyA9l1VPd5rwz0+FrLcETaMT
	cbatK7kxs=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDn758Nf3NmX9+2AA--.51251S2;
	Thu, 20 Jun 2024 08:59:59 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com,
	mgorman@techsingularity.net,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>,
	stable@vger.kernel.org
Subject: [PATCH V2] mm/page_alloc: Separate THP PCP into movable and non-movable categories
Date: Thu, 20 Jun 2024 08:59:50 +0800
Message-Id: <1718845190-4456-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDn758Nf3NmX9+2AA--.51251S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWUtF17Xw18JF1UuFWDXFb_yoWrAFy3pF
	WxJr4ayayjqry3Ar1xA3Wqkr1rCwnxGFsrCr1xury8ZwsxJFyS9a4UK3WqvF95ArW7AF48
	Xr9rt34fCF4DZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbPEhUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiGBQEG2VLb4BrvgABsG
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
Cc: <stable@vger.kernel.org>
Signed-off-by: yangge <yangge1116@126.com>
---

V2:
- Change the commit title
- Add Cc to stable

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


