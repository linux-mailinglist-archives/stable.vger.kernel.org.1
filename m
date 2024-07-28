Return-Path: <stable+bounces-61985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D75593E1AD
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 02:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D366AB21604
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 00:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99D220ED;
	Sun, 28 Jul 2024 00:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf8GTKLG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E8B1EB2A;
	Sun, 28 Jul 2024 00:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127671; cv=none; b=r/DDi0gWzk5ObqgoPrLMpgIIGSTMxg1Th4YH5tbgsaZQAQv7ksx7+OwTEA2H85JDMoGMOcXIbTIJX0uI9Ao1YpeML4qTaA8Dn7ncCkJWka62IlkzytkhFkS4m5J+uGLafwn1Ds/3L9qs6HBWIkkQHPd8etELSSt/8aOt5UPcHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127671; c=relaxed/simple;
	bh=2/8PERBmInLBugE1Jf8UdzfJ7qpT5FeuBgq5xNY2UpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evvfW41FaxzL7vobXR0R1JdKBxmtW2RVPk7epQMn3JRbtgH+QWLApKCFIvdbwhiBIrKSUelTQ/0Bjn3UIJ/ZmKcVtSda8KlZbZcy0R27kQ6FLLqUP48JGhQDODzXCSLrQ4WFImGtLIpbNPVL/J2CiE0Xa4VA/9C7bkNbLN9ACZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf8GTKLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69072C4AF07;
	Sun, 28 Jul 2024 00:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127671;
	bh=2/8PERBmInLBugE1Jf8UdzfJ7qpT5FeuBgq5xNY2UpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nf8GTKLG9y4LgRRBVEDc5MSYTSLF5moPyR9DLkFH/3TuL+oQk/17JTELfKZa5xRYg
	 bx1x0/vzBY4cvN7cVn6KB887JBcI02/lOpU0VkUZUiO1Ns1S5j0hBl2yRtf+CiWjpW
	 ldAGpel6TfBwofsic8l/IqG6yLde/gTLji+o5sDd1rRKP/4Tx3zUDOAJGsfkQE8GU1
	 ZnAn17WCqh95ZkFU6FSSA3Ce2W2cxmw201QLFUpGZivp5IXfOyzLT0pIxEof+5wTTv
	 itGEEpm971Njg2YM/bcVx95Yk5nbuizpsf/3GMLXQ4CKjfssrcF6GF7HO0ehVRcIYI
	 bCCOGKon1Q3tQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	akpm@linux-foundation.org,
	j.granados@samsung.com,
	cyphar@cyphar.com,
	rongtao@cestc.cn,
	willy@infradead.org,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 05/16] Revert "rcu-tasks: Fix synchronize_rcu_tasks() VS zap_pid_ns_processes()"
Date: Sat, 27 Jul 2024 20:47:22 -0400
Message-ID: <20240728004739.1698541-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004739.1698541-1-sashal@kernel.org>
References: <20240728004739.1698541-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit 9855c37edf0009cc276cecfee09f7e76e2380212 ]

This reverts commit 28319d6dc5e2ffefa452c2377dd0f71621b5bff0. The race
it fixed was subject to conditions that don't exist anymore since:

	1612160b9127 ("rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks")

This latter commit removes the use of SRCU that used to cover the
RCU-tasks blind spot on exit between the tasklist's removal and the
final preemption disabling. The task is now placed instead into a
temporary list inside which voluntary sleeps are accounted as RCU-tasks
quiescent states. This would disarm the deadlock initially reported
against PID namespace exit.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/rcupdate.h |  2 --
 kernel/pid_namespace.c   | 17 -----------------
 kernel/rcu/tasks.h       | 16 +++-------------
 3 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index dfd2399f2cde0..61cb3de236af1 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -209,7 +209,6 @@ void synchronize_rcu_tasks_rude(void);
 
 #define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t, false)
 void exit_tasks_rcu_start(void);
-void exit_tasks_rcu_stop(void);
 void exit_tasks_rcu_finish(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 #define rcu_tasks_classic_qs(t, preempt) do { } while (0)
@@ -218,7 +217,6 @@ void exit_tasks_rcu_finish(void);
 #define call_rcu_tasks call_rcu
 #define synchronize_rcu_tasks synchronize_rcu
 static inline void exit_tasks_rcu_start(void) { }
-static inline void exit_tasks_rcu_stop(void) { }
 static inline void exit_tasks_rcu_finish(void) { }
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 25f3cf679b358..bdf0087d64423 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -249,24 +249,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (pid_ns->pid_allocated == init_pids)
 			break;
-		/*
-		 * Release tasks_rcu_exit_srcu to avoid following deadlock:
-		 *
-		 * 1) TASK A unshare(CLONE_NEWPID)
-		 * 2) TASK A fork() twice -> TASK B (child reaper for new ns)
-		 *    and TASK C
-		 * 3) TASK B exits, kills TASK C, waits for TASK A to reap it
-		 * 4) TASK A calls synchronize_rcu_tasks()
-		 *                   -> synchronize_srcu(tasks_rcu_exit_srcu)
-		 * 5) *DEADLOCK*
-		 *
-		 * It is considered safe to release tasks_rcu_exit_srcu here
-		 * because we assume the current task can not be concurrently
-		 * reaped at this point.
-		 */
-		exit_tasks_rcu_stop();
 		schedule();
-		exit_tasks_rcu_start();
 	}
 	__set_current_state(TASK_RUNNING);
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e1bf33018e6d5..4dc56b6e27c04 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -858,7 +858,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 //	not know to synchronize with this RCU Tasks grace period) have
 //	completed exiting.  The synchronize_rcu() in rcu_tasks_postgp()
 //	will take care of any tasks stuck in the non-preemptible region
-//	of do_exit() following its call to exit_tasks_rcu_stop().
+//	of do_exit() following its call to exit_tasks_rcu_finish().
 // check_all_holdout_tasks(), repeatedly until holdout list is empty:
 //	Scans the holdout list, attempting to identify a quiescent state
 //	for each task on the list.  If there is a quiescent state, the
@@ -1220,7 +1220,7 @@ void exit_tasks_rcu_start(void)
  * Remove the task from the "yet another list" because do_exit() is now
  * non-preemptible, allowing synchronize_rcu() to wait beyond this point.
  */
-void exit_tasks_rcu_stop(void)
+void exit_tasks_rcu_finish(void)
 {
 	unsigned long flags;
 	struct rcu_tasks_percpu *rtpcp;
@@ -1231,22 +1231,12 @@ void exit_tasks_rcu_stop(void)
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 	list_del_init(&t->rcu_tasks_exit_list);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
-}
 
-/*
- * Contribute to protect against tasklist scan blind spot while the
- * task is exiting and may be removed from the tasklist. See
- * corresponding synchronize_srcu() for further details.
- */
-void exit_tasks_rcu_finish(void)
-{
-	exit_tasks_rcu_stop();
-	exit_tasks_rcu_finish_trace(current);
+	exit_tasks_rcu_finish_trace(t);
 }
 
 #else /* #ifdef CONFIG_TASKS_RCU */
 void exit_tasks_rcu_start(void) { }
-void exit_tasks_rcu_stop(void) { }
 void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
 #endif /* #else #ifdef CONFIG_TASKS_RCU */
 
-- 
2.43.0


