Return-Path: <stable+bounces-203504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31136CE68DC
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D17A3011F64
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AB030C614;
	Mon, 29 Dec 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="trmzUMO+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5935308F35
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008240; cv=none; b=syzpME+PeJ8eNiNp79kCZTY2UebjJhx60f76pgFphDoSFXAw9THf8dkPmxk+UUU5yS4rREvHZsOIQuZa+3jePkxFZDF9Q04R1awdxw4RnmuoYBUgmKGWTmAN1QQz/urAjE48B1xkeuyEmXm6sgNLJKRdwoSbJDqKBCB49AUIoZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008240; c=relaxed/simple;
	bh=sNCSvp1aSaFse8BHGuMTCmGIyynbz3V54eAyxZJolB4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=DlHPiW/MwNuE51Q8y4A4/6LSJ99N3rZZv0BJxCiHt/j+hP00iq4FeWv0fkVN8OeTmYKsjRisrhGmIiKO6iXauczlYaMLmyPmI3GC5VQGV5LkGkHIwXK2m8prV+kce49//cTRctAMmcy/XpeBPFh1qB6tMu2g4d3Qtx0WWDFTFc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=trmzUMO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831CCC4CEF7;
	Mon, 29 Dec 2025 11:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767008239;
	bh=sNCSvp1aSaFse8BHGuMTCmGIyynbz3V54eAyxZJolB4=;
	h=Subject:To:Cc:From:Date:From;
	b=trmzUMO+GqnofzbOxne4GnkdZoF4IFkX/olRrPA9/U4Bb4detF+t1qcQh3tsXI8pz
	 Me1phPDlKfpm0bOtsqLYsRCG1qaKTcDpyOphpZEGS5I2ETONcYQNbhuRipKbtG2WUb
	 aC+GTaE1fmfUM1EbZwzsWECGPM26Nni92I2x/3Zk=
Subject: FAILED: patch "[PATCH] sched_ext: Fix incorrect sched_class settings for per-cpu" failed to apply to 6.12-stable tree
To: qiang.zhang@linux.dev,arighi@nvidia.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 12:37:09 +0100
Message-ID: <2025122909-remover-casino-d84a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1dd6c84f1c544e552848a8968599220bd464e338
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122909-remover-casino-d84a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1dd6c84f1c544e552848a8968599220bd464e338 Mon Sep 17 00:00:00 2001
From: Zqiang <qiang.zhang@linux.dev>
Date: Mon, 1 Dec 2025 19:25:40 +0800
Subject: [PATCH] sched_ext: Fix incorrect sched_class settings for per-cpu
 migration tasks

When loading the ebpf scheduler, the tasks in the scx_tasks list will
be traversed and invoke __setscheduler_class() to get new sched_class.
however, this would also incorrectly set the per-cpu migration
task's->sched_class to rt_sched_class, even after unload, the per-cpu
migration task's->sched_class remains sched_rt_class.

The log for this issue is as follows:

./scx_rustland --stats 1
[  199.245639][  T630] sched_ext: "rustland" does not implement cgroup cpu.weight
[  199.269213][  T630] sched_ext: BPF scheduler "rustland" enabled
04:25:09 [INFO] RustLand scheduler attached

bpftrace -e 'iter:task /strcontains(ctx->task->comm, "migration")/
{ printf("%s:%d->%pS\n", ctx->task->comm, ctx->task->pid, ctx->task->sched_class); }'
Attaching 1 probe...
migration/0:24->rt_sched_class+0x0/0xe0
migration/1:27->rt_sched_class+0x0/0xe0
migration/2:33->rt_sched_class+0x0/0xe0
migration/3:39->rt_sched_class+0x0/0xe0
migration/4:45->rt_sched_class+0x0/0xe0
migration/5:52->rt_sched_class+0x0/0xe0
migration/6:58->rt_sched_class+0x0/0xe0
migration/7:64->rt_sched_class+0x0/0xe0

sched_ext: BPF scheduler "rustland" disabled (unregistered from user space)
EXIT: unregistered from user space
04:25:21 [INFO] Unregister RustLand scheduler

bpftrace -e 'iter:task /strcontains(ctx->task->comm, "migration")/
{ printf("%s:%d->%pS\n", ctx->task->comm, ctx->task->pid, ctx->task->sched_class); }'
Attaching 1 probe...
migration/0:24->rt_sched_class+0x0/0xe0
migration/1:27->rt_sched_class+0x0/0xe0
migration/2:33->rt_sched_class+0x0/0xe0
migration/3:39->rt_sched_class+0x0/0xe0
migration/4:45->rt_sched_class+0x0/0xe0
migration/5:52->rt_sched_class+0x0/0xe0
migration/6:58->rt_sched_class+0x0/0xe0
migration/7:64->rt_sched_class+0x0/0xe0

This commit therefore generate a new scx_setscheduler_class() and
add check for stop_sched_class to replace __setscheduler_class().

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index dca9ca0c1854..b563b8c3fd24 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -248,6 +248,14 @@ static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 dsq_id)
 	return rhashtable_lookup(&sch->dsq_hash, &dsq_id, dsq_hash_params);
 }
 
+static const struct sched_class *scx_setscheduler_class(struct task_struct *p)
+{
+	if (p->sched_class == &stop_sched_class)
+		return &stop_sched_class;
+
+	return __setscheduler_class(p->policy, p->prio);
+}
+
 /*
  * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
  * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
@@ -4241,8 +4249,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 		const struct sched_class *old_class = p->sched_class;
-		const struct sched_class *new_class =
-			__setscheduler_class(p->policy, p->prio);
+		const struct sched_class *new_class = scx_setscheduler_class(p);
 
 		update_rq_clock(task_rq(p));
 
@@ -5042,8 +5049,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
 		const struct sched_class *old_class = p->sched_class;
-		const struct sched_class *new_class =
-			__setscheduler_class(p->policy, p->prio);
+		const struct sched_class *new_class = scx_setscheduler_class(p);
 
 		if (scx_get_task_state(p) != SCX_TASK_READY)
 			continue;


