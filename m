Return-Path: <stable+bounces-94803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2557D9D6F34
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D632F2811A5
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D091E5733;
	Sun, 24 Nov 2024 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9p7dreA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C45B1E5721;
	Sun, 24 Nov 2024 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452464; cv=none; b=CS8ACiI7YmR/2q1TXcHpkEpVaUze7p2aoHegzNvHfucq+ARZ5nohhf3zlGVgQL16KXotOGvLlrj1jWii5v0gvIGqDxH0o81Dr4U9mqtJZPOAEFHVt72f4Y2iGDW2ZSgipLH3J4UbETQICVEnMPuKZ5eyFSencGLrCoDiaP0Jgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452464; c=relaxed/simple;
	bh=KGdfZ3LCOqmaNPMHEis9xuXUij/J5QsB+YpIAHqAdek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lExv0sewaqsqBwhTNRXtfL7mPpmXYXOEIpIEUNLgEf8BCgUnSwpvTqGdz+y0k/z/NRoJMrWPTG+BiVJoDEueR8D8EHiYX/1zC2xQ5Zb0XaFfdVhBHxdhj0n6ujmNCh7g5I1Yb6CTsHcTw0UkvYDEriNzv+ysUxOOKP6/pjsRySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9p7dreA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB758C4CECC;
	Sun, 24 Nov 2024 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452463;
	bh=KGdfZ3LCOqmaNPMHEis9xuXUij/J5QsB+YpIAHqAdek=;
	h=From:To:Cc:Subject:Date:From;
	b=L9p7dreAN+3qLXPhGcPQrGVZhxALjdO2VzrMSljZpyDR3fbopfdEo1QrN4FCoWvC9
	 75MMa8ppElEko7bzMwy1W3+R2YCtOKWSWb6uGbPdNkofeONzioX+Ob69z63iFrDCki
	 80yIWeHBLPtvTz5PgtrVh5KpdHv/Jkdj6xBhDDWcN1oEGiMUCpQIAG3iSGVqKHepPM
	 ddpsDv2hvNlKfYMzbxBsNz3jAMYqjUGe2E0AX4CdBPQr0TDwrw0XiVmnU5/RPKZ8vo
	 QbHH+pYIMCKeulBOZRqBeXdeHrgwKMhSPFdyqpRQEKaAcKKH0CEvoX6Y2tvZhZim76
	 NxWIs4axh/YOA==
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
Subject: [PATCH AUTOSEL 5.4 1/2] uprobes: sanitiize xol_free_insn_slot()
Date: Sun, 24 Nov 2024 07:47:38 -0500
Message-ID: <20241124124741.3338607-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
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
index 6285674412f25..d338eeb30145b 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1640,8 +1640,8 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 static void xol_free_insn_slot(struct task_struct *tsk)
 {
 	struct xol_area *area;
-	unsigned long vma_end;
 	unsigned long slot_addr;
+	unsigned long offset;
 
 	if (!tsk->mm || !tsk->mm->uprobes_state.xol_area || !tsk->utask)
 		return;
@@ -1650,24 +1650,21 @@ static void xol_free_insn_slot(struct task_struct *tsk)
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


