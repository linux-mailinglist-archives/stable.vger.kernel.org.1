Return-Path: <stable+bounces-241037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHjGAMHW62lISAAAu9opvQ
	(envelope-from <stable+bounces-241037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:46:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E32B4634CE
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54B123030D5F
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06F23FFAAC;
	Fri, 24 Apr 2026 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpsjU+Aq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F03FFAA3;
	Fri, 24 Apr 2026 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063469; cv=none; b=GAKMf6RWO+odqhLsW/D1LtS8/4K1rCZtlpH4HjS0qv3XpEezKxtqkEr+lyvU75qba1cdvgeZhOImy+msZwrtWY0pHPJhnetQxF/RAj0+0LbBH7mUh/4mCHiuaI+Hv1a87caLnr9QpzrjbF/tFQBtQ9ohxP791uphJXE78VG89to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063469; c=relaxed/simple;
	bh=3D++F8SwMXQMt8/VSFsPACkVpftH1C/s7DpBQaSIcyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gOZhBs64jc67eCt+V1RnxUkFjUx6f38hW4Syo2eOZmfTe03PRBu7i2jYaJY49lGSFQAoyedlcX5D4v9WmN4jBbNXBUTaInyaCqrwYXM0OPQdhxSz5jCWcj13AG3H4440Qj0wD0DmglzokJ4AXZfKYOEcbj/StqPeo9blxxLd2pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpsjU+Aq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30558C4AF0B;
	Fri, 24 Apr 2026 20:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063469;
	bh=3D++F8SwMXQMt8/VSFsPACkVpftH1C/s7DpBQaSIcyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UpsjU+Aq0cR+TkiPqmRuBSQVXARQfLfhYmE9KLEGkNlIM2yR8nke4OPJPYECBG3X2
	 8694tf0n5S4jKMR5Qb+iEB/CYrrct3zoyxnMrW74xhkMTMsRGO+SzETNsvWvO4YyFs
	 wITS40fRSKXWPrNTk1pBwLNLd4aQpG0fZqOn/xwi7My551AJLQ3sYmJCEg+bhUcY1V
	 8sJuA2NolroEJbiDEQuazaMYqxUH/mzvA/CuAt8H9u9RJhZcEEos7xENxqTMCL3GHY
	 NaapSa5ydzSZQwaqytyA3IEP7VhiSc899wuCe7BzO+L1ie5EJYrePGKcJoRK5NL5c/
	 0Ila12+3oPHhQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 09/13] sched_ext: Pass held rq to SCX_CALL_OP() for dump_cpu/dump_task
Date: Fri, 24 Apr 2026 10:44:14 -1000
Message-ID: <20260424204418.3809733-10-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424204418.3809733-1-tj@kernel.org>
References: <20260424204418.3809733-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8E32B4634CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241037-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

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
---
 kernel/sched/ext.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 608d5dc4c8bc..90008be04c7c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6096,9 +6096,8 @@ static void ops_dump_exit(void)
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
@@ -6139,7 +6138,7 @@ static void scx_dump_task(struct scx_sched *sch,
 
 	if (SCX_HAS_OP(sch, dump_task)) {
 		ops_dump_init(s, "    ");
-		SCX_CALL_OP(sch, dump_task, NULL, dctx, p);
+		SCX_CALL_OP(sch, dump_task, rq, dctx, p);
 		ops_dump_exit();
 	}
 
@@ -6263,8 +6262,7 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 		used = seq_buf_used(&ns);
 		if (SCX_HAS_OP(sch, dump_cpu)) {
 			ops_dump_init(&ns, "  ");
-			SCX_CALL_OP(sch, dump_cpu, NULL,
-				    &dctx, cpu, idle);
+			SCX_CALL_OP(sch, dump_cpu, rq, &dctx, cpu, idle);
 			ops_dump_exit();
 		}
 
@@ -6287,11 +6285,11 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 
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
-- 
2.53.0


