Return-Path: <stable+bounces-102943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1409EF65C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F7176020
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFA022654B;
	Thu, 12 Dec 2024 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P5zOjgI8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D08176AA1;
	Thu, 12 Dec 2024 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023063; cv=none; b=E3/J+XzaKcBKwKgOnXrlUVqh2KtPDCLtcaKmMNOgx74nVp6HnIpka4LwPH+0jIFKvDWmij2dmA4OAY9AX2dbUKb6LuxODFJwpUkeSPzyOWRQqqAF2Q8o+jPsWKfNivAIgX46i3MITxR7m0CWvZtzeV40D0836N/ZmYYB2sWZVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023063; c=relaxed/simple;
	bh=U0UcI7Nq1ZhvCgzENlBhINQXcqaj6awzxtSaa7fS9jM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kd58lRB6TXE5ayqSIOvdMuSVOBZfAL9TAozhASqgvmKJXHL7GoFo66tde2hQd8TtKp+KbEdg9TVbmKZVzzIa6YCzPt2R8UwuDP8ljTDKRuW/7g9Jxcg3BxijFNQ2A4DWBfiqXn57CCPr99SNO0LnIrAwJ7DUuw8C9gIHLsx/PhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P5zOjgI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F24C4CECE;
	Thu, 12 Dec 2024 17:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023063;
	bh=U0UcI7Nq1ZhvCgzENlBhINQXcqaj6awzxtSaa7fS9jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P5zOjgI8VpH4i6LJOEZkOiH6uNd6T00cUZs2m1XICJgonvmcH+KdWb/J8vif2UmKh
	 K4rMMoz+zGlkcBnCBVdPOChruPhPj2skFOHJ6eLQbsC8KVEHE2wOKu+GeZ8tlLnwAT
	 WTpedb6eL2nEAlnqgyfTwqmgrxBagoF/QUiwDrEI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Ottens <martin.ottens@fau.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 411/565] net/sched: tbf: correct backlog statistic for GSO packets
Date: Thu, 12 Dec 2024 16:00:06 +0100
Message-ID: <20241212144327.904928400@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 7461e5c67d50a..5f50fdeaafa8d 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -193,7 +193,7 @@ static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
 	struct tbf_sched_data *q = qdisc_priv(sch);
 	struct sk_buff *segs, *nskb;
 	netdev_features_t features = netif_skb_features(skb);
-	unsigned int len = 0, prev_len = qdisc_pkt_len(skb);
+	unsigned int len = 0, prev_len = qdisc_pkt_len(skb), seg_len;
 	int ret, nb;
 
 	segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
@@ -204,21 +204,27 @@ static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
 	nb = 0;
 	skb_list_walk_safe(segs, segs, nskb) {
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




