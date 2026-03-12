Return-Path: <stable+bounces-224789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENemFzknsmnlIwAAu9opvQ
	(envelope-from <stable+bounces-224789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 03:38:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B1526C507
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 03:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 233D930116B7
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 02:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CEA37C919;
	Thu, 12 Mar 2026 02:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="iIjU37XB"
X-Original-To: stable@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279C337C91D
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 02:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773283121; cv=none; b=KIjcSjKWJCrOZr6jawbpp7gH8qtDcR/foYyF0Be0TVaDzo6gio1g75/NyX8I7Mape8JCURc/hlqRX39Rb00U3m+V9Y3lUnXkgbJ4LD/mlK3aua9OaNEDPjgVMZ2yyfnZeUe6V4qZPrVZnJvjSVxhfacgUylyE86OpMFr1FzIcNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773283121; c=relaxed/simple;
	bh=ASu9LId5PB3uir9qI8OvtYBXBkct6NQOCJ52a+ECzkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H80TA2ssT4LHUQDLClqz+947MnkZmlw/V3yjoKac6iIfLBwMKdff/JY7mg7vM84Vju17MOQ/XrGMqV1zpK89u0Ij5B1LmgtshTnC7tOpiLAO+G11Z5Y3IyhVj0QMBg0gbnz/EQPiHwMOXrI5sVtROgcwxJXX8a4zZekIz0EQMfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=iIjU37XB; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=4Q
	6+Cf75Jbfxr8y3niXpUrqxJGZ/pvz/KOLqaQb4JMk=; b=iIjU37XB9CZ/Sxbbiw
	dQikq5/TT+dyW4kFbENVExAFM8+c49IaIiB62Ch1x46L1AsOgt1Kkuthi/AsFwE0
	Q7yAjxEH2NG63BGHH8O6xafKBcsu7o70pKx47feiNClbjlckHNesR33zGKZJIVhz
	iGnHW5tiBMfKDUTVEs0ckBN38=
Received: from localhost.net (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPA id Ms8vCgC33a8cJ7JpaVaNAg--.48576S2;
	Thu, 12 Mar 2026 10:38:21 +0800 (CST)
From: xietangxin <xietangxin@yeah.net>
To: xietangxin@h-partners.com
Cc: xietangxin <xietangxin@yeah.net>,
	stable@vger.kernel.org
Subject: [PATCH net v2] virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
Date: Thu, 12 Mar 2026 10:38:15 +0800
Message-ID: <20260312023815.15329-1-xietangxin@yeah.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgC33a8cJ7JpaVaNAg--.48576S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArW3XF43AFy5Jw1kArW3GFg_yoW5CFWfpF
	4YyrW5Xr4vqr17Aa93Xw4kWry8Zan5Jw13Grs0gw13u398CFy5Kr1I9ryjqFWDCFs5Z347
	ZrsYvr1UKrZ0vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbF4iUUUUU=
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiIh3XDGmyJx24wQAA38
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yeah.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[yeah.net:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224789-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[yeah.net,vger.kernel.org];
	DKIM_TRACE(0.00)[yeah.net:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[xietangxin@yeah.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[yeah.net];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,yeah.net:dkim,yeah.net:email,yeah.net:mid]
X-Rspamd-Queue-Id: 63B1526C507
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A UAF issue occurs when the virtio_net driver is configured with napi_tx=N
and the device's IFF_XMIT_DST_RELEASE flag is cleared
(e.g., during the configuration of tc route filter rules).

When IFF_XMIT_DST_RELEASE is removed from the net_device, the network stack
expects the driver to hold the reference to skb->dst until the packet
is fully transmitted and freed. In virtio_net with napi_tx=N,
skbs may remain in the virtio transmit ring for an extended period.

If the network namespace is destroyed while these skbs are still pending,
the corresponding dst_ops structure has freed. When a subsequent packet
is transmitted, free_old_xmit() is triggered to clean up old skbs.
It then calls dst_release() on the skb associated with the stale dst_entry.
Since the dst_ops (referenced by the dst_entry) has already been freed,
a UAF kernel paging request occurs.

fix it by adds skb_dst_drop(skb) in start_xmit to explicitly release
the dst reference before the skb is queued in virtio_net.

Call Trace:
 Unable to handle kernel paging request at virtual address ffff80007e150000
 CPU: 2 UID: 0 PID: 6236 Comm: ping Kdump: loaded Not tainted 7.0.0-rc1+ #6 PREEMPT
  ...
  percpu_counter_add_batch+0x3c/0x158 lib/percpu_counter.c:98 (P)
  dst_release+0xe0/0x110  net/core/dst.c:177
  skb_release_head_state+0xe8/0x108 net/core/skbuff.c:1177
  sk_skb_reason_drop+0x54/0x2d8 net/core/skbuff.c:1255
  dev_kfree_skb_any_reason+0x64/0x78 net/core/dev.c:3469
  napi_consume_skb+0x1c4/0x3a0 net/core/skbuff.c:1527
  __free_old_xmit+0x164/0x230  drivers/net/virtio_net.c:611 [virtio_net]
  free_old_xmit drivers/net/virtio_net.c:1081 [virtio_net]
  start_xmit+0x7c/0x530 drivers/net/virtio_net.c:3329 [virtio_net]
  ...

Reproduction Steps:
NETDEV="enp3s0"

config_qdisc_route_filter() {
    tc qdisc del dev $NETDEV root
    tc qdisc add dev $NETDEV root handle 1: prio
    tc filter add dev $NETDEV parent 1:0 \
	protocol ip prio 100 route to 100 flowid 1:1
    ip route add 192.168.1.100/32 dev $NETDEV realm 100
}

test_ns() {
    ip netns add testns
    ip link set $NETDEV netns testns
    ip netns exec testns ifconfig $NETDEV  10.0.32.46/24
    ip netns exec testns ping -c 1 10.0.32.1
    ip netns del testns
}

config_qdisc_route_filter

test_ns
sleep 2
test_ns

Fixes: f2fc6a54585a ("[NETNS][IPV6] route6 - move ip6_dst_ops inside the network namespace")
Cc: stable@vger.kernel.org
Signed-off-by: xietangxin <xietangxin@yeah.net>
---
changes in v2:
- add cc stable and fix tag

v1:https://lore.kernel.org/all/20260307035110.7121-1-xietangxin@yeah.net/
---
---
 drivers/net/virtio_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 72d6a9c6a..5b13a61b3 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3351,6 +3351,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* Don't wait up for transmitted skbs to be freed. */
 	if (!use_napi) {
 		skb_orphan(skb);
+		skb_dst_drop(skb);
 		nf_reset_ct(skb);
 	}
 
-- 
2.43.0


