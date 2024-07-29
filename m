Return-Path: <stable+bounces-62611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81CB93FEDA
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 22:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2914BB21F1A
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 20:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC38A188CBC;
	Mon, 29 Jul 2024 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2KpEX/1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7743152;
	Mon, 29 Jul 2024 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283875; cv=none; b=FHMl//9TUbpDXhfYXgcSziszLCwtfWllUYkrMFsKS5b5OqFgCAFjsj3HEQjXwk727mErAE9fGur11rCmfmWd215Ya7R8qNHFh9F/XnAZZ+HQKu/ZruYqKpr506tn6gZpjStlagfUPgV8KFNZkMpyjCd9dyndZmcoVOOV8RKE9Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283875; c=relaxed/simple;
	bh=1HhYhvu5qPZnyoOhxtG9/REYK9y8WdoqX16CLuITjVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pS94bksyaWWet6UMb9K7G7+kSWdFPxOpi6Cpc71IijcosiSPs8WFeSTk7mxw9SLFVTCWtmm4kY2sd72UcB7F+R6W8cayAY93kvh3adIH9yuKpCbOe6i8l0D9yBpusPfMS6xFa2P6WFpdfVTuJxgAbvIFE7Vt+zKFvltAQMCVsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2KpEX/1; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-825dc62725cso1108176241.3;
        Mon, 29 Jul 2024 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722283873; x=1722888673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8tezPeWHMUA8ikyyOY2gU0vK8x1rpfFIrDZ2UW5GgM0=;
        b=L2KpEX/1eZhYWcd4T4PVwt+svgb76lXCOm6bGbvOYSFFM32yLNsTuBASi8yLs4mUSD
         /zn+JEATRiuTe9rih65NQbAR5ercNHyvsla6uEoFBASNv3sz5akQLhUhcPQUcK5DyOAs
         pu9RBNap7x5r+J85fENrNowM2pVls+TUwkL0NE/XdaeI5+I2R1FasUvc/oa1DxbfwVyH
         ugKih/LXv/L6bg2/tbitoTVNSRXki+M9r4VSdQYtzDLopP4zZhntpoAllqNYpuwotgum
         GTNR5g5pPMAsfDL6AGmOTvPkFpAeHXpbjWO4L1kWGKGRrOOuEH2eyUyuuZIE/YadWh5Y
         g6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722283873; x=1722888673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tezPeWHMUA8ikyyOY2gU0vK8x1rpfFIrDZ2UW5GgM0=;
        b=E1KBKDT7UZyH0sxmDjNrd2LP8AQuvIqcxiqXV/Zc6Q7+6Ezokf7q9BVzzbbAekQeMK
         4rXK9/1qonEdL9SqNvYl3BEuvlnSF1hmEgrlFwnuGOQjaM0RCn7ORKohwStXW4tWpEii
         WkZUFSX2j3B6kAODgM6I+THkvQk51yEkno/lJrGPZqLudtJOkp8wT7XDArtbVAeGN+dh
         /yxQQ9yhEtp1agOVWP5zNmj9lWp6HxtLw1j/h2+ZKsmVdsoVRDxBwp0L2824DqRbauou
         1z0+ERMTOD9yq9TwKetdQs0C+YyxeirpI2sZKKoZHP1YxyQvC16kLpUBi3o8pjkknC/e
         p7nw==
X-Forwarded-Encrypted: i=1; AJvYcCVbr0Z/eNG6x6rDWK43oGNjw+E3Hw/MsPn/enMzPkGw2RxunA7VgXakXNd1fHFcr5LQfwO0XRoLicsRbviMmbVP3/Oa49iO
X-Gm-Message-State: AOJu0YxZaxj2oA24+szeaKsaAAP/cj6iBijBIv5z0m/eWv8EAwj4KKRL
	FghiMeFGi6a5is1lsjkJYg2fdasI5OlEkAz/2NUqsmMG6TCze+as7OYqEg==
X-Google-Smtp-Source: AGHT+IEPlhYE4kXhM/k5XgUjpH2dok8Tvb5HOpwhDKFNLXOi+BBQgK+DxQt3EL5kO/CJ9PGG0PqMOw==
X-Received: by 2002:a05:6102:291e:b0:493:c3b2:b5ba with SMTP id ada2fe7eead31-493fa15f37cmr11925430137.6.1722283872616;
        Mon, 29 Jul 2024 13:11:12 -0700 (PDT)
Received: from willemb.c.googlers.com.com (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1dcc43dacsm482255685a.126.2024.07.29.13.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 13:11:11 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	arefev@swemel.ru,
	alexander.duyck@gmail.com,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: drop bad gso csum_start and offset in virtio_net_hdr
Date: Mon, 29 Jul 2024 16:10:12 -0400
Message-ID: <20240729201108.1615114-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
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

---

v1->v2
  - skb_transport_header instead of skb->transport_header (edumazet@)
  - typo: migitate -> mitigate
---
 include/linux/virtio_net.h | 16 +++++-----------
 net/ipv4/tcp_offload.c     |  3 +++
 net/ipv4/udp_offload.c     |  4 ++++
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d1d7825318c32..6c395a2600e8d 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -56,7 +56,6 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	unsigned int thlen = 0;
 	unsigned int p_off = 0;
 	unsigned int ip_proto;
-	u64 ret, remainder, gso_size;
 
 	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
 		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
@@ -99,16 +98,6 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
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
 
@@ -182,6 +171,11 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
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
index 4b791e74529e1..e4ad3311e1489 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -140,6 +140,9 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	if (thlen < sizeof(*th))
 		goto out;
 
+	if (unlikely(skb_checksum_start(skb) != skb_transport_header(skb)))
+		goto out;
+
 	if (!pskb_may_pull(skb, thlen))
 		goto out;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index aa2e0a28ca613..bc8a9da750fed 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -278,6 +278,10 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
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
2.46.0.rc1.232.g9752f9e123-goog


