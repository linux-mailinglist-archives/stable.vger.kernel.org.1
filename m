Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A92D7A3A42
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjIQUBj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240350AbjIQUAo (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:00:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03228196
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:00:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3811EC433C9;
        Sun, 17 Sep 2023 20:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980821;
        bh=+AerffGa2h884/TYtXfP2Zp3sEDlX8m9G1dYjXbsXMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qx09NCyKpo4Y5zVy3TZsnfE4SYefPQn5uMASNPLwl8xH7V0Oa/cdavMI1ZqZsz/CU
         rTB3fuuaFXjNrHeH9lsOQOGpAa8la8b1PWD0DV/KmVrGiCInzZB2SEEfwBCnHqkcVP
         G/9fIdugJMh104x3O14aLS76Ix5qLMOSYGRLS0rE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Zhao <yuzhao@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <Michael@MichaelLarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 002/219] mm: multi-gen LRU: rename lrugen->lists[] to lrugen->folios[]
Date:   Sun, 17 Sep 2023 21:12:09 +0200
Message-ID: <20230917191041.046853552@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Zhao <yuzhao@google.com>

commit 6df1b2212950aae2b2188c6645ea18e2a9e3fdd5 upstream.

lru_gen_folio will be chained into per-node lists by the coming
lrugen->list.

Link: https://lkml.kernel.org/r/20221222041905.2431096-3-yuzhao@google.com
Signed-off-by: Yu Zhao <yuzhao@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Michael Larabel <Michael@MichaelLarabel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/mm/multigen_lru.rst |    8 ++++----
 include/linux/mm_inline.h         |    4 ++--
 include/linux/mmzone.h            |    8 ++++----
 mm/vmscan.c                       |   20 ++++++++++----------
 4 files changed, 20 insertions(+), 20 deletions(-)

--- a/Documentation/mm/multigen_lru.rst
+++ b/Documentation/mm/multigen_lru.rst
@@ -89,15 +89,15 @@ variables are monotonically increasing.
 
 Generation numbers are truncated into ``order_base_2(MAX_NR_GENS+1)``
 bits in order to fit into the gen counter in ``folio->flags``. Each
-truncated generation number is an index to ``lrugen->lists[]``. The
+truncated generation number is an index to ``lrugen->folios[]``. The
 sliding window technique is used to track at least ``MIN_NR_GENS`` and
 at most ``MAX_NR_GENS`` generations. The gen counter stores a value
 within ``[1, MAX_NR_GENS]`` while a page is on one of
-``lrugen->lists[]``; otherwise it stores zero.
+``lrugen->folios[]``; otherwise it stores zero.
 
 Each generation is divided into multiple tiers. A page accessed ``N``
 times through file descriptors is in tier ``order_base_2(N)``. Unlike
-generations, tiers do not have dedicated ``lrugen->lists[]``. In
+generations, tiers do not have dedicated ``lrugen->folios[]``. In
 contrast to moving across generations, which requires the LRU lock,
 moving across tiers only involves atomic operations on
 ``folio->flags`` and therefore has a negligible cost. A feedback loop
@@ -127,7 +127,7 @@ page mapped by this PTE to ``(max_seq%MA
 Eviction
 --------
 The eviction consumes old generations. Given an ``lruvec``, it
-increments ``min_seq`` when ``lrugen->lists[]`` indexed by
+increments ``min_seq`` when ``lrugen->folios[]`` indexed by
 ``min_seq%MAX_NR_GENS`` becomes empty. To select a type and a tier to
 evict from, it first compares ``min_seq[]`` to select the older type.
 If both types are equally old, it selects the one whose first tier has
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -256,9 +256,9 @@ static inline bool lru_gen_add_folio(str
 	lru_gen_update_size(lruvec, folio, -1, gen);
 	/* for folio_rotate_reclaimable() */
 	if (reclaiming)
-		list_add_tail(&folio->lru, &lrugen->lists[gen][type][zone]);
+		list_add_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 	else
-		list_add(&folio->lru, &lrugen->lists[gen][type][zone]);
+		list_add(&folio->lru, &lrugen->folios[gen][type][zone]);
 
 	return true;
 }
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -312,7 +312,7 @@ enum lruvec_flags {
  * They form a sliding window of a variable size [MIN_NR_GENS, MAX_NR_GENS]. An
  * offset within MAX_NR_GENS, i.e., gen, indexes the LRU list of the
  * corresponding generation. The gen counter in folio->flags stores gen+1 while
- * a page is on one of lrugen->lists[]. Otherwise it stores 0.
+ * a page is on one of lrugen->folios[]. Otherwise it stores 0.
  *
  * A page is added to the youngest generation on faulting. The aging needs to
  * check the accessed bit at least twice before handing this page over to the
@@ -324,8 +324,8 @@ enum lruvec_flags {
  * rest of generations, if they exist, are considered inactive. See
  * lru_gen_is_active().
  *
- * PG_active is always cleared while a page is on one of lrugen->lists[] so that
- * the aging needs not to worry about it. And it's set again when a page
+ * PG_active is always cleared while a page is on one of lrugen->folios[] so
+ * that the aging needs not to worry about it. And it's set again when a page
  * considered active is isolated for non-reclaiming purposes, e.g., migration.
  * See lru_gen_add_folio() and lru_gen_del_folio().
  *
@@ -412,7 +412,7 @@ struct lru_gen_struct {
 	/* the birth time of each generation in jiffies */
 	unsigned long timestamps[MAX_NR_GENS];
 	/* the multi-gen LRU lists, lazily sorted on eviction */
-	struct list_head lists[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
+	struct list_head folios[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
 	/* the multi-gen LRU sizes, eventually consistent */
 	long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
 	/* the exponential moving average of refaulted */
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4258,7 +4258,7 @@ static bool inc_min_seq(struct lruvec *l
 
 	/* prevent cold/hot inversion if force_scan is true */
 	for (zone = 0; zone < MAX_NR_ZONES; zone++) {
-		struct list_head *head = &lrugen->lists[old_gen][type][zone];
+		struct list_head *head = &lrugen->folios[old_gen][type][zone];
 
 		while (!list_empty(head)) {
 			struct folio *folio = lru_to_folio(head);
@@ -4269,7 +4269,7 @@ static bool inc_min_seq(struct lruvec *l
 			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
 
 			new_gen = folio_inc_gen(lruvec, folio, false);
-			list_move_tail(&folio->lru, &lrugen->lists[new_gen][type][zone]);
+			list_move_tail(&folio->lru, &lrugen->folios[new_gen][type][zone]);
 
 			if (!--remaining)
 				return false;
@@ -4297,7 +4297,7 @@ static bool try_to_inc_min_seq(struct lr
 			gen = lru_gen_from_seq(min_seq[type]);
 
 			for (zone = 0; zone < MAX_NR_ZONES; zone++) {
-				if (!list_empty(&lrugen->lists[gen][type][zone]))
+				if (!list_empty(&lrugen->folios[gen][type][zone]))
 					goto next;
 			}
 
@@ -4762,7 +4762,7 @@ static bool sort_folio(struct lruvec *lr
 
 	/* promoted */
 	if (gen != lru_gen_from_seq(lrugen->min_seq[type])) {
-		list_move(&folio->lru, &lrugen->lists[gen][type][zone]);
+		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
 	}
 
@@ -4771,7 +4771,7 @@ static bool sort_folio(struct lruvec *lr
 		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
 		gen = folio_inc_gen(lruvec, folio, false);
-		list_move_tail(&folio->lru, &lrugen->lists[gen][type][zone]);
+		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 
 		WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
 			   lrugen->protected[hist][type][tier - 1] + delta);
@@ -4783,7 +4783,7 @@ static bool sort_folio(struct lruvec *lr
 	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
 	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
 		gen = folio_inc_gen(lruvec, folio, true);
-		list_move(&folio->lru, &lrugen->lists[gen][type][zone]);
+		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
 	}
 
@@ -4850,7 +4850,7 @@ static int scan_folios(struct lruvec *lr
 	for (zone = sc->reclaim_idx; zone >= 0; zone--) {
 		LIST_HEAD(moved);
 		int skipped = 0;
-		struct list_head *head = &lrugen->lists[gen][type][zone];
+		struct list_head *head = &lrugen->folios[gen][type][zone];
 
 		while (!list_empty(head)) {
 			struct folio *folio = lru_to_folio(head);
@@ -5250,7 +5250,7 @@ static bool __maybe_unused state_is_vali
 		int gen, type, zone;
 
 		for_each_gen_type_zone(gen, type, zone) {
-			if (!list_empty(&lrugen->lists[gen][type][zone]))
+			if (!list_empty(&lrugen->folios[gen][type][zone]))
 				return false;
 		}
 	}
@@ -5295,7 +5295,7 @@ static bool drain_evictable(struct lruve
 	int remaining = MAX_LRU_BATCH;
 
 	for_each_gen_type_zone(gen, type, zone) {
-		struct list_head *head = &lruvec->lrugen.lists[gen][type][zone];
+		struct list_head *head = &lruvec->lrugen.folios[gen][type][zone];
 
 		while (!list_empty(head)) {
 			bool success;
@@ -5832,7 +5832,7 @@ void lru_gen_init_lruvec(struct lruvec *
 		lrugen->timestamps[i] = jiffies;
 
 	for_each_gen_type_zone(gen, type, zone)
-		INIT_LIST_HEAD(&lrugen->lists[gen][type][zone]);
+		INIT_LIST_HEAD(&lrugen->folios[gen][type][zone]);
 
 	lruvec->mm_state.seq = MIN_NR_GENS;
 	init_waitqueue_head(&lruvec->mm_state.wait);


