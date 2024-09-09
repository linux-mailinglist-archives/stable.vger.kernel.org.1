Return-Path: <stable+bounces-74081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0729721D5
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 20:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AA11C23023
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 18:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A490518991E;
	Mon,  9 Sep 2024 18:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqlfvKXU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93481898F1;
	Mon,  9 Sep 2024 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725906318; cv=none; b=c3gEB7vKaiTQHGAi/RB+a94wnFLXq26tUB3u0TTCOdXeIe1d5MQVYmidyrVdhnR77NUSDMNSgqD2ehpOq60YKvZbYTQl1nMY7opL103GCqHBgKnKsbUgUmcVFgGVBLOyELKSLFhuVbaGGRtbzx1Mk4vD7MdlVZXtJVerEO3Gr64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725906318; c=relaxed/simple;
	bh=c0UkyO4dRrZt6YTLPCWHFSnlwf8AjfAg1BDn+9MD5Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g8VqT8bgiZvy/plyH6h+8eAOZlQLO4QwE58HBT8ah3Ukfj1TSNxY50+aqOwGa6ZZTIEfCVQODG/6L+TybTSay+q7oSV8pPDu9yD2hrvFzuvoMrAfqM1wbg3F68IMwJTJ/m7vYTuXr/C9wSetXKckkLEHoWDI0Xxz7DHTaYT/Jb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqlfvKXU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-45821ebb4e6so14263591cf.2;
        Mon, 09 Sep 2024 11:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725906316; x=1726511116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX9Sc+83Yo9dOLkn3aa7t0ygd0a58dUOvhxdQ/fmNtw=;
        b=RqlfvKXU767vgZ+3a86gEQH9rn1vv4c5gf/fDLLuTCz7OW6NBOSACPnDOTkpQHJ7Hc
         lGYxxh8eiQJTWR25YeXG1+Pdn+Ifz1mDnNu9DpQLXvZ/L6aqEtKCrFHfKydDj55RIL+9
         NhvGtOiOyEXC53tb1iJVtKCpSR7nXqkVeJh7hghafa2ndAUV/twk/29WbbeGU5nufsXQ
         CZt9WjxSt1h+pl1vLnBU/31O3rHoA3851Cfneiiy40PuCIDmoW/fcyePtH8ps0VT9H9g
         yrzOyBpA1LiUBLSU1qBIjbK/MMJiz8MJ6uoO76Uxp+LrzYfshEZDzPYz+T+K+/orIDG4
         PUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725906316; x=1726511116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RX9Sc+83Yo9dOLkn3aa7t0ygd0a58dUOvhxdQ/fmNtw=;
        b=nSmwQ1ip2EizpT924ly7BrTdP0FIRgGdJvvcINUW6nc4mOZdK8sEwfJ8w54bn+a4gX
         g9C2r92sisqOaz77sWDS3h3UGZp8U1p7ANaUkVYqbtUzXu7dUmdzo45rmVC+a9tjXRdD
         H0HLBff6xf5eGPk3yA0+wqCMVcxnTTEot3VQ995UBoRTdpU2J+EOUACpgsxOhBN+ifLD
         20dnf4/8W7tGIfhQL3S4J2hbvHfi+ctoBUUzsrv6zIQcV5Quo+umJpbkXci12/UyK3Nh
         aJRdTIEODicLixRE4RkodF3/U8EmVmD7vzkTZ8inA4JkGLSJMe12xJ9o45mKFCH6APvh
         OacA==
X-Gm-Message-State: AOJu0YyspEkek/NLE74ZLXYyC7eT8Ch8c2FCCs0VTE6Xuqrdya1EVUcy
	FwwWgq7TXQqYEXIXAqdWGNjJTgwroHRGB+ylreSEHdNuOFsxlB7WEmMPCA==
X-Google-Smtp-Source: AGHT+IH8vrfyH4CVR4LmtRFTnHoqZO218qLFkLD5vUp5YoTcjLWB4NFqico01KG9srpvuLW28BZqMw==
X-Received: by 2002:a05:622a:6a85:b0:458:2182:b07a with SMTP id d75a77b69052e-4582182b5acmr91986271cf.18.1725906315659;
        Mon, 09 Sep 2024 11:25:15 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e9b231sm22539071cf.47.2024.09.09.11.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 11:25:14 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: stable@vger.kernel.org
Cc: netdev@vger.kernel.org,
	gregkh@linuxfoundation.org,
	christian@theune.cc,
	mathieu.tortuyaux@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 4/4] net: drop bad gso csum_start and offset in virtio_net_hdr
Date: Mon,  9 Sep 2024 14:22:48 -0400
Message-ID: <20240909182506.270136-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240909182506.270136-1-willemdebruijn.kernel@gmail.com>
References: <20240909182506.270136-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

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
CHECKSUM_NONE since commit 10154dbded6d6 ("udp: Allow GSO transmit
from devices with no checksum offload"), but then still these fields
are initialized correctly in udp4_hwcsum/udp6_hwcsum_outgoing. So no
need to test for ip_summed == CHECKSUM_PARTIAL first.

This revises an existing fix mentioned in the Fixes tag, which broke
small packets with GSO offload, as detected by kselftests.

Link: https://syzkaller.appspot.com/bug?extid=e1db31216c789f552871
Link: https://lore.kernel.org/netdev/20240723223109.2196886-1-kuba@kernel.org
Fixes: e269d79c7d35 ("net: missing check virtio")
Cc: stable@vger.kernel.org
Signed-off-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20240729201108.1615114-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[5.15 stable: clean backport]
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/linux/virtio_net.h | 16 +++++-----------
 net/ipv4/tcp_offload.c     |  3 +++
 net/ipv4/udp_offload.c     |  4 ++++
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 137357fb6a574..823e28042f410 100644
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
 
@@ -170,6 +159,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 			if (gso_type != SKB_GSO_UDP_L4)
 				return -EINVAL;
 			break;
+		case SKB_GSO_TCPV4:
+		case SKB_GSO_TCPV6:
+			if (skb->csum_offset != offsetof(struct tcphdr, check))
+				return -EINVAL;
+			break;
 		}
 
 		/* Kernel has a special handling for GSO_BY_FRAGS. */
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fc61cd3fea652..357d3be04f84c 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -71,6 +71,9 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	if (thlen < sizeof(*th))
 		goto out;
 
+	if (unlikely(skb_checksum_start(skb) != skb_transport_header(skb)))
+		goto out;
+
 	if (!pskb_may_pull(skb, thlen))
 		goto out;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index f0bc91af94d7c..e009247ca7f14 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -276,6 +276,10 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	if (gso_skb->len <= sizeof(*uh) + mss)
 		return ERR_PTR(-EINVAL);
 
+	if (unlikely(skb_checksum_start(gso_skb) !=
+		     skb_transport_header(gso_skb)))
+		return ERR_PTR(-EINVAL);
+
 	if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
 		/* Packet is from an untrusted source, reset gso_segs. */
 		skb_shinfo(gso_skb)->gso_segs = DIV_ROUND_UP(gso_skb->len - sizeof(*uh),
-- 
2.46.0.598.g6f2099f65c-goog


