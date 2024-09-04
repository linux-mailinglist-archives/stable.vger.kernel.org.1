Return-Path: <stable+bounces-72968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AED96B332
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 09:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E22A284B38
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 07:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E03813212B;
	Wed,  4 Sep 2024 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="cD+KzbPB"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9CC823DE
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 07:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435955; cv=none; b=S9riQRIBekKztM+7ZsDwkARF93fRtsGeAG5E8jg4KPVFb5yzjXhX4OoXbnrwb4ho3yx+u76+CPiPw0di5nQIvaALX9i879nx4VzGHaRbNi2moVPlPtts+hYldd8mWZ9hVPYNPFZQbXNdRxGF3TGwmg/m6J1ayu17mMhzUZGORfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435955; c=relaxed/simple;
	bh=wqC8/ZiPAlnc4dTaCQbC06y9eVGVoy/qaMRgWhMFIww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Naclx+mX/SKar/tqIpvLm1sdVr++mAk23kXaspu1Y+S07EiwJbS2+t9ZFoyZ1komKgmeY2DqBEQRVIwEe+5SlU8Swb1ORypykggzpLe6JkhE7mUGC0mtgRu4JNL/sxoA8p5D5Waa9fItIffmHFCgFFY+TYlqX/xHjRDRz5QpoFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=cD+KzbPB; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1725435404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bC5PrfUTDObRDleXarsjObmYqZdt/QmLj0WFkPAo3yI=;
	b=cD+KzbPBJpfuPrm9kW2jOTpYOnvP4Hztw9Tdti7mgnvY/p7aSgoEZkxNgyiRGtdj1dvwnT
	jP6YUePuxyvEWbM3Yz05AieG/jZH9gIYXrOTtRsXem37sNk0xk5Tia3uJv/2eEUsbPte0L
	442lwxvApLZlNy8fQBi+ds7p5NmyQ3s=
To: darefyev@mail.ru
Cc: Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] net: drop bad gso csum_start and offset in virtio_net_hdr
Date: Wed,  4 Sep 2024 10:36:44 +0300
Message-Id: <20240904073644.11966-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

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
(cherry picked from commit 89add40066f9ed9abe5f7f886fe5789ff7e0c50e)
---
 include/linux/virtio_net.h | 22 ++++++++++++++++++++--
 net/ipv4/tcp_offload.c     |  3 +++
 net/ipv4/udp_offload.c     | 18 +++++++++++++++---
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 6047058d6703..6fe99dd3ca39 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -144,9 +144,27 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		unsigned int nh_off = p_off;
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-		/* UFO may not include transport header in gso_size. */
-		if (gso_type & SKB_GSO_UDP)
+		switch (gso_type & ~SKB_GSO_TCP_ECN) {
+		case SKB_GSO_UDP:
+			/* UFO may not include transport header in gso_size. */
 			nh_off -= thlen;
+			break;
+		case SKB_GSO_UDP_L4:
+			if (!(hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
+				return -EINVAL;
+			if (skb->csum_offset != offsetof(struct udphdr, check))
+				return -EINVAL;
+			if (skb->len - p_off > gso_size * UDP_MAX_SEGMENTS)
+				return -EINVAL;
+			if (gso_type != SKB_GSO_UDP_L4)
+				return -EINVAL;
+			break;
+		case SKB_GSO_TCPV4:
+		case SKB_GSO_TCPV6:
+			if (skb->csum_offset != offsetof(struct tcphdr, check))
+				return -EINVAL;
+			break;
+		}
 
 		/* Kernel has a special handling for GSO_BY_FRAGS. */
 		if (gso_size == GSO_BY_FRAGS)
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index fc61cd3fea65..357d3be04f84 100644
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
index a0b569d0085b..0407b829e481 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -269,13 +269,25 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	__sum16 check;
 	__be16 newlen;
 
-	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
-		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
-
 	mss = skb_shinfo(gso_skb)->gso_size;
 	if (gso_skb->len <= sizeof(*uh) + mss)
 		return ERR_PTR(-EINVAL);
 
+	if (unlikely(skb_checksum_start(gso_skb) !=
+		     skb_transport_header(gso_skb) &&
+		     !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)))
+		return ERR_PTR(-EINVAL);
+
+	if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
+		/* Packet is from an untrusted source, reset gso_segs. */
+		skb_shinfo(gso_skb)->gso_segs = DIV_ROUND_UP(gso_skb->len - sizeof(*uh),
+							     mss);
+		return NULL;
+	}
+
+	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
+		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
+
 	skb_pull(gso_skb, sizeof(*uh));
 
 	/* clear destructor to avoid skb_segment assigning it to tail */
-- 
2.20.1


