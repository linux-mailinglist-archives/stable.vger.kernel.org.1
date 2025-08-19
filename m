Return-Path: <stable+bounces-171800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E60B2C715
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 16:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A465E4785
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160C02741CD;
	Tue, 19 Aug 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sry28HVo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FE1273803
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755613976; cv=none; b=YBl8w8AdOoYDlKbm60hPMKt4d54T2kR3Ztb4z6qyqp0l2ATil67LxgvYO7r/4frmFxMQQe+QJ5uDx9rwFD2cPHV/aDDsX3wLZLxN+yx/cQfiiRGnEkdOYljt0i5E7Kuq/3fk0MbcFh3ZuYRZGjh6ghgBkQANa5AKTfQ2ETkT5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755613976; c=relaxed/simple;
	bh=xkcDlU2UrgJCsHlJa0u6nnQtS+idW9ADbuLP0vkxFwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cerEh/t8bZL/tb0A+INhdE3Usnh0bgKpch5UNJutv8ERhS2s0CXprHVy9aspN2AEfQHZc6pRDemIzHMmEZ3ITIYNkjNBDHG3h/4Fd35hicTl+BoYEGFJr/mvMS9WTzE01p6W8EZ7LqIXSXQD/RMJ7MbKVtCPX8d2F9ysyrEmCIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sry28HVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF108C4CEF1;
	Tue, 19 Aug 2025 14:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755613976;
	bh=xkcDlU2UrgJCsHlJa0u6nnQtS+idW9ADbuLP0vkxFwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sry28HVoQZQtujcYppm29lpnwLmAhoG5RmeFX4HjZqbSr0K8cT/7hh75B9Ensg5E+
	 UWt8U3pUg93Dw4Qoq85a7M6IawLUkELaCDHJGsaHhhe/r43Lp5NYMFdctCUslD40sd
	 PcQkyY415S4YjiicJWomhiiDhMjWn5+qCbNg8tOxqpbXy7WpFnzQQM/Gj7fUCMgpIx
	 +7j1AULAH7SYqUMzgNyT+CvnTE/tYeaEU2mnYhQHqp0DA9VYuaCVwqqWEwBJKnyiIA
	 ZbEF8NC9QjNBSiIJdl3Ewvy1hu5237d1SVDu72QOegRxW/H3+JFIfd1Ro3NVTUktBF
	 l+Hxa6rWg82mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Davide Caratti <dcaratti@redhat.com>,
	Cong Wang <cong.wang@bytedance.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] net/sched: sch_ets: properly init all active DRR list handles
Date: Tue, 19 Aug 2025 10:32:51 -0400
Message-ID: <20250819143253.512050-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081858-blurred-unlinked-7eae@gregkh>
References: <2025081858-blurred-unlinked-7eae@gregkh>
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
index 4f4da11a2c77..b9e35a0a60cf 100644
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


