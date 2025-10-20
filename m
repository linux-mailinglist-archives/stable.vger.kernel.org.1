Return-Path: <stable+bounces-188148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD6BF22C7
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF5C1898A7C
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D0726D4E5;
	Mon, 20 Oct 2025 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVBHJlxF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D8B1DFD8B
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975055; cv=none; b=l7SWGGG+teBE98QWhmfkPSqC2csY+rn5YfITnLJDQvB0ARjzL0XFCXXLLPLMXeqF873sLmX62pN5FcYvs1Fh8j8/0+/eWA4+ekqN+y4ja9jopFt2WGCvlzNTuxs6ii5L86Il5UmC1gOv88BnBwElqpGyS8R0tsPzVZDJQ4o5M4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975055; c=relaxed/simple;
	bh=xtWxsZh22PlcE/WlJx1Vqupr3RA2g+V7cFGMgPFocUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjis9QJ4ga224yy2ldBTz0jdiOr0xgQjWwjEFYvti6BgXU6RwcaKJkaWjLmX0ALAJ7NbS4fzzuGpYl7ZxMxTkBhXS2W5wclYPf9tj/Th0WiONgEuTfM5GpPfvz1q/UUrs62xaaZW9DvCcWYE6Q9ISbFEEACNqx1TpjKaYP6g2U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVBHJlxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D12DC113D0;
	Mon, 20 Oct 2025 15:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760975055;
	bh=xtWxsZh22PlcE/WlJx1Vqupr3RA2g+V7cFGMgPFocUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVBHJlxFDo9xQv+jlZjXS07fagcOUOKbcLayj+T/ARA16iAJLJacUFt3jMZOMtxaD
	 dJBXnj6AaAtsE935m0euSakFH/zn4a5cyUZSrjKcxn1Ln3Hl9QKeaOcTLjwJyxkXce
	 4ESyFzdpP+sZnsxAb2P+w9BvTFHLoSp3zpqFlckWwAz1b/QruwTcBD7W47co+6pM9E
	 5ZXGf8wUFHug7yqWpI++4hUoHDSebGtK63ztSJLiN5BPL4AMz71M+GEyQX5Iyq0YBK
	 +bcl1sHRLoAAEv3B9yijyXcc/fU99jqw4hmqVPDgeVI6iasJFOxvx4vrbK6pxn/VA9
	 e+1ZShCW5jOSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/8] tcp: cache RTAX_QUICKACK metric in a hot cache line
Date: Mon, 20 Oct 2025 11:44:03 -0400
Message-ID: <20251020154409.1823664-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020154409.1823664-1-sashal@kernel.org>
References: <2025101604-chamber-playhouse-5278@gregkh>
 <20251020154409.1823664-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 15492700ac41459b54a6683490adcee350ab11e3 ]

tcp_in_quickack_mode() is called from input path for small packets.

It calls __sk_dst_get() which reads sk->sk_dst_cache which has been
put in sock_read_tx group (for good reasons).

Then dst_metric(dst, RTAX_QUICKACK) also needs extra cache line misses.

Cache RTAX_QUICKACK in icsk->icsk_ack.dst_quick_ack to no longer pull
these cache lines for the cases a delayed ACK is scheduled.

After this patch TCP receive path does not longer access sock_read_tx
group.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Reviewed-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://patch.msgid.link/20250312083907.1931644-1-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 833d4313bc1e ("mptcp: reset blackhole on success with non-loopback ifaces")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_connection_sock.h | 3 ++-
 net/core/sock.c                    | 6 +++++-
 net/ipv4/tcp_input.c               | 3 +--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 4bd93571e6c1b..bcc138ff087bd 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -116,7 +116,8 @@ struct inet_connection_sock {
 		#define ATO_BITS 8
 		__u32		  ato:ATO_BITS,	 /* Predicted tick of soft clock	   */
 				  lrcv_flowlabel:20, /* last received ipv6 flowlabel	   */
-				  unused:4;
+				  dst_quick_ack:1, /* cache dst RTAX_QUICKACK		   */
+				  unused:3;
 		unsigned long	  timeout;	 /* Currently scheduled timeout		   */
 		__u32		  lrcvtime;	 /* timestamp of last received data packet */
 		__u16		  last_seg_size; /* Size of last incoming segment	   */
diff --git a/net/core/sock.c b/net/core/sock.c
index d392cb37a864f..b5723adab4ebf 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2547,8 +2547,12 @@ void sk_setup_caps(struct sock *sk, struct dst_entry *dst)
 	u32 max_segs = 1;
 
 	sk->sk_route_caps = dst->dev->features;
-	if (sk_is_tcp(sk))
+	if (sk_is_tcp(sk)) {
+		struct inet_connection_sock *icsk = inet_csk(sk);
+
 		sk->sk_route_caps |= NETIF_F_GSO;
+		icsk->icsk_ack.dst_quick_ack = dst_metric(dst, RTAX_QUICKACK);
+	}
 	if (sk->sk_route_caps & NETIF_F_GSO)
 		sk->sk_route_caps |= NETIF_F_GSO_SOFTWARE;
 	if (unlikely(sk->sk_gso_disabled))
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4c8d84fc27ca3..1d9e93a04930b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -331,9 +331,8 @@ static void tcp_enter_quickack_mode(struct sock *sk, unsigned int max_quickacks)
 static bool tcp_in_quickack_mode(struct sock *sk)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
-	const struct dst_entry *dst = __sk_dst_get(sk);
 
-	return (dst && dst_metric(dst, RTAX_QUICKACK)) ||
+	return icsk->icsk_ack.dst_quick_ack ||
 		(icsk->icsk_ack.quick && !inet_csk_in_pingpong_mode(sk));
 }
 
-- 
2.51.0


