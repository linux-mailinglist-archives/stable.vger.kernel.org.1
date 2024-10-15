Return-Path: <stable+bounces-85963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DEF99EAFF
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F57E28575A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7503B1C07CF;
	Tue, 15 Oct 2024 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hq2mh5YZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323FE1C07C9;
	Tue, 15 Oct 2024 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728997304; cv=none; b=o8zlp2dRiUtX3djzteLqzCq6urwvw6bAQAtWruM2ifnb9w8zRVOT3CEHAa+JN2aJyU059qrErITA2TfCXXPAusAWfmBa0v7eAkFyjdEKWZOwio6rBhlJOc7A8FPycnZNW0m8aPMhwR1xC3volyHkv8oFSj8sadaknIJR5zdsjEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728997304; c=relaxed/simple;
	bh=FkpAt6oAPL/NwUUM+HCsZvZsjAsENpK6yJRLCb4T/dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEDwfQDb9V4saG3p6qk4X6IgqIZMh4sdbmytzvNZFC0T3vujZRYnCPi+HTfZkyqiBiajdUhRj6NivgqJO63RjpNRI0vrOQlyVwjO/HGn6EErTDyXZaaZSq15wpXJPUej/9hTos6HsyaISEyLDJRCjezHYDcg95iW14VNFQA1D/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hq2mh5YZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52004C4CECE;
	Tue, 15 Oct 2024 13:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728997304;
	bh=FkpAt6oAPL/NwUUM+HCsZvZsjAsENpK6yJRLCb4T/dQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hq2mh5YZnEQrLMeV+9ac8Al6IOTi6UQYz3qyREvA3M9YH9bJkJ9uF1mD51lSthC0e
	 52yMrHxJVDR40CyDs71ZYL4MDO5NQhAeYtaeNfDBwBp99Jxykkybv1Hv1u6zGmb6os
	 zC4ygLdKXnoDL1e7+nFtQ23LbO866PpYI0bhmEjc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rob Clark <robdclark@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vincent Donnefort <vincent.donnefort@arm.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Jens Axboe <axboe@kernel.dk>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ilias Stamatis <stamatis.iliass@gmail.com>,
	Liang Chen <cl@rock-chips.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	"J. Bruce Fields" <bfields@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 145/518] kthread: add kthread_work tracepoints
Date: Tue, 15 Oct 2024 14:40:49 +0200
Message-ID: <20241015123922.595985185@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Clark <robdclark@chromium.org>

[ Upstream commit f630c7c6f10546ebff15c3a856e7949feb7a2372 ]

While migrating some code from wq to kthread_worker, I found that I missed
the execute_start/end tracepoints.  So add similar tracepoints for
kthread_work.  And for completeness, queue_work tracepoint (although this
one differs slightly from the matching workqueue tracepoint).

Link: https://lkml.kernel.org/r/20201010180323.126634-1-robdclark@gmail.com
Signed-off-by: Rob Clark <robdclark@chromium.org>
Cc: Rob Clark <robdclark@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Phil Auld <pauld@redhat.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Vincent Donnefort <vincent.donnefort@arm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Ilias Stamatis <stamatis.iliass@gmail.com>
Cc: Liang Chen <cl@rock-chips.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: "J. Bruce Fields" <bfields@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: e16c7b07784f ("kthread: fix task state in kthread worker if being frozen")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/sched.h | 84 ++++++++++++++++++++++++++++++++++++
 kernel/kthread.c             |  9 ++++
 2 files changed, 93 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index c96a4337afe6c..5039af667645d 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -5,6 +5,7 @@
 #if !defined(_TRACE_SCHED_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_SCHED_H
 
+#include <linux/kthread.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/tracepoint.h>
 #include <linux/binfmts.h>
@@ -51,6 +52,89 @@ TRACE_EVENT(sched_kthread_stop_ret,
 	TP_printk("ret=%d", __entry->ret)
 );
 
+/**
+ * sched_kthread_work_queue_work - called when a work gets queued
+ * @worker:	pointer to the kthread_worker
+ * @work:	pointer to struct kthread_work
+ *
+ * This event occurs when a work is queued immediately or once a
+ * delayed work is actually queued (ie: once the delay has been
+ * reached).
+ */
+TRACE_EVENT(sched_kthread_work_queue_work,
+
+	TP_PROTO(struct kthread_worker *worker,
+		 struct kthread_work *work),
+
+	TP_ARGS(worker, work),
+
+	TP_STRUCT__entry(
+		__field( void *,	work	)
+		__field( void *,	function)
+		__field( void *,	worker)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+		__entry->function	= work->func;
+		__entry->worker		= worker;
+	),
+
+	TP_printk("work struct=%p function=%ps worker=%p",
+		  __entry->work, __entry->function, __entry->worker)
+);
+
+/**
+ * sched_kthread_work_execute_start - called immediately before the work callback
+ * @work:	pointer to struct kthread_work
+ *
+ * Allows to track kthread work execution.
+ */
+TRACE_EVENT(sched_kthread_work_execute_start,
+
+	TP_PROTO(struct kthread_work *work),
+
+	TP_ARGS(work),
+
+	TP_STRUCT__entry(
+		__field( void *,	work	)
+		__field( void *,	function)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+		__entry->function	= work->func;
+	),
+
+	TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
+);
+
+/**
+ * sched_kthread_work_execute_end - called immediately after the work callback
+ * @work:	pointer to struct work_struct
+ * @function:   pointer to worker function
+ *
+ * Allows to track workqueue execution.
+ */
+TRACE_EVENT(sched_kthread_work_execute_end,
+
+	TP_PROTO(struct kthread_work *work, kthread_work_func_t function),
+
+	TP_ARGS(work, function),
+
+	TP_STRUCT__entry(
+		__field( void *,	work	)
+		__field( void *,	function)
+	),
+
+	TP_fast_assign(
+		__entry->work		= work;
+		__entry->function	= function;
+	),
+
+	TP_printk("work struct %p: function %ps", __entry->work, __entry->function)
+);
+
 /*
  * Tracepoint for waking up a task:
  */
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 9d6cc9c15a55e..d0cb3e413eff5 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -765,8 +765,15 @@ int kthread_worker_fn(void *worker_ptr)
 	raw_spin_unlock_irq(&worker->lock);
 
 	if (work) {
+		kthread_work_func_t func = work->func;
 		__set_current_state(TASK_RUNNING);
+		trace_sched_kthread_work_execute_start(work);
 		work->func(work);
+		/*
+		 * Avoid dereferencing work after this point.  The trace
+		 * event only cares about the address.
+		 */
+		trace_sched_kthread_work_execute_end(work, func);
 	} else if (!freezing(current))
 		schedule();
 
@@ -895,6 +902,8 @@ static void kthread_insert_work(struct kthread_worker *worker,
 {
 	kthread_insert_work_sanity_check(worker, work);
 
+	trace_sched_kthread_work_queue_work(worker, work);
+
 	list_add_tail(&work->node, pos);
 	work->worker = worker;
 	if (!worker->current_work && likely(worker->task))
-- 
2.43.0




