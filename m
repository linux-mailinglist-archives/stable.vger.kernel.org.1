Return-Path: <stable+bounces-82261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F497994BE1
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0419528345E
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70F61DE898;
	Tue,  8 Oct 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eJ1L8uw6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580A0183CB8;
	Tue,  8 Oct 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391669; cv=none; b=D7AUWp5VZh7XEQUeZz1JCTaEy/uy5d0KiQUx4HDt3thm97SOND6MxU94V6/ru9+6pi9lQiozKvNRJ8Pt/3cxcknRoxBZxhdhHqfpdoNhdqQ6sGBmONlpC1G1BT+PVmQrB3PdWLqsvjQfvmgSSGaDtnoiE/nBcCewOCWhyhXV+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391669; c=relaxed/simple;
	bh=j6kl3CIHG+28PWzR0BCULj9maXI7XYt6/gqeZrk8ox8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jn/SBrPn4V67UYC04K+yfHYJFUj0yOKyg8j1PQUpofH3SRMyLN+3lhz8wTegIm/gK20XdYLHotiq8bBnEOtiZPIN2dvhijTDpfSY/rwrqmmtnbvnokZuuGML3wPvW1Ao9KMBu9WO2nZ3qEGeaQlYHSHlbjsUbDK8AWPzb2Z0NQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eJ1L8uw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE13FC4CEC7;
	Tue,  8 Oct 2024 12:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391669;
	bh=j6kl3CIHG+28PWzR0BCULj9maXI7XYt6/gqeZrk8ox8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJ1L8uw6Et5a5VdK0N8vha58BFAtY9CbfBHXSIfvxkBsyWB/+2NWwZoT3ay1Yk/EM
	 6wF/0PCazqgST9e64xGqK1Hm5Y+kppvhQ3K/SRQwEKBUIpltX+HNJJ7Js1onJvxN4j
	 p9fql80nenWdiUGFQodMnJ4SLHl/Z0A4Rw/wubE8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhixu Liu <zhixu.liu@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 188/558] rcu-tasks: Fix access non-existent percpu rtpcp variable in rcu_tasks_need_gpcb()
Date: Tue,  8 Oct 2024 14:03:38 +0200
Message-ID: <20241008115709.748978644@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zqiang <qiang.zhang1211@gmail.com>

[ Upstream commit fd70e9f1d85f5323096ad313ba73f5fe3d15ea41 ]

For kernels built with CONFIG_FORCE_NR_CPUS=y, the nr_cpu_ids is
defined as NR_CPUS instead of the number of possible cpus, this
will cause the following system panic:

smpboot: Allowing 4 CPUs, 0 hotplug CPUs
...
setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:512 nr_node_ids:1
...
BUG: unable to handle page fault for address: ffffffff9911c8c8
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 0 PID: 15 Comm: rcu_tasks_trace Tainted: G W
6.6.21 #1 5dc7acf91a5e8e9ac9dcfc35bee0245691283ea6
RIP: 0010:rcu_tasks_need_gpcb+0x25d/0x2c0
RSP: 0018:ffffa371c00a3e60 EFLAGS: 00010082
CR2: ffffffff9911c8c8 CR3: 000000040fa20005 CR4: 00000000001706f0
Call Trace:
<TASK>
? __die+0x23/0x80
? page_fault_oops+0xa4/0x180
? exc_page_fault+0x152/0x180
? asm_exc_page_fault+0x26/0x40
? rcu_tasks_need_gpcb+0x25d/0x2c0
? __pfx_rcu_tasks_kthread+0x40/0x40
rcu_tasks_one_gp+0x69/0x180
rcu_tasks_kthread+0x94/0xc0
kthread+0xe8/0x140
? __pfx_kthread+0x40/0x40
ret_from_fork+0x34/0x80
? __pfx_kthread+0x40/0x40
ret_from_fork_asm+0x1b/0x80
</TASK>

Considering that there may be holes in the CPU numbers, use the
maximum possible cpu number, instead of nr_cpu_ids, for configuring
enqueue and dequeue limits.

[ neeraj.upadhyay: Fix htmldocs build error reported by Stephen Rothwell ]

Closes: https://lore.kernel.org/linux-input/CALMA0xaTSMN+p4xUXkzrtR5r6k7hgoswcaXx7baR_z9r5jjskw@mail.gmail.com/T/#u
Reported-by: Zhixu Liu <zhixu.liu@gmail.com>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tasks.h | 82 ++++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 29 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ba3440a45b6dd..bc8429ada7a51 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -34,6 +34,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @rtp_blkd_tasks: List of tasks blocked as readers.
  * @rtp_exit_list: List of tasks in the latter portion of do_exit().
  * @cpu: CPU number corresponding to this entry.
+ * @index: Index of this CPU in rtpcp_array of the rcu_tasks structure.
  * @rtpp: Pointer to the rcu_tasks structure.
  */
 struct rcu_tasks_percpu {
@@ -49,6 +50,7 @@ struct rcu_tasks_percpu {
 	struct list_head rtp_blkd_tasks;
 	struct list_head rtp_exit_list;
 	int cpu;
+	int index;
 	struct rcu_tasks *rtpp;
 };
 
@@ -76,6 +78,7 @@ struct rcu_tasks_percpu {
  * @call_func: This flavor's call_rcu()-equivalent function.
  * @wait_state: Task state for synchronous grace-period waits (default TASK_UNINTERRUPTIBLE).
  * @rtpcpu: This flavor's rcu_tasks_percpu structure.
+ * @rtpcp_array: Array of pointers to rcu_tasks_percpu structure of CPUs in cpu_possible_mask.
  * @percpu_enqueue_shift: Shift down CPU ID this much when enqueuing callbacks.
  * @percpu_enqueue_lim: Number of per-CPU callback queues in use for enqueuing.
  * @percpu_dequeue_lim: Number of per-CPU callback queues in use for dequeuing.
@@ -110,6 +113,7 @@ struct rcu_tasks {
 	call_rcu_func_t call_func;
 	unsigned int wait_state;
 	struct rcu_tasks_percpu __percpu *rtpcpu;
+	struct rcu_tasks_percpu **rtpcp_array;
 	int percpu_enqueue_shift;
 	int percpu_enqueue_lim;
 	int percpu_dequeue_lim;
@@ -182,6 +186,8 @@ module_param(rcu_task_collapse_lim, int, 0444);
 static int rcu_task_lazy_lim __read_mostly = 32;
 module_param(rcu_task_lazy_lim, int, 0444);
 
+static int rcu_task_cpu_ids;
+
 /* RCU tasks grace-period state for debugging. */
 #define RTGS_INIT		 0
 #define RTGS_WAIT_WAIT_CBS	 1
@@ -245,6 +251,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	int cpu;
 	int lim;
 	int shift;
+	int maxcpu;
+	int index = 0;
 
 	if (rcu_task_enqueue_lim < 0) {
 		rcu_task_enqueue_lim = 1;
@@ -254,14 +262,9 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	}
 	lim = rcu_task_enqueue_lim;
 
-	if (lim > nr_cpu_ids)
-		lim = nr_cpu_ids;
-	shift = ilog2(nr_cpu_ids / lim);
-	if (((nr_cpu_ids - 1) >> shift) >= lim)
-		shift++;
-	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
-	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
-	smp_store_release(&rtp->percpu_enqueue_lim, lim);
+	rtp->rtpcp_array = kcalloc(num_possible_cpus(), sizeof(struct rcu_tasks_percpu *), GFP_KERNEL);
+	BUG_ON(!rtp->rtpcp_array);
+
 	for_each_possible_cpu(cpu) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
@@ -273,14 +276,29 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		INIT_WORK(&rtpcp->rtp_work, rcu_tasks_invoke_cbs_wq);
 		rtpcp->cpu = cpu;
 		rtpcp->rtpp = rtp;
+		rtpcp->index = index;
+		rtp->rtpcp_array[index] = rtpcp;
+		index++;
 		if (!rtpcp->rtp_blkd_tasks.next)
 			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
 		if (!rtpcp->rtp_exit_list.next)
 			INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
+		maxcpu = cpu;
 	}
 
-	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
-			data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim), rcu_task_cb_adjust);
+	rcu_task_cpu_ids = maxcpu + 1;
+	if (lim > rcu_task_cpu_ids)
+		lim = rcu_task_cpu_ids;
+	shift = ilog2(rcu_task_cpu_ids / lim);
+	if (((rcu_task_cpu_ids - 1) >> shift) >= lim)
+		shift++;
+	WRITE_ONCE(rtp->percpu_enqueue_shift, shift);
+	WRITE_ONCE(rtp->percpu_dequeue_lim, lim);
+	smp_store_release(&rtp->percpu_enqueue_lim, lim);
+
+	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d rcu_task_cpu_ids=%d.\n",
+			rtp->name, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim),
+			rcu_task_cb_adjust, rcu_task_cpu_ids);
 }
 
 // Compute wakeup time for lazy callback timer.
@@ -348,7 +366,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 			rtpcp->rtp_n_lock_retries = 0;
 		}
 		if (rcu_task_cb_adjust && ++rtpcp->rtp_n_lock_retries > rcu_task_contend_lim &&
-		    READ_ONCE(rtp->percpu_enqueue_lim) != nr_cpu_ids)
+		    READ_ONCE(rtp->percpu_enqueue_lim) != rcu_task_cpu_ids)
 			needadjust = true;  // Defer adjustment to avoid deadlock.
 	}
 	// Queuing callbacks before initialization not yet supported.
@@ -368,10 +386,10 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	if (unlikely(needadjust)) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
-		if (rtp->percpu_enqueue_lim != nr_cpu_ids) {
+		if (rtp->percpu_enqueue_lim != rcu_task_cpu_ids) {
 			WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
-			WRITE_ONCE(rtp->percpu_dequeue_lim, nr_cpu_ids);
-			smp_store_release(&rtp->percpu_enqueue_lim, nr_cpu_ids);
+			WRITE_ONCE(rtp->percpu_dequeue_lim, rcu_task_cpu_ids);
+			smp_store_release(&rtp->percpu_enqueue_lim, rcu_task_cpu_ids);
 			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
 		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
@@ -444,6 +462,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 
 	dequeue_limit = smp_load_acquire(&rtp->percpu_dequeue_lim);
 	for (cpu = 0; cpu < dequeue_limit; cpu++) {
+		if (!cpu_possible(cpu))
+			continue;
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
 		/* Advance and accelerate any new callbacks. */
@@ -481,7 +501,7 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	if (rcu_task_cb_adjust && ncbs <= rcu_task_collapse_lim) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim > 1) {
-			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(nr_cpu_ids));
+			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(rcu_task_cpu_ids));
 			smp_store_release(&rtp->percpu_enqueue_lim, 1);
 			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
 			gpdone = false;
@@ -496,7 +516,9 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 			pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
 		}
 		if (rtp->percpu_dequeue_lim == 1) {
-			for (cpu = rtp->percpu_dequeue_lim; cpu < nr_cpu_ids; cpu++) {
+			for (cpu = rtp->percpu_dequeue_lim; cpu < rcu_task_cpu_ids; cpu++) {
+				if (!cpu_possible(cpu))
+					continue;
 				struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
 				WARN_ON_ONCE(rcu_segcblist_n_cbs(&rtpcp->cblist));
@@ -511,30 +533,32 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 // Advance callbacks and invoke any that are ready.
 static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu *rtpcp)
 {
-	int cpu;
-	int cpunext;
 	int cpuwq;
 	unsigned long flags;
 	int len;
+	int index;
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	struct rcu_tasks_percpu *rtpcp_next;
 
-	cpu = rtpcp->cpu;
-	cpunext = cpu * 2 + 1;
-	if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
-		rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
-		cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
-		queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
-		cpunext++;
-		if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
-			rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
-			cpuwq = rcu_cpu_beenfullyonline(cpunext) ? cpunext : WORK_CPU_UNBOUND;
+	index = rtpcp->index * 2 + 1;
+	if (index < num_possible_cpus()) {
+		rtpcp_next = rtp->rtpcp_array[index];
+		if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
+			cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
 			queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
+			index++;
+			if (index < num_possible_cpus()) {
+				rtpcp_next = rtp->rtpcp_array[index];
+				if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
+					cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
+					queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
+				}
+			}
 		}
 	}
 
-	if (rcu_segcblist_empty(&rtpcp->cblist) || !cpu_possible(cpu))
+	if (rcu_segcblist_empty(&rtpcp->cblist))
 		return;
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 	rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
-- 
2.43.0




