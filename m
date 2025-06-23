Return-Path: <stable+bounces-157417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7791AE53E7
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB301B624AC
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A0021FF2B;
	Mon, 23 Jun 2025 21:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xces23ms"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A5C1AD3FA;
	Mon, 23 Jun 2025 21:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715814; cv=none; b=YseRx9lmVWjOf8zs+oPpiIjcujP3h8t9VzBTk5lJL8sHXYpzggQWDL+8lFEpJTwFNoyhxPJDBYFKBHgDHgUAgK/mVr/TpbSy/sP7ydj3I0lzYa2tY8C59U3YNPsFJdeiCnzFL3e/j6Mbq3jV8gkc2+0IVSsNKhqj5HcmzO3VmQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715814; c=relaxed/simple;
	bh=5GkjxmU6f46+uFakvw9o1WUklsBdK5kbb7XkwQx8M9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sq0oNebIki4NnRO4lfLEzcL5h982tdbumZ1K81wgVI1jFWW92mJ5VsGs/uIbE//B7G31YciKXYktUZBNH4J2R64RPpDEHspwvbdNJqZTtW3zKOTJUHIGRMM9HFavSVgnv7bz8fdsEhW8TNvD4sxmS9KyphjmCbXC4BtUSWVLMiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xces23ms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAD8C4CEEA;
	Mon, 23 Jun 2025 21:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715814;
	bh=5GkjxmU6f46+uFakvw9o1WUklsBdK5kbb7XkwQx8M9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xces23msmlG6Z9amfi4Oplx7kio18XQYjaLI9lhilHLiKnegu0PgDjbGAv64xN9mu
	 jcFfcqus9jcEMbTR9iZq1MAYM4qOP+aBWfqqpGyEa1VfTOt+OpStT2WiGLdXBSoljh
	 LgNeI2/sRgLJz6VtYDG4OgS4q/aECYaWfhodaasE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+e2b1803445d236442e54@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 6.1 283/508] x86/iopl: Cure TIF_IO_BITMAP inconsistencies
Date: Mon, 23 Jun 2025 15:05:28 +0200
Message-ID: <20250623130652.224618355@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -154,6 +154,7 @@ int copy_thread(struct task_struct *p, c
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;
+	clear_tsk_thread_flag(p, TIF_IO_BITMAP);
 	p->thread.iopl_warn = 0;
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
 
@@ -428,6 +429,11 @@ void native_tss_update_io_bitmap(void)
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



