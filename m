Return-Path: <stable+bounces-36612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ADF89C0A2
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B39D281A45
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBD07350E;
	Mon,  8 Apr 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vbf8Vtys"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD41471727;
	Mon,  8 Apr 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581835; cv=none; b=NNSyTEieH01BieOnyaYa/ycJOSQavdGUBN+N3Dt0k4cYnN90rKvlcbZGj8qixhn0/Qy/Txgumqd3HeXJ570GeKU3sEMyzBQAjO/IJd6zESC+rgvyms1/fNIr2AQbJ6Q5FpFOJq+Sxdup6/5cpfvYznVXqEWGNJ2dm2292SueFF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581835; c=relaxed/simple;
	bh=rCcnSoFOrdh3Gx8sgV52+rGPSE4nyXDxfNRb4Mh087A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TE3xyH5Eqgej8gtiVPvu35lSKAqh2U4yMM6qZE6tZASWSKo9VQWgjG0NviXL56HHdlSzEmLo69Y4Z2l1dCxsD/T5Y7xLzcfhvNPusxU9N2ekXw9ybC8jUWS2PQBsaILi0J8cb9Tk7nJD2YFakLmd0Z+SWtoxAmi1f8IsZQ6F66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vbf8Vtys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5550C43394;
	Mon,  8 Apr 2024 13:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581835;
	bh=rCcnSoFOrdh3Gx8sgV52+rGPSE4nyXDxfNRb4Mh087A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vbf8Vtys1iSQoRIYQH8hTyfiR/bWzd4E9QLwy/hR/QGsPOnZH7M8xcKdrH47a3F63
	 j2XoQ68taVpcan3igAr1lKXfVqewpkC7g5PW+2R6s3wZjvJTdAxbmt0EpzNK8IBJFy
	 t3OC9Eu0JZ3NbnRMaBl3BjDDX8yZyQ4hkp8z9dxk=
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
Subject: [PATCH 5.15 086/690] ring-buffer: Fix waking up ring buffer readers
Date: Mon,  8 Apr 2024 14:49:12 +0200
Message-ID: <20240408125402.605400638@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

[ Upstream commit b3594573681b53316ec0365332681a30463edfd6 ]

A task can wait on a ring buffer for when it fills up to a specific
watermark. The writer will check the minimum watermark that waiters are
waiting for and if the ring buffer is past that, it will wake up all the
waiters.

The waiters are in a wait loop, and will first check if a signal is
pending and then check if the ring buffer is at the desired level where it
should break out of the loop.

If a file that uses a ring buffer closes, and there's threads waiting on
the ring buffer, it needs to wake up those threads. To do this, a
"wait_index" was used.

Before entering the wait loop, the waiter will read the wait_index. On
wakeup, it will check if the wait_index is different than when it entered
the loop, and will exit the loop if it is. The waker will only need to
update the wait_index before waking up the waiters.

This had a couple of bugs. One trivial one and one broken by design.

The trivial bug was that the waiter checked the wait_index after the
schedule() call. It had to be checked between the prepare_to_wait() and
the schedule() which it was not.

The main bug is that the first check to set the default wait_index will
always be outside the prepare_to_wait() and the schedule(). That's because
the ring_buffer_wait() doesn't have enough context to know if it should
break out of the loop.

The loop itself is not needed, because all the callers to the
ring_buffer_wait() also has their own loop, as the callers have a better
sense of what the context is to decide whether to break out of the loop
or not.

Just have the ring_buffer_wait() block once, and if it gets woken up, exit
the function and let the callers decide what to do next.

Link: https://lore.kernel.org/all/CAHk-=whs5MdtNjzFkTyaUy=vHi=qwWgPi0JgTe6OYUYMNSRZfg@mail.gmail.com/
Link: https://lore.kernel.org/linux-trace-kernel/20240308202431.792933613@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linke li <lilinke99@qq.com>
Cc: Rabin Vincent <rabin@rab.in>
Fixes: e30f53aad2202 ("tracing: Do not busy wait in buffer splice")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: 761d9473e27f ("ring-buffer: Do not set shortest_full when full target is hit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 139 ++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 71 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index d9bed77f96c1f..15067de333497 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -406,7 +406,6 @@ struct rb_irq_work {
 	struct irq_work			work;
 	wait_queue_head_t		waiters;
 	wait_queue_head_t		full_waiters;
-	long				wait_index;
 	bool				waiters_pending;
 	bool				full_waiters_pending;
 	bool				wakeup_full;
@@ -915,14 +914,40 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 		rbwork = &cpu_buffer->irq_work;
 	}
 
-	rbwork->wait_index++;
-	/* make sure the waiters see the new index */
-	smp_wmb();
-
 	/* This can be called in any context */
 	irq_work_queue(&rbwork->work);
 }
 
+static bool rb_watermark_hit(struct trace_buffer *buffer, int cpu, int full)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	bool ret = false;
+
+	/* Reads of all CPUs always waits for any data */
+	if (cpu == RING_BUFFER_ALL_CPUS)
+		return !ring_buffer_empty(buffer);
+
+	cpu_buffer = buffer->buffers[cpu];
+
+	if (!ring_buffer_empty_cpu(buffer, cpu)) {
+		unsigned long flags;
+		bool pagebusy;
+
+		if (!full)
+			return true;
+
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+		pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
+		ret = !pagebusy && full_hit(buffer, cpu, full);
+
+		if (!cpu_buffer->shortest_full ||
+		    cpu_buffer->shortest_full > full)
+			cpu_buffer->shortest_full = full;
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+	}
+	return ret;
+}
+
 /**
  * ring_buffer_wait - wait for input to the ring buffer
  * @buffer: buffer to wait on
@@ -938,7 +963,6 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	DEFINE_WAIT(wait);
 	struct rb_irq_work *work;
-	long wait_index;
 	int ret = 0;
 
 	/*
@@ -957,81 +981,54 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 		work = &cpu_buffer->irq_work;
 	}
 
-	wait_index = READ_ONCE(work->wait_index);
-
-	while (true) {
-		if (full)
-			prepare_to_wait(&work->full_waiters, &wait, TASK_INTERRUPTIBLE);
-		else
-			prepare_to_wait(&work->waiters, &wait, TASK_INTERRUPTIBLE);
-
-		/*
-		 * The events can happen in critical sections where
-		 * checking a work queue can cause deadlocks.
-		 * After adding a task to the queue, this flag is set
-		 * only to notify events to try to wake up the queue
-		 * using irq_work.
-		 *
-		 * We don't clear it even if the buffer is no longer
-		 * empty. The flag only causes the next event to run
-		 * irq_work to do the work queue wake up. The worse
-		 * that can happen if we race with !trace_empty() is that
-		 * an event will cause an irq_work to try to wake up
-		 * an empty queue.
-		 *
-		 * There's no reason to protect this flag either, as
-		 * the work queue and irq_work logic will do the necessary
-		 * synchronization for the wake ups. The only thing
-		 * that is necessary is that the wake up happens after
-		 * a task has been queued. It's OK for spurious wake ups.
-		 */
-		if (full)
-			work->full_waiters_pending = true;
-		else
-			work->waiters_pending = true;
-
-		if (signal_pending(current)) {
-			ret = -EINTR;
-			break;
-		}
-
-		if (cpu == RING_BUFFER_ALL_CPUS && !ring_buffer_empty(buffer))
-			break;
-
-		if (cpu != RING_BUFFER_ALL_CPUS &&
-		    !ring_buffer_empty_cpu(buffer, cpu)) {
-			unsigned long flags;
-			bool pagebusy;
-			bool done;
-
-			if (!full)
-				break;
-
-			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-			pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
-			done = !pagebusy && full_hit(buffer, cpu, full);
+	if (full)
+		prepare_to_wait(&work->full_waiters, &wait, TASK_INTERRUPTIBLE);
+	else
+		prepare_to_wait(&work->waiters, &wait, TASK_INTERRUPTIBLE);
 
-			if (!cpu_buffer->shortest_full ||
-			    cpu_buffer->shortest_full > full)
-				cpu_buffer->shortest_full = full;
-			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-			if (done)
-				break;
-		}
+	/*
+	 * The events can happen in critical sections where
+	 * checking a work queue can cause deadlocks.
+	 * After adding a task to the queue, this flag is set
+	 * only to notify events to try to wake up the queue
+	 * using irq_work.
+	 *
+	 * We don't clear it even if the buffer is no longer
+	 * empty. The flag only causes the next event to run
+	 * irq_work to do the work queue wake up. The worse
+	 * that can happen if we race with !trace_empty() is that
+	 * an event will cause an irq_work to try to wake up
+	 * an empty queue.
+	 *
+	 * There's no reason to protect this flag either, as
+	 * the work queue and irq_work logic will do the necessary
+	 * synchronization for the wake ups. The only thing
+	 * that is necessary is that the wake up happens after
+	 * a task has been queued. It's OK for spurious wake ups.
+	 */
+	if (full)
+		work->full_waiters_pending = true;
+	else
+		work->waiters_pending = true;
 
-		schedule();
+	if (rb_watermark_hit(buffer, cpu, full))
+		goto out;
 
-		/* Make sure to see the new wait index */
-		smp_rmb();
-		if (wait_index != work->wait_index)
-			break;
+	if (signal_pending(current)) {
+		ret = -EINTR;
+		goto out;
 	}
 
+	schedule();
+ out:
 	if (full)
 		finish_wait(&work->full_waiters, &wait);
 	else
 		finish_wait(&work->waiters, &wait);
 
+	if (!ret && !rb_watermark_hit(buffer, cpu, full) && signal_pending(current))
+		ret = -EINTR;
+
 	return ret;
 }
 
-- 
2.43.0




