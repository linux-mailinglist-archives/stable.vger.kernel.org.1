Return-Path: <stable+bounces-37353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FF089C59F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E0A5B2934F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F477C6EB;
	Mon,  8 Apr 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FLePy6r5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BDC7C092;
	Mon,  8 Apr 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583984; cv=none; b=g5g2F2t97iTeiNjfnbcHWxibeWBVceoNOg1SpvYosBhReFt5BSrKYaIPt53crhD7d2wSGBVFN1NQqC70WFbtHuxgqzz9MQ/eEpBwopAa7CoiPnqEcBHHUytotlgCs82s/YwVqmba0SSMqOVVpOUUEuWU1OcstQYlOsvJaoKszEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583984; c=relaxed/simple;
	bh=TFOFUTjoq5AvmFApFGglUmCcMx49A2WDDaIXIGD6Dmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErKRrBJ+Jb7MqNH4UcJociIFCJxzL4ZkN8XuQr+c3nN6e/5nCS47Pn5XPFxNDh52WZUiJzwtItcaQO0kMM4QUahZsrA+I56f1myJ7y9h4SScBCn3D1Dxqfyvf/NiL3hI5CDMEd2Zcw/xPFvoAAVGfbnxHI0C7eT6OPBNLuqkHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FLePy6r5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C324EC433F1;
	Mon,  8 Apr 2024 13:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712583984;
	bh=TFOFUTjoq5AvmFApFGglUmCcMx49A2WDDaIXIGD6Dmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FLePy6r5XOH/8UcFrwM6vZF+rpJ25liJCgk2XEB0w8OVkna+yJJ3TYhH3kDUF35sQ
	 941qdTBsdX1y6qPFcWpJFEc8nMGuekbIm4LHmlQM6peZ9pXkeXu8tDCQm7W1tWpsbA
	 cHEKF1VblP1IjjWwzTwMl2pXHtERsJzVT3rZjeNk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan ORear <sorear@fastmail.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.8 242/273] riscv: process: Fix kernel gp leakage
Date: Mon,  8 Apr 2024 14:58:37 +0200
Message-ID: <20240408125316.949618033@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan O'Rear <sorear@fastmail.com>

commit d14fa1fcf69db9d070e75f1c4425211fa619dfc8 upstream.

childregs represents the registers which are active for the new thread
in user context. For a kernel thread, childregs->gp is never used since
the kernel gp is not touched by switch_to. For a user mode helper, the
gp value can be observed in user space after execve or possibly by other
means.

[From the email thread]

The /* Kernel thread */ comment is somewhat inaccurate in that it is also used
for user_mode_helper threads, which exec a user process, e.g. /sbin/init or
when /proc/sys/kernel/core_pattern is a pipe. Such threads do not have
PF_KTHREAD set and are valid targets for ptrace etc. even before they exec.

childregs is the *user* context during syscall execution and it is observable
from userspace in at least five ways:

1. kernel_execve does not currently clear integer registers, so the starting
   register state for PID 1 and other user processes started by the kernel has
   sp = user stack, gp = kernel __global_pointer$, all other integer registers
   zeroed by the memset in the patch comment.

   This is a bug in its own right, but I'm unwilling to bet that it is the only
   way to exploit the issue addressed by this patch.

2. ptrace(PTRACE_GETREGSET): you can PTRACE_ATTACH to a user_mode_helper thread
   before it execs, but ptrace requires SIGSTOP to be delivered which can only
   happen at user/kernel boundaries.

3. /proc/*/task/*/syscall: this is perfectly happy to read pt_regs for
   user_mode_helpers before the exec completes, but gp is not one of the
   registers it returns.

4. PERF_SAMPLE_REGS_USER: LOCKDOWN_PERF normally prevents access to kernel
   addresses via PERF_SAMPLE_REGS_INTR, but due to this bug kernel addresses
   are also exposed via PERF_SAMPLE_REGS_USER which is permitted under
   LOCKDOWN_PERF. I have not attempted to write exploit code.

5. Much of the tracing infrastructure allows access to user registers. I have
   not attempted to determine which forms of tracing allow access to user
   registers without already allowing access to kernel registers.

Fixes: 7db91e57a0ac ("RISC-V: Task implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan O'Rear <sorear@fastmail.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20240327061258.2370291-1-sorear@fastmail.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/kernel/process.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -27,8 +27,6 @@
 #include <asm/vector.h>
 #include <asm/cpufeature.h>
 
-register unsigned long gp_in_global __asm__("gp");
-
 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
 #include <linux/stackprotector.h>
 unsigned long __stack_chk_guard __read_mostly;
@@ -207,7 +205,6 @@ int copy_thread(struct task_struct *p, c
 	if (unlikely(args->fn)) {
 		/* Kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
-		childregs->gp = gp_in_global;
 		/* Supervisor/Machine, irqs on: */
 		childregs->status = SR_PP | SR_PIE;
 



