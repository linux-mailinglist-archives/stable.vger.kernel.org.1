Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE2D7A3D2A
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241238AbjIQUjd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241300AbjIQUjK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:39:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B4C133
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:39:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0C7C433C8;
        Sun, 17 Sep 2023 20:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983144;
        bh=eoDMGBHGZjel7Y/IIZzr1CXNcEzouBWUydoVZFPjTyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYX4RZT1Lfjpd0qtOvoMIK+RIHSJmwHZAUh/9gTdz2+R879GGaCydYcieSA0Y982c
         uMn5drDzUsbE3L1YACIgjslREcPTWXWCe9Z3BJJJ6QbbA2HF+5L50uwP2P0+pwEbMv
         3HZXi7Np0BXICNd9CEZThrImFjzaEt6QAN6rSpm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 455/511] netfilter: nftables: exthdr: fix 4-byte stack OOB write
Date:   Sun, 17 Sep 2023 21:14:42 +0200
Message-ID: <20230917191124.744696121@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit fd94d9dadee58e09b49075240fe83423eb1dcd36 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_exthdr.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 9e927ab4df151..3609680831a14 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -35,6 +35,14 @@ static unsigned int optlen(const u8 *opt, unsigned int offset)
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
@@ -56,8 +64,7 @@ static void nft_exthdr_ipv6_eval(const struct nft_expr *expr,
 	}
 	offset += priv->offset;
 
-	dest[priv->len / NFT_REG32_SIZE] = 0;
-	if (skb_copy_bits(pkt->skb, offset, dest, priv->len) < 0)
+	if (nft_skb_copy_to_reg(pkt->skb, offset, dest, priv->len) < 0)
 		goto err;
 	return;
 err:
@@ -153,8 +160,7 @@ static void nft_exthdr_ipv4_eval(const struct nft_expr *expr,
 	}
 	offset += priv->offset;
 
-	dest[priv->len / NFT_REG32_SIZE] = 0;
-	if (skb_copy_bits(pkt->skb, offset, dest, priv->len) < 0)
+	if (nft_skb_copy_to_reg(pkt->skb, offset, dest, priv->len) < 0)
 		goto err;
 	return;
 err:
@@ -210,7 +216,8 @@ static void nft_exthdr_tcp_eval(const struct nft_expr *expr,
 		if (priv->flags & NFT_EXTHDR_F_PRESENT) {
 			*dest = 1;
 		} else {
-			dest[priv->len / NFT_REG32_SIZE] = 0;
+			if (priv->len % NFT_REG32_SIZE)
+				dest[priv->len / NFT_REG32_SIZE] = 0;
 			memcpy(dest, opt + offset, priv->len);
 		}
 
@@ -335,9 +342,8 @@ static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
 			    offset + ntohs(sch->length) > pkt->skb->len)
 				break;
 
-			dest[priv->len / NFT_REG32_SIZE] = 0;
-			if (skb_copy_bits(pkt->skb, offset + priv->offset,
-					  dest, priv->len) < 0)
+			if (nft_skb_copy_to_reg(pkt->skb, offset + priv->offset,
+						dest, priv->len) < 0)
 				break;
 			return;
 		}
-- 
2.40.1



