Return-Path: <stable+bounces-10109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CE382727F
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2385E1F23627
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C664C602;
	Mon,  8 Jan 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OhBpeof4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16644BAB1;
	Mon,  8 Jan 2024 15:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBA4C433C7;
	Mon,  8 Jan 2024 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726788;
	bh=e/LM1cstUvf8S6oVwqLUPbObN+w1M7cjKMFOOvfano8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OhBpeof42OCHcfJIIvSgmBO1W7fWuet7yaagFUvv0bBk78vnrWuCZl93etCn4+xSi
	 H7bKt0Re9JEfJ4rCHTOZ2LX0Pp3ntPm2LfUhhp6kPjQFK99kWvh/8S9HHT4t645CKN
	 nmDrcMWd1Igw/BVZUhg0gPXIC3FIBmazv5JDrpJs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>,
	Waiman Long <longman@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 078/124] rcu: Break rcu_node_0 --> &rq->__lock order
Date: Mon,  8 Jan 2024 16:08:24 +0100
Message-ID: <20240108150606.564549042@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 85d68222ddc5f4522e456d97d201166acb50f716 ]

Commit 851a723e45d1 ("sched: Always clear user_cpus_ptr in
do_set_cpus_allowed()") added a kfree() call to free any user
provided affinity mask, if present. It was changed later to use
kfree_rcu() in commit 9a5418bc48ba ("sched/core: Use kfree_rcu()
in do_set_cpus_allowed()") to avoid a circular locking dependency
problem.

It turns out that even kfree_rcu() isn't safe for avoiding
circular locking problem. As reported by kernel test robot,
the following circular locking dependency now exists:

  &rdp->nocb_lock --> rcu_node_0 --> &rq->__lock

Solve this by breaking the rcu_node_0 --> &rq->__lock chain by moving
the resched_cpu() out from under rcu_node lock.

[peterz: heavily borrowed from Waiman's Changelog]
[paulmck: applied Z qiang feedback]

Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/oe-lkp/202310302207.a25f1a30-oliver.sang@intel.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7b4517dc46579..92a090e161865 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -755,14 +755,19 @@ static int dyntick_save_progress_counter(struct rcu_data *rdp)
 }
 
 /*
- * Return true if the specified CPU has passed through a quiescent
- * state by virtue of being in or having passed through an dynticks
- * idle state since the last call to dyntick_save_progress_counter()
- * for this same CPU, or by virtue of having been offline.
+ * Returns positive if the specified CPU has passed through a quiescent state
+ * by virtue of being in or having passed through an dynticks idle state since
+ * the last call to dyntick_save_progress_counter() for this same CPU, or by
+ * virtue of having been offline.
+ *
+ * Returns negative if the specified CPU needs a force resched.
+ *
+ * Returns zero otherwise.
  */
 static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 {
 	unsigned long jtsq;
+	int ret = 0;
 	struct rcu_node *rnp = rdp->mynode;
 
 	/*
@@ -848,8 +853,8 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	    (time_after(jiffies, READ_ONCE(rdp->last_fqs_resched) + jtsq * 3) ||
 	     rcu_state.cbovld)) {
 		WRITE_ONCE(rdp->rcu_urgent_qs, true);
-		resched_cpu(rdp->cpu);
 		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
+		ret = -1;
 	}
 
 	/*
@@ -862,8 +867,8 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	if (time_after(jiffies, rcu_state.jiffies_resched)) {
 		if (time_after(jiffies,
 			       READ_ONCE(rdp->last_fqs_resched) + jtsq)) {
-			resched_cpu(rdp->cpu);
 			WRITE_ONCE(rdp->last_fqs_resched, jiffies);
+			ret = -1;
 		}
 		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
 		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
@@ -892,7 +897,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 /* Trace-event wrapper function for trace_rcu_future_grace_period.  */
@@ -2270,15 +2275,15 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 {
 	int cpu;
 	unsigned long flags;
-	unsigned long mask;
-	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 
 	rcu_state.cbovld = rcu_state.cbovldnext;
 	rcu_state.cbovldnext = false;
 	rcu_for_each_leaf_node(rnp) {
+		unsigned long mask = 0;
+		unsigned long rsmask = 0;
+
 		cond_resched_tasks_rcu_qs();
-		mask = 0;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rcu_state.cbovldnext |= !!rnp->cbovldmask;
 		if (rnp->qsmask == 0) {
@@ -2296,11 +2301,17 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 			continue;
 		}
 		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->qsmask) {
+			struct rcu_data *rdp;
+			int ret;
+
 			rdp = per_cpu_ptr(&rcu_data, cpu);
-			if (f(rdp)) {
+			ret = f(rdp);
+			if (ret > 0) {
 				mask |= rdp->grpmask;
 				rcu_disable_urgency_upon_qs(rdp);
 			}
+			if (ret < 0)
+				rsmask |= rdp->grpmask;
 		}
 		if (mask != 0) {
 			/* Idle/offline CPUs, report (releases rnp->lock). */
@@ -2309,6 +2320,9 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
 			/* Nothing to do here, so just drop the lock. */
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
+
+		for_each_leaf_node_cpu_mask(rnp, cpu, rsmask)
+			resched_cpu(cpu);
 	}
 }
 
-- 
2.43.0




