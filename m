Return-Path: <stable+bounces-108309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C913A0A7E4
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 10:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 226427A2F78
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 09:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168E3187553;
	Sun, 12 Jan 2025 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l6/aHGmb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D68BE8
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736672962; cv=none; b=ZiA/hmxxpe0csLzrio694EKChSJCi2uMmIvxa8E+jPemiGKSlpaZy+JAY4LZrdZXtGGe3v4LLhJYXlP4UCnFLg23LL/cYHe3zRBNInh/kHVjJ711kgNbG0qpJlQwYZds1sITHDJQ9/KH7YBWOUNBEQOt71qiyUkD3sJfI7u/gpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736672962; c=relaxed/simple;
	bh=rXG3C1n6hBdSkzKYozH6LRvRH/4z5Nt9nJRwvDlGpv8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ETURhEVwpXR01RtVbRAsDABOK2V177kvAdAqJC3lv63XlZpL8BbKN6RXZsFZPvaGISD2nm9uf5ItLl/aUPO9ElArdIuGcl5TqHdvbKGBRGPSdXBlsNLIhYyG4IyWNPda7Lt24e/wty2Y+CrZ6I7Ebdluh87XTmFJxryb7DIqSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l6/aHGmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A5DC4CEDF;
	Sun, 12 Jan 2025 09:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736672962;
	bh=rXG3C1n6hBdSkzKYozH6LRvRH/4z5Nt9nJRwvDlGpv8=;
	h=Subject:To:Cc:From:Date:From;
	b=l6/aHGmbmbiXAIT/5bwCnH+aKQteEvCW3JnHzXXQghtO59Kz39S1fNCKhbgEtumVM
	 VgB3ug1+wQtKEMtLeScsDEZGyW61E8HEs9LwGyFkil2Kn0seyhoyjl5GIFA8N0dBsM
	 3uHkOjP4QwUsSk0IaYaK0/hj/rj/Bn3TsOyVePxU=
Subject: FAILED: patch "[PATCH] riscv: Fix sleeping in invalid context in die()" failed to apply to 5.4-stable tree
To: namcao@linutronix.de,bigeasy@linutronix.de,palmer@rivosinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 12 Jan 2025 10:09:19 +0100
Message-ID: <2025011219-fondling-tweezers-0486@gregkh>
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
git cherry-pick -x 6a97f4118ac07cfdc316433f385dbdc12af5025e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011219-fondling-tweezers-0486@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6a97f4118ac07cfdc316433f385dbdc12af5025e Mon Sep 17 00:00:00 2001
From: Nam Cao <namcao@linutronix.de>
Date: Mon, 18 Nov 2024 10:13:33 +0100
Subject: [PATCH] riscv: Fix sleeping in invalid context in die()

die() can be called in exception handler, and therefore cannot sleep.
However, die() takes spinlock_t which can sleep with PREEMPT_RT enabled.
That causes the following warning:

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 285, name: mutex
preempt_count: 110001, expected: 0
RCU nest depth: 0, expected: 0
CPU: 0 UID: 0 PID: 285 Comm: mutex Not tainted 6.12.0-rc7-00022-ge19049cf7d56-dirty #234
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
    dump_backtrace+0x1c/0x24
    show_stack+0x2c/0x38
    dump_stack_lvl+0x5a/0x72
    dump_stack+0x14/0x1c
    __might_resched+0x130/0x13a
    rt_spin_lock+0x2a/0x5c
    die+0x24/0x112
    do_trap_insn_illegal+0xa0/0xea
    _new_vmalloc_restore_context_a0+0xcc/0xd8
Oops - illegal instruction [#1]

Switch to use raw_spinlock_t, which does not sleep even with PREEMPT_RT
enabled.

Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20241118091333.1185288-1-namcao@linutronix.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 51ebfd23e007..8ff8e8b36524 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -35,7 +35,7 @@
 
 int show_unhandled_signals = 1;
 
-static DEFINE_SPINLOCK(die_lock);
+static DEFINE_RAW_SPINLOCK(die_lock);
 
 static int copy_code(struct pt_regs *regs, u16 *val, const u16 *insns)
 {
@@ -81,7 +81,7 @@ void die(struct pt_regs *regs, const char *str)
 
 	oops_enter();
 
-	spin_lock_irqsave(&die_lock, flags);
+	raw_spin_lock_irqsave(&die_lock, flags);
 	console_verbose();
 	bust_spinlocks(1);
 
@@ -100,7 +100,7 @@ void die(struct pt_regs *regs, const char *str)
 
 	bust_spinlocks(0);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-	spin_unlock_irqrestore(&die_lock, flags);
+	raw_spin_unlock_irqrestore(&die_lock, flags);
 	oops_exit();
 
 	if (in_interrupt())


