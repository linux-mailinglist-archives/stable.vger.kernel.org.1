Return-Path: <stable+bounces-204127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FC3CE80D0
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 20:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6164300EA2B
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 19:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68B5146588;
	Mon, 29 Dec 2025 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qA6veFvg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A684410F1
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767037002; cv=none; b=He3x+mcer/B9uBEKPeVofvEE8EIvQ5PSsfG/Eoe6aDTpAgo9PcyYlARl9NMbkGsLjhW2Q64KlVG4ougwuAbaSqrkQI/yMtUWnnssH7DETGiSCIudumalCnLog5j6zHDQ4GEG/g7nulWU9vIAp7GdbKdc2rbH+//m1fnon6sqA2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767037002; c=relaxed/simple;
	bh=GHlBXky5L/wi5wZG2kdJFSICthBsFfbAt4bVaJkNXqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGVZWF5Qj+uUswMP6xSt1kYGpWjX+zMr6PIMa+VfxowktCHHxKMe2DVS4ov7pnZ9R3f5dtxQO3+IMJNPlO7WdqWlc/t2ezKhItP16DfB8ge8Pbq/EZt5l9/6Aj9jXEd1DEHVbRNzKB/3l+mmMZRywmVMmkv3FUWSCR6+g9JbkCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qA6veFvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6757C4CEF7;
	Mon, 29 Dec 2025 19:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767037002;
	bh=GHlBXky5L/wi5wZG2kdJFSICthBsFfbAt4bVaJkNXqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qA6veFvgtty7fOZhoeQNrKJWJM2sFTFNChPA73uBFNEuTjwJfgaPYUcnuRGYywnxb
	 zUYRSza4iMPko6ETdFzjJ059gBAvblr88S042qItHj1tjHlheDTdn1c8v9cZwQgNE7
	 L5dDRqkP14iZ/trPIJsCO82s80koLJpq0OBA//RoR03zQ9XdNgCTxKnJUNzdIhu4sH
	 VbFXHWC5prs1Vsl9I9uWN4R2VX1lvqEcOHpt/G2DX3LdBDxug7Y50O3Ga8W2ChmAuw
	 jCjK7nyVN1V1pGrGJNdX/IxNlgboZ9PpJzHtllrXHAjO3XWVTeW31zYoeLYH10AXAX
	 ROsODrqHBi8Dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zqiang <qiang.zhang@linux.dev>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] sched_ext: Fix incorrect sched_class settings for per-cpu migration tasks
Date: Mon, 29 Dec 2025 14:36:40 -0500
Message-ID: <20251229193640.1641653-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122908-magician-unlaced-bef4@gregkh>
References: <2025122908-magician-unlaced-bef4@gregkh>
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
index 979484dab2d3..85fb518ed3e0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -203,6 +203,14 @@ static struct scx_dispatch_q *find_user_dsq(struct scx_sched *sch, u64 dsq_id)
 	return rhashtable_lookup_fast(&sch->dsq_hash, &dsq_id, dsq_hash_params);
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
@@ -3973,8 +3981,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
-		const struct sched_class *new_class =
-			__setscheduler_class(p->policy, p->prio);
+		const struct sched_class *new_class = scx_setscheduler_class(p);
 		struct sched_enq_and_set_ctx ctx;
 
 		if (old_class != new_class && p->se.sched_delayed)
@@ -4752,8 +4759,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
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


