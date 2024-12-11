Return-Path: <stable+bounces-100712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D250D9ED524
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480BF188AF8A
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D034236FA9;
	Wed, 11 Dec 2024 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btMMI284"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF683231A52;
	Wed, 11 Dec 2024 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943089; cv=none; b=ntHZQtpnu+mBOmGeBI1IdeQXw15X+oKhu5+KSua/Li2CCJMwxOL9NVy7Yk3GMtXRvOLCTA44IzoX9F7NOAB4i7xqeWiElk9oeRvuFEeuqRTY7Ro1ML3u3m6QC3N1zRDofAfRAPgLNE3Hc2F5Xy/aGzb30mSqiVqMILTluObtShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943089; c=relaxed/simple;
	bh=96r5ccacfmXcLQnwik2jHbpoWaiE2MrtcAfUX3pATWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAx/YFV2xhvDaPZeAV++XWihSzlZ0eOxLMz2Io/CqBkAXpsGyI/0Wq+LMo3G61ActLiccw9LdslqpQG3lgPTWkn+73JMuV5MW4q4NNo/D8V6NAg3/NxOzEkk4IW+TZh6yJkNV4IKfzjYjbno0PtOlKPJidGNvrHm1OK5VdB5ArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btMMI284; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28714C4CEE6;
	Wed, 11 Dec 2024 18:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943088;
	bh=96r5ccacfmXcLQnwik2jHbpoWaiE2MrtcAfUX3pATWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btMMI2844CHpivRupse72R7RZI6KL35EzZIDsrvPxtJBl0vWQW7+r4IBqEBWQOCTB
	 qnMNlKWMP0h7ZswAF3lkQYXBtGfw/pAhX0mt2dJt1YNdpd9Poow05gg73qYMn6Lzld
	 yEucXr5zae84/MCneCqZx2lJC4ylQJOXcoGgSMN2ihmaswwoKeAAFl6YGdxzHl+Cvf
	 2FWFM6DHZ5vG8nAg3imynt2lKBcbjyZgFEsl/G0wxSu1quK3gwcV8o8Az3LN1AbQXq
	 7b4GKZyoecqejWJTzNcLGTtCAhObCBmKfz9ZMrAZCe1gAW632oyGtSc0pWMDufaEng
	 TKSp/9zrEEzHA==
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
Subject: [PATCH AUTOSEL 6.12 22/36] net: sched: fix ordering of qlen adjustment
Date: Wed, 11 Dec 2024 13:49:38 -0500
Message-ID: <20241211185028.3841047-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185028.3841047-1-sashal@kernel.org>
References: <20241211185028.3841047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.4
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
index f2f9b75008bb0..8d8b2db4653c0 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1525,7 +1525,6 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	b->backlogs[idx]    -= len;
 	b->tin_backlog      -= len;
 	sch->qstats.backlog -= len;
-	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	flow->dropped++;
 	b->tin_dropped++;
@@ -1536,6 +1535,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 
 	__qdisc_drop(skb, to_free);
 	sch->q.qlen--;
+	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	cake_heapify(q, 0);
 
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index 91072010923d1..757b89292e7e6 100644
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


