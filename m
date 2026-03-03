Return-Path: <stable+bounces-222857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL9QDnPApmnETQAAu9opvQ
	(envelope-from <stable+bounces-222857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 12:05:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A71B1ED58B
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 12:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F29C63008CAE
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 11:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AAE3E8C5C;
	Tue,  3 Mar 2026 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bljmHR7v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C23E9F93;
	Tue,  3 Mar 2026 11:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535677; cv=none; b=lffF88u7rkZyyfEZBjVrMwUJpbNz5/338COxGwj9AuWwKJ7cTKsxNyaQEBfzZ1IFLaE63vh9tkUUoxPZ5RcHMH6NuL1oHRX0IJSfVpY6MgrG3+v6eVUBaLnE5RX7vTyakklXwTWBVEhWQ050kgpdB/e7o/59/V1wq7qvkMJH4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535677; c=relaxed/simple;
	bh=q5LnMbaB80xwd3/j9l4jKe95mdjbXXcr3a0eioUAyi8=;
	h=Date:Message-ID:From:To:Cc:Subject; b=k4mcUoaG9XjBVYtbr2f2M8X7sTmazZJLdSZlTmybu9MSBkDvHe4dIrLPN/S96t5M8WpTMh0uGcZIG9PZeBe0t7SH6gBs1JTACTKfnwfU96r+uhYBkR/KLOEKO2bXRDkfUYSSRIl3YrUgd2VYasRK61y8B5CtYa6Wc/Nn/5tYgNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bljmHR7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C707EC116C6;
	Tue,  3 Mar 2026 11:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772535676;
	bh=q5LnMbaB80xwd3/j9l4jKe95mdjbXXcr3a0eioUAyi8=;
	h=Date:From:To:Cc:Subject:From;
	b=bljmHR7vW0kxKmP0+fEdN4VoxiSHoBHAM/sFLC9zrZ0mgKkNz4OgrmtjWtqrXbi1f
	 sviMCzNfwKKQqotjKxjN6cdkIuwlF17Cs/NW1LM+SFc2P77969UXHRC5aepVK8y6yJ
	 Ff6ZWPMyKqBgfACb3+JyNV/iIWuLvIoT2Q6QnHE4oiz0Q9A7siXTSXb0law7UjzQ/e
	 WVfmEEE5umbyN8kvGevNtaqc/aDP4m6E8NfZ64n9JWCzay7ly+DeotluHsmS+Nv6/F
	 o5S+31tbQGnM6RHIjzNWuD0VoVgk65C8bD8Z0vznRZfoSExYw04S9uOlLDb74iWZ7e
	 Fec1MZlYKOohA==
Date: Tue, 03 Mar 2026 01:01:15 -1000
Message-ID: <85a171ba1e37f417fbd7e74afe56efc4@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH sched_ext/for-7.0-fixes] sched_ext: Fix starvation of
 scx_enable() under fair-class saturation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 3A71B1ED58B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-222857-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

During scx_enable(), the READY -> ENABLED task switching loop changes the
calling thread's sched_class from fair to ext. Since fair has higher
priority than ext, saturating fair-class workloads can indefinitely starve
the enable thread, hanging the system. This was introduced when the enable
path switched from preempt_disable() to scx_bypass() which doesn't protect
against fair-class starvation. Note that the original preempt_disable()
protection wasn't complete either - in partial switch modes, the calling
thread could still be starved after preempt_enable() as it may have been
switched to ext class.

Fix it by offloading the enable body to a dedicated system-wide RT
(SCHED_FIFO) kthread which cannot be starved by either fair or ext class
tasks. scx_enable() lazily creates the kthread on first use and passes the
ops pointer through a struct scx_enable_cmd containing the kthread_work,
then synchronously waits for completion.

The workfn runs on a different kthread from sch->helper (which runs
disable_work), so it can safely flush disable_work on the error path
without deadlock.

Fixes: 8c2090c504e9 ("sched_ext: Initialize in bypass mode")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 66 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0bb8fa927e9e..deb22c8e25cd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4924,20 +4924,30 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
 	return 0;
 }

-static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
+/*
+ * scx_enable() is offloaded to a dedicated system-wide RT kthread to avoid
+ * starvation. During the READY -> ENABLED task switching loop, the calling
+ * thread's sched_class gets switched from fair to ext. As fair has higher
+ * priority than ext, the calling thread can be indefinitely starved under
+ * fair-class saturation, leading to a system hang.
+ */
+struct scx_enable_cmd {
+	struct kthread_work	work;
+	struct sched_ext_ops	*ops;
+	int			ret;
+};
+
+static void scx_enable_workfn(struct kthread_work *work)
 {
+	struct scx_enable_cmd *cmd =
+		container_of(work, struct scx_enable_cmd, work);
+	struct sched_ext_ops *ops = cmd->ops;
 	struct scx_sched *sch;
 	struct scx_task_iter sti;
 	struct task_struct *p;
 	unsigned long timeout;
 	int i, cpu, ret;

-	if (!cpumask_equal(housekeeping_cpumask(HK_TYPE_DOMAIN),
-			   cpu_possible_mask)) {
-		pr_err("sched_ext: Not compatible with \"isolcpus=\" domain isolation\n");
-		return -EINVAL;
-	}
-
 	mutex_lock(&scx_enable_mutex);

 	if (scx_enable_state() != SCX_DISABLED) {
@@ -5154,13 +5164,15 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)

 	atomic_long_inc(&scx_enable_seq);

-	return 0;
+	cmd->ret = 0;
+	return;

 err_free_ksyncs:
 	free_kick_syncs();
 err_unlock:
 	mutex_unlock(&scx_enable_mutex);
-	return ret;
+	cmd->ret = ret;
+	return;

 err_disable_unlock_all:
 	scx_cgroup_unlock();
@@ -5179,7 +5191,41 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	scx_error(sch, "scx_enable() failed (%d)", ret);
 	kthread_flush_work(&sch->disable_work);
-	return 0;
+	cmd->ret = 0;
+}
+
+static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
+{
+	static struct kthread_worker *helper;
+	static DEFINE_MUTEX(helper_mutex);
+	struct scx_enable_cmd cmd;
+
+	if (!cpumask_equal(housekeeping_cpumask(HK_TYPE_DOMAIN),
+			   cpu_possible_mask)) {
+		pr_err("sched_ext: Not compatible with \"isolcpus=\" domain isolation\n");
+		return -EINVAL;
+	}
+
+	if (!READ_ONCE(helper)) {
+		mutex_lock(&helper_mutex);
+		if (!helper) {
+			helper = kthread_run_worker(0, "scx_enable_helper");
+			if (IS_ERR_OR_NULL(helper)) {
+				helper = NULL;
+				mutex_unlock(&helper_mutex);
+				return -ENOMEM;
+			}
+			sched_set_fifo(helper->task);
+		}
+		mutex_unlock(&helper_mutex);
+	}
+
+	kthread_init_work(&cmd.work, scx_enable_workfn);
+	cmd.ops = ops;
+
+	kthread_queue_work(READ_ONCE(helper), &cmd.work);
+	kthread_flush_work(&cmd.work);
+	return cmd.ret;
 }


--
2.53.0

