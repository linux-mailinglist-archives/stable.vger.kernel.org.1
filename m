Return-Path: <stable+bounces-9025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B6B82086B
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 21:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B353B21AD6
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 20:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111D6C13D;
	Sat, 30 Dec 2023 20:13:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9747C12B
	for <stable@vger.kernel.org>; Sat, 30 Dec 2023 20:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C65C433C7;
	Sat, 30 Dec 2023 20:13:45 +0000 (UTC)
Date: Sat, 30 Dec 2023 15:14:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 <stable@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] tracing: Disable snapshot buffer when
 stopping instance" failed to apply to 5.4-stable tree
Message-ID: <20231230151439.4802d6b2@gandalf.local.home>
In-Reply-To: <2023120908-crisply-trash-d37e@gregkh>
References: <2023120908-crisply-trash-d37e@gregkh>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 09 Dec 2023 13:27:08 +0100
<gregkh@linuxfoundation.org> wrote:

> The patch below does not apply to the 5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
> git checkout FETCH_HEAD
> git cherry-pick -x b538bf7d0ec11ca49f536dfda742a5f6db90a798
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120908-crisply-trash-d37e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..
> 
> Possible dependencies:
> 
> b538bf7d0ec1 ("tracing: Disable snapshot buffer when stopping instance tracers")
> 13292494379f ("tracing: Make struct ring_buffer less ambiguous")
> 1c5eb4481e01 ("tracing: Rename trace_buffer to array_buffer")
> 2d6425af6116 ("tracing: Declare newly exported APIs in include/linux/trace.h")
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> >From b538bf7d0ec11ca49f536dfda742a5f6db90a798 Mon Sep 17 00:00:00 2001  
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> Date: Tue, 5 Dec 2023 16:52:11 -0500
> Subject: [PATCH] tracing: Disable snapshot buffer when stopping instance
>  tracers
> 

This is the fix for 5.4.265, although running tests on it, there appears
to be other issues with snapshot and 5.4.265 with and without this patch.

I don't have time to investigate though.

-- Steve


diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d7ca8f97b315..a1967c46af12 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2039,13 +2039,7 @@ int is_tracing_stopped(void)
 	return global_trace.stop_count;
 }
 
-/**
- * tracing_start - quick start of the tracer
- *
- * If tracing is enabled but was stopped by tracing_stop,
- * this will start the tracer back up.
- */
-void tracing_start(void)
+static void tracing_start_tr(struct trace_array *tr)
 {
 	struct ring_buffer *buffer;
 	unsigned long flags;
@@ -2053,119 +2047,83 @@ void tracing_start(void)
 	if (tracing_disabled)
 		return;
 
-	raw_spin_lock_irqsave(&global_trace.start_lock, flags);
-	if (--global_trace.stop_count) {
-		if (global_trace.stop_count < 0) {
+	raw_spin_lock_irqsave(&tr->start_lock, flags);
+	if (--tr->stop_count) {
+		if (WARN_ON_ONCE(tr->stop_count < 0)) {
 			/* Someone screwed up their debugging */
-			WARN_ON_ONCE(1);
-			global_trace.stop_count = 0;
+			tr->stop_count = 0;
 		}
 		goto out;
 	}
 
 	/* Prevent the buffers from switching */
-	arch_spin_lock(&global_trace.max_lock);
+	arch_spin_lock(&tr->max_lock);
 
-	buffer = global_trace.trace_buffer.buffer;
+	buffer = tr->trace_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_enable(buffer);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	buffer = global_trace.max_buffer.buffer;
+	buffer = tr->max_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_enable(buffer);
 #endif
 
-	arch_spin_unlock(&global_trace.max_lock);
-
- out:
-	raw_spin_unlock_irqrestore(&global_trace.start_lock, flags);
-}
-
-static void tracing_start_tr(struct trace_array *tr)
-{
-	struct ring_buffer *buffer;
-	unsigned long flags;
-
-	if (tracing_disabled)
-		return;
-
-	/* If global, we need to also start the max tracer */
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
-		return tracing_start();
-
-	raw_spin_lock_irqsave(&tr->start_lock, flags);
-
-	if (--tr->stop_count) {
-		if (tr->stop_count < 0) {
-			/* Someone screwed up their debugging */
-			WARN_ON_ONCE(1);
-			tr->stop_count = 0;
-		}
-		goto out;
-	}
-
-	buffer = tr->trace_buffer.buffer;
-	if (buffer)
-		ring_buffer_record_enable(buffer);
+	arch_spin_unlock(&tr->max_lock);
 
  out:
 	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
 }
 
 /**
- * tracing_stop - quick stop of the tracer
+ * tracing_start - quick start of the tracer
  *
- * Light weight way to stop tracing. Use in conjunction with
- * tracing_start.
+ * If tracing is enabled but was stopped by tracing_stop,
+ * this will start the tracer back up.
  */
-void tracing_stop(void)
+void tracing_start(void)
+
+{
+	return tracing_start_tr(&global_trace);
+}
+
+static void tracing_stop_tr(struct trace_array *tr)
 {
 	struct ring_buffer *buffer;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&global_trace.start_lock, flags);
-	if (global_trace.stop_count++)
+	raw_spin_lock_irqsave(&tr->start_lock, flags);
+	if (tr->stop_count++)
 		goto out;
 
 	/* Prevent the buffers from switching */
-	arch_spin_lock(&global_trace.max_lock);
+	arch_spin_lock(&tr->max_lock);
 
-	buffer = global_trace.trace_buffer.buffer;
+	buffer = tr->trace_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_disable(buffer);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	buffer = global_trace.max_buffer.buffer;
+	buffer = tr->max_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_disable(buffer);
 #endif
 
-	arch_spin_unlock(&global_trace.max_lock);
+	arch_spin_unlock(&tr->max_lock);
 
  out:
-	raw_spin_unlock_irqrestore(&global_trace.start_lock, flags);
+	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
 }
 
-static void tracing_stop_tr(struct trace_array *tr)
+/**
+ * tracing_stop - quick stop of the tracer
+ *
+ * Light weight way to stop tracing. Use in conjunction with
+ * tracing_start.
+ */
+void tracing_stop(void)
 {
-	struct ring_buffer *buffer;
-	unsigned long flags;
-
-	/* If global, we need to also stop the max tracer */
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
-		return tracing_stop();
-
-	raw_spin_lock_irqsave(&tr->start_lock, flags);
-	if (tr->stop_count++)
-		goto out;
-
-	buffer = tr->trace_buffer.buffer;
-	if (buffer)
-		ring_buffer_record_disable(buffer);
-
- out:
-	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
+	return tracing_stop_tr(&global_trace);
 }
 
 static int trace_save_cmdline(struct task_struct *tsk)

