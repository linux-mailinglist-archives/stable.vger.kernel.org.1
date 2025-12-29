Return-Path: <stable+bounces-203503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACCDCE68D6
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEE173013523
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A03930C605;
	Mon, 29 Dec 2025 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WE+SFWlH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55CE285C85
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008238; cv=none; b=LdYfQyfkIrSWvdkzVNNwx/p1/lqHkWaaQ1QCSwJ7y7GnHyCb5DW89uQO4+plSrPPEI/rrJ7uQRbSF0dp+wVukis4qM7Fgqs1xBPD667QR3FkGxrZa1sk7nefQLvy/t85b04Bk0Hc7WWqpnEzg60gGYMoPCXwdOi4xeHS58kTnhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008238; c=relaxed/simple;
	bh=Wj1a7yF/r6BqFoefMfY06F+yjXovCziRBq+P4itl3Lo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kQX352UVzkj1e0bdCI0BT+TbYxwhLW4F3gsnvcfi30KYW81Fh/uHwJ/q0Ts4w1nUyRacbbVAuOFRljl7vvqzIlUIG1PR2q8iIjSeOPNI1m46gqATl7aOO05wVJOKkF5w8rjZTDydNizgz8FdfA3c4awAh3TLl8+IbZvombMFDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WE+SFWlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E067C4CEF7;
	Mon, 29 Dec 2025 11:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767008236;
	bh=Wj1a7yF/r6BqFoefMfY06F+yjXovCziRBq+P4itl3Lo=;
	h=Subject:To:Cc:From:Date:From;
	b=WE+SFWlHGtYX3m4ew+laHh79n8RgNN9dnDhfl7TpGc2DAchFNmmdTOFino7hH7uvq
	 VM/x05zQCkJLr9X692SNcnNWBCrJoUaCqmAq6mbxGetHq/kGm3W7cvzcKV8O4N+rlX
	 3A72MCJwGzEHx6xH77EiXV2qWJef66jl+wLJjK4k=
Subject: FAILED: patch "[PATCH] sched_ext: Fix incorrect sched_class settings for per-cpu" failed to apply to 6.18-stable tree
To: qiang.zhang@linux.dev,arighi@nvidia.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 12:37:08 +0100
Message-ID: <2025122908-magician-unlaced-bef4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1dd6c84f1c544e552848a8968599220bd464e338
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122908-magician-unlaced-bef4@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

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


