Return-Path: <stable+bounces-52079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9159B907984
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 19:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BAC41F23F38
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD72149E09;
	Thu, 13 Jun 2024 17:15:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4455014AD23;
	Thu, 13 Jun 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298901; cv=none; b=s+UoZosRo1qsnK3twXkThdcFfp630kAIMDHCbdsNt3zkdAjajZb/6fYFUVoJsrOp0ouhiT/bgW9dWd+6OQfl1LX+Q5U3xbWOwF6UJSu1U5Qc6V3hZ71cVDx6xhBYOvEJkrb3dnH9g22AeUIb2Jz6if0hoeoG/1/sktzEsoUgpHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298901; c=relaxed/simple;
	bh=PiihNOfcyEATAtCG900JeUIgMm/Oa/AY2JJ7f9Jlat8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KzElyYzZs2SdeQkU9ebDjKvEGmc8uKcbE2tsLrUfm/NVeQRybyMDZHiVAbcstN0reiXTQqM6TsDoVMp5qT+hl48sh+vrDpEQHZksPw+rRAVwb+ACtB6MOMZnTmyrhnFrQCs21I8HVDi5ijShcKoKZiaGh2oHGIy2FCkaUvBsc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH -stable,5.4] netfilter: nftables: exthdr: fix 4-byte stack OOB write
Date: Thu, 13 Jun 2024 19:14:55 +0200
Message-Id: <20240613171455.121818-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

commit fd94d9dadee58e09b49075240fe83423eb1dcd36 upstream.

If priv->len is a multiple of 4, then dst[len / 4] can write past
the destination array which leads to stack corruption.

This construct is necessary to clean the remainder of the register
in case ->len is NOT a multiple of the register size, so make it
conditional just like nft_payload.c does.

The bug was added in 4.1 cycle and then copied/inherited when
tcp/sctp and ip option support was added.

Bug reported by Zero Day Initiative project (ZDI-CAN-21950,
ZDI-CAN-21951, ZDI-CAN-21961).

Fixes: 49499c3e6e18 ("netfilter: nf_tables: switch registers to 32 bit addressing")
Fixes: 935b7f643018 ("netfilter: nft_exthdr: add TCP option matching")
Fixes: 133dc203d77d ("netfilter: nft_exthdr: Support SCTP chunks")
Fixes: dbb5281a1f84 ("netfilter: nf_tables: add support for matching IPv4 options")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
Hi Greg, Sasha,

This backport is missing in 5.4, please apply to -stable. Thanks.

 net/netfilter/nft_exthdr.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 670dd146fb2b..ca268293cfa1 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -33,6 +33,14 @@ static unsigned int optlen(const u8 *opt, unsigned int offset)
 		return opt[offset + 1];
 }
 
+static int nft_skb_copy_to_reg(const struct sk_buff *skb, int offset, u32 *dest, unsigned int len)
+{
+	if (len % NFT_REG32_SIZE)
+		dest[len / NFT_REG32_SIZE] = 0;
+
+	return skb_copy_bits(skb, offset, dest, len);
+}
+
 static void nft_exthdr_ipv6_eval(const struct nft_expr *expr,
 				 struct nft_regs *regs,
 				 const struct nft_pktinfo *pkt)
@@ -54,8 +62,7 @@ static void nft_exthdr_ipv6_eval(const struct nft_expr *expr,
 	}
 	offset += priv->offset;
 
-	dest[priv->len / NFT_REG32_SIZE] = 0;
-	if (skb_copy_bits(pkt->skb, offset, dest, priv->len) < 0)
+	if (nft_skb_copy_to_reg(pkt->skb, offset, dest, priv->len) < 0)
 		goto err;
 	return;
 err:
@@ -151,8 +158,7 @@ static void nft_exthdr_ipv4_eval(const struct nft_expr *expr,
 	}
 	offset += priv->offset;
 
-	dest[priv->len / NFT_REG32_SIZE] = 0;
-	if (skb_copy_bits(pkt->skb, offset, dest, priv->len) < 0)
+	if (nft_skb_copy_to_reg(pkt->skb, offset, dest, priv->len) < 0)
 		goto err;
 	return;
 err:
@@ -208,7 +214,8 @@ static void nft_exthdr_tcp_eval(const struct nft_expr *expr,
 		if (priv->flags & NFT_EXTHDR_F_PRESENT) {
 			*dest = 1;
 		} else {
-			dest[priv->len / NFT_REG32_SIZE] = 0;
+			if (priv->len % NFT_REG32_SIZE)
+				dest[priv->len / NFT_REG32_SIZE] = 0;
 			memcpy(dest, opt + offset, priv->len);
 		}
 
-- 
2.30.2


