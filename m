Return-Path: <stable+bounces-9476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4163982328C
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6866F1C23C76
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54B11C2AE;
	Wed,  3 Jan 2024 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HYpOWeqe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B52E1C2A9;
	Wed,  3 Jan 2024 17:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7DDC433C8;
	Wed,  3 Jan 2024 17:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301711;
	bh=sxR+hrTncz+u0jui//l51VB3f2kD8Qr1yeXl+bqeiAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HYpOWeqe6JDV/IbRIQrxTI2vKzSTUA/BOp3MIdBdaKlqU/G7yki5RxRvtln5OW27T
	 KGsur9q3CPQvzHfw4My1DR4Bk+PJlvDjTQjMtUdY9nL+cLPtvrmcZwawONa+ogeUTJ
	 2HVb69n0vEsH+JcjJrT7g66P4KJhAsqjhenPax6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.15 88/95] tracing: Fix blocked reader of snapshot buffer
Date: Wed,  3 Jan 2024 17:55:36 +0100
Message-ID: <20240103164907.256578102@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164853.921194838@linuxfoundation.org>
References: <20240103164853.921194838@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit 39a7dc23a1ed0fe81141792a09449d124c5953bd upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/ring_buffer.c |    3 ++-
 kernel/trace/trace.c       |   20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -964,7 +964,8 @@ void ring_buffer_wake_waiters(struct tra
 	/* make sure the waiters see the new index */
 	smp_wmb();
 
-	rb_wake_up_waiters(&rbwork->work);
+	/* This can be called in any context */
+	irq_work_queue(&rbwork->work);
 }
 
 /**
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1837,6 +1837,9 @@ update_max_tr(struct trace_array *tr, st
 	__update_max_tr(tr, tsk, cpu);
 
 	arch_spin_unlock(&tr->max_lock);
+
+	/* Any waiters on the old snapshot buffer need to wake up */
+	ring_buffer_wake_waiters(tr->array_buffer.buffer, RING_BUFFER_ALL_CPUS);
 }
 
 /**
@@ -1888,12 +1891,23 @@ update_max_tr_single(struct trace_array
 
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
@@ -8383,7 +8397,7 @@ tracing_buffers_splice_read(struct file
 
 		wait_index = READ_ONCE(iter->wait_index);
 
-		ret = wait_on_pipe(iter, iter->tr->buffer_percent);
+		ret = wait_on_pipe(iter, iter->snapshot ? 0 : iter->tr->buffer_percent);
 		if (ret)
 			goto out;
 



