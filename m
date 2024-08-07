Return-Path: <stable+bounces-65771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1176894ABD5
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC73E2828F6
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F6881751;
	Wed,  7 Aug 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uTD7ceCb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220A227448;
	Wed,  7 Aug 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043365; cv=none; b=A1TaKlDjapxv4x1d+kHX4yKE8hNwcnz1fD+PZEUnwkmrDJDft4MxKWHa3Ahu2h8BM2KSmcQSD4Qnt8OBwhu7vnQd4iyFz6I2wjQeTUQXztW48Yw+anPEMym1nbMJY0NfkGMi2fkHALPM5rLs0embhBlQcbTpgrC2o+NsXHVnkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043365; c=relaxed/simple;
	bh=dxeraXo47CbXyQn7gPd+j4rhikGsxrWb3KxunMH01V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDwBInV2tiqZg9WMAnRGru+l2fPTqwvrAZrcapOjjXWh/vsawEFs0mgx+6VAy8ebbjgCh40+aChmqffwWQr2RxV5+8NoAUFIoGBq6jAF8xFnRZ036MOtxZCgGE5//G7SmXFddexQATMPlNL90HasnD2zUoSgIm0tfCn/Yq/aQT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uTD7ceCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D9FC32781;
	Wed,  7 Aug 2024 15:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043364;
	bh=dxeraXo47CbXyQn7gPd+j4rhikGsxrWb3KxunMH01V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTD7ceCbepNpciRbF8MM2+TuwT63bk62mNR5Jb8XycceSBOEoKrp9PLuVE2nMcgJW
	 mqtoVTM/bTmbKdvLJ/nVCwB3OjhbFJvqHxlNuqVdC/66Chl7aXeAQVuJEnlO/Ci7cd
	 y8pdCQG7y9qb3y8vBIPkw6HDZkgRB3Yzj/WdeglM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 064/121] tcp: annotate data-races around tp->window_clamp
Date: Wed,  7 Aug 2024 16:59:56 +0200
Message-ID: <20240807150021.507309604@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150019.412911622@linuxfoundation.org>
References: <20240807150019.412911622@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f410cbea9f3d2675b4c8e52af1d1985b11b387d1 ]

tp->window_clamp can be read locklessly, add READ_ONCE()
and WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Link: https://lore.kernel.org/r/20240404114231.2195171-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 05f76b2d634e ("tcp: Adjust clamping window for applications specifying SO_RCVBUF")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/syncookies.c |  3 ++-
 net/ipv4/tcp.c        |  8 ++++----
 net/ipv4/tcp_input.c  | 17 ++++++++++-------
 net/ipv4/tcp_output.c | 18 ++++++++++--------
 net/ipv6/syncookies.c |  2 +-
 net/mptcp/protocol.c  |  2 +-
 net/mptcp/sockopt.c   |  2 +-
 7 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 3b4dafefb4b03..e143562077958 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -424,7 +424,8 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	}
 
 	/* Try to redo what tcp_v4_send_synack did. */
-	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(&rt->dst, RTAX_WINDOW);
+	req->rsk_window_clamp = READ_ONCE(tp->window_clamp) ? :
+				dst_metric(&rt->dst, RTAX_WINDOW);
 	/* limit the window selection if the user enforce a smaller rx buffer */
 	full_space = tcp_full_space(sk);
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 91c3d8264059d..1e3202f2b7a87 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1723,7 +1723,7 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	space = tcp_space_from_win(sk, val);
 	if (space > sk->sk_rcvbuf) {
 		WRITE_ONCE(sk->sk_rcvbuf, space);
-		tcp_sk(sk)->window_clamp = val;
+		WRITE_ONCE(tcp_sk(sk)->window_clamp, val);
 	}
 	return 0;
 }
@@ -3386,7 +3386,7 @@ int tcp_set_window_clamp(struct sock *sk, int val)
 	if (!val) {
 		if (sk->sk_state != TCP_CLOSE)
 			return -EINVAL;
-		tp->window_clamp = 0;
+		WRITE_ONCE(tp->window_clamp, 0);
 	} else {
 		u32 new_rcv_ssthresh, old_window_clamp = tp->window_clamp;
 		u32 new_window_clamp = val < SOCK_MIN_RCVBUF / 2 ?
@@ -3395,7 +3395,7 @@ int tcp_set_window_clamp(struct sock *sk, int val)
 		if (new_window_clamp == old_window_clamp)
 			return 0;
 
-		tp->window_clamp = new_window_clamp;
+		WRITE_ONCE(tp->window_clamp, new_window_clamp);
 		if (new_window_clamp < old_window_clamp) {
 			/* need to apply the reserved mem provisioning only
 			 * when shrinking the window clamp
@@ -4020,7 +4020,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 				      TCP_RTO_MAX / HZ);
 		break;
 	case TCP_WINDOW_CLAMP:
-		val = tp->window_clamp;
+		val = READ_ONCE(tp->window_clamp);
 		break;
 	case TCP_INFO: {
 		struct tcp_info info;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c2e4dac42453b..13464e35d7565 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -570,19 +570,20 @@ static void tcp_init_buffer_space(struct sock *sk)
 	maxwin = tcp_full_space(sk);
 
 	if (tp->window_clamp >= maxwin) {
-		tp->window_clamp = maxwin;
+		WRITE_ONCE(tp->window_clamp, maxwin);
 
 		if (tcp_app_win && maxwin > 4 * tp->advmss)
-			tp->window_clamp = max(maxwin -
-					       (maxwin >> tcp_app_win),
-					       4 * tp->advmss);
+			WRITE_ONCE(tp->window_clamp,
+				   max(maxwin - (maxwin >> tcp_app_win),
+				       4 * tp->advmss));
 	}
 
 	/* Force reservation of one segment. */
 	if (tcp_app_win &&
 	    tp->window_clamp > 2 * tp->advmss &&
 	    tp->window_clamp + tp->advmss > maxwin)
-		tp->window_clamp = max(2 * tp->advmss, maxwin - tp->advmss);
+		WRITE_ONCE(tp->window_clamp,
+			   max(2 * tp->advmss, maxwin - tp->advmss));
 
 	tp->rcv_ssthresh = min(tp->rcv_ssthresh, tp->window_clamp);
 	tp->snd_cwnd_stamp = tcp_jiffies32;
@@ -768,7 +769,8 @@ void tcp_rcv_space_adjust(struct sock *sk)
 			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
 
 			/* Make the window clamp follow along.  */
-			tp->window_clamp = tcp_win_from_space(sk, rcvbuf);
+			WRITE_ONCE(tp->window_clamp,
+				   tcp_win_from_space(sk, rcvbuf));
 		}
 	}
 	tp->rcvq_space.space = copied;
@@ -6347,7 +6349,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 
 		if (!tp->rx_opt.wscale_ok) {
 			tp->rx_opt.snd_wscale = tp->rx_opt.rcv_wscale = 0;
-			tp->window_clamp = min(tp->window_clamp, 65535U);
+			WRITE_ONCE(tp->window_clamp,
+				   min(tp->window_clamp, 65535U));
 		}
 
 		if (tp->rx_opt.saw_tstamp) {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5631041ae12cb..15c49d559db53 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -203,16 +203,17 @@ static inline void tcp_event_ack_sent(struct sock *sk, u32 rcv_nxt)
  * This MUST be enforced by all callers.
  */
 void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
-			       __u32 *rcv_wnd, __u32 *window_clamp,
+			       __u32 *rcv_wnd, __u32 *__window_clamp,
 			       int wscale_ok, __u8 *rcv_wscale,
 			       __u32 init_rcv_wnd)
 {
 	unsigned int space = (__space < 0 ? 0 : __space);
+	u32 window_clamp = READ_ONCE(*__window_clamp);
 
 	/* If no clamp set the clamp to the max possible scaled window */
-	if (*window_clamp == 0)
-		(*window_clamp) = (U16_MAX << TCP_MAX_WSCALE);
-	space = min(*window_clamp, space);
+	if (window_clamp == 0)
+		window_clamp = (U16_MAX << TCP_MAX_WSCALE);
+	space = min(window_clamp, space);
 
 	/* Quantize space offering to a multiple of mss if possible. */
 	if (space > mss)
@@ -239,12 +240,13 @@ void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
 		/* Set window scaling on max possible window */
 		space = max_t(u32, space, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
 		space = max_t(u32, space, READ_ONCE(sysctl_rmem_max));
-		space = min_t(u32, space, *window_clamp);
+		space = min_t(u32, space, window_clamp);
 		*rcv_wscale = clamp_t(int, ilog2(space) - 15,
 				      0, TCP_MAX_WSCALE);
 	}
 	/* Set the clamp no higher than max representable value */
-	(*window_clamp) = min_t(__u32, U16_MAX << (*rcv_wscale), *window_clamp);
+	WRITE_ONCE(*__window_clamp,
+		   min_t(__u32, U16_MAX << (*rcv_wscale), window_clamp));
 }
 EXPORT_SYMBOL(tcp_select_initial_window);
 
@@ -3787,7 +3789,7 @@ static void tcp_connect_init(struct sock *sk)
 	tcp_ca_dst_init(sk, dst);
 
 	if (!tp->window_clamp)
-		tp->window_clamp = dst_metric(dst, RTAX_WINDOW);
+		WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW));
 	tp->advmss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
 
 	tcp_initialize_rcv_mss(sk);
@@ -3795,7 +3797,7 @@ static void tcp_connect_init(struct sock *sk)
 	/* limit the window selection if the user enforce a smaller rx buffer */
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
 	    (tp->window_clamp > tcp_full_space(sk) || tp->window_clamp == 0))
-		tp->window_clamp = tcp_full_space(sk);
+		WRITE_ONCE(tp->window_clamp, tcp_full_space(sk));
 
 	rcv_wnd = tcp_rwnd_init_bpf(sk);
 	if (rcv_wnd == 0)
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 8698b49dfc8de..593ead8a45d79 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -243,7 +243,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 			goto out_free;
 	}
 
-	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(dst, RTAX_WINDOW);
+	req->rsk_window_clamp = READ_ONCE(tp->window_clamp) ? :dst_metric(dst, RTAX_WINDOW);
 	/* limit the window selection if the user enforce a smaller rx buffer */
 	full_space = tcp_full_space(sk);
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK &&
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d2edd02a137bd..973290d08e796 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2024,7 +2024,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 				ssk = mptcp_subflow_tcp_sock(subflow);
 				slow = lock_sock_fast(ssk);
 				WRITE_ONCE(ssk->sk_rcvbuf, rcvbuf);
-				tcp_sk(ssk)->window_clamp = window_clamp;
+				WRITE_ONCE(tcp_sk(ssk)->window_clamp, window_clamp);
 				tcp_cleanup_rbuf(ssk, 1);
 				unlock_sock_fast(ssk, slow);
 			}
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 6e254f10b41e6..3977332c44c0a 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1564,7 +1564,7 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
 
 		slow = lock_sock_fast(ssk);
 		WRITE_ONCE(ssk->sk_rcvbuf, space);
-		tcp_sk(ssk)->window_clamp = val;
+		WRITE_ONCE(tcp_sk(ssk)->window_clamp, val);
 		unlock_sock_fast(ssk, slow);
 	}
 	return 0;
-- 
2.43.0




