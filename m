Return-Path: <stable+bounces-100781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 824CB9ED609
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D148188D7EE
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9D82571F5;
	Wed, 11 Dec 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioI09ZMX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2DC2571EC;
	Wed, 11 Dec 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943274; cv=none; b=Kjuh7eYMnDYUZ+bvC0cCau+mVi5g8LdFSRlDaXoTsDmenXGJBg1SvOL23cETkHo8L0m2qJKJFzkt5w02q7u8GpWPodzEd4vnnD2ai8UZvLvRevJkRgoRVczpu6/MxmLxrRFzI9jaWSd2mD1jk6KZoqvbDCuIVXxKMg7A1XE2KQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943274; c=relaxed/simple;
	bh=abLzIOoeqegwBKW22/IQl8qmfu8k5E7rnoJ2fhX+uyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gp99PmvwKAVrkczaofFY4dp2h7u7ymo9Ot2Amp4hURDklFGuJKndQDmi8YVVICez2zTEmyq647Bd/aq/7LcLfCvCz3fCuO8pqxkAxUWk+/tTQtNGVX2qnaFVpHLW5kUHUgPpUi+3zEAu/G3XhhMF2xJjv2hR6G8Ilxd+nyZU9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioI09ZMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78887C4CED4;
	Wed, 11 Dec 2024 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943274;
	bh=abLzIOoeqegwBKW22/IQl8qmfu8k5E7rnoJ2fhX+uyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ioI09ZMXQUsSTeBg+iNt4jGGSkv6HKb9Sk11XkvniiFqHY4cCkjWTFxPkPWa3Phwc
	 W3LSPfKpSDNv2FYMsHKs9U0uF60TPXJxnJOFwpZeSZuxXdUjtk+LK4oxat842+NJED
	 1s0B/Cr8Th6/aAYZ2wSJIX6JP9LAgjVjpv5ZL43/YnHSpKyNQF73gkHWGzTRhT/oPM
	 K2wsWL9XJHAF5IRYW2XvY+oR/PFVTmzhr4K/t5JGLaPk7gyBSMBaTsaNBSHUSORZz3
	 f0bLAq8SUNUKHGnPaYH92nznlao4xrKe3L2r1woqDLzonzx0dVrOrvn6LY4zPK84or
	 d6g+gAcBit8GA==
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
Subject: [PATCH AUTOSEL 5.10 07/10] net: sched: fix ordering of qlen adjustment
Date: Wed, 11 Dec 2024 13:54:13 -0500
Message-ID: <20241211185419.3843138-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185419.3843138-1-sashal@kernel.org>
References: <20241211185419.3843138-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index 4ddb43a6644ab..8d9c0b98a747b 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1541,7 +1541,6 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	b->backlogs[idx]    -= len;
 	b->tin_backlog      -= len;
 	sch->qstats.backlog -= len;
-	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	flow->dropped++;
 	b->tin_dropped++;
@@ -1552,6 +1551,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 
 	__qdisc_drop(skb, to_free);
 	sch->q.qlen--;
+	qdisc_tree_reduce_backlog(sch, 1, len);
 
 	cake_heapify(q, 0);
 
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index 25d2daaa81227..f3805bee995bb 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -124,10 +124,10 @@ static void choke_drop_by_idx(struct Qdisc *sch, unsigned int idx,
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


