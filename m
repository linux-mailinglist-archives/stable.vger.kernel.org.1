Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775D77A397E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjIQTu0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbjIQTuL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:50:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C1CC6
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:50:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F00C433C7;
        Sun, 17 Sep 2023 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980204;
        bh=3OiJQG7zSzLR/0HXgHOAs1iXZCGiI5hrESf2aIMvU1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jj4ePWzlf+zSlJ+pwHrgEmE+av8c8LHZhy9Xhhl31wOZAKFAJlZVdCHvAGVJ8Od77
         TOqyHsp4CGXF1wgV8syILAfTTXejm8SPlKKjCN3pyisjgf+UE4B4vZH6v44DlbVoxG
         QqoMroDpMhg7KHDg73nIX5Uf7/RQNTJnhKWYK3J0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 122/285] net: annotate data-races around sk->sk_tsflags
Date:   Sun, 17 Sep 2023 21:12:02 +0200
Message-ID: <20230917191055.889201672@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit e3390b30a5dfb112e8e802a59c0f68f947b638b2 ]

sk->sk_tsflags can be read locklessly, add corresponding annotations.

Fixes: b9f40e21ef42 ("net-timestamp: move timestamp flags out of sk_flags")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip.h       |  2 +-
 include/net/sock.h     | 17 ++++++++++-------
 net/can/j1939/socket.c | 10 ++++++----
 net/core/skbuff.c      | 10 ++++++----
 net/core/sock.c        |  4 ++--
 net/ipv4/ip_output.c   |  2 +-
 net/ipv4/ip_sockglue.c |  2 +-
 net/ipv4/tcp.c         |  4 ++--
 net/ipv6/ip6_output.c  |  2 +-
 net/ipv6/ping.c        |  2 +-
 net/ipv6/raw.c         |  2 +-
 net/ipv6/udp.c         |  2 +-
 net/socket.c           | 13 +++++++------
 13 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 19adacd5ece03..9276cea775cc2 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -94,7 +94,7 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 	ipcm_init(ipcm);
 
 	ipcm->sockc.mark = READ_ONCE(inet->sk.sk_mark);
-	ipcm->sockc.tsflags = inet->sk.sk_tsflags;
+	ipcm->sockc.tsflags = READ_ONCE(inet->sk.sk_tsflags);
 	ipcm->oif = READ_ONCE(inet->sk.sk_bound_dev_if);
 	ipcm->addr = inet->inet_saddr;
 	ipcm->protocol = inet->inet_num;
diff --git a/include/net/sock.h b/include/net/sock.h
index 85f9dffde05d0..4e787285fc66b 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1906,7 +1906,9 @@ struct sockcm_cookie {
 static inline void sockcm_init(struct sockcm_cookie *sockc,
 			       const struct sock *sk)
 {
-	*sockc = (struct sockcm_cookie) { .tsflags = sk->sk_tsflags };
+	*sockc = (struct sockcm_cookie) {
+		.tsflags = READ_ONCE(sk->sk_tsflags)
+	};
 }
 
 int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
@@ -2701,9 +2703,9 @@ void __sock_recv_wifi_status(struct msghdr *msg, struct sock *sk,
 static inline void
 sock_recv_timestamp(struct msghdr *msg, struct sock *sk, struct sk_buff *skb)
 {
-	ktime_t kt = skb->tstamp;
 	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
-
+	u32 tsflags = READ_ONCE(sk->sk_tsflags);
+	ktime_t kt = skb->tstamp;
 	/*
 	 * generate control messages if
 	 * - receive time stamping in software requested
@@ -2711,10 +2713,10 @@ sock_recv_timestamp(struct msghdr *msg, struct sock *sk, struct sk_buff *skb)
 	 * - hardware time stamps available and wanted
 	 */
 	if (sock_flag(sk, SOCK_RCVTSTAMP) ||
-	    (sk->sk_tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
-	    (kt && sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
+	    (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
+	    (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
 	    (hwtstamps->hwtstamp &&
-	     (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
+	     (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
 		__sock_recv_timestamp(msg, sk, skb);
 	else
 		sock_write_timestamp(sk, kt);
@@ -2736,7 +2738,8 @@ static inline void sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
 #define TSFLAGS_ANY	  (SOF_TIMESTAMPING_SOFTWARE			| \
 			   SOF_TIMESTAMPING_RAW_HARDWARE)
 
-	if (sk->sk_flags & FLAGS_RECV_CMSGS || sk->sk_tsflags & TSFLAGS_ANY)
+	if (sk->sk_flags & FLAGS_RECV_CMSGS ||
+	    READ_ONCE(sk->sk_tsflags) & TSFLAGS_ANY)
 		__sock_recv_cmsgs(msg, sk, skb);
 	else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP)))
 		sock_write_timestamp(sk, skb->tstamp);
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index feaec4ad6d163..b28c976f52a0a 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -974,6 +974,7 @@ static void __j1939_sk_errqueue(struct j1939_session *session, struct sock *sk,
 	struct sock_exterr_skb *serr;
 	struct sk_buff *skb;
 	char *state = "UNK";
+	u32 tsflags;
 	int err;
 
 	jsk = j1939_sk(sk);
@@ -981,13 +982,14 @@ static void __j1939_sk_errqueue(struct j1939_session *session, struct sock *sk,
 	if (!(jsk->state & J1939_SOCK_ERRQUEUE))
 		return;
 
+	tsflags = READ_ONCE(sk->sk_tsflags);
 	switch (type) {
 	case J1939_ERRQUEUE_TX_ACK:
-		if (!(sk->sk_tsflags & SOF_TIMESTAMPING_TX_ACK))
+		if (!(tsflags & SOF_TIMESTAMPING_TX_ACK))
 			return;
 		break;
 	case J1939_ERRQUEUE_TX_SCHED:
-		if (!(sk->sk_tsflags & SOF_TIMESTAMPING_TX_SCHED))
+		if (!(tsflags & SOF_TIMESTAMPING_TX_SCHED))
 			return;
 		break;
 	case J1939_ERRQUEUE_TX_ABORT:
@@ -997,7 +999,7 @@ static void __j1939_sk_errqueue(struct j1939_session *session, struct sock *sk,
 	case J1939_ERRQUEUE_RX_DPO:
 		fallthrough;
 	case J1939_ERRQUEUE_RX_ABORT:
-		if (!(sk->sk_tsflags & SOF_TIMESTAMPING_RX_SOFTWARE))
+		if (!(tsflags & SOF_TIMESTAMPING_RX_SOFTWARE))
 			return;
 		break;
 	default:
@@ -1054,7 +1056,7 @@ static void __j1939_sk_errqueue(struct j1939_session *session, struct sock *sk,
 	}
 
 	serr->opt_stats = true;
-	if (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)
+	if (tsflags & SOF_TIMESTAMPING_OPT_ID)
 		serr->ee.ee_data = session->tskey;
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p tskey: %i, state: %s\n",
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index acdf94bb54c80..7dfae58055c2b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5149,7 +5149,7 @@ static void __skb_complete_tx_timestamp(struct sk_buff *skb,
 	serr->ee.ee_info = tstype;
 	serr->opt_stats = opt_stats;
 	serr->header.h4.iif = skb->dev ? skb->dev->ifindex : 0;
-	if (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID) {
+	if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
 		serr->ee.ee_data = skb_shinfo(skb)->tskey;
 		if (sk_is_tcp(sk))
 			serr->ee.ee_data -= atomic_read(&sk->sk_tskey);
@@ -5205,21 +5205,23 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 {
 	struct sk_buff *skb;
 	bool tsonly, opt_stats = false;
+	u32 tsflags;
 
 	if (!sk)
 		return;
 
-	if (!hwtstamps && !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
+	tsflags = READ_ONCE(sk->sk_tsflags);
+	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
 	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
 		return;
 
-	tsonly = sk->sk_tsflags & SOF_TIMESTAMPING_OPT_TSONLY;
+	tsonly = tsflags & SOF_TIMESTAMPING_OPT_TSONLY;
 	if (!skb_may_tx_timestamp(sk, tsonly))
 		return;
 
 	if (tsonly) {
 #ifdef CONFIG_INET
-		if ((sk->sk_tsflags & SOF_TIMESTAMPING_OPT_STATS) &&
+		if ((tsflags & SOF_TIMESTAMPING_OPT_STATS) &&
 		    sk_is_tcp(sk)) {
 			skb = tcp_get_timestamping_opt_stats(sk, orig_skb,
 							     ack_skb);
diff --git a/net/core/sock.c b/net/core/sock.c
index 5edb17de6d1df..fea5961c51fd1 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -937,7 +937,7 @@ int sock_set_timestamping(struct sock *sk, int optname,
 			return ret;
 	}
 
-	sk->sk_tsflags = val;
+	WRITE_ONCE(sk->sk_tsflags, val);
 	sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname == SO_TIMESTAMPING_NEW);
 
 	if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
@@ -1718,7 +1718,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 	case SO_TIMESTAMPING_OLD:
 		lv = sizeof(v.timestamping);
-		v.timestamping.flags = sk->sk_tsflags;
+		v.timestamping.flags = READ_ONCE(sk->sk_tsflags);
 		v.timestamping.bind_phc = sk->sk_bind_phc;
 		break;
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a6e4c82615d7e..6935d07a60c35 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -982,7 +982,7 @@ static int __ip_append_data(struct sock *sk,
 	paged = !!cork->gso_size;
 
 	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
-	    sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)
+	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID)
 		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
 
 	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index d41bce8927b2c..d7006942fc2f9 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -510,7 +510,7 @@ static bool ipv4_datagram_support_cmsg(const struct sock *sk,
 	 * or without payload (SOF_TIMESTAMPING_OPT_TSONLY).
 	 */
 	info = PKTINFO_SKB_CB(skb);
-	if (!(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_CMSG) ||
+	if (!(READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_CMSG) ||
 	    !info->ipi_ifindex)
 		return false;
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8ed52e1e3c99a..75f24b931a185 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2256,14 +2256,14 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			}
 		}
 
-		if (sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE)
+		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE)
 			has_timestamping = true;
 		else
 			tss->ts[0] = (struct timespec64) {0};
 	}
 
 	if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
-		if (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
+		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_RAW_HARDWARE)
 			has_timestamping = true;
 		else
 			tss->ts[2] = (struct timespec64) {0};
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 016b0a513259f..9270ef7f8e98b 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1502,7 +1502,7 @@ static int __ip6_append_data(struct sock *sk,
 	orig_mtu = mtu;
 
 	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
-	    sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)
+	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID)
 		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
 
 	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 1b27728349725..5831aaa53d75e 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -119,7 +119,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		return -EINVAL;
 
 	ipcm6_init_sk(&ipc6, np);
-	ipc6.sockc.tsflags = sk->sk_tsflags;
+	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
 
 	fl6.flowi6_oif = oif;
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index ea16734f5e1f7..d52d5e34c12ae 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -778,7 +778,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	fl6.flowi6_uid = sk->sk_uid;
 
 	ipcm6_init(&ipc6);
-	ipc6.sockc.tsflags = sk->sk_tsflags;
+	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = fl6.flowi6_mark;
 
 	if (sin6) {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 3ffca158d3e11..24d3c5c791218 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1368,7 +1368,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	ipcm6_init(&ipc6);
 	ipc6.gso_size = READ_ONCE(up->gso_size);
-	ipc6.sockc.tsflags = sk->sk_tsflags;
+	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
 
 	/* destination address check */
diff --git a/net/socket.c b/net/socket.c
index f49edb9b49185..6bba7818b593d 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -821,7 +821,7 @@ static bool skb_is_swtx_tstamp(const struct sk_buff *skb, int false_tstamp)
 
 static ktime_t get_timestamp(struct sock *sk, struct sk_buff *skb, int *if_index)
 {
-	bool cycles = sk->sk_tsflags & SOF_TIMESTAMPING_BIND_PHC;
+	bool cycles = READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_PHC;
 	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
 	struct net_device *orig_dev;
 	ktime_t hwtstamp;
@@ -873,12 +873,12 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 	int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP);
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
 	struct scm_timestamping_internal tss;
-
 	int empty = 1, false_tstamp = 0;
 	struct skb_shared_hwtstamps *shhwtstamps =
 		skb_hwtstamps(skb);
 	int if_index;
 	ktime_t hwtstamp;
+	u32 tsflags;
 
 	/* Race occurred between timestamp enabling and packet
 	   receiving.  Fill in the current time for now. */
@@ -920,11 +920,12 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 	}
 
 	memset(&tss, 0, sizeof(tss));
-	if ((sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
+	tsflags = READ_ONCE(sk->sk_tsflags);
+	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
 	    ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
 		empty = 0;
 	if (shhwtstamps &&
-	    (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
+	    (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
 	    !skb_is_swtx_tstamp(skb, false_tstamp)) {
 		if_index = 0;
 		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
@@ -932,14 +933,14 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 		else
 			hwtstamp = shhwtstamps->hwtstamp;
 
-		if (sk->sk_tsflags & SOF_TIMESTAMPING_BIND_PHC)
+		if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
 			hwtstamp = ptp_convert_timestamp(&hwtstamp,
 							 sk->sk_bind_phc);
 
 		if (ktime_to_timespec64_cond(hwtstamp, tss.ts + 2)) {
 			empty = 0;
 
-			if ((sk->sk_tsflags & SOF_TIMESTAMPING_OPT_PKTINFO) &&
+			if ((tsflags & SOF_TIMESTAMPING_OPT_PKTINFO) &&
 			    !skb_is_err_queue(skb))
 				put_ts_pktinfo(msg, skb, if_index);
 		}
-- 
2.40.1



