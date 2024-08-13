Return-Path: <stable+bounces-67514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A2F9509CF
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 18:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F3F1F27944
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 16:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1D21A2561;
	Tue, 13 Aug 2024 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y8U+7K0u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C27E1A0708
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 16:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565126; cv=none; b=OY6PWWqwMC3dROVIQA9h47mhxUVLGVFOonSwurWjmHrMgr1Hq+nRZLfmgVwwwPYhvtU2hc9FAXyPh3QK6sw80J0V1NEDatgjB8gnTEzeqfe4WQ3eKasKJvj7tMBKfAl/9Fb1TBnYamgn2ICOauPACxSTTZOOl2raxsq+p22eUNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565126; c=relaxed/simple;
	bh=f4neqbdTbz6x4T+DClWRr7Gdzq9i79hWZFp33yNcf3w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Prv+VMA+7paOPNrWgyP1eIoqn3sfsTA8s/O8N1jvePx/U1JOcSw0p4OWgTv89iVskLkTYt70+F8pliZ1U3YRXrm7jjs6Qf8rlb4lqI8kwzdBwTNDr9Vxap15CvDWWyaL5l8GsXVQmMwybf8Rd37o1hA5UA7kWgI31dBDsqi9+lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y8U+7K0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2933FC4AF16;
	Tue, 13 Aug 2024 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723565125;
	bh=f4neqbdTbz6x4T+DClWRr7Gdzq9i79hWZFp33yNcf3w=;
	h=Subject:To:Cc:From:Date:From;
	b=Y8U+7K0uoC48JX2FkxA/yhT+vhfqsIvLIRT0khIozBRIr3Jdw+jwSY6nwZpcdhaer
	 3TyM7aamDHhWoJG3Kt89/ZscppjH3jblwhm7+s8qB9dVSqehQsKKsxI50wfnDcszlP
	 07u+do5ZKFd57Q050YyxhC7KGz/6k5Cg1fqioiuo=
Subject: FAILED: patch "[PATCH] net: drop bad gso csum_start and offset in virtio_net_hdr" failed to apply to 5.15-stable tree
To: willemb@google.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 13 Aug 2024 18:05:22 +0200
Message-ID: <2024081322-yoyo-proving-7a44@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 89add40066f9ed9abe5f7f886fe5789ff7e0c50e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081322-yoyo-proving-7a44@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")
fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
9840036786d9 ("gso: fix dodgy bit handling for GSO_UDP_L4")
cf9acc90c80e ("net: virtio_net_hdr_to_skb: count transport header in UFO")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 89add40066f9ed9abe5f7f886fe5789ff7e0c50e Mon Sep 17 00:00:00 2001
From: Willem de Bruijn <willemb@google.com>
Date: Mon, 29 Jul 2024 16:10:12 -0400
Subject: [PATCH] net: drop bad gso csum_start and offset in virtio_net_hdr

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
index 4b791e74529e..e4ad3311e148 100644
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
index aa2e0a28ca61..bc8a9da750fe 100644
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


