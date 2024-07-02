Return-Path: <stable+bounces-56735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE069245C0
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE961C21B2F
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344911BE22B;
	Tue,  2 Jul 2024 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NHkN7+AU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71C415218A;
	Tue,  2 Jul 2024 17:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941184; cv=none; b=KfBFEL3E+ITltlMDIaNIspVPaq8clPVlQD7No+HXupcbemw3dTeEbj089umzmnBz4tzyPYYlQ635km11G/9/gKejaj1n1XPQHSl/uGsPDYyDa4DWh2+LPw1Yigw7PaAch3NEl0QwX0GIyHDwj+5JjqoLtfTpul4a2I6EdJSfp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941184; c=relaxed/simple;
	bh=wNZYrPVPnlFJRyquo99lOxk2rLH2BrBAob8Mnj91hZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhM9RFsi7kktbmb3W8yLh8G/Bm3884F0o+1vr7Ulnmr9sUykLLc/6ICYU0qOxXwPKkghzY51nnx2rcWBcTbXOPPQsn+J9KuzvxptaOP1MBUHRKB7yCB7hBhjg/f8daQ7KUsV0g4thNa0cvyghTCvn/H01++f63SD/lqjY54W6g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NHkN7+AU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03E9C4AF07;
	Tue,  2 Jul 2024 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719941183;
	bh=wNZYrPVPnlFJRyquo99lOxk2rLH2BrBAob8Mnj91hZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NHkN7+AU4ZFARh7qBUvpMwjUpXuRMMw7lvnOtVT4qL9xH+hA7Pq3HX9PrukuKj7Wl
	 pnvQ7N328ddr0rVJ8Uqt1WpY9HyOxOSGCuqprJYX1k2aLgaycNIMrE6BVEMnsi4SCO
	 n0G0iM7FJbgrVsW3Zz30z1TxcV4XPG+RnWBe0wYY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	yangge <yangge1116@126.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <21cnbao@gmail.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6 153/163] mm/page_alloc: Separate THP PCP into movable and non-movable categories
Date: Tue,  2 Jul 2024 19:04:27 +0200
Message-ID: <20240702170238.852826789@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
References: <20240702170233.048122282@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: yangge <yangge1116@126.com>

commit bf14ed81f571f8dba31cd72ab2e50fbcc877cc31 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mmzone.h |    9 ++++-----
 mm/page_alloc.c        |    9 +++++++--
 2 files changed, 11 insertions(+), 7 deletions(-)

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
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -519,10 +519,15 @@ out:
 
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
@@ -536,7 +541,7 @@ static inline int pindex_to_order(unsign
 	int order = pindex / MIGRATE_PCPTYPES;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (pindex == NR_LOWORDER_PCP_LISTS)
+	if (pindex >= NR_LOWORDER_PCP_LISTS)
 		order = pageblock_order;
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);



