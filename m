Return-Path: <stable+bounces-253921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDk4D2+HEWqdnAYAu9opvQ
	(envelope-from <stable+bounces-253921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 12:54:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E225BE925
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 12:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3380630166E8
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 10:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A9234F48A;
	Sat, 23 May 2026 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="qTQYoXQC"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892631991D4;
	Sat, 23 May 2026 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779533670; cv=none; b=mC4U0U8s3ZX7ShhzJeJCCu795Us5DvB+oCCTW7RKqHjEGEV92lQqlRIeyncWuYm5cDWdymrQfMDTfHwRkCvoDyPjBXfedVOXl6ZQH3d/SOkYYFQCAvQ/O+fGgmiaLjqUWel0WJaGLdpN4qsgz4Quyt27kOjSEsEVRMOaXlPHqe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779533670; c=relaxed/simple;
	bh=Swbx9eyynEokKKR/wwqf9s/qC/zsk5Ve97QyIjamFGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i5Pu+TqWF0v1wZ4UWmJGr/qqzETtH3bQCz/aQz3BZEfv9WE6D8qCAwj1uVpPMQNR7pBhmUmKL+7AU/IIM24PqvZ30UoFoBMSWFKgX4SsHnPR68dxrDIgmOxpqgM+R2PJPYqF4ex70YMV6Nq+SDZXjXwjeczJqMAdx5zSS6c3CQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=qTQYoXQC; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.7])
	by mail.ispras.ru (Postfix) with ESMTPSA id 35D5445F7992;
	Sat, 23 May 2026 10:48:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 35D5445F7992
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1779533317;
	bh=5rhMn95wNx50e9E5MEKylgbrKweX3eByB6xbBWS3V4M=;
	h=From:To:Cc:Subject:Date:From;
	b=qTQYoXQCgWs20LtrXIiNWGH4GHzK3cXJB/mbS/4qfSc4gyszGUqVKLgUe+bmJCH2Z
	 5b/gNyZJC2/kh96DSYYzxVKy9GJEy5pnj2SO93N4bC15F51EAtwiFKIYJdVGB2DhqX
	 X/9o4rU645IuboB8elVyWduwzqQeQa8rnKpgY1qE=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jie Deng <Jie.Deng1@synopsys.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] net: dwc-xlgmac: fix channel count initialization
Date: Sat, 23 May 2026 13:45:27 +0300
Message-ID: <20260523104740.295650-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ispras.ru,none];
	R_DKIM_ALLOW(-0.20)[ispras.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-253921-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pchelkin@ispras.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ispras.ru:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ispras.ru:email,ispras.ru:mid,ispras.ru:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qemu.org:url]
X-Rspamd-Queue-Id: C8E225BE925
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The number of channels used by the driver is determined by the maximum
value of TX and RX rings.  Currently it is initialized once during the
driver's probing phase.  However, the value is zeroed inside
xlgmac_free_channels() when closing the interface.  The further attempts
to transmit data after reopening the interface fail with a crash because
xlgmac_alloc_channels() "allocates" a ZERO_SIZE_PTR channel_head now which
is directly dereferenced in xmit path.

general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 1 PID: 21 Comm: kworker/1:0 Not tainted 6.1.164 #116
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
Workqueue: mld mld_ifc_work
RIP: 0010:xlgmac_xmit+0xde/0x13f0 drivers/net/ethernet/synopsys/dwc-xlgmac-net.c:716
Call Trace:
 <TASK>
 __netdev_start_xmit include/linux/netdevice.h:4896 [inline]
 netdev_start_xmit include/linux/netdevice.h:4910 [inline]
 xmit_one net/core/dev.c:3683 [inline]
 dev_hard_start_xmit+0x126/0x680 net/core/dev.c:3699
 sch_direct_xmit+0x18a/0x7e0 net/sched/sch_generic.c:345
 __dev_xmit_skb net/core/dev.c:3920 [inline]
 __dev_queue_xmit+0x19ef/0x3da0 net/core/dev.c:4325
 dev_queue_xmit include/linux/netdevice.h:3051 [inline]
 neigh_resolve_output net/core/neighbour.c:1568 [inline]
 neigh_resolve_output+0x563/0x880 net/core/neighbour.c:1548
 neigh_output include/net/neighbour.h:545 [inline]
 ip6_finish_output2+0xb4f/0x2390 net/ipv6/ip6_output.c:138
 __ip6_finish_output+0x48c/0x1300 net/ipv6/ip6_output.c:205
 ip6_finish_output net/ipv6/ip6_output.c:216 [inline]
 NF_HOOK_COND include/linux/netfilter.h:291 [inline]
 ip6_output+0x250/0x910 net/ipv6/ip6_output.c:237
 dst_output include/net/dst.h:453 [inline]
 NF_HOOK.constprop.0+0x111/0x8a0 include/linux/netfilter.h:302
 mld_sendpack+0x67b/0xd40 net/ipv6/mcast.c:1825
 mld_send_cr net/ipv6/mcast.c:2126 [inline]
 mld_ifc_work+0x7a5/0xd80 net/ipv6/mcast.c:2656
 process_one_work+0x97f/0x1470 kernel/workqueue.c:2292
 worker_thread+0x5a1/0x1090 kernel/workqueue.c:2439
 kthread+0x2e1/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x22/0x30 arch/x86/entry/entry_64.S:295

Move the pdata->channel_count initialization into xlgmac_alloc_channels()
where it logically belongs.  Nothing should touch the channel-related
properties before this function succeeds anyway.

This also makes it similar to the pattern of pdata->channel_count handling
preferred in akin amd-xgbe driver.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 65e0ace2c5cd ("net: dwc-xlgmac: Initial driver for DesignWare Enterprise Ethernet")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/net/ethernet/synopsys/dwc-xlgmac-common.c | 6 +-----
 drivers/net/ethernet/synopsys/dwc-xlgmac-desc.c   | 9 +++++----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/synopsys/dwc-xlgmac-common.c b/drivers/net/ethernet/synopsys/dwc-xlgmac-common.c
index 131786aa4d5b..9275f64401e4 100644
--- a/drivers/net/ethernet/synopsys/dwc-xlgmac-common.c
+++ b/drivers/net/ethernet/synopsys/dwc-xlgmac-common.c
@@ -98,8 +98,7 @@ static int xlgmac_init(struct xlgmac_pdata *pdata)
 		return ret;
 	}
 
-	/* Channel and ring params initializtion
-	 *  pdata->channel_count;
+	/* Ring params initialization
 	 *  pdata->tx_ring_count;
 	 *  pdata->rx_ring_count;
 	 *  pdata->tx_desc_count;
@@ -145,9 +144,6 @@ static int xlgmac_init(struct xlgmac_pdata *pdata)
 		return ret;
 	}
 
-	pdata->channel_count =
-		max_t(unsigned int, pdata->tx_ring_count, pdata->rx_ring_count);
-
 	/* Initialize RSS hash key and lookup table */
 	netdev_rss_key_fill(pdata->rss_key, sizeof(pdata->rss_key));
 
diff --git a/drivers/net/ethernet/synopsys/dwc-xlgmac-desc.c b/drivers/net/ethernet/synopsys/dwc-xlgmac-desc.c
index 2a40257ab47c..e08cd28c8699 100644
--- a/drivers/net/ethernet/synopsys/dwc-xlgmac-desc.c
+++ b/drivers/net/ethernet/synopsys/dwc-xlgmac-desc.c
@@ -230,10 +230,11 @@ static int xlgmac_alloc_channels(struct xlgmac_pdata *pdata)
 {
 	struct xlgmac_channel *channel_head, *channel;
 	struct xlgmac_ring *tx_ring, *rx_ring;
+	unsigned int i, count;
 	int ret = -ENOMEM;
-	unsigned int i;
 
-	channel_head = kzalloc_objs(struct xlgmac_channel, pdata->channel_count);
+	count = max_t(unsigned int, pdata->tx_ring_count, pdata->rx_ring_count);
+	channel_head = kzalloc_objs(struct xlgmac_channel, count);
 	if (!channel_head)
 		return ret;
 
@@ -248,8 +249,7 @@ static int xlgmac_alloc_channels(struct xlgmac_pdata *pdata)
 	if (!rx_ring)
 		goto err_rx_ring;
 
-	for (i = 0, channel = channel_head; i < pdata->channel_count;
-		i++, channel++) {
+	for (i = 0, channel = channel_head; i < count; i++, channel++) {
 		snprintf(channel->name, sizeof(channel->name), "channel-%u", i);
 		channel->pdata = pdata;
 		channel->queue_index = i;
@@ -281,6 +281,7 @@ static int xlgmac_alloc_channels(struct xlgmac_pdata *pdata)
 	}
 
 	pdata->channel_head = channel_head;
+	pdata->channel_count = count;
 
 	return 0;
 
-- 
2.53.0


