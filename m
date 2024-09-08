Return-Path: <stable+bounces-73872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52CC97071C
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 13:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE22281C7A
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 11:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04054156F46;
	Sun,  8 Sep 2024 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h3l1blZv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86B414EC50
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725796353; cv=none; b=rAHXkxgaBQdFNhZguslADg2V2Lb3t9fiNp4AY33zSceGxdcd0/URNFANDqkkolWEigrCNxOx3fv60CZ+hy0p3LYz/ayh3l+kOGoTIavtKZEiMCiDdHKb71zDwvsiVvQ5JYjg8OCb69lSSPtmOfvr7N2bAU5iX4Ztl0Wl9UMaxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725796353; c=relaxed/simple;
	bh=El1+fpT6m0iptTRY8n9sgm1JQQ47tksF6cZ4HCR4H8M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ErrGWMSbiCEqyVPx2XJqeysGhVh7tXrG0QHIWgMCnMcQwUNoCXzjmfIGRmaAE7yGK3/gDypx2/Qcsi83tHG3bfai/XfCiwspxkNJljiFFlMqNLJq2PHf37qLxDuOPw0eFvmf5bp5wrv+UdG3XGnLubQN3NlF85a+WJRhUASrxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h3l1blZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10EEC4CEC3;
	Sun,  8 Sep 2024 11:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725796353;
	bh=El1+fpT6m0iptTRY8n9sgm1JQQ47tksF6cZ4HCR4H8M=;
	h=Subject:To:Cc:From:Date:From;
	b=h3l1blZvBNnHNbIJ4RjpVSHVeT2qy1umPzes3ZeUPg72h2YS+Y30kMPrVh6WXx8pF
	 LyAFHvRM6kfDIXgNTL8GosBLiQCTKl0QNgP3UXqG3J14Oya7JmhQL3ENmbc9YE5Gt6
	 K2bfWXYQ3BdlWCaxiuPGsldFCEGZFU8iVTrKoj3M=
Subject: FAILED: patch "[PATCH] Revert "mm: skip CMA pages when they are not available"" failed to apply to 6.6-stable tree
To: usamaarif642@gmail.com,akpm@linux-foundation.org,bharata@amd.com,david@redhat.com,hannes@cmpxchg.org,huangzhaoyang@gmail.com,leitao@debian.org,riel@surriel.com,stable@vger.kernel.org,vbabka@suse.cz,willy@infradead.org,yuzhao@google.com,zhaoyang.huang@unisoc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 13:52:30 +0200
Message-ID: <2024090830-imaging-symphonic-8783@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x bfe0857c20c663fcc1592fa4e3a61ca12b07dac9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090830-imaging-symphonic-8783@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

bfe0857c20c6 ("Revert "mm: skip CMA pages when they are not available"")
97144ce008f9 ("mm/vmscan: use folio_migratetype() instead of get_pageblock_migratetype()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bfe0857c20c663fcc1592fa4e3a61ca12b07dac9 Mon Sep 17 00:00:00 2001
From: Usama Arif <usamaarif642@gmail.com>
Date: Wed, 21 Aug 2024 20:26:07 +0100
Subject: [PATCH] Revert "mm: skip CMA pages when they are not available"

This reverts commit 5da226dbfce3 ("mm: skip CMA pages when they are not
available") and b7108d66318a ("Multi-gen LRU: skip CMA pages when they are
not eligible").

lruvec->lru_lock is highly contended and is held when calling
isolate_lru_folios.  If the lru has a large number of CMA folios
consecutively, while the allocation type requested is not MIGRATE_MOVABLE,
isolate_lru_folios can hold the lock for a very long time while it skips
those.  For FIO workload, ~150million order=0 folios were skipped to
isolate a few ZONE_DMA folios [1].  This can cause lockups [1] and high
memory pressure for extended periods of time [2].

Remove skipping CMA for MGLRU as well, as it was introduced in sort_folio
for the same resaon as 5da226dbfce3a2f44978c2c7cf88166e69a6788b.

[1] https://lore.kernel.org/all/CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com/
[2] https://lore.kernel.org/all/ZrssOrcJIDy8hacI@gmail.com/

[usamaarif642@gmail.com: also revert b7108d66318a, per Johannes]
  Link: https://lkml.kernel.org/r/9060a32d-b2d7-48c0-8626-1db535653c54@gmail.com
  Link: https://lkml.kernel.org/r/357ac325-4c61-497a-92a3-bdbd230d5ec9@gmail.com
Link: https://lkml.kernel.org/r/9060a32d-b2d7-48c0-8626-1db535653c54@gmail.com
Fixes: 5da226dbfce3 ("mm: skip CMA pages when they are not available")
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Bharata B Rao <bharata@amd.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/vmscan.c b/mm/vmscan.c
index cfa839284b92..bd489c1af228 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1604,25 +1604,6 @@ static __always_inline void update_lru_sizes(struct lruvec *lruvec,
 
 }
 
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
 /*
  * Isolating page from the lruvec to fill in @dst list by nr_to_scan times.
  *
@@ -1669,8 +1650,7 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
 		nr_pages = folio_nr_pages(folio);
 		total_scan += nr_pages;
 
-		if (folio_zonenum(folio) > sc->reclaim_idx ||
-				skip_cma(folio, sc)) {
+		if (folio_zonenum(folio) > sc->reclaim_idx) {
 			nr_skipped[folio_zonenum(folio)] += nr_pages;
 			move_to = &folios_skipped;
 			goto move;
@@ -4320,7 +4300,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* ineligible */
-	if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
+	if (zone > sc->reclaim_idx) {
 		gen = folio_inc_gen(lruvec, folio, false);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;


