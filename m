Return-Path: <stable+bounces-57913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3367925F92
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 14:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EED01F263A0
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4EC17164D;
	Wed,  3 Jul 2024 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="T931knSL"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FEC171E5A;
	Wed,  3 Jul 2024 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008206; cv=none; b=SRPpy4SBoHGvhc/VbDVhK6rdmbrTY69wOsO0B43P2E505Co4xtx/mZV7hGOStImJsCnK3wPi4QD9GDNQrxC9avAsxl1CZzfj6J+ItnKk3/c4eZsKgHjD7aVfIdp7ZBnkXZiC5aYtkj9wyc5nhrdFfrUaQz0t8WiyeH662mAL9kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008206; c=relaxed/simple;
	bh=CeCJEwqiwFWfrfCrR6E1k4PfHawusEPfZktD198KcUw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=lE4ORoCF1O+6BuijXL9xkdlP1zaWHc8gwo9Dgl1loiHDWsklgNd/7f7iFN/ycQ9X4nbK5Kp0i1ZqTqZ3gAbwyh1KozG3lcVYAxpHaSXx9l8pMsBkym5gUA3ifhXh/iU/ctsPGXDA7jcpXW+VxeyW7N61UcpWvL4iLip7AP96hyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=T931knSL; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=+xxXvPv4ZRctgc4I5X
	pHM6oasgCZi8jLWTxJTFBM7AM=; b=T931knSL8OsG26rLe+vEHmCV7+Dck4a1B1
	xhZr2ieZ1YITIBsRbJzMmT623I1xpehq3eEXPVz9B2HUqmjfkBTBKWh4zuO9nU2L
	C4styEijuj3GRALEs3Y3/Hn9IZm/MjnWBa4ukT6yFbP2m68a9kAuwWHYM1737fBR
	qk7rPQwv0=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wD3_9_mPYVmi7EgAQ--.48290S2;
	Wed, 03 Jul 2024 20:02:48 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	21cnbao@gmail.com,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	aneesh.kumar@linux.ibm.com,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>
Subject: [PATCH V3] mm/gup: Clear the LRU flag of a page before adding to LRU batch
Date: Wed,  3 Jul 2024 20:02:33 +0800
Message-Id: <1720008153-16035-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wD3_9_mPYVmi7EgAQ--.48290S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF4rXF4fJr17CF4kCw4xCrg_yoW7AryxpF
	W7Gr9IqF4DGFnrur47Xw15Jr1Yk393Xa1UJFWxGry7AF15Xw1qkF1xKw1UJa9xJryruFn3
	Za4UJF1vgF1UAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR5UUUUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiGAkRG2VLcLTHxQAAsz
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: yangge <yangge1116@126.com>

If a large number of CMA memory are configured in system (for example, the
CMA memory accounts for 50% of the system memory), starting a virtual
virtual machine with device passthrough, it will
call pin_user_pages_remote(..., FOLL_LONGTERM, ...) to pin memory.
Normally if a page is present and in CMA area, pin_user_pages_remote()
will migrate the page from CMA area to non-CMA area because of
FOLL_LONGTERM flag. But the current code will cause the migration failure
due to unexpected page refcounts, and eventually cause the virtual machine
fail to start.

If a page is added in LRU batch, its refcount increases one, remove the
page from LRU batch decreases one. Page migration requires the page is not
referenced by others except page mapping. Before migrating a page, we
should try to drain the page from LRU batch in case the page is in it,
however, folio_test_lru() is not sufficient to tell whether the page is
in LRU batch or not, if the page is in LRU batch, the migration will fail.

To solve the problem above, we modify the logic of adding to LRU batch.
Before adding a page to LRU batch, we clear the LRU flag of the page so
that we can check whether the page is in LRU batch by folio_test_lru(page).
Seems making the LRU flag of the page invisible a long time is no problem,
because a new page is allocated from buddy and added to the lru batch,
its LRU flag is also not visible for a long time.

Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
Cc: <stable@vger.kernel.org>
Signed-off-by: yangge <yangge1116@126.com>
---
 mm/swap.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

V3:
   Add fixes tag
V2:
   Adjust code and commit message according to David's comments

diff --git a/mm/swap.c b/mm/swap.c
index dc205bd..9caf6b0 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -211,10 +211,6 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 	for (i = 0; i < folio_batch_count(fbatch); i++) {
 		struct folio *folio = fbatch->folios[i];
 
-		/* block memcg migration while the folio moves between lru */
-		if (move_fn != lru_add_fn && !folio_test_clear_lru(folio))
-			continue;
-
 		folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
 		move_fn(lruvec, folio);
 
@@ -255,11 +251,16 @@ static void lru_move_tail_fn(struct lruvec *lruvec, struct folio *folio)
 void folio_rotate_reclaimable(struct folio *folio)
 {
 	if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
-	    !folio_test_unevictable(folio) && folio_test_lru(folio)) {
+	    !folio_test_unevictable(folio)) {
 		struct folio_batch *fbatch;
 		unsigned long flags;
 
 		folio_get(folio);
+		if (!folio_test_clear_lru(folio)) {
+			folio_put(folio);
+			return;
+		}
+
 		local_lock_irqsave(&lru_rotate.lock, flags);
 		fbatch = this_cpu_ptr(&lru_rotate.fbatch);
 		folio_batch_add_and_move(fbatch, folio, lru_move_tail_fn);
@@ -352,11 +353,15 @@ static void folio_activate_drain(int cpu)
 
 void folio_activate(struct folio *folio)
 {
-	if (folio_test_lru(folio) && !folio_test_active(folio) &&
-	    !folio_test_unevictable(folio)) {
+	if (!folio_test_active(folio) && !folio_test_unevictable(folio)) {
 		struct folio_batch *fbatch;
 
 		folio_get(folio);
+		if (!folio_test_clear_lru(folio)) {
+			folio_put(folio);
+			return;
+		}
+
 		local_lock(&cpu_fbatches.lock);
 		fbatch = this_cpu_ptr(&cpu_fbatches.activate);
 		folio_batch_add_and_move(fbatch, folio, folio_activate_fn);
@@ -700,6 +705,11 @@ void deactivate_file_folio(struct folio *folio)
 		return;
 
 	folio_get(folio);
+	if (!folio_test_clear_lru(folio)) {
+		folio_put(folio);
+		return;
+	}
+
 	local_lock(&cpu_fbatches.lock);
 	fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate_file);
 	folio_batch_add_and_move(fbatch, folio, lru_deactivate_file_fn);
@@ -716,11 +726,16 @@ void deactivate_file_folio(struct folio *folio)
  */
 void folio_deactivate(struct folio *folio)
 {
-	if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
-	    (folio_test_active(folio) || lru_gen_enabled())) {
+	if (!folio_test_unevictable(folio) && (folio_test_active(folio) ||
+	    lru_gen_enabled())) {
 		struct folio_batch *fbatch;
 
 		folio_get(folio);
+		if (!folio_test_clear_lru(folio)) {
+			folio_put(folio);
+			return;
+		}
+
 		local_lock(&cpu_fbatches.lock);
 		fbatch = this_cpu_ptr(&cpu_fbatches.lru_deactivate);
 		folio_batch_add_and_move(fbatch, folio, lru_deactivate_fn);
@@ -737,12 +752,16 @@ void folio_deactivate(struct folio *folio)
  */
 void folio_mark_lazyfree(struct folio *folio)
 {
-	if (folio_test_lru(folio) && folio_test_anon(folio) &&
-	    folio_test_swapbacked(folio) && !folio_test_swapcache(folio) &&
-	    !folio_test_unevictable(folio)) {
+	if (folio_test_anon(folio) && folio_test_swapbacked(folio) &&
+	    !folio_test_swapcache(folio) && !folio_test_unevictable(folio)) {
 		struct folio_batch *fbatch;
 
 		folio_get(folio);
+		if (!folio_test_clear_lru(folio)) {
+			folio_put(folio);
+			return;
+		}
+
 		local_lock(&cpu_fbatches.lock);
 		fbatch = this_cpu_ptr(&cpu_fbatches.lru_lazyfree);
 		folio_batch_add_and_move(fbatch, folio, lru_lazyfree_fn);
-- 
2.7.4


