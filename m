Return-Path: <stable+bounces-103787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B4D9EF9B2
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7D9189A6A6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF8622541D;
	Thu, 12 Dec 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F9mpJghy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B9D22540B;
	Thu, 12 Dec 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025602; cv=none; b=sy3a6mdeNa/aaRWe1vd+ChfmCzzMn8kY7oBM1fAWNFtVM4I7fY3oGVHK9SAT7MooxSLk3eimtmaVHFFd5Dq03asLvGthNl/09f6PTwWCqajlC23irqGEqo+a+vxNq+h+AYxA5oG+Ff4xWXlchFis/8GI90uFQpa62b3yl88O4ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025602; c=relaxed/simple;
	bh=368lU46KYietBa8DuHf7eEcpz3b0E49RSKM1UFL2IsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgZyEMqpziNMpQg9GHTo0LwaNcTyL5Ywrjbp1uOooPHaGOoW+LjoBtSuW9KM3ErIYLJSX+uWVyACPdKMCCEkAWT/qDx7+eeZC8vXg3n6AyPr75ARH9NftEpsWHs7ei24PL7NkDIZ6Nxh69HVtRag8+V6WrStjqEyUl20wac5M20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F9mpJghy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12802C4CECE;
	Thu, 12 Dec 2024 17:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734025602;
	bh=368lU46KYietBa8DuHf7eEcpz3b0E49RSKM1UFL2IsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F9mpJghybKi/ROHN0GP3B5tfMAYIsPH4LU4LBoWmuzG0E03329qtNJ1W2ro32LjWR
	 eTrOxuCepNo6LHxPes0NDNypJQMVWXSi0uLDPAGELWdDOIGiZjWpdPVqa7L3BDQbHy
	 tZiKC/5EjpuIPuD1SimEeP6hsnxlnz+BJrPBj9zs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Ottens <martin.ottens@fau.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 225/321] net/sched: tbf: correct backlog statistic for GSO packets
Date: Thu, 12 Dec 2024 16:02:23 +0100
Message-ID: <20241212144238.864826430@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144229.291682835@linuxfoundation.org>
References: <20241212144229.291682835@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Ottens <martin.ottens@fau.de>

[ Upstream commit 1596a135e3180c92e42dd1fbcad321f4fb3e3b17 ]

When the length of a GSO packet in the tbf qdisc is larger than the burst
size configured the packet will be segmented by the tbf_segment function.
Whenever this function is used to enqueue SKBs, the backlog statistic of
the tbf is not increased correctly. This can lead to underflows of the
'backlog' byte-statistic value when these packets are dequeued from tbf.

Reproduce the bug:
Ensure that the sender machine has GSO enabled. Configured the tbf on
the outgoing interface of the machine as follows (burstsize = 1 MTU):
$ tc qdisc add dev <oif> root handle 1: tbf rate 50Mbit burst 1514 latency 50ms

Send bulk TCP traffic out via this interface, e.g., by running an iPerf3
client on this machine. Check the qdisc statistics:
$ tc -s qdisc show dev <oif>

The 'backlog' byte-statistic has incorrect values while traffic is
transferred, e.g., high values due to u32 underflows. When the transfer
is stopped, the value is != 0, which should never happen.

This patch fixes this bug by updating the statistics correctly, even if
single SKBs of a GSO SKB cannot be enqueued.

Fixes: e43ac79a4bc6 ("sch_tbf: segment too big GSO packets")
Signed-off-by: Martin Ottens <martin.ottens@fau.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241125174608.1484356-1-martin.ottens@fau.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_tbf.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index a7f60bb2dd513..259a39ca99bfb 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -146,7 +146,7 @@ static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
 	struct tbf_sched_data *q = qdisc_priv(sch);
 	struct sk_buff *segs, *nskb;
 	netdev_features_t features = netif_skb_features(skb);
-	unsigned int len = 0, prev_len = qdisc_pkt_len(skb);
+	unsigned int len = 0, prev_len = qdisc_pkt_len(skb), seg_len;
 	int ret, nb;
 
 	segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
@@ -158,22 +158,28 @@ static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
 	while (segs) {
 		nskb = segs->next;
 		skb_mark_not_on_list(segs);
-		qdisc_skb_cb(segs)->pkt_len = segs->len;
-		len += segs->len;
+		seg_len = segs->len;
+		qdisc_skb_cb(segs)->pkt_len = seg_len;
 		ret = qdisc_enqueue(segs, q->qdisc, to_free);
 		if (ret != NET_XMIT_SUCCESS) {
 			if (net_xmit_drop_count(ret))
 				qdisc_qstats_drop(sch);
 		} else {
 			nb++;
+			len += seg_len;
 		}
 		segs = nskb;
 	}
 	sch->q.qlen += nb;
-	if (nb > 1)
+	sch->qstats.backlog += len;
+	if (nb > 0) {
 		qdisc_tree_reduce_backlog(sch, 1 - nb, prev_len - len);
-	consume_skb(skb);
-	return nb > 0 ? NET_XMIT_SUCCESS : NET_XMIT_DROP;
+		consume_skb(skb);
+		return NET_XMIT_SUCCESS;
+	}
+
+	kfree_skb(skb);
+	return NET_XMIT_DROP;
 }
 
 static int tbf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
-- 
2.43.0




