Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6557BDDD5
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376938AbjJINNm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376941AbjJINN0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C47519BD
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:12:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D907C433C8;
        Mon,  9 Oct 2023 13:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857163;
        bh=ad4tpvR4n6aXF6N8V7O9O9yb7zQAdSfJ9Doxwve2i94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYz638ZojS02eYk5oMKJbDZFKSR2UoINIPDk02LBT+k1oKOJkcQD3skDc7+wUST1n
         lYeX4TWSmKXYn6IZLJnCsVbrkGeIIRUvJcGIsRWiBRIPno3l8WAIrc+sCslmZrU7JW
         OVYV/Sdn6oDAhZbqC6cZcAOU8Zg4/7+Qq3bR4/d8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Ward <david.ward@ll.mit.edu>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 117/163] netfilter: nft_payload: rebuild vlan header on h_proto access
Date:   Mon,  9 Oct 2023 15:01:21 +0200
Message-ID: <20231009130127.256521593@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit af84f9e447a65b4b9f79e7e5d69e19039b431c56 ]

nft can perform merging of adjacent payload requests.
This means that:

ether saddr 00:11 ... ether type 8021ad ...

is a single payload expression, for 8 bytes, starting at the
ethernet source offset.

Check that offset+length is fully within the source/destination mac
addersses.

This bug prevents 'ether type' from matching the correct h_proto in case
vlan tag got stripped.

Fixes: de6843be3082 ("netfilter: nft_payload: rebuild vlan header when needed")
Reported-by: David Ward <david.ward@ll.mit.edu>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_payload.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 8cb8009899479..120f6d395b98b 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -154,6 +154,17 @@ int nft_payload_inner_offset(const struct nft_pktinfo *pkt)
 	return pkt->inneroff;
 }
 
+static bool nft_payload_need_vlan_copy(const struct nft_payload *priv)
+{
+	unsigned int len = priv->offset + priv->len;
+
+	/* data past ether src/dst requested, copy needed */
+	if (len > offsetof(struct ethhdr, h_proto))
+		return true;
+
+	return false;
+}
+
 void nft_payload_eval(const struct nft_expr *expr,
 		      struct nft_regs *regs,
 		      const struct nft_pktinfo *pkt)
@@ -172,7 +183,7 @@ void nft_payload_eval(const struct nft_expr *expr,
 			goto err;
 
 		if (skb_vlan_tag_present(skb) &&
-		    priv->offset >= offsetof(struct ethhdr, h_proto)) {
+		    nft_payload_need_vlan_copy(priv)) {
 			if (!nft_payload_copy_vlan(dest, skb,
 						   priv->offset, priv->len))
 				goto err;
-- 
2.40.1



