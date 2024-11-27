Return-Path: <stable+bounces-95642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB24C9DAB8E
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 17:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A9B16508F
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BD0200B93;
	Wed, 27 Nov 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRQaWN0D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB5200B84
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724117; cv=none; b=tLkclBjKO6+wGB/99lp7gTzlPO066sE4y+lZ4XYqpuxfKYFUg70O/mOAgQpjW7WO8UJXj9tPEqLhx6W4rLdqw4PH5EODPjYJDops29tkm2Aq//ZzSOJXu6fMJc8Z1OvniB7APIATXhX2a5B6juVTe+WEeT4CrIo0Sv5hQp3jRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724117; c=relaxed/simple;
	bh=yBGEcoVCTKxTtH7DTI85SQ7vcP8O3tXA5FLznuYj7sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rP9X3ahomIkWnmNeAjJEHFlMRWYt5ceKkCaf+Y5l6/UzBK5qsT7tfBxw7pJ2VN4miijnXG3mjvhhJUE2sWZ6+cc+63/Tgd+S/2vb5afDIMyAuG8199KYtQrdxUvXpw/U5wRbPXhqgKlqPvUokRgnbbR/oFghRIn0w+qUrAOtAWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRQaWN0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4654C4CED3;
	Wed, 27 Nov 2024 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724117;
	bh=yBGEcoVCTKxTtH7DTI85SQ7vcP8O3tXA5FLznuYj7sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRQaWN0D20PDIP+lLCq6uyRFQ3kJNqEXzxe+mo1u5f65fUIO8Ojjj67TuDlNheL3P
	 CHDQp05705H7fZCMCk2Tt3V5Hst+4lPZsXiTF8QYytlFzWDSdvNjD1G5DhvLVhr4bK
	 sigRNQfd8/du5aHTLXUahVU72+q40QHYw0J8IJOkpdOfxy9j0dbo+1TYfLz57jbXON
	 WUn7FEKQ3LNBT7c/QP/YVVM/psGnwgHIYEjsBaCkcSqIvVjsyod+hQdZT07H+uf4K9
	 tGz1Lvf9q9RMO3MeYW5yMy2I/yLaoeKwv1lcYF9Wc2MSw1XeiZYiBwmUpddu7Fb4GC
	 1o225I+QUhtlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] rcu-tasks: Fix access non-existent percpu rtpcp variable in rcu_tasks_need_gpcb()
Date: Wed, 27 Nov 2024 11:15:15 -0500
Message-ID: <20241127084859-8ff455beb5530be5@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241127021813.472737-1-xiangyu.chen@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: fd70e9f1d85f5323096ad313ba73f5fe3d15ea41

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Zqiang <qiang.zhang1211@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 05095271a4fb)
6.6.y | Present (different SHA1: b3b2431ed27f)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-27 08:44:48.162519786 -0500
+++ /tmp/tmp.BM83GdWj4t	2024-11-27 08:44:48.157166722 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit fd70e9f1d85f5323096ad313ba73f5fe3d15ea41 ]
+
 For kernels built with CONFIG_FORCE_NR_CPUS=y, the nr_cpu_ids is
 defined as NR_CPUS instead of the number of possible cpus, this
 will cause the following system panic:
@@ -40,65 +42,68 @@
 Reported-by: Zhixu Liu <zhixu.liu@gmail.com>
 Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
 Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+[Xiangyu: BP to fix CVE:CVE-2024-49926, minor conflict resolution]
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  kernel/rcu/tasks.h | 82 ++++++++++++++++++++++++++++++----------------
- 1 file changed, 53 insertions(+), 29 deletions(-)
+ 1 file changed, 54 insertions(+), 28 deletions(-)
 
 diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
-index 4bc038bcc0169..72d564c84499a 100644
+index bb6b037ef30f..46b207eac171 100644
 --- a/kernel/rcu/tasks.h
 +++ b/kernel/rcu/tasks.h
-@@ -34,6 +34,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
+@@ -31,6 +31,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
+  * @barrier_q_head: RCU callback for barrier operation.
   * @rtp_blkd_tasks: List of tasks blocked as readers.
-  * @rtp_exit_list: List of tasks in the latter portion of do_exit().
   * @cpu: CPU number corresponding to this entry.
 + * @index: Index of this CPU in rtpcp_array of the rcu_tasks structure.
   * @rtpp: Pointer to the rcu_tasks structure.
   */
  struct rcu_tasks_percpu {
-@@ -49,6 +50,7 @@ struct rcu_tasks_percpu {
+@@ -43,6 +44,7 @@ struct rcu_tasks_percpu {
+ 	struct rcu_head barrier_q_head;
  	struct list_head rtp_blkd_tasks;
- 	struct list_head rtp_exit_list;
  	int cpu;
 +	int index;
  	struct rcu_tasks *rtpp;
  };
  
-@@ -76,6 +78,7 @@ struct rcu_tasks_percpu {
+@@ -68,6 +70,7 @@ struct rcu_tasks_percpu {
+  * @postgp_func: This flavor's post-grace-period function (optional).
   * @call_func: This flavor's call_rcu()-equivalent function.
-  * @wait_state: Task state for synchronous grace-period waits (default TASK_UNINTERRUPTIBLE).
   * @rtpcpu: This flavor's rcu_tasks_percpu structure.
 + * @rtpcp_array: Array of pointers to rcu_tasks_percpu structure of CPUs in cpu_possible_mask.
   * @percpu_enqueue_shift: Shift down CPU ID this much when enqueuing callbacks.
   * @percpu_enqueue_lim: Number of per-CPU callback queues in use for enqueuing.
   * @percpu_dequeue_lim: Number of per-CPU callback queues in use for dequeuing.
-@@ -110,6 +113,7 @@ struct rcu_tasks {
+@@ -100,6 +103,7 @@ struct rcu_tasks {
+ 	postgp_func_t postgp_func;
  	call_rcu_func_t call_func;
- 	unsigned int wait_state;
  	struct rcu_tasks_percpu __percpu *rtpcpu;
 +	struct rcu_tasks_percpu **rtpcp_array;
  	int percpu_enqueue_shift;
  	int percpu_enqueue_lim;
  	int percpu_dequeue_lim;
-@@ -182,6 +186,8 @@ module_param(rcu_task_collapse_lim, int, 0444);
- static int rcu_task_lazy_lim __read_mostly = 32;
- module_param(rcu_task_lazy_lim, int, 0444);
+@@ -164,6 +168,8 @@ module_param(rcu_task_contend_lim, int, 0444);
+ static int rcu_task_collapse_lim __read_mostly = 10;
+ module_param(rcu_task_collapse_lim, int, 0444);
  
 +static int rcu_task_cpu_ids;
 +
  /* RCU tasks grace-period state for debugging. */
  #define RTGS_INIT		 0
  #define RTGS_WAIT_WAIT_CBS	 1
-@@ -245,6 +251,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
- 	int cpu;
+@@ -228,6 +234,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
+ 	unsigned long flags;
  	int lim;
  	int shift;
 +	int maxcpu;
 +	int index = 0;
  
+ 	raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
  	if (rcu_task_enqueue_lim < 0) {
- 		rcu_task_enqueue_lim = 1;
-@@ -254,14 +262,9 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
+@@ -238,14 +246,9 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
  	}
  	lim = rcu_task_enqueue_lim;
  
@@ -116,7 +121,7 @@
  	for_each_possible_cpu(cpu) {
  		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
  
-@@ -273,14 +276,29 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
+@@ -258,16 +261,33 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
  		INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
  		rtpcp->cpu = cpu;
  		rtpcp->rtpp = rtp;
@@ -125,13 +130,15 @@
 +		index++;
  		if (!rtpcp->rtp_blkd_tasks.next)
  			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
- 		if (!rtpcp->rtp_exit_list.next)
- 			INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
+ 		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
 +		maxcpu = cpu;
  	}
+ 	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
  
--	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
--			data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim), rcu_task_cb_adjust);
+ 	if (rcu_task_cb_adjust)
+ 		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
+ 
+-	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
 +	rcu_task_cpu_ids = maxcpu + 1;
 +	if (lim > rcu_task_cpu_ids)
 +		lim = rcu_task_cpu_ids;
@@ -145,10 +152,11 @@
 +	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d rcu_task_cpu_ids=%d.\n",
 +			rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim),
 +			rcu_task_cb_adjust, rcu_task_cpu_ids);
++
  }
  
- // Compute wakeup time for lazy callback timer.
-@@ -348,7 +366,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
+ // IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic().
+@@ -307,7 +327,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
  			rtpcp->rtp_n_lock_retries = 0;
  		}
  		if (rcu_task_cb_adjust && ++rtpcp->rtp_n_lock_retries > rcu_task_contend_lim &&
@@ -156,8 +164,8 @@
 +		    READ_ONCE(rtp->percpu_enqueue_lim) != rcu_task_cpu_ids)
  			needadjust = true;  // Defer adjustment to avoid deadlock.
  	}
- 	// Queuing callbacks before initialization not yet supported.
-@@ -368,10 +386,10 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
+ 	if (!rcu_segcblist_is_enabled(&rtpcp->cblist)) {
+@@ -320,10 +340,10 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
  	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
  	if (unlikely(needadjust)) {
  		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
@@ -171,16 +179,16 @@
  			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
  		}
  		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
-@@ -444,6 +462,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
+@@ -394,6 +414,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
+ 	int needgpcb = 0;
  
- 	dequeue_limit = smp_load_acquire(&rtp->percpu_dequeue_lim);
- 	for (cpu = 0; cpu < dequeue_limit; cpu++) {
+ 	for (cpu = 0; cpu < smp_load_acquire(&rtp->percpu_dequeue_lim); cpu++) {
 +		if (!cpu_possible(cpu))
 +			continue;
  		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
  
  		/* Advance and accelerate any new callbacks. */
-@@ -481,7 +501,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
+@@ -426,7 +448,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
  	if (rcu_task_cb_adjust && ncbs <= rcu_task_collapse_lim) {
  		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
  		if (rtp->percpu_enqueue_lim > 1) {
@@ -189,7 +197,7 @@
  			smp_store_release(&rtp->percpu_enqueue_lim, 1);
  			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
  			gpdone = false;
-@@ -496,7 +516,9 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
+@@ -441,7 +463,9 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
  			pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
  		}
  		if (rtp->percpu_dequeue_lim == 1) {
@@ -200,7 +208,7 @@
  				struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
  
  				WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp->cblist));
-@@ -511,30 +533,32 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
+@@ -456,30 +480,32 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
  // Advance callbacks and invoke any that are ready.
  static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu *rtpcp)
  {
@@ -246,3 +254,6 @@
  		return;
  	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
  	rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

