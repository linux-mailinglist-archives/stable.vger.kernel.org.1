Return-Path: <stable+bounces-5131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3860E80B432
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 13:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E360A2810D0
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82E314293;
	Sat,  9 Dec 2023 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hf2DxPSj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FEA14286
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 12:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD9CC433C8;
	Sat,  9 Dec 2023 12:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702124839;
	bh=ezgQiL2UkB9jjcxE1R+tyKatuFzKlkdwi8Y6Sl7jm8E=;
	h=Subject:To:Cc:From:Date:From;
	b=Hf2DxPSjKZEj1HJfIhUxriz+WEPNgJbKc/fJKilHXhp74+dcs5P7gugMCixaCVxD7
	 DtQp0Q/fyljBxmIPAjR2YzuWInYRT36IGdEK1v5z1vfGBZcHqFCL0O7N8ES25kqjMw
	 Jz8lsWqelW4X0Jjv7oqDi9YygE35rSRBmKNJ38SA=
Subject: FAILED: patch "[PATCH] tracing: Disable snapshot buffer when stopping instance" failed to apply to 4.14-stable tree
To: rostedt@goodmis.org,akpm@linux-foundation.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Dec 2023 13:27:10 +0100
Message-ID: <2023120910-reputable-mummy-5f86@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x b538bf7d0ec11ca49f536dfda742a5f6db90a798
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120910-reputable-mummy-5f86@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

b538bf7d0ec1 ("tracing: Disable snapshot buffer when stopping instance tracers")
13292494379f ("tracing: Make struct ring_buffer less ambiguous")
1c5eb4481e01 ("tracing: Rename trace_buffer to array_buffer")
2d6425af6116 ("tracing: Declare newly exported APIs in include/linux/trace.h")
a47b53e95acc ("tracing: Rename tracing_reset() to tracing_reset_cpu()")
46cc0b44428d ("tracing/snapshot: Resize spare buffer if size changed")
d2d8b146043a ("Merge tag 'trace-v5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b538bf7d0ec11ca49f536dfda742a5f6db90a798 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Tue, 5 Dec 2023 16:52:11 -0500
Subject: [PATCH] tracing: Disable snapshot buffer when stopping instance
 tracers

It use to be that only the top level instance had a snapshot buffer (for
latency tracers like wakeup and irqsoff). When stopping a tracer in an
instance would not disable the snapshot buffer. This could have some
unintended consequences if the irqsoff tracer is enabled.

Consolidate the tracing_start/stop() with tracing_start/stop_tr() so that
all instances behave the same. The tracing_start/stop() functions will
just call their respective tracing_start/stop_tr() with the global_array
passed in.

Link: https://lkml.kernel.org/r/20231205220011.041220035@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 6d9b3fa5e7f6 ("tracing: Move tracing_max_latency into trace_array")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e978868b1a22..2492c6c76850 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2360,49 +2360,6 @@ int is_tracing_stopped(void)
 	return global_trace.stop_count;
 }
 
-/**
- * tracing_start - quick start of the tracer
- *
- * If tracing is enabled but was stopped by tracing_stop,
- * this will start the tracer back up.
- */
-void tracing_start(void)
-{
-	struct trace_buffer *buffer;
-	unsigned long flags;
-
-	if (tracing_disabled)
-		return;
-
-	raw_spin_lock_irqsave(&global_trace.start_lock, flags);
-	if (--global_trace.stop_count) {
-		if (global_trace.stop_count < 0) {
-			/* Someone screwed up their debugging */
-			WARN_ON_ONCE(1);
-			global_trace.stop_count = 0;
-		}
-		goto out;
-	}
-
-	/* Prevent the buffers from switching */
-	arch_spin_lock(&global_trace.max_lock);
-
-	buffer = global_trace.array_buffer.buffer;
-	if (buffer)
-		ring_buffer_record_enable(buffer);
-
-#ifdef CONFIG_TRACER_MAX_TRACE
-	buffer = global_trace.max_buffer.buffer;
-	if (buffer)
-		ring_buffer_record_enable(buffer);
-#endif
-
-	arch_spin_unlock(&global_trace.max_lock);
-
- out:
-	raw_spin_unlock_irqrestore(&global_trace.start_lock, flags);
-}
-
 static void tracing_start_tr(struct trace_array *tr)
 {
 	struct trace_buffer *buffer;
@@ -2411,25 +2368,70 @@ static void tracing_start_tr(struct trace_array *tr)
 	if (tracing_disabled)
 		return;
 
-	/* If global, we need to also start the max tracer */
-	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
-		return tracing_start();
-
 	raw_spin_lock_irqsave(&tr->start_lock, flags);
-
 	if (--tr->stop_count) {
-		if (tr->stop_count < 0) {
+		if (WARN_ON_ONCE(tr->stop_count < 0)) {
 			/* Someone screwed up their debugging */
-			WARN_ON_ONCE(1);
 			tr->stop_count = 0;
 		}
 		goto out;
 	}
 
+	/* Prevent the buffers from switching */
+	arch_spin_lock(&tr->max_lock);
+
 	buffer = tr->array_buffer.buffer;
 	if (buffer)
 		ring_buffer_record_enable(buffer);
 
+#ifdef CONFIG_TRACER_MAX_TRACE
+	buffer = tr->max_buffer.buffer;
+	if (buffer)
+		ring_buffer_record_enable(buffer);
+#endif
+
+	arch_spin_unlock(&tr->max_lock);
+
+ out:
+	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
+}
+
+/**
+ * tracing_start - quick start of the tracer
+ *
+ * If tracing is enabled but was stopped by tracing_stop,
+ * this will start the tracer back up.
+ */
+void tracing_start(void)
+
+{
+	return tracing_start_tr(&global_trace);
+}
+
+static void tracing_stop_tr(struct trace_array *tr)
+{
+	struct trace_buffer *buffer;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&tr->start_lock, flags);
+	if (tr->stop_count++)
+		goto out;
+
+	/* Prevent the buffers from switching */
+	arch_spin_lock(&tr->max_lock);
+
+	buffer = tr->array_buffer.buffer;
+	if (buffer)
+		ring_buffer_record_disable(buffer);
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+	buffer = tr->max_buffer.buffer;
+	if (buffer)
+		ring_buffer_record_disable(buffer);
+#endif
+
+	arch_spin_unlock(&tr->max_lock);
+
  out:
 	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
 }
@@ -2442,51 +2444,7 @@ static void tracing_start_tr(struct trace_array *tr)
  */
 void tracing_stop(void)
 {
-	struct trace_buffer *buffer;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&global_trace.start_lock, flags);
-	if (global_trace.stop_count++)
-		goto out;
-
-	/* Prevent the buffers from switching */
-	arch_spin_lock(&global_trace.max_lock);
-
-	buffer = global_trace.array_buffer.buffer;
-	if (buffer)
-		ring_buffer_record_disable(buffer);
-
-#ifdef CONFIG_TRACER_MAX_TRACE
-	buffer = global_trace.max_buffer.buffer;
-	if (buffer)
-		ring_buffer_record_disable(buffer);
-#endif
-
-	arch_spin_unlock(&global_trace.max_lock);
-
- out:
-	raw_spin_unlock_irqrestore(&global_trace.start_lock, flags);
-}
-
-static void tracing_stop_tr(struct trace_array *tr)
-{
-	struct trace_buffer *buffer;
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
-	buffer = tr->array_buffer.buffer;
-	if (buffer)
-		ring_buffer_record_disable(buffer);
-
- out:
-	raw_spin_unlock_irqrestore(&tr->start_lock, flags);
+	return tracing_stop_tr(&global_trace);
 }
 
 static int trace_save_cmdline(struct task_struct *tsk)


