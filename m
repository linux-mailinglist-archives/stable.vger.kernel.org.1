Return-Path: <stable+bounces-165061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02863B14DD1
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 14:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D31C3B52B2
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 12:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7921E291C03;
	Tue, 29 Jul 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jjisc1tw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CA8238C20
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753793069; cv=none; b=UYCsUJ5HrOZPSeOrTcgUDx0MwUVResvDRnjK+Rl+DnEGmezjNciL494ZxE8V1puV3lTWYeRhsiPNj7RUF/Q/DcrvZl3M2OwQglYpoe/9h+FmQVMXdYuoiIhMKdLUySOF0UX7aWAnFTZD/6Ji+nTCEV5toanpizz1qx9pvoWOEFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753793069; c=relaxed/simple;
	bh=IvGy0Ssa66RZgtaURNknpbKp/p3fsSSmCOzrqt9uf7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AISGZDpKK2gHCoEe9nEYQjaqTIIP1fRP7C3hwom/ExXY6uPXMH1BchmCY1Xqer2gR2aopI71pBU7WrKT4GUhzR6zXbqf1HHmAgf8DaX5YJTKj4Cw1Fo49hjjEyva4yXy8LDPLLUM7BWIakmBLl2ecigvHewv5G3N3VqNrBmKVVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jjisc1tw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9589AC4CEF4;
	Tue, 29 Jul 2025 12:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753793068;
	bh=IvGy0Ssa66RZgtaURNknpbKp/p3fsSSmCOzrqt9uf7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jjisc1tw/HSy2xwZacyj3h9HKtx316+qhdU0W8NnUBBV+ajCSjEvZepSVcHBHwHhW
	 cNMVJzJeGFcH+175eO5OvTzoVFVfUaZsYHdquvaFS5pHgJqyL4MkNBczp0CItX5jbD
	 55aP3+YtzYUoBhp5D7VFrT2o51y9NjRzdzbCH2+vFtLZANQOnzelsvyTLyfbASeHqq
	 9F1AqHYbsWl6lS918Tq69RxtCEWUkQshO3nJMhMVLftpTPGjDZfQXeAsbcOGaUsATN
	 mHn5UgYhrxsli0IuG8Se+lH6RdWjmolezhmiQj8YeE9jXeACL6rF2wlDOJVyhhrBGM
	 rPfoudug3wZfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Cristian Prundeanu <cpru@amazon.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] arm64/entry: Mask DAIF in cpu_switch_to(), call_on_irq_stack()
Date: Tue, 29 Jul 2025 08:44:24 -0400
Message-Id: <20250729124424.2699860-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072811-pension-lyrics-6070@gregkh>
References: <2025072811-pension-lyrics-6070@gregkh>
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
index bdc5f744249b..d0882ce3d97d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -833,6 +833,7 @@ SYM_CODE_END(__bp_harden_el1_vectors)
  *
  */
 SYM_FUNC_START(cpu_switch_to)
+	save_and_disable_daif x11
 	mov	x10, #THREAD_CPU_CONTEXT
 	add	x8, x0, x10
 	mov	x9, sp
@@ -856,6 +857,7 @@ SYM_FUNC_START(cpu_switch_to)
 	ptrauth_keys_install_kernel x1, x8, x9, x10
 	scs_save x0
 	scs_load_current
+	restore_irq x11
 	ret
 SYM_FUNC_END(cpu_switch_to)
 NOKPROBE(cpu_switch_to)
@@ -882,6 +884,7 @@ NOKPROBE(ret_from_fork)
  * Calls func(regs) using this CPU's irq stack and shadow irq stack.
  */
 SYM_FUNC_START(call_on_irq_stack)
+	save_and_disable_daif x9
 #ifdef CONFIG_SHADOW_CALL_STACK
 	get_current_task x16
 	scs_save x16
@@ -896,8 +899,10 @@ SYM_FUNC_START(call_on_irq_stack)
 
 	/* Move to the new stack and call the function there */
 	add	sp, x16, #IRQ_STACK_SIZE
+	restore_irq x9
 	blr	x1
 
+	save_and_disable_daif x9
 	/*
 	 * Restore the SP from the FP, and restore the FP and LR from the frame
 	 * record.
@@ -905,6 +910,7 @@ SYM_FUNC_START(call_on_irq_stack)
 	mov	sp, x29
 	ldp	x29, x30, [sp], #16
 	scs_load_current
+	restore_irq x9
 	ret
 SYM_FUNC_END(call_on_irq_stack)
 NOKPROBE(call_on_irq_stack)
-- 
2.39.5


