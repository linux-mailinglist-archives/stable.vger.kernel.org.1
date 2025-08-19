Return-Path: <stable+bounces-171779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F92FB2C2E3
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11521B66B19
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 12:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DBF33A01D;
	Tue, 19 Aug 2025 12:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7f0PiPY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9916334723
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605732; cv=none; b=rOc8CjcMF5KcGTn/xUjZj1jE2WjAk4LyTcbQ/6TSv3I+OVJn2+3sUSVFuyLSNpD5HzXRRJ/nCW/4GzoGvKIQ+XJDSV4utVfw+SOz0xssIHkAzIUK/DggMbBXZ3XIQ8aElJ30kOIvpQrxKJdt9ChleKgGCJWVhnX2eXkXeIquat4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605732; c=relaxed/simple;
	bh=hHJNSaa7z0QLH28+zBJFEgkojRm1pKmgCyIK5Yzn6fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0BeAHSrW3mNbqX+RCpWvLEpvEgPjh6h6774lUPNg+G+Oapc7jR01wqslkh/JXtjvigMeXyc5xl5eea29J0iQ7N9sSbUbPCRJALLSOqMih9B9X4XTWReoa2S4cQdxmidMs0nQskPbGjPwm0tl0qfVxQnBnxSOklIvyBV2L4iZ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7f0PiPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C32C4CEF1;
	Tue, 19 Aug 2025 12:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755605732;
	bh=hHJNSaa7z0QLH28+zBJFEgkojRm1pKmgCyIK5Yzn6fM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B7f0PiPYPc3922+2aXTv0YHKOddleZuGZsIUoFYSqOAHHEJrCCnK56gh/jKyoqLrL
	 x2qPM2QJCC+cuBwsgeJUurZrBddxDiAwNIuIIDy8TTzTPODugUC0UijI64vXRiekwC
	 fvPQP0bpfpO+euLNNX4PFeomJeJPNXSPcptH/o9G/0ld6r43Cn5rpQ5sZ10zSOdR6I
	 M8pLoA3HMz6n3lfxG5/MWx65LTkvg8EiBz4VeoCBYAFjb/t3XcKBMLVf0O9M+Ul32b
	 /WDuR2QQQcst1ZA9rAHIs8oshD4+0CiDsUH3eXY3L2fzxFea6Jv7dnWKNtlG+m4zdD
	 BdEwy5OeBm7+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Davide Caratti <dcaratti@redhat.com>,
	Cong Wang <cong.wang@bytedance.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] net/sched: sch_ets: properly init all active DRR list handles
Date: Tue, 19 Aug 2025 08:15:28 -0400
Message-ID: <20250819121530.461591-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081857-reunite-divinely-430d@gregkh>
References: <2025081857-reunite-divinely-430d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit 454d3e1ae057a1e09a15905b06b860f60d6c14d0 ]

leaf classes of ETS qdiscs are served in strict priority or deficit round
robin (DRR), depending on the value of 'nstrict'. Since this value can be
changed while traffic is running, we need to be sure that the active list
of DRR classes can be updated at any time, so:

1) call INIT_LIST_HEAD(&alist) on all leaf classes in .init(), before the
   first packet hits any of them.
2) ensure that 'alist' is not overwritten with zeros when a leaf class is
   no more strict priority nor DRR (i.e. array elements beyond 'nbands').

Link: https://lore.kernel.org/netdev/YS%2FoZ+f0Nr8eQkzH@dcaratti.users.ipa.redhat.com
Suggested-by: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 87c6efc5ce9c ("net/sched: ets: use old 'nbands' while purging unused classes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_ets.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index b49e1a977586..7bf6be69b3ee 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -666,7 +666,6 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 
 	q->nbands = nbands;
 	for (i = nstrict; i < q->nstrict; i++) {
-		INIT_LIST_HEAD(&q->classes[i].alist);
 		if (q->classes[i].qdisc->q.qlen) {
 			list_add_tail(&q->classes[i].alist, &q->active);
 			q->classes[i].deficit = quanta[i];
@@ -694,7 +693,11 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 	ets_offload_change(sch);
 	for (i = q->nbands; i < oldbands; i++) {
 		qdisc_put(q->classes[i].qdisc);
-		memset(&q->classes[i], 0, sizeof(q->classes[i]));
+		q->classes[i].qdisc = NULL;
+		q->classes[i].quantum = 0;
+		q->classes[i].deficit = 0;
+		memset(&q->classes[i].bstats, 0, sizeof(q->classes[i].bstats));
+		memset(&q->classes[i].qstats, 0, sizeof(q->classes[i].qstats));
 	}
 	return 0;
 }
@@ -703,7 +706,7 @@ static int ets_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 			  struct netlink_ext_ack *extack)
 {
 	struct ets_sched *q = qdisc_priv(sch);
-	int err;
+	int err, i;
 
 	if (!opt)
 		return -EINVAL;
@@ -713,6 +716,9 @@ static int ets_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 		return err;
 
 	INIT_LIST_HEAD(&q->active);
+	for (i = 0; i < TCQ_ETS_MAX_BANDS; i++)
+		INIT_LIST_HEAD(&q->classes[i].alist);
+
 	return ets_qdisc_change(sch, opt, extack);
 }
 
-- 
2.50.1


