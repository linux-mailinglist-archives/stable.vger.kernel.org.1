Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725E27A3BBA
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbjIQUV1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbjIQUVQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:21:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAB9101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:21:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF9EC433C9;
        Sun, 17 Sep 2023 20:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982071;
        bh=uf0H6mFhprfZJ4IOR3/B3qBU2Kvvyb9xOSAyA78Lohw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yYgbiMgG/CyYugpR5E1jrmb+jFgNhaN7q2c0r7wXeGbDCFLuZaBrZF7iuRVcuFWLU
         LpfO5unKmBC1Y2OhpiRHCUj6yUmcx4tr+/tLI2patcu+y66hF/MTUV/U8poPq+jcZR
         7goRflaaBtOuQduHTTzwaFF9yMppKYgNjFlJ2eAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 213/219] tcp: Factorise sk_family-independent comparison in inet_bind2_bucket_match(_addr_any).
Date:   Sun, 17 Sep 2023 21:15:40 +0200
Message-ID: <20230917191048.633862131@linuxfoundation.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit c6d277064b1da7f9015b575a562734de87a7e463 ]

This is a prep patch to make the following patches cleaner that touch
inet_bind2_bucket_match() and inet_bind2_bucket_match_addr_any().

Both functions have duplicated comparison for netns, port, and l3mdev.
Let's factorise them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: aa99e5f87bd5 ("tcp: Fix bind() regression for v4-mapped-v6 wildcard address.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_hashtables.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 38a92c8c66863..71d77b3b6536f 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -795,41 +795,39 @@ static bool inet_bind2_bucket_match(const struct inet_bind2_bucket *tb,
 				    const struct net *net, unsigned short port,
 				    int l3mdev, const struct sock *sk)
 {
+	if (!net_eq(ib2_net(tb), net) || tb->port != port ||
+	    tb->l3mdev != l3mdev)
+		return false;
+
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family != tb->family)
 		return false;
 
 	if (sk->sk_family == AF_INET6)
-		return net_eq(ib2_net(tb), net) && tb->port == port &&
-			tb->l3mdev == l3mdev &&
-			ipv6_addr_equal(&tb->v6_rcv_saddr, &sk->sk_v6_rcv_saddr);
-	else
+		return ipv6_addr_equal(&tb->v6_rcv_saddr, &sk->sk_v6_rcv_saddr);
 #endif
-		return net_eq(ib2_net(tb), net) && tb->port == port &&
-			tb->l3mdev == l3mdev && tb->rcv_saddr == sk->sk_rcv_saddr;
+	return tb->rcv_saddr == sk->sk_rcv_saddr;
 }
 
 bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const struct net *net,
 				      unsigned short port, int l3mdev, const struct sock *sk)
 {
+	if (!net_eq(ib2_net(tb), net) || tb->port != port ||
+	    tb->l3mdev != l3mdev)
+		return false;
+
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family != tb->family) {
 		if (sk->sk_family == AF_INET)
-			return net_eq(ib2_net(tb), net) && tb->port == port &&
-				tb->l3mdev == l3mdev &&
-				ipv6_addr_any(&tb->v6_rcv_saddr);
+			return ipv6_addr_any(&tb->v6_rcv_saddr);
 
 		return false;
 	}
 
 	if (sk->sk_family == AF_INET6)
-		return net_eq(ib2_net(tb), net) && tb->port == port &&
-			tb->l3mdev == l3mdev &&
-			ipv6_addr_any(&tb->v6_rcv_saddr);
-	else
+		return ipv6_addr_any(&tb->v6_rcv_saddr);
 #endif
-		return net_eq(ib2_net(tb), net) && tb->port == port &&
-			tb->l3mdev == l3mdev && tb->rcv_saddr == 0;
+	return tb->rcv_saddr == 0;
 }
 
 /* The socket's bhash2 hashbucket spinlock must be held when this is called */
-- 
2.40.1



