Return-Path: <stable+bounces-94786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8817D9D6F1A
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322301629F3
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49311E200E;
	Sun, 24 Nov 2024 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibNx0p6l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793BC1C2323;
	Sun, 24 Nov 2024 12:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452406; cv=none; b=WOTNCDwQgp6DLucqYOWpDTSRPizoCcnf2Sybt9MiootwfmBAdu2oZ/Kj4QADLFBRw3E99++11gRM6H5iWn6s/zgsVTKlB1xt4SU2VatCtSHPr7UM4KLoaHhR2ygklolOqD2UYV/nc3esjceQJHud4gTHyOgby2k0hPb65/843zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452406; c=relaxed/simple;
	bh=JOG/03EV8u6TXR5qA1Qjwxo6330A49y44ozU8Lfay/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2b2EJbctXLd0XpIjMYVJ9xJvUI3yqJ66FHvbyQHXWH7VWaLMAZFd2hVpXb13wkmtTqlk0IQY/7WyB4m4Hi99gT1qHhkLRPAHOmmOm912tNP4AwcUxsYG+7/pBB2ONLAE09UcSszZelIHGMQW6rUmsqqoCNStuJ3z8a5oYUeABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibNx0p6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA78C4CECC;
	Sun, 24 Nov 2024 12:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452406;
	bh=JOG/03EV8u6TXR5qA1Qjwxo6330A49y44ozU8Lfay/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=ibNx0p6lqKgJECXQvgVYA63u8jJpBjNDarvK1L4BowdTBRWQiQMxtYaJE5YjBmHZu
	 J1B5unCoJHFdLb61y8KhrStYKhQkyaOUX7amGLMudZjJCP+C61y7z4UbV8zC80doEB
	 NgfAmy6U8bLzkWAZP48XGTwxXwGG9k08O1xNpLrY5Yh0Ba9eikqgShkVP9fQOg67Bt
	 zA1SS/oyyPJrG1e+SQurLeOff8JN+WvKj7ElA0MgQhjhRaFU9Kz4JtXqYL0XIawTSd
	 KRiLMdu/ifkdUQJ3DiN5jBUK9NI6zcvbyH0yNNVzR3iPykUxLE+8FPHRuq36Qxz4sV
	 BBx5aFT3F5r2A==
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
Subject: [PATCH AUTOSEL 6.11 1/5] uprobes: sanitiize xol_free_insn_slot()
Date: Sun, 24 Nov 2024 07:46:34 -0500
Message-ID: <20241124124643.3338173-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index 56cd0c7f516d3..5df99a1223c22 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1639,8 +1639,8 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 static void xol_free_insn_slot(struct task_struct *tsk)
 {
 	struct xol_area *area;
-	unsigned long vma_end;
 	unsigned long slot_addr;
+	unsigned long offset;
 
 	if (!tsk->mm || !tsk->mm->uprobes_state.xol_area || !tsk->utask)
 		return;
@@ -1649,24 +1649,21 @@ static void xol_free_insn_slot(struct task_struct *tsk)
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


