Return-Path: <stable+bounces-245718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ2iG2o+A2qr2AEAu9opvQ
	(envelope-from <stable+bounces-245718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:51:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E10522F4E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9F8A30C3748
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD8B3B2D2A;
	Tue, 12 May 2026 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nxKFaj7o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FB33B2D23
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595529; cv=none; b=vGdV+CqpDpl74xxC+mIfvhGaKFHmmlR8LBsjbOKs4lQnEhvzOvlmALmevOMCcVO+j2KHjiOXgvrPbsWzRMif42fWeOZ0DUkj45FhLpcKRecNvM6nBDehWFmBIC6uPO2L6C6gI1eSCjgWmOqJ8tGKgt0sGLJeG/fwvhLr5WGOy+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595529; c=relaxed/simple;
	bh=Ju4jT0lNMn/Bkm9nCowCyosL/5of+lK3OoigCJXfW+4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LakSVFX2hyCKIgxAAyVhifQCCa6UqDodXnfi00uXccTHvox6DZQnQNhuG5Khnlls5gepBV+MX6H5zwO7y/o2bnv3CBSmB0sUdP/JhpZSYA+3R41Xbg8p9qELHUIJXO8N4kR2yvKDflWDIfKwQPWyJ5ng90VwgAIt/rNjJYS0VUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nxKFaj7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380CAC2BCFA;
	Tue, 12 May 2026 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595528;
	bh=Ju4jT0lNMn/Bkm9nCowCyosL/5of+lK3OoigCJXfW+4=;
	h=Subject:To:Cc:From:Date:From;
	b=nxKFaj7ogfn5Tc4L4UhqlLdd27VVeW4tD8lf5a8wXQoVn4hXMQcw5NDVHWczm17WA
	 m+ulMTFuBdQSPy2lw4HOXHFIqgkcjpXvIn+cs2xjATBekJuHMqzGlnFt+ReCuhOsQw
	 IVA7t9tg8Ahxta7pT7Q34Hk9oIv0dpQL9ZomOqCI=
Subject: FAILED: patch "[PATCH] sched_ext: Pass held rq to SCX_CALL_OP() for" failed to apply to 6.18-stable tree
To: tj@kernel.org,arighi@nvidia.com,clm@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:18:23 +0200
Message-ID: <2026051223-catfight-unfounded-5cda@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 74E10522F4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245718-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,nvidia.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 207d76a372fb1bb324eadc8cb5bcaa0a8da7cefd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051223-catfight-unfounded-5cda@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 207d76a372fb1bb324eadc8cb5bcaa0a8da7cefd Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 24 Apr 2026 14:31:36 -1000
Subject: [PATCH] sched_ext: Pass held rq to SCX_CALL_OP() for
 dump_cpu/dump_task

scx_dump_state() walks CPUs with rq_lock_irqsave() held and invokes
ops.dump_cpu / ops.dump_task with NULL locked_rq, leaving
scx_locked_rq_state NULL. If the BPF callback calls a kfunc that
re-acquires rq based on scx_locked_rq() - e.g. scx_bpf_cpuperf_set(cpu)
- it re-acquires the already-held rq.

Pass the held rq to SCX_CALL_OP(). Thread it into scx_dump_task() too.
The pre-loop ops.dump call runs before rq_lock_irqsave() so keeps
rq=NULL.

Fixes: 07814a9439a3 ("sched_ext: Print debug dump after an error exit")
Cc: stable@vger.kernel.org # v6.12+
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 26968d0a6752..73d629559d6d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6117,9 +6117,8 @@ static void ops_dump_exit(void)
 	scx_dump_data.cpu = -1;
 }
 
-static void scx_dump_task(struct scx_sched *sch,
-			  struct seq_buf *s, struct scx_dump_ctx *dctx,
-			  struct task_struct *p, char marker)
+static void scx_dump_task(struct scx_sched *sch, struct seq_buf *s, struct scx_dump_ctx *dctx,
+			  struct rq *rq, struct task_struct *p, char marker)
 {
 	static unsigned long bt[SCX_EXIT_BT_LEN];
 	struct scx_sched *task_sch = scx_task_sched(p);
@@ -6160,7 +6159,7 @@ static void scx_dump_task(struct scx_sched *sch,
 
 	if (SCX_HAS_OP(sch, dump_task)) {
 		ops_dump_init(s, "    ");
-		SCX_CALL_OP(sch, dump_task, NULL, dctx, p);
+		SCX_CALL_OP(sch, dump_task, rq, dctx, p);
 		ops_dump_exit();
 	}
 
@@ -6284,8 +6283,7 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 		used = seq_buf_used(&ns);
 		if (SCX_HAS_OP(sch, dump_cpu)) {
 			ops_dump_init(&ns, "  ");
-			SCX_CALL_OP(sch, dump_cpu, NULL,
-				    &dctx, cpu, idle);
+			SCX_CALL_OP(sch, dump_cpu, rq, &dctx, cpu, idle);
 			ops_dump_exit();
 		}
 
@@ -6308,11 +6306,11 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 
 		if (rq->curr->sched_class == &ext_sched_class &&
 		    (dump_all_tasks || scx_task_on_sched(sch, rq->curr)))
-			scx_dump_task(sch, &s, &dctx, rq->curr, '*');
+			scx_dump_task(sch, &s, &dctx, rq, rq->curr, '*');
 
 		list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
 			if (dump_all_tasks || scx_task_on_sched(sch, p))
-				scx_dump_task(sch, &s, &dctx, p, ' ');
+				scx_dump_task(sch, &s, &dctx, rq, p, ' ');
 	next:
 		rq_unlock_irqrestore(rq, &rf);
 	}


