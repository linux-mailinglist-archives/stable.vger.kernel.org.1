Return-Path: <stable+bounces-94805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBCF9D6F54
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10CF8B25303
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCAB1E7C10;
	Sun, 24 Nov 2024 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNw2GwzG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4306D1E7C09;
	Sun, 24 Nov 2024 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452470; cv=none; b=OwpDY12HCXOB+NDtmTbAL9gTJrWl/Hx9diKQrrrnPi4pvs0hEE0Ctskve15lbANyKhL7wAmtksn+u+zQf8U/vZDTqPxHLs6vgY/XLwMgQdzLAoFFuU4LiVlbuXWuGAg5mErCeBGpVn163AbF9BTM3ljeEUbrvs6oHVdOi/YgtsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452470; c=relaxed/simple;
	bh=O8T2JipCKJ2boPqKFdo/Fhpy25Wjx9Jy45Ra3HSpHL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0QAk+RPDt2ZjG/tfLbKYWePQAohFNuRiS1iQ0tBpxkS0Vmrpx0jGPq75hMlbHlPdTZHNsDpqQuTto85OtsACq31lFZhpqlsLuyOAqc8UG4yPbm7tVgFgYFHm/Xuct0UpwrF/6AOr8Fm1s/9OKz0HfH+p5/O/AgKHK1KHGwKZD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNw2GwzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F6AC4CECC;
	Sun, 24 Nov 2024 12:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452470;
	bh=O8T2JipCKJ2boPqKFdo/Fhpy25Wjx9Jy45Ra3HSpHL0=;
	h=From:To:Cc:Subject:Date:From;
	b=nNw2GwzG75IfvWlKTerjJUMza/dA8eI9RXhh5BDbws9KZmMvejMisVChEzXw/jwK6
	 KRr1DxJItfEwqZba++TKPUAatG6NK9woo+/QviXkWWJ9vepAkrBQXL1G+Yh8vDKi8T
	 /Z0wvszIM6zVlCITrRKsrxrpuGdt8tWLLmr6nrNkP0nyrFZTt8Cp+nZAPge39dw8i4
	 vCdcbrB3lYmMc+sDCkY20PY9hcTLVrGa+ntlJ66H9MTBfKEkYn84TOhu1CS7413vkL
	 y5Pd2g8m2sFUx2X+hQTLfBVAuG1dsFVMMpmBy3ozSNyWHbHcuQdoxsjcJGSZ+sw6+y
	 WrM0mEXnhVtew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	mhiramat@kernel.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19] uprobes: sanitiize xol_free_insn_slot()
Date: Sun, 24 Nov 2024 07:47:47 -0500
Message-ID: <20241124124747.3338709-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
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
index 3ca91daddc9f5..e4156acc004d3 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1332,8 +1332,8 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 static void xol_free_insn_slot(struct task_struct *tsk)
 {
 	struct xol_area *area;
-	unsigned long vma_end;
 	unsigned long slot_addr;
+	unsigned long offset;
 
 	if (!tsk->mm || !tsk->mm->uprobes_state.xol_area || !tsk->utask)
 		return;
@@ -1342,24 +1342,21 @@ static void xol_free_insn_slot(struct task_struct *tsk)
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


