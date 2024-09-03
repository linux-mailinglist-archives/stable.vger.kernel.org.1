Return-Path: <stable+bounces-72784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1BF9697A5
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94F3AB223DA
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 08:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040661B9850;
	Tue,  3 Sep 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nzc8AbFJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0A1B984E
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353032; cv=none; b=FItLrBQkKmWmjVCYGEl5aMSkI/TxrtVU7ubWUp4zUQzLh7hNjEmDQadpGJlXw7AJ1GAYOUhQrxWyd8I1wH5fMWR4DeQ2lNk2P910XcUZrOT+l5HY0CARZX7yrNuMTlUlg99GtHhfi7ZSbZD7N6O1e2acNQbWZE7KFGF6zGHCH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353032; c=relaxed/simple;
	bh=au3Bzne0cfXbrI/SSZYux8/FSYfMzNpAiZPF0VbkfDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VjV1ke/Zudhq/z3OtEyMsrAvYvXlJQNpdXlMZN3UXUMRJMKWJlEWnlbWKkWcyA8Epgw5gQGE/nDg+1WnN/dulxXkl27qrBND83j7uGggn7PsSGzFFxIOrcTBvranhi/bfLnUgiY4OOLTY4wZLYGm6ZB3T3UIdFxshXZlp5veyC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nzc8AbFJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bbf138477so29306065e9.2
        for <stable@vger.kernel.org>; Tue, 03 Sep 2024 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725353029; x=1725957829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7n0fHa0VKgwezs72ueNiKxl6EaorzdvI28g4TsbYQ2g=;
        b=Nzc8AbFJFkL/WDfQbAZkEwi1LisGBUi2t0cfhc896s477nTCJ0FpjaR10R6mNBqrq7
         jxlJ4NzmmrUhE6IbA5FJXhkcsrgNkaxyciWADDniMK9Iv/8LhJKj+sdoUyd9t7hm33r9
         CQjhl/5RH0wWJBXlP2sIBNRSuTDW6H1czOSE0dD8nf6x9TXVpTfIYwPFxUwcvwXk/2xN
         Jib2lLR6pwUeNjmXAw9n/mdJzW2MhAASeCRuMkSsdSIaRMapEOAVu0ww2DrrD29zBv7y
         TWZmPV61+d6o360jzd0eJv7CowOjgtf373LgpjY4rmHg35eR7CtaQVa1UGb671300DiR
         cUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725353029; x=1725957829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7n0fHa0VKgwezs72ueNiKxl6EaorzdvI28g4TsbYQ2g=;
        b=RH32dTMZB2SSItVoCT3d+j0U72ZZ4OPZ8lmkNkB7mR2cN03KyH1/tJfrBFRtDbcSun
         HwWrmjdsI5CLCo7LjWafbu/MK8USVuZXFGJ0vmfKHb5hw71ib4t+4NgTlcam4YUPcRS9
         Jzd9skFdNXP7umO2FHFsTJEFufIseCKPOutO2ExuXldSWHTJ066qtdUuLC9GkxWkrehO
         07y46IqIK/3Go0z/UJz0piiQPUbN4qP9LvNijlnxMhlQiGKoxpQrk3z5Ye/c3FHwwTw6
         VESeRyB2OUcrH/gKJIJ6mfQbhQH/njLuODZwJAKDfjYc1Oq0Dg3fwD1wAx8Gv7jC9UCm
         XmBA==
X-Gm-Message-State: AOJu0YxA56JQHw3jOTAKY2fmunIH4qADQqkFlUJbh29Q3sctyJiFJngV
	qXjVEWn5mOXLnbtaShn/DrQ55LNQTE/d1+fnr2Rb/crcRRW73FNehlIl2QEc
X-Google-Smtp-Source: AGHT+IHLuXfS8eV7R4u3x2YVwVg/oN8S4KgXUtqUuib9Em4fPwBFoZ5Ib6aTKuAaXV1BqoJpm5Gzxg==
X-Received: by 2002:a5d:5452:0:b0:36d:2984:ef6b with SMTP id ffacd0b85a97d-374ecc67b8fmr1797945f8f.11.1725353028498;
        Tue, 03 Sep 2024 01:43:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb14:499:e600:1a5e:fff:fe3d:95be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c90c6c06sm5837518f8f.84.2024.09.03.01.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:43:48 -0700 (PDT)
From: mathieu.tortuyaux@gmail.com
To: stable@vger.kernel.org
Cc: Mathieu Tortuyaux <mtortuyaux@microsoft.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] net: drop bad gso csum_start and offset in virtio_net_hdr
Date: Tue,  3 Sep 2024 10:42:26 +0200
Message-ID: <20240903084307.20562-2-mathieu.tortuyaux@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathieu Tortuyaux <mtortuyaux@microsoft.com>

[ Upstream commit 89add40066f9ed9abe5f7f886fe5789ff7e0c50e ]

Tighten csum_start and csum_offset checks in virtio_net_hdr_to_skb
for GSO packets.

The function already checks that a checksum requested with
VIRTIO_NET_HDR_F_NEEDS_CSUM is in skb linear. But for GSO packets
this might not hold for segs after segmentation.

Syzkaller demonstrated to reach this warning in skb_checksum_help

	offset = skb_checksum_start_offset(skb);
	ret = -EINVAL;
	if (WARN_ON_ONCE(offset >= skb_headlen(skb)))

By injecting a TSO packet:

WARNING: CPU: 1 PID: 3539 at net/core/dev.c:3284 skb_checksum_help+0x3d0/0x5b0
 ip_do_fragment+0x209/0x1b20 net/ipv4/ip_output.c:774
 ip_finish_output_gso net/ipv4/ip_output.c:279 [inline]
 __ip_finish_output+0x2bd/0x4b0 net/ipv4/ip_output.c:301
 iptunnel_xmit+0x50c/0x930 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x2296/0x2c70 net/ipv4/ip_tunnel.c:813
 __gre_xmit net/ipv4/ip_gre.c:469 [inline]
 ipgre_xmit+0x759/0xa60 net/ipv4/ip_gre.c:661
 __netdev_start_xmit include/linux/netdevice.h:4850 [inline]
 netdev_start_xmit include/linux/netdevice.h:4864 [inline]
 xmit_one net/core/dev.c:3595 [inline]
 dev_hard_start_xmit+0x261/0x8c0 net/core/dev.c:3611
 __dev_queue_xmit+0x1b97/0x3c90 net/core/dev.c:4261
 packet_snd net/packet/af_packet.c:3073 [inline]

The geometry of the bad input packet at tcp_gso_segment:

[   52.003050][ T8403] skb len=12202 headroom=244 headlen=12093 tailroom=0
[   52.003050][ T8403] mac=(168,24) mac_len=24 net=(192,52) trans=244
[   52.003050][ T8403] shinfo(txflags=0 nr_frags=1 gso(size=1552 type=3 segs=0))
[   52.003050][ T8403] csum(0x60000c7 start=199 offset=1536
ip_summed=3 complete_sw=0 valid=0 level=0)

Mitigate with stricter input validation.

csum_offset: for GSO packets, deduce the correct value from gso_type.
This is already done for USO. Extend it to TSO. Let UFO be:
udp[46]_ufo_fragment ignores these fields and always computes the
checksum in software.

csum_start: finding the real offset requires parsing to the transport
header. Do not add a parser, use existing segmentation parsing. Thanks
to SKB_GSO_DODGY, that also catches bad packets that are hw offloaded.
Again test both TSO and USO. Do not test UFO for the above reason, and
do not test UDP tunnel offload.

GSO packet are almost always CHECKSUM_PARTIAL. USO packets may be
CHECKSUM_NONE since commit 10154db ("udp: Allow GSO transmit
from devices with no checksum offload"), but then still these fields
are initialized correctly in udp4_hwcsum/udp6_hwcsum_outgoing. So no
need to test for ip_summed == CHECKSUM_PARTIAL first.

This revises an existing fix mentioned in the Fixes tag, which broke
small packets with GSO offload, as detected by kselftests.

Link: https://syzkaller.appspot.com/bug?extid=e1db31216c789f552871
Link: https://lore.kernel.org/netdev/20240723223109.2196886-1-kuba@kernel.org
Fixes: e269d79 ("net: missing check virtio")
Cc: stable@vger.kernel.org
Signed-off-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20240729201108.1615114-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mathieu Tortuyaux <mtortuyaux@microsoft.com>
---
Hi,

This patch fixes network failures on OpenStack VMs running with Kernel
5.15.165.

In 5.15.165, the commit "net: missing check virtio" is breaking networks
on VMs that uses virtio in some conditions.

I slightly adapted the patch to have it fitting this branch (5.15.y).

Once patched and compiled it has been successfully tested on Flatcar CI
with Kernel 5.15.165.

NOTE: This patch has already been backported on other stable branches
(like 6.6.y) 

Thanks,

Mathieu - @tormath1

 include/linux/virtio_net.h | 17 ++++++-----------
 net/ipv4/tcp_offload.c     |  3 +++
 net/ipv4/udp_offload.c     |  4 ++++
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 29b19d0a324c..d9410d97158d 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -51,7 +51,6 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	unsigned int thlen = 0;
 	unsigned int p_off = 0;
 	unsigned int ip_proto;
-	u64 ret, remainder, gso_size;
 
 	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
 		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
@@ -88,16 +87,6 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
 		u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
 
-		if (hdr->gso_size) {
-			gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
-			ret = div64_u64_rem(skb->len, gso_size, &remainder);
-			if (!(ret && (hdr->gso_size > needed) &&
-						((remainder > needed) || (remainder == 0)))) {
-				return -EINVAL;
-			}
-			skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
-		}
-
 		if (!pskb_may_pull(skb, needed))
 			return -EINVAL;
 
@@ -163,6 +152,12 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		if (gso_size == GSO_BY_FRAGS)
 			return -EINVAL;
 
+		if ((gso_size & SKB_GSO_TCPV4) ||
+			(gso_size & SKB_GSO_TCPV6)) {
+				if (skb->csum_offset != offsetof(struct tcphdr, check))
+					return -EINVAL;
+		}
+
 		/* Too small packets are not really GSO ones. */
 		if (skb->len - nh_off > gso_size) {
 			shinfo->gso_size = gso_size;
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fc61cd3fea65..76684cbd63a4 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -71,6 +71,9 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	if (thlen < sizeof(*th))
 		goto out;
 
+    if (unlikely(skb_checksum_start(skb) != skb_transport_header(skb)))
+        goto out;
+
 	if (!pskb_may_pull(skb, thlen))
 		goto out;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index c61268849948..61773a26fb34 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -279,6 +279,10 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	if (gso_skb->len <= sizeof(*uh) + mss)
 		return ERR_PTR(-EINVAL);
 
+    if (unlikely(skb_checksum_start(gso_skb) !=
+                skb_transport_header(gso_skb)))
+        return ERR_PTR(-EINVAL);
+
 	skb_pull(gso_skb, sizeof(*uh));
 
 	/* clear destructor to avoid skb_segment assigning it to tail */
-- 
2.44.2


