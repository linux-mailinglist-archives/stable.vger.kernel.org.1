Return-Path: <stable+bounces-216756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPMyG5GRk2lH6gEAu9opvQ
	(envelope-from <stable+bounces-216756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 22:52:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A657147CEC
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 22:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 944AE301DE28
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 21:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DACD286D70;
	Mon, 16 Feb 2026 21:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="lHp+qOYW"
X-Original-To: stable@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431CA284B37;
	Mon, 16 Feb 2026 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771278731; cv=none; b=LczWayZjIyc1UVNfwtWBt8GA9CDDef8T6jt7d2h4EnUndGqAe73g8Y6uV6E2rNGf7gGjSdZMnAfcikguJhB20JkvS+s0t7t4PUYlBe+fbNkw90UxZB5DC4TzjkZsPsF1ciDu13iU+CMCqwSKapTtctAWkt+dUGNoJ8cIhywR2EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771278731; c=relaxed/simple;
	bh=K/jl3q7PbM2I0IDdTYuJe0oNw9BihhMXwuK0Aw/zPSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eHyw42A6w2AIkwchg1z2gNmiy3QT/7tvoTiXgnOGrTUlLF1/qzq7h3/ar0Au9y75v5bmprLAx7cp6wVirGVnHwT+pclfWCv0xs83WyPLT8qtVBbFpQk9o6A6cG9HB4TOY49tChaoCJt+xdF3V2uNO83qlUVydTEOiMQiybu8/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=lHp+qOYW; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=hMzNNZX1fqAgDrNz9xQpK6Mu2Wf80+XMxObH+vAO4eA=; b=lHp+qOYW/nCOORFo/eQAdpKxlZ
	A2TMhas0lo2TRCZ55CGyviZciTJIbzs/sFJF+MdzD7gFvrNE/R5VEj8gyP5HwdsVU4DGnoXujtG1i
	YkcD9MpekPxLNEPIzj3G7FQi6QCYaawqRuxejy2nyLondzQBk1466i9kBS5GArDrjtRQQe3KgSfom
	V0Gv1XMYAM9XAI9YE2L2ufY6nkX832IKrvM4ZIUL4MagCuc27xqMzMVL/K3dfibJqJD4KavqXz5ol
	CsumHEUL0EgeAPsALu3bfBMhYcZpddh28xhEW2iBk/4JLItI+yu1I7U3SBCMPRbkiXoLZ4PTkEeaF
	ghCHj+8Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vs6BW-0002o7-26;
	Mon, 16 Feb 2026 22:31:14 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason@zx2c4.com,
	kuba@kernel.org
Subject: [PATCH stable v5.15,v6.1] Revert "wireguard: device: enable threaded NAPI"
Date: Mon, 16 Feb 2026 22:31:13 +0100
Message-ID: <c05f3968fa63b630ce22d65aa03e6dcef4bf4e83.1771277247.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27914/Mon Feb 16 08:24:56 2026)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216756-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:mid,iogearbox.net:dkim,iogearbox.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A657147CEC
X-Rspamd-Action: no action

This reverts the backport of upstream commit db9ae3b6b43c ("wireguard:
device: enable threaded NAPI").

We have had three independent production user reports in combination
with Cilium utilizing WireGuard as encryption underneath that k8s Pod
E/W traffic to certain peer nodes fully stalled. The situation appears
as follows:

  - Occurs very rarely but at random times under heavy networking load.
  - Once the issue triggers the decryption side stops working completely
    for that WireGuard peer, other peers keep working fine. The stall
    happens also for newly initiated connections towards that particular
    WireGuard peer.
  - Only the decryption side is affected, never the encryption side.
  - Once it triggers, it never recovers and remains in this state,
    the CPU/mem on that node looks normal, no leak, busy loop or crash.
  - bpftrace on the affected system shows that wg_prev_queue_enqueue
    fails, thus the MAX_QUEUED_PACKETS (1024 skbs!) for the peer's
    rx_queue is reached.
  - Also, bpftrace shows that wg_packet_rx_poll for that peer is never
    called again after reaching this state for that peer. For other
    peers wg_packet_rx_poll does get called normally.
  - Commit db9ae3b ("wireguard: device: enable threaded NAPI")
    switched WireGuard to threaded NAPI by default. The default has
    not been changed for triggering the issue, neither did CPU
    hotplugging occur (i.e. 5bd8de2 ("wireguard: queueing: always
    return valid online CPU in wg_cpumask_choose_online()")).
  - The issue has been observed with stable kernels of v5.15 as well as
    v6.1. It was reported to us that v5.10 stable is working fine, and
    no report on v6.6 stable either (somewhat related discussion in [0]
    though).
  - In the WireGuard driver the only material difference between v5.10
    stable and v5.15 stable is the switch to threaded NAPI by default.

    [0] https://lore.kernel.org/netdev/CA+wXwBTT74RErDGAnj98PqS=wvdh8eM1pi4q6tTdExtjnokKqA@mail.gmail.com/

Breakdown of the problem:

  1) skbs arriving for decryption are enqueued to the peer->rx_queue in
     wg_packet_consume_data via wg_queue_enqueue_per_device_and_peer.
  2) The latter only moves the skb into the MPSC peer queue if it does
     not surpass MAX_QUEUED_PACKETS (1024) which is kept track in an
     atomic counter via wg_prev_queue_enqueue.
  3) In case enqueueing was successful, the skb is also queued up
     in the device queue, round-robin picks a next online CPU, and
     schedules the decryption worker.
  4) The wg_packet_decrypt_worker, once scheduled, picks these up
     from the queue, decrypts the packets and once done calls into
     wg_queue_enqueue_per_peer_rx.
  5) The latter updates the state to PACKET_STATE_CRYPTED on success
     and calls napi_schedule on the per peer->napi instance.
  6) NAPI then polls via wg_packet_rx_poll. wg_prev_queue_peek checks
     on the peer->rx_queue. It will wg_prev_queue_dequeue if the
     queue->peeked skb was not cached yet, or just return the latter
     otherwise. (wg_prev_queue_drop_peeked later clears the cache.)
  7) From an ordering perspective, the peer->rx_queue has skbs in order
     while the device queue with the per-CPU worker threads from a
     global ordering PoV can finish the decryption and signal the skb
     PACKET_STATE_CRYPTED out of order.
  8) A situation can be observed that the first packet coming in will
     be stuck waiting for the decryption worker to be scheduled for
     a longer time when the system is under pressure.
  9) While this is the case, the other CPUs in the meantime finish
     decryption and call into napi_schedule.
 10) Now in wg_packet_rx_poll it picks up the first in-order skb
     from the peer->rx_queue and sees that its state is still
     PACKET_STATE_UNCRYPTED. The NAPI poll routine then exits early
     with work_done = 0 and calls napi_complete_done, signalling
     it "finished" processing.
 11) The assumption in wg_packet_decrypt_worker is that when the
     decryption finished the subsequent napi_schedule will always
     lead to a later invocation of wg_packet_rx_poll to pick up
     the finished packet.
 12) However, it appears that a later napi_schedule does /not/
     schedule a later poll and thus no wg_packet_rx_poll.
 13) If this situation happens exactly for the corner case where
     the decryption worker of the first packet is stuck and waiting
     to be scheduled, and the network load for WireGuard is very
     high then the queue can build up to MAX_QUEUED_PACKETS.
 14) If this situation occurs, then no new decryption worker will
     be scheduled and also no new napi_schedule to make forward
     progress.
 15) This means the peer->rx_queue stops processing packets completely
     and they are indefinitely stuck waiting for a new NAPI poll on
     that peer which never happens. New packets for that peer are
     then dropped due to full queue, as it has been observed on the
     production machines.

Technically, the backport of commit db9ae3b6b43c ("wireguard: device:
enable threaded NAPI") to stable should not have happened since it is
more of an optimization rather than a pure fix and addresses a NAPI
situation with utilizing many WireGuard tunnel devices in parallel.
Revert it from stable given the backport triggers a regression for
mentioned kernels.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 drivers/net/wireguard/device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 7bf1ec4ccaa9..e5e344af3423 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -352,7 +352,6 @@ static int wg_newlink(struct net *src_net, struct net_device *dev,
 	if (ret < 0)
 		goto err_free_handshake_queue;
 
-	dev_set_threaded(dev, true);
 	ret = register_netdevice(dev);
 	if (ret < 0)
 		goto err_uninit_ratelimiter;
-- 
2.43.0


