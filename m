Return-Path: <stable+bounces-36350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4796989BCD1
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB11E1F225E0
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DE652F7E;
	Mon,  8 Apr 2024 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SQXrd99f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743DC524AD
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571381; cv=none; b=OGziiJzm9MtJJfLIiQNsagNQp/HIoUDWjkHz8csymMq+SYjPoelEiEVCFvNU2dmSp61X7jwHdvOKh12+dp4kyrST/GyWY8nnIxfE43zTx9FbFja/GXnMh4YLj8d1bIymLlw1SPJNZpzPNt3UviGKpEQMPHUpWXskFVn6YZkkpAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571381; c=relaxed/simple;
	bh=g0ah6wefcAMZGeJeZTrgzwKbcBE92kjqivg6ijC+cu8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HQdsOY26jJ8kIiEQHLphmEg1YMxBTe3eXNba9yyYSABreVEdMUpcWUiNXvTa76Wq6UCQJf/CTSArBKLa7MwBPsC5xA2iCIrsP4/tjgK+0K7O+o3bEXkVk1/7TYB2IidUQsKI+8/V9v96imuWu9pfRdfZ7+8ir6JpfXZnHmzu7UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SQXrd99f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB6EC433C7;
	Mon,  8 Apr 2024 10:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712571381;
	bh=g0ah6wefcAMZGeJeZTrgzwKbcBE92kjqivg6ijC+cu8=;
	h=Subject:To:Cc:From:Date:From;
	b=SQXrd99fLuixE/smSTEATjPJFzwbDDZ8Tx9NVUTEioQA1mR1jQiYWwgx+ow5C0x73
	 r6ZtG+ADm/7XTJMjlNN7Uc8AQr5Sm3qcBVYMoZBUxpIju2tivgXNzp7ebYkgqAk85r
	 rWhYUvX3oW29SHUxl9uecAuWt7gQ0k4UNzTFYhCw=
Subject: FAILED: patch "[PATCH] riscv: process: Fix kernel gp leakage" failed to apply to 5.4-stable tree
To: sorear@fastmail.com,alexghiti@rivosinc.com,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Apr 2024 12:16:15 +0200
Message-ID: <2024040815-geometric-quaintly-f4a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x d14fa1fcf69db9d070e75f1c4425211fa619dfc8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040815-geometric-quaintly-f4a7@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

d14fa1fcf69d ("riscv: process: Fix kernel gp leakage")
fea2fed201ee ("riscv: Enable per-task stack canaries")
d7071743db31 ("RISC-V: Add EFI stub support.")
f2c9699f6555 ("riscv: Add STACKPROTECTOR supported")
a5d8e55b2c7d ("Merge tag 'v5.7-rc7' into efi/core, to refresh the branch and pick up fixes")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d14fa1fcf69db9d070e75f1c4425211fa619dfc8 Mon Sep 17 00:00:00 2001
From: Stefan O'Rear <sorear@fastmail.com>
Date: Wed, 27 Mar 2024 02:12:58 -0400
Subject: [PATCH] riscv: process: Fix kernel gp leakage

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

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 6abeecbfc51d..e4bc61c4e58a 100644
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
@@ -207,7 +205,6 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	if (unlikely(args->fn)) {
 		/* Kernel thread */
 		memset(childregs, 0, sizeof(struct pt_regs));
-		childregs->gp = gp_in_global;
 		/* Supervisor/Machine, irqs on: */
 		childregs->status = SR_PP | SR_PIE;
 


