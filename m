Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947E67ECD24
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjKOTeh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbjKOTeg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:34:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D6AA4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:34:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911DCC433C9;
        Wed, 15 Nov 2023 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076872;
        bh=iM/RJ5jix369dTYiOuiDKWsNJ3tvfhW4Yff+DX/UKT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZmCQzoYAs6juWVHdSjRdtBfI34sZcblMDMPYW/o7HVavcsl9VoLnrpVIaX/q2B6Vw
         vmBIDPrJstBID8T8UGk9qxgb/TNXABcBkc39bJQglA5cb1ChiaEm0pt5o4jLWX8AD5
         xLvILKlW4k72EgTzg4R7vppOkql2AcSFtmCGlB/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 053/603] udp: introduce udp->udp_flags
Date:   Wed, 15 Nov 2023 14:09:58 -0500
Message-ID: <20231115191616.787263650@linuxfoundation.org>
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

[ Upstream commit 81b36803ac139827538ac5ce4028e750a3c53f53 ]

According to syzbot, it is time to use proper atomic flags
for various UDP flags.

Add udp_flags field, and convert udp->corkflag to first
bit in it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: a0002127cd74 ("udp: move udp->no_check6_tx to udp->udp_flags")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/udp.h | 28 +++++++++++++++++++++-------
 net/ipv4/udp.c      | 12 ++++++------
 net/ipv6/udp.c      |  6 +++---
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 43c1fb2d2c21a..23f0693e0d9cc 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -32,14 +32,20 @@ static inline u32 udp_hashfn(const struct net *net, u32 num, u32 mask)
 	return (num + net_hash_mix(net)) & mask;
 }
 
+enum {
+	UDP_FLAGS_CORK,		/* Cork is required */
+};
+
 struct udp_sock {
 	/* inet_sock has to be the first member */
 	struct inet_sock inet;
 #define udp_port_hash		inet.sk.__sk_common.skc_u16hashes[0]
 #define udp_portaddr_hash	inet.sk.__sk_common.skc_u16hashes[1]
 #define udp_portaddr_node	inet.sk.__sk_common.skc_portaddr_node
+
+	unsigned long	 udp_flags;
+
 	int		 pending;	/* Any pending frames ? */
-	unsigned int	 corkflag;	/* Cork is required */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
 	unsigned char	 no_check6_tx:1,/* Send zero UDP6 checksums on TX? */
 			 no_check6_rx:1,/* Allow zero UDP6 checksums on RX? */
@@ -51,6 +57,11 @@ struct udp_sock {
 			 gro_enabled:1,	/* Request GRO aggregation */
 			 accept_udp_l4:1,
 			 accept_udp_fraglist:1;
+/* indicator bits used by pcflag: */
+#define UDPLITE_BIT      0x1  		/* set by udplite proto init function */
+#define UDPLITE_SEND_CC  0x2  		/* set via udplite setsockopt         */
+#define UDPLITE_RECV_CC  0x4		/* set via udplite setsocktopt        */
+	__u8		 pcflag;        /* marks socket as UDP-Lite if > 0    */
 	/*
 	 * Following member retains the information to create a UDP header
 	 * when the socket is uncorked.
@@ -62,12 +73,6 @@ struct udp_sock {
 	 */
 	__u16		 pcslen;
 	__u16		 pcrlen;
-/* indicator bits used by pcflag: */
-#define UDPLITE_BIT      0x1  		/* set by udplite proto init function */
-#define UDPLITE_SEND_CC  0x2  		/* set via udplite setsockopt         */
-#define UDPLITE_RECV_CC  0x4		/* set via udplite setsocktopt        */
-	__u8		 pcflag;        /* marks socket as UDP-Lite if > 0    */
-	__u8		 unused[3];
 	/*
 	 * For encapsulation sockets.
 	 */
@@ -95,6 +100,15 @@ struct udp_sock {
 	int		forward_threshold;
 };
 
+#define udp_test_bit(nr, sk)			\
+	test_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
+#define udp_set_bit(nr, sk)			\
+	set_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
+#define udp_clear_bit(nr, sk)			\
+	clear_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
+#define udp_assign_bit(nr, sk, val)		\
+	assign_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags, val)
+
 #define UDP_MAX_SEGMENTS	(1 << 6UL)
 
 #define udp_sk(ptr) container_of_const(ptr, struct udp_sock, inet.sk)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f39b9c8445808..9709f8a532dc3 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1051,7 +1051,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	u8 tos, scope;
 	__be16 dport;
 	int err, is_udplite = IS_UDPLITE(sk);
-	int corkreq = READ_ONCE(up->corkflag) || msg->msg_flags&MSG_MORE;
+	int corkreq = udp_test_bit(CORK, sk) || msg->msg_flags & MSG_MORE;
 	int (*getfrag)(void *, char *, int, int, int, struct sk_buff *);
 	struct sk_buff *skb;
 	struct ip_options_data opt_copy;
@@ -1315,11 +1315,11 @@ void udp_splice_eof(struct socket *sock)
 	struct sock *sk = sock->sk;
 	struct udp_sock *up = udp_sk(sk);
 
-	if (!up->pending || READ_ONCE(up->corkflag))
+	if (!up->pending || udp_test_bit(CORK, sk))
 		return;
 
 	lock_sock(sk);
-	if (up->pending && !READ_ONCE(up->corkflag))
+	if (up->pending && !udp_test_bit(CORK, sk))
 		udp_push_pending_frames(sk);
 	release_sock(sk);
 }
@@ -2658,9 +2658,9 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 	switch (optname) {
 	case UDP_CORK:
 		if (val != 0) {
-			WRITE_ONCE(up->corkflag, 1);
+			udp_set_bit(CORK, sk);
 		} else {
-			WRITE_ONCE(up->corkflag, 0);
+			udp_clear_bit(CORK, sk);
 			lock_sock(sk);
 			push_pending_frames(sk);
 			release_sock(sk);
@@ -2783,7 +2783,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 
 	switch (optname) {
 	case UDP_CORK:
-		val = READ_ONCE(up->corkflag);
+		val = udp_test_bit(CORK, sk);
 		break;
 
 	case UDP_ENCAP:
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 86b5d509a4688..0c6973cd22ce4 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1332,7 +1332,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int addr_len = msg->msg_namelen;
 	bool connected = false;
 	int ulen = len;
-	int corkreq = READ_ONCE(up->corkflag) || msg->msg_flags&MSG_MORE;
+	int corkreq = udp_test_bit(CORK, sk) || msg->msg_flags & MSG_MORE;
 	int err;
 	int is_udplite = IS_UDPLITE(sk);
 	int (*getfrag)(void *, char *, int, int, int, struct sk_buff *);
@@ -1644,11 +1644,11 @@ static void udpv6_splice_eof(struct socket *sock)
 	struct sock *sk = sock->sk;
 	struct udp_sock *up = udp_sk(sk);
 
-	if (!up->pending || READ_ONCE(up->corkflag))
+	if (!up->pending || udp_test_bit(CORK, sk))
 		return;
 
 	lock_sock(sk);
-	if (up->pending && !READ_ONCE(up->corkflag))
+	if (up->pending && !udp_test_bit(CORK, sk))
 		udp_v6_push_pending_frames(sk);
 	release_sock(sk);
 }
-- 
2.42.0



