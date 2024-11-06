Return-Path: <stable+bounces-90174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4189BE709
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43FF1F28060
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F54A1DF252;
	Wed,  6 Nov 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JsL8AhMt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB7E1D5AD7;
	Wed,  6 Nov 2024 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894989; cv=none; b=NnHWWzaXKqKQxuK7Mu3zSIDvwkfEF2350I62sXeVtX19M8e7ZLwUn41pFFXr/kSX1q7zpNv9vgIs3Ob6yt4whtzCByyFaH56hYQ8L6traUMyRp83rbVc0s+xsjD0dsryjfOd25DHHeldtnooOMiHRFOTKmMM1jOa5cZYXr/R1dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894989; c=relaxed/simple;
	bh=dwFmrCO+UVk5mhEYzYcf06Ot9fQGoU0l3RpjjFhdPuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urm/YdMD2DKuBfUgtaa1BO4Dv5kpUFNf2VEnh9XVzIc2Oe7l0zq7TO/B4MkVBY9w8LPO3O/+II2eahBC8azNjZubp6/rHv7xgQrUWwRmeSGiMeUxjIKopG3OJG5D2QSVjrecVxFMib4otRxINIL97VhxTVMgbRS1xr3KZCUYQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JsL8AhMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3523FC4CECD;
	Wed,  6 Nov 2024 12:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730894988;
	bh=dwFmrCO+UVk5mhEYzYcf06Ot9fQGoU0l3RpjjFhdPuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JsL8AhMtvbGj2p7Xa45A9DsxfyN89XDsntpWDGOG+9X29LvU1YlLd7GKF0AUxH5ai
	 fV/FbGSvI6PU+MYUgKG3Mmx4hIsq2uCi0B3T9SLeFLUHdNk5HJjzRnS4zOpcowPJwm
	 UIKM894klE8cajtdR50wYniaYj27M22a/LDbtSN8=
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
Subject: [PATCH 4.19 068/350] kthread: add kthread_work tracepoints
Date: Wed,  6 Nov 2024 12:59:56 +0100
Message-ID: <20241106120322.577046508@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120320.865793091@linuxfoundation.org>
References: <20241106120320.865793091@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 9a4bdfadab077..a4eb7bc6fcf5b 100644
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
index 9750f4f7f9010..f69aa5da3b53e 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -696,8 +696,15 @@ int kthread_worker_fn(void *worker_ptr)
 	spin_unlock_irq(&worker->lock);
 
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
 
@@ -826,6 +833,8 @@ static void kthread_insert_work(struct kthread_worker *worker,
 {
 	kthread_insert_work_sanity_check(worker, work);
 
+	trace_sched_kthread_work_queue_work(worker, work);
+
 	list_add_tail(&work->node, pos);
 	work->worker = worker;
 	if (!worker->current_work && likely(worker->task))
-- 
2.43.0




