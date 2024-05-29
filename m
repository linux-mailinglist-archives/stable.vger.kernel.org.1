Return-Path: <stable+bounces-47655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1C38D3D68
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 19:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F6C284EE9
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15901A38C5;
	Wed, 29 May 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LemeY3a3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A112181CFC;
	Wed, 29 May 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003792; cv=none; b=MTX4hSvzOpltleX+m48n6G3eyMu17QppnOFe25rQe/vj1zknKu3yoMJe9sxC42+PXvnYGLJB9j92H1Xf9SuN/TzgPVuh/dj/KEZ2Quom3I2Im1pMZOpDCvkMoBDmIqsaVEzE9r5QHqa0a7G1gwQ1HGJWmHmuihxWvDYQ5jrZYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003792; c=relaxed/simple;
	bh=A9UhXtEcisGdQ7S+GoLiZz5Cc4x1PGg5yQCUDuWY1OI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rr/DGMxOE7FLCUJodtMOnOwPeKRJB52sK8OP070Y5f0xNiT59+5GxjQZ4RERT1olzqogTWPuixzW8WnrIJ7HnDDCJB3VXzZGtGgIFC9sGhEOFLhHS0DGOeB94pDiI01k8ihunIRCvxzvHsPF8evIouNe9YdwK+r3Xzp1aX1dgAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LemeY3a3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D741FC113CC;
	Wed, 29 May 2024 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717003791;
	bh=A9UhXtEcisGdQ7S+GoLiZz5Cc4x1PGg5yQCUDuWY1OI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=LemeY3a3dkcONAXHujpB1cyh0OwVvJyxJG9LXALeTeRnFCy+709y/PlntMQwguoMC
	 l1hQRt9eYvIyazkYGA4q2osF5cn4EtBz/X4oq1EuRRfvVymdT9we7xQWYFwx3Xb6K3
	 zfQ79/6Slv6ErsMDVL8FfAVfi7k62isDe1pv25XIurFcsVIn1RIf1tKgflpU+kg6/M
	 q6KhdD1mJO+lU1z17M+rL2mHQlbBKlSY8iH0QbDIw+GCRsISDEtsWu/D+uTd/47va/
	 4ciSEAJQxRXl/bY1hlG7uts2Q2ZtEytrcJ/pyJKlMSZ2tUPY2T7d6BOLx2RNkKACAQ
	 QOcbOOs7N1rPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18CDC25B7C;
	Wed, 29 May 2024 17:29:51 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 29 May 2024 18:29:32 +0100
Subject: [PATCH net] net/tcp: Don't consider TCP_CLOSE in
 TCP_AO_ESTABLISHED
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-tcp_ao-sk_state-v1-1-d69b5d323c52@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPtlV2YC/x2M0QrCMAwAf2Xk2UBbugf9FZGR1uiC2I0kDGHs3
 60+3sHdDsYqbHAZdlDexGRpHeJpgDpTezLKvTOkkHIY0xm9rhMtaK/JnJwxc0mxhDyGEKFXq/J
 DPv/jFRo73LosZIxFqdX5N3uTOSscxxdTVVH3fwAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717003790; l=4011;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=41vTCdrciFlE2ucowln/i/qvIHlsHBhkFQcAUL+bxDc=;
 b=wiHAeqOo3CwmYpFYkuuD0qstxMwV/2lWmg1Q7gCER+fRAP/qC5KJHm1nMJzg+0gZmDrBtBZxUciS
 pf81NF2oDAMFJ+nbMLEU7mnDq2zw9Cvvrw1C7Yu2d6+KVgpdQRJp
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

TCP_CLOSE may or may not have current/rnext keys and should not be
considered "established". The fast-path for TCP_CLOSE is
SKB_DROP_REASON_TCP_CLOSE. This is what tcp_rcv_state_process() does
anyways. Add an early drop path to not spend any time verifying
segment signatures for sockets in TCP_CLOSE state.

Cc: stable@vger.kernel.org # v6.7
Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 include/net/tcp_ao.h |  7 ++++---
 net/ipv4/tcp_ao.c    | 13 +++++++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 471e177362b4..5d8e9ed2c005 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -86,7 +86,8 @@ static inline int tcp_ao_sizeof_key(const struct tcp_ao_key *key)
 struct tcp_ao_info {
 	/* List of tcp_ao_key's */
 	struct hlist_head	head;
-	/* current_key and rnext_key aren't maintained on listen sockets.
+	/* current_key and rnext_key are maintained on sockets
+	 * in TCP_AO_ESTABLISHED states.
 	 * Their purpose is to cache keys on established connections,
 	 * saving needless lookups. Never dereference any of them from
 	 * listen sockets.
@@ -201,9 +202,9 @@ struct tcp6_ao_context {
 };
 
 struct tcp_sigpool;
+/* Established states are fast-path and there always is current_key/rnext_key */
 #define TCP_AO_ESTABLISHED (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | \
-			    TCPF_CLOSE | TCPF_CLOSE_WAIT | \
-			    TCPF_LAST_ACK | TCPF_CLOSING)
+			    TCPF_CLOSE_WAIT | TCPF_LAST_ACK | TCPF_CLOSING)
 
 int tcp_ao_transmit_skb(struct sock *sk, struct sk_buff *skb,
 			struct tcp_ao_key *key, struct tcphdr *th,
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 781b67a52571..37c42b63ff99 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -933,6 +933,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	struct tcp_ao_key *key;
 	__be32 sisn, disn;
 	u8 *traffic_key;
+	int state;
 	u32 sne = 0;
 
 	info = rcu_dereference(tcp_sk(sk)->ao_info);
@@ -948,8 +949,9 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		disn = 0;
 	}
 
+	state = READ_ONCE(sk->sk_state);
 	/* Fast-path */
-	if (likely((1 << sk->sk_state) & TCP_AO_ESTABLISHED)) {
+	if (likely((1 << state) & TCP_AO_ESTABLISHED)) {
 		enum skb_drop_reason err;
 		struct tcp_ao_key *current_key;
 
@@ -988,6 +990,9 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 		return SKB_NOT_DROPPED_YET;
 	}
 
+	if (unlikely(state == TCP_CLOSE))
+		return SKB_DROP_REASON_TCP_CLOSE;
+
 	/* Lookup key based on peer address and keyid.
 	 * current_key and rnext_key must not be used on tcp listen
 	 * sockets as otherwise:
@@ -1001,7 +1006,7 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 	if (th->syn && !th->ack)
 		goto verify_hash;
 
-	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV)) {
+	if ((1 << state) & (TCPF_LISTEN | TCPF_NEW_SYN_RECV)) {
 		/* Make the initial syn the likely case here */
 		if (unlikely(req)) {
 			sne = tcp_ao_compute_sne(0, tcp_rsk(req)->rcv_isn,
@@ -1018,14 +1023,14 @@ tcp_inbound_ao_hash(struct sock *sk, const struct sk_buff *skb,
 			/* no way to figure out initial sisn/disn - drop */
 			return SKB_DROP_REASON_TCP_FLAGS;
 		}
-	} else if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
+	} else if ((1 << state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
 		disn = info->lisn;
 		if (th->syn || th->rst)
 			sisn = th->seq;
 		else
 			sisn = info->risn;
 	} else {
-		WARN_ONCE(1, "TCP-AO: Unexpected sk_state %d", sk->sk_state);
+		WARN_ONCE(1, "TCP-AO: Unexpected sk_state %d", state);
 		return SKB_DROP_REASON_TCP_AOFAILURE;
 	}
 verify_hash:

---
base-commit: e0cce98fe279b64f4a7d81b7f5c3a23d80b92fbc
change-id: 20240529-tcp_ao-sk_state-4eb21b045001

Best regards,
-- 
Dmitry Safonov <0x7f454c46@gmail.com>



