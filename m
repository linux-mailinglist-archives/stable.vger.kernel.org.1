Return-Path: <stable+bounces-108486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D4EA0C016
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2D316A420
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1BE1F9F69;
	Mon, 13 Jan 2025 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ew6Und3C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C401F9F5B;
	Mon, 13 Jan 2025 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793306; cv=none; b=lQXIaGifiy3qKOjbCxS2me5vBCanLmw8gvE6c2/VcgHUSkrhOP02wzft1YWri5AuRc9Qe6Fs2TRaAqPP3E7+NslwXgBRhOiTxe+gcVJeihrNySFXygPcPbZ1IB2LFb5W06CupxeiUuGPtn+OEIzTuojg5Y2pczjPEQ4AzQxGv3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793306; c=relaxed/simple;
	bh=oCs/GBdCg29DHR59+pTCj8OWhkpbOT7d3Ht7oLrBVHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dfCIT/mdXQY2AHcgi8W6ZhudkWeYm7gy3TSsH7EgZjQ8sqK1xIjrUpV0HU2ccEUvglaMdvDMruh7ffLD8aongPTNu8ONW6/Xb7vSNVE27jNhsXMYzhMzx8hq24bHqkrKJ2LgZ6frp+UGYorZgcPnnOrR3duHx0iImBp4DH/Mj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ew6Und3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B55C4CEE5;
	Mon, 13 Jan 2025 18:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793305;
	bh=oCs/GBdCg29DHR59+pTCj8OWhkpbOT7d3Ht7oLrBVHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ew6Und3CPK/982QseOTJJxhwDif40BoHugrOrCF48GZ04x9ga8zsLwuC+uYzV0PLf
	 wAfwlkoh/UgHnkxcZst8Xy7dbV9JMDfltw4bFiVvj9dvKPXP9mC//UaMsQZhWsEaOS
	 9SCRaLgp0e7oShrXT3o8UxCn4GAbISD7W49Xfd8zFXVS4EoKW8lSx5GAJX4eHSadje
	 OuvjOQBQMmzUds+pMt3GfPzjJX8tkXbUxlGFSZyEaST7lNPI3vX2WxQ7GDFHd8elw/
	 zFN1V8/pDZFWbKzal9meDe8de+8ufiTMcEbkkPM3p/POUrmpKEoKr4JZnmSU+MAu3b
	 L7rjobn5W73mg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Henry Huang <henry.hj@antgroup.com>,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Subject: [PATCH AUTOSEL 6.12 17/20] sched_ext: keep running prev when prev->scx.slice != 0
Date: Mon, 13 Jan 2025 13:34:22 -0500
Message-Id: <20250113183425.1783715-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183425.1783715-1-sashal@kernel.org>
References: <20250113183425.1783715-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.9
Content-Transfer-Encoding: 8bit

From: Henry Huang <henry.hj@antgroup.com>

[ Upstream commit 30dd3b13f9de612ef7328ccffcf1a07d0d40ab51 ]

When %SCX_OPS_ENQ_LAST is set and prev->scx.slice != 0,
@prev will be dispacthed into the local DSQ in put_prev_task_scx().
However, pick_task_scx() is executed before put_prev_task_scx(),
so it will not pick @prev.
Set %SCX_RQ_BAL_KEEP in balance_one() to ensure that pick_task_scx()
can pick @prev.

Signed-off-by: Henry Huang <henry.hj@antgroup.com>
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 40f915f893e2..7e217761854b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2630,6 +2630,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	bool prev_on_scx = prev->sched_class == &ext_sched_class;
+	bool prev_on_rq = prev->scx.flags & SCX_TASK_QUEUED;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
 
 	lockdep_assert_rq_held(rq);
@@ -2662,8 +2663,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * See scx_ops_disable_workfn() for the explanation on the
 		 * bypassing test.
 		 */
-		if ((prev->scx.flags & SCX_TASK_QUEUED) &&
-		    prev->scx.slice && !scx_rq_bypassing(rq)) {
+		if (prev_on_rq && prev->scx.slice && !scx_rq_bypassing(rq)) {
 			rq->scx.flags |= SCX_RQ_BAL_KEEP;
 			goto has_tasks;
 		}
@@ -2696,6 +2696,10 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 
 		flush_dispatch_buf(rq);
 
+		if (prev_on_rq && prev->scx.slice) {
+			rq->scx.flags |= SCX_RQ_BAL_KEEP;
+			goto has_tasks;
+		}
 		if (rq->scx.local_dsq.nr)
 			goto has_tasks;
 		if (consume_global_dsq(rq))
@@ -2721,8 +2725,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	 * Didn't find another task to run. Keep running @prev unless
 	 * %SCX_OPS_ENQ_LAST is in effect.
 	 */
-	if ((prev->scx.flags & SCX_TASK_QUEUED) &&
-	    (!static_branch_unlikely(&scx_ops_enq_last) ||
+	if (prev_on_rq && (!static_branch_unlikely(&scx_ops_enq_last) ||
 	     scx_rq_bypassing(rq))) {
 		rq->scx.flags |= SCX_RQ_BAL_KEEP;
 		goto has_tasks;
-- 
2.39.5


