Return-Path: <stable+bounces-194706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A91C58BBA
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 17:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66C3F361D1F
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B34F357724;
	Thu, 13 Nov 2025 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vn4Kwj+C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0RHu7IV/"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816B7355038;
	Thu, 13 Nov 2025 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049836; cv=none; b=MzEL5gD2gq/lNjg9awWUbDELtIuKsuDBWleLKUVHNg+VJmaP3MKwDX2GUyVTu2nHAS9Jes6f7NQKe1+ows/JeyryKP0zDgKeFMXFoDnrUnM9WRsn9T+8t5PTEJ2sctKCosJt7IWQM+aUbjCLVoP0scpNOv5A3wvGTIWxVN60Bx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049836; c=relaxed/simple;
	bh=jsRjABolfvt58Su8HCoQgSIvPvsz0ytX+Sb2WJUG1hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVhSni7Pfk2J6T6cL1mateorn15MKQ8dY4KRV6y1S5WGVBORAOiQmsZeSJkuSmC/II4blo+3HNqQ/5vEaY+8fdoYa0UMeCKzN4EbmyzP3dkkUsnct3LxrXNl9bwjNxQGzBVCw4wHBLORcatdvQdeoTC/djtlwjqkSeSur5jhYJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vn4Kwj+C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0RHu7IV/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763049832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0x6UpLvGpne1nhqWuL/Iohd+4FDKyD/F9FrhWYniBNg=;
	b=Vn4Kwj+ChvdVWTEXHdQuLTlx7eoXKatFWvco7SwFylF+1bb5/rFJ3F3c3Vf1joN6m5zTM3
	PD2m5aSmtmGdfV+HIvtgB8SXC87VJKU8GYauy8X89yuwLLwzQdrkww9s1aOddxEQvr7Oxi
	LZjW819UpQRTvddtAScHmM0KOOnvFSm6cIHP6mw7H4g9eOl2AorO2w+Idg73uySHYWbO6S
	XrEutC3ut16vLMDwN1AWFexc3N3ZC/8hNr0Z/J44Ny85pWDaEJNoR7MSX0VVBh15cPeO+k
	UM5ViOST5DwvDzmUfksxdFJzuAckxFYjlHkvPhUJWttUDRyYLjecLTr8w0m+yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763049832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0x6UpLvGpne1nhqWuL/Iohd+4FDKyD/F9FrhWYniBNg=;
	b=0RHu7IV/97k+xouUohNtqmfeTikojcLheX+v+EfJdn46bJQaWW0AdgThM4p9Xx+lwOhVTE
	qhfrdjQ8bH5xf7Bw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sherry Sun <sherry.sun@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Derek Barbosa <debarbos@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH printk v2 2/2] printk: Avoid scheduling irq_work on suspend
Date: Thu, 13 Nov 2025 17:09:48 +0106
Message-ID: <20251113160351.113031-3-john.ogness@linutronix.de>
In-Reply-To: <20251113160351.113031-1-john.ogness@linutronix.de>
References: <20251113160351.113031-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allowing irq_work to be scheduled while trying to suspend has shown
to cause problems as some architectures interpret the pending
interrupts as a reason to not suspend. This became a problem for
printk() with the introduction of NBCON consoles. With every
printk() call, NBCON console printing kthreads are woken by queueing
irq_work. This means that irq_work continues to be queued due to
printk() calls late in the suspend procedure.

Avoid this problem by preventing printk() from queueing irq_work
once console suspending has begun. This applies to triggering NBCON
and legacy deferred printing as well as klogd waiters.

Since triggering of NBCON threaded printing relies on irq_work, the
pr_flush() within console_suspend_all() is used to perform the final
flushing before suspending consoles and blocking irq_work queueing.
NBCON consoles that are not suspended (due to the usage of the
"no_console_suspend" boot argument) transition to atomic flushing.

Introduce a new global variable @console_irqwork_blocked to flag
when irq_work queueing is to be avoided. The flag is used by
printk_get_console_flush_type() to avoid allowing deferred printing
and switch NBCON consoles to atomic flushing. It is also used by
vprintk_emit() to avoid klogd waking.

Add WARN_ON_ONCE(console_irqwork_blocked) to the irq_work queuing
functions to catch any code that attempts to queue printk irq_work
during the suspending/resuming procedure.

Cc: <stable@vger.kernel.org> # 6.13.x because no drivers in 6.12.x
Fixes: 6b93bb41f6ea ("printk: Add non-BKL (nbcon) console basic infrastructure")
Closes: https://lore.kernel.org/lkml/DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 @sherry.sun: This patch is essentially the same as v1, but since
 two WARN_ON_ONCE() were added, I decided not to use your
 Tested-by. It would be great if you could test again with this
 series.

 kernel/printk/internal.h |  8 +++---
 kernel/printk/nbcon.c    |  7 +++++
 kernel/printk/printk.c   | 58 +++++++++++++++++++++++++++++-----------
 3 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index f72bbfa266d6c..b20929b7d71f5 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -230,6 +230,8 @@ struct console_flush_type {
 	bool	legacy_offload;
 };
 
+extern bool console_irqwork_blocked;
+
 /*
  * Identify which console flushing methods should be used in the context of
  * the caller.
@@ -241,7 +243,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
 	switch (nbcon_get_default_prio()) {
 	case NBCON_PRIO_NORMAL:
 		if (have_nbcon_console && !have_boot_console) {
-			if (printk_kthreads_running)
+			if (printk_kthreads_running && !console_irqwork_blocked)
 				ft->nbcon_offload = true;
 			else
 				ft->nbcon_atomic = true;
@@ -251,7 +253,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
 		if (have_legacy_console || have_boot_console) {
 			if (!is_printk_legacy_deferred())
 				ft->legacy_direct = true;
-			else
+			else if (!console_irqwork_blocked)
 				ft->legacy_offload = true;
 		}
 		break;
@@ -264,7 +266,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
 		if (have_legacy_console || have_boot_console) {
 			if (!is_printk_legacy_deferred())
 				ft->legacy_direct = true;
-			else
+			else if (!console_irqwork_blocked)
 				ft->legacy_offload = true;
 		}
 		break;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 73f315fd97a3e..730d14f6cbc58 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1276,6 +1276,13 @@ void nbcon_kthreads_wake(void)
 	if (!printk_kthreads_running)
 		return;
 
+	/*
+	 * It is not allowed to call this function when console irq_work
+	 * is blocked.
+	 */
+	if (WARN_ON_ONCE(console_irqwork_blocked))
+		return;
+
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(con) {
 		if (!(console_srcu_read_flags(con) & CON_NBCON))
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dc89239cf1b58..b1c0d35cf3caa 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -462,6 +462,9 @@ bool have_boot_console;
 /* See printk_legacy_allow_panic_sync() for details. */
 bool legacy_allow_panic_sync;
 
+/* Avoid using irq_work when suspending. */
+bool console_irqwork_blocked;
+
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
@@ -2426,7 +2429,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	if (ft.legacy_offload)
 		defer_console_output();
-	else
+	else if (!console_irqwork_blocked)
 		wake_up_klogd();
 
 	return printed_len;
@@ -2730,10 +2733,20 @@ void console_suspend_all(void)
 {
 	struct console *con;
 
+	if (console_suspend_enabled)
+		pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
+
+	/*
+	 * Flush any console backlog and then avoid queueing irq_work until
+	 * console_resume_all(). Until then deferred printing is no longer
+	 * triggered, NBCON consoles transition to atomic flushing, and
+	 * any klogd waiters are not triggered.
+	 */
+	pr_flush(1000, true);
+	console_irqwork_blocked = true;
+
 	if (!console_suspend_enabled)
 		return;
-	pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
-	pr_flush(1000, true);
 
 	console_list_lock();
 	for_each_console(con)
@@ -2754,26 +2767,34 @@ void console_resume_all(void)
 	struct console_flush_type ft;
 	struct console *con;
 
-	if (!console_suspend_enabled)
-		return;
-
-	console_list_lock();
-	for_each_console(con)
-		console_srcu_write_flags(con, con->flags & ~CON_SUSPENDED);
-	console_list_unlock();
-
 	/*
-	 * Ensure that all SRCU list walks have completed. All printing
-	 * contexts must be able to see they are no longer suspended so
-	 * that they are guaranteed to wake up and resume printing.
+	 * Allow queueing irq_work. After restoring console state, deferred
+	 * printing and any klogd waiters need to be triggered in case there
+	 * is now a console backlog.
 	 */
-	synchronize_srcu(&console_srcu);
+	console_irqwork_blocked = false;
+
+	if (console_suspend_enabled) {
+		console_list_lock();
+		for_each_console(con)
+			console_srcu_write_flags(con, con->flags & ~CON_SUSPENDED);
+		console_list_unlock();
+
+		/*
+		 * Ensure that all SRCU list walks have completed. All printing
+		 * contexts must be able to see they are no longer suspended so
+		 * that they are guaranteed to wake up and resume printing.
+		 */
+		synchronize_srcu(&console_srcu);
+	}
 
 	printk_get_console_flush_type(&ft);
 	if (ft.nbcon_offload)
 		nbcon_kthreads_wake();
 	if (ft.legacy_offload)
 		defer_console_output();
+	else
+		wake_up_klogd();
 
 	pr_flush(1000, true);
 }
@@ -4511,6 +4532,13 @@ static void __wake_up_klogd(int val)
 	if (!printk_percpu_data_ready())
 		return;
 
+	/*
+	 * It is not allowed to call this function when console irq_work
+	 * is blocked.
+	 */
+	if (WARN_ON_ONCE(console_irqwork_blocked))
+		return;
+
 	preempt_disable();
 	/*
 	 * Guarantee any new records can be seen by tasks preparing to wait
-- 
2.47.3


