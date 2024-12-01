Return-Path: <stable+bounces-95896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7A09DF471
	for <lists+stable@lfdr.de>; Sun,  1 Dec 2024 03:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4DE161FA6
	for <lists+stable@lfdr.de>; Sun,  1 Dec 2024 02:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56484111A8;
	Sun,  1 Dec 2024 02:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dRrdntab"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0574223AB;
	Sun,  1 Dec 2024 02:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733021252; cv=none; b=GIPTMtX9huIF/TjUH6aWnYoF5/yfMyLG9n+C6XF0USnhQbZcs1tIRzzrDZXD2oty0RGNs4P10GvizAzHLTVrnYhxkkdhFRNMusNLPskgFjPWUTX3PqeZE+5vQAZUVrAQL4ACLQ99Eqo65SgaAXRkioGX4MTKclkahG+6LGY2zz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733021252; c=relaxed/simple;
	bh=VHanmVhirfgRqe4UiMZrtbYqvNGI+jMwbd3Z22LNnFo=;
	h=Date:To:From:Subject:Message-Id; b=Ezz+uf1IQ3N49mkH7QRIHNuUSGwZKRWwPFaM/2FSlZgIP6RBarN2OWOGBl5PPnQCAg6na5gcKJ4++gf9uMqm31OImUD8+6jM4qd98UxXQ9sKo0Z1HmlEMQZsoQQC+eWlTx2i+e27OcKnJXAx651T5pW3WqV/2xn4s5at2K6WHuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dRrdntab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98101C4CECC;
	Sun,  1 Dec 2024 02:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733021251;
	bh=VHanmVhirfgRqe4UiMZrtbYqvNGI+jMwbd3Z22LNnFo=;
	h=Date:To:From:Subject:From;
	b=dRrdntabP0V62bl4Ll0SsTw2X4HtAHM/9ihg1EHDRnTmud+INHYhJNEWujEMcCDEz
	 SDeGiis7YnK8CJvWrYsUotnpwOES8eKd9lheFiKX+QW6JsgeHzAcXSeAm776/PtkP7
	 udmWT5dYnHCH59/8M4nR7BaYqWLltMisNm9owGTQ=
Date: Sat, 30 Nov 2024 18:47:31 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,mgorman@techsingularity.net,snishika@redhat.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-vmscan-account-for-free-pages-to-prevent-infinite-loop-in-throttle_direct_reclaim.patch added to mm-hotfixes-unstable branch
Message-Id: <20241201024731.98101C4CECC@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm: vmscan: account for free pages to prevent infinite Loop in throttle_direct_reclaim()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-vmscan-account-for-free-pages-to-prevent-infinite-loop-in-throttle_direct_reclaim.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-vmscan-account-for-free-pages-to-prevent-infinite-loop-in-throttle_direct_reclaim.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Seiji Nishikawa <snishika@redhat.com>
Subject: mm: vmscan: account for free pages to prevent infinite Loop in throttle_direct_reclaim()
Date: Sun, 1 Dec 2024 01:12:34 +0900

The task sometimes continues looping in throttle_direct_reclaim() because
allow_direct_reclaim(pgdat) keeps returning false.  

 #0 [ffff80002cb6f8d0] __switch_to at ffff8000080095ac
 #1 [ffff80002cb6f900] __schedule at ffff800008abbd1c
 #2 [ffff80002cb6f990] schedule at ffff800008abc50c
 #3 [ffff80002cb6f9b0] throttle_direct_reclaim at ffff800008273550
 #4 [ffff80002cb6fa20] try_to_free_pages at ffff800008277b68
 #5 [ffff80002cb6fae0] __alloc_pages_nodemask at ffff8000082c4660
 #6 [ffff80002cb6fc50] alloc_pages_vma at ffff8000082e4a98
 #7 [ffff80002cb6fca0] do_anonymous_page at ffff80000829f5a8
 #8 [ffff80002cb6fce0] __handle_mm_fault at ffff8000082a5974
 #9 [ffff80002cb6fd90] handle_mm_fault at ffff8000082a5bd4

At this point, the pgdat contains the following two zones:

        NODE: 4  ZONE: 0  ADDR: ffff00817fffe540  NAME: "DMA32"
          SIZE: 20480  MIN/LOW/HIGH: 11/28/45
          VM_STAT:
                NR_FREE_PAGES: 359
        NR_ZONE_INACTIVE_ANON: 18813
          NR_ZONE_ACTIVE_ANON: 0
        NR_ZONE_INACTIVE_FILE: 50
          NR_ZONE_ACTIVE_FILE: 0
          NR_ZONE_UNEVICTABLE: 0
        NR_ZONE_WRITE_PENDING: 0
                     NR_MLOCK: 0
                    NR_BOUNCE: 0
                   NR_ZSPAGES: 0
            NR_FREE_CMA_PAGES: 0

        NODE: 4  ZONE: 1  ADDR: ffff00817fffec00  NAME: "Normal"
          SIZE: 8454144  PRESENT: 98304  MIN/LOW/HIGH: 68/166/264
          VM_STAT:
                NR_FREE_PAGES: 146
        NR_ZONE_INACTIVE_ANON: 94668
          NR_ZONE_ACTIVE_ANON: 3
        NR_ZONE_INACTIVE_FILE: 735
          NR_ZONE_ACTIVE_FILE: 78
          NR_ZONE_UNEVICTABLE: 0
        NR_ZONE_WRITE_PENDING: 0
                     NR_MLOCK: 0
                    NR_BOUNCE: 0
                   NR_ZSPAGES: 0
            NR_FREE_CMA_PAGES: 0

In allow_direct_reclaim(), while processing ZONE_DMA32, the sum of
inactive/active file-backed pages calculated in zone_reclaimable_pages()
based on the result of zone_page_state_snapshot() is zero.  

Additionally, since this system lacks swap, the calculation of inactive/
active anonymous pages is skipped.

        crash> p nr_swap_pages
        nr_swap_pages = $1937 = {
          counter = 0
        }

As a result, ZONE_DMA32 is deemed unreclaimable and skipped, moving on to
the processing of the next zone, ZONE_NORMAL, despite ZONE_DMA32 having
free pages significantly exceeding the high watermark.

The problem is that the pgdat->kswapd_failures hasn't been incremented.

        crash> px ((struct pglist_data *) 0xffff00817fffe540)->kswapd_failures
        $1935 = 0x0

This is because the node deemed balanced.  The node balancing logic in
balance_pgdat() evaluates all zones collectively.  If one or more zones
(e.g., ZONE_DMA32) have enough free pages to meet their watermarks, the
entire node is deemed balanced.  This causes balance_pgdat() to exit early
before incrementing the kswapd_failures, as it considers the overall
memory state acceptable, even though some zones (like ZONE_NORMAL) remain
under significant pressure.


The patch ensures that zone_reclaimable_pages() includes free pages
(NR_FREE_PAGES) in its calculation when no other reclaimable pages are
available (e.g., file-backed or anonymous pages).  This change prevents
zones like ZONE_DMA32, which have sufficient free pages, from being
mistakenly deemed unreclaimable.  By doing so, the patch ensures proper
node balancing, avoids masking pressure on other zones like ZONE_NORMAL,
and prevents infinite loops in throttle_direct_reclaim() caused by
allow_direct_reclaim(pgdat) repeatedly returning false.


The kernel hangs due to a task stuck in throttle_direct_reclaim(), caused
by a node being incorrectly deemed balanced despite pressure in certain
zones, such as ZONE_NORMAL.  This issue arises from
zone_reclaimable_pages() returning 0 for zones without reclaimable file-
backed or anonymous pages, causing zones like ZONE_DMA32 with sufficient
free pages to be skipped.

The lack of swap or reclaimable pages results in ZONE_DMA32 being ignored
during reclaim, masking pressure in other zones.  Consequently,
pgdat->kswapd_failures remains 0 in balance_pgdat(), preventing fallback
mechanisms in allow_direct_reclaim() from being triggered, leading to an
infinite loop in throttle_direct_reclaim().

This patch modifies zone_reclaimable_pages() to account for free pages
(NR_FREE_PAGES) when no other reclaimable pages exist.  This ensures zones
with sufficient free pages are not skipped, enabling proper balancing and
reclaim behavior.

Link: https://lkml.kernel.org/r/20241130164346.436469-1-snishika@redhat.com
Link: https://lkml.kernel.org/r/20241130161236.433747-2-snishika@redhat.com
Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/vmscan.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/mm/vmscan.c~mm-vmscan-account-for-free-pages-to-prevent-infinite-loop-in-throttle_direct_reclaim
+++ a/mm/vmscan.c
@@ -374,7 +374,14 @@ unsigned long zone_reclaimable_pages(str
 	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
 		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
 			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
-
+	/*
+	 * If there are no reclaimable file-backed or anonymous pages, 
+	 * ensure zones with sufficient free pages are not skipped. 
+	 * This prevents zones like DMA32 from being ignored in reclaim 
+	 * scenarios where they can still help alleviate memory pressure.
+	 */
+	if (nr == 0)
+	    nr = zone_page_state_snapshot(zone, NR_FREE_PAGES);
 	return nr;
 }
 
_

Patches currently in -mm which might be from snishika@redhat.com are

mm-vmscan-ensure-kswapd-is-woken-up-if-the-wait-queue-is-active.patch
mm-vmscan-account-for-free-pages-to-prevent-infinite-loop-in-throttle_direct_reclaim.patch


