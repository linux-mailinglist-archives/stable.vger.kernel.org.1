Return-Path: <stable+bounces-58012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F18927004
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 08:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC6C1C214BC
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 06:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECE71A08D7;
	Thu,  4 Jul 2024 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="bvlQ9sk8"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917DA1B960;
	Thu,  4 Jul 2024 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720076012; cv=none; b=h0Xpnr044hZi4bJKHDV/b4Tf8RjAj+xhSFJ2mw2mHu9uexuAwFTKAT0YH7WT+IBc6CpdFO6Rguaob9djzwbyXl8pgUSWZ/ycOGgXiQkL4WyLpOGgsuTmksRT8UgxHhohTyiBtBdgwZDdG+EMPTt4JCZIAKALCIqvxiuwDZR9Flg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720076012; c=relaxed/simple;
	bh=LtzL+5nzrxroaiXUiVmHZGJ801+M2qbN8Dqcc9EBJUQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AMhOMtPKff0ne47VTSEBaZMf4kHLhBpAzbifbu3QkxtqXFz2CiCiGhxLP+g2tQMmopkyuFxYHLoc0EQMd/mNzN4zrWOelsGg/xnDrGh2GIYmuKgCaVNnAgNEeVbeBUaAkSQ7pPY3ZwatOtgYZkZixr0MY4V6fuir6W3iPm8Ay24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=bvlQ9sk8; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=G2ce0ny7NpQUp89do8
	pJiahKyj8CvImCsHF65fd4k1Y=; b=bvlQ9sk8liOXi6532J7WtvtTn3qnv8NjhX
	7PIb/N1lBDJasCvIlUvCDbUMFYG4BxnsRcwj8TcpNMh2yRXPuYm/qVHsGLm9+L+Z
	DDXb8OvhVBVB7kh76INqycJApPsLmJ9OHzP451YwirtIxVYZ8bdomkp2H66JiSTG
	k7RA4qBNg=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wDHba3ERoZm+hJAAQ--.15286S2;
	Thu, 04 Jul 2024 14:52:54 +0800 (CST)
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
Subject: [PATCH V4] mm/gup: Clear the LRU flag of a page before adding to LRU batch
Date: Thu,  4 Jul 2024 14:52:24 +0800
Message-Id: <1720075944-27201-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDHba3ERoZm+hJAAQ--.15286S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF4rGF4DJF1DCr4rXw1xGrg_yoW7tr17pF
	W7Gr9IqFWDGFsrur47Xw15Ar1Yk393Xa1UJFWxGry7ZF45Xw1qkF1xKw1UJa9xJry5uFna
	v3WUJF1vgF1UAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRoGQDUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQsSG2VLbKWqWQAAsP
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
It's quite valuable, because likely we don't want to blindly drain the LRU
batch simply because there is some unexpected reference on a page, as
described above.

This change makes the LRU flag of a page invisible for longer, which
may impact some programs. For example, as long as a page is on a LRU
batch, we cannot isolate it, and we cannot check if it's an LRU page.
Further, a page can now only be on exactly one LRU batch. This doesn't
seem to matter much, because a new page is allocated from buddy and
added to the lru batch, or be isolated, it's LRU flag may also be
invisible for a long time.

Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
Cc: <stable@vger.kernel.org>
Signed-off-by: yangge <yangge1116@126.com>
---
 mm/swap.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

V4:
   Adjust commit message according to David's comments
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


