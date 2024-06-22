Return-Path: <stable+bounces-54859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA3491326B
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 08:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D818284E96
	for <lists+stable@lfdr.de>; Sat, 22 Jun 2024 06:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B293212C550;
	Sat, 22 Jun 2024 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="D/eTzu26"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85B64696;
	Sat, 22 Jun 2024 06:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719038922; cv=none; b=EoG5kPN0DmmtKp2VhJqQu0ekIQz2EfTQ4LuntFPSNiYYGa14wFDZtYH9cNggIZUzdqZMxI9U8yv4TK3ENLZwsfVf7+qEzMzHwdLEtJ+nyCPk3hpdWksKNdg1SlXo1MeDqPt2U2VgG6UURiSKWemzu+d3/6V0cS+Z2/oSuZLoT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719038922; c=relaxed/simple;
	bh=WMYndEbvL6OMXhVtHmvwY4g+jhYqACDm3KG11+egEbY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=p90JPw2OKKB1hL3DKn+Fl3VrVCWrw9QmLZwZM+9OOYFru7jrN3U43JK4D76UlrOUAP9fgWXfo6xfMyK5AiqR2Kw40pgjzzwQkTzNOrNM0EH+ekR9psn3blyKF3uVG1gHoB0khtylfGE3XVa5K8kXM+nBCYiygNNVVF5/ivoGwJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=D/eTzu26; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=4PQv0PvTVRL/ItON0f
	L1teaBFOQB7W1EZ8kO5egpB0c=; b=D/eTzu26yO2HFv+BJzfEzXGSpFAl8iajwD
	GAbph4rFmCFJAHeu3KgkSkYg8qnIu8Bd3rmez+K5SenSs77ctEsDdN1Xly4ksoze
	eCe830XisU6FxLBg65QOCmWfZogVmQ1RL4CgVJCjOJoWTERFAYYX/8LwGV+uVKHu
	Ekcfl5ijQ=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDH7WCmc3ZmqHYEAA--.12787S2;
	Sat, 22 Jun 2024 14:48:07 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	21cnbao@gmail.com,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>
Subject: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to LRU batch
Date: Sat, 22 Jun 2024 14:48:04 +0800
Message-Id: <1719038884-1903-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDH7WCmc3ZmqHYEAA--.12787S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF4rXF4xZrWUGFWUJFyUtrb_yoW7XF1xpF
	W7Gr9IqF4DGFnrWr47Xw15Jr1Yk393Xa1UJFWxGry7AF15Xw1qkF1xtw1UJa9xJryruFn3
	Z3W8JF1vgF1UAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjLvNUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOggGG2VEw83b2AAAsD
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: yangge <yangge1116@126.com>

If a large number of CMA memory are configured in system (for example, the
CMA memory accounts for 50% of the system memory), starting a virtual
virtual machine, it will call pin_user_pages_remote(..., FOLL_LONGTERM,
...) to pin memory.  Normally if a page is present and in CMA area,
pin_user_pages_remote() will migrate the page from CMA area to non-CMA
area because of FOLL_LONGTERM flag. But the current code will cause the
migration failure due to unexpected page refcounts, and eventually cause
the virtual machine fail to start.

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

Cc: <stable@vger.kernel.org>
Signed-off-by: yangge <yangge1116@126.com>
---
 mm/swap.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

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


