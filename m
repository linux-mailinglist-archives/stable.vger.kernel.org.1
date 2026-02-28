Return-Path: <stable+bounces-220580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHMaIwc+o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:12:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 244C51C6ADF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBC0631DDD77
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AC93DD768;
	Sat, 28 Feb 2026 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROAUf7jV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B733DD743;
	Sat, 28 Feb 2026 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300463; cv=none; b=hHuWLsBrys9CboFmvEx6N77PbnXNLLcWQ5LLMlytA9M9DgjasZjwqBfCJEP9tfHZORrARIABjq8fvjtCecDVMCk6DichysYO1+mcojck++Q6HQ4JT96qlXH37UExq95EE9P3o2s5/afnXwmE0klzLRDhmegIr8S3HzMaOuL+kP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300463; c=relaxed/simple;
	bh=J78dsazIkoKl/QHeY1XsBXrk/kkW+ncj5rTqse0vuoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+AOUw5yMz7pkAKqEL4UBv2/rn/UcEv+JvdBXLHPuBQMvGlNA3jxvtbQok0S78m3V6AP/GlSUoZFixHRU5jxTKOmqHLLRLtRnysM7RHTCSIYlDdP15Q3VWX0lnh28GUC+qprfEoo2pNSexgTeeFE/D+yQpOMKlk5Uuh6rkollaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROAUf7jV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04425C19425;
	Sat, 28 Feb 2026 17:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300462;
	bh=J78dsazIkoKl/QHeY1XsBXrk/kkW+ncj5rTqse0vuoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ROAUf7jVdZ+6xtY88a6QnfH4phHkUAa2KG6mN/tUU9pWtRwH4bi0fyXAG4JzGWg2u
	 1qWP7+evl2/YS/4VP3Aul9kCEz/rticXrVX2h21zHreqTHw17ESvCa2VXkP7ZVFjJa
	 VRKpcvahp6pcgAdvpotqTUkusNLLUci97Gm8iYn7vYDpz3iJB+UgnLYwz3MsxhFJGl
	 T/LzoaUyVP/l9NF+KvXRkxc0XIl/rg0zfy+L5Zj09yCKu8DAosp2KgKdU02XR2/yWl
	 tiQkf0ZGj5k8Qtceq0qOljStxJv26Kq2tNXRz52s+ZSeApDDCJVznDecIwp1lx+Xux
	 TX+kZfUIMSIFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 501/844] net: consume xmit errors of GSO frames
Date: Sat, 28 Feb 2026 12:26:54 -0500
Message-ID: <20260228173244.1509663-502-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220580-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 244C51C6ADF
X-Rspamd-Action: no action

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 7aa767d0d3d04e50ae94e770db7db8197f666970 ]

udpgro_frglist.sh and udpgro_bench.sh are the flakiest tests
currently in NIPA. They fail in the same exact way, TCP GRO
test stalls occasionally and the test gets killed after 10min.

These tests use veth to simulate GRO. They attach a trivial
("return XDP_PASS;") XDP program to the veth to force TSO off
and NAPI on.

Digging into the failure mode we can see that the connection
is completely stuck after a burst of drops. The sender's snd_nxt
is at sequence number N [1], but the receiver claims to have
received (rcv_nxt) up to N + 3 * MSS [2]. Last piece of the puzzle
is that senders rtx queue is not empty (let's say the block in
the rtx queue is at sequence number N - 4 * MSS [3]).

In this state, sender sends a retransmission from the rtx queue
with a single segment, and sequence numbers N-4*MSS:N-3*MSS [3].
Receiver sees it and responds with an ACK all the way up to
N + 3 * MSS [2]. But sender will reject this ack as TCP_ACK_UNSENT_DATA
because it has no recollection of ever sending data that far out [1].
And we are stuck.

The root cause is the mess of the xmit return codes. veth returns
an error when it can't xmit a frame. We end up with a loss event
like this:

  -------------------------------------------------
  |   GSO super frame 1   |   GSO super frame 2   |
  |-----------------------------------------------|
  | seg | seg | seg | seg | seg | seg | seg | seg |
  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |
  -------------------------------------------------
     x    ok    ok    <ok>|  ok    ok    ok   <x>
                          \\
			   snd_nxt

"x" means packet lost by veth, and "ok" means it went thru.
Since veth has TSO disabled in this test it sees individual segments.
Segment 1 is on the retransmit queue and will be resent.

So why did the sender not advance snd_nxt even tho it clearly did
send up to seg 8? tcp_write_xmit() interprets the return code
from the core to mean that data has not been sent at all. Since
TCP deals with GSO super frames, not individual segment the crux
of the problem is that loss of a single segment can be interpreted
as loss of all. TCP only sees the last return code for the last
segment of the GSO frame (in <> brackets in the diagram above).

Of course for the problem to occur we need a setup or a device
without a Qdisc. Otherwise Qdisc layer disconnects the protocol
layer from the device errors completely.

We have multiple ways to fix this.

 1) make veth not return an error when it lost a packet.
    While this is what I think we did in the past, the issue keeps
    reappearing and it's annoying to debug. The game of whack
    a mole is not great.

 2) fix the damn return codes
    We only talk about NETDEV_TX_OK and NETDEV_TX_BUSY in the
    documentation, so maybe we should make the return code from
    ndo_start_xmit() a boolean. I like that the most, but perhaps
    some ancient, not-really-networking protocol would suffer.

 3) make TCP ignore the errors
    It is not entirely clear to me what benefit TCP gets from
    interpreting the result of ip_queue_xmit()? Specifically once
    the connection is established and we're pushing data - packet
    loss is just packet loss?

 4) this fix
    Ignore the rc in the Qdisc-less+GSO case, since it's unreliable.
    We already always return OK in the TCQ_F_CAN_BYPASS case.
    In the Qdisc-less case let's be a bit more conservative and only
    mask the GSO errors. This path is taken by non-IP-"networks"
    like CAN, MCTP etc, so we could regress some ancient thing.
    This is the simplest, but also maybe the hackiest fix?

Similar fix has been proposed by Eric in the past but never committed
because original reporter was working with an OOT driver and wasn't
providing feedback (see Link).

Link: https://lore.kernel.org/CANn89iJcLepEin7EtBETrZ36bjoD9LrR=k4cfwWh046GB+4f9A@mail.gmail.com
Fixes: 1f59533f9ca5 ("qdisc: validate frames going through the direct_xmit path")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260223235100.108939-1-kuba@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 60a26208cbd87..062415cc3e5a4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4818,6 +4818,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 		 * to -1 or to their cpu id, but not to our id.
 		 */
 		if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
+			bool is_list = false;
+
 			if (dev_xmit_recursion())
 				goto recursion_alert;
 
@@ -4828,17 +4830,28 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 			HARD_TX_LOCK(dev, txq, cpu);
 
 			if (!netif_xmit_stopped(txq)) {
+				is_list = !!skb->next;
+
 				dev_xmit_recursion_inc();
 				skb = dev_hard_start_xmit(skb, dev, txq, &rc);
 				dev_xmit_recursion_dec();
-				if (dev_xmit_complete(rc)) {
-					HARD_TX_UNLOCK(dev, txq);
-					goto out;
-				}
+
+				/* GSO segments a single SKB into
+				 * a list of frames. TCP expects error
+				 * to mean none of the data was sent.
+				 */
+				if (is_list)
+					rc = NETDEV_TX_OK;
 			}
 			HARD_TX_UNLOCK(dev, txq);
+			if (!skb) /* xmit completed */
+				goto out;
+
 			net_crit_ratelimited("Virtual device %s asks to queue packet!\n",
 					     dev->name);
+			/* NETDEV_TX_BUSY or queue was stopped */
+			if (!is_list)
+				rc = -ENETDOWN;
 		} else {
 			/* Recursion is detected! It is possible,
 			 * unfortunately
@@ -4846,10 +4859,10 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 recursion_alert:
 			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
 					     dev->name);
+			rc = -ENETDOWN;
 		}
 	}
 
-	rc = -ENETDOWN;
 	rcu_read_unlock_bh();
 
 	dev_core_stats_tx_dropped_inc(dev);
-- 
2.51.0


