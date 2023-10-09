Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1587BDE2A
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376968AbjJINQh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376955AbjJINQe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:16:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D82FC
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:16:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F08EC433CA;
        Mon,  9 Oct 2023 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857390;
        bh=Vb31PpzqZkGAWVGSuGY7Ya9QwdCIXoxPWlJBoXLH9gE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8WpPSuB1zyqGu5CoJCDrNK5c69nWYxbAuEhVBm0oBtNFouwqP14tgBrYw3e7ig7S
         nkZF81206XZCwvPq+Rw8+t3ICA+RIMOdu07WRrrIKw+0XWKrToRqCvvUA7/Ly4NrYW
         2VwgCDbMj/dKFtI4OZjUkIBkmpK4kTEBCzGNnO0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Weiner <hannes@cmpxchg.org>,
        Joe Liu <joe.liu@mediatek.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 031/162] mm: page_alloc: fix CMA and HIGHATOMIC landing on the wrong buddy list
Date:   Mon,  9 Oct 2023 15:00:12 +0200
Message-ID: <20231009130123.803972652@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Weiner <hannes@cmpxchg.org>

[ Upstream commit 7b086755fb8cdbb6b3e45a1bbddc00e7f9b1dc03 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 90082f75660f2..ca017c6008b7c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3448,7 +3448,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	struct per_cpu_pages *pcp;
 	struct zone *zone;
 	unsigned long pfn = page_to_pfn(page);
-	int migratetype;
+	int migratetype, pcpmigratetype;
 
 	if (!free_unref_page_prepare(page, pfn, order))
 		return;
@@ -3456,24 +3456,24 @@ void free_unref_page(struct page *page, unsigned int order)
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
-- 
2.40.1



