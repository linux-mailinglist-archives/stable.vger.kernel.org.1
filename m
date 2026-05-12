Return-Path: <stable+bounces-245714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMDwM6A3A2ow1wEAu9opvQ
	(envelope-from <stable+bounces-245714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:22:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9655224FD
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0827E30F3831
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF13B1EE2;
	Tue, 12 May 2026 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nGkHJfSg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767093B1ED5
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595518; cv=none; b=Pc2jvq1xrdoyaNQfvWmtu/dHM81fN5Alb1aB2LGPfub22JwU1kJrqxvyW03TpVtxgHIRf38mnRWRh+RgSJ9ESkfl+/tbui5SOUymHV+bTA1wkZ436c4raOPvtLS0KQcU1pdkWEdk1lMbaa/c/TRA+E3xoo6dQ0eWppS8kKfjwwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595518; c=relaxed/simple;
	bh=2wKSdVJR54yce9sXdRdjnxys19C7OspxWEOFLgeKaqU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K1/8kCzU1nUdKFNl5tNUD1kHh5MwAWctdhuWxMBdIl2cSk4FTTGDx7cZwD++naRkGukN9KV2qwqPVv+B1LQ1DXZdoNoauJT1nKHway0f9eBavteO+hOw0/YUP2QvlZlzihCVzP+J9ymO8PuwchCJE3JWsZX3AyCsOhPFTiX1T8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nGkHJfSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB20C2BCB0;
	Tue, 12 May 2026 14:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595518;
	bh=2wKSdVJR54yce9sXdRdjnxys19C7OspxWEOFLgeKaqU=;
	h=Subject:To:Cc:From:Date:From;
	b=nGkHJfSgzUvUfUiujphGU75qzwMuc3RaI836BW7uKiuLCEwyqnD+J2viOOllexBbC
	 sdMx5fdk2ISmtyUDXQC6qgDMfutYQP5oMgBLB5+iT57RteHH7VYNNJQOw2clO18q5Z
	 dKMFlwX4dT4cI/mp23tMXvAB8vte7E4+tXBAtGts=
Subject: FAILED: patch "[PATCH] sched_ext: Make bypass LB cpumasks per-scheduler" failed to apply to 7.0-stable tree
To: tj@kernel.org,arighi@nvidia.com,clm@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:18:08 +0200
Message-ID: <2026051208-barstool-risotto-4fc9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6C9655224FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245714-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,meta.com:email,gregkh:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action


The patch below does not apply to the 7.0-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.0.y
git checkout FETCH_HEAD
git cherry-pick -x d292aa00de1aea72961f94c0db43f6b5c72684c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051208-barstool-risotto-4fc9@gregkh' --subject-prefix 'PATCH 7.0.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d292aa00de1aea72961f94c0db43f6b5c72684c9 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 24 Apr 2026 14:31:36 -1000
Subject: [PATCH] sched_ext: Make bypass LB cpumasks per-scheduler

scx_bypass_lb_{donee,resched}_cpumask were file-scope statics shared by all
scheduler instances. With CONFIG_EXT_SUB_SCHED, multiple sched instances
each arm their own bypass_lb_timer; concurrent bypass_lb_node() calls RMW
the global cpumasks with no lock, corrupting donee/resched decisions.

Move the cpumasks into struct scx_sched, allocate them alongside the timer
in scx_alloc_and_add_sched(), free them in scx_sched_free_rcu_work().

Fixes: 95d1df610cdc ("sched_ext: Implement load balancer for bypass mode")
Cc: stable@vger.kernel.org # v6.19+
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ba977154273c..e07f8c46e399 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -53,8 +53,6 @@ DEFINE_STATIC_KEY_FALSE(__scx_enabled);
 DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_enable_state_var = ATOMIC_INIT(SCX_DISABLED);
 static DEFINE_RAW_SPINLOCK(scx_bypass_lock);
-static cpumask_var_t scx_bypass_lb_donee_cpumask;
-static cpumask_var_t scx_bypass_lb_resched_cpumask;
 static bool scx_init_task_enabled;
 static bool scx_switching_all;
 DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
@@ -4747,6 +4745,8 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	irq_work_sync(&sch->disable_irq_work);
 	kthread_destroy_worker(sch->helper);
 	timer_shutdown_sync(&sch->bypass_lb_timer);
+	free_cpumask_var(sch->bypass_lb_donee_cpumask);
+	free_cpumask_var(sch->bypass_lb_resched_cpumask);
 
 #ifdef CONFIG_EXT_SUB_SCHED
 	kfree(sch->cgrp_path);
@@ -5123,8 +5123,8 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 static void bypass_lb_node(struct scx_sched *sch, int node)
 {
 	const struct cpumask *node_mask = cpumask_of_node(node);
-	struct cpumask *donee_mask = scx_bypass_lb_donee_cpumask;
-	struct cpumask *resched_mask = scx_bypass_lb_resched_cpumask;
+	struct cpumask *donee_mask = sch->bypass_lb_donee_cpumask;
+	struct cpumask *resched_mask = sch->bypass_lb_resched_cpumask;
 	u32 nr_tasks = 0, nr_cpus = 0, nr_balanced = 0;
 	u32 nr_target, nr_donor_target;
 	u32 before_min = U32_MAX, before_max = 0;
@@ -6520,6 +6520,15 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	init_irq_work(&sch->disable_irq_work, scx_disable_irq_workfn);
 	kthread_init_work(&sch->disable_work, scx_disable_workfn);
 	timer_setup(&sch->bypass_lb_timer, scx_bypass_lb_timerfn, 0);
+
+	if (!alloc_cpumask_var(&sch->bypass_lb_donee_cpumask, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto err_stop_helper;
+	}
+	if (!alloc_cpumask_var(&sch->bypass_lb_resched_cpumask, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto err_free_lb_cpumask;
+	}
 	sch->ops = *ops;
 	rcu_assign_pointer(ops->priv, sch);
 
@@ -6529,14 +6538,14 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	char *buf = kzalloc(PATH_MAX, GFP_KERNEL);
 	if (!buf) {
 		ret = -ENOMEM;
-		goto err_stop_helper;
+		goto err_free_lb_resched;
 	}
 	cgroup_path(cgrp, buf, PATH_MAX);
 	sch->cgrp_path = kstrdup(buf, GFP_KERNEL);
 	kfree(buf);
 	if (!sch->cgrp_path) {
 		ret = -ENOMEM;
-		goto err_stop_helper;
+		goto err_free_lb_resched;
 	}
 
 	sch->cgrp = cgrp;
@@ -6571,10 +6580,12 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 #endif	/* CONFIG_EXT_SUB_SCHED */
 	return sch;
 
-#ifdef CONFIG_EXT_SUB_SCHED
+err_free_lb_resched:
+	free_cpumask_var(sch->bypass_lb_resched_cpumask);
+err_free_lb_cpumask:
+	free_cpumask_var(sch->bypass_lb_donee_cpumask);
 err_stop_helper:
 	kthread_destroy_worker(sch->helper);
-#endif
 err_free_pcpu:
 	for_each_possible_cpu(cpu) {
 		if (cpu == bypass_fail_cpu)
@@ -9761,12 +9772,6 @@ static int __init scx_init(void)
 		return ret;
 	}
 
-	if (!alloc_cpumask_var(&scx_bypass_lb_donee_cpumask, GFP_KERNEL) ||
-	    !alloc_cpumask_var(&scx_bypass_lb_resched_cpumask, GFP_KERNEL)) {
-		pr_err("sched_ext: Failed to allocate cpumasks\n");
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 __initcall(scx_init);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 62ce4eaf6a3f..a075732d4430 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1075,6 +1075,8 @@ struct scx_sched {
 	struct irq_work		disable_irq_work;
 	struct kthread_work	disable_work;
 	struct timer_list	bypass_lb_timer;
+	cpumask_var_t		bypass_lb_donee_cpumask;
+	cpumask_var_t		bypass_lb_resched_cpumask;
 	struct rcu_work		rcu_work;
 
 	/* all ancestors including self */


