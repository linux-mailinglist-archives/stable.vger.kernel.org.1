Return-Path: <stable+bounces-203499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF53CE68DF
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2174C30169AE
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 11:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B486B30C375;
	Mon, 29 Dec 2025 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qQ+WZA/Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3872F290B
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767008215; cv=none; b=sdRCqdVmEPcyz70pSzD4vgFwxbLsUdND/ZDz5eVSQvnjzSGlM1DC0eL0a5Lx/z3dmorC5ZV8qQqm59qsA6MQkr0UWeehXpcFuNZPsmd1bSvB7aqXRvwidtglMv1qzB5+VoFtPzRwmlqL8wfmZnclgLDLXiFGvhnbzPBjrJUX/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767008215; c=relaxed/simple;
	bh=Zu7ll8M1lf9B31ggRP5CHl7AxseWj7l8mQWGfVgD+V0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=opzoZx+2FIUTrJf/7TVYCAuKpnCErfiqADeeHLoalfAqUdn4icSgOSlHp8GTeGwjvkkOThufLYAFWA3TstDXZsBNuYZR33ONEDmYudcesdr2H5TB61SNdhNUwlYOGDoczDp6K8OBU1OjbkffGBnJ7sfioaFDIHUqy253TXSN4U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qQ+WZA/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607E7C4CEF7;
	Mon, 29 Dec 2025 11:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767008213;
	bh=Zu7ll8M1lf9B31ggRP5CHl7AxseWj7l8mQWGfVgD+V0=;
	h=Subject:To:Cc:From:Date:From;
	b=qQ+WZA/Yy8Zg9uxD2Q1PFCwYwPHecoNL1P6aomZUriRFtd6YAb1IT7pEmepwe5P+x
	 28RZqdTE16ZuoZ1q7CvfY3tUp6BV0Za1hOIFf0XAFHapSHp7oaBRb3WosTRSe9Z7w1
	 T8NxSiXcU/dOPB8bu/DYd0zjKJUgRVpuJMEkThWQ=
Subject: FAILED: patch "[PATCH] sched_ext: Fix missing post-enqueue handling in" failed to apply to 6.12-stable tree
To: tj@kernel.org,arighi@nvidia.com,emil@etsalapatis.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 12:36:51 +0100
Message-ID: <2025122951-giggle-reveler-2e6b@gregkh>
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
git cherry-pick -x f5e1e5ec204da11fa87fdf006d451d80ce06e118
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122951-giggle-reveler-2e6b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f5e1e5ec204da11fa87fdf006d451d80ce06e118 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 11 Dec 2025 15:45:04 -1000
Subject: [PATCH] sched_ext: Fix missing post-enqueue handling in
 move_local_task_to_local_dsq()

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


