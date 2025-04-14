Return-Path: <stable+bounces-132547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 570ABA88354
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036003B69BB
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4806929E073;
	Mon, 14 Apr 2025 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPtBqQgN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BEB29E069;
	Mon, 14 Apr 2025 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637385; cv=none; b=e+u4Vuo5Yp/riuwBxFucR8O3Pi1NfodLgal30rvhho8luztRX7AOM9GqbF1u7HSQ+HaL/yF1n0gG4P1X4cqKaq/h5BFit5cH/w8Gq7VPC+kIuaa0DGjDKXZMjINfElI6tett3/1c/+nZTPRT7Cd5dQrYN99FpNSx5mfiV4OP/mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637385; c=relaxed/simple;
	bh=DDLp9F3hw0/j5DNaV3tFyRMhvyjy0IKOIaq0JQaile8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s1Nu1kTxKVJw/O/L/CQdQU/gdDWROxP2t0IM1dyt6i7wctI1J25e5mCjy9wHRjhzYK9kDYsRGCF0j/4+AUMpfuEpb8cczZHN5HcllBW+V5qVBZeb6qQvdBenY9n+ZOJZyio1QVuDb5alCQ8RR7qK/tjnAtP+6iXLwdLTGsGItSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPtBqQgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39998C4CEE9;
	Mon, 14 Apr 2025 13:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637384;
	bh=DDLp9F3hw0/j5DNaV3tFyRMhvyjy0IKOIaq0JQaile8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPtBqQgNUpuhqJW4Z1zBQHKuU6NXJGmH+tkDm5LjpRM13T6RBw8BkNAwVabmfNWEl
	 yqcB0hAIR1Mwcuq3+LA5POzBRBcz1mV/dsRdKh4y+NongAXj/ZK9CSjTN22BZ+okSk
	 DhRc9lR6jB9/47eVKA7mOt5wYq4l4ed2QlmyTPQ40fXTamc1Mox3fewnKNyGUPL4/a
	 y4RwSw5u3ALxortLVnhWLhuj/5BTqbPD8onwWUF2o78J2dNL+/GRh4XvH7zsUodr7T
	 EQCsGlKDCYBsxmj3ablEiqymxgagOj2FCkOrJrIyvpxzSASnLOACHI369oqpzOeGA2
	 uhFHdq+OsuuNw==
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
Subject: [PATCH AUTOSEL 6.12 24/30] net_sched: sch_sfq: use a temporary work area for validating configuration
Date: Mon, 14 Apr 2025 09:28:41 -0400
Message-Id: <20250414132848.679855-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132848.679855-1-sashal@kernel.org>
References: <20250414132848.679855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.23
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
index 65d5b59da5830..7714ae94e0521 100644
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


