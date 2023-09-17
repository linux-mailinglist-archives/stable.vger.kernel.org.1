Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FCB7A3AC5
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbjIQUIh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240461AbjIQUIY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:08:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF5897
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:08:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48B2C433C7;
        Sun, 17 Sep 2023 20:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981299;
        bh=vDZ8goxAh7GGSdSC7KAjtYxN4EPGvdQ/eMaWZxhnK/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVBAD2S5HxHie6UU9AIFUofjDx6280/8T4HP/6oq9O9bGxD0WZNbxKd4PrX7cJsq3
         oZ9tNSL+dVU646czs8jGj9pTWkejHhCN1bkO+FNAtqtyI0O3T6ZeEXftZfB3AUlMfB
         eEwDbZfBaka0b5+v/sMygbYI/7h4KY5Uccl7pAMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
        Ido Schimmel <idosch@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 101/219] ipv6: ignore dst hint for multipath routes
Date:   Sun, 17 Sep 2023 21:13:48 +0200
Message-ID: <20230917191044.651325083@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>

[ Upstream commit 8423be8926aa82cd2e28bba5cc96ccb72c7ce6be ]

Route hints when the nexthop is part of a multipath group causes packets
in the same receive batch to be sent to the same nexthop irrespective of
the multipath hash of the packet. So, do not extract route hint for
packets whose destination is part of a multipath group.

A new SKB flag IP6SKB_MULTIPATH is introduced for this purpose, set the
flag when route is looked up in fib6_select_path() and use it in
ip6_can_use_hint() to check for the existence of the flag.

Fixes: 197dbf24e360 ("ipv6: introduce and uses route look hints for list input.")
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ipv6.h | 1 +
 net/ipv6/ip6_input.c | 3 ++-
 net/ipv6/route.c     | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 37dfdcfcdd542..15d7529ac9534 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -146,6 +146,7 @@ struct inet6_skb_parm {
 #define IP6SKB_JUMBOGRAM      128
 #define IP6SKB_SEG6	      256
 #define IP6SKB_FAKEJUMBO      512
+#define IP6SKB_MULTIPATH      1024
 };
 
 #if defined(CONFIG_NET_L3_MASTER_DEV)
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index d94041bb42872..b8378814532ce 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -99,7 +99,8 @@ static bool ip6_can_use_hint(const struct sk_buff *skb,
 static struct sk_buff *ip6_extract_route_hint(const struct net *net,
 					      struct sk_buff *skb)
 {
-	if (fib6_routes_require_src(net) || fib6_has_custom_rules(net))
+	if (fib6_routes_require_src(net) || fib6_has_custom_rules(net) ||
+	    IP6CB(skb)->flags & IP6SKB_MULTIPATH)
 		return NULL;
 
 	return skb;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 960ab43a49c46..93957b20fccce 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -425,6 +425,9 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 	if (match->nh && have_oif_match && res->nh)
 		return;
 
+	if (skb)
+		IP6CB(skb)->flags |= IP6SKB_MULTIPATH;
+
 	/* We might have already computed the hash for ICMPv6 errors. In such
 	 * case it will always be non-zero. Otherwise now is the time to do it.
 	 */
-- 
2.40.1



