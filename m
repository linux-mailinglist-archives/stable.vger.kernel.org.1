Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64EB7ECD28
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjKOTeo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjKOTen (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:34:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5C1130
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:34:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F758C433C8;
        Wed, 15 Nov 2023 19:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076879;
        bh=Vb0o629es5sfJm1uXrlX3Mphs54iiTNlEQ79CUtLSAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnKZMczqU6e48+Y/TuUYP0DoOmAtvRKcQDuRDirfWQVvs8gkx2OdYDBHHAtEa/gaQ
         HkqsDt2Fl3C7CT3SR9vUKiX6fYPpTc1JjpX0BaeeHxaa//to+v+pEMLi+0JD9+cw8e
         74UiEOIc0Y2RQ+mrduZjL2rn52qiJdrBpywF4/e8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 055/603] udp: move udp->no_check6_rx to udp->udp_flags
Date:   Wed, 15 Nov 2023 14:10:00 -0500
Message-ID: <20231115191616.926940856@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit bcbc1b1de884647aa0318bf74eb7f293d72a1e40 ]

syzbot reported that udp->no_check6_rx can be read locklessly.
Use one atomic bit from udp->udp_flags.

Fixes: 1c19448c9ba6 ("net: Make enabling of zero UDP6 csums more restrictive")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/udp.h | 10 +++++-----
 net/ipv4/udp.c      |  4 ++--
 net/ipv6/udp.c      |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index e3f2a6c7ac1d1..8d4c3835b1b21 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -35,6 +35,7 @@ static inline u32 udp_hashfn(const struct net *net, u32 num, u32 mask)
 enum {
 	UDP_FLAGS_CORK,		/* Cork is required */
 	UDP_FLAGS_NO_CHECK6_TX, /* Send zero UDP6 checksums on TX? */
+	UDP_FLAGS_NO_CHECK6_RX, /* Allow zero UDP6 checksums on RX? */
 };
 
 struct udp_sock {
@@ -48,8 +49,7 @@ struct udp_sock {
 
 	int		 pending;	/* Any pending frames ? */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
-	unsigned char	 no_check6_rx:1,/* Allow zero UDP6 checksums on RX? */
-			 encap_enabled:1, /* This socket enabled encap
+	unsigned char	 encap_enabled:1, /* This socket enabled encap
 					   * processing; UDP tunnels and
 					   * different encapsulation layer set
 					   * this
@@ -120,7 +120,7 @@ static inline void udp_set_no_check6_tx(struct sock *sk, bool val)
 
 static inline void udp_set_no_check6_rx(struct sock *sk, bool val)
 {
-	udp_sk(sk)->no_check6_rx = val;
+	udp_assign_bit(NO_CHECK6_RX, sk, val);
 }
 
 static inline bool udp_get_no_check6_tx(const struct sock *sk)
@@ -128,9 +128,9 @@ static inline bool udp_get_no_check6_tx(const struct sock *sk)
 	return udp_test_bit(NO_CHECK6_TX, sk);
 }
 
-static inline bool udp_get_no_check6_rx(struct sock *sk)
+static inline bool udp_get_no_check6_rx(const struct sock *sk)
 {
-	return udp_sk(sk)->no_check6_rx;
+	return udp_test_bit(NO_CHECK6_RX, sk);
 }
 
 static inline void udp_cmsg_recv(struct msghdr *msg, struct sock *sk,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0c6998291c99d..cb32826a1db20 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2698,7 +2698,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_NO_CHECK6_RX:
-		up->no_check6_rx = valbool;
+		udp_set_no_check6_rx(sk, valbool);
 		break;
 
 	case UDP_SEGMENT:
@@ -2795,7 +2795,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_NO_CHECK6_RX:
-		val = up->no_check6_rx;
+		val = udp_get_no_check6_rx(sk);
 		break;
 
 	case UDP_SEGMENT:
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 469df0ca561f7..6e1ea3029260e 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -858,7 +858,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 		/* If zero checksum and no_check is not on for
 		 * the socket then skip it.
 		 */
-		if (!uh->check && !udp_sk(sk)->no_check6_rx)
+		if (!uh->check && !udp_get_no_check6_rx(sk))
 			continue;
 		if (!first) {
 			first = sk;
@@ -980,7 +980,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		if (unlikely(rcu_dereference(sk->sk_rx_dst) != dst))
 			udp6_sk_rx_dst_set(sk, dst);
 
-		if (!uh->check && !udp_sk(sk)->no_check6_rx) {
+		if (!uh->check && !udp_get_no_check6_rx(sk)) {
 			if (refcounted)
 				sock_put(sk);
 			goto report_csum_error;
@@ -1002,7 +1002,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	/* Unicast */
 	sk = __udp6_lib_lookup_skb(skb, uh->source, uh->dest, udptable);
 	if (sk) {
-		if (!uh->check && !udp_sk(sk)->no_check6_rx)
+		if (!uh->check && !udp_get_no_check6_rx(sk))
 			goto report_csum_error;
 		return udp6_unicast_rcv_skb(sk, skb, uh);
 	}
-- 
2.42.0



