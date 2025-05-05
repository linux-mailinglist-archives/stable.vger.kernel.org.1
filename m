Return-Path: <stable+bounces-140060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0DAAAA498
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A005E1888ABE
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428522798EA;
	Mon,  5 May 2025 22:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVPfMzuB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49BB28C87A;
	Mon,  5 May 2025 22:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484004; cv=none; b=tlhLPoKbYZVE89V6KaVIKSmxXT6Kd0s7kWizWYpw4miLSnvENZ02MoWRZvK2u0jb2PsphYswLODynUe07GNtkA3JGmKbNNeqDi6pwM4jI4VwC+JYqZmxzYovwtrywMJJEAjdK0oM7Oa0RzEethYJxAH18tfxZKJHCWTB2awDBwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484004; c=relaxed/simple;
	bh=lrYYyDYMuluFlk8IbOl5KYrdzwm8zyptzBr+gqY8TiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GFhv7elLng4lWuS85lqojhhYKMUZBANfMh/lVZKcfYo3bA3zEBO+DKk39YzDGlNslXVua39d030SAFBdMQJdhwduzz2xt/bYUhWPn3lkDSSdl3jbJk7B65yc8IfoUq5GSLwyiESy665WlGYXWA28CXRzh09gas35VQAu54sv2Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVPfMzuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91C8C4CEE4;
	Mon,  5 May 2025 22:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484003;
	bh=lrYYyDYMuluFlk8IbOl5KYrdzwm8zyptzBr+gqY8TiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVPfMzuBEIr6mPeVVVN/xh/0yYQO0HlwUsBe2UgAaTOsa//AbFyg8rdFUXZWcVObi
	 GYir3bJanzGOQLbHmyciOcxHDqZ2Zmv885mep/TeNuvJdmvNMKhRUHFHxXNPAPW01i
	 IshR0XOSeUE+FghRkijFEdsbRF5OLvlOKmMHpOOF6WJ5616cXlHUxrIKxxbuOmdeIc
	 3q+5NboyF6FOCgkff8fiC64bX9Nm5c2B3qrAGduw4prCcyTQqXcFqdcNjru5FvYeJG
	 hYnS3M1nJBZbXroJrExfgtStTZKWxithYkyfjHnisPkn7wq3dbuFzNSZtSSj0W4zFu
	 R3ZK6pQ+xYJdg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Yong-Hao Zou <yonghaoz1994@gmail.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	corbet@lwn.net,
	dsahern@kernel.org,
	kerneljasonxing@gmail.com,
	chopps@labn.net,
	sd@queasysnail.net,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 313/642] tcp: be less liberal in TSEcr received while in SYN_RECV state
Date: Mon,  5 May 2025 18:08:49 -0400
Message-Id: <20250505221419.2672473-313-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 3ba075278c11cdb19e2dbb80362042f1b0c08f74 ]

Yong-Hao Zou mentioned that linux was not strict as other OS in 3WHS,
for flows using TCP TS option (RFC 7323)

As hinted by an old comment in tcp_check_req(),
we can check the TSEcr value in the incoming packet corresponds
to one of the SYNACK TSval values we have sent.

In this patch, I record the oldest and most recent values
that SYNACK packets have used.

Send a challenge ACK if we receive a TSEcr outside
of this range, and increase a new SNMP counter.

nstat -az | grep TSEcrRejected
TcpExtTSEcrRejected            0                  0.0

Due to TCP fastopen implementation, do not apply yet these checks
for fastopen flows.

v2: No longer use req->num_timeout, but treq->snt_tsval_first
    to detect when first SYNACK is prepared. This means
    we make sure to not send an initial zero TSval.
    Make sure MPTCP and TCP selftests are passing.
    Change MIB name to TcpExtTSEcrRejected

v1: https://lore.kernel.org/netdev/CADVnQykD8i4ArpSZaPKaoNxLJ2if2ts9m4As+=Jvdkrgx1qMHw@mail.gmail.com/T/

Reported-by: Yong-Hao Zou <yonghaoz1994@gmail.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250225171048.3105061-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../networking/net_cachelines/snmp.rst        |  1 +
 include/linux/tcp.h                           |  2 ++
 include/uapi/linux/snmp.h                     |  1 +
 net/ipv4/proc.c                               |  1 +
 net/ipv4/syncookies.c                         |  1 +
 net/ipv4/tcp_input.c                          |  1 +
 net/ipv4/tcp_minisocks.c                      | 26 +++++++++++--------
 net/ipv4/tcp_output.c                         |  6 +++++
 8 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/net_cachelines/snmp.rst b/Documentation/networking/net_cachelines/snmp.rst
index 90ca2d92547d4..bc96efc92cf5b 100644
--- a/Documentation/networking/net_cachelines/snmp.rst
+++ b/Documentation/networking/net_cachelines/snmp.rst
@@ -36,6 +36,7 @@ unsigned_long  LINUX_MIB_TIMEWAITRECYCLED
 unsigned_long  LINUX_MIB_TIMEWAITKILLED
 unsigned_long  LINUX_MIB_PAWSACTIVEREJECTED
 unsigned_long  LINUX_MIB_PAWSESTABREJECTED
+unsigned_long  LINUX_MIB_TSECR_REJECTED
 unsigned_long  LINUX_MIB_DELAYEDACKLOST
 unsigned_long  LINUX_MIB_LISTENOVERFLOWS
 unsigned_long  LINUX_MIB_LISTENDROPS
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index f88daaa76d836..159b2c59eb627 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -160,6 +160,8 @@ struct tcp_request_sock {
 	u32				rcv_isn;
 	u32				snt_isn;
 	u32				ts_off;
+	u32				snt_tsval_first;
+	u32				snt_tsval_last;
 	u32				last_oow_ack_time; /* last SYNACK */
 	u32				rcv_nxt; /* the ack # by SYNACK. For
 						  * FastOpen it's the seq#
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index 848c7784e684c..eb9fb776fdc3e 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -186,6 +186,7 @@ enum
 	LINUX_MIB_TIMEWAITKILLED,		/* TimeWaitKilled */
 	LINUX_MIB_PAWSACTIVEREJECTED,		/* PAWSActiveRejected */
 	LINUX_MIB_PAWSESTABREJECTED,		/* PAWSEstabRejected */
+	LINUX_MIB_TSECRREJECTED,		/* TSEcrRejected */
 	LINUX_MIB_PAWS_OLD_ACK,			/* PAWSOldAck */
 	LINUX_MIB_DELAYEDACKS,			/* DelayedACKs */
 	LINUX_MIB_DELAYEDACKLOCKED,		/* DelayedACKLocked */
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index affd21a0f5728..10cbeb76c2745 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -189,6 +189,7 @@ static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("TWKilled", LINUX_MIB_TIMEWAITKILLED),
 	SNMP_MIB_ITEM("PAWSActive", LINUX_MIB_PAWSACTIVEREJECTED),
 	SNMP_MIB_ITEM("PAWSEstab", LINUX_MIB_PAWSESTABREJECTED),
+	SNMP_MIB_ITEM("TSEcrRejected", LINUX_MIB_TSECRREJECTED),
 	SNMP_MIB_ITEM("PAWSOldAck", LINUX_MIB_PAWS_OLD_ACK),
 	SNMP_MIB_ITEM("DelayedACKs", LINUX_MIB_DELAYEDACKS),
 	SNMP_MIB_ITEM("DelayedACKLocked", LINUX_MIB_DELAYEDACKLOCKED),
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 1948d15f1f281..25976fa7768c9 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -279,6 +279,7 @@ static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 		ireq->smc_ok = 0;
 
 	treq->snt_synack = 0;
+	treq->snt_tsval_first = 0;
 	treq->tfo_listener = false;
 	treq->txhash = net_tx_rndhash();
 	treq->rcv_isn = ntohl(th->seq) - 1;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 23cf8f4a37214..1b09b4d76c296 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7089,6 +7089,7 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->rcv_isn = TCP_SKB_CB(skb)->seq;
 	tcp_rsk(req)->rcv_nxt = TCP_SKB_CB(skb)->seq + 1;
 	tcp_rsk(req)->snt_synack = 0;
+	tcp_rsk(req)->snt_tsval_first = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
 	req->mss = rx_opt->mss_clamp;
 	req->ts_recent = rx_opt->saw_tstamp ? rx_opt->rcv_tsval : 0;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index dfdb7a4608a85..0d4ff5f2352f8 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -665,6 +665,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	struct sock *child;
 	const struct tcphdr *th = tcp_hdr(skb);
 	__be32 flg = tcp_flag_word(th) & (TCP_FLAG_RST|TCP_FLAG_SYN|TCP_FLAG_ACK);
+	bool tsecr_reject = false;
 	bool paws_reject = false;
 	bool own_req;
 
@@ -674,8 +675,13 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 
 		if (tmp_opt.saw_tstamp) {
 			tmp_opt.ts_recent = READ_ONCE(req->ts_recent);
-			if (tmp_opt.rcv_tsecr)
+			if (tmp_opt.rcv_tsecr) {
+				if (inet_rsk(req)->tstamp_ok && !fastopen)
+					tsecr_reject = !between(tmp_opt.rcv_tsecr,
+							tcp_rsk(req)->snt_tsval_first,
+							READ_ONCE(tcp_rsk(req)->snt_tsval_last));
 				tmp_opt.rcv_tsecr -= tcp_rsk(req)->ts_off;
+			}
 			/* We do not store true stamp, but it is not required,
 			 * it can be estimated (approximately)
 			 * from another data.
@@ -790,18 +796,14 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	     tcp_rsk(req)->snt_isn + 1))
 		return sk;
 
-	/* Also, it would be not so bad idea to check rcv_tsecr, which
-	 * is essentially ACK extension and too early or too late values
-	 * should cause reset in unsynchronized states.
-	 */
-
 	/* RFC793: "first check sequence number". */
 
-	if (paws_reject || !tcp_in_window(TCP_SKB_CB(skb)->seq,
-					  TCP_SKB_CB(skb)->end_seq,
-					  tcp_rsk(req)->rcv_nxt,
-					  tcp_rsk(req)->rcv_nxt +
-					  tcp_synack_window(req))) {
+	if (paws_reject || tsecr_reject ||
+	    !tcp_in_window(TCP_SKB_CB(skb)->seq,
+			   TCP_SKB_CB(skb)->end_seq,
+			   tcp_rsk(req)->rcv_nxt,
+			   tcp_rsk(req)->rcv_nxt +
+			   tcp_synack_window(req))) {
 		/* Out of window: send ACK and drop. */
 		if (!(flg & TCP_FLAG_RST) &&
 		    !tcp_oow_rate_limited(sock_net(sk), skb,
@@ -810,6 +812,8 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			req->rsk_ops->send_ack(sk, skb, req);
 		if (paws_reject)
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_PAWSESTABREJECTED);
+		else if (tsecr_reject)
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TSECRREJECTED);
 		return NULL;
 	}
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bc95d2a5924fd..6031d7f7f5198 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -941,6 +941,12 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 		opts->options |= OPTION_TS;
 		opts->tsval = tcp_skb_timestamp_ts(tcp_rsk(req)->req_usec_ts, skb) +
 			      tcp_rsk(req)->ts_off;
+		if (!tcp_rsk(req)->snt_tsval_first) {
+			if (!opts->tsval)
+				opts->tsval = ~0U;
+			tcp_rsk(req)->snt_tsval_first = opts->tsval;
+		}
+		WRITE_ONCE(tcp_rsk(req)->snt_tsval_last, opts->tsval);
 		opts->tsecr = READ_ONCE(req->ts_recent);
 		remaining -= TCPOLEN_TSTAMP_ALIGNED;
 	}
-- 
2.39.5


