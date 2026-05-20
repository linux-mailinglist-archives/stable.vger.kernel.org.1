Return-Path: <stable+bounces-252624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFTqLnv8DWoK5QUAu9opvQ
	(envelope-from <stable+bounces-252624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:24:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B96596110
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BED73097DC9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C0D3E5ECF;
	Wed, 20 May 2026 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rOGTPLNF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDAA29B78D;
	Wed, 20 May 2026 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301163; cv=none; b=bBjJT961vwg8Hfgxqvnrw0VRx+Hm1S5tx4xC0QwDndjkTnUhYdfFaMXdJHQqR8482rBZRW+PQBaVtB1/Ns097SG0c30X2Fbw7F9eo2DR29v+JancVqpRFrczUhIBXG01l65XncUyrgI9Niqq/6TiZ1AKCQp9Y1+zEFUIL/s4DpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301163; c=relaxed/simple;
	bh=zYttbOuQfXIWpTy9wq5hOgOGGiR/7FtYFIcokoWgEas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lI6iBM3o/KxDnsJJ2iV4h99V3uXYthgn188IUy7JlOD6f0nlnSt217+nkf0QOcmVJPMoCSeAhGYOUxqv9tflhE6NlGhQi4RseXFGUkQ8qNdqgTbUZbVxKNlFGt38z6qYUpU9OXs4UeG3QEF+7gRBZDeErZPhTfYnBzU+7zAUnMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rOGTPLNF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A8B1F00893;
	Wed, 20 May 2026 18:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301162;
	bh=0NjfbQ3xB41MMEh7pcxHXDGo9b73043hs+6xcUGNkhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rOGTPLNFTBKJaR+35y3GxDfVmrrAciDWOyzPuKOWzobP2DcM8LIJ1ltlMKb0r5S8N
	 s2P9DxV/cvh2sIlb1hzcY213Gzd26xYWu2ZMcgR6sBwQxEBP2318yuz74/660BXK+8
	 rAoKDxbaiBPrSymaJznMZ0RF2wwTlzJbUDr6cgl0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 450/666] tcp: add data-race annotations for TCP_NLA_SNDQ_SIZE
Date: Wed, 20 May 2026 18:21:01 +0200
Message-ID: <20260520162121.024355748@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252624-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 75B96596110
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 124199444de467767175a9004e1574dc42523e62 ]

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: 87ecc95d81d9 ("tcp: add send queue size stat in SCM_TIMESTAMPING_OPT_STATS")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260416200319.3608680-7-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c        | 4 +++-
 net/ipv4/tcp_input.c  | 4 ++--
 net/ipv4/tcp_output.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 382c2895ec311..16ee72717e039 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4297,7 +4297,9 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	nla_put_u32(stats, TCP_NLA_DELIVERED, tp->delivered);
 	nla_put_u32(stats, TCP_NLA_DELIVERED_CE, tp->delivered_ce);
 
-	nla_put_u32(stats, TCP_NLA_SNDQ_SIZE, tp->write_seq - tp->snd_una);
+	nla_put_u32(stats, TCP_NLA_SNDQ_SIZE,
+		    max_t(int, 0,
+			  READ_ONCE(tp->write_seq) - READ_ONCE(tp->snd_una)));
 	nla_put_u8(stats, TCP_NLA_CA_STATE, inet_csk(sk)->icsk_ca_state);
 
 	nla_put_u64_64bit(stats, TCP_NLA_BYTES_SENT, tp->bytes_sent,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index c498588c021d7..39463842231c0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3670,7 +3670,7 @@ static void tcp_snd_una_update(struct tcp_sock *tp, u32 ack)
 	sock_owned_by_me((struct sock *)tp);
 	tp->bytes_acked += delta;
 	tcp_snd_sne_update(tp, ack);
-	tp->snd_una = ack;
+	WRITE_ONCE(tp->snd_una, ack);
 }
 
 static void tcp_rcv_sne_update(struct tcp_sock *tp, u32 seq)
@@ -6877,7 +6877,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		if (sk->sk_socket)
 			sk_wake_async(sk, SOCK_WAKE_IO, POLL_OUT);
 
-		tp->snd_una = TCP_SKB_CB(skb)->ack_seq;
+		WRITE_ONCE(tp->snd_una, TCP_SKB_CB(skb)->ack_seq);
 		tp->snd_wnd = ntohs(th->window) << tp->rx_opt.snd_wscale;
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index dbe39ad886821..59a0ef96b4d85 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3945,7 +3945,7 @@ static void tcp_connect_init(struct sock *sk)
 	tp->snd_wnd = 0;
 	tcp_init_wl(tp, 0);
 	tcp_write_queue_purge(sk);
-	tp->snd_una = tp->write_seq;
+	WRITE_ONCE(tp->snd_una, tp->write_seq);
 	tp->snd_sml = tp->write_seq;
 	tp->snd_up = tp->write_seq;
 	WRITE_ONCE(tp->snd_nxt, tp->write_seq);
-- 
2.53.0




