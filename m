Return-Path: <stable+bounces-165060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B386CB14D9A
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 14:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD5718A2C11
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 12:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE18F2A1CF;
	Tue, 29 Jul 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvHrCoQj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63E262FF0
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753791888; cv=none; b=mXBfCdDFdyEISjhOV2xBGvunKMUuA9VeNKKNVZsXjL2ulXNzdOo6C0T2LQukqcPvOROhYBlW8C86JUYn+9Ro16na4GVcnqn6IrKi6qeziBtMNzZAg9PFn2jfa861cWOhG7A/s2DLZ/rorT3B7PwsPVxaUwDUyQ7s2FrZ6mrgZ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753791888; c=relaxed/simple;
	bh=+N69QnbU8CGI4ZqRRCughCONKa9hWfxUBKaj2QQ5ZgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9dIY+oS0sCiHmDLhkddvNU/WkDUOgfNjn9eFCeJSF1eGlxAvqhPgNqASV2EWXoy4x98UbIC0NsGjTpp7O4HqQrtbhJoUx/gFaimoGF060wgmx9RmOKlvsP4EywonY2blYXJF64QyO2WQ2aoRy8bFrDKdP3Q+CIIf3GShdDkg2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvHrCoQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A680C4CEEF;
	Tue, 29 Jul 2025 12:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753791888;
	bh=+N69QnbU8CGI4ZqRRCughCONKa9hWfxUBKaj2QQ5ZgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LvHrCoQjWeTmRMwXM4ag+9iLsWdBSx2B/AhzZb4lU0QATkQ9vMozII2flkYyi60Du
	 eWyKCHzopgeEEYSMNJFNTameFuNaWJvPURFWwQ7C5gpp68mr6hiwgSS+18jwkupUx0
	 VgIspLjUz6KKxUXGZ8/TVaBkDExg+ElGFR4mgTW97NRTD2OaJQ8spbk/nNyO5qj0it
	 aQxtO5u0TT7tOkYryyVAmmOxngJkmAai8pInnDbK8XZo4VNX2eSF4zeabg9xiyCc/b
	 DJIphMv+5OmZ/MkPZJROwfjftkDtQiyRUe2rpQgverb6NhgESdL4gxZ0fgc0vlEW1T
	 wNlKOjbfkzRMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Cristian Prundeanu <cpru@amazon.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] arm64/entry: Mask DAIF in cpu_switch_to(), call_on_irq_stack()
Date: Tue, 29 Jul 2025 08:24:21 -0400
Message-Id: <20250729122421.2688525-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072817-deeply-galleria-d758@gregkh>
References: <2025072817-deeply-galleria-d758@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

[ Upstream commit d42e6c20de6192f8e4ab4cf10be8c694ef27e8cb ]

`cpu_switch_to()` and `call_on_irq_stack()` manipulate SP to change
to different stacks along with the Shadow Call Stack if it is enabled.
Those two stack changes cannot be done atomically and both functions
can be interrupted by SErrors or Debug Exceptions which, though unlikely,
is very much broken : if interrupted, we can end up with mismatched stacks
and Shadow Call Stack leading to clobbered stacks.

In `cpu_switch_to()`, it can happen when SP_EL0 points to the new task,
but x18 stills points to the old task's SCS. When the interrupt handler
tries to save the task's SCS pointer, it will save the old task
SCS pointer (x18) into the new task struct (pointed to by SP_EL0),
clobbering it.

In `call_on_irq_stack()`, it can happen when switching from the task stack
to the IRQ stack and when switching back. In both cases, we can be
interrupted when the SCS pointer points to the IRQ SCS, but SP points to
the task stack. The nested interrupt handler pushes its return addresses
on the IRQ SCS. It then detects that SP points to the task stack,
calls `call_on_irq_stack()` and clobbers the task SCS pointer with
the IRQ SCS pointer, which it will also use !

This leads to tasks returning to addresses on the wrong SCS,
or even on the IRQ SCS, triggering kernel panics via CONFIG_VMAP_STACK
or FPAC if enabled.

This is possible on a default config, but unlikely.
However, when enabling CONFIG_ARM64_PSEUDO_NMI, DAIF is unmasked and
instead the GIC is responsible for filtering what interrupts the CPU
should receive based on priority.
Given the goal of emulating NMIs, pseudo-NMIs can be received by the CPU
even in `cpu_switch_to()` and `call_on_irq_stack()`, possibly *very*
frequently depending on the system configuration and workload, leading
to unpredictable kernel panics.

Completely mask DAIF in `cpu_switch_to()` and restore it when returning.
Do the same in `call_on_irq_stack()`, but restore and mask around
the branch.
Mask DAIF even if CONFIG_SHADOW_CALL_STACK is not enabled for consistency
of behaviour between all configurations.

Introduce and use an assembly macro for saving and masking DAIF,
as the existing one saves but only masks IF.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Reported-by: Cristian Prundeanu <cpru@amazon.com>
Fixes: 59b37fe52f49 ("arm64: Stash shadow stack pointer in the task struct on interrupt")
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20250718142814.133329-1-ada.coupriediaz@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
[ removed duplicate save_and_disable_daif macro ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/entry.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 62146d48dba7..4b4a9aa76e1a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -827,6 +827,7 @@ SYM_CODE_END(__bp_harden_el1_vectors)
  *
  */
 SYM_FUNC_START(cpu_switch_to)
+	save_and_disable_daif x11
 	mov	x10, #THREAD_CPU_CONTEXT
 	add	x8, x0, x10
 	mov	x9, sp
@@ -850,6 +851,7 @@ SYM_FUNC_START(cpu_switch_to)
 	ptrauth_keys_install_kernel x1, x8, x9, x10
 	scs_save x0
 	scs_load_current
+	restore_irq x11
 	ret
 SYM_FUNC_END(cpu_switch_to)
 NOKPROBE(cpu_switch_to)
@@ -876,6 +878,7 @@ NOKPROBE(ret_from_fork)
  * Calls func(regs) using this CPU's irq stack and shadow irq stack.
  */
 SYM_FUNC_START(call_on_irq_stack)
+	save_and_disable_daif x9
 #ifdef CONFIG_SHADOW_CALL_STACK
 	get_current_task x16
 	scs_save x16
@@ -890,8 +893,10 @@ SYM_FUNC_START(call_on_irq_stack)
 
 	/* Move to the new stack and call the function there */
 	add	sp, x16, #IRQ_STACK_SIZE
+	restore_irq x9
 	blr	x1
 
+	save_and_disable_daif x9
 	/*
 	 * Restore the SP from the FP, and restore the FP and LR from the frame
 	 * record.
@@ -899,6 +904,7 @@ SYM_FUNC_START(call_on_irq_stack)
 	mov	sp, x29
 	ldp	x29, x30, [sp], #16
 	scs_load_current
+	restore_irq x9
 	ret
 SYM_FUNC_END(call_on_irq_stack)
 NOKPROBE(call_on_irq_stack)
-- 
2.39.5


