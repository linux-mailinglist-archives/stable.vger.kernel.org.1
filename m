Return-Path: <stable+bounces-204423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD06CED9A0
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 03:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DAF23006A51
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 02:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8437175D53;
	Fri,  2 Jan 2026 02:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMDj0PA8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0A11C28E
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 02:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767319281; cv=none; b=VaQTqm42O55lYMfWQ4Pk7+Mcxu3p84KjxONplxsJsfVLunAkSXVEwOVX3HpKC5AQ23tcnjHcrmDza/Bk2x4BXGDzbRmY9djVpjJCFI83g8wovipimX+NjRsKJbh7IFCvvkKXKRFkWketK6DRpLuH1Nq1XOv3JlV1Q8IxdsJNmLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767319281; c=relaxed/simple;
	bh=61QqOZGZdpvVc4Pp2qf5aXO66MtvW/7sCwSwi94HSgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMhHRYqSLbNxlDNkA9evLAzf7wlhVWagF5eK7r4GP8akmQsv/ZiqIlWILqwZZpjnE2PsjvmhCrTYYWAzeuYf8nfsWYK903SbyUucXYtjzArc8JWK5aMaqceT+9sZK4py9eHRyAJdoEGnvC1E0X25m6yakVy0Nc0WTj6aKITzhkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMDj0PA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F63FC19421;
	Fri,  2 Jan 2026 02:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767319280;
	bh=61QqOZGZdpvVc4Pp2qf5aXO66MtvW/7sCwSwi94HSgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tMDj0PA8hdP2wdjJVr6mo5DAtXa4T9AOMSBuz8oyQgSHzloiIi/fse3QFrd2EaIbY
	 5Sf7/W50K011VUOqcn+JcGZY91QiqvyIeJmgNCSF8FY5gQo5WnHRw+ozPK59oqxHuU
	 cAERCS1HlZeK4fkxW7BRRQDn4no86mkEW2yp/9d4BDN2020WG4gNGsbm7S8d//XKNe
	 PzmU+XKzq+xO4rIg1F71mhJRwkgBsCzOcws9zE4Ef0z8fAqJ6YJqVSBFfNUcowJS4J
	 s96/Q5R+WdZdju+lwez9G09hKTBBObbrCdZwuFxDU6Zhzggf+uTtBz1cPtmcTQI80S
	 iQ1x2Ebn+M7pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] sched_ext: Fix missing post-enqueue handling in move_local_task_to_local_dsq()
Date: Thu,  1 Jan 2026 21:01:17 -0500
Message-ID: <20260102020117.100465-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260102020117.100465-1-sashal@kernel.org>
References: <2025122951-giggle-reveler-2e6b@gregkh>
 <20260102020117.100465-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit f5e1e5ec204da11fa87fdf006d451d80ce06e118 ]

move_local_task_to_local_dsq() is used when moving a task from a non-local
DSQ to a local DSQ on the same CPU. It directly manipulates the local DSQ
without going through dispatch_enqueue() and was missing the post-enqueue
handling that triggers preemption when SCX_ENQ_PREEMPT is set or the idle
task is running.

The function is used by move_task_between_dsqs() which backs
scx_bpf_dsq_move() and may be called while the CPU is busy.

Add local_dsq_post_enq() call to move_local_task_to_local_dsq(). As the
dispatch path doesn't need post-enqueue handling, add SCX_RQ_IN_BALANCE
early exit to keep consume_dispatch_q() behavior unchanged and avoid
triggering unnecessary resched when scx_bpf_dsq_move() is used from the
dispatch path.

Fixes: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()")
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 54e194d08d92..a7a6478fe4b8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1674,6 +1674,14 @@ static void local_dsq_post_enq(struct scx_dispatch_q *dsq, struct task_struct *p
 	struct rq *rq = container_of(dsq, struct rq, scx.local_dsq);
 	bool preempt = false;
 
+	/*
+	 * If @rq is in balance, the CPU is already vacant and looking for the
+	 * next task to run. No need to preempt or trigger resched after moving
+	 * @p into its local DSQ.
+	 */
+	if (rq->scx.flags & SCX_RQ_IN_BALANCE)
+		return;
+
 	if ((enq_flags & SCX_ENQ_PREEMPT) && p != rq->curr &&
 	    rq->curr->sched_class == &ext_sched_class) {
 		rq->curr->scx.slice = 0;
@@ -2251,6 +2259,8 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 
 	dsq_mod_nr(dst_dsq, 1);
 	p->scx.dsq = dst_dsq;
+
+	local_dsq_post_enq(dst_dsq, p, enq_flags);
 }
 
 #ifdef CONFIG_SMP
-- 
2.51.0


