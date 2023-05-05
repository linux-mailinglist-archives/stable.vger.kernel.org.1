Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B071F6F8965
	for <lists+stable@lfdr.de>; Fri,  5 May 2023 21:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjEETOt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 5 May 2023 15:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjEETOn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 5 May 2023 15:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A986514926;
        Fri,  5 May 2023 12:14:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D92563F8E;
        Fri,  5 May 2023 19:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7312EC433D2;
        Fri,  5 May 2023 19:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683314070;
        bh=r0o0DDoKClGIFEu5U20pZXkbZmM+Xh4eCtPJfTXBBm0=;
        h=Date:To:From:Subject:From;
        b=Bghh582jHNz7Ksp7qq1+pKdXvMe/DT/tF2j2UIf1yrNFWVtJ26B0VL1sGJBWIr/91
         Y1LItrzZtLatpeDkLqG2qpFCKEHQXzn5IdSpMh6rnf5ycA/HVQRUwbmi4RuOnW+BA9
         vcUa7hyIj8hpZdyrzoglusFQ4C6+zi53ropDJhVk=
Date:   Fri, 05 May 2023 12:14:29 -0700
To:     mm-commits@vger.kernel.org, vitaly.wool@konsulko.com,
        stable@vger.kernel.org, sjenning@redhat.com,
        senozhatsky@chromium.org, ngupta@vflare.org, minchan@kernel.org,
        hannes@cmpxchg.org, ddstreet@ieee.org, nphamcs@gmail.com,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + zsmalloc-move-lru-update-from-zs_map_object-to-zs_malloc.patch added to mm-hotfixes-unstable branch
Message-Id: <20230505191430.7312EC433D2@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: zsmalloc: move LRU update from zs_map_object() to zs_malloc()
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     zsmalloc-move-lru-update-from-zs_map_object-to-zs_malloc.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/zsmalloc-move-lru-update-from-zs_map_object-to-zs_malloc.patch

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
From: Nhat Pham <nphamcs@gmail.com>
Subject: zsmalloc: move LRU update from zs_map_object() to zs_malloc()
Date: Fri, 5 May 2023 11:50:54 -0700

Under memory pressure, we sometimes observe the following crash:

[ 5694.832838] ------------[ cut here ]------------
[ 5694.842093] list_del corruption, ffff888014b6a448->next is LIST_POISON1 (dead000000000100)
[ 5694.858677] WARNING: CPU: 33 PID: 418824 at lib/list_debug.c:47 __list_del_entry_valid+0x42/0x80
[ 5694.961820] CPU: 33 PID: 418824 Comm: fuse_counters.s Kdump: loaded Tainted: G S                5.19.0-0_fbk3_rc3_hoangnhatpzsdynshrv41_10870_g85a9558a25de #1
[ 5694.990194] Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM16 05/24/2021
[ 5695.007072] RIP: 0010:__list_del_entry_valid+0x42/0x80
[ 5695.017351] Code: 08 48 83 c2 22 48 39 d0 74 24 48 8b 10 48 39 f2 75 2c 48 8b 51 08 b0 01 48 39 f2 75 34 c3 48 c7 c7 55 d7 78 82 e8 4e 45 3b 00 <0f> 0b eb 31 48 c7 c7 27 a8 70 82 e8 3e 45 3b 00 0f 0b eb 21 48 c7
[ 5695.054919] RSP: 0018:ffffc90027aef4f0 EFLAGS: 00010246
[ 5695.065366] RAX: 41fe484987275300 RBX: ffff888008988180 RCX: 0000000000000000
[ 5695.079636] RDX: ffff88886006c280 RSI: ffff888860060480 RDI: ffff888860060480
[ 5695.093904] RBP: 0000000000000002 R08: 0000000000000000 R09: ffffc90027aef370
[ 5695.108175] R10: 0000000000000000 R11: ffffffff82fdf1c0 R12: 0000000010000002
[ 5695.122447] R13: ffff888014b6a448 R14: ffff888014b6a420 R15: 00000000138dc240
[ 5695.136717] FS:  00007f23a7d3f740(0000) GS:ffff888860040000(0000) knlGS:0000000000000000
[ 5695.152899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5695.164388] CR2: 0000560ceaab6ac0 CR3: 000000001c06c001 CR4: 00000000007706e0
[ 5695.178659] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 5695.192927] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 5695.207197] PKRU: 55555554
[ 5695.212602] Call Trace:
[ 5695.217486]  <TASK>
[ 5695.221674]  zs_map_object+0x91/0x270
[ 5695.229000]  zswap_frontswap_store+0x33d/0x870
[ 5695.237885]  ? do_raw_spin_lock+0x5d/0xa0
[ 5695.245899]  __frontswap_store+0x51/0xb0
[ 5695.253742]  swap_writepage+0x3c/0x60
[ 5695.261063]  shrink_page_list+0x738/0x1230
[ 5695.269255]  shrink_lruvec+0x5ec/0xcd0
[ 5695.276749]  ? shrink_slab+0x187/0x5f0
[ 5695.284240]  ? mem_cgroup_iter+0x6e/0x120
[ 5695.292255]  shrink_node+0x293/0x7b0
[ 5695.299402]  do_try_to_free_pages+0xea/0x550
[ 5695.307940]  try_to_free_pages+0x19a/0x490
[ 5695.316126]  __folio_alloc+0x19ff/0x3e40
[ 5695.323971]  ? __filemap_get_folio+0x8a/0x4e0
[ 5695.332681]  ? walk_component+0x2a8/0xb50
[ 5695.340697]  ? generic_permission+0xda/0x2a0
[ 5695.349231]  ? __filemap_get_folio+0x8a/0x4e0
[ 5695.357940]  ? walk_component+0x2a8/0xb50
[ 5695.365955]  vma_alloc_folio+0x10e/0x570
[ 5695.373796]  ? walk_component+0x52/0xb50
[ 5695.381634]  wp_page_copy+0x38c/0xc10
[ 5695.388953]  ? filename_lookup+0x378/0xbc0
[ 5695.397140]  handle_mm_fault+0x87f/0x1800
[ 5695.405157]  do_user_addr_fault+0x1bd/0x570
[ 5695.413520]  exc_page_fault+0x5d/0x110
[ 5695.421017]  asm_exc_page_fault+0x22/0x30

After some investigation, I have found the following issue: unlike other
zswap backends, zsmalloc performs the LRU list update at the object
mapping time, rather than when the slot for the object is allocated.
This deviation was discussed and agreed upon during the review process
of the zsmalloc writeback patch series:

https://lore.kernel.org/lkml/Y3flcAXNxxrvy3ZH@cmpxchg.org/

Unfortunately, this introduces a subtle bug that occurs when there is a
concurrent store and reclaim, which interleave as follows:

zswap_frontswap_store()            shrink_worker()
  zs_malloc()                        zs_zpool_shrink()
    spin_lock(&pool->lock)             zs_reclaim_page()
    zspage = find_get_zspage()
    spin_unlock(&pool->lock)
                                         spin_lock(&pool->lock)
                                         zspage = list_first_entry(&pool->lru)
                                         list_del(&zspage->lru)
                                           zspage->lru.next = LIST_POISON1
                                           zspage->lru.prev = LIST_POISON2
                                         spin_unlock(&pool->lock)
  zs_map_object()
    spin_lock(&pool->lock)
    if (!list_empty(&zspage->lru))
      list_del(&zspage->lru)
        CHECK_DATA_CORRUPTION(next == LIST_POISON1) /* BOOM */

With the current upstream code, this issue rarely happens. zswap only
triggers writeback when the pool is already full, at which point all
further store attempts are short-circuited. This creates an implicit
pseudo-serialization between reclaim and store. I am working on a new
zswap shrinking mechanism, which makes interleaving reclaim and store
more likely, exposing this bug.

zbud and z3fold do not have this problem, because they perform the LRU
list update in the alloc function, while still holding the pool's lock.
This patch fixes the aforementioned bug by moving the LRU update back to
zs_malloc(), analogous to zbud and z3fold.

Link: https://lkml.kernel.org/r/20230505185054.2417128-1-nphamcs@gmail.com
Fixes: 64f768c6b32e ("zsmalloc: add a LRU to zs_pool to keep track of zspages in LRU order")
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/zsmalloc.c |   36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

--- a/mm/zsmalloc.c~zsmalloc-move-lru-update-from-zs_map_object-to-zs_malloc
+++ a/mm/zsmalloc.c
@@ -1331,31 +1331,6 @@ void *zs_map_object(struct zs_pool *pool
 	obj_to_location(obj, &page, &obj_idx);
 	zspage = get_zspage(page);
 
-#ifdef CONFIG_ZPOOL
-	/*
-	 * Move the zspage to front of pool's LRU.
-	 *
-	 * Note that this is swap-specific, so by definition there are no ongoing
-	 * accesses to the memory while the page is swapped out that would make
-	 * it "hot". A new entry is hot, then ages to the tail until it gets either
-	 * written back or swaps back in.
-	 *
-	 * Furthermore, map is also called during writeback. We must not put an
-	 * isolated page on the LRU mid-reclaim.
-	 *
-	 * As a result, only update the LRU when the page is mapped for write
-	 * when it's first instantiated.
-	 *
-	 * This is a deviation from the other backends, which perform this update
-	 * in the allocation function (zbud_alloc, z3fold_alloc).
-	 */
-	if (mm == ZS_MM_WO) {
-		if (!list_empty(&zspage->lru))
-			list_del(&zspage->lru);
-		list_add(&zspage->lru, &pool->lru);
-	}
-#endif
-
 	/*
 	 * migration cannot move any zpages in this zspage. Here, pool->lock
 	 * is too heavy since callers would take some time until they calls
@@ -1525,9 +1500,8 @@ unsigned long zs_malloc(struct zs_pool *
 		fix_fullness_group(class, zspage);
 		record_obj(handle, obj);
 		class_stat_inc(class, ZS_OBJS_INUSE, 1);
-		spin_unlock(&pool->lock);
 
-		return handle;
+		goto out;
 	}
 
 	spin_unlock(&pool->lock);
@@ -1550,6 +1524,14 @@ unsigned long zs_malloc(struct zs_pool *
 
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
+out:
+#ifdef CONFIG_ZPOOL
+	/* Add/move zspage to beginning of LRU */
+	if (!list_empty(&zspage->lru))
+		list_del(&zspage->lru);
+	list_add(&zspage->lru, &pool->lru);
+#endif
+
 	spin_unlock(&pool->lock);
 
 	return handle;
_

Patches currently in -mm which might be from nphamcs@gmail.com are

zsmalloc-move-lru-update-from-zs_map_object-to-zs_malloc.patch
workingset-refactor-lru-refault-to-expose-refault-recency-check.patch
cachestat-implement-cachestat-syscall.patch
selftests-add-selftests-for-cachestat.patch

