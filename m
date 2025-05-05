Return-Path: <stable+bounces-140682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739B5AAAE9F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAC117473E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE34F393E80;
	Mon,  5 May 2025 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxa84x9a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D34037267A;
	Mon,  5 May 2025 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485917; cv=none; b=lkxGBQr/9/nzPzwLXJNkHKHv2YrbdM3y7vO9wGXiscwk8vH6hwi9TiZkO4GcGv4wFX/CuxgvIXAgYCmvx+gf2jJEvkwyZ6hdbl7TLPDqpT9i8wvoFUDKmBy+IdZvwRmVB7UkcNbOhLN/5NlF0nJqQqBZN4NCaVTZ8IFHunW0jg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485917; c=relaxed/simple;
	bh=39hkzjDfkXnmr1qhqbpL0xEVZqj0Ysy9UdjsREhQAq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgNSSc7ZHAc6st9ClkGfAyE47MCmh4iWsd3vjeAa3ZD2IAfZ1+mSRh6+7HdtpxMKpQrDA12ecHSEbzdf91rAtK85lxit7QRPcmCZBNanv5DpBnRpnhocgQuvvxIA98OmKT7RudbpUIihFRAjwa/5W5ZVnwhnCcNlR84GpdEuX5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxa84x9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE853C4CEEF;
	Mon,  5 May 2025 22:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485916;
	bh=39hkzjDfkXnmr1qhqbpL0xEVZqj0Ysy9UdjsREhQAq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mxa84x9agdWMz69bxSZCYL10ocQxKx2kKb91QXnTfyAiyyeKKw36H+/oJhU8Cbl+7
	 OTwugFX3oHlJp/QC4tOx9+GCtyuwdlhgK9bIzbTrCEm6GhhbO0hS0zkvUTbWa+RPa5
	 b9wgGW/JKSJf+pqvQsT5DFwaWlZf9DAwno42aaPmAIBeq1ZtRQaL10ohqOJHKuiV3O
	 SlXSEQDEJrW+guO9P/rt3ymfN1YES7TIqbM73SSL0eS8KJTLC+L18IiG1pnN0Rv/c9
	 9sN2VWt2ZzlrBXwqrw+dyX416Xl/zyyCqKg8RKZHFhxgLQO91ZPf/VGYOCu9UAnkaO
	 bJC8ix7z4c6Kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 063/294] tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
Date: Mon,  5 May 2025 18:52:43 -0400
Message-Id: <20250505225634.2688578-63-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ij@kernel.org>

[ Upstream commit 149dfb31615e22271d2525f078c95ea49bc4db24 ]

- Move tcp_count_delivered() earlier and split tcp_count_delivered_ce()
  out of it
- Move tcp_in_ack_event() later
- While at it, remove the inline from tcp_in_ack_event() and let
  the compiler to decide

Accurate ECN's heuristics does not know if there is going
to be ACE field based CE counter increase or not until after
rtx queue has been processed. Only then the number of ACKed
bytes/pkts is available. As CE or not affects presence of
FLAG_ECE, that information for tcp_in_ack_event is not yet
available in the old location of the call to tcp_in_ack_event().

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_input.c | 56 +++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 10d38ec0ff5ac..a172248b66783 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -425,6 +425,20 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr
 	return false;
 }
 
+static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
+{
+	tp->delivered_ce += ecn_count;
+}
+
+/* Updates the delivered and delivered_ce counts */
+static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
+				bool ece_ack)
+{
+	tp->delivered += delivered;
+	if (ece_ack)
+		tcp_count_delivered_ce(tp, delivered);
+}
+
 /* Buffer size and advertised window tuning.
  *
  * 1. Tuning sk->sk_sndbuf, when connection enters established state.
@@ -1137,15 +1151,6 @@ void tcp_mark_skb_lost(struct sock *sk, struct sk_buff *skb)
 	}
 }
 
-/* Updates the delivered and delivered_ce counts */
-static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
-				bool ece_ack)
-{
-	tp->delivered += delivered;
-	if (ece_ack)
-		tp->delivered_ce += delivered;
-}
-
 /* This procedure tags the retransmission queue when SACKs arrive.
  *
  * We have three tag bits: SACKED(S), RETRANS(R) and LOST(L).
@@ -3816,12 +3821,23 @@ static void tcp_process_tlp_ack(struct sock *sk, u32 ack, int flag)
 	}
 }
 
-static inline void tcp_in_ack_event(struct sock *sk, u32 flags)
+static void tcp_in_ack_event(struct sock *sk, int flag)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
 
-	if (icsk->icsk_ca_ops->in_ack_event)
-		icsk->icsk_ca_ops->in_ack_event(sk, flags);
+	if (icsk->icsk_ca_ops->in_ack_event) {
+		u32 ack_ev_flags = 0;
+
+		if (flag & FLAG_WIN_UPDATE)
+			ack_ev_flags |= CA_ACK_WIN_UPDATE;
+		if (flag & FLAG_SLOWPATH) {
+			ack_ev_flags |= CA_ACK_SLOWPATH;
+			if (flag & FLAG_ECE)
+				ack_ev_flags |= CA_ACK_ECE;
+		}
+
+		icsk->icsk_ca_ops->in_ack_event(sk, ack_ev_flags);
+	}
 }
 
 /* Congestion control has updated the cwnd already. So if we're in
@@ -3938,12 +3954,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		tcp_snd_una_update(tp, ack);
 		flag |= FLAG_WIN_UPDATE;
 
-		tcp_in_ack_event(sk, CA_ACK_WIN_UPDATE);
-
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPHPACKS);
 	} else {
-		u32 ack_ev_flags = CA_ACK_SLOWPATH;
-
 		if (ack_seq != TCP_SKB_CB(skb)->end_seq)
 			flag |= FLAG_DATA;
 		else
@@ -3955,19 +3967,12 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 			flag |= tcp_sacktag_write_queue(sk, skb, prior_snd_una,
 							&sack_state);
 
-		if (tcp_ecn_rcv_ecn_echo(tp, tcp_hdr(skb))) {
+		if (tcp_ecn_rcv_ecn_echo(tp, tcp_hdr(skb)))
 			flag |= FLAG_ECE;
-			ack_ev_flags |= CA_ACK_ECE;
-		}
 
 		if (sack_state.sack_delivered)
 			tcp_count_delivered(tp, sack_state.sack_delivered,
 					    flag & FLAG_ECE);
-
-		if (flag & FLAG_WIN_UPDATE)
-			ack_ev_flags |= CA_ACK_WIN_UPDATE;
-
-		tcp_in_ack_event(sk, ack_ev_flags);
 	}
 
 	/* This is a deviation from RFC3168 since it states that:
@@ -3994,6 +3999,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	tcp_rack_update_reo_wnd(sk, &rs);
 
+	tcp_in_ack_event(sk, flag);
+
 	if (tp->tlp_high_seq)
 		tcp_process_tlp_ack(sk, ack, flag);
 
@@ -4025,6 +4032,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	return 1;
 
 no_queue:
+	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
-- 
2.39.5


