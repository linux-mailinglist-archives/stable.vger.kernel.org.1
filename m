Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E2B7831F5
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjHUUF1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjHUUF0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:05:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCADB11C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:05:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F0346191C
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF30C433C8;
        Mon, 21 Aug 2023 20:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648323;
        bh=UoIPqozLxwklBSS3rgN2pzmq8qRddHYrb7TTDl3zKwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxE15+Kc9N+xgYqe1wNnES7v8L9/4ihnRryaTsM8WbgcTGQAuVc+sejaeEPGwy8AM
         PbysujzJB+FOrQbp7RcZ/A7f8V62wwcurKA/i8/HlDf4abjLKdiGRzcoZ5brOfp4UA
         Tfsbcm68DQJRtzhzm0410B8P4Qm/GNCFaFLrNQ/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 135/234] xfrm: Silence warnings triggerable by bad packets
Date:   Mon, 21 Aug 2023 21:41:38 +0200
Message-ID: <20230821194134.798873838@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 57010b8ece2821a1fdfdba2197d14a022f3769db ]

After the elimination of inner modes, a couple of warnings that
were previously unreachable can now be triggered by malformed
inbound packets.

Fix this by:

1. Moving the setting of skb->protocol into the decap functions.
2. Returning -EINVAL when unexpected protocol is seen.

Reported-by: Maciej Żenczykowski<maze@google.com>
Fixes: 5f24f41e8ea6 ("xfrm: Remove inner/outer modes from input path")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Reviewed-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_input.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 815b380804011..d5ee96789d4bf 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -180,6 +180,8 @@ static int xfrm4_remove_beet_encap(struct xfrm_state *x, struct sk_buff *skb)
 	int optlen = 0;
 	int err = -EINVAL;
 
+	skb->protocol = htons(ETH_P_IP);
+
 	if (unlikely(XFRM_MODE_SKB_CB(skb)->protocol == IPPROTO_BEETPH)) {
 		struct ip_beet_phdr *ph;
 		int phlen;
@@ -232,6 +234,8 @@ static int xfrm4_remove_tunnel_encap(struct xfrm_state *x, struct sk_buff *skb)
 {
 	int err = -EINVAL;
 
+	skb->protocol = htons(ETH_P_IP);
+
 	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
 		goto out;
 
@@ -267,6 +271,8 @@ static int xfrm6_remove_tunnel_encap(struct xfrm_state *x, struct sk_buff *skb)
 {
 	int err = -EINVAL;
 
+	skb->protocol = htons(ETH_P_IPV6);
+
 	if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
 		goto out;
 
@@ -296,6 +302,8 @@ static int xfrm6_remove_beet_encap(struct xfrm_state *x, struct sk_buff *skb)
 	int size = sizeof(struct ipv6hdr);
 	int err;
 
+	skb->protocol = htons(ETH_P_IPV6);
+
 	err = skb_cow_head(skb, size + skb->mac_len);
 	if (err)
 		goto out;
@@ -346,6 +354,7 @@ xfrm_inner_mode_encap_remove(struct xfrm_state *x,
 			return xfrm6_remove_tunnel_encap(x, skb);
 		break;
 		}
+		return -EINVAL;
 	}
 
 	WARN_ON_ONCE(1);
@@ -366,19 +375,6 @@ static int xfrm_prepare_input(struct xfrm_state *x, struct sk_buff *skb)
 		return -EAFNOSUPPORT;
 	}
 
-	switch (XFRM_MODE_SKB_CB(skb)->protocol) {
-	case IPPROTO_IPIP:
-	case IPPROTO_BEETPH:
-		skb->protocol = htons(ETH_P_IP);
-		break;
-	case IPPROTO_IPV6:
-		skb->protocol = htons(ETH_P_IPV6);
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		break;
-	}
-
 	return xfrm_inner_mode_encap_remove(x, skb);
 }
 
-- 
2.40.1



