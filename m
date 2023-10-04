Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020187B843E
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 17:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbjJDPxj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242963AbjJDPxi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 11:53:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47EFA6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 08:53:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E409CC433C7;
        Wed,  4 Oct 2023 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696434812;
        bh=r36FsRLG6+u97keVjV/TQOeiqnsKLDehAVt1h6vR1/g=;
        h=Subject:To:Cc:From:Date:From;
        b=BZ1UFJWJlb8vBh5d4e4zVmRUo8iSHaroNGQdl9lSJBs59UmJBWx6px2SzX4+6d/+v
         MRIX0JTailHiota4U5GLT53B9ONo1S4YDDyRuSVOk5TE6UQebW1PkTbsAPu3yxzNvw
         r7+aEMEcB0cdoaOTovurh4AJ8yhPCXCblHOrUqmE=
Subject: FAILED: patch "[PATCH] mm: page_alloc: fix CMA and HIGHATOMIC landing on the wrong" failed to apply to 6.1-stable tree
To:     hannes@cmpxchg.org, akpm@linux-foundation.org,
        joe.liu@mediatek.com, stable@vger.kernel.org, vbabka@suse.cz
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 17:53:29 +0200
Message-ID: <2023100429-postnasal-hassle-02be@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7b086755fb8cdbb6b3e45a1bbddc00e7f9b1dc03
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100429-postnasal-hassle-02be@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7b086755fb8cdbb6b3e45a1bbddc00e7f9b1dc03 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 11 Sep 2023 14:11:08 -0400
Subject: [PATCH] mm: page_alloc: fix CMA and HIGHATOMIC landing on the wrong
 buddy list

Commit 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
bypasses the pcplist on lock contention and returns the page directly to
the buddy list of the page's migratetype.

For pages that don't have their own pcplist, such as CMA and HIGHATOMIC,
the migratetype is temporarily updated such that the page can hitch a ride
on the MOVABLE pcplist.  Their true type is later reassessed when flushing
in free_pcppages_bulk().  However, when lock contention is detected after
the type was already overridden, the bypass will then put the page on the
wrong buddy list.

Once on the MOVABLE buddy list, the page becomes eligible for fallbacks
and even stealing.  In the case of HIGHATOMIC, otherwise ineligible
allocations can dip into the highatomic reserves.  In the case of CMA, the
page can be lost from the CMA region permanently.

Use a separate pcpmigratetype variable for the pcplist override.  Use the
original migratetype when going directly to the buddy.  This fixes the bug
and should make the intentions more obvious in the code.

Originally sent here to address the HIGHATOMIC case:
https://lore.kernel.org/lkml/20230821183733.106619-4-hannes@cmpxchg.org/

Changelog updated in response to the CMA-specific bug report.

[mgorman@techsingularity.net: updated changelog]
Link: https://lkml.kernel.org/r/20230911181108.GA104295@cmpxchg.org
Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reported-by: Joe Liu <joe.liu@mediatek.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0c5be12f9336..95546f376302 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2400,7 +2400,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	struct per_cpu_pages *pcp;
 	struct zone *zone;
 	unsigned long pfn = page_to_pfn(page);
-	int migratetype;
+	int migratetype, pcpmigratetype;
 
 	if (!free_unref_page_prepare(page, pfn, order))
 		return;
@@ -2408,24 +2408,24 @@ void free_unref_page(struct page *page, unsigned int order)
 	/*
 	 * We only track unmovable, reclaimable and movable on pcp lists.
 	 * Place ISOLATE pages on the isolated list because they are being
-	 * offlined but treat HIGHATOMIC as movable pages so we can get those
-	 * areas back if necessary. Otherwise, we may have to free
+	 * offlined but treat HIGHATOMIC and CMA as movable pages so we can
+	 * get those areas back if necessary. Otherwise, we may have to free
 	 * excessively into the page allocator
 	 */
-	migratetype = get_pcppage_migratetype(page);
+	migratetype = pcpmigratetype = get_pcppage_migratetype(page);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
 			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
 			return;
 		}
-		migratetype = MIGRATE_MOVABLE;
+		pcpmigratetype = MIGRATE_MOVABLE;
 	}
 
 	zone = page_zone(page);
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
-		free_unref_page_commit(zone, pcp, page, migratetype, order);
+		free_unref_page_commit(zone, pcp, page, pcpmigratetype, order);
 		pcp_spin_unlock(pcp);
 	} else {
 		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);

