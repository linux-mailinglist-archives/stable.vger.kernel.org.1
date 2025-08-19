Return-Path: <stable+bounces-171801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFA7B2C717
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 16:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87695E48F8
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE46D27586C;
	Tue, 19 Aug 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC3Sm6rO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E77D275854
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613977; cv=none; b=E6fHno06vC7fTxI1sO+uJK8fdpSM0Nm6biL9bE8O5/D+X6TJVeu4OwT1b6b17OXZpl2LlWUrUHP+hiG/ku73pTd8wicHkKz9nOp/YJxcQdjzmpHntfsxvOfSoE4JB4eJuDSkUARCmfuZMG442ijJxwnN5fXpMHf5mC7bWdeaWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613977; c=relaxed/simple;
	bh=wabELlro73BktZFYggkIhRJOCUMqohAmfmbKtER3njs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOBbaQj7fYnCGFyjp2FuGO8935hAuO56mCYj0pAH9h6q61si88cR5FY897UE/tS2coCQ7I6ma6+k7lSKMjvhS59A0dso6XljIAfFJZQLgn3aH/V5eL1Hhueg2B0VW6aoDsZaoI1dsl0mONNg7BFCAmJg2xDwtAfgMNMmtGxlOc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC3Sm6rO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6C3C113D0;
	Tue, 19 Aug 2025 14:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755613977;
	bh=wabELlro73BktZFYggkIhRJOCUMqohAmfmbKtER3njs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SC3Sm6rOj9Co6XN8MojJAkD/AbIUzwHSSr3XLAI/RnANxsM9k1O/M+kbs/iMUhTYd
	 RTuPykDDVUsUcwKvrzWNM9R1pAT9jbJr2W00UQ6fTbrYfUD0zdrz/0ym2nQYA6AQmE
	 TKlGI47LaylWRuFxHSijmnLgMAJ42ZElfm4GKgnvnJTH0Isai+KkOnyJuYSgolTGwd
	 YXO5EG+H1DhIdUoR7+iu9XxTx888Gf6q0aDF1JleeMpkKPoPopH4+AhwN/QSVoqicj
	 qjslFji6wRM0BTt+RwWHF3GqEfRTNjXizihqUHts+b6AU7hZcZGyd43T+/pE/j8LN5
	 guPhtwDjsHK3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] net_sched: sch_ets: implement lockless ets_dump()
Date: Tue, 19 Aug 2025 10:32:52 -0400
Message-ID: <20250819143253.512050-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819143253.512050-1-sashal@kernel.org>
References: <2025081858-blurred-unlinked-7eae@gregkh>
 <20250819143253.512050-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit c5f1dde7f731e7bf2e7c169ca42cb4989fc2f8b9 ]

Instead of relying on RTNL, ets_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in ets_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 87c6efc5ce9c ("net/sched: ets: use old 'nbands' while purging unused classes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_ets.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index b9e35a0a60cf..5c9a72f1e1f2 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -664,7 +664,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 
 	sch_tree_lock(sch);
 
-	q->nbands = nbands;
+	WRITE_ONCE(q->nbands, nbands);
 	for (i = nstrict; i < q->nstrict; i++) {
 		if (q->classes[i].qdisc->q.qlen) {
 			list_add_tail(&q->classes[i].alist, &q->active);
@@ -676,11 +676,11 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 			list_del_init(&q->classes[i].alist);
 		qdisc_purge_queue(q->classes[i].qdisc);
 	}
-	q->nstrict = nstrict;
+	WRITE_ONCE(q->nstrict, nstrict);
 	memcpy(q->prio2band, priomap, sizeof(priomap));
 
 	for (i = 0; i < q->nbands; i++)
-		q->classes[i].quantum = quanta[i];
+		WRITE_ONCE(q->classes[i].quantum, quanta[i]);
 
 	for (i = oldbands; i < q->nbands; i++) {
 		q->classes[i].qdisc = queues[i];
@@ -694,7 +694,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	for (i = q->nbands; i < oldbands; i++) {
 		qdisc_put(q->classes[i].qdisc);
 		q->classes[i].qdisc = NULL;
-		q->classes[i].quantum = 0;
+		WRITE_ONCE(q->classes[i].quantum, 0);
 		q->classes[i].deficit = 0;
 		memset(&q->classes[i].bstats, 0, sizeof(q->classes[i].bstats));
 		memset(&q->classes[i].qstats, 0, sizeof(q->classes[i].qstats));
@@ -751,6 +751,7 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct ets_sched *q = qdisc_priv(sch);
 	struct nlattr *opts;
 	struct nlattr *nest;
+	u8 nbands, nstrict;
 	int band;
 	int prio;
 	int err;
@@ -763,21 +764,22 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
 	if (!opts)
 		goto nla_err;
 
-	if (nla_put_u8(skb, TCA_ETS_NBANDS, q->nbands))
+	nbands = READ_ONCE(q->nbands);
+	if (nla_put_u8(skb, TCA_ETS_NBANDS, nbands))
 		goto nla_err;
 
-	if (q->nstrict &&
-	    nla_put_u8(skb, TCA_ETS_NSTRICT, q->nstrict))
+	nstrict = READ_ONCE(q->nstrict);
+	if (nstrict && nla_put_u8(skb, TCA_ETS_NSTRICT, nstrict))
 		goto nla_err;
 
-	if (q->nbands > q->nstrict) {
+	if (nbands > nstrict) {
 		nest = nla_nest_start(skb, TCA_ETS_QUANTA);
 		if (!nest)
 			goto nla_err;
 
-		for (band = q->nstrict; band < q->nbands; band++) {
+		for (band = nstrict; band < nbands; band++) {
 			if (nla_put_u32(skb, TCA_ETS_QUANTA_BAND,
-					q->classes[band].quantum))
+					READ_ONCE(q->classes[band].quantum)))
 				goto nla_err;
 		}
 
@@ -789,7 +791,8 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
 		goto nla_err;
 
 	for (prio = 0; prio <= TC_PRIO_MAX; prio++) {
-		if (nla_put_u8(skb, TCA_ETS_PRIOMAP_BAND, q->prio2band[prio]))
+		if (nla_put_u8(skb, TCA_ETS_PRIOMAP_BAND,
+			       READ_ONCE(q->prio2band[prio])))
 			goto nla_err;
 	}
 
-- 
2.50.1


