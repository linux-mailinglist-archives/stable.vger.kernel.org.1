Return-Path: <stable+bounces-171742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B35D7B2B78B
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 05:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CAC1BA19A4
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 03:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A53153BE8;
	Tue, 19 Aug 2025 03:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYfQscuR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB23F13FEE
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 03:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574316; cv=none; b=Km5/zr1/sRoq8uEfyXU00plJ9GXiORmLWBRV/aOn2aRWsD75rPaLSCM9KN4O2zem80S0gLMxOrYk61zCwkovOsyAoV0ezT/PUj2jmCBh4Dku3NxLsRaoW3tJUKJIl1pIFdr/yaLO5G+cM3wV2FqIXK9VkepJ1yllOoGyAgbVjwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574316; c=relaxed/simple;
	bh=ENYiwATYki9nrya+IFZaDd5v7h4PXVIoE/yG52XAA9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNjttwoHAJvuki0RG0xPft4c1JM+/uBRFiW4kZLj2yDPNscw94ZeM6hU2h4tSYH5bBSEajEqDcvFm8KcCGUQMAgDpWdnLRozHH5F6deZmtrd1D6l6tZ236Mjqt9V570dOaRjZB0N+z6waZGCyXGnn2rbRg7SVwVukhmeTaOp1Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYfQscuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DD7C4CEF4;
	Tue, 19 Aug 2025 03:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755574316;
	bh=ENYiwATYki9nrya+IFZaDd5v7h4PXVIoE/yG52XAA9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qYfQscuRdGt98TFKznGTV7IvYsTmFxqVtCQA1tJcp3hNpoC6k7+UQbwwy9C+jCbW5
	 hPCvmefUFktCFa4o7m8JLZ7tynAIfND9GnB/WIK5Lk2UDNxIsNsLcMzungZR70VHso
	 YpxRFbLGAcgNKeBBx6TkF+8gJ3lvhGGSdFBjdYvE8ujqB27fEw38ufZNL4ayLerdws
	 a33uYbH2apYEk08GcH07RTPc/0q82LGSyXY80hW4rZemwnhAD30tz9ytBfkYc141kA
	 f8L0aJoQA91eooucXlqIBkvjA6SFYUA/p2H6ZrUcsGeeVK1HK9EEpX7GtwIwIbSnZl
	 lmOJZW3vMYM4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] net_sched: sch_ets: implement lockless ets_dump()
Date: Mon, 18 Aug 2025 23:31:52 -0400
Message-ID: <20250819033153.315415-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081854-registry-sled-ea48@gregkh>
References: <2025081854-registry-sled-ea48@gregkh>
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
index 3ee46f6e005d..93469bc337d6 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -651,7 +651,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 
 	sch_tree_lock(sch);
 
-	q->nbands = nbands;
+	WRITE_ONCE(q->nbands, nbands);
 	for (i = nstrict; i < q->nstrict; i++) {
 		if (q->classes[i].qdisc->q.qlen) {
 			list_add_tail(&q->classes[i].alist, &q->active);
@@ -663,11 +663,11 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
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
@@ -681,7 +681,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	for (i = q->nbands; i < oldbands; i++) {
 		qdisc_put(q->classes[i].qdisc);
 		q->classes[i].qdisc = NULL;
-		q->classes[i].quantum = 0;
+		WRITE_ONCE(q->classes[i].quantum, 0);
 		q->classes[i].deficit = 0;
 		gnet_stats_basic_sync_init(&q->classes[i].bstats);
 		memset(&q->classes[i].qstats, 0, sizeof(q->classes[i].qstats));
@@ -738,6 +738,7 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct ets_sched *q = qdisc_priv(sch);
 	struct nlattr *opts;
 	struct nlattr *nest;
+	u8 nbands, nstrict;
 	int band;
 	int prio;
 	int err;
@@ -750,21 +751,22 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
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
 
@@ -776,7 +778,8 @@ static int ets_qdisc_dump(struct Qdisc *sch, struct sk_buff *skb)
 		goto nla_err;
 
 	for (prio = 0; prio <= TC_PRIO_MAX; prio++) {
-		if (nla_put_u8(skb, TCA_ETS_PRIOMAP_BAND, q->prio2band[prio]))
+		if (nla_put_u8(skb, TCA_ETS_PRIOMAP_BAND,
+			       READ_ONCE(q->prio2band[prio])))
 			goto nla_err;
 	}
 
-- 
2.50.1


