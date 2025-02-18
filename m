Return-Path: <stable+bounces-116761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35918A39C53
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 13:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12C6176D56
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7DC246351;
	Tue, 18 Feb 2025 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rlz+SVnX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B9243368
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881985; cv=none; b=pbLLDt9gbSkoFmgN/0qBF3TJZhB79ttwaW7bFi7p2WQIX4ev4cwAujvXxG9A+MGPV3oO2LMQL4bXANHDL01OaAQkLJkQr+AfHCXGzqSJNLxAq2MDAjGdyW0tMTfPXA+3TyyckHukXgEKCMxBm/PuHQuBPK+0w/kPCrDYZ6cSJYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881985; c=relaxed/simple;
	bh=25wZXQG8Fwrma92IiXlCh4gCOtxHNjWRR/4zZ/gQ99A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iZeagj4cn62unyjzEEeGFf16/17DpHc3v6D8ZcgJ/aXOzJS8177wrnsa2NAw0hzcqj6zeXvAG+CxmAaZl9PE2pKeK4h7AcXt1BZO0NJz1sOFiLDUPeRSHMHEIEHLXr2R0UNZIZl2gh4VVJQ7Tu/anojSPPET1zd2mnUqNMZHCqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rlz+SVnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB000C4CEE2;
	Tue, 18 Feb 2025 12:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739881985;
	bh=25wZXQG8Fwrma92IiXlCh4gCOtxHNjWRR/4zZ/gQ99A=;
	h=Subject:To:Cc:From:Date:From;
	b=rlz+SVnXHE0VLv04kVHi1I9op5WteRHsOFEIR6zNbxcQnKv5bgaxPR3kgal1R7XEg
	 tTgszTcEuNf44DxtC3CPm81lQxyq4yhI50e06hJlt+sQIGuQdWjU9vAAOwQbmdXRPe
	 LEz/cSqe2seWLJN8buDs9vGIC2ELABBjTOZAc9II=
Subject: FAILED: patch "[PATCH] sched_ext: Fix migration disabled handling in targeted" failed to apply to 6.12-stable tree
To: tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 13:33:02 +0100
Message-ID: <2025021801-myself-cane-67bf@gregkh>
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
git cherry-pick -x 32966821574cd2917bd60f2554f435fe527f4702
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021801-myself-cane-67bf@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 32966821574cd2917bd60f2554f435fe527f4702 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 7 Feb 2025 10:59:06 -1000
Subject: [PATCH] sched_ext: Fix migration disabled handling in targeted
 dispatches

A dispatch operation that can target a specific local DSQ -
scx_bpf_dsq_move_to_local() or scx_bpf_dsq_move() - checks whether the task
can be migrated to the target CPU using task_can_run_on_remote_rq(). If the
task can't be migrated to the targeted CPU, it is bounced through a global
DSQ.

task_can_run_on_remote_rq() assumes that the task is on a CPU that's
different from the targeted CPU but the callers doesn't uphold the
assumption and may call the function when the task is already on the target
CPU. When such task has migration disabled, task_can_run_on_remote_rq() ends
up returning %false incorrectly unnecessarily bouncing the task to a global
DSQ.

Fix it by updating the callers to only call task_can_run_on_remote_rq() when
the task is on a different CPU than the target CPU. As this is a bit subtle,
for clarity and documentation:

- Make task_can_run_on_remote_rq() trigger SCHED_WARN_ON() if the task is on
  the same CPU as the target CPU.

- is_migration_disabled() test in task_can_run_on_remote_rq() cannot trigger
  if the task is on a different CPU than the target CPU as the preceding
  task_allowed_on_cpu() test should fail beforehand. Convert the test into
  SCHED_WARN_ON().

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()")
Fixes: 0366017e0973 ("sched_ext: Use task_can_run_on_remote_rq() test in dispatch_to_local_dsq()")
Cc: stable@vger.kernel.org # v6.12+

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index efdbf4d85a21..e01144340d67 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2333,12 +2333,16 @@ static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
  *
  * - The BPF scheduler is bypassed while the rq is offline and we can always say
  *   no to the BPF scheduler initiated migrations while offline.
+ *
+ * The caller must ensure that @p and @rq are on different CPUs.
  */
 static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq,
 				      bool trigger_error)
 {
 	int cpu = cpu_of(rq);
 
+	SCHED_WARN_ON(task_cpu(p) == cpu);
+
 	/*
 	 * We don't require the BPF scheduler to avoid dispatching to offline
 	 * CPUs mostly for convenience but also because CPUs can go offline
@@ -2352,8 +2356,11 @@ static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq,
 		return false;
 	}
 
-	if (unlikely(is_migration_disabled(p)))
-		return false;
+	/*
+	 * If @p has migration disabled, @p->cpus_ptr only contains its current
+	 * CPU and the above task_allowed_on_cpu() test should have failed.
+	 */
+	SCHED_WARN_ON(is_migration_disabled(p));
 
 	if (!scx_rq_online(rq))
 		return false;
@@ -2457,7 +2464,8 @@ static struct rq *move_task_between_dsqs(struct task_struct *p, u64 enq_flags,
 
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
-		if (!task_can_run_on_remote_rq(p, dst_rq, true)) {
+		if (src_rq != dst_rq &&
+		    unlikely(!task_can_run_on_remote_rq(p, dst_rq, true))) {
 			dst_dsq = find_global_dsq(p);
 			dst_rq = src_rq;
 		}
@@ -2611,7 +2619,8 @@ static void dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
 	}
 
 #ifdef CONFIG_SMP
-	if (unlikely(!task_can_run_on_remote_rq(p, dst_rq, true))) {
+	if (src_rq != dst_rq &&
+	    unlikely(!task_can_run_on_remote_rq(p, dst_rq, true))) {
 		dispatch_enqueue(find_global_dsq(p), p,
 				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;


