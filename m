Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D51E7ECD2F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjKOTey (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjKOTex (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:34:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979481BD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:34:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9B2C433CB;
        Wed, 15 Nov 2023 19:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076890;
        bh=JahcFFMT8uSVQvwUGYfXfssx8l5yoEs4RkJKGcerbE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qz2xTbZg8Mq7/Uytv00y1a4dOfamYgkwur3iMYqrrVzspf6D2XPdPTudPIRRnweSI
         6tR/sHaMh40Pq7RDYwVrweIeMIuUUXyS9YA22tG8p4/2CVnYFnTauAg9uMUWm3RKk2
         L1cIL7Rv0y7QlcwmqmN7pNhJhj7VGQHL14hbbSRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 058/603] udp: move udp->accept_udp_{l4|fraglist} to udp->udp_flags
Date:   Wed, 15 Nov 2023 14:10:03 -0500
Message-ID: <20231115191617.140663711@linuxfoundation.org>
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

[ Upstream commit f5f52f0884a595ff99ab1a608643fe4025fca2d5 ]

These are read locklessly, move them to udp_flags to fix data-races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 70a36f571362 ("udp: annotate data-races around udp->encap_type")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/udp.h | 16 +++++++++-------
 net/ipv4/udp.c      |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index b344bd2e41fc9..bb2b87adfbea9 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -37,6 +37,8 @@ enum {
 	UDP_FLAGS_NO_CHECK6_TX, /* Send zero UDP6 checksums on TX? */
 	UDP_FLAGS_NO_CHECK6_RX, /* Allow zero UDP6 checksums on RX? */
 	UDP_FLAGS_GRO_ENABLED,	/* Request GRO aggregation */
+	UDP_FLAGS_ACCEPT_FRAGLIST,
+	UDP_FLAGS_ACCEPT_L4,
 };
 
 struct udp_sock {
@@ -50,13 +52,11 @@ struct udp_sock {
 
 	int		 pending;	/* Any pending frames ? */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
-	unsigned char	 encap_enabled:1, /* This socket enabled encap
+	unsigned char	 encap_enabled:1; /* This socket enabled encap
 					   * processing; UDP tunnels and
 					   * different encapsulation layer set
 					   * this
 					   */
-			 accept_udp_l4:1,
-			 accept_udp_fraglist:1;
 /* indicator bits used by pcflag: */
 #define UDPLITE_BIT      0x1  		/* set by udplite proto init function */
 #define UDPLITE_SEND_CC  0x2  		/* set via udplite setsockopt         */
@@ -149,10 +149,12 @@ static inline bool udp_unexpected_gso(struct sock *sk, struct sk_buff *skb)
 	if (!skb_is_gso(skb))
 		return false;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 && !udp_sk(sk)->accept_udp_l4)
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+	    !udp_test_bit(ACCEPT_L4, sk))
 		return true;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST && !udp_sk(sk)->accept_udp_fraglist)
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST &&
+	    !udp_test_bit(ACCEPT_FRAGLIST, sk))
 		return true;
 
 	return false;
@@ -160,8 +162,8 @@ static inline bool udp_unexpected_gso(struct sock *sk, struct sk_buff *skb)
 
 static inline void udp_allow_gso(struct sock *sk)
 {
-	udp_sk(sk)->accept_udp_l4 = 1;
-	udp_sk(sk)->accept_udp_fraglist = 1;
+	udp_set_bit(ACCEPT_L4, sk);
+	udp_set_bit(ACCEPT_FRAGLIST, sk);
 }
 
 #define udp_portaddr_for_each_entry(__sk, list) \
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index db43907b9a3e8..75ba86a87bb62 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2716,7 +2716,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		if (valbool)
 			udp_tunnel_encap_enable(sk->sk_socket);
 		udp_assign_bit(GRO_ENABLED, sk, valbool);
-		up->accept_udp_l4 = valbool;
+		udp_assign_bit(ACCEPT_L4, sk, valbool);
 		release_sock(sk);
 		break;
 
-- 
2.42.0



