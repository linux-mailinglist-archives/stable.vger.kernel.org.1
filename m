Return-Path: <stable+bounces-9251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9B9822AE2
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 11:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F74283316
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 10:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C447518623;
	Wed,  3 Jan 2024 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FLNdg8q7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4A318653
	for <stable@vger.kernel.org>; Wed,  3 Jan 2024 10:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3ABC433C8;
	Wed,  3 Jan 2024 10:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704276209;
	bh=8E/0BnUsaPe2XOQkG0wiPMK/6tkt0P0XMKSEpzREJBI=;
	h=Subject:To:Cc:From:Date:From;
	b=FLNdg8q7LuRndYkPr0XahEKGHAd7rLNd/qrrf434t++eJaABiWjtNnQb/Agu0Jdfo
	 N8gq69zpUVlEYz6qq8JY5KjsMnn86J/RhHhXCO0bHSz8AyOVuF61/6Co46O191fRA0
	 RD9NKUzUlgxINB95ZehcAAqqDPTrpbDhcLUWvy6E=
Subject: FAILED: patch "[PATCH] tracing: Fix blocked reader of snapshot buffer" failed to apply to 4.14-stable tree
To: rostedt@goodmis.org,mark.rutland@arm.com,mathieu.desnoyers@efficios.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 03 Jan 2024 11:03:16 +0100
Message-ID: <2024010316-scrambled-backless-32db@gregkh>
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
git cherry-pick -x 39a7dc23a1ed0fe81141792a09449d124c5953bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024010316-scrambled-backless-32db@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

39a7dc23a1ed ("tracing: Fix blocked reader of snapshot buffer")
f3ddb74ad079 ("tracing: Wake up ring buffer waiters on closing of the file")
7e9fbbb1b776 ("ring-buffer: Add ring_buffer_wake_waiters()")
efbbdaa22bb7 ("tracing: Show real address for trace event arguments")
8e99cf91b99b ("tracing: Do not allocate buffer in trace_find_next_entry() in atomic")
ff895103a84a ("tracing: Save off entry when peeking at next entry")
1c5eb4481e01 ("tracing: Rename trace_buffer to array_buffer")
a47b53e95acc ("tracing: Rename tracing_reset() to tracing_reset_cpu()")
46cc0b44428d ("tracing/snapshot: Resize spare buffer if size changed")
d2d8b146043a ("Merge tag 'trace-v5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 39a7dc23a1ed0fe81141792a09449d124c5953bd Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Thu, 28 Dec 2023 09:51:49 -0500
Subject: [PATCH] tracing: Fix blocked reader of snapshot buffer

If an application blocks on the snapshot or snapshot_raw files, expecting
to be woken up when a snapshot occurs, it will not happen. Or it may
happen with an unexpected result.

That result is that the application will be reading the main buffer
instead of the snapshot buffer. That is because when the snapshot occurs,
the main and snapshot buffers are swapped. But the reader has a descriptor
still pointing to the buffer that it originally connected to.

This is fine for the main buffer readers, as they may be blocked waiting
for a watermark to be hit, and when a snapshot occurs, the data that the
main readers want is now on the snapshot buffer.

But for waiters of the snapshot buffer, they are waiting for an event to
occur that will trigger the snapshot and they can then consume it quickly
to save the snapshot before the next snapshot occurs. But to do this, they
need to read the new snapshot buffer, not the old one that is now
receiving new data.

Also, it does not make sense to have a watermark "buffer_percent" on the
snapshot buffer, as the snapshot buffer is static and does not receive new
data except all at once.

Link: https://lore.kernel.org/linux-trace-kernel/20231228095149.77f5b45d@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: debdd57f5145f ("tracing: Make a snapshot feature available from userspace")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 32c0dd2fd1c3..9286f88fcd32 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -949,7 +949,8 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 	/* make sure the waiters see the new index */
 	smp_wmb();
 
-	rb_wake_up_waiters(&rbwork->work);
+	/* This can be called in any context */
+	irq_work_queue(&rbwork->work);
 }
 
 /**
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 199df497db07..a0defe156b57 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1894,6 +1894,9 @@ update_max_tr(struct trace_array *tr, struct task_struct *tsk, int cpu,
 	__update_max_tr(tr, tsk, cpu);
 
 	arch_spin_unlock(&tr->max_lock);
+
+	/* Any waiters on the old snapshot buffer need to wake up */
+	ring_buffer_wake_waiters(tr->array_buffer.buffer, RING_BUFFER_ALL_CPUS);
 }
 
 /**
@@ -1945,12 +1948,23 @@ update_max_tr_single(struct trace_array *tr, struct task_struct *tsk, int cpu)
 
 static int wait_on_pipe(struct trace_iterator *iter, int full)
 {
+	int ret;
+
 	/* Iterators are static, they should be filled or empty */
 	if (trace_buffer_iter(iter, iter->cpu_file))
 		return 0;
 
-	return ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file,
-				full);
+	ret = ring_buffer_wait(iter->array_buffer->buffer, iter->cpu_file, full);
+
+#ifdef CONFIG_TRACER_MAX_TRACE
+	/*
+	 * Make sure this is still the snapshot buffer, as if a snapshot were
+	 * to happen, this would now be the main buffer.
+	 */
+	if (iter->snapshot)
+		iter->array_buffer = &iter->tr->max_buffer;
+#endif
+	return ret;
 }
 
 #ifdef CONFIG_FTRACE_STARTUP_TEST
@@ -8517,7 +8531,7 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 
 		wait_index = READ_ONCE(iter->wait_index);
 
-		ret = wait_on_pipe(iter, iter->tr->buffer_percent);
+		ret = wait_on_pipe(iter, iter->snapshot ? 0 : iter->tr->buffer_percent);
 		if (ret)
 			goto out;
 


