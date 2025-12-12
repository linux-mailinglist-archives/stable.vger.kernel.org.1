Return-Path: <stable+bounces-200832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D79CB791B
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 02:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 179A33043549
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 01:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC6D22B8CB;
	Fri, 12 Dec 2025 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX66Lzvg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2F51CDFCA;
	Fri, 12 Dec 2025 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765503908; cv=none; b=dNGE3E1h51ivYzO9DVcKfMQuU5pzBJz4Qw5w+2nIb47YJ6lX832EiPAbYTVy+TJjpq/0iXLcodcAaI/aB9PqiycPDftY98DmJr/bzUV9syMxDPdYCARCODKHuaQJMaA36dKESI00IpiSVniXpg0lKHi2uVs8hZliII83o2f19hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765503908; c=relaxed/simple;
	bh=LkKCUbsI960+ONJDHq8t++u5huE72Wv83fqaU8Re8S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JT9T2A/ZJSAV/J2pBKLxlcIXobW7ge3k+5KBwM/aESuIqa2jiXw0RP601QL/9ctjX2J/iqcTRNVdEvWRm/ujb9O/EDt3R3Ok/VGNg6aJJWYZ9dhMhj+vR75Bt1xGx5kqHsJRac2B1LxCkEgLt5mL2Zt98MpV/75dPG58G90AKzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UX66Lzvg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F7EC16AAE;
	Fri, 12 Dec 2025 01:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765503907;
	bh=LkKCUbsI960+ONJDHq8t++u5huE72Wv83fqaU8Re8S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UX66LzvgrYzkeXzN215fJ9d4xFOKNqZrGiDYe4BoJ1aPtyJ8tdadoVzBxSVneOQkX
	 w6do5gScJrPMnGV81tXqs7vXDmSVqBQmUZAfUyO5ue3BREKiKZkttYd2seB0qQOXzu
	 vgAdu0k5/oUyfN7n+GLwZbqmfDTCNcL2O3ER//4NbCvbnmM0jVk6a+ZJ2UlNtLdfH5
	 x85rfWvYvrNrHoymUW/4Zbly4yzAOya+l92q9gcCcDBOvMXHXyBcp28iz3Izl+vHjg
	 nbVOMgdHn67rc9o2P2OgO/iYyta41v9ajA+819LIis4944HAKfuPWIiFYhq06l5aBO
	 kuHHhFPXQN5rg==
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/2] sched_ext: Fix missing post-enqueue handling in move_local_task_to_local_dsq()
Date: Thu, 11 Dec 2025 15:45:04 -1000
Message-ID: <20251212014504.3431169-3-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251212014504.3431169-1-tj@kernel.org>
References: <20251211224809.3383633-1-tj@kernel.org>
 <20251212014504.3431169-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c78efa99406f..695503a2f7d1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -988,6 +988,14 @@ static void local_dsq_post_enq(struct scx_dispatch_q *dsq, struct task_struct *p
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
@@ -1636,6 +1644,8 @@ static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 
 	dsq_mod_nr(dst_dsq, 1);
 	p->scx.dsq = dst_dsq;
+
+	local_dsq_post_enq(dst_dsq, p, enq_flags);
 }
 
 /**
-- 
2.52.0


