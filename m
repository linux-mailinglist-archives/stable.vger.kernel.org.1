Return-Path: <stable+bounces-224138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGEuMOX+r2mQeQIAu9opvQ
	(envelope-from <stable+bounces-224138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B09624A821
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E9A23072463
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCB8389E1F;
	Tue, 10 Mar 2026 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVNE6e+I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE6C38735B;
	Tue, 10 Mar 2026 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141271; cv=none; b=Rh/ojFYaWzCp9hOvCN0BsGtPALZYcRvH5iXNOGeYfUe1bjyknMK3SCRECrd+UGYIDTcjHETkH+Mtnu+JOof3BCpnZLCFnYh4yZGagZGcocZgDunbqOdz4skQKIswNL/Ia13R3h1BKehxZcZalrp8oivoi+Bqq2bo7Lv1GUmdZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141271; c=relaxed/simple;
	bh=gE3N8uL+PC3g6ct0fDJsJH+Z6tlr7Hy10cr8yANXkrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsyfXPJRL6hqTjdqhIBtwxlDSigKDp+f1d9IiEJtWhzvDEDnIVraQTSyqgXT+hgWaBFd0PnSWLEifLwNWCFdjcXPOWD9e12aXimt1HS9ihYF4kDGJBj2YFJCLyTaKaEau9RFzS4rwjOyH7ifyhcSnYTjoS0VBEPCnrZPAXZJbhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVNE6e+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920A1C19423;
	Tue, 10 Mar 2026 11:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141271;
	bh=gE3N8uL+PC3g6ct0fDJsJH+Z6tlr7Hy10cr8yANXkrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZVNE6e+ILau/o4cVDuHxbxY/2TQSb2hwg+Bp4NeBNSg6SlJGfEuEcCrD9MohSUbsB
	 n1UqqNehiaVoIvPVf58lNmO43cQ2CYjI/xoOVRZ32Nz0uNnSSXQHwW8E1iHpgZqzN6
	 1yRAdFGYQLKP+YMbDZdhAhZ9gPyX2gpSe9ICdhb8K7IS6kOv+ArsQXcaaMc58bu+eq
	 W9W+0wJQBKUCVFeBHFEVL3v9+W8xZSaluy2wkYp3du32Q1zkT/jvCqEiEr9zTnpEC1
	 7Gcl97B07fVYgdkg3Jr2/K++G7cKDE3IZnJci6srUKjD9lGmmst7LJUKsIR28oYJHR
	 QvMZzeRm6OA1Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Koichiro Den <den@valinux.co.jp>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 273/311] net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue race for lockless qdiscs
Date: Tue, 10 Mar 2026 07:05:20 -0400
Message-ID: <66a5430015dad3d0f73f261de298866608b0edf2.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B09624A821
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
	TAGGED_FROM(0.00)[bounces-224138-lists,stable=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:email,msgid.link:url]
X-Rspamd-Action: no action

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
index c3a7268b567e0..d5d55cb21686d 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -778,13 +778,23 @@ static inline bool skb_skip_tc_classify(struct sk_buff *skb)
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


