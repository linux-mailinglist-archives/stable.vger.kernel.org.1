Return-Path: <stable+bounces-241039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMrDH5rW62lISAAAu9opvQ
	(envelope-from <stable+bounces-241039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:46:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF1A4634A0
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6AFB3012841
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0039C3FFADF;
	Fri, 24 Apr 2026 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfYPh1vY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C553FFAD7;
	Fri, 24 Apr 2026 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063471; cv=none; b=Zibpb1d1qtB5VJeugYepNpJxfjI0QnNC3Pm1KeUJOMbfaokBNoV0Gk+Ol2Y4/RYLqyaNjF+wvvolKezywmrTxHygjVnCtrlb4EVul1PeMxApcloWnRdq122thmTDHzsxfw2cfx4TucUgRmUo59Lk7EwIUL6p49DBVyB5bgffIp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063471; c=relaxed/simple;
	bh=qPJgdoqthPXRaxCT3RdewnobRnyX54NzogEAbZX+gxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABCJVOSQtLTi3+16Bs9xif2eyreNaz6UhT9jUR4xeMwNwjq53DqllbPY6O4g39iw/STQO3CSAV+lgX+5nppzD3bJnJjzzvkfcPkL9J9QbZ5XUQQZXBjpFjgM+2wb1Gi48lW/ROYLiDSn9+l1FG3B2MtPFByTA2PlSBdf/HyHtZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfYPh1vY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46025C2BCB0;
	Fri, 24 Apr 2026 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063471;
	bh=qPJgdoqthPXRaxCT3RdewnobRnyX54NzogEAbZX+gxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfYPh1vYC3tKQQndNIcAICbwTx3xGH181zfiBIrRxXbcs3dnyXg4+LJ3aWiqSiA1z
	 dORYtsioE55uSMBVIqna7R5nyi2QwLx4J0ybpP0eL+RbX5bZFIOKSCZR/3K3NttM+M
	 tYVTHkzEjWeuz0wAYn+sCCXr/uQuM/QT66Nq94X7kuaJrlYXac3mpoYSd85J9WJPI9
	 ImW9DHqEZdSTCkz8o3GURrrBbAbUKmq00w79IW4j6PEUPnEmU+Ki4qzBR+9hhJIdSC
	 91UJedsAgn/PrG03rQtAJywkRnntJf/NGHwyg3R3uvKXTrhXAHFIlKdt4UZCjR4J+H
	 LTnj+Csoep6gw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 11/13] sched_ext: Make bypass LB cpumasks per-scheduler
Date: Fri, 24 Apr 2026 10:44:16 -1000
Message-ID: <20260424204418.3809733-12-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424204418.3809733-1-tj@kernel.org>
References: <20260424204418.3809733-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2AF1A4634A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241039-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

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
---
 kernel/sched/ext.c          | 33 +++++++++++++++++++--------------
 kernel/sched/ext_internal.h |  2 ++
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index da188af21b3d..0980531c0e6c 100644
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
@@ -5102,8 +5102,8 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
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
@@ -6499,6 +6499,15 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
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
 
@@ -6508,14 +6517,14 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
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
@@ -6550,10 +6559,12 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
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
@@ -9740,12 +9751,6 @@ static int __init scx_init(void)
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
-- 
2.53.0


