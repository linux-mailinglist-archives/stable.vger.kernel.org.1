Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1CB7ECB5A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjKOTVq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjKOTVk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:21:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C855D130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:21:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D70C433C9;
        Wed, 15 Nov 2023 19:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076097;
        bh=erRRbWHykfeBlOS/daF5O91DnyN9sK1Rvbfu/l7v25Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAxTbUjyhiSjoStVINSl9htmwP8A5qg8PRtnLQwYRDBib63HVN8hMggyfMjpCvSTR
         LkrcSPijO4BATQx42N+VF9cBJAgB5YCUOr6U346jKgtqHqtVQdrlKZkwea7zt0Adfq
         mBbnojQgQIvfMmR8jrbKsLCDyOdTy35k/eLlexv0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 057/550] udp: move udp->no_check6_tx to udp->udp_flags
Date:   Wed, 15 Nov 2023 14:10:41 -0500
Message-ID: <20231115191604.632702628@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a0002127cd746fcaa182ad3386ef6931c37f3bda ]

syzbot reported that udp->no_check6_tx can be read locklessly.
Use one atomic bit from udp->udp_flags

Fixes: 1c19448c9ba6 ("net: Make enabling of zero UDP6 csums more restrictive")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/udp.h | 10 +++++-----
 net/ipv4/udp.c      |  4 ++--
 net/ipv6/udp.c      |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 23f0693e0d9cc..e3f2a6c7ac1d1 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -34,6 +34,7 @@ static inline u32 udp_hashfn(const struct net *net, u32 num, u32 mask)
 
 enum {
 	UDP_FLAGS_CORK,		/* Cork is required */
+	UDP_FLAGS_NO_CHECK6_TX, /* Send zero UDP6 checksums on TX? */
 };
 
 struct udp_sock {
@@ -47,8 +48,7 @@ struct udp_sock {
 
 	int		 pending;	/* Any pending frames ? */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
-	unsigned char	 no_check6_tx:1,/* Send zero UDP6 checksums on TX? */
-			 no_check6_rx:1,/* Allow zero UDP6 checksums on RX? */
+	unsigned char	 no_check6_rx:1,/* Allow zero UDP6 checksums on RX? */
 			 encap_enabled:1, /* This socket enabled encap
 					   * processing; UDP tunnels and
 					   * different encapsulation layer set
@@ -115,7 +115,7 @@ struct udp_sock {
 
 static inline void udp_set_no_check6_tx(struct sock *sk, bool val)
 {
-	udp_sk(sk)->no_check6_tx = val;
+	udp_assign_bit(NO_CHECK6_TX, sk, val);
 }
 
 static inline void udp_set_no_check6_rx(struct sock *sk, bool val)
@@ -123,9 +123,9 @@ static inline void udp_set_no_check6_rx(struct sock *sk, bool val)
 	udp_sk(sk)->no_check6_rx = val;
 }
 
-static inline bool udp_get_no_check6_tx(struct sock *sk)
+static inline bool udp_get_no_check6_tx(const struct sock *sk)
 {
-	return udp_sk(sk)->no_check6_tx;
+	return udp_test_bit(NO_CHECK6_TX, sk);
 }
 
 static inline bool udp_get_no_check6_rx(struct sock *sk)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c7873bb4375d0..716eaddc7bdd0 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2719,7 +2719,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_NO_CHECK6_TX:
-		up->no_check6_tx = valbool;
+		udp_set_no_check6_tx(sk, valbool);
 		break;
 
 	case UDP_NO_CHECK6_RX:
@@ -2816,7 +2816,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_NO_CHECK6_TX:
-		val = up->no_check6_tx;
+		val = udp_get_no_check6_tx(sk);
 		break;
 
 	case UDP_NO_CHECK6_RX:
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 816247afc2f89..c4f82dfa533fe 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1270,7 +1270,7 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 			kfree_skb(skb);
 			return -EINVAL;
 		}
-		if (udp_sk(sk)->no_check6_tx) {
+		if (udp_get_no_check6_tx(sk)) {
 			kfree_skb(skb);
 			return -EINVAL;
 		}
@@ -1291,7 +1291,7 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 
 	if (is_udplite)
 		csum = udplite_csum(skb);
-	else if (udp_sk(sk)->no_check6_tx) {   /* UDP csum disabled */
+	else if (udp_get_no_check6_tx(sk)) {   /* UDP csum disabled */
 		skb->ip_summed = CHECKSUM_NONE;
 		goto send;
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) { /* UDP hardware csum */
-- 
2.42.0



