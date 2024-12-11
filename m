Return-Path: <stable+bounces-100740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E3B9ED582
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3BA1889048
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87774249D6C;
	Wed, 11 Dec 2024 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZZHubEa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EC3249D63;
	Wed, 11 Dec 2024 18:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943166; cv=none; b=sDkiVZt1SIueN7zuLxxNLqzQxgaRe6YvDmxFdEEH+0tlKamPDm/UYmVCESo7W2A31/1be1QN5n+o5Wyz7RU6xqlc/sLwP+jYp0qqPDVLZp7vhJ9sSm3c3uRlZcVmpjXWuXIJRyPK2or5ZnAON/vzkhdOmYHshmkkfgLkiP+8pNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943166; c=relaxed/simple;
	bh=/GqXsUvp7leke0Ic7oUS0GoQj5+Xi/xodGN1FrUodGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnXE90AnncV2Ti03nmeW+iC+rE5s5/72UFQahKYHMPbqvFl1bqsjDnZuQ8zXkQNcJVyrXjU8nIRLvXD5u8XKNATPQFGvHoO8dmkqnUdwRuQU0mGBNJtxfDfI4OHrKbX4ApZigSHIrMskR4RNPWPf1MCJyoUbEKWulOGbaPoKyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZZHubEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C873C4CED4;
	Wed, 11 Dec 2024 18:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943166;
	bh=/GqXsUvp7leke0Ic7oUS0GoQj5+Xi/xodGN1FrUodGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jZZHubEa9lQ2rZ9e17XZBC87yTHue1QXvOgeVP3Z2c3dAteH5EP4bcYPZ8Cqk+Eeq
	 VqYeX9gmVqvODsNzgiigw23h8yniMLNGy/KRdrAgIOjXnEIiC8IAkt8uqn1iH+qRv8
	 ZjcHO4Gy7Wydxvy9OY3uy5rv3a0TO0mhyjnGz4J3317GuJ5rx0dJ0jjcgFxoHA97YH
	 rnscE+j3YvncMGbxCIAezuIDJ9gCLUGvBHU4HOM8tysRhzSq7QkaemHOhyAm5f3vvj
	 mrIDdShGvNMLQxN5jTGA8o/Qt5W3HRhx0ZU8IAN6k5HOKANaoeQ7Jj9o6tUbZkZhHr
	 USbfpDWPCgdTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lion Ackermann <nnamrec@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 14/23] net: sched: fix ordering of qlen adjustment
Date: Wed, 11 Dec 2024 13:51:51 -0500
Message-ID: <20241211185214.3841978-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185214.3841978-1-sashal@kernel.org>
References: <20241211185214.3841978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.65
Content-Transfer-Encoding: 8bit

From: Lion Ackermann <nnamrec@gmail.com>

[ Upstream commit 5eb7de8cd58e73851cd37ff8d0666517d9926948 ]

Changes to sch->q.qlen around qdisc_tree_reduce_backlog() need to happen
_before_ a call to said function because otherwise it may fail to notify
parent qdiscs when the child is about to become empty.

Signed-off-by: Lion Ackermann <nnamrec@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_cake.c  | 2 +-
 net/sched/sch_choke.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 30955dd45779e..a65fad45d5568 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1542,7 +1542,6 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	b->backlogs[idx]    -= len;
 	b->tin_backlog      -= len;
 	sch->qstats.backlog -= len;
-	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	flow->dropped++;
 	b->tin_dropped++;
@@ -1553,6 +1552,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 
 	__qdisc_drop(skb, to_free);
 	sch->q.qlen--;
+	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	cake_heapify(q, 0);
 
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index 19c851125901f..a919591422085 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -123,10 +123,10 @@ static void choke_drop_by_idx(struct Qdisc *sch, unsigned int idx,
 	if (idx == q->tail)
 		choke_zap_tail_holes(q);
 
+	--sch->q.qlen;
 	qdisc_qstats_backlog_dec(sch, skb);
 	qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
 	qdisc_drop(skb, sch, to_free);
-	--sch->q.qlen;
 }
 
 struct choke_skb_cb {
-- 
2.43.0


