Return-Path: <stable+bounces-58734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6855992B89E
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCFF1C219F2
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB215F3EC;
	Tue,  9 Jul 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fZR6c/4+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/dYuES3"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7315A864;
	Tue,  9 Jul 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525323; cv=none; b=LCZGRI3f2B33gCYUzfIzd8OkVg1vPdDcNeV6XG8QBwJanFKQe0C8AdDl3ca0NdLaMl8PUZrdt8vTZTI4ckFsI54xgv/iBKq1EpUrE+pRkYwZ35FYZjQgKSd5IEsX8m1a9c1UMHMWn4Keg2LWgMETYJ8suM0wga5mGnm8bBd297Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525323; c=relaxed/simple;
	bh=PzUq5lvl+7HRtyyADq4BFGgcRTdmn3WSXgm0E+eoClg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A6vs1FUCSJqnWv5AFYcT3rccq6nJ/H7M9QR06oDDYkhaM2DfEEyU7LVdWyczqA53JqiXoAofjYRHezbxW0szq4lW95vkHqwg7ko2kl4apEzMjEMOoDK/VRdbuuII+DkvlWMVZaNaIwQxk77ANXnReapr0Xo5bwcxJcdklEmwN1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fZR6c/4+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y/dYuES3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Jul 2024 11:41:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720525320;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKV7RcTe7lqxV7OngjMDBTCl6JG2kKHfHqLO4PLON+o=;
	b=fZR6c/4+GQ1MjpvIUNIfG91YkNMVyjdM29sgFbe8rCGXqZYNBokBklfM5V6jJMrJ9nQjKE
	t9+j/KjRJR9drtn8v7dosLzvWHBfSjF6nrE7MzfNjnQtUG7RN9AZwNYnqyUH1yLMwnw//e
	F5Yc4RYIJZ1Ep08vRLVk/iUuNdYQPAizKxxn7g+XsHj8FcOJdJ/sxbw/oYn+DQtDw6mTtI
	VX/E2MAUGoqMEkgAdr8+wRNP3PaJ4gnMSx1nRARoT68qyZVOXbDllQnZ/85OFLFfYGgtVM
	FbO7KAz69IBaMwFlaug3CvMGDSgOIJHyTK/xfuHKrDS5H0gJGJxA9pG7qzF9NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720525320;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hKV7RcTe7lqxV7OngjMDBTCl6JG2kKHfHqLO4PLON+o=;
	b=Y/dYuES3HAweTbVfk53JqqclRi9846BXPMCj4aHnfVexYeHTAD2pp+2KjB/yvEZu+JIwxr
	txjKQj8CnQGLRmDA==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Fix event leak upon exec and file release
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240621091601.18227-5-frederic@kernel.org>
References: <20240621091601.18227-5-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172052531981.2215.9647149778299516501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3a5465418f5fd970e86a86c7f4075be262682840
Gitweb:        https://git.kernel.org/tip/3a5465418f5fd970e86a86c7f4075be262682840
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 21 Jun 2024 11:16:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Jul 2024 13:26:33 +02:00

perf: Fix event leak upon exec and file release

The perf pending task work is never waited upon the matching event
release. In the case of a child event, released via free_event()
directly, this can potentially result in a leaked event, such as in the
following scenario that doesn't even require a weak IRQ work
implementation to trigger:

schedule()
   prepare_task_switch()
=======> <NMI>
      perf_event_overflow()
         event->pending_sigtrap = ...
         irq_work_queue(&event->pending_irq)
<======= </NMI>
      perf_event_task_sched_out()
          event_sched_out()
              event->pending_sigtrap = 0;
              atomic_long_inc_not_zero(&event->refcount)
              task_work_add(&event->pending_task)
   finish_lock_switch()
=======> <IRQ>
   perf_pending_irq()
      //do nothing, rely on pending task work
<======= </IRQ>

begin_new_exec()
   perf_event_exit_task()
      perf_event_exit_event()
         // If is child event
         free_event()
            WARN(atomic_long_cmpxchg(&event->refcount, 1, 0) != 1)
            // event is leaked

Similar scenarios can also happen with perf_event_remove_on_exec() or
simply against concurrent perf_event_release().

Fix this with synchonizing against the possibly remaining pending task
work while freeing the event, just like is done with remaining pending
IRQ work. This means that the pending task callback neither need nor
should hold a reference to the event, preventing it from ever beeing
freed.

Fixes: 517e6a301f34 ("perf: Fix perf_pending_task() UaF")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240621091601.18227-5-frederic@kernel.org
---
 include/linux/perf_event.h |  1 +-
 kernel/events/core.c       | 38 +++++++++++++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a5304ae..393fb13 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -786,6 +786,7 @@ struct perf_event {
 	struct irq_work			pending_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
+	struct rcuwait			pending_work_wait;
 
 	atomic_t			event_limit;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 576400d..32c7996 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2288,7 +2288,6 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 		if (state != PERF_EVENT_STATE_OFF &&
 		    !event->pending_work &&
 		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
-			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
 			event->pending_work = 1;
 		} else {
 			local_dec(&event->ctx->nr_pending);
@@ -5203,9 +5202,35 @@ static bool exclusive_event_installable(struct perf_event *event,
 static void perf_addr_filters_splice(struct perf_event *event,
 				       struct list_head *head);
 
+static void perf_pending_task_sync(struct perf_event *event)
+{
+	struct callback_head *head = &event->pending_task;
+
+	if (!event->pending_work)
+		return;
+	/*
+	 * If the task is queued to the current task's queue, we
+	 * obviously can't wait for it to complete. Simply cancel it.
+	 */
+	if (task_work_cancel(current, head)) {
+		event->pending_work = 0;
+		local_dec(&event->ctx->nr_pending);
+		return;
+	}
+
+	/*
+	 * All accesses related to the event are within the same
+	 * non-preemptible section in perf_pending_task(). The RCU
+	 * grace period before the event is freed will make sure all
+	 * those accesses are complete by then.
+	 */
+	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
+}
+
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
+	perf_pending_task_sync(event);
 
 	unaccount_event(event);
 
@@ -6818,23 +6843,27 @@ static void perf_pending_task(struct callback_head *head)
 	int rctx;
 
 	/*
+	 * All accesses to the event must belong to the same implicit RCU read-side
+	 * critical section as the ->pending_work reset. See comment in
+	 * perf_pending_task_sync().
+	 */
+	preempt_disable_notrace();
+	/*
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
 	 */
-	preempt_disable_notrace();
 	rctx = perf_swevent_get_recursion_context();
 
 	if (event->pending_work) {
 		event->pending_work = 0;
 		perf_sigtrap(event);
 		local_dec(&event->ctx->nr_pending);
+		rcuwait_wake_up(&event->pending_work_wait);
 	}
 
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
 	preempt_enable_notrace();
-
-	put_event(event);
 }
 
 #ifdef CONFIG_GUEST_PERF_EVENTS
@@ -11948,6 +11977,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	init_waitqueue_head(&event->waitq);
 	init_irq_work(&event->pending_irq, perf_pending_irq);
 	init_task_work(&event->pending_task, perf_pending_task);
+	rcuwait_init(&event->pending_work_wait);
 
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);

