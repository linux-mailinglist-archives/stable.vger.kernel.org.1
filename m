Return-Path: <stable+bounces-132594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9039A883B1
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FF51889F5B
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5642D8DCF;
	Mon, 14 Apr 2025 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3/YpGYr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D832D8DC2;
	Mon, 14 Apr 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637483; cv=none; b=RBpIul+e+LwlL14/frYtYh8wteHYjZ96SFa54HYuLpDVCWgqfYPrN6/RstJ9R7rzDnZGweUCWxA7mlOZST84cDWk+gD9ar+Rf5G3Fs4fW2brLp9t/nDqp2b0Xf4tuJTjf1Jnk7N/iH47AaOixoiwppXMNHSKAws5puYYBrpAggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637483; c=relaxed/simple;
	bh=o2c4G+9qIpNKNZ43uZzD8sLLfeF+E5ue+/gTgXkOlUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M84gNSeSFAMptCEz6l8H7KkVoYeKpDz0cyphuB2ujYrRR3KHth0MiQuFChS0u2iArKyAdUUaf4uqLAmbOoAp8Du2y9QrOxHuond7MCeHwA1qkNwlxKPR82XNnWMtl+DycwGRAIJVEo+TRe/kms0NGMRSeV9X4tJwC8S+rNf3kjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3/YpGYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F6CC4CEE2;
	Mon, 14 Apr 2025 13:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637483;
	bh=o2c4G+9qIpNKNZ43uZzD8sLLfeF+E5ue+/gTgXkOlUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3/YpGYrAKduy0MNaNbkB73uEi/IRMhZK5Omtjud9UmD8aC0Ktyuh9AunR4TbWzX+
	 06FRhZa28skzcZmeHa7PHE3DEjkMG2BQlAVFvfj0PYyh2dk1uLCytuzOLoWdzHPOtw
	 mo3vpbS63W6/JXOUdvgzen7UAnGFvmGT3I4DwZhUZt6vmEyf36ExV8sRbFFqDzrZXV
	 slT7VjXp4xurpZC5BVTt1tkYgzJ6WPVS29GwfelR1EXIQgu12HR306mLg9IOGxxbuh
	 mk/JipIhLxjVKjfUhb8IJSNeA+flk3Rfob/MY0/Y+lQClWQZAmvrOvGtMY1+pTNMOb
	 g0zNLxIji0yQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Octavian Purdila <tavip@google.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/17] net_sched: sch_sfq: use a temporary work area for validating configuration
Date: Mon, 14 Apr 2025 09:30:47 -0400
Message-Id: <20250414133048.680608-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133048.680608-1-sashal@kernel.org>
References: <20250414133048.680608-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
Content-Transfer-Encoding: 8bit

From: Octavian Purdila <tavip@google.com>

[ Upstream commit 8c0cea59d40cf6dd13c2950437631dd614fbade6 ]

Many configuration parameters have influence on others (e.g. divisor
-> flows -> limit, depth -> limit) and so it is difficult to correctly
do all of the validation before applying the configuration. And if a
validation error is detected late it is difficult to roll back a
partially applied configuration.

To avoid these issues use a temporary work area to update and validate
the configuration and only then apply the configuration to the
internal state.

Signed-off-by: Octavian Purdila <tavip@google.com>
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_sfq.c | 56 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 60754f366ab7b..68e909e8fabd9 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -631,6 +631,15 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 	struct red_parms *p = NULL;
 	struct sk_buff *to_free = NULL;
 	struct sk_buff *tail = NULL;
+	unsigned int maxflows;
+	unsigned int quantum;
+	unsigned int divisor;
+	int perturb_period;
+	u8 headdrop;
+	u8 maxdepth;
+	int limit;
+	u8 flags;
+
 
 	if (opt->nla_len < nla_attr_size(sizeof(*ctl)))
 		return -EINVAL;
@@ -656,36 +665,59 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
 		return -EINVAL;
 	}
+
 	sch_tree_lock(sch);
+
+	limit = q->limit;
+	divisor = q->divisor;
+	headdrop = q->headdrop;
+	maxdepth = q->maxdepth;
+	maxflows = q->maxflows;
+	perturb_period = q->perturb_period;
+	quantum = q->quantum;
+	flags = q->flags;
+
+	/* update and validate configuration */
 	if (ctl->quantum)
-		q->quantum = ctl->quantum;
-	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
+		quantum = ctl->quantum;
+	perturb_period = ctl->perturb_period * HZ;
 	if (ctl->flows)
-		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
+		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
-		q->divisor = ctl->divisor;
-		q->maxflows = min_t(u32, q->maxflows, q->divisor);
+		divisor = ctl->divisor;
+		maxflows = min_t(u32, maxflows, divisor);
 	}
 	if (ctl_v1) {
 		if (ctl_v1->depth)
-			q->maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
+			maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
 		if (p) {
-			swap(q->red_parms, p);
-			red_set_parms(q->red_parms,
+			red_set_parms(p,
 				      ctl_v1->qth_min, ctl_v1->qth_max,
 				      ctl_v1->Wlog,
 				      ctl_v1->Plog, ctl_v1->Scell_log,
 				      NULL,
 				      ctl_v1->max_P);
 		}
-		q->flags = ctl_v1->flags;
-		q->headdrop = ctl_v1->headdrop;
+		flags = ctl_v1->flags;
+		headdrop = ctl_v1->headdrop;
 	}
 	if (ctl->limit) {
-		q->limit = min_t(u32, ctl->limit, q->maxdepth * q->maxflows);
-		q->maxflows = min_t(u32, q->maxflows, q->limit);
+		limit = min_t(u32, ctl->limit, maxdepth * maxflows);
+		maxflows = min_t(u32, maxflows, limit);
 	}
 
+	/* commit configuration */
+	q->limit = limit;
+	q->divisor = divisor;
+	q->headdrop = headdrop;
+	q->maxdepth = maxdepth;
+	q->maxflows = maxflows;
+	WRITE_ONCE(q->perturb_period, perturb_period);
+	q->quantum = quantum;
+	q->flags = flags;
+	if (p)
+		swap(q->red_parms, p);
+
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > q->limit) {
 		dropped += sfq_drop(sch, &to_free);
-- 
2.39.5


