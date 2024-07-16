Return-Path: <stable+bounces-59612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DC5932AED
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7879FB2420F
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76181DDF5;
	Tue, 16 Jul 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zGvJX7mQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C5FB641;
	Tue, 16 Jul 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144372; cv=none; b=oCyagZeKcfBwmKF2rQB9QjxXYCk69Tlbt0miAbMK0R7MAW7M+soKWM/fRMYcQhwItes368v7zJIMwfLVDcoJY0v6IWdbmhQZZ0oFJ9FVfO0TA7aLxspBaN/368tywyOTaL/wf+NscpWD02uaQyBmk60qgmVNUVlP5AYb3Q5rw8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144372; c=relaxed/simple;
	bh=1icScSuqb2cBR4TfYCStOJAS0Ho8pndNy9ouHpVGPY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ivkd9uYaToCWUAbc4qaHFV/DvG/AlOGixl+TVIc1viXhWf5Mt/Xo3s52MILjpQkHyeafrXSsnkKpsLpU2EQFfEj15gBcmAN04KLoC+e8UXOK8zOuRPImbtCRgJRgPu8ij8E6p+z+7i1AYK73wWoCqN1t0JCxUXnKdf8/qrAKTbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zGvJX7mQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34BDC116B1;
	Tue, 16 Jul 2024 15:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144372;
	bh=1icScSuqb2cBR4TfYCStOJAS0Ho8pndNy9ouHpVGPY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zGvJX7mQjmpvslZFmTRXkS3FvZdwnrPaSgXvQdvDF4Ruiv1rqBa2TYf8uFdNZ14bD
	 KrFgbUiZ2Qw+vkbMCGljKtPFH1A9sUkEy3ImoDodqEU/vZIk8c+P/+CTLOqz3Bys0z
	 2Ri/5Cfti/U+eUnDp0LJbvEOF9s8JelMQaERYEzU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Baron <jbaron@akamai.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Christoph Paasch <cpaasch@apple.com>,
	Yuchung Cheng <ycheng@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 49/78] tcp: add TCP_INFO status for failed client TFO
Date: Tue, 16 Jul 2024 17:31:21 +0200
Message-ID: <20240716152742.537649803@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152740.626160410@linuxfoundation.org>
References: <20240716152740.626160410@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Baron <jbaron@akamai.com>

[ Upstream commit 480274787d7e3458bc5a7cfbbbe07033984ad711 ]

The TCPI_OPT_SYN_DATA bit as part of tcpi_options currently reports whether
or not data-in-SYN was ack'd on both the client and server side. We'd like
to gather more information on the client-side in the failure case in order
to indicate the reason for the failure. This can be useful for not only
debugging TFO, but also for creating TFO socket policies. For example, if
a middle box removes the TFO option or drops a data-in-SYN, we can
can detect this case, and turn off TFO for these connections saving the
extra retransmits.

The newly added tcpi_fastopen_client_fail status is 2 bits and has the
following 4 states:

1) TFO_STATUS_UNSPEC

Catch-all state which includes when TFO is disabled via black hole
detection, which is indicated via LINUX_MIB_TCPFASTOPENBLACKHOLE.

2) TFO_COOKIE_UNAVAILABLE

If TFO_CLIENT_NO_COOKIE mode is off, this state indicates that no cookie
is available in the cache.

3) TFO_DATA_NOT_ACKED

Data was sent with SYN, we received a SYN/ACK but it did not cover the data
portion. Cookie is not accepted by server because the cookie may be invalid
or the server may be overloaded.

4) TFO_SYN_RETRANSMITTED

Data was sent with SYN, we received a SYN/ACK which did not cover the data
after at least 1 additional SYN was sent (without data). It may be the case
that a middle-box is dropping data-in-SYN packets. Thus, it would be more
efficient to not use TFO on this connection to avoid extra retransmits
during connection establishment.

These new fields do not cover all the cases where TFO may fail, but other
failures, such as SYN/ACK + data being dropped, will result in the
connection not becoming established. And a connection blackhole after
session establishment shows up as a stalled connection.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Christoph Paasch <cpaasch@apple.com>
Cc: Yuchung Cheng <ycheng@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 0ec986ed7bab ("tcp: fix incorrect undo caused by DSACK of TLP retransmit")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/tcp.h      |  2 +-
 include/uapi/linux/tcp.h | 10 +++++++++-
 net/ipv4/tcp.c           |  2 ++
 net/ipv4/tcp_fastopen.c  |  5 ++++-
 net/ipv4/tcp_input.c     |  4 ++++
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 68dacc1994376..0c1255a9d3068 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -225,7 +225,7 @@ struct tcp_sock {
 		fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
 		fastopen_no_cookie:1, /* Allow send/recv SYN+data without a cookie */
 		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
-		unused:2;
+		fastopen_client_fail:2; /* reason why fastopen failed */
 	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
 		thin_lto    : 1,/* Use linear timeouts for thin streams */
 		recvmsg_inq : 1,/* Indicate # of bytes in queue upon recvmsg */
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 81e697978e8b5..74af1f759cee4 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -155,6 +155,14 @@ enum {
 	TCP_QUEUES_NR,
 };
 
+/* why fastopen failed from client perspective */
+enum tcp_fastopen_client_fail {
+	TFO_STATUS_UNSPEC, /* catch-all */
+	TFO_COOKIE_UNAVAILABLE, /* if not in TFO_CLIENT_NO_COOKIE mode */
+	TFO_DATA_NOT_ACKED, /* SYN-ACK did not ack SYN data */
+	TFO_SYN_RETRANSMITTED, /* SYN-ACK did not ack SYN data after timeout */
+};
+
 /* for TCP_INFO socket option */
 #define TCPI_OPT_TIMESTAMPS	1
 #define TCPI_OPT_SACK		2
@@ -211,7 +219,7 @@ struct tcp_info {
 	__u8	tcpi_backoff;
 	__u8	tcpi_options;
 	__u8	tcpi_snd_wscale : 4, tcpi_rcv_wscale : 4;
-	__u8	tcpi_delivery_rate_app_limited:1;
+	__u8	tcpi_delivery_rate_app_limited:1, tcpi_fastopen_client_fail:2;
 
 	__u32	tcpi_rto;
 	__u32	tcpi_ato;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a878b8b6e0b96..54399256a4380 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2713,6 +2713,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	/* Clean up fastopen related fields */
 	tcp_free_fastopen_req(tp);
 	inet->defer_connect = 0;
+	tp->fastopen_client_fail = 0;
 
 	WARN_ON(inet->inet_num && !icsk->icsk_bind_hash);
 
@@ -3360,6 +3361,7 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 	info->tcpi_reord_seen = tp->reord_seen;
 	info->tcpi_rcv_ooopack = tp->rcv_ooopack;
 	info->tcpi_snd_wnd = tp->snd_wnd;
+	info->tcpi_fastopen_client_fail = tp->fastopen_client_fail;
 	unlock_sock_fast(sk, slow);
 }
 EXPORT_SYMBOL_GPL(tcp_get_info);
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 35088cd30840d..38752bdedee39 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -446,7 +446,10 @@ bool tcp_fastopen_cookie_check(struct sock *sk, u16 *mss,
 		cookie->len = -1;
 		return true;
 	}
-	return cookie->len > 0;
+	if (cookie->len > 0)
+		return true;
+	tcp_sk(sk)->fastopen_client_fail = TFO_COOKIE_UNAVAILABLE;
+	return false;
 }
 
 /* This function checks if we want to defer sending SYN until the first
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 702f46d2f9fea..57907fe94b238 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5896,6 +5896,10 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
 	tcp_fastopen_cache_set(sk, mss, cookie, syn_drop, try_exp);
 
 	if (data) { /* Retransmit unacked data in SYN */
+		if (tp->total_retrans)
+			tp->fastopen_client_fail = TFO_SYN_RETRANSMITTED;
+		else
+			tp->fastopen_client_fail = TFO_DATA_NOT_ACKED;
 		skb_rbtree_walk_from(data) {
 			if (__tcp_retransmit_skb(sk, data, 1))
 				break;
-- 
2.43.0




