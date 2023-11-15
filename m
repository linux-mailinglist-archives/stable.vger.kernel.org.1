Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35AF7ED01E
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbjKOTw4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbjKOTwz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:52:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5745812C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:52:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF89AC433C8;
        Wed, 15 Nov 2023 19:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077972;
        bh=kRiwSO2or1SHqhDQgcuIZG8K7RLtSHpmK9ULnCs3jnc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7TbzD5aUxUuzWfAEmyTZDe44aS+V/Kg6O9VqlYY99O+0Oi0QFYRLg47KEZAU/0LM
         Ay0w1iibqCPROb2oNFJhqtzuB51pYAIHOmOSU/C/zVXiLs0atDgZTTS6ZCMWzEBBz6
         CgRm46W6LfYOeE6RS4G0S4pZJByu8Q0LZCQtf1mk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Kuyo=20Chang=20 ?= <Kuyo.Chang@mediatek.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 007/379] sched: Fix stop_one_cpu_nowait() vs hotplug
Date:   Wed, 15 Nov 2023 14:21:22 -0500
Message-ID: <20231115192645.576433491@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit f0498d2a54e7966ce23cd7c7ff42c64fa0059b07 ]

Kuyo reported sporadic failures on a sched_setaffinity() vs CPU
hotplug stress-test -- notably affine_move_task() remains stuck in
wait_for_completion(), leading to a hung-task detector warning.

Specifically, it was reported that stop_one_cpu_nowait(.fn =
migration_cpu_stop) returns false -- this stopper is responsible for
the matching complete().

The race scenario is:

	CPU0					CPU1

					// doing _cpu_down()

  __set_cpus_allowed_ptr()
    task_rq_lock();
					takedown_cpu()
					  stop_machine_cpuslocked(take_cpu_down..)

					<PREEMPT: cpu_stopper_thread()
					  MULTI_STOP_PREPARE
					  ...
    __set_cpus_allowed_ptr_locked()
      affine_move_task()
        task_rq_unlock();

  <PREEMPT: cpu_stopper_thread()\>
    ack_state()
					  MULTI_STOP_RUN
					    take_cpu_down()
					      __cpu_disable();
					      stop_machine_park();
						stopper->enabled = false;
					 />
   />
	stop_one_cpu_nowait(.fn = migration_cpu_stop);
          if (stopper->enabled) // false!!!

That is, by doing stop_one_cpu_nowait() after dropping rq-lock, the
stopper thread gets a chance to preempt and allows the cpu-down for
the target CPU to complete.

OTOH, since stop_one_cpu_nowait() / cpu_stop_queue_work() needs to
issue a wakeup, it must not be ran under the scheduler locks.

Solve this apparent contradiction by keeping preemption disabled over
the unlock + queue_stopper combination:

	preempt_disable();
	task_rq_unlock(...);
	if (!stop_pending)
	  stop_one_cpu_nowait(...)
	preempt_enable();

This respects the lock ordering contraints while still avoiding the
above race. That is, if we find the CPU is online under rq-lock, the
targeted stop_one_cpu_nowait() must succeed.

Apply this pattern to all similar stop_one_cpu_nowait() invocations.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Reported-by: "Kuyo Chang (張建文)" <Kuyo.Chang@mediatek.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: "Kuyo Chang (張建文)" <Kuyo.Chang@mediatek.com>
Link: https://lkml.kernel.org/r/20231010200442.GA16515@noisy.programming.kicks-ass.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c     | 10 ++++++++--
 kernel/sched/deadline.c |  2 ++
 kernel/sched/fair.c     |  4 +++-
 kernel/sched/rt.c       |  4 ++++
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 55d13980e29fd..18a4f8f28a25f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2463,9 +2463,11 @@ static int migration_cpu_stop(void *data)
 		 * it.
 		 */
 		WARN_ON_ONCE(!pending->stop_pending);
+		preempt_disable();
 		task_rq_unlock(rq, p, &rf);
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
+		preempt_enable();
 		return 0;
 	}
 out:
@@ -2746,12 +2748,13 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			complete = true;
 		}
 
+		preempt_disable();
 		task_rq_unlock(rq, p, rf);
-
 		if (push_task) {
 			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
 					    p, &rq->push_work);
 		}
+		preempt_enable();
 
 		if (complete)
 			complete_all(&pending->done);
@@ -2817,12 +2820,13 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		if (flags & SCA_MIGRATE_ENABLE)
 			p->migration_flags &= ~MDF_PUSH;
 
+		preempt_disable();
 		task_rq_unlock(rq, p, rf);
-
 		if (!stop_pending) {
 			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
 					    &pending->arg, &pending->stop_work);
 		}
+		preempt_enable();
 
 		if (flags & SCA_MIGRATE_ENABLE)
 			return 0;
@@ -9255,9 +9259,11 @@ static void balance_push(struct rq *rq)
 	 * Temporarily drop rq->lock such that we can wake-up the stop task.
 	 * Both preemption and IRQs are still disabled.
 	 */
+	preempt_disable();
 	raw_spin_rq_unlock(rq);
 	stop_one_cpu_nowait(rq->cpu, __balance_push_cpu_stop, push_task,
 			    this_cpu_ptr(&push_work));
+	preempt_enable();
 	/*
 	 * At this point need_resched() is true and we'll take the loop in
 	 * schedule(). The next pick is obviously going to be the stop task
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9ce9810861ba5..389290e950bea 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2460,9 +2460,11 @@ static void pull_dl_task(struct rq *this_rq)
 		double_unlock_balance(this_rq, src_rq);
 
 		if (push_task) {
+			preempt_disable();
 			raw_spin_rq_unlock(this_rq);
 			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
 					    push_task, &src_rq->push_work);
+			preempt_enable();
 			raw_spin_rq_lock(this_rq);
 		}
 	}
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7ae0ba3fd0bc..2558ab9033bee 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10713,13 +10713,15 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 				busiest->push_cpu = this_cpu;
 				active_balance = 1;
 			}
-			raw_spin_rq_unlock_irqrestore(busiest, flags);
 
+			preempt_disable();
+			raw_spin_rq_unlock_irqrestore(busiest, flags);
 			if (active_balance) {
 				stop_one_cpu_nowait(cpu_of(busiest),
 					active_load_balance_cpu_stop, busiest,
 					&busiest->active_balance_work);
 			}
+			preempt_enable();
 		}
 	} else {
 		sd->nr_balance_failed = 0;
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 576eb2f51f043..76bafa8d331a7 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2109,9 +2109,11 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 */
 		push_task = get_push_task(rq);
 		if (push_task) {
+			preempt_disable();
 			raw_spin_rq_unlock(rq);
 			stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
 					    push_task, &rq->push_work);
+			preempt_enable();
 			raw_spin_rq_lock(rq);
 		}
 
@@ -2448,9 +2450,11 @@ static void pull_rt_task(struct rq *this_rq)
 		double_unlock_balance(this_rq, src_rq);
 
 		if (push_task) {
+			preempt_disable();
 			raw_spin_rq_unlock(this_rq);
 			stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
 					    push_task, &src_rq->push_work);
+			preempt_enable();
 			raw_spin_rq_lock(this_rq);
 		}
 	}
-- 
2.42.0



