Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB29B6FA9DE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbjEHK4d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbjEHK4R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:56:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC1C2945E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 151DA62999
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09686C4339E;
        Mon,  8 May 2023 10:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543311;
        bh=j555t3IoEFG8QcHU5w8axL3QZd5Q7UUME20EroKCErw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nnDGHINLUXgSSIt2qhV8YMx1vnHJ++3jlOfg30BU27Ij8sDTRw8/f52pMvKa2y5wo
         iTh0wnd0UUXWfJZvPs/44cxVJqfqKYjDJmLpjhKowNKAY9Sp0B2ATz9Qd0Nt+Q6tKa
         ddhjsyaABp9D9ZtTPsSEmCH440abo0D0xRbVpSxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 6.3 019/694] posix-cpu-timers: Implement the missing timer_wait_running callback
Date:   Mon,  8 May 2023 11:37:34 +0200
Message-Id: <20230508094433.249353935@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit f7abf14f0001a5a47539d9f60bbdca649e43536b upstream.

For some unknown reason the introduction of the timer_wait_running callback
missed to fixup posix CPU timers, which went unnoticed for almost four years.
Marco reported recently that the WARN_ON() in timer_wait_running()
triggers with a posix CPU timer test case.

Posix CPU timers have two execution models for expiring timers depending on
CONFIG_POSIX_CPU_TIMERS_TASK_WORK:

1) If not enabled, the expiry happens in hard interrupt context so
   spin waiting on the remote CPU is reasonably time bound.

   Implement an empty stub function for that case.

2) If enabled, the expiry happens in task work before returning to user
   space or guest mode. The expired timers are marked as firing and moved
   from the timer queue to a local list head with sighand lock held. Once
   the timers are moved, sighand lock is dropped and the expiry happens in
   fully preemptible context. That means the expiring task can be scheduled
   out, migrated, interrupted etc. So spin waiting on it is more than
   suboptimal.

   The timer wheel has a timer_wait_running() mechanism for RT, which uses
   a per CPU timer-base expiry lock which is held by the expiry code and the
   task waiting for the timer function to complete blocks on that lock.

   This does not work in the same way for posix CPU timers as there is no
   timer base and expiry for process wide timers can run on any task
   belonging to that process, but the concept of waiting on an expiry lock
   can be used too in a slightly different way:

    - Add a mutex to struct posix_cputimers_work. This struct is per task
      and used to schedule the expiry task work from the timer interrupt.

    - Add a task_struct pointer to struct cpu_timer which is used to store
      a the task which runs the expiry. That's filled in when the task
      moves the expired timers to the local expiry list. That's not
      affecting the size of the k_itimer union as there are bigger union
      members already

    - Let the task take the expiry mutex around the expiry function

    - Let the waiter acquire a task reference with rcu_read_lock() held and
      block on the expiry mutex

   This avoids spin-waiting on a task which might not even be on a CPU and
   works nicely for RT too.

Fixes: ec8f954a40da ("posix-timers: Use a callback for cancel synchronization on PREEMPT_RT")
Reported-by: Marco Elver <elver@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Marco Elver <elver@google.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/87zg764ojw.ffs@tglx
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/posix-timers.h   |   17 +++++---
 kernel/time/posix-cpu-timers.c |   81 +++++++++++++++++++++++++++++++++--------
 kernel/time/posix-timers.c     |    4 ++
 3 files changed, 82 insertions(+), 20 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -4,6 +4,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/alarmtimer.h>
 #include <linux/timerqueue.h>
 
@@ -62,16 +63,18 @@ static inline int clockid_to_fd(const cl
  * cpu_timer - Posix CPU timer representation for k_itimer
  * @node:	timerqueue node to queue in the task/sig
  * @head:	timerqueue head on which this timer is queued
- * @task:	Pointer to target task
+ * @pid:	Pointer to target task PID
  * @elist:	List head for the expiry list
  * @firing:	Timer is currently firing
+ * @handling:	Pointer to the task which handles expiry
  */
 struct cpu_timer {
-	struct timerqueue_node	node;
-	struct timerqueue_head	*head;
-	struct pid		*pid;
-	struct list_head	elist;
-	int			firing;
+	struct timerqueue_node		node;
+	struct timerqueue_head		*head;
+	struct pid			*pid;
+	struct list_head		elist;
+	int				firing;
+	struct task_struct __rcu	*handling;
 };
 
 static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
@@ -135,10 +138,12 @@ struct posix_cputimers {
 /**
  * posix_cputimers_work - Container for task work based posix CPU timer expiry
  * @work:	The task work to be scheduled
+ * @mutex:	Mutex held around expiry in context of this task work
  * @scheduled:  @work has been scheduled already, no further processing
  */
 struct posix_cputimers_work {
 	struct callback_head	work;
+	struct mutex		mutex;
 	unsigned int		scheduled;
 };
 
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -846,6 +846,8 @@ static u64 collect_timerqueue(struct tim
 			return expires;
 
 		ctmr->firing = 1;
+		/* See posix_cpu_timer_wait_running() */
+		rcu_assign_pointer(ctmr->handling, current);
 		cpu_timer_dequeue(ctmr);
 		list_add_tail(&ctmr->elist, firing);
 	}
@@ -1161,7 +1163,49 @@ static void handle_posix_cpu_timers(stru
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
 static void posix_cpu_timers_work(struct callback_head *work)
 {
+	struct posix_cputimers_work *cw = container_of(work, typeof(*cw), work);
+
+	mutex_lock(&cw->mutex);
 	handle_posix_cpu_timers(current);
+	mutex_unlock(&cw->mutex);
+}
+
+/*
+ * Invoked from the posix-timer core when a cancel operation failed because
+ * the timer is marked firing. The caller holds rcu_read_lock(), which
+ * protects the timer and the task which is expiring it from being freed.
+ */
+static void posix_cpu_timer_wait_running(struct k_itimer *timr)
+{
+	struct task_struct *tsk = rcu_dereference(timr->it.cpu.handling);
+
+	/* Has the handling task completed expiry already? */
+	if (!tsk)
+		return;
+
+	/* Ensure that the task cannot go away */
+	get_task_struct(tsk);
+	/* Now drop the RCU protection so the mutex can be locked */
+	rcu_read_unlock();
+	/* Wait on the expiry mutex */
+	mutex_lock(&tsk->posix_cputimers_work.mutex);
+	/* Release it immediately again. */
+	mutex_unlock(&tsk->posix_cputimers_work.mutex);
+	/* Drop the task reference. */
+	put_task_struct(tsk);
+	/* Relock RCU so the callsite is balanced */
+	rcu_read_lock();
+}
+
+static void posix_cpu_timer_wait_running_nsleep(struct k_itimer *timr)
+{
+	/* Ensure that timr->it.cpu.handling task cannot go away */
+	rcu_read_lock();
+	spin_unlock_irq(&timr->it_lock);
+	posix_cpu_timer_wait_running(timr);
+	rcu_read_unlock();
+	/* @timr is on stack and is valid */
+	spin_lock_irq(&timr->it_lock);
 }
 
 /*
@@ -1177,6 +1221,7 @@ void clear_posix_cputimers_work(struct t
 	       sizeof(p->posix_cputimers_work.work));
 	init_task_work(&p->posix_cputimers_work.work,
 		       posix_cpu_timers_work);
+	mutex_init(&p->posix_cputimers_work.mutex);
 	p->posix_cputimers_work.scheduled = false;
 }
 
@@ -1255,6 +1300,18 @@ static inline void __run_posix_cpu_timer
 	lockdep_posixtimer_exit();
 }
 
+static void posix_cpu_timer_wait_running(struct k_itimer *timr)
+{
+	cpu_relax();
+}
+
+static void posix_cpu_timer_wait_running_nsleep(struct k_itimer *timr)
+{
+	spin_unlock_irq(&timr->it_lock);
+	cpu_relax();
+	spin_lock_irq(&timr->it_lock);
+}
+
 static inline bool posix_cpu_timers_work_scheduled(struct task_struct *tsk)
 {
 	return false;
@@ -1363,6 +1420,8 @@ static void handle_posix_cpu_timers(stru
 		 */
 		if (likely(cpu_firing >= 0))
 			cpu_timer_fire(timer);
+		/* See posix_cpu_timer_wait_running() */
+		rcu_assign_pointer(timer->it.cpu.handling, NULL);
 		spin_unlock(&timer->it_lock);
 	}
 }
@@ -1497,23 +1556,16 @@ static int do_cpu_nanosleep(const clocki
 		expires = cpu_timer_getexpires(&timer.it.cpu);
 		error = posix_cpu_timer_set(&timer, 0, &zero_it, &it);
 		if (!error) {
-			/*
-			 * Timer is now unarmed, deletion can not fail.
-			 */
+			/* Timer is now unarmed, deletion can not fail. */
 			posix_cpu_timer_del(&timer);
+		} else {
+			while (error == TIMER_RETRY) {
+				posix_cpu_timer_wait_running_nsleep(&timer);
+				error = posix_cpu_timer_del(&timer);
+			}
 		}
-		spin_unlock_irq(&timer.it_lock);
 
-		while (error == TIMER_RETRY) {
-			/*
-			 * We need to handle case when timer was or is in the
-			 * middle of firing. In other cases we already freed
-			 * resources.
-			 */
-			spin_lock_irq(&timer.it_lock);
-			error = posix_cpu_timer_del(&timer);
-			spin_unlock_irq(&timer.it_lock);
-		}
+		spin_unlock_irq(&timer.it_lock);
 
 		if ((it.it_value.tv_sec | it.it_value.tv_nsec) == 0) {
 			/*
@@ -1623,6 +1675,7 @@ const struct k_clock clock_posix_cpu = {
 	.timer_del		= posix_cpu_timer_del,
 	.timer_get		= posix_cpu_timer_get,
 	.timer_rearm		= posix_cpu_timer_rearm,
+	.timer_wait_running	= posix_cpu_timer_wait_running,
 };
 
 const struct k_clock clock_process = {
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -846,6 +846,10 @@ static struct k_itimer *timer_wait_runni
 	rcu_read_lock();
 	unlock_timer(timer, *flags);
 
+	/*
+	 * kc->timer_wait_running() might drop RCU lock. So @timer
+	 * cannot be touched anymore after the function returns!
+	 */
 	if (!WARN_ON_ONCE(!kc->timer_wait_running))
 		kc->timer_wait_running(timer);
 


