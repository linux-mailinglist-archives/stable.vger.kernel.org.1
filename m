Return-Path: <stable+bounces-229605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEsxIsxrwWlMTAQAu9opvQ
	(envelope-from <stable+bounces-229605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:35:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B4C2F85FB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6046D30138D6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69EE3BE166;
	Mon, 23 Mar 2026 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H1AEm2Tz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737A3BD646;
	Mon, 23 Mar 2026 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282371; cv=none; b=ogx763YdcWOR13LFRoxStyK7Tk4acydjKUNk/i+73KfOPhEBeYCZEtTzHghY+4CuHNFNVlpcMg1B8JU4YwELW3oF/QCx3q/6+Ifm3mbI9fuH6pJfgmU8oceBFNvohVswJnboxccuZVvwa3HAKCaGH+vEG1L5c4KAR9aCXimS0L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282371; c=relaxed/simple;
	bh=CTX3ZzeEnxo226BfY7lXQ1t1D1brwT2b/1t3xC3D7B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FI5jlVcs8wWBP01kywsX42uijHE4czrZXWkojPnAkoE0wCrkPcAogTVYzoInIbxFnSwl9/0FLykHmATbjMquQokFDHveq+ASZ75ay4mNJvVElBNr9m0HW0HDxZRnI7J9I41eQdcg0+6AxbdN7X3+rJwY08rfdxI34+VMnSLkxXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H1AEm2Tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D770AC2BC9E;
	Mon, 23 Mar 2026 16:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282371;
	bh=CTX3ZzeEnxo226BfY7lXQ1t1D1brwT2b/1t3xC3D7B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1AEm2TzEXETFevRKyhAhy0OJdwkJB2ugc7kK0Vh73Uk+RMqf3Ii+U/iKg7jLlkYm
	 b9xV90IPPu6S91QjZo1rQzQulb9Xfcr0r8toCl5AGpyN61fUlCa1RYrkKDjaBhZYdR
	 POJwwKeI6cKLaIHjTOC/utDW0BY6dOtlJG135tTo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Koichiro Den <den@valinux.co.jp>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 130/481] net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue race for lockless qdiscs
Date: Mon, 23 Mar 2026 14:41:52 +0100
Message-ID: <20260323134528.437790838@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229605-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 89B4C2F85FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Koichiro Den <den@valinux.co.jp>

[ Upstream commit 7f083faf59d14c04e01ec05a7507f036c965acf8 ]

When shrinking the number of real tx queues,
netif_set_real_num_tx_queues() calls qdisc_reset_all_tx_gt() to flush
qdiscs for queues which will no longer be used.

qdisc_reset_all_tx_gt() currently serializes qdisc_reset() with
qdisc_lock(). However, for lockless qdiscs, the dequeue path is
serialized by qdisc_run_begin/end() using qdisc->seqlock instead, so
qdisc_reset() can run concurrently with __qdisc_run() and free skbs
while they are still being dequeued, leading to UAF.

This can easily be reproduced on e.g. virtio-net by imposing heavy
traffic while frequently changing the number of queue pairs:

  iperf3 -ub0 -c $peer -t 0 &
  while :; do
    ethtool -L eth0 combined 1
    ethtool -L eth0 combined 2
  done

With KASAN enabled, this leads to reports like:

  BUG: KASAN: slab-use-after-free in __qdisc_run+0x133f/0x1760
  ...
  Call Trace:
   <TASK>
   ...
   __qdisc_run+0x133f/0x1760
   __dev_queue_xmit+0x248f/0x3550
   ip_finish_output2+0xa42/0x2110
   ip_output+0x1a7/0x410
   ip_send_skb+0x2e6/0x480
   udp_send_skb+0xb0a/0x1590
   udp_sendmsg+0x13c9/0x1fc0
   ...
   </TASK>

  Allocated by task 1270 on cpu 5 at 44.558414s:
   ...
   alloc_skb_with_frags+0x84/0x7c0
   sock_alloc_send_pskb+0x69a/0x830
   __ip_append_data+0x1b86/0x48c0
   ip_make_skb+0x1e8/0x2b0
   udp_sendmsg+0x13a6/0x1fc0
   ...

  Freed by task 1306 on cpu 3 at 44.558445s:
   ...
   kmem_cache_free+0x117/0x5e0
   pfifo_fast_reset+0x14d/0x580
   qdisc_reset+0x9e/0x5f0
   netif_set_real_num_tx_queues+0x303/0x840
   virtnet_set_channels+0x1bf/0x260 [virtio_net]
   ethnl_set_channels+0x684/0xae0
   ethnl_default_set_doit+0x31a/0x890
   ...

Serialize qdisc_reset_all_tx_gt() against the lockless dequeue path by
taking qdisc->seqlock for TCQ_F_NOLOCK qdiscs, matching the
serialization model already used by dev_reset_queue().

Additionally clear QDISC_STATE_NON_EMPTY after reset so the qdisc state
reflects an empty queue, avoiding needless re-scheduling.

Fixes: 6b3ba9146fe6 ("net: sched: allow qdiscs to handle locking")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
Link: https://patch.msgid.link/20260228145307.3955532-1-den@valinux.co.jp
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sch_generic.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index b34e9e93a1463..7bb73448de0d3 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -724,13 +724,23 @@ static inline bool skb_skip_tc_classify(struct sk_buff *skb)
 static inline void qdisc_reset_all_tx_gt(struct net_device *dev, unsigned int i)
 {
 	struct Qdisc *qdisc;
+	bool nolock;
 
 	for (; i < dev->num_tx_queues; i++) {
 		qdisc = rtnl_dereference(netdev_get_tx_queue(dev, i)->qdisc);
 		if (qdisc) {
+			nolock = qdisc->flags & TCQ_F_NOLOCK;
+
+			if (nolock)
+				spin_lock_bh(&qdisc->seqlock);
 			spin_lock_bh(qdisc_lock(qdisc));
 			qdisc_reset(qdisc);
 			spin_unlock_bh(qdisc_lock(qdisc));
+			if (nolock) {
+				clear_bit(__QDISC_STATE_MISSED, &qdisc->state);
+				clear_bit(__QDISC_STATE_DRAINING, &qdisc->state);
+				spin_unlock_bh(&qdisc->seqlock);
+			}
 		}
 	}
 }
-- 
2.51.0




