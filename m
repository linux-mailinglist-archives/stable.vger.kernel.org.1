Return-Path: <stable+bounces-94800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03699D7176
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DC4B2C1F6
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFDC1E47CC;
	Sun, 24 Nov 2024 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzaJPOU0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB411CEE80;
	Sun, 24 Nov 2024 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452456; cv=none; b=TOJtvq9yiGSarRETpBkSMlGDg9+cJZEB3vrAsaSVAyp1vjh0dsJ4h31cK/w8zzyBTnGW2MTB/EX/ZlBMQd7njCrjgZvjjRfC0htQhnUdYkAwqoRbJRCc2APM9fkFyoZXS68rM0mjffHWvcRH9e0qh1v1eNjOffoinhMp27ugQuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452456; c=relaxed/simple;
	bh=LOs3EQTGf41IMhjbMb6zCRsx2GD1hoPqo7sHaTBNJx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d5dl5uuFPWYnw0CCxZWEDuDr417voKE1SKfZI4ISWCR3W5R8P6t+p4mPZ6J7pEZ6AuTgLwPl7Ej2cFtCY8UlueNtPeYdSW5+snzIsfq9vFkybIMkFY2IYvcefxOb7ex4jlrTGxpKzkjwR0LAu2isTYCDbDj5rnFEDEcXLUpgtz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzaJPOU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB9AC4CECC;
	Sun, 24 Nov 2024 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452456;
	bh=LOs3EQTGf41IMhjbMb6zCRsx2GD1hoPqo7sHaTBNJx4=;
	h=From:To:Cc:Subject:Date:From;
	b=JzaJPOU0KHZ2z+FaTss0LfBNit2sd0wkXsceziDgkuDpVtuQ3DLIGgKVxvjBsduLX
	 g/lcXuGrAg+JwdIb95gbsTV/iUfYLCo4hAYKKaEYj5qOOgQIjyJqESeOnBwgeu2+2t
	 jUzMAN4F2O02SVHVo6Q/wDrr2b8L++6B8KMy79ejMz6+PRFA6cY5k5OCzLGJxsf3Hu
	 NCaZBIBD8S7gNq+LpVFmhmV4cZQGgTTTtY1dGKcxuPyd7lGN44kOyegYayRyULVkPw
	 +IqdpugGdwLPWrM4n7WI2QRmUMPn2wcg/C1NV9/VjoUWmrSj92nTriEfDpka2WquZP
	 6EB6S79rj0MVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mhiramat@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/2] uprobes: sanitiize xol_free_insn_slot()
Date: Sun, 24 Nov 2024 07:47:30 -0500
Message-ID: <20241124124733.3338551-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit c7b4133c48445dde789ed30b19ccb0448c7593f7 ]

1. Clear utask->xol_vaddr unconditionally, even if this addr is not valid,
   xol_free_insn_slot() should never return with utask->xol_vaddr != NULL.

2. Add a comment to explain why do we need to validate slot_addr.

3. Simplify the validation above. We can simply check offset < PAGE_SIZE,
   unsigned underflows are fine, it should work if slot_addr < area->vaddr.

4. Kill the unnecessary "slot_nr >= UINSNS_PER_PAGE" check, slot_nr must
   be valid if offset < PAGE_SIZE.

The next patches will cleanup this function even more.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240929144235.GA9471@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/uprobes.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 1ea2c1f311261..220d5f4a57e6b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1634,8 +1634,8 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 static void xol_free_insn_slot(struct task_struct *tsk)
 {
 	struct xol_area *area;
-	unsigned long vma_end;
 	unsigned long slot_addr;
+	unsigned long offset;
 
 	if (!tsk->mm || !tsk->mm->uprobes_state.xol_area || !tsk->utask)
 		return;
@@ -1644,24 +1644,21 @@ static void xol_free_insn_slot(struct task_struct *tsk)
 	if (unlikely(!slot_addr))
 		return;
 
+	tsk->utask->xol_vaddr = 0;
 	area = tsk->mm->uprobes_state.xol_area;
-	vma_end = area->vaddr + PAGE_SIZE;
-	if (area->vaddr <= slot_addr && slot_addr < vma_end) {
-		unsigned long offset;
-		int slot_nr;
-
-		offset = slot_addr - area->vaddr;
-		slot_nr = offset / UPROBE_XOL_SLOT_BYTES;
-		if (slot_nr >= UINSNS_PER_PAGE)
-			return;
+	offset = slot_addr - area->vaddr;
+	/*
+	 * slot_addr must fit into [area->vaddr, area->vaddr + PAGE_SIZE).
+	 * This check can only fail if the "[uprobes]" vma was mremap'ed.
+	 */
+	if (offset < PAGE_SIZE) {
+		int slot_nr = offset / UPROBE_XOL_SLOT_BYTES;
 
 		clear_bit(slot_nr, area->bitmap);
 		atomic_dec(&area->slot_count);
 		smp_mb__after_atomic(); /* pairs with prepare_to_wait() */
 		if (waitqueue_active(&area->wq))
 			wake_up(&area->wq);
-
-		tsk->utask->xol_vaddr = 0;
 	}
 }
 
-- 
2.43.0


