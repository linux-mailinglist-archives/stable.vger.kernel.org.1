Return-Path: <stable+bounces-233885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEnzBO9O1mm8DQgAu9opvQ
	(envelope-from <stable+bounces-233885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:49:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 685563BC627
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38B963004613
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EBA3B582F;
	Wed,  8 Apr 2026 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEqoyj1A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D7344DAB
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652463; cv=none; b=UYT+XZhjORg+yerTk+SIqHaqydy2bPHI8KAinTK/9dCqY5pO3d89ka2rr7iX3xB+nOOZLTjtq4W0RyBgUDkmsMV7oDyZIjH8MyCoEgu7WiOL/WM1mv9y5SbfQeJKM5WOAo9QsCoHpg+Y0sRCP0Swin4VVlLBgILJV1SdJfuN034=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652463; c=relaxed/simple;
	bh=hcS4ljt6SLSFdZeSLeiFPgvnx5rApdIML7zFHQ5wf6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hP+PDuO4pmAlBZEQySAATnwu16//X5d+yOV06hRiUm2jlzhew5J/0M8SEyCIGfXJrsD4SshA3t7L64QzLDOJDE86jJZTnBBRKsfsvZOglQx0BPdjDIZcFLXAhSHJx9rJRF0wOQQnG0xM31I9DXbYoxGm20tQmN1iIHAN+Obqnkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEqoyj1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E857AC19421;
	Wed,  8 Apr 2026 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775652463;
	bh=hcS4ljt6SLSFdZeSLeiFPgvnx5rApdIML7zFHQ5wf6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QEqoyj1Asf8qq2P6FoRXmwvpF/J5/pT2J01XlAfnrXtY9UJwyiUFqwuM9JtbWDViA
	 o4QkBDc2Lz+yvRV5mVGQWFo6MKBolb4L0IHprFMbY3vNecC+HJ4/jfEX1fz02fDSuE
	 vSHDhb6rMf6Emv2KuoAhq7x3KRV5OGHoKbmOzTPjAzscate5tLprAnSxLLwjAHuy+M
	 JEfpkp4x2EUGkUQYZ31IoTXfKwj6cQbPjjVlRa/SQasoljJLZ3a04hvoZ9TGXxHMwu
	 ptBHwZmQ8ht7V0sVMgtBHIZ+s92R/aj55y3xyLAUIxRmoujIPXVH+nJ0C8FkJayQ5L
	 vQ+bZQmzyGB1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] sched_ext: Refactor do_enqueue_task() local and global DSQ paths
Date: Wed,  8 Apr 2026 08:47:40 -0400
Message-ID: <20260408124741.1019690-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026040839-sprang-trembling-2810@gregkh>
References: <2026040839-sprang-trembling-2810@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233885-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,etsalapatis.com:email]
X-Rspamd-Queue-Id: 685563BC627
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 3546119f18647d7ddbba579737d8a222b430cb1c ]

The local and global DSQ enqueue paths in do_enqueue_task() share the same
slice refill logic. Factor out the common code into a shared enqueue label.
This makes adding new enqueue cases easier. No functional changes.

Reviewed-by: Andrea Righi <arighi@nvidia.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: 7e0ffb72de8a ("sched_ext: Fix stale direct dispatch state in ddsp_dsq_id")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index bf4bea3595cd0..083370667e521 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1243,6 +1243,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 {
 	struct scx_sched *sch = scx_root;
 	struct task_struct **ddsp_taskp;
+	struct scx_dispatch_q *dsq;
 	unsigned long qseq;
 
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_QUEUED));
@@ -1310,8 +1311,17 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 direct:
 	direct_dispatch(sch, p, enq_flags);
 	return;
-
+local_norefill:
+	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
+	return;
 local:
+	dsq = &rq->scx.local_dsq;
+	goto enqueue;
+global:
+	dsq = find_global_dsq(sch, p);
+	goto enqueue;
+
+enqueue:
 	/*
 	 * For task-ordering, slice refill must be treated as implying the end
 	 * of the current slice. Otherwise, the longer @p stays on the CPU, the
@@ -1319,14 +1329,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	 */
 	touch_core_sched(rq, p);
 	refill_task_slice_dfl(sch, p);
-local_norefill:
-	dispatch_enqueue(sch, &rq->scx.local_dsq, p, enq_flags);
-	return;
-
-global:
-	touch_core_sched(rq, p);	/* see the comment in local: */
-	refill_task_slice_dfl(sch, p);
-	dispatch_enqueue(sch, find_global_dsq(sch, p), p, enq_flags);
+	dispatch_enqueue(sch, dsq, p, enq_flags);
 }
 
 static bool task_runnable(const struct task_struct *p)
-- 
2.53.0


