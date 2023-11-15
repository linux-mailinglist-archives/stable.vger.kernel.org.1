Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36787ECB4F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjKOTVi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjKOTV2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:21:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DE7D5A
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:21:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E82C433CA;
        Wed, 15 Nov 2023 19:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076082;
        bh=8HWTpNQWzEkyRCShSQIunINInjS9k7A/CWRZkP9k04k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQs4h9YYYDnyL5XVJbwnwR5O7zeCrCeaQAmzL9Es2YQGFVahnxL8LqI0ocGZf5W7O
         TjKwLUUTxskDwg9K2UgG9zRIZ9UJmNG3hZMTAkbMRez82ld5vj+8xJJ2SohGwVoRoV
         hYIqz/jjiItgeO3owvaCZzRY1PCSfwAo7DMxOJek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 065/550] udplite: fix various data-races
Date:   Wed, 15 Nov 2023 14:10:49 -0500
Message-ID: <20231115191605.193103857@linuxfoundation.org>
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

[ Upstream commit 882af43a0fc37e26d85fb0df0c9edd3bed928de4 ]

udp->pcflag, udp->pcslen and udp->pcrlen reads/writes are racy.

Move udp->pcflag to udp->udp_flags for atomicity,
and add READ_ONCE()/WRITE_ONCE() annotations for pcslen and pcrlen.

Fixes: ba4e58eca8aa ("[NET]: Supporting UDP-Lite (RFC 3828) in Linux")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/udp.h   |  6 ++----
 include/net/udplite.h | 14 +++++++++-----
 net/ipv4/udp.c        | 21 +++++++++++----------
 net/ipv6/udp.c        |  9 +++++----
 4 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 58156edec0096..d04188714dca1 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -40,6 +40,8 @@ enum {
 	UDP_FLAGS_ACCEPT_FRAGLIST,
 	UDP_FLAGS_ACCEPT_L4,
 	UDP_FLAGS_ENCAP_ENABLED, /* This socket enabled encap */
+	UDP_FLAGS_UDPLITE_SEND_CC, /* set via udplite setsockopt */
+	UDP_FLAGS_UDPLITE_RECV_CC, /* set via udplite setsockopt */
 };
 
 struct udp_sock {
@@ -54,10 +56,6 @@ struct udp_sock {
 	int		 pending;	/* Any pending frames ? */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
 
-/* indicator bits used by pcflag: */
-#define UDPLITE_SEND_CC  0x1  		/* set via udplite setsockopt         */
-#define UDPLITE_RECV_CC  0x2		/* set via udplite setsocktopt        */
-	__u8		 pcflag;        /* marks socket as UDP-Lite if > 0    */
 	/*
 	 * Following member retains the information to create a UDP header
 	 * when the socket is uncorked.
diff --git a/include/net/udplite.h b/include/net/udplite.h
index 299c14ce2bb94..dd60b51364837 100644
--- a/include/net/udplite.h
+++ b/include/net/udplite.h
@@ -66,14 +66,18 @@ static inline int udplite_checksum_init(struct sk_buff *skb, struct udphdr *uh)
 /* Fast-path computation of checksum. Socket may not be locked. */
 static inline __wsum udplite_csum(struct sk_buff *skb)
 {
-	const struct udp_sock *up = udp_sk(skb->sk);
 	const int off = skb_transport_offset(skb);
+	const struct sock *sk = skb->sk;
 	int len = skb->len - off;
 
-	if ((up->pcflag & UDPLITE_SEND_CC) && up->pcslen < len) {
-		if (0 < up->pcslen)
-			len = up->pcslen;
-		udp_hdr(skb)->len = htons(up->pcslen);
+	if (udp_test_bit(UDPLITE_SEND_CC, sk)) {
+		u16 pcslen = READ_ONCE(udp_sk(sk)->pcslen);
+
+		if (pcslen < len) {
+			if (pcslen > 0)
+				len = pcslen;
+			udp_hdr(skb)->len = htons(pcslen);
+		}
 	}
 	skb->ip_summed = CHECKSUM_NONE;     /* no HW support for checksumming */
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index be0370a64cc15..f712ff61beb8a 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2149,7 +2149,8 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	/*
 	 * 	UDP-Lite specific tests, ignored on UDP sockets
 	 */
-	if ((up->pcflag & UDPLITE_RECV_CC)  &&  UDP_SKB_CB(skb)->partial_cov) {
+	if (udp_test_bit(UDPLITE_RECV_CC, sk) && UDP_SKB_CB(skb)->partial_cov) {
+		u16 pcrlen = READ_ONCE(up->pcrlen);
 
 		/*
 		 * MIB statistics other than incrementing the error count are
@@ -2162,7 +2163,7 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 		 * delivery of packets with coverage values less than a value
 		 * provided by the application."
 		 */
-		if (up->pcrlen == 0) {          /* full coverage was set  */
+		if (pcrlen == 0) {          /* full coverage was set  */
 			net_dbg_ratelimited("UDPLite: partial coverage %d while full coverage %d requested\n",
 					    UDP_SKB_CB(skb)->cscov, skb->len);
 			goto drop;
@@ -2173,9 +2174,9 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 		 * that it wants x while sender emits packets of smaller size y.
 		 * Therefore the above ...()->partial_cov statement is essential.
 		 */
-		if (UDP_SKB_CB(skb)->cscov  <  up->pcrlen) {
+		if (UDP_SKB_CB(skb)->cscov < pcrlen) {
 			net_dbg_ratelimited("UDPLite: coverage %d too small, need min %d\n",
-					    UDP_SKB_CB(skb)->cscov, up->pcrlen);
+					    UDP_SKB_CB(skb)->cscov, pcrlen);
 			goto drop;
 		}
 	}
@@ -2754,8 +2755,8 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 			val = 8;
 		else if (val > USHRT_MAX)
 			val = USHRT_MAX;
-		up->pcslen = val;
-		up->pcflag |= UDPLITE_SEND_CC;
+		WRITE_ONCE(up->pcslen, val);
+		udp_set_bit(UDPLITE_SEND_CC, sk);
 		break;
 
 	/* The receiver specifies a minimum checksum coverage value. To make
@@ -2768,8 +2769,8 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 			val = 8;
 		else if (val > USHRT_MAX)
 			val = USHRT_MAX;
-		up->pcrlen = val;
-		up->pcflag |= UDPLITE_RECV_CC;
+		WRITE_ONCE(up->pcrlen, val);
+		udp_set_bit(UDPLITE_RECV_CC, sk);
 		break;
 
 	default:
@@ -2833,11 +2834,11 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 	/* The following two cannot be changed on UDP sockets, the return is
 	 * always 0 (which corresponds to the full checksum coverage of UDP). */
 	case UDPLITE_SEND_CSCOV:
-		val = up->pcslen;
+		val = READ_ONCE(up->pcslen);
 		break;
 
 	case UDPLITE_RECV_CSCOV:
-		val = up->pcrlen;
+		val = READ_ONCE(up->pcrlen);
 		break;
 
 	default:
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 9988160ca4a76..8d79642ae45dd 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -760,16 +760,17 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	/*
 	 * UDP-Lite specific tests, ignored on UDP sockets (see net/ipv4/udp.c).
 	 */
-	if ((up->pcflag & UDPLITE_RECV_CC)  &&  UDP_SKB_CB(skb)->partial_cov) {
+	if (udp_test_bit(UDPLITE_RECV_CC, sk) && UDP_SKB_CB(skb)->partial_cov) {
+		u16 pcrlen = READ_ONCE(up->pcrlen);
 
-		if (up->pcrlen == 0) {          /* full coverage was set  */
+		if (pcrlen == 0) {          /* full coverage was set  */
 			net_dbg_ratelimited("UDPLITE6: partial coverage %d while full coverage %d requested\n",
 					    UDP_SKB_CB(skb)->cscov, skb->len);
 			goto drop;
 		}
-		if (UDP_SKB_CB(skb)->cscov  <  up->pcrlen) {
+		if (UDP_SKB_CB(skb)->cscov < pcrlen) {
 			net_dbg_ratelimited("UDPLITE6: coverage %d too small, need min %d\n",
-					    UDP_SKB_CB(skb)->cscov, up->pcrlen);
+					    UDP_SKB_CB(skb)->cscov, pcrlen);
 			goto drop;
 		}
 	}
-- 
2.42.0



