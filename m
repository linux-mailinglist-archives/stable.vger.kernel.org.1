Return-Path: <stable+bounces-225838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMf1HzU9uWkowQEAu9opvQ
	(envelope-from <stable+bounces-225838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:38:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BF62A900E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C8E130692CF
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BD134A3A2;
	Tue, 17 Mar 2026 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PudWOAYJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A009357A20
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747370; cv=none; b=tbXFARUctD4rgKKt5Z6qQ2TlN+VwA7d92fBeZpblEYIcHPmASFD+u9ik96boqlROBQgqtmWoApZqAzqVEMXGD4HNG8JSOoZd4TxdX8nFMDk14i3/D9PWd2YGPVx/y3TXI+UaI62I60d1yfs7kXivW0n5agt5dXWKq2gAsjkYWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747370; c=relaxed/simple;
	bh=skb6OCmDffYSTc0VIYoQzke7db8QyzbdRQrq5bZ5LbI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mlatjxlrs4Weu/Mk3nxMCImZFl38uxof3+HbO8HKRslgoqsQ5a2AgjQlpDTq+18w4I0UjxxRTrMyJqoKB9WB640WjkZfxGim3RNqkkLnJfxIm4kTkx6LL5Cy8R72K+YgwvBqNwze/jtxmBNk19slLaEEnG9dUx9ORO2G8Lb7dV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PudWOAYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3316C4CEF7;
	Tue, 17 Mar 2026 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773747370;
	bh=skb6OCmDffYSTc0VIYoQzke7db8QyzbdRQrq5bZ5LbI=;
	h=Subject:To:Cc:From:Date:From;
	b=PudWOAYJOkS73Uc2ITbQNQ1Y7d1dpzyODDx0qXABhu/6asAfKmvcb1JzCItTjXtJd
	 ZOKD/aB7N63Q92Mj57nofdWYxr0j8Y3ZdfRWvzYsjocNxfZ0+R6MpbgmO+G3Ms2cp3
	 SxqRJlVBohizw5pVQWMON1b3vQy7dturKHbApcMA=
Subject: FAILED: patch "[PATCH] sched_ext: Fix starvation of scx_enable() under fair-class" failed to apply to 6.12-stable tree
To: tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 12:35:58 +0100
Message-ID: <2026031758-flagship-decimeter-9b5e@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225838-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Queue-Id: 06BF62A900E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x b06ccbabe2506fd70b9167a644978b049150224a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031758-flagship-decimeter-9b5e@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b06ccbabe2506fd70b9167a644978b049150224a Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 3 Mar 2026 01:01:15 -1000
Subject: [PATCH] sched_ext: Fix starvation of scx_enable() under fair-class
 saturation

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

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index eab6e09b6442..ba51969718f5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4975,20 +4975,30 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
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
@@ -5205,13 +5215,15 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
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
@@ -5230,7 +5242,41 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
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
 
 


