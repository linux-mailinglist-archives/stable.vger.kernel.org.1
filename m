Return-Path: <stable+bounces-61810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FE793CCC1
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 04:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D146D282E6D
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 02:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BC81A716;
	Fri, 26 Jul 2024 02:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeSaDTBg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6791B947;
	Fri, 26 Jul 2024 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721961246; cv=none; b=Yr1/RxCZaRObiIY3n8YwRMkLvI/eZpVDv5OgLGJJjRosEu7XsonGKKq9Cppd6J2WNYTHVUuzHaZrtdehwuc+JnXS4zYJDGOpmg1grpM0x72xWsXjs4PFoDhLWnZpXyiEjyUgmLXcsqwwLSyhsJ8kUCWZ6sj+pAtTUnr5ibDX4sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721961246; c=relaxed/simple;
	bh=fGO7zgAjSKLGmo/Nb/TQ4yUxCHvoxiuh+5KbAxDkpUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCA7EQDn7HxmuLFda7D7K0b+30CylQ8ViBCpUfMekWy7eYNbjJ1BnTbVGB6ugCEfKXwdnqo23GPJmWnzgGDHW0uwnU1g2u6TyCHbfrGsisQM6Gpmo8pDBhy/YKxH9FcGf2/cNLYYJQTlM5i1d+hI9yyH3F03lWFToHFckGlPbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeSaDTBg; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44fdde0c8dcso1105591cf.0;
        Thu, 25 Jul 2024 19:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721961244; x=1722566044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B1DrkWVH1N3/4i4ZMI9uWQ4G3glJcw7jxGQQ1U+yfBg=;
        b=SeSaDTBg7YpW4KrFtRa9+H6DtwZ07V2OViTOZL0r91fcYGZYO61auSAThiVMlDJTdS
         Yss3Nyr6IJD9jy0X+FwQ7gn/t4gD+fEc+QOkuQMT6F48Gm/BRVCI7ZQlVClmdYqgr7QU
         KwRH+5Q838c3vSPqy35H+7JT+mkHTm9A6bL3RhpfkY+Z+YuV3/ZkMck0tw/JjU5CUXFk
         4rDarMFube7Nek67+XXZsv8JFAc0D+VHA/mTpXUDVI/rvMt5UdWJ+eEXTz+ym9yBhaHW
         knON7gC+g9Qld+nd/wVpOMX5n0Wjsk5dGkoUXJIKF9h26lZsJ0+RGeo5L7hIEFgZp/A3
         d/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721961244; x=1722566044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1DrkWVH1N3/4i4ZMI9uWQ4G3glJcw7jxGQQ1U+yfBg=;
        b=drI18XgYnHbOiV8UeeCO9mCBzaPvQwbDgvQIEnsJrYA7Sx1SUngxb7s++OI7WIVTeW
         hQrU7QdnFS0ikeITijSKzQos+tVX+Q7B605uuUY9qSK2VFB4C8mWiGeTJncEM6GXJ0T3
         5mEbFI0/JrlF8uXvxYqSKOJBa5KlCvV65OdVB/tErLtfXvlMU8i+7DhizUgZTRVkjniN
         tzAgSBMvGdWW+l0z5Mu0RzbaOioySQrHSPq7kHhhTGJAcH4Z65nUYuDB5JmzRaypuFI0
         STa3ndFlmHb8k5+J9c47QP6VoZRccqeZ6+tyF9q1xmEaQATWsjlEJg636vFXXvJS3y5k
         75gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJcQwaET5i7o5bmhQKlFVeO5NDBQVlIRaOLFZsLHvPlaFlJn2SbEIt44zoI6GJkbRY/S5frWEOdx0mimj80632S8crLx0L
X-Gm-Message-State: AOJu0Yybl++cLWHManAxbL+en5J7rFi+qdLZGWMfulRou2SRp+POpkro
	UNoAJAHFYq1d7fwM1XiX0mUKt7Byq0XZH5DhkS4VHdgs2STGttjrgngT6w==
X-Google-Smtp-Source: AGHT+IGJi0rlpnoJDnkh4TLgoJ0OhF3ZU6Eqq5O6eZw/kgN+3qP6bMAfcdpvbsLZXT3bI68so+xGaA==
X-Received: by 2002:a05:622a:448:b0:447:df17:5116 with SMTP id d75a77b69052e-44fe32a19f4mr47893061cf.7.1721961243818;
        Thu, 25 Jul 2024 19:34:03 -0700 (PDT)
Received: from willemb.c.googlers.com.com (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe81463easm10677521cf.26.2024.07.25.19.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 19:34:03 -0700 (PDT)
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
Subject: [PATCH net] net: drop bad gso csum_start and offset in virtio_net_hdr
Date: Thu, 25 Jul 2024 22:32:49 -0400
Message-ID: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
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

Migitage with stricter input validation.

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
 include/linux/virtio_net.h | 16 +++++-----------
 net/ipv4/tcp_offload.c     |  3 +++
 net/ipv4/udp_offload.c     |  3 +++
 3 files changed, 11 insertions(+), 11 deletions(-)

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
index 4b791e74529e1..9e49ffcc77071 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -140,6 +140,9 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	if (thlen < sizeof(*th))
 		goto out;
 
+	if (unlikely(skb->csum_start != skb->transport_header))
+		goto out;
+
 	if (!pskb_may_pull(skb, thlen))
 		goto out;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index aa2e0a28ca613..f521152c40871 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -278,6 +278,9 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	if (gso_skb->len <= sizeof(*uh) + mss)
 		return ERR_PTR(-EINVAL);
 
+	if (unlikely(gso_skb->csum_start != gso_skb->transport_header))
+		return ERR_PTR(-EINVAL);
+
 	if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
 		/* Packet is from an untrusted source, reset gso_segs. */
 		skb_shinfo(gso_skb)->gso_segs = DIV_ROUND_UP(gso_skb->len - sizeof(*uh),
-- 
2.46.0.rc1.232.g9752f9e123-goog


