Return-Path: <stable+bounces-205632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAE9CFA45B
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A523A340F7D8
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6806F2EC096;
	Tue,  6 Jan 2026 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ifKGd1cq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2488A2EA171;
	Tue,  6 Jan 2026 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721337; cv=none; b=GeTFhkDIndt1auRMbCZWdKZXPzv79KyyHFo4XrIz7KpNuutGHiC3xVu2wXpYH7BvCyINi9+q8qbrsoyKjKw47PYZs527D0aBgtcX/ennp3q1qa54LvwRQ2UhP+pA3aPyEYQJGpIw0gkXmeD9pn2lDBejELGWld0F5PKpHnC7xyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721337; c=relaxed/simple;
	bh=h4+cHfwvGOzaPawKeKElfo/DzAszG6Qq79vKK7bu2dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JX5B0fgAJ31lD2AdVLY6xwc8FkLE7MmtovLSzrPgHzpguTobLAd9S6gZImJjmpXqxLu3gC4MYwFyc2gZDHo6zv+vah3i2Jet+WZKDIBbsaiiTGMWT8MVSjYQgoFmT2DRx57Lc1HOQv2jbjlw85RabVNv8ZQ5nNDNjCbDcLJkY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ifKGd1cq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF4FC116C6;
	Tue,  6 Jan 2026 17:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767721337;
	bh=h4+cHfwvGOzaPawKeKElfo/DzAszG6Qq79vKK7bu2dY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifKGd1cq2HeMp2UaxlEzaeK5/rHLlh4qH6vzeYdufSEOFr+xfasyI3pYGI+YWbLJ7
	 dYxkDHKMU/XRe3ZAUATQyj6FGR9ieQmArxsHKhIqk2uUzrIFq0TIomWBJbANKncrh0
	 nEs6u5dYMwmPLmnU2U3+erMXaHHaFP3gyPfOs2NM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrea Righi <arighi@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 507/567] sched_ext: Fix missing post-enqueue handling in move_local_task_to_local_dsq()
Date: Tue,  6 Jan 2026 18:04:49 +0100
Message-ID: <20260106170510.128934956@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/ext.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1682,6 +1682,14 @@ static void local_dsq_post_enq(struct sc
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
@@ -2259,6 +2267,8 @@ static void move_local_task_to_local_dsq
 
 	dsq_mod_nr(dst_dsq, 1);
 	p->scx.dsq = dst_dsq;
+
+	local_dsq_post_enq(dst_dsq, p, enq_flags);
 }
 
 #ifdef CONFIG_SMP



