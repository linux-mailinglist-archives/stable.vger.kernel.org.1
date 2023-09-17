Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CD77A3AC3
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbjIQUIf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbjIQUIO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:08:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B9BB5
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:08:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D7DC433C7;
        Sun, 17 Sep 2023 20:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981288;
        bh=3jofWKcPO/FI1TT3/PRbIYM6xhfWfTNYXlHQOBgf10E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0qZ9n9ZPvPnhSkd+WBqXNu9byCdbb3ZvoI65gM4/fK6yPI3p7oqeh3dfMlm4rVVJD
         nnzSI0gJQ2JkfeiLsazdBe02no1RrSWenO41XRSmQG7TCakNhPiZi2ymRkTuy2kPsi
         axGKOvaz1RQ5Xd2/MSQ+AbUWEb/0Mvsob1vezgN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
        Ido Schimmel <idosch@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 100/219] ipv4: ignore dst hint for multipath routes
Date:   Sun, 17 Sep 2023 21:13:47 +0200
Message-ID: <20230917191044.586350956@linuxfoundation.org>
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

[ Upstream commit 6ac66cb03ae306c2e288a9be18226310529f5b25 ]

Route hints when the nexthop is part of a multipath group causes packets
in the same receive batch to be sent to the same nexthop irrespective of
the multipath hash of the packet. So, do not extract route hint for
packets whose destination is part of a multipath group.

A new SKB flag IPSKB_MULTIPATH is introduced for this purpose, set the
flag when route is looked up in ip_mkroute_input() and use it in
ip_extract_route_hint() to check for the existence of the flag.

Fixes: 02b24941619f ("ipv4: use dst hint for ipv4 list receive")
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip.h    | 1 +
 net/ipv4/ip_input.c | 3 ++-
 net/ipv4/route.c    | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 1872f570abeda..c286344628dba 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -57,6 +57,7 @@ struct inet_skb_parm {
 #define IPSKB_FRAG_PMTU		BIT(6)
 #define IPSKB_L3SLAVE		BIT(7)
 #define IPSKB_NOPOLICY		BIT(8)
+#define IPSKB_MULTIPATH		BIT(9)
 
 	u16			frag_max_size;
 };
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index e880ce77322aa..e7196ecffafc6 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -584,7 +584,8 @@ static void ip_sublist_rcv_finish(struct list_head *head)
 static struct sk_buff *ip_extract_route_hint(const struct net *net,
 					     struct sk_buff *skb, int rt_type)
 {
-	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST)
+	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
+	    IPCB(skb)->flags & IPSKB_MULTIPATH)
 		return NULL;
 
 	return skb;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 51bd9a50a1d1d..a04ffc128e22b 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2146,6 +2146,7 @@ static int ip_mkroute_input(struct sk_buff *skb,
 		int h = fib_multipath_hash(res->fi->fib_net, NULL, skb, hkeys);
 
 		fib_select_multipath(res, h);
+		IPCB(skb)->flags |= IPSKB_MULTIPATH;
 	}
 #endif
 
-- 
2.40.1



