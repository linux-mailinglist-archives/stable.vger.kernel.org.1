Return-Path: <stable+bounces-107102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB35A02A45
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA833A66F4
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB5E70812;
	Mon,  6 Jan 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="svISzr7V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6691DDC04;
	Mon,  6 Jan 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177459; cv=none; b=E7BohyhoTNQOIb7fvUfPQqEIWszPlM2cQJg7uUh2zTpteYqxtXNpGZUjb0R/uRKmRGWQHc5gvzczbGEs0PYVtBPoZsZl75NwLal5ww4Skx2NHn6yB8LlfGgoRbQEJYrwGt0nNqQnIPDQWAD+q5Wo8YvyNAUGmH6HsZ69+VmMRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177459; c=relaxed/simple;
	bh=8dlQt7c/wzFfyEs1WdAIZCgxzWTwUihokG7JAPLcZUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dauyxS/j9EiEfkZmX0hVmZU2GqUcFoyCO0eKjaAKxHacr5+NtrYL4hmI4Lks6Gwv7XlH9XR/JN5jeQlTm21cSDsHgfhASZxFWcdZ+OjXHpxSLtLUU7xW76Gywt7F6po3lqLCLZJaoHuAlLqtlnAim2ht79rqLNph2VtxhOKLhuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=svISzr7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F22C4CED2;
	Mon,  6 Jan 2025 15:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177459;
	bh=8dlQt7c/wzFfyEs1WdAIZCgxzWTwUihokG7JAPLcZUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=svISzr7VMb+v1N0dwIv9IED1Ufd1QCjT5bK4dfmyWw9JIUMG4hvnOMi4wT3FmEeWl
	 Scqk/TFdlyP/qLbzCPyxmzzuuXC6HlgYWJHCa0gNuXhWoi2VLiMtQ6zml1p3ixjrmC
	 HPhQAVyriG5c4R6XZA+VWtXwBsZfjapNosymA+Ok=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 171/222] net: reenable NETIF_F_IPV6_CSUM offload for BIG TCP packets
Date: Mon,  6 Jan 2025 16:16:15 +0100
Message-ID: <20250106151157.236843844@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 68e068cabd2c6c533ef934c2e5151609cf6ecc6d ]

The blamed commit disabled hardware offoad of IPv6 packets with
extension headers on devices that advertise NETIF_F_IPV6_CSUM,
based on the definition of that feature in skbuff.h:

 *   * - %NETIF_F_IPV6_CSUM
 *     - Driver (device) is only able to checksum plain
 *       TCP or UDP packets over IPv6. These are specifically
 *       unencapsulated packets of the form IPv6|TCP or
 *       IPv6|UDP where the Next Header field in the IPv6
 *       header is either TCP or UDP. IPv6 extension headers
 *       are not supported with this feature. This feature
 *       cannot be set in features for a device with
 *       NETIF_F_HW_CSUM also set. This feature is being
 *       DEPRECATED (see below).

The change causes skb_warn_bad_offload to fire for BIG TCP
packets.

[  496.310233] WARNING: CPU: 13 PID: 23472 at net/core/dev.c:3129 skb_warn_bad_offload+0xc4/0xe0

[  496.310297]  ? skb_warn_bad_offload+0xc4/0xe0
[  496.310300]  skb_checksum_help+0x129/0x1f0
[  496.310303]  skb_csum_hwoffload_help+0x150/0x1b0
[  496.310306]  validate_xmit_skb+0x159/0x270
[  496.310309]  validate_xmit_skb_list+0x41/0x70
[  496.310312]  sch_direct_xmit+0x5c/0x250
[  496.310317]  __qdisc_run+0x388/0x620

BIG TCP introduced an IPV6_TLV_JUMBO IPv6 extension header to
communicate packet length, as this is an IPv6 jumbogram. But, the
feature is only enabled on devices that support BIG TCP TSO. The
header is only present for PF_PACKET taps like tcpdump, and not
transmitted by physical devices.

For this specific case of extension headers that are not
transmitted, return to the situation before the blamed commit
and support hardware offload.

ipv6_has_hopopt_jumbo() tests not only whether this header is present,
but also that it is the only extension header before a terminal (L4)
header.

Fixes: 04c20a9356f2 ("net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension")
Reported-by: syzbot <syzkaller@googlegroups.com>
Reported-by: Eric Dumazet <edumazet@google.com>
Closes: https://lore.kernel.org/netdev/CANn89iK1hdC3Nt8KPhOtTF8vCPc1AHDCtse_BTNki1pWxAByTQ@mail.gmail.com/
Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20250101164909.1331680-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4beb9acf2c18..69da7b009f8b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3628,8 +3628,10 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
 		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
-		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
+		    !ipv6_has_hopopt_jumbo(skb))
 			goto sw_checksum;
+
 		switch (skb->csum_offset) {
 		case offsetof(struct tcphdr, check):
 		case offsetof(struct udphdr, check):
-- 
2.39.5




