Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86E67B8770
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243788AbjJDSFU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243777AbjJDSFT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:05:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584DAAD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:05:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3610C433C9;
        Wed,  4 Oct 2023 18:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442716;
        bh=HQmp+zOFs0s8wjnbNfe5f2r2B/PfuPZHaJoa3Cje10I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ketICBeOr+6Ji2mOQpzxN7tjMv4mZWTvAoxxKKXf8PAxUEmgUmROcgNOFoGXhbkJw
         0MVT5hxTtuCDJuhJ4bazq2vh8J2synUPsvxWXUH5LdSPW3AQz3Fe3xylZQWwf9UzeB
         TVnEe9C7j3+7cxXwoqcwNwCBv65Q94xupkbdgVY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiao Liang <shaw.leon@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 083/183] netfilter: nft_exthdr: Fix non-linear header modification
Date:   Wed,  4 Oct 2023 19:55:14 +0200
Message-ID: <20231004175207.337269578@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
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

From: Xiao Liang <shaw.leon@gmail.com>

[ Upstream commit 28427f368f0e08d504ed06e74bc7cc79d6d06511 ]

Fix skb_ensure_writable() size. Don't use nft_tcp_header_pointer() to
make it explicit that pointers point to the packet (not local buffer).

Fixes: 99d1712bc41c ("netfilter: exthdr: tcp option set support")
Fixes: 7890cbea66e7 ("netfilter: exthdr: add support for tcp option removal")
Cc: stable@vger.kernel.org
Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_exthdr.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 58f205531b961..daee46cf62abb 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -245,7 +245,12 @@ static void nft_exthdr_tcp_set_eval(const struct nft_expr *expr,
 	if (!tcph)
 		goto err;
 
+	if (skb_ensure_writable(pkt->skb, nft_thoff(pkt) + tcphdr_len))
+		goto err;
+
+	tcph = (struct tcphdr *)(pkt->skb->data + nft_thoff(pkt));
 	opt = (u8 *)tcph;
+
 	for (i = sizeof(*tcph); i < tcphdr_len - 1; i += optl) {
 		union {
 			__be16 v16;
@@ -260,15 +265,6 @@ static void nft_exthdr_tcp_set_eval(const struct nft_expr *expr,
 		if (i + optl > tcphdr_len || priv->len + priv->offset > optl)
 			goto err;
 
-		if (skb_ensure_writable(pkt->skb,
-					nft_thoff(pkt) + i + priv->len))
-			goto err;
-
-		tcph = nft_tcp_header_pointer(pkt, sizeof(buff), buff,
-					      &tcphdr_len);
-		if (!tcph)
-			goto err;
-
 		offset = i + priv->offset;
 
 		switch (priv->len) {
@@ -332,9 +328,9 @@ static void nft_exthdr_tcp_strip_eval(const struct nft_expr *expr,
 	if (skb_ensure_writable(pkt->skb, nft_thoff(pkt) + tcphdr_len))
 		goto drop;
 
-	opt = (u8 *)nft_tcp_header_pointer(pkt, sizeof(buff), buff, &tcphdr_len);
-	if (!opt)
-		goto err;
+	tcph = (struct tcphdr *)(pkt->skb->data + nft_thoff(pkt));
+	opt = (u8 *)tcph;
+
 	for (i = sizeof(*tcph); i < tcphdr_len - 1; i += optl) {
 		unsigned int j;
 
-- 
2.40.1



