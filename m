Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0493670754C
	for <lists+stable@lfdr.de>; Thu, 18 May 2023 00:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjEQWZb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 18:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEQWZW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 18:25:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8146F1B5;
        Wed, 17 May 2023 15:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0628963CF2;
        Wed, 17 May 2023 22:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DF0C433EF;
        Wed, 17 May 2023 22:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684362320;
        bh=TJDCyBo3lztrbPhdzkpsnF14C96RYsxIWrAKTKBBnI8=;
        h=Date:To:From:Subject:From;
        b=xC94swDOf7z9Aax6tum2n1PgKfpzu1oBkJZJScQdsHA3CPE5E5PayZoEBGbJIVnwA
         MURa7UVIOfL59ZhwR7gXwHALDCbfripnREp+Lk6ANOEIwr0Px0UvjIovfAESN0ldO9
         2z7FipNVHgiXZsXy6qG85q2nZ2oWyvTGQyzaidwg=
Date:   Wed, 17 May 2023 15:25:19 -0700
To:     mm-commits@vger.kernel.org, vitaly.wool@konsulko.com,
        stable@vger.kernel.org, sjenning@redhat.com, ngupta@vflare.org,
        minchan@kernel.org, hannes@cmpxchg.org, ddstreet@ieee.org,
        chrisl@kernel.org, cerasuolodomenico@gmail.com,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-fix-zswap-writeback-race-condition.patch removed from -mm tree
Message-Id: <20230517222520.57DF0C433EF@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: mm: fix zswap writeback race condition
has been removed from the -mm tree.  Its filename was
     mm-fix-zswap-writeback-race-condition.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: mm: fix zswap writeback race condition
Date: Wed, 3 May 2023 17:12:00 +0200

The zswap writeback mechanism can cause a race condition resulting in
memory corruption, where a swapped out page gets swapped in with data that
was written to a different page.

The race unfolds like this:
1. a page with data A and swap offset X is stored in zswap
2. page A is removed off the LRU by zpool driver for writeback in
   zswap-shrink work, data for A is mapped by zpool driver
3. user space program faults and invalidates page entry A, offset X is
   considered free
4. kswapd stores page B at offset X in zswap (zswap could also be
   full, if so, page B would then be IOed to X, then skip step 5.)
5. entry A is replaced by B in tree->rbroot, this doesn't affect the
   local reference held by zswap-shrink work
6. zswap-shrink work writes back A at X, and frees zswap entry A
7. swapin of slot X brings A in memory instead of B

The fix:
Once the swap page cache has been allocated (case ZSWAP_SWAPCACHE_NEW),
zswap-shrink work just checks that the local zswap_entry reference is
still the same as the one in the tree.  If it's not the same it means that
it's either been invalidated or replaced, in both cases the writeback is
aborted because the local entry contains stale data.

Reproducer:
I originally found this by running `stress` overnight to validate my work
on the zswap writeback mechanism, it manifested after hours on my test
machine.  The key to make it happen is having zswap writebacks, so
whatever setup pumps /sys/kernel/debug/zswap/written_back_pages should do
the trick.

In order to reproduce this faster on a vm, I setup a system with ~100M of
available memory and a 500M swap file, then running `stress --vm 1
--vm-bytes 300000000 --vm-stride 4000` makes it happen in matter of tens
of minutes.  One can speed things up even more by swinging
/sys/module/zswap/parameters/max_pool_percent up and down between, say, 20
and 1; this makes it reproduce in tens of seconds.  It's crucial to set
`--vm-stride` to something other than 4096 otherwise `stress` won't
realize that memory has been corrupted because all pages would have the
same data.

Link: https://lkml.kernel.org/r/20230503151200.19707-1-cerasuolodomenico@gmail.com
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Chris Li (Google) <chrisl@kernel.org>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/zswap.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/mm/zswap.c~mm-fix-zswap-writeback-race-condition
+++ a/mm/zswap.c
@@ -1020,6 +1020,22 @@ static int zswap_writeback_entry(struct
 		goto fail;
 
 	case ZSWAP_SWAPCACHE_NEW: /* page is locked */
+		/*
+		 * Having a local reference to the zswap entry doesn't exclude
+		 * swapping from invalidating and recycling the swap slot. Once
+		 * the swapcache is secured against concurrent swapping to and
+		 * from the slot, recheck that the entry is still current before
+		 * writing.
+		 */
+		spin_lock(&tree->lock);
+		if (zswap_rb_search(&tree->rbroot, entry->offset) != entry) {
+			spin_unlock(&tree->lock);
+			delete_from_swap_cache(page_folio(page));
+			ret = -ENOMEM;
+			goto fail;
+		}
+		spin_unlock(&tree->lock);
+
 		/* decompress */
 		acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 		dlen = PAGE_SIZE;
_

Patches currently in -mm which might be from cerasuolodomenico@gmail.com are


