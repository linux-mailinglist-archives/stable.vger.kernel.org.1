Return-Path: <stable+bounces-249543-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC+XKbs7DGp8aQUAu9opvQ
	(envelope-from <stable+bounces-249543-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:30:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2046757C411
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E32EE30A02E7
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715613A9615;
	Tue, 19 May 2026 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hSzfZsxI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273AA3A9DA7
	for <stable@vger.kernel.org>; Tue, 19 May 2026 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186058; cv=none; b=jp447KnE0g1Ha64BO1dy6UJzC274pWVTRbdAfoiH4T2Q9taI9pVtUdWEDgfi/ELhhaN8kL648SwR2zo/uqvBwdBtz5ld6kG2nXbne1ff/8vB1gsF0iGjFQ9Y6OiH2O9QjCqfdI2dIJ36AxU9ntyap8ptRv0jmZQUWBUWE6Pv5ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186058; c=relaxed/simple;
	bh=hT16Lhk1k7MJJtcXiZy4sUQGBedB1FR0/pyaJmSpNyI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ovgiRlIN+AXw7K2xKkJgH2HKwm/vJtz73fg0C6S13XLhpF3f0sGNHLA/HpY59SF3wpoivKDnF2C32uC9jxmaMj0s8LpETC7Nrz0J/QM+D63a/sjjA7bPAmM3JW3aWPUrFHMiDxwvU6JY25VcuinTa+vtNI2FSeWB2EwnBTur1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hSzfZsxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF2DC2BCB3;
	Tue, 19 May 2026 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779186058;
	bh=hT16Lhk1k7MJJtcXiZy4sUQGBedB1FR0/pyaJmSpNyI=;
	h=Subject:To:Cc:From:Date:From;
	b=hSzfZsxIU//XvY/U7EBHslrlzuKLuA2wEpaRqxleSZe8kOZ6aZq/jKKpNAV6mFkX+
	 dPWFYNVkYZwPCmz9NDEFu/Axn0fEOtoe/IqAxa/uiT9rVzjb/pvyb1EAC5n1ojcbBO
	 +tD/9jRRL7MwkksIcxWfHaMCV9mxnWGaUPxnCfQo=
Subject: FAILED: patch "[PATCH] cgroup/cpuset: Reserve DL bandwidth only for root-domain" failed to apply to 5.10-stable tree
To: zhangguopeng@kylinos.cn,juri.lelli@redhat.com,longman@redhat.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 19 May 2026 12:19:53 +0200
Message-ID: <2026051953-fernlike-browsing-90a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249543-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kylinos.cn:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 2046757C411
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5dd74441cbf42c22e874450eb6a6bbb19390a216
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051953-fernlike-browsing-90a5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5dd74441cbf42c22e874450eb6a6bbb19390a216 Mon Sep 17 00:00:00 2001
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
Date: Sat, 9 May 2026 18:20:31 +0800
Subject: [PATCH] cgroup/cpuset: Reserve DL bandwidth only for root-domain
 moves

cpuset_can_attach() currently adds the bandwidth of all migrating
SCHED_DEADLINE tasks to sum_migrate_dl_bw. If the source and destination
cpuset effective CPU masks do not overlap, the whole sum is then
reserved in the destination root domain.

set_cpus_allowed_dl(), however, subtracts bandwidth from the source
root domain only when the affinity change really moves the task between
root domains. A DL task can move between cpusets that are still in the
same root domain, so including that task in sum_migrate_dl_bw can reserve
destination bandwidth without a matching source-side subtraction.

Share the root-domain move test with set_cpus_allowed_dl(). Keep
nr_migrate_dl_tasks counting all migrating deadline tasks for cpuset DL
task accounting, but add to sum_migrate_dl_bw only for tasks that need a
root-domain bandwidth move. Keep using the destination cpuset effective
CPU mask and leave the broader can_attach()/attach() transaction model
unchanged.

Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
Cc: stable@vger.kernel.org # v6.10+
Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
Reviewed-by: Waiman Long <longman@redhat.com>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 1198138cb839..273538200a44 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -33,6 +33,15 @@ struct root_domain;
 extern void dl_add_task_root_domain(struct task_struct *p);
 extern void dl_clear_root_domain(struct root_domain *rd);
 extern void dl_clear_root_domain_cpu(int cpu);
+/*
+ * Return whether moving DL task @p to @new_mask requires moving DL
+ * bandwidth accounting between root domains. This helper is specific to
+ * DL bandwidth move accounting semantics and is shared by
+ * cpuset_can_attach() and set_cpus_allowed_dl() so both paths use the
+ * same source root-domain test.
+ */
+extern bool dl_task_needs_bw_move(struct task_struct *p,
+				  const struct cpumask *new_mask);
 
 extern u64 dl_cookie;
 extern bool dl_bw_visited(int cpu, u64 cookie);
diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index bb4e692bea30..f7aaf01f7cd5 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -167,6 +167,7 @@ struct cpuset {
 	 */
 	int nr_deadline_tasks;
 	int nr_migrate_dl_tasks;
+	/* DL bandwidth that needs destination reservation for this attach. */
 	u64 sum_migrate_dl_bw;
 	/*
 	 * CPU used for temporary DL bandwidth allocation during attach;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 3fbf6e7f68c3..e84e801e22cf 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2993,7 +2993,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	struct cpuset *cs, *oldcs;
 	struct task_struct *task;
 	bool setsched_check;
-	int ret;
+	int cpu, ret;
 
 	/* used later by cpuset_attach() */
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
@@ -3038,29 +3038,32 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		}
 
 		if (dl_task(task)) {
+			/*
+			 * Count all migrating DL tasks for cpuset task accounting.
+			 * Only tasks that need a root-domain bandwidth move
+			 * contribute to sum_migrate_dl_bw.
+			 */
 			cs->nr_migrate_dl_tasks++;
-			cs->sum_migrate_dl_bw += task->dl.dl_bw;
+			if (dl_task_needs_bw_move(task, cs->effective_cpus))
+				cs->sum_migrate_dl_bw += task->dl.dl_bw;
 		}
 	}
 
-	if (!cs->nr_migrate_dl_tasks)
+	if (!cs->sum_migrate_dl_bw)
 		goto out_success;
 
-	if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
-		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
-
-		if (unlikely(cpu >= nr_cpu_ids)) {
-			ret = -EINVAL;
-			goto out_unlock;
-		}
-
-		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
-		if (ret)
-			goto out_unlock;
-
-		cs->dl_bw_cpu = cpu;
+	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
+	if (unlikely(cpu >= nr_cpu_ids)) {
+		ret = -EINVAL;
+		goto out_unlock;
 	}
 
+	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
+	if (ret)
+		goto out_unlock;
+
+	cs->dl_bw_cpu = cpu;
+
 out_success:
 	/*
 	 * Mark attach is in progress.  This makes validate_change() fail
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index edca7849b165..7db4c87df83b 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3107,20 +3107,18 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 static void set_cpus_allowed_dl(struct task_struct *p,
 				struct affinity_context *ctx)
 {
-	struct root_domain *src_rd;
 	struct rq *rq;
 
 	WARN_ON_ONCE(!dl_task(p));
 
 	rq = task_rq(p);
-	src_rd = rq->rd;
 	/*
 	 * Migrating a SCHED_DEADLINE task between exclusive
 	 * cpusets (different root_domains) entails a bandwidth
 	 * update. We already made space for us in the destination
 	 * domain (see cpuset_can_attach()).
 	 */
-	if (!cpumask_intersects(src_rd->span, ctx->new_mask)) {
+	if (dl_task_needs_bw_move(p, ctx->new_mask)) {
 		struct dl_bw *src_dl_b;
 
 		src_dl_b = dl_bw_of(cpu_of(rq));
@@ -3137,6 +3135,15 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 	set_cpus_allowed_common(p, ctx);
 }
 
+bool dl_task_needs_bw_move(struct task_struct *p,
+			   const struct cpumask *new_mask)
+{
+	if (!dl_task(p))
+		return false;
+
+	return !cpumask_intersects(task_rq(p)->rd->span, new_mask);
+}
+
 /* Assumes rq->lock is held */
 static void rq_online_dl(struct rq *rq)
 {


