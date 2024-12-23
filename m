Return-Path: <stable+bounces-105678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0FD9FB133
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84AC1621FE
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F7B1AB6FF;
	Mon, 23 Dec 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nKjyt7iQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755052EAE6;
	Mon, 23 Dec 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734969762; cv=none; b=cQstYE3IugZd32G64Mt6rHGDnnw/V0qDb7z60NBmA/oS3IK2ETNM+KFvNH8ocNjeSqR+KZRCKlzJTnBu03zDNgN/eRpN1pfr7Uo4DQLoAph7boSGf0HQ4IOzEXmEGWqBUdVRave1dVB+SXhfQ+L1xT9VI2aB1g0qd0AseOSLa8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734969762; c=relaxed/simple;
	bh=avwGK4/lgkddbvJ2rtt84XOsn0fO7n5RbjdATedWXB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyYMbZvoNoDvVi/MDZBa+9btr6nMBlu+0KtFQL2ZbdtLTiyGe1plKgWWdjl2fb8hSVUkM3fB20lNjg19AnL5FMfcUnF9YxPUORPsmTX6eQaBrjznWOaYTjnvO5poxuKkVids8wD1J0c65Peh23kvMRCRq6BbvjlgA2XO7G9opHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nKjyt7iQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D86C4CED3;
	Mon, 23 Dec 2024 16:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734969762;
	bh=avwGK4/lgkddbvJ2rtt84XOsn0fO7n5RbjdATedWXB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nKjyt7iQFoIP876MzR7U0D45vqxAv5e4jn7iFyByXuuYxc7X31ZB84OD4REnryh5c
	 9RrD25mEkQneGsyzx44Vjj0rT+Z2iL0dS7E7UlRWDdj8aGv4Yj54MC3FyxMLLdOJPA
	 ojQVqypwBlbj9DJ3z4oGrO2beKBvnZbrv8hnkx9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Sasha Levin <sashal@kernel.org>,
	Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
Subject: [PATCH 6.12 016/160] sched/dlserver: Fix dlserver double enqueue
Date: Mon, 23 Dec 2024 16:57:07 +0100
Message-ID: <20241223155409.273389115@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
References: <20241223155408.598780301@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vineeth Pillai (Google) <vineeth@bitbyteword.org>

[ Upstream commit b53127db1dbf7f1047cf35c10922d801dcd40324 ]

dlserver can get dequeued during a dlserver pick_task due to the delayed
deueue feature and this can lead to issues with dlserver logic as it
still thinks that dlserver is on the runqueue. The dlserver throttling
and replenish logic gets confused and can lead to double enqueue of
dlserver.

Double enqueue of dlserver could happend due to couple of reasons:

Case 1
------

Delayed dequeue feature[1] can cause dlserver being stopped during a
pick initiated by dlserver:
  __pick_next_task
   pick_task_dl -> server_pick_task
    pick_task_fair
     pick_next_entity (if (sched_delayed))
      dequeue_entities
       dl_server_stop

server_pick_task goes ahead with update_curr_dl_se without knowing that
dlserver is dequeued and this confuses the logic and may lead to
unintended enqueue while the server is stopped.

Case 2
------
A race condition between a task dequeue on one cpu and same task's enqueue
on this cpu by a remote cpu while the lock is released causing dlserver
double enqueue.

One cpu would be in the schedule() and releasing RQ-lock:

current->state = TASK_INTERRUPTIBLE();
        schedule();
          deactivate_task()
            dl_stop_server();
          pick_next_task()
            pick_next_task_fair()
              sched_balance_newidle()
                rq_unlock(this_rq)

at which point another CPU can take our RQ-lock and do:

        try_to_wake_up()
          ttwu_queue()
            rq_lock()
            ...
            activate_task()
              dl_server_start() --> first enqueue
            wakeup_preempt() := check_preempt_wakeup_fair()
              update_curr()
                update_curr_task()
                  if (current->dl_server)
                    dl_server_update()
                      enqueue_dl_entity() --> second enqueue

This bug was not apparent as the enqueue in dl_server_start doesn't
usually happen because of the defer logic. But as a side effect of the
first case(dequeue during dlserver pick), dl_throttled and dl_yield will
be set and this causes the time accounting of dlserver to messup and
then leading to a enqueue in dl_server_start.

Have an explicit flag representing the status of dlserver to avoid the
confusion. This is set in dl_server_start and reset in dlserver_stop.

Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk> # ROCK 5B
Link: https://lkml.kernel.org/r/20241213032244.877029-1-vineeth@bitbyteword.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched.h   | 7 +++++++
 kernel/sched/deadline.c | 8 ++++++--
 kernel/sched/sched.h    | 5 +++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index bb343136ddd0..c14446c6164d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -656,6 +656,12 @@ struct sched_dl_entity {
 	 * @dl_defer_armed tells if the deferrable server is waiting
 	 * for the replenishment timer to activate it.
 	 *
+	 * @dl_server_active tells if the dlserver is active(started).
+	 * dlserver is started on first cfs enqueue on an idle runqueue
+	 * and is stopped when a dequeue results in 0 cfs tasks on the
+	 * runqueue. In other words, dlserver is active only when cpu's
+	 * runqueue has atleast one cfs task.
+	 *
 	 * @dl_defer_running tells if the deferrable server is actually
 	 * running, skipping the defer phase.
 	 */
@@ -664,6 +670,7 @@ struct sched_dl_entity {
 	unsigned int			dl_non_contending : 1;
 	unsigned int			dl_overrun	  : 1;
 	unsigned int			dl_server         : 1;
+	unsigned int			dl_server_active  : 1;
 	unsigned int			dl_defer	  : 1;
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fc6f41ac33eb..a17c23b53049 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1647,6 +1647,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (!dl_se->dl_runtime)
 		return;
 
+	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
 		resched_curr(dl_se->rq);
@@ -1661,6 +1662,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
 	dl_se->dl_throttled = 0;
+	dl_se->dl_server_active = 0;
 }
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
@@ -2420,8 +2422,10 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
 	if (dl_server(dl_se)) {
 		p = dl_se->server_pick_task(dl_se);
 		if (!p) {
-			dl_se->dl_yielded = 1;
-			update_curr_dl_se(rq, dl_se, 0);
+			if (dl_server_active(dl_se)) {
+				dl_se->dl_yielded = 1;
+				update_curr_dl_se(rq, dl_se, 0);
+			}
 			goto again;
 		}
 		rq->dl_server = dl_se;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c53696275ca1..f2ef520513c4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -398,6 +398,11 @@ extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
 
+static inline bool dl_server_active(struct sched_dl_entity *dl_se)
+{
+	return dl_se->dl_server_active;
+}
+
 #ifdef CONFIG_CGROUP_SCHED
 
 extern struct list_head task_groups;
-- 
2.39.5




