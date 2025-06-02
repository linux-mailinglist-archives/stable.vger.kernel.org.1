Return-Path: <stable+bounces-150326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E8EACB86D
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD741BC3B7E
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56DB234977;
	Mon,  2 Jun 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dFcfPHVt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082523185D;
	Mon,  2 Jun 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876767; cv=none; b=ZqkCxChUESthC1y5v38FN09HlPCUD9sJs7arG1K2wdN+hyT17yKOBD2n5lBGKWefL/hmPHUi0csTtPz2enwLVWjFKxp4Q6qGc91e1rcEsky26Ahl+tYcDzij5b+RdBgiTiJBvSuf9fFvZPAzPoe99Mt1uvu6lltKTTsttGVck28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876767; c=relaxed/simple;
	bh=3peYgRLXEWZ7HTmrKFub+cTdWsM3TYZGph5VfhzCRCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rji5jaDSYTsslkiWt74UXwBnVbtpweQPCYmKizhCtHJklVXg8ermx6Z/RMPxNnNCU+DQ3U/xskJfsP2+F9LtyDVR7GiEZYuGZvWFab7UFaO9SITWll2TW9j31/y5tZBhrk1EE8XKUBLhdjRUvuy14/Ovqmff42AxN0bb5XlfdiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dFcfPHVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26069C4CEEB;
	Mon,  2 Jun 2025 15:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876767;
	bh=3peYgRLXEWZ7HTmrKFub+cTdWsM3TYZGph5VfhzCRCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFcfPHVtfpAkOtGgGnIMdeycZCyfGzfxQ1AmTEnqZAUDTjw+KVtR8CCgNnDT/J2nW
	 pyUAgg9R4FrD6khYc5dtRCkZDy4KwJZsiI0AAzX7fVEDHSe4naUreXZuSXPJcia7zz
	 U5Mv4ucd2sf6hWJVzEHAYojRk5O98lG1qKGuuTmY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 067/325] tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
Date: Mon,  2 Jun 2025 15:45:43 +0200
Message-ID: <20250602134322.501619791@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 3b81f6df829ff..db1a99df29d55 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -404,6 +404,20 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp, const struct tcphdr
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
@@ -1119,15 +1133,6 @@ void tcp_mark_skb_lost(struct sock *sk, struct sk_buff *skb)
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
@@ -3783,12 +3788,23 @@ static void tcp_process_tlp_ack(struct sock *sk, u32 ack, int flag)
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
@@ -3905,12 +3921,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
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
@@ -3922,19 +3934,12 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
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
@@ -3961,6 +3966,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	tcp_rack_update_reo_wnd(sk, &rs);
 
+	tcp_in_ack_event(sk, flag);
+
 	if (tp->tlp_high_seq)
 		tcp_process_tlp_ack(sk, ack, flag);
 
@@ -3992,6 +3999,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	return 1;
 
 no_queue:
+	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
-- 
2.39.5




