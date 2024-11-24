Return-Path: <stable+bounces-94781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BF19D6F10
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DAA1621B3
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7BB1BF300;
	Sun, 24 Nov 2024 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rifF6LT6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C503D1BBBEE;
	Sun, 24 Nov 2024 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452386; cv=none; b=gEh9CZpSDEXlG4qFzlUk1ai9CbJtnfwGCSwMHjj6J452pOFqUXqCjwIVWUIclHFlcOKrCyNHJJSQ3tsjW4nxHXj2/P82coW0S6l+YSMRyvvPA0kVubMoT6Z3qiHN7RwlDsmy5jrt29h7sHRd44AH7cF7o+VAz2BSBy9C40TGtF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452386; c=relaxed/simple;
	bh=sA9g5Eu8ASeFls4iVRs/Rqrj0T7ijfTMFjnwdbEAiSM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r76KKXn5NHZFCQspKAf5/HNLDD/LIpp5BwnjNyr178JKEmyZD11+vVWtU/zK8pLdDAQN7EP/OMjCy2cGCAGZSObETt5uHiud0vH8s6Wm85xnu4RBpFFEesEqk0ATOK3y4qMPJHSe2LY3XxceH+LdOllY94wJE7nCEG0FGsm6r6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rifF6LT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEC9C4CECC;
	Sun, 24 Nov 2024 12:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452386;
	bh=sA9g5Eu8ASeFls4iVRs/Rqrj0T7ijfTMFjnwdbEAiSM=;
	h=From:To:Cc:Subject:Date:From;
	b=rifF6LT63qSJKtKTKu5fQiJ+/8fOXmx6BFYqzai65XPBTzRrnvMRhfSmpZnLEk+mJ
	 b4IYWHp7Rd2EQrMrFO43/bASN0toEqrD5/2fyjMiza57E0W1QrcHxZvJEOulDyzy7N
	 p4Rji9lPkbx5/jl6g1StrnmkOSb4KWgF7A0c2ES4ijJWtHaTf3zd9XMPXEVvrzyC2k
	 s/ZJe/Wy876Pz5TK/D3t/S+DORFtMOE6OGYyfGEf/Ri1kQs7hMr5IgiQNYGFkmLCXd
	 3BSnTT/QB3dsaXTdjc6avUvD6My588oAiUCglXHWrrT1KhR23mqAzDvCPm3w73mhng
	 tbmSuq2OsTV0Q==
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
Subject: [PATCH AUTOSEL 6.12 1/5] uprobes: sanitiize xol_free_insn_slot()
Date: Sun, 24 Nov 2024 07:46:13 -0500
Message-ID: <20241124124623.3337983-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 4b52cb2ae6d62..cc605df73d72f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1683,8 +1683,8 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 static void xol_free_insn_slot(struct task_struct *tsk)
 {
 	struct xol_area *area;
-	unsigned long vma_end;
 	unsigned long slot_addr;
+	unsigned long offset;
 
 	if (!tsk->mm || !tsk->mm->uprobes_state.xol_area || !tsk->utask)
 		return;
@@ -1693,24 +1693,21 @@ static void xol_free_insn_slot(struct task_struct *tsk)
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


