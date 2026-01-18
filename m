Return-Path: <stable+bounces-210216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9736D397CA
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 17:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D22693006460
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B171FBCA7;
	Sun, 18 Jan 2026 16:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N52nDLni"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D1C21D3CA
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768753096; cv=none; b=dJh6J3m2rAWkIboW9Br2DGxtUgZ24BLdmzzq7zpa4pPYRPEsd2wkYUVfWNVmHGVpvS/q/oynBWCdSivpuo/RhmW8ksFFlpMLtkv2mI4kogB7nB7gKpTUOGoYgzr11WdCDrjWw2YLSQvS2wXy8thFaT0Jhl6WHhTkO67oOsnltr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768753096; c=relaxed/simple;
	bh=+Ni6gCuqYOrk9udAtBLav2luGbFbxpfwwQMdUUJl/78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gRTEOMZz2VRCUvdrzAORpQcZAkX4hyIy/4tEqmVPpwh/G4/h1N/12E12HWBAGwD1ZA2Q1maNmIV+pJ6A2cU/U7yDPnK8DdGYtiIvAxd6Arvycv8cUDwTv/xFGzh87X5gQP7mzHn3LzEMHKjLlpbPHPo1SjUvMvOjiAlKxmXFAng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N52nDLni; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768753086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxbY9ZLicNezST4OqDkyKxpy3uvxeTOOeWefuY30ST4=;
	b=N52nDLni8Hd+prcyvWT+zLCb2/+oqudCApW+KBKHKh+iSnURxCFnyNjzJSOqlPm5lfIzJW
	WDvsK2p9AFYuuOT6KjVxkcoVJ6HC7OsCDUzdqeFwirjAGw5VvF/PaPycfzTS+rTzyS+axX
	dsGIM8/OHEhuxIxSADJVtRamHlUi6xo=
From: wen.yang@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wen Yang <wen.yang@linuxt.dev>
Subject: [PATCH 6.1 3/3] net: Allow to use SMP threads for backlog NAPI.
Date: Mon, 19 Jan 2026 00:17:41 +0800
Message-Id: <997bc0de4746100bb69e1bd2ccfb25315d8f62e4.1768751557.git.wen.yang@linux.dev>
In-Reply-To: <cover.1768751557.git.wen.yang@linux.dev>
References: <cover.1768751557.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit dad6b97702639fba27a2bd3e986982ad6f0db3a7 upstream.

Backlog NAPI is a per-CPU NAPI struct only (with no device behind it)
used by drivers which don't do NAPI them self, RPS and parts of the
stack which need to avoid recursive deadlocks while processing a packet.

The non-NAPI driver use the CPU local backlog NAPI. If RPS is enabled
then a flow for the skb is computed and based on the flow the skb can be
enqueued on a remote CPU. Scheduling/ raising the softirq (for backlog's
NAPI) on the remote CPU isn't trivial because the softirq is only
scheduled on the local CPU and performed after the hardirq is done.
In order to schedule a softirq on the remote CPU, an IPI is sent to the
remote CPU which schedules the backlog-NAPI on the then local CPU.

On PREEMPT_RT interrupts are force-threaded. The soft interrupts are
raised within the interrupt thread and processed after the interrupt
handler completed still within the context of the interrupt thread. The
softirq is handled in the context where it originated.

With force-threaded interrupts enabled, ksoftirqd is woken up if a
softirq is raised from hardirq context. This is the case if it is raised
from an IPI. Additionally there is a warning on PREEMPT_RT if the
softirq is raised from the idle thread.
This was done for two reasons:
- With threaded interrupts the processing should happen in thread
  context (where it originated) and ksoftirqd is the only thread for
  this context if raised from hardirq. Using the currently running task
  instead would "punish" a random task.
- Once ksoftirqd is active it consumes all further softirqs until it
  stops running. This changed recently and is no longer the case.

Instead of keeping the backlog NAPI in ksoftirqd (in force-threaded/
PREEMPT_RT setups) I am proposing NAPI-threads for backlog.
The "proper" setup with threaded-NAPI is not doable because the threads
are not pinned to an individual CPU and can be modified by the user.
Additionally a dummy network device would have to be assigned. Also
CPU-hotplug has to be considered if additional CPUs show up.
All this can be probably done/ solved but the smpboot-threads already
provide this infrastructure.

Sending UDP packets over loopback expects that the packet is processed
within the call. Delaying it by handing it over to the thread hurts
performance. It is not beneficial to the outcome if the context switch
happens immediately after enqueue or after a while to process a few
packets in a batch.
There is no need to always use the thread if the backlog NAPI is
requested on the local CPU. This restores the loopback throuput. The
performance drops mostly to the same value after enabling RPS on the
loopback comparing the IPI and the tread result.

Create NAPI-threads for backlog if request during boot. The thread runs
the inner loop from napi_threaded_poll(), the wait part is different. It
checks for NAPI_STATE_SCHED (the backlog NAPI can not be disabled).

The NAPI threads for backlog are optional, it has to be enabled via the boot
argument "thread_backlog_napi". It is mandatory for PREEMPT_RT to avoid the
wakeup of ksoftirqd from the IPI.

Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linuxt.dev>
---
 net/core/dev.c | 130 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 104 insertions(+), 26 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 83475b8b3e9d..678848e116d2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -78,6 +78,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
+#include <linux/smpboot.h>
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/string.h>
@@ -217,6 +218,31 @@ static inline struct hlist_head *dev_index_hash(struct net *net, int ifindex)
 	return &net->dev_index_head[ifindex & (NETDEV_HASHENTRIES - 1)];
 }
 
+#ifndef CONFIG_PREEMPT_RT
+
+static DEFINE_STATIC_KEY_FALSE(use_backlog_threads_key);
+
+static int __init setup_backlog_napi_threads(char *arg)
+{
+	static_branch_enable(&use_backlog_threads_key);
+	return 0;
+}
+early_param("thread_backlog_napi", setup_backlog_napi_threads);
+
+static bool use_backlog_threads(void)
+{
+	return static_branch_unlikely(&use_backlog_threads_key);
+}
+
+#else
+
+static bool use_backlog_threads(void)
+{
+	return true;
+}
+
+#endif
+
 static inline void rps_lock_irqsave(struct softnet_data *sd,
 				    unsigned long *flags)
 {
@@ -4415,6 +4441,7 @@ EXPORT_SYMBOL(__dev_direct_xmit);
 /*************************************************************************
  *			Receiver routines
  *************************************************************************/
+static DEFINE_PER_CPU(struct task_struct *, backlog_napi);
 
 int netdev_max_backlog __read_mostly = 1000;
 EXPORT_SYMBOL(netdev_max_backlog);
@@ -4447,12 +4474,16 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 		 */
 		thread = READ_ONCE(napi->thread);
 		if (thread) {
+			if (use_backlog_threads() && thread == raw_cpu_read(backlog_napi))
+				goto use_local_napi;
+
 			set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
 			wake_up_process(thread);
 			return;
 		}
 	}
 
+use_local_napi:
 	list_add_tail(&napi->poll_list, &sd->poll_list);
 	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
 }
@@ -4695,6 +4726,11 @@ static void napi_schedule_rps(struct softnet_data *sd)
 
 #ifdef CONFIG_RPS
 	if (sd != mysd) {
+		if (use_backlog_threads()) {
+			__napi_schedule_irqoff(&sd->backlog);
+			return;
+		}
+
 		sd->rps_ipi_next = mysd->rps_ipi_list;
 		mysd->rps_ipi_list = sd;
 
@@ -5979,7 +6015,7 @@ static void net_rps_action_and_irq_enable(struct softnet_data *sd)
 #ifdef CONFIG_RPS
 	struct softnet_data *remsd = sd->rps_ipi_list;
 
-	if (remsd) {
+	if (!use_backlog_threads() && remsd) {
 		sd->rps_ipi_list = NULL;
 
 		local_irq_enable();
@@ -5994,7 +6030,7 @@ static void net_rps_action_and_irq_enable(struct softnet_data *sd)
 static bool sd_has_rps_ipi_waiting(struct softnet_data *sd)
 {
 #ifdef CONFIG_RPS
-	return sd->rps_ipi_list != NULL;
+	return !use_backlog_threads() && sd->rps_ipi_list;
 #else
 	return false;
 #endif
@@ -6038,7 +6074,7 @@ static int process_backlog(struct napi_struct *napi, int quota)
 			 * We can use a plain write instead of clear_bit(),
 			 * and we dont need an smp_mb() memory barrier.
 			 */
-			napi->state = 0;
+			napi->state &= NAPIF_STATE_THREADED;
 			again = false;
 		} else {
 			skb_queue_splice_tail_init(&sd->input_pkt_queue,
@@ -6688,32 +6724,37 @@ static int napi_thread_wait(struct napi_struct *napi)
 	return -1;
 }
 
-static int napi_threaded_poll(void *data)
+static void napi_threaded_poll_loop(struct napi_struct *napi)
 {
-	struct napi_struct *napi = data;
-	void *have;
-
-	while (!napi_thread_wait(napi)) {
-		unsigned long last_qs = jiffies;
+	unsigned long last_qs = jiffies;
 
-		for (;;) {
-			bool repoll = false;
+	for (;;) {
+		bool repoll = false;
+		void *have;
 
-			local_bh_disable();
+		local_bh_disable();
 
-			have = netpoll_poll_lock(napi);
-			__napi_poll(napi, &repoll);
-			netpoll_poll_unlock(have);
+		have = netpoll_poll_lock(napi);
+		__napi_poll(napi, &repoll);
+		netpoll_poll_unlock(have);
 
-			local_bh_enable();
+		local_bh_enable();
 
-			if (!repoll)
-				break;
+		if (!repoll)
+			break;
 
-			rcu_softirq_qs_periodic(last_qs);
-			cond_resched();
-		}
+		rcu_softirq_qs_periodic(last_qs);
+		cond_resched();
 	}
+}
+
+static int napi_threaded_poll(void *data)
+{
+	struct napi_struct *napi = data;
+
+	while (!napi_thread_wait(napi))
+		napi_threaded_poll_loop(napi);
+
 	return 0;
 }
 
@@ -11238,7 +11279,7 @@ static int dev_cpu_dead(unsigned int oldcpu)
 
 		list_del_init(&napi->poll_list);
 		if (napi->poll == process_backlog)
-			napi->state = 0;
+			napi->state &= NAPIF_STATE_THREADED;
 		else
 			____napi_schedule(sd, napi);
 	}
@@ -11246,12 +11287,14 @@ static int dev_cpu_dead(unsigned int oldcpu)
 	raise_softirq_irqoff(NET_TX_SOFTIRQ);
 	local_irq_enable();
 
+	if (!use_backlog_threads()) {
 #ifdef CONFIG_RPS
-	remsd = oldsd->rps_ipi_list;
-	oldsd->rps_ipi_list = NULL;
+		remsd = oldsd->rps_ipi_list;
+		oldsd->rps_ipi_list = NULL;
 #endif
-	/* send out pending IPI's on offline CPU */
-	net_rps_send_ipi(remsd);
+		/* send out pending IPI's on offline CPU */
+		net_rps_send_ipi(remsd);
+	}
 
 	/* Process offline CPU's input_pkt_queue */
 	while ((skb = __skb_dequeue(&oldsd->process_queue))) {
@@ -11511,6 +11554,38 @@ static struct pernet_operations __net_initdata default_device_ops = {
  *
  */
 
+static int backlog_napi_should_run(unsigned int cpu)
+{
+	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
+	struct napi_struct *napi = &sd->backlog;
+
+	return test_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
+}
+
+static void run_backlog_napi(unsigned int cpu)
+{
+	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
+
+	napi_threaded_poll_loop(&sd->backlog);
+}
+
+static void backlog_napi_setup(unsigned int cpu)
+{
+	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
+	struct napi_struct *napi = &sd->backlog;
+
+	napi->thread = this_cpu_read(backlog_napi);
+	set_bit(NAPI_STATE_THREADED, &napi->state);
+}
+
+static struct smp_hotplug_thread backlog_threads = {
+	.store			= &backlog_napi,
+	.thread_should_run	= backlog_napi_should_run,
+	.thread_fn		= run_backlog_napi,
+	.thread_comm		= "backlog_napi/%u",
+	.setup			= backlog_napi_setup,
+};
+
 /*
  *       This is called single threaded during boot, so no need
  *       to take the rtnl semaphore.
@@ -11561,7 +11636,10 @@ static int __init net_dev_init(void)
 		init_gro_hash(&sd->backlog);
 		sd->backlog.poll = process_backlog;
 		sd->backlog.weight = weight_p;
+		INIT_LIST_HEAD(&sd->backlog.poll_list);
 	}
+	if (use_backlog_threads())
+		smpboot_register_percpu_thread(&backlog_threads);
 
 	dev_boot_phase = 0;
 
-- 
2.25.1


