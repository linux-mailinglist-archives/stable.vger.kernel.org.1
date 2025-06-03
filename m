Return-Path: <stable+bounces-150719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A97ACC8C1
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 16:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FC587A07ED
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 14:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD9F23A9A5;
	Tue,  3 Jun 2025 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T3LuJQt7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0B8OcsWL"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A39D239086;
	Tue,  3 Jun 2025 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959707; cv=none; b=R4ftw5tsKDBwpYv4fwpv2Z6sUI/1lBDf19ShR1TUOIZrVhzBsIXrKW6MMM884fpIDMfJbf4mf3KdVFw54gzLQh3iJTE+N1vppkBXmIYGld9pUSlw0QYLg5hK8vvfuyyxfy08Fba+95RhJAt7Gf6HvaxlVsmrBLEYKAHIvgs1HWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959707; c=relaxed/simple;
	bh=5EudBcfEszL6gBVCnHkKuKmLA2viOUk0WrqkZ5BCh5o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BluOaq4x/rgySfDeG16t/OyDUm78I6iGEUnbhh3MD9sXpYYS8ZpTV1Bf9fG4UU0R2Cl3mZmRMztiRgyd8KMGg4U6SjACUpZuGsYeAoYl6IemA8QjaQbkZRWDHaYgiCEXfBOaT9/53/uAGO87GOreZLL8Tgw+hQjZOVqXN+mIpTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T3LuJQt7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0B8OcsWL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Jun 2025 14:08:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748959702;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTNeQM0OFI1EkFlZcWKkjPtR/twmYHMH0DZe3+JTBaI=;
	b=T3LuJQt7HuSuLowYaseWUFS9fpuKvbvHtnrgcLiz/ThVXugsW6wHK6XaSTHtS7uNNkQHgl
	BsM3cRZWUnOYiMAHDlbMpvP7pbkF6+g9tgGeXSiOixANUCSWUbVbP78EDPz9NuHTEJoXtL
	Lk1HzaGn5PUrQhjmxhdUGF7dpJuSh7Ha9GlBGkU85ppNgXWpRK15LbsNkte5UdiANCN5yB
	MbYJX9eVV99GZ8YZwif1FOQ+c5KRTDjyEqd4cNPaY6ZnMjCAYTcsuxx4JqFIdOa+gvtlWi
	F/QvguBDjrfyNONyJpkyQ4Xsk4uDE+j8mjUdBW6IYNvl1fbWFWUHwBlP9XCGog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748959702;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTNeQM0OFI1EkFlZcWKkjPtR/twmYHMH0DZe3+JTBaI=;
	b=0B8OcsWLgubo6569xtNaz8o15QPJuwP1KJ1+DDf4D6F+ZP5Mf+T2jVTb510RC5oZXAEGAD
	WN8+NR+vWjpk+fCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/iopl: Cure TIF_IO_BITMAP inconsistencies
Cc: syzbot+e2b1803445d236442e54@syzkaller.appspotmail.com,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87wmdceom2.ffs@tglx>
References: <87wmdceom2.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174895970095.406.15848786102493716530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8b68e978718f14fdcb080c2a7791c52a0d09bc6d
Gitweb:        https://git.kernel.org/tip/8b68e978718f14fdcb080c2a7791c52a0d09bc6d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 16:01:57 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 03 Jun 2025 15:56:39 +02:00

x86/iopl: Cure TIF_IO_BITMAP inconsistencies

io_bitmap_exit() is invoked from exit_thread() when a task exists or
when a fork fails. In the latter case the exit_thread() cleans up
resources which were allocated during fork().

io_bitmap_exit() invokes task_update_io_bitmap(), which in turn ends up
in tss_update_io_bitmap(). tss_update_io_bitmap() operates on the
current task. If current has TIF_IO_BITMAP set, but no bitmap installed,
tss_update_io_bitmap() crashes with a NULL pointer dereference.

There are two issues, which lead to that problem:

  1) io_bitmap_exit() should not invoke task_update_io_bitmap() when
     the task, which is cleaned up, is not the current task. That's a
     clear indicator for a cleanup after a failed fork().

  2) A task should not have TIF_IO_BITMAP set and neither a bitmap
     installed nor IOPL emulation level 3 activated.

     This happens when a kernel thread is created in the context of
     a user space thread, which has TIF_IO_BITMAP set as the thread
     flags are copied and the IO bitmap pointer is cleared.

     Other than in the failed fork() case this has no impact because
     kernel threads including IO workers never return to user space and
     therefore never invoke tss_update_io_bitmap().

Cure this by adding the missing cleanups and checks:

  1) Prevent io_bitmap_exit() to invoke task_update_io_bitmap() if
     the to be cleaned up task is not the current task.

  2) Clear TIF_IO_BITMAP in copy_thread() unconditionally. For user
     space forks it is set later, when the IO bitmap is inherited in
     io_bitmap_share().

For paranoia sake, add a warning into tss_update_io_bitmap() to catch
the case, when that code is invoked with inconsistent state.

Fixes: ea5f1cd7ab49 ("x86/ioperm: Remove bitmap if all permissions dropped")
Reported-by: syzbot+e2b1803445d236442e54@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/87wmdceom2.ffs@tglx
---
 arch/x86/kernel/ioport.c  | 13 +++++++++----
 arch/x86/kernel/process.c |  6 ++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 6290dd1..ff40f09 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -33,8 +33,9 @@ void io_bitmap_share(struct task_struct *tsk)
 	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
 }
 
-static void task_update_io_bitmap(struct task_struct *tsk)
+static void task_update_io_bitmap(void)
 {
+	struct task_struct *tsk = current;
 	struct thread_struct *t = &tsk->thread;
 
 	if (t->iopl_emul == 3 || t->io_bitmap) {
@@ -54,7 +55,12 @@ void io_bitmap_exit(struct task_struct *tsk)
 	struct io_bitmap *iobm = tsk->thread.io_bitmap;
 
 	tsk->thread.io_bitmap = NULL;
-	task_update_io_bitmap(tsk);
+	/*
+	 * Don't touch the TSS when invoked on a failed fork(). TSS
+	 * reflects the state of @current and not the state of @tsk.
+	 */
+	if (tsk == current)
+		task_update_io_bitmap();
 	if (iobm && refcount_dec_and_test(&iobm->refcnt))
 		kfree(iobm);
 }
@@ -192,8 +198,7 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 	}
 
 	t->iopl_emul = level;
-	task_update_io_bitmap(current);
-
+	task_update_io_bitmap();
 	return 0;
 }
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c1d2dac..704883c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -176,6 +176,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	frame->ret_addr = (unsigned long) ret_from_fork_asm;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;
+	clear_tsk_thread_flag(p, TIF_IO_BITMAP);
 	p->thread.iopl_warn = 0;
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
@@ -464,6 +465,11 @@ void native_tss_update_io_bitmap(void)
 	} else {
 		struct io_bitmap *iobm = t->io_bitmap;
 
+		if (WARN_ON_ONCE(!iobm)) {
+			clear_thread_flag(TIF_IO_BITMAP);
+			native_tss_invalidate_io_bitmap();
+		}
+
 		/*
 		 * Only copy bitmap data when the sequence number differs. The
 		 * update time is accounted to the incoming task.

