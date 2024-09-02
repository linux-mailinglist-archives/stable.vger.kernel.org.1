Return-Path: <stable+bounces-72630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27F8967D18
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 02:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9790A2817DC
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 00:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5746679C2;
	Mon,  2 Sep 2024 00:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IqolQiXc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131B52F30;
	Mon,  2 Sep 2024 00:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725238598; cv=none; b=ZQv3nKS/Y7WkFwoCLjwKbJ6vFQAfzjHadhO8M7SRxtEdIfbn2OOCxnVUaaC1krJgfAYS8yzMI77M7OsWDnoO8+fcwd/KPF2rHmLQ4iLCvNSYTYpWH7CPMvptxMymELIjSbC4VrB8gF7ZTJs1ueYu53uW7vti4btnbXMqGuH13Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725238598; c=relaxed/simple;
	bh=qy5+Tpfb9t0IRYvoNxEMM+No5uHwbED92OS+ABSjIaA=;
	h=Date:To:From:Subject:Message-Id; b=WdIvvbEdRzGGJZ6ju2O7cg7w/S3L/yv3Lev1//tUZAj58eNb3BWgwfVyOcqGC7hBAEkOKJtYRPDwtgYihked05iax3PqwnUkmrHl6vWiCJvg5cMsoass816z+tyZw/nEQxkH/X5lAaSbyNoijYmwl9Laa8+OAE6GRppxs+bJg3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IqolQiXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B53C4CEC3;
	Mon,  2 Sep 2024 00:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725238597;
	bh=qy5+Tpfb9t0IRYvoNxEMM+No5uHwbED92OS+ABSjIaA=;
	h=Date:To:From:Subject:From;
	b=IqolQiXcK8yNXaVl9c3xrxSvYk6zPi9dCkN9JaJ9Ncsknfrl9/XfjFQHhSrO5GA48
	 O20gTXACCmSQBd4Ho0kxvH7epNFTvxJOQTV4+h+L6g4d/nsMNX+8CfWppvb+Ky4HOy
	 6EKUZDep3LFVTSMMiWgV2R2NJeMTcbtgBYbCalyU=
Date: Sun, 01 Sep 2024 17:56:37 -0700
To: mm-commits@vger.kernel.org,zhaoyang.huang@unisoc.com,yuzhao@google.com,willy@infradead.org,vbabka@suse.cz,stable@vger.kernel.org,riel@surriel.com,leitao@debian.org,huangzhaoyang@gmail.com,hannes@cmpxchg.org,david@redhat.com,bharata@amd.com,usamaarif642@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [folded-merged] revert-mm-skip-cma-pages-when-they-are-not-available-update.patch removed from -mm tree
Message-Id: <20240902005637.B2B53C4CEC3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: revert-mm-skip-cma-pages-when-they-are-not-available-update
has been removed from the -mm tree.  Its filename was
     revert-mm-skip-cma-pages-when-they-are-not-available-update.patch

This patch was dropped because it was folded into revert-mm-skip-cma-pages-when-they-are-not-available.patch

------------------------------------------------------
From: Usama Arif <usamaarif642@gmail.com>
Subject: revert-mm-skip-cma-pages-when-they-are-not-available-update
Date: Wed, 21 Aug 2024 20:26:07 +0100

also revert b7108d66318a ("Multi-gen LRU: skip CMA pages when they are not
eligible"), per Johannes

Link: https://lkml.kernel.org/r/9060a32d-b2d7-48c0-8626-1db535653c54@gmail.com
Link: https://lkml.kernel.org/r/357ac325-4c61-497a-92a3-bdbd230d5ec9@gmail.com
Fixes: 5da226dbfce3 ("mm: skip CMA pages when they are not available")
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/vmscan.c |   21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

--- a/mm/vmscan.c~revert-mm-skip-cma-pages-when-they-are-not-available-update
+++ a/mm/vmscan.c
@@ -4253,25 +4253,6 @@ void lru_gen_soft_reclaim(struct mem_cgr
 
 #endif /* CONFIG_MEMCG */
 
-#ifdef CONFIG_CMA
-/*
- * It is waste of effort to scan and reclaim CMA pages if it is not available
- * for current allocation context. Kswapd can not be enrolled as it can not
- * distinguish this scenario by using sc->gfp_mask = GFP_KERNEL
- */
-static bool skip_cma(struct folio *folio, struct scan_control *sc)
-{
-	return !current_is_kswapd() &&
-			gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
-			folio_migratetype(folio) == MIGRATE_CMA;
-}
-#else
-static bool skip_cma(struct folio *folio, struct scan_control *sc)
-{
-	return false;
-}
-#endif
-
 /******************************************************************************
  *                          the eviction
  ******************************************************************************/
@@ -4319,7 +4300,7 @@ static bool sort_folio(struct lruvec *lr
 	}
 
 	/* ineligible */
-	if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
+	if (zone > sc->reclaim_idx) {
 		gen = folio_inc_gen(lruvec, folio, false);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
_

Patches currently in -mm which might be from usamaarif642@gmail.com are

revert-mm-skip-cma-pages-when-they-are-not-available.patch
mm-store-zero-pages-to-be-swapped-out-in-a-bitmap.patch
mm-remove-code-to-handle-same-filled-pages.patch
mm-introduce-a-pageflag-for-partially-mapped-folios.patch
mm-split-underused-thps.patch
mm-add-sysfs-entry-to-disable-splitting-underused-thps.patch


