Return-Path: <stable+bounces-226933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMtSAHntuWnFPgIAu9opvQ
	(envelope-from <stable+bounces-226933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:10:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3572B48C9
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 01:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31FA73021453
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500B522097;
	Wed, 18 Mar 2026 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdK1xstU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C812B93
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792627; cv=none; b=cgCiTYPyknDnG/XDUiHaFsbZYW5C1DQ5vga2D3CAIe/FA43yw8A+/LjO6/Smf7/QyMIKTts4pvSCBwhXAiyJHzPVZ+PhKC0C5t89J+UHxwNdNNoU//qMHVqQCXbVrxz7Zo6TBXGtW9s7mvaNaYcQ7/gHneq0momhrmLWrj4Q8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792627; c=relaxed/simple;
	bh=pRlqGOch6gPLrWX0CwxIF9sI8Vm/GqTaAENkOY8Cplg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCioCJe8CixoUwKW6WCVwoVjx9Hw18lwy9P21eelenbkC4rhhwgX5yCcYryCxRZxPSrlZWH0ld39h14HJ/u9H9bbpEq8hcAW7Vw9r+fnQHgkWDQpn7gdrIFP4LprRhDxwrA/lB6fPKILXyo2Kgl1B/Rd5vO12ElqgUb/hFjcNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdK1xstU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E16DC4CEF7;
	Wed, 18 Mar 2026 00:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773792626;
	bh=pRlqGOch6gPLrWX0CwxIF9sI8Vm/GqTaAENkOY8Cplg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdK1xstUqqCuM2oG9xdA1N8+PvsUtl1MrM9Bi0vh5MAGdB6iI6AlZjRFC+quufElq
	 vlv+2O16FHQAHBpvPuAq6h7+wbQXelrY1lQCRtvlkIjIVGc+r1MnMnAnP/Grey7RCy
	 RIoVvlJtNGVmiPps/LrFcKdZu2T+gMQnf4lo01xt9Pb03xWfAY+725CEIvkcauJODz
	 SBQc1vAND4oQkIjRkCuSKh+cZtHtfd+GWdBl25hKv+35e9cbIkDmnojRU4Ny8QUzdg
	 OueqBhFoOIB52L0dXbs6h7gn+6EhdwyK23uV7L02kOg/ajboa8pi5shAueel+2rKun
	 amtgE9WOQYn0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] sched_ext: Fix starvation of scx_enable() under fair-class saturation
Date: Tue, 17 Mar 2026 20:10:24 -0400
Message-ID: <20260318001024.379990-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031758-flagship-decimeter-9b5e@gregkh>
References: <2026031758-flagship-decimeter-9b5e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226933-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A3572B48C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tejun Heo <tj@kernel.org>

[ Upstream commit b06ccbabe2506fd70b9167a644978b049150224a ]

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
[ adapted per-scheduler scx_sched struct references to globals ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 64 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7e79f39c7bcf6..f269128559a27 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5150,19 +5150,29 @@ static int validate_ops(const struct sched_ext_ops *ops)
 	return 0;
 }
 
-static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
+/*
+ * scx_ops_enable() is offloaded to a dedicated system-wide RT kthread to avoid
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
+static void scx_ops_enable_workfn(struct kthread_work *work)
 {
+	struct scx_enable_cmd *cmd =
+		container_of(work, struct scx_enable_cmd, work);
+	struct sched_ext_ops *ops = cmd->ops;
 	struct scx_task_iter sti;
 	struct task_struct *p;
 	unsigned long timeout;
 	int i, cpu, node, ret;
 
-	if (!cpumask_equal(housekeeping_cpumask(HK_TYPE_DOMAIN),
-			   cpu_possible_mask)) {
-		pr_err("sched_ext: Not compatible with \"isolcpus=\" domain isolation\n");
-		return -EINVAL;
-	}
-
 	mutex_lock(&scx_ops_enable_mutex);
 
 	if (!scx_ops_helper) {
@@ -5429,7 +5439,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	atomic_long_inc(&scx_enable_seq);
 
-	return 0;
+	cmd->ret = 0;
+	return;
 
 err_del:
 	kobject_del(scx_root_kobj);
@@ -5442,7 +5453,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	}
 err_unlock:
 	mutex_unlock(&scx_ops_enable_mutex);
-	return ret;
+	cmd->ret = ret;
+	return;
 
 err_disable_unlock_all:
 	scx_cgroup_unlock();
@@ -5461,7 +5473,39 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	scx_ops_error("scx_ops_enable() failed (%d)", ret);
 	kthread_flush_work(&scx_ops_disable_work);
-	return 0;
+	cmd->ret = 0;
+}
+
+static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
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
+			helper = scx_create_rt_helper("scx_ops_enable_helper");
+			if (!helper) {
+				mutex_unlock(&helper_mutex);
+				return -ENOMEM;
+			}
+		}
+		mutex_unlock(&helper_mutex);
+	}
+
+	kthread_init_work(&cmd.work, scx_ops_enable_workfn);
+	cmd.ops = ops;
+
+	kthread_queue_work(READ_ONCE(helper), &cmd.work);
+	kthread_flush_work(&cmd.work);
+	return cmd.ret;
 }
 
 
-- 
2.51.0


