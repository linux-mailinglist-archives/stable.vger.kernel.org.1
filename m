Return-Path: <stable+bounces-119529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E72B4A4459B
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094091885A1E
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 16:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C777C18C00B;
	Tue, 25 Feb 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz2Kd9zi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E321ABAB;
	Tue, 25 Feb 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500018; cv=none; b=ngVN/VNtt95UuTwhtx/GwCgTAWUFq+qjR9gdZl0mfLyqYd/bmnHcM+VcVau/bLe4fcAlm1/UGKd2Isz0/3aPcv9tK1L2Ow8zjwTkYhFHhQ5w8YVABeEVNOUlw3MspcwPpNdp8+i40JW3F3bB0JbBwc7lYQdwpqgyPjGPHPbDiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500018; c=relaxed/simple;
	bh=zxHilzlwDf7ovEtBPkSL+tIZUqIVWUarGWX8NAWd+bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bohQrny7OVSufcyJZepLHEsW3OdPsdP7imOnOORJoldzuibUZ5+YaTJDEmZvp8Min4whTyg5hBgKRZv+G9TRfqzHEChzgOLks5hosmSVHnLQQP33SFGDsiCuJYTtY+NfJS0L5iTzi8tGDdjnDh9mehVQMtDWYfizhVXkSyFWiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oz2Kd9zi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D60C4CEDD;
	Tue, 25 Feb 2025 16:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500018;
	bh=zxHilzlwDf7ovEtBPkSL+tIZUqIVWUarGWX8NAWd+bQ=;
	h=From:To:Cc:Subject:Date:From;
	b=oz2Kd9ziWB20Tn9xySVGugZduBZV1GtbCE11NCHQTqg2eFRVdD8gJ1voa9Iq/ZJX+
	 AqU4ymCwQMPEPcKfZ+Q3/0sPK7Ra4SwsV2HQCE5uLxRL7fxBoDq1ig9UM5tYAqbOUb
	 EC7lMCJRSjxbUPUvd1/dcRWpr8Km0w8h1b09Flc01m/esDg7fB9BIm6lRNYDB0fLE7
	 QihjZMIqv+B66qa80w83pAJMUcfEt/gESTzJvuYp5Do+Qt+RGWCUjokSVIXPUCVExj
	 6xIupq+6HZJt1jpJxceVp/GINA0+k8Ka8oLa9tO+F2B7EMr/TM7yfeHnmD2cFIuowD
	 Dc0lehLXNQyPA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Quang Le <quanglex97@gmail.com>,
	Cong Wang <cong.wang@bytedance.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v6.1-v5.4 1/1] pfifo_tail_enqueue: Drop new packet when sch->limit == 0
Date: Tue, 25 Feb 2025 16:13:09 +0000
Message-ID: <20250225161310.2194361-1-lee@kernel.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 647cef20e649c576dff271e018d5d15d998b629d ]

Expected behaviour:
In case we reach scheduler's limit, pfifo_tail_enqueue() will drop a
packet in scheduler's queue and decrease scheduler's qlen by one.
Then, pfifo_tail_enqueue() enqueue new packet and increase
scheduler's qlen by one. Finally, pfifo_tail_enqueue() return
`NET_XMIT_CN` status code.

Weird behaviour:
In case we set `sch->limit == 0` and trigger pfifo_tail_enqueue() on a
scheduler that has no packet, the 'drop a packet' step will do nothing.
This means the scheduler's qlen still has value equal 0.
Then, we continue to enqueue new packet and increase scheduler's qlen by
one. In summary, we can leverage pfifo_tail_enqueue() to increase qlen by
one and return `NET_XMIT_CN` status code.

The problem is:
Let's say we have two qdiscs: Qdisc_A and Qdisc_B.
 - Qdisc_A's type must have '->graft()' function to create parent/child relationship.
   Let's say Qdisc_A's type is `hfsc`. Enqueue packet to this qdisc will trigger `hfsc_enqueue`.
 - Qdisc_B's type is pfifo_head_drop. Enqueue packet to this qdisc will trigger `pfifo_tail_enqueue`.
 - Qdisc_B is configured to have `sch->limit == 0`.
 - Qdisc_A is configured to route the enqueued's packet to Qdisc_B.

Enqueue packet through Qdisc_A will lead to:
 - hfsc_enqueue(Qdisc_A) -> pfifo_tail_enqueue(Qdisc_B)
 - Qdisc_B->q.qlen += 1
 - pfifo_tail_enqueue() return `NET_XMIT_CN`
 - hfsc_enqueue() check for `NET_XMIT_SUCCESS` and see `NET_XMIT_CN` => hfsc_enqueue() don't increase qlen of Qdisc_A.

The whole process lead to a situation where Qdisc_A->q.qlen == 0 and Qdisc_B->q.qlen == 1.
Replace 'hfsc' with other type (for example: 'drr') still lead to the same problem.
This violate the design where parent's qlen should equal to the sum of its childrens'qlen.

Bug impact: This issue can be used for user->kernel privilege escalation when it is reachable.

Fixes: 57dbb2d83d10 ("sched: add head drop fifo queue")
Reported-by: Quang Le <quanglex97@gmail.com>
Signed-off-by: Quang Le <quanglex97@gmail.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Link: https://patch.msgid.link/20250204005841.223511-2-xiyou.wangcong@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Lee: Backported to linux-6.6.y - fixed a minor surrounding diff conflict]
(cherry picked from commit e40cb34b7f247fe2e366fd192700d1b4f38196ca)
Signed-off-by: Lee Jones <lee@kernel.org>
---

- Applies cleanly to v6.1, v5.15, v5.10 and v5.4

 net/sched/sch_fifo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
index e1040421b797..af5f2ab69b8d 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -39,6 +39,9 @@ static int pfifo_tail_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 {
 	unsigned int prev_backlog;
 
+	if (unlikely(READ_ONCE(sch->limit) == 0))
+		return qdisc_drop(skb, sch, to_free);
+
 	if (likely(sch->q.qlen < sch->limit))
 		return qdisc_enqueue_tail(skb, sch);
 
-- 
2.48.1.658.g4767266eb4-goog


