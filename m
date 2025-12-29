Return-Path: <stable+bounces-204128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2F5CE80E8
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 20:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BB4030102BD
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 19:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B28F18E02A;
	Mon, 29 Dec 2025 19:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVNoZg06"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B710F1
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 19:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767037163; cv=none; b=GmovUnb+bNxHsmb+Mc00VTx59+bbUYjTtD8dVwHtHmZRXWctosvoPWm2IjAQPotoX/y/NYhd2YE5Dhj2+g+bYrnIOt5OVT+OrX0YgWg9T56hmDjHawLM896nidt4MrUxda+3GIPeiuc22czp8nCEcVWMOddJEbwFc5rEEy3ZZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767037163; c=relaxed/simple;
	bh=6+ae7Ag/xahvj5V3qktvrU5r24sDpXEQAxBOunWKK/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s5qRzXkPyYFS1+UdVbrgIrbh3FtKgPSUSp2Zs8ca1YYrCB/cMNi6hoPhP3igRAPBxIYY9x1oAR+dNiJCgnnMDzLfbafR/THnZTHURULTp+PukJ9TiIT1q0FZvK9WRopgFZYSCkt11sYzyijXuWbJrdgXM2F7/aLwmlwDGXwfI6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVNoZg06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539A2C4CEF7;
	Mon, 29 Dec 2025 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767037162;
	bh=6+ae7Ag/xahvj5V3qktvrU5r24sDpXEQAxBOunWKK/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gVNoZg06smYBZY/XAof2Q6AwEt+yHrB3VMVfJZhhddZ97mIt/24pXt23VSx3rbIpb
	 HBMauSA/5J7kJCxFV7/RxYfMSabvLeAe6PhG8knd0mdKfyr21xq7twjpT2lhGEaGSw
	 DP5aRJEI4LOFF6i4g5Ng8fE4fREAidsOLRHEjf4mmip7cCSQtMC78Vuck/uDcwb1NO
	 7Hzhdq2vPapVKoz5Ge+E030WenPpuPrlRIIu+1dcFAX9loXUZIy5M4SjfJPH1PoVGk
	 i5q1uGw+s2cXYfglgCv9ktK1MK83yYDIYI44OtuKoK0zB1TrZuRc46aSqNKk5wB+2f
	 TpttZcHevSo4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zqiang <qiang.zhang@linux.dev>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] sched_ext: Fix incorrect sched_class settings for per-cpu migration tasks
Date: Mon, 29 Dec 2025 14:39:20 -0500
Message-ID: <20251229193920.1643627-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122909-remover-casino-d84a@gregkh>
References: <2025122909-remover-casino-d84a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

[ Upstream commit 1dd6c84f1c544e552848a8968599220bd464e338 ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ad1d438b3085..614275e4b05c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1057,6 +1057,14 @@ static struct scx_dispatch_q *find_user_dsq(u64 dsq_id)
 	return rhashtable_lookup_fast(&dsq_hash, &dsq_id, dsq_hash_params);
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
@@ -4653,8 +4661,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
-		const struct sched_class *new_class =
-			__setscheduler_class(p->policy, p->prio);
+		const struct sched_class *new_class = scx_setscheduler_class(p);
 		struct sched_enq_and_set_ctx ctx;
 
 		if (old_class != new_class && p->se.sched_delayed)
@@ -5368,8 +5375,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
-		const struct sched_class *new_class =
-			__setscheduler_class(p->policy, p->prio);
+		const struct sched_class *new_class = scx_setscheduler_class(p);
 		struct sched_enq_and_set_ctx ctx;
 
 		if (!tryget_task_struct(p))
-- 
2.51.0


