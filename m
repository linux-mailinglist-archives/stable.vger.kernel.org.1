Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4907ECB68
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjKOTWI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjKOTWG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:22:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CC61A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:22:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509AFC433C7;
        Wed, 15 Nov 2023 19:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076121;
        bh=qwMhULPB1HF3+XVVzMtxxXajPoPkCBMzWs4CscONyHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpSuZr87+Gnu2u6EjvBofhZYksV98jWs5Zq9uN1EpE4bwWgvL7wVJ5zgn8QbcpYVX
         zC9SYXqcauLDIKul/3+qiPsA97I2ea4zUKyBQkBUMxIKPYyW8XQmP7QIWAR0oIVLsW
         sOhYTegPulZtAf+CE+3IjIhqQJzCimRM1LItPYk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 062/550] udp: lockless UDP_ENCAP_L2TPINUDP / UDP_GRO
Date:   Wed, 15 Nov 2023 14:10:46 -0500
Message-ID: <20231115191604.984128370@linuxfoundation.org>
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

[ Upstream commit ac9a7f4ce5dda1472e8f44096f33066c6ec1a3b4 ]

Move udp->encap_enabled to udp->udp_flags.

Add udp_test_and_set_bit() helper to allow lockless
udp_tunnel_encap_enable() implementation.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 70a36f571362 ("udp: annotate data-races around udp->encap_type")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/udp.h        |  9 ++++-----
 include/net/udp_tunnel.h   |  9 +++------
 net/ipv4/udp.c             | 10 +++-------
 net/ipv4/udp_tunnel_core.c |  2 +-
 net/ipv6/udp.c             |  2 +-
 5 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index bb2b87adfbea9..0cf83270a4a28 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -39,6 +39,7 @@ enum {
 	UDP_FLAGS_GRO_ENABLED,	/* Request GRO aggregation */
 	UDP_FLAGS_ACCEPT_FRAGLIST,
 	UDP_FLAGS_ACCEPT_L4,
+	UDP_FLAGS_ENCAP_ENABLED, /* This socket enabled encap */
 };
 
 struct udp_sock {
@@ -52,11 +53,7 @@ struct udp_sock {
 
 	int		 pending;	/* Any pending frames ? */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
-	unsigned char	 encap_enabled:1; /* This socket enabled encap
-					   * processing; UDP tunnels and
-					   * different encapsulation layer set
-					   * this
-					   */
+
 /* indicator bits used by pcflag: */
 #define UDPLITE_BIT      0x1  		/* set by udplite proto init function */
 #define UDPLITE_SEND_CC  0x2  		/* set via udplite setsockopt         */
@@ -104,6 +101,8 @@ struct udp_sock {
 	test_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
 #define udp_set_bit(nr, sk)			\
 	set_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
+#define udp_test_and_set_bit(nr, sk)		\
+	test_and_set_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
 #define udp_clear_bit(nr, sk)			\
 	clear_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
 #define udp_assign_bit(nr, sk, val)		\
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 0ca9b7a11baf5..29251c3519cf0 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -174,16 +174,13 @@ static inline int udp_tunnel_handle_offloads(struct sk_buff *skb, bool udp_csum)
 }
 #endif
 
-static inline void udp_tunnel_encap_enable(struct socket *sock)
+static inline void udp_tunnel_encap_enable(struct sock *sk)
 {
-	struct udp_sock *up = udp_sk(sock->sk);
-
-	if (up->encap_enabled)
+	if (udp_test_and_set_bit(ENCAP_ENABLED, sk))
 		return;
 
-	up->encap_enabled = 1;
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sock->sk->sk_family == PF_INET6)
+	if (READ_ONCE(sk->sk_family) == PF_INET6)
 		ipv6_stub->udpv6_encap_enable();
 #endif
 	udp_encap_enable();
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a2eb4921d2440..4df99839e7a30 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2643,7 +2643,7 @@ void udp_destroy_sock(struct sock *sk)
 			if (encap_destroy)
 				encap_destroy(sk);
 		}
-		if (up->encap_enabled)
+		if (udp_test_bit(ENCAP_ENABLED, sk))
 			static_branch_dec(&udp_encap_needed_key);
 	}
 }
@@ -2710,9 +2710,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 			fallthrough;
 		case UDP_ENCAP_L2TPINUDP:
 			up->encap_type = val;
-			lock_sock(sk);
-			udp_tunnel_encap_enable(sk->sk_socket);
-			release_sock(sk);
+			udp_tunnel_encap_enable(sk);
 			break;
 		default:
 			err = -ENOPROTOOPT;
@@ -2735,14 +2733,12 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_GRO:
-		lock_sock(sk);
 
 		/* when enabling GRO, accept the related GSO packet type */
 		if (valbool)
-			udp_tunnel_encap_enable(sk->sk_socket);
+			udp_tunnel_encap_enable(sk);
 		udp_assign_bit(GRO_ENABLED, sk, valbool);
 		udp_assign_bit(ACCEPT_L4, sk, valbool);
-		release_sock(sk);
 		break;
 
 	/*
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 5f8104cf082d0..732e21b75ba28 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -78,7 +78,7 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 	udp_sk(sk)->gro_receive = cfg->gro_receive;
 	udp_sk(sk)->gro_complete = cfg->gro_complete;
 
-	udp_tunnel_encap_enable(sock);
+	udp_tunnel_encap_enable(sk);
 }
 EXPORT_SYMBOL_GPL(setup_udp_tunnel_sock);
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 3e9497418758f..4f39511bb0969 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1699,7 +1699,7 @@ void udpv6_destroy_sock(struct sock *sk)
 			if (encap_destroy)
 				encap_destroy(sk);
 		}
-		if (up->encap_enabled) {
+		if (udp_test_bit(ENCAP_ENABLED, sk)) {
 			static_branch_dec(&udpv6_encap_needed_key);
 			udp_encap_disable();
 		}
-- 
2.42.0



