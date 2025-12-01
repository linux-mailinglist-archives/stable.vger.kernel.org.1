Return-Path: <stable+bounces-197852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2AAC97087
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1093A1CAD
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086DB25A2B4;
	Mon,  1 Dec 2025 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mbCxx9QJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FAD25A640;
	Mon,  1 Dec 2025 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588709; cv=none; b=vEKBc15Y74mPKZypVcCQUFXBQ2314hBv4RdDfy8DFy5RrIorsv9rHiZzYHHClhmuD5S1PUpipC6f2slfBipbp5KDrzn5eKNcMCElPFGw1uTbnxFshst/z7wdVYevKKhiUhtKoUsXpWwM6Q60JzYZ33VLmbR0Kmm4h/FEsrZ6SSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588709; c=relaxed/simple;
	bh=cJSq5lKJbERL8KVgoaSAcwxDPco3txxtpOlgtOliqlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuD7iChYdhEuVZfkQ2oPiOKZ5WMiIKGdmywtezIeaP3Ez/TQkeFSq0XSDqXsXBKbG2SLmiKrrE7A8FNCs20eAL52D6eaZPNXl9n0ph1wLFZTtQw/tos9kuPKx2ZProvdmqlGFjieJSjBqhhONmBDmg8IRNy5T1iMkYCNQ8fbOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mbCxx9QJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46599C4CEF1;
	Mon,  1 Dec 2025 11:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764588709;
	bh=cJSq5lKJbERL8KVgoaSAcwxDPco3txxtpOlgtOliqlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mbCxx9QJTfWU1qtwe5u1S50128M7xMi5rRCvU/lZKhFxUiKiJuwfP0a+HlZYW9kJy
	 AvsXNgL4IJON3ZVp37st62pnlA9O+trVE1uzB0YKpPp8fqOlffyHbtuEGjYctztrUv
	 PnHGmftdN0vmVQPcYaRTXwNWxiNA0u5H6iV9JstI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 143/187] net_sched: remove need_resched() from qdisc_run()
Date: Mon,  1 Dec 2025 12:24:11 +0100
Message-ID: <20251201112246.388373542@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201112241.242614045@linuxfoundation.org>
References: <20251201112241.242614045@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b60fa1c5d01a10e358c509b904d4bead6114d593 ]

The introduction of this schedule point was done in commit
2ba2506ca7ca ("[NET]: Add preemption point in qdisc_run")
at a time the loop was not bounded.

Then later in commit d5b8aa1d246f ("net_sched: fix dequeuer fairness")
we added a limit on the number of packets.

Now is the time to remove the schedule point, since the default
limit of 64 packets matches the number of packets a typical NAPI
poll can process in a row.

This solves a latency problem for most TCP receivers under moderate load :

1) host receives a packet.
   NET_RX_SOFTIRQ is raised by NIC hard IRQ handler

2) __do_softirq() does its first loop, handling NET_RX_SOFTIRQ
   and calling the driver napi->loop() function

3) TCP stores the skb in socket receive queue:

4) TCP calls sk->sk_data_ready() and wakeups a user thread
   waiting for EPOLLIN (as a result, need_resched() might now be true)

5) TCP cooks an ACK and sends it.

6) qdisc_run() processes one packet from qdisc, and sees need_resched(),
   this raises NET_TX_SOFTIRQ (even if there are no more packets in
   the qdisc)

Then we go back to the __do_softirq() in 2), and we see that new
softirqs were raised. Since need_resched() is true, we end up waking
ksoftirqd in this path :

    if (pending) {
            if (time_before(jiffies, end) && !need_resched() &&
                --max_restart)
                    goto restart;

            wakeup_softirqd();
    }

So we have many wakeups of ksoftirqd kernel threads,
and more calls to qdisc_run() with associated lock overhead.

Note that another way to solve the issue would be to change TCP
to first send the ACK packet, then signal the EPOLLIN,
but this changes P99 latencies, as sending the ACK packet
can add a long delay.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 0345552a653c ("net_sched: limit try_bulk_dequeue_skb() batches")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_generic.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 4250f3cf30e72..19fe5078a8d13 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -407,13 +407,8 @@ void __qdisc_run(struct Qdisc *q)
 	int packets;
 
 	while (qdisc_restart(q, &packets)) {
-		/*
-		 * Ordered by possible occurrence: Postpone processing if
-		 * 1. we've exceeded packet quota
-		 * 2. another process needs the CPU;
-		 */
 		quota -= packets;
-		if (quota <= 0 || need_resched()) {
+		if (quota <= 0) {
 			__netif_schedule(q);
 			break;
 		}
-- 
2.51.0




