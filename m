Return-Path: <stable+bounces-153803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA38CADD676
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9827B17B9A0
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC102EF2B8;
	Tue, 17 Jun 2025 16:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I8nygJLE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD372EA14E;
	Tue, 17 Jun 2025 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177149; cv=none; b=avD1sC4qUstuCob4RSrOxc+okf9UWEUht6ocfNcz2Z/Vrv17rYpDFDbwUIoRiDTTUFlYy5JnkbzWHcG5T8mA5zNtZdqj119RW5ZV2cbn9oH+oJS0fowOdAohNSBdrcq/p2QPNuXdZzUsOzwMhfLEKdllLTD8Xb1C2qm0sXyzhaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177149; c=relaxed/simple;
	bh=md+TxOl756FysgTZAgmmRNq2ZBEVTtqS15KcQuGExCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cnq//CvzFRtpD0gTdn36AUk09UO70PMSBLPt4BKyLmj8UU7Z9PcVKYYGsfOkGHe9w3ZVLp8OFkJRvQY86MwvPEc/Cp1NCs85r1v3pkKz2LmVoZIojSJl/5il/DXoe3PxHKP/35VOqCgy9MGSR6k8lkqPOXUO0Kd5n9uvoYnHJQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I8nygJLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5ADC4CEE3;
	Tue, 17 Jun 2025 16:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750177148;
	bh=md+TxOl756FysgTZAgmmRNq2ZBEVTtqS15KcQuGExCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I8nygJLEM5eQ/iVl4xLDQ9G8MQOz6+TGnlla+r5pwmmVEYW/ZyQZLVQRprqGAJkLR
	 zrRCNVaOoDq0dPHRcii/eL7ZBkTLGUhlXy8jAMcG6oK4ZL7+srHsvOAQWpMeabDdP/
	 bhnBvO5Fa/SZ3kiyNRrIylImHjjin+e9hnpnD3mo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+e2b1803445d236442e54@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.6 352/356] x86/iopl: Cure TIF_IO_BITMAP inconsistencies
Date: Tue, 17 Jun 2025 17:27:47 +0200
Message-ID: <20250617152352.305569814@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 8b68e978718f14fdcb080c2a7791c52a0d09bc6d upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/ioport.c  |   13 +++++++++----
 arch/x86/kernel/process.c |    6 ++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -33,8 +33,9 @@ void io_bitmap_share(struct task_struct
 	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
 }
 
-static void task_update_io_bitmap(struct task_struct *tsk)
+static void task_update_io_bitmap(void)
 {
+	struct task_struct *tsk = current;
 	struct thread_struct *t = &tsk->thread;
 
 	if (t->iopl_emul == 3 || t->io_bitmap) {
@@ -54,7 +55,12 @@ void io_bitmap_exit(struct task_struct *
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
@@ -192,8 +198,7 @@ SYSCALL_DEFINE1(iopl, unsigned int, leve
 	}
 
 	t->iopl_emul = level;
-	task_update_io_bitmap(current);
-
+	task_update_io_bitmap();
 	return 0;
 }
 
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -180,6 +180,7 @@ int copy_thread(struct task_struct *p, c
 	frame->ret_addr = (unsigned long) ret_from_fork_asm;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;
+	clear_tsk_thread_flag(p, TIF_IO_BITMAP);
 	p->thread.iopl_warn = 0;
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
@@ -468,6 +469,11 @@ void native_tss_update_io_bitmap(void)
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



