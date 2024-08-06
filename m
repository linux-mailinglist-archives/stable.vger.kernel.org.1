Return-Path: <stable+bounces-65486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB18948EF8
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 14:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA891F214A5
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 12:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AC01BE23B;
	Tue,  6 Aug 2024 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kq1VuZiE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BE81D52B
	for <stable@vger.kernel.org>; Tue,  6 Aug 2024 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722946999; cv=none; b=bNpWo8w58etRj/7rtqMQc/aI7lrmXnKQFVmEZU56/vI1bVLHPSck8A8MjqtwMXtny+fCWIAVJLM7IFsbHU9/FzQlvJOBPH5rws3SS9rEONX/xY0YpVDX8FjeAtnXzg6B4a7Mq+4GBTbWnugmysV4G8BI5EgogmkK8mjK1OrfhDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722946999; c=relaxed/simple;
	bh=QiRNRqgpbT9KQoBtjD/4Ga5MITnDOyZInBJrbNWX6K8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mjfvdscvXA7ftzuCkomI3erM8S6MiWYOIoVFwvJAoUkoKu3N6PUVZw0Uvq90KyM885/2XOu4oQmwtrDZgU6GidFmPzYWGdPY9ehOyGLEHktLL8ckGAHDyukXW9lwCzXadR472d33rok6uo5DXXgO4hLh3v7ef0ArFsSIihdT12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kq1VuZiE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso5424815e9.3
        for <stable@vger.kernel.org>; Tue, 06 Aug 2024 05:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722946996; x=1723551796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUD4UppQjjFF1Dsxg4bgYlOz6ywgN8rwyMu/NGUE+6c=;
        b=Kq1VuZiETAWtyrkDOnerArnJDymaHp6Z+hN3WsKucjP5IUPlol4iVBBbjO1SYYpttw
         YDGepaC6R4u6ZJlNoHDb7Isk00dN8XWM5Il30aenjgcEVqQYQdU3A22s+EwjM918mHCE
         0aFV1N4RWQb75FLbjE/T5O+idhH9P7nU0ZSXRkX3CB6eaWvaJlDBNChmcOSv5Cp7w/9P
         NxpA1t7Cx4suv+sgAQgjRnu2VNUuBT7mvA/zz12jt0rMVGN1ggD4G/Dqv5VVfYl1jLdu
         ULP2uVNLgniTiWzB9tc2q88ROXcdnYMomn4A0a5VYhfdzRNifw/9Bi7vN+pH0VztY3fm
         R7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722946996; x=1723551796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUD4UppQjjFF1Dsxg4bgYlOz6ywgN8rwyMu/NGUE+6c=;
        b=csSiv8mtSv4HM/Dt0TAexcQgqT76rpn2joQAj0MI+mWvzJV99HK8AATKg1tj3XTrs3
         89ocfdq6rw19Z6vTp5LleLXM3oJSLhpVOPs1MG0Xio/HtYdTE+T+NkQS54XYScGkG9lj
         l6si8QyoVEEPexO0NtoBH8fr95v8SkgPyCnrdxqkG7pPifkCBcBHIe3gpjqw/7ILaXSD
         +61Dg79YGkgipJAlsdvtHEoa1O65XgfR6zLLCZJ8yWddHrVZZME22Oo62OxGYIXjXU/t
         Oh9jsNH74aT0gm7oLikQYDCktV0lgfEOPQBAesl67KcpZP3Y4sLGsDg2sHIK18cI+Efj
         78tA==
X-Gm-Message-State: AOJu0YyB4xaVbjirVyW6Y7gO6r/1tL0awey5sfDMbE7PqglyjsrMXc+r
	C/hZ/D66XaPWUHfoeY2sxkHTAr8fayVncz0qaM18OH/7AtXYkUi3o+HiojuS
X-Google-Smtp-Source: AGHT+IHRz57cX/nabit6CvwPOeoGkHzGWrxqfc6ogZ3EPhQIGXshUREborVBs9TnCrTHOI6ULsmUYA==
X-Received: by 2002:a05:600c:1d10:b0:426:61fc:fc1a with SMTP id 5b1f17b1804b1-428e6af242dmr117798655e9.3.1722946974154;
        Tue, 06 Aug 2024 05:22:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb14:499:e600:1a5e:fff:fe3d:95be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8ada7esm241504305e9.15.2024.08.06.05.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:22:53 -0700 (PDT)
From: mathieu.tortuyaux@gmail.com
To: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] net: drop bad gso csum_start and offset in virtio_net_hdr
Date: Tue,  6 Aug 2024 14:18:40 +0200
Message-ID: <20240806122236.60183-1-mathieu.tortuyaux@gmail.com>
X-Mailer: git-send-email 2.44.2
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
---
Hi,

This patch fixes network failures on OpenStack VMs running with Kernel
6.6.44 (it was working fine with 6.6.43).
```
[  237.422038] eth0: bad gso: type: 1, size: 1432
```

This has been tested on Flatcar Linux CI with Kernel 6.6.44.

I think it has to be backported on Linux branches that have the "net:
missing check virtio" commit.

At this moment, I know those releases to be concerned:
* 6.1.y (with 6.1.103)
* 6.6.y (with 6.6.44)
* 6.10.y (with 6.10.3)

Thanks,

Mathieu - @tormath1

 include/linux/virtio_net.h | 16 +++++-----------
 net/ipv4/tcp_offload.c     |  3 +++
 net/ipv4/udp_offload.c     |  4 ++++
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index d1d7825318c3..6c395a2600e8 100644
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
index 8311c38267b5..69e6012ae82f 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -73,6 +73,9 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	if (thlen < sizeof(*th))
 		goto out;
 
+	if (unlikely(skb_checksum_start(skb) != skb_transport_header(skb)))
+		goto out;
+
 	if (!pskb_may_pull(skb, thlen))
 		goto out;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index e5971890d637..9cb13a50011e 100644
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
2.44.2


