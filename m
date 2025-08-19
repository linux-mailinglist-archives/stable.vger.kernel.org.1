Return-Path: <stable+bounces-171780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8AEB2C2E1
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C42561542
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001C61D8DE1;
	Tue, 19 Aug 2025 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsh4imgK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DD325E814
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605733; cv=none; b=FyXaf29DZfyv6qymroJZpx+R5qaUz33Tc1dAYajCK7rYRVWKT4iFzEiXq1y3y6WofMvhMtPH0mW5QpF1CIItcKD9SyYZ7grQYCJUqnMQjuTHz8t7NChgc0aZW3s8S5Eoi0zG8/K5kbO9RPdenxyipZwExw/SJHmImxo6GWDKkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605733; c=relaxed/simple;
	bh=/8q5mgSi9+IogJRcPLdWKHZx6+PByxw+3/3b3rwlaDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogJY4EzwG4WUmw4o4AYOwaDI8dr93Vj0zGGalQvPcxPAyPj1yrBbMGeSFXAANw2Jg8rHNBi2SWJTWQPtLcaJx8FP0K7GTMpbx16x1mJaBjB3Qb5rnLBtiH778dwdAeR+iUKQPixJTLn2FzwsOAD+uEA1l3QO1rHhWwNF/4MiIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsh4imgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94692C113D0;
	Tue, 19 Aug 2025 12:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755605733;
	bh=/8q5mgSi9+IogJRcPLdWKHZx6+PByxw+3/3b3rwlaDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jsh4imgKYJGBZH9Rkj2/QP8hRUkTXKx/8yBiCTV92HMe+PGGwpVWBTQmw8ebQPQCg
	 0MMihoaqWTElsVKzvaGq2IWRGXHtCsqcigS9YUhxeTanOtcp0pdnDKlADdGXc90Kur
	 tbHffsv4OpknUl5+5SaO3EyezTPU8B4zJekWmJh8zQe/7/x81sJtD72y1hvke0AipV
	 wHYb3aVj41IMxQslTJcJX7fJM9S8sY2mcwhCCNLLK0J1h72FfmDsN78nG71aGJXClO
	 0k0ysc29u3ligiNahiLBjnmelkgLoNyeZcNnFQuNqfMQw1yBw7jsHg+7Badd1zfVt1
	 vGeAEy99LPzNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] net_sched: sch_ets: implement lockless ets_dump()
Date: Tue, 19 Aug 2025 08:15:29 -0400
Message-ID: <20250819121530.461591-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819121530.461591-1-sashal@kernel.org>
References: <2025081857-reunite-divinely-430d@gregkh>
 <20250819121530.461591-1-sashal@kernel.org>
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
index 7bf6be69b3ee..3abfba061d8e 100644
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


