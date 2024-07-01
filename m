Return-Path: <stable+bounces-56223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EA591DFBC
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0A21C22159
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 12:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE66015B971;
	Mon,  1 Jul 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="od6PBHsk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62D15B561
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837932; cv=none; b=l7da+Zil6Enp5MQoiYNoC8PyCz7cj4wYCrUinp1gkXWJn2y37eeYg1+N+v7hpgVApmb9JXJNoU8G5wchYnFovJafEbbXWwKJKZicbwfEhpf8GpQR1+WUopPOcTanpMyQEVw/iHFqt9YjkHwZWne4QnjaE7a1KkCf9KG+xumDDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837932; c=relaxed/simple;
	bh=dzq15meA5udoEKFC//Z+5O/cpaVaVRkBBJqKW3rh4jY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SlNIBqvpTiUP4qz027W+dbBcyMuitr9QJEb+QcrtE5ceXOQvt/IrFm5Q9fdpUzwygJ/Rr2o77BVdA7TisjZVreT/b49bw0x/4SmSONE1agt/J4IR8UOIkVMUMEcbqRf8Za2px9ERXAfwsmdRwedlxv90acV7HcMpswm/qT4FpbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=od6PBHsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB1EC116B1;
	Mon,  1 Jul 2024 12:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719837932;
	bh=dzq15meA5udoEKFC//Z+5O/cpaVaVRkBBJqKW3rh4jY=;
	h=Subject:To:Cc:From:Date:From;
	b=od6PBHskm0oOPr6MVvYewIRvu1BNem5vv0hZeCldcOajx536aZDVuHr75BIPFRh96
	 hlxcWpDYIIrXYfDzalKvpb3DZ2FgW8VZBfEdE+1p4II91wA8uAmAZWNOn6DFmDDthZ
	 /+OsRYE0Rmsw9Ooj/bOlcQJ6HFsyh1V0PsNle88Q=
Subject: FAILED: patch "[PATCH] mm/page_alloc: Separate THP PCP into movable and non-movable" failed to apply to 6.1-stable tree
To: yangge1116@126.com,21cnbao@gmail.com,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,mgorman@techsingularity.net,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Jul 2024 14:29:29 +0200
Message-ID: <2024070129-movable-commend-1b2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x bf14ed81f571f8dba31cd72ab2e50fbcc877cc31
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070129-movable-commend-1b2a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

bf14ed81f571 ("mm/page_alloc: Separate THP PCP into movable and non-movable categories")
6303d1c553c8 ("mm: page_alloc: use the correct THP order for THP PCP")
c1dc69e6ce65 ("mm/page_alloc: remove unneeded variable base")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bf14ed81f571f8dba31cd72ab2e50fbcc877cc31 Mon Sep 17 00:00:00 2001
From: yangge <yangge1116@126.com>
Date: Thu, 20 Jun 2024 08:59:50 +0800
Subject: [PATCH] mm/page_alloc: Separate THP PCP into movable and non-movable
 categories

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

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8f9c9590a42c..586a8f0104d7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -654,13 +654,12 @@ enum zone_watermarks {
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
index 7300aa9f14b0..9ecf99190ea2 100644
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


