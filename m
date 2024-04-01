Return-Path: <stable+bounces-34508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AE1893FA2
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29721F214B0
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E66B47A62;
	Mon,  1 Apr 2024 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gc4/FTK3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9D3446AC;
	Mon,  1 Apr 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988357; cv=none; b=gw/ocBLKiEp0Q0erEIeGXANIufnn2VofwX7wp2wCE4uJQiao2HTzGBjY0pUObcxLL6Xb8x4vqTIjlX6D0jO0u+uJUQzTVOIEHQMu5oGqIjb0YL54sHUmdDs5xZpLL7sGA943CBS84elAPtWKotI7CAL59z3x9VvlWOhN2bgdmv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988357; c=relaxed/simple;
	bh=FfLJF14BKH7Ee1g7ksOI34RPx3fanjg0j8OeFwX7Mdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBbNZc7pSnlCbqZRHk3yyY2vTipkVO5vBEPUoA1Kt2a0b0FUB/4VdkPFNSlnWlP1TYDEoqhoaWBdkvcaDqFphxkjz2Y0qmE6JBIFOr1yEwBktZ62aYl4LLhYJNrmXTECfp4lLKmDTnvDydUof2/vVdriI0mqL87ZFAD/jBz/D8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gc4/FTK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6A1C433F1;
	Mon,  1 Apr 2024 16:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988356;
	bh=FfLJF14BKH7Ee1g7ksOI34RPx3fanjg0j8OeFwX7Mdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gc4/FTK3XYPIIFjD8F+M+NzWHLSU6NGS9nE7Z54DzI2q02t1wTfY8Xwkr3gVBDFuA
	 pbXltriz+FXxH1ZelCMJDJUv4/xkSjUjK5QXaV3e2KwLSEwb52cGNE0FsR5fim0y64
	 3q3wVTxbygYlEukqJrqrIK2zev88wuRJ9TawUFGQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linke li <lilinke99@qq.com>,
	Rabin Vincent <rabin@rab.in>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 160/432] ring-buffer: Use wait_event_interruptible() in ring_buffer_wait()
Date: Mon,  1 Apr 2024 17:42:27 +0200
Message-ID: <20240401152557.911369328@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (Google) <rostedt@goodmis.org>

[ Upstream commit 7af9ded0c2caac0a95f33df5cb04706b0f502588 ]

Convert ring_buffer_wait() over to wait_event_interruptible(). The default
condition is to execute the wait loop inside __wait_event() just once.

This does not change the ring_buffer_wait() prototype yet, but
restructures the code so that it can take a "cond" and "data" parameter
and will call wait_event_interruptible() with a helper function as the
condition.

The helper function (rb_wait_cond) takes the cond function and data
parameters. It will first check if the buffer hit the watermark defined by
the "full" parameter and then call the passed in condition parameter. If
either are true, it returns true.

If rb_wait_cond() does not return true, it will set the appropriate
"waiters_pending" flag and returns false.

Link: https://lore.kernel.org/linux-trace-kernel/CAHk-=wgsNgewHFxZAJiAQznwPMqEtQmi1waeS2O1v6L4c_Um5A@mail.gmail.com/
Link: https://lore.kernel.org/linux-trace-kernel/20240312121703.399598519@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linke li <lilinke99@qq.com>
Cc: Rabin Vincent <rabin@rab.in>
Fixes: f3ddb74ad0790 ("tracing: Wake up ring buffer waiters on closing of the file")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ring_buffer.h |   1 +
 kernel/trace/ring_buffer.c  | 116 +++++++++++++++++++++---------------
 2 files changed, 69 insertions(+), 48 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 782e14f62201f..ded528d23f855 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -98,6 +98,7 @@ __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *k
 	__ring_buffer_alloc((size), (flags), &__key);	\
 })
 
+typedef bool (*ring_buffer_cond_fn)(void *data);
 int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full);
 __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 			  struct file *filp, poll_table *poll_table, int full);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index df4fe1447e5f2..140f8eed83da6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -990,43 +990,15 @@ static bool rb_watermark_hit(struct trace_buffer *buffer, int cpu, int full)
 	return ret;
 }
 
-/**
- * ring_buffer_wait - wait for input to the ring buffer
- * @buffer: buffer to wait on
- * @cpu: the cpu buffer to wait on
- * @full: wait until the percentage of pages are available, if @cpu != RING_BUFFER_ALL_CPUS
- *
- * If @cpu == RING_BUFFER_ALL_CPUS then the task will wake up as soon
- * as data is added to any of the @buffer's cpu buffers. Otherwise
- * it will wait for data to be added to a specific cpu buffer.
- */
-int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
+static inline bool
+rb_wait_cond(struct rb_irq_work *rbwork, struct trace_buffer *buffer,
+	     int cpu, int full, ring_buffer_cond_fn cond, void *data)
 {
-	struct ring_buffer_per_cpu *cpu_buffer;
-	DEFINE_WAIT(wait);
-	struct rb_irq_work *work;
-	int ret = 0;
-
-	/*
-	 * Depending on what the caller is waiting for, either any
-	 * data in any cpu buffer, or a specific buffer, put the
-	 * caller on the appropriate wait queue.
-	 */
-	if (cpu == RING_BUFFER_ALL_CPUS) {
-		work = &buffer->irq_work;
-		/* Full only makes sense on per cpu reads */
-		full = 0;
-	} else {
-		if (!cpumask_test_cpu(cpu, buffer->cpumask))
-			return -ENODEV;
-		cpu_buffer = buffer->buffers[cpu];
-		work = &cpu_buffer->irq_work;
-	}
+	if (rb_watermark_hit(buffer, cpu, full))
+		return true;
 
-	if (full)
-		prepare_to_wait(&work->full_waiters, &wait, TASK_INTERRUPTIBLE);
-	else
-		prepare_to_wait(&work->waiters, &wait, TASK_INTERRUPTIBLE);
+	if (cond(data))
+		return true;
 
 	/*
 	 * The events can happen in critical sections where
@@ -1049,27 +1021,75 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 	 * a task has been queued. It's OK for spurious wake ups.
 	 */
 	if (full)
-		work->full_waiters_pending = true;
+		rbwork->full_waiters_pending = true;
 	else
-		work->waiters_pending = true;
+		rbwork->waiters_pending = true;
 
-	if (rb_watermark_hit(buffer, cpu, full))
-		goto out;
+	return false;
+}
 
-	if (signal_pending(current)) {
-		ret = -EINTR;
-		goto out;
+/*
+ * The default wait condition for ring_buffer_wait() is to just to exit the
+ * wait loop the first time it is woken up.
+ */
+static bool rb_wait_once(void *data)
+{
+	long *once = data;
+
+	/* wait_event() actually calls this twice before scheduling*/
+	if (*once > 1)
+		return true;
+
+	(*once)++;
+	return false;
+}
+
+/**
+ * ring_buffer_wait - wait for input to the ring buffer
+ * @buffer: buffer to wait on
+ * @cpu: the cpu buffer to wait on
+ * @full: wait until the percentage of pages are available, if @cpu != RING_BUFFER_ALL_CPUS
+ *
+ * If @cpu == RING_BUFFER_ALL_CPUS then the task will wake up as soon
+ * as data is added to any of the @buffer's cpu buffers. Otherwise
+ * it will wait for data to be added to a specific cpu buffer.
+ */
+int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	struct wait_queue_head *waitq;
+	ring_buffer_cond_fn cond;
+	struct rb_irq_work *rbwork;
+	void *data;
+	long once = 0;
+	int ret = 0;
+
+	cond = rb_wait_once;
+	data = &once;
+
+	/*
+	 * Depending on what the caller is waiting for, either any
+	 * data in any cpu buffer, or a specific buffer, put the
+	 * caller on the appropriate wait queue.
+	 */
+	if (cpu == RING_BUFFER_ALL_CPUS) {
+		rbwork = &buffer->irq_work;
+		/* Full only makes sense on per cpu reads */
+		full = 0;
+	} else {
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			return -ENODEV;
+		cpu_buffer = buffer->buffers[cpu];
+		rbwork = &cpu_buffer->irq_work;
 	}
 
-	schedule();
- out:
 	if (full)
-		finish_wait(&work->full_waiters, &wait);
+		waitq = &rbwork->full_waiters;
 	else
-		finish_wait(&work->waiters, &wait);
+		waitq = &rbwork->waiters;
 
-	if (!ret && !rb_watermark_hit(buffer, cpu, full) && signal_pending(current))
-		ret = -EINTR;
+	ret = wait_event_interruptible((*waitq),
+				rb_wait_cond(rbwork, buffer, cpu, full, cond, data));
 
 	return ret;
 }
-- 
2.43.0




