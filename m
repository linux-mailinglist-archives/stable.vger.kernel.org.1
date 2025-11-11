Return-Path: <stable+bounces-194500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E96C4EABB
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 16:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5DE3B2520
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D554E324707;
	Tue, 11 Nov 2025 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XOV4ic+H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0+KZeCa2"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BD32F90D3;
	Tue, 11 Nov 2025 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872215; cv=none; b=FTNsbRlR1t7YkjFAs9bs5rOUGEAObVkmkgYqFig9RoVya+GOweAl0aU29lORDFwFwG08EkzapmXOgUvm1qywPAgNTJHbfF912y1NYLEjNH/Uwn/1eHwSeSUAswBFt3Uk0iVIGpo48lEGfy1b7OsN/9jnelF26gvul+rAIELt4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872215; c=relaxed/simple;
	bh=MPu/tsOZkT6J35VS9D16ketf3w7CW09xPX2aNv8BGiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWMNga5HzQ0KxCpi5GT5Kq2mE8HPeregMfntGGYI565RKnwK/MFvT98MtjhLJOC6iyst8foEXV/yRuS80pBgvFLx6iQ7gucKCfSkmK15cXAYpKRhJnSRSEvtYYC3qMa/bGi+CF3F2gxH0Qpoocr/zadAznYSqsNZuD42+XJaFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XOV4ic+H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0+KZeCa2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762872211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b91XU7hHkSIra6MHumO32Fr5vsRcsLrtiPH/XTCjqNI=;
	b=XOV4ic+HXGvqHQaprQ+1Wiqu+OhiPXmHsNT4NZD5vuxD+6+2qpDs0gVoTGmMkrz0nFCxsm
	BE7hRRmz62S4ha7qQ+bNOM6MgQybVTUs7IPqL0LRZU+LoIEKBWvoIVVmmkm6sWvdJVD5UF
	taaynjfUH2OV53hlSeHrgXABcQoYOeQ+2LNvvNK+LkPgW0hkZsvtMfHG1fQ2Ug3WSlqPhw
	LpjRRfViaSMh7OqOJ+G0ZIk7wZ6nc6wo4vbI7YmIKWnWt4cL2zD/y/z1wB1yEoX+lvkVHF
	JaXZS9PnWi8FK3kEBAw1Knx+SI5qXzvyaM2itb8zOLkob+ZA5aX64XSuxI5TCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762872211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b91XU7hHkSIra6MHumO32Fr5vsRcsLrtiPH/XTCjqNI=;
	b=0+KZeCa2N9RV08W4UvShLECsB/34rtVclgZKmAJoNTZzLDul+ENaUGLa3rbKWPcW2irJeS
	C+2O1yZemBx/VFCg==
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
Subject: [PATCH printk v1 1/1] printk: Avoid scheduling irq_work on suspend
Date: Tue, 11 Nov 2025 15:49:22 +0106
Message-ID: <20251111144328.887159-2-john.ogness@linutronix.de>
In-Reply-To: <20251111144328.887159-1-john.ogness@linutronix.de>
References: <20251111144328.887159-1-john.ogness@linutronix.de>
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

Introduce a new global variable @console_offload_blocked to flag
when irq_work queueing is to be avoided. The flag is used by
printk_get_console_flush_type() to avoid allowing deferred printing
and switch NBCON consoles to atomic flushing. It is also used by
vprintk_emit() to avoid klogd waking.

Cc: <stable@vger.kernel.org> # 6.13.x because no drivers in 6.12.x
Fixes: 6b93bb41f6ea ("printk: Add non-BKL (nbcon) console basic infrastructure")
Closes: https://lore.kernel.org/lkml/DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  8 ++++---
 kernel/printk/printk.c   | 51 ++++++++++++++++++++++++++++------------
 2 files changed, 41 insertions(+), 18 deletions(-)

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
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5aee9ffb16b9a..94fc4a8662d4b 100644
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
-- 
2.47.3


