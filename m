Return-Path: <stable+bounces-251840-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBMRBFr8DWoK5QUAu9opvQ
	(envelope-from <stable+bounces-251840-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:24:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C01B59608C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B800A3648F7F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937443EE1FA;
	Wed, 20 May 2026 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U7/RvW6x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACAB1C3BFC;
	Wed, 20 May 2026 17:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299026; cv=none; b=Z467camg5aTa93rmFXBJ9p1Nxa07P5PLqbHatgeT1j5H6/je6SnetH9XB5/A2FQeCps3r8HSioW0Nk4Fii3zJnOPq0hBeg5ydoC8I2l3RDTsWS/9Ls3ILSPLf8rL8Fasj67SvKyHKtlx4X65Xmb0C2JSFSxSG35SFFlG3PkYgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299026; c=relaxed/simple;
	bh=yRmdL0eMjygzeTSTiR3FcgDmBj3N8LzxQ8I8jY4UkSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgnca0DPmsExg1oKjusYl1yrBLz3qrnOr3XtpomnJUU/0RIJe+g9IN581UIZSd9p6eafCfwWQmhvkQGGlIWfa4qG3mBf3Kg7wbQ4VPeiP5aAf2WSlQoWFFWMuojs9K0oAP55SQ8H9VEmdnliq2ynVtuD4rXNvMQyY1YiYpYXBk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U7/RvW6x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04731F000E9;
	Wed, 20 May 2026 17:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299025;
	bh=owp6v7ehO3kLcjrYwyItFTCq/iEDeRptq9pyh4FQj4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U7/RvW6xePVJJfQtbNVtvYh5xLMdbnk2Qbr/1fa2p37W7qn9FqPS0tXVagonoDybj
	 pr1uuP5XYZySUyPVkJ4uKvyv0S47Teg0ng88uHuxSY8zLIJbUnAaadRE7fb0myg5id
	 sNncp+/IbfcqdY9BuJfNTPzINAm+2BJoABnw0X+k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 635/957] tcp: annotate data-races around tp->delivered and tp->delivered_ce
Date: Wed, 20 May 2026 18:18:38 +0200
Message-ID: <20260520162148.300061702@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251840-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 8C01B59608C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit faa886ad3ce5fc8f5156493491fe189b2b726bc9 ]

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: feb5f2ec6464 ("tcp: export packets delivery info")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260416200319.3608680-6-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp_ecn.h | 2 +-
 net/ipv4/tcp.c        | 4 ++--
 net/ipv4/tcp_input.c  | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index a709fb1756eb7..59d6944f8d103 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -189,7 +189,7 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 		    tcp_accecn_validate_syn_feedback(sk, ace, sent_ect)) {
 			if ((tcp_accecn_extract_syn_ect(ace) == INET_ECN_CE) &&
 			    !tp->delivered_ce)
-				tp->delivered_ce++;
+				WRITE_ONCE(tp->delivered_ce, 1);
 		}
 		break;
 	}
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3de09b59663d8..515313ef0c642 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4405,8 +4405,8 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 		   READ_ONCE(inet_csk(sk)->icsk_retransmits));
 	nla_put_u8(stats, TCP_NLA_DELIVERY_RATE_APP_LMT, data_race(!!tp->rate_app_limited));
 	nla_put_u32(stats, TCP_NLA_SND_SSTHRESH, READ_ONCE(tp->snd_ssthresh));
-	nla_put_u32(stats, TCP_NLA_DELIVERED, tp->delivered);
-	nla_put_u32(stats, TCP_NLA_DELIVERED_CE, tp->delivered_ce);
+	nla_put_u32(stats, TCP_NLA_DELIVERED, READ_ONCE(tp->delivered));
+	nla_put_u32(stats, TCP_NLA_DELIVERED_CE, READ_ONCE(tp->delivered_ce));
 
 	nla_put_u32(stats, TCP_NLA_SNDQ_SIZE, tp->write_seq - tp->snd_una);
 	nla_put_u8(stats, TCP_NLA_CA_STATE, inet_csk(sk)->icsk_ca_state);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 16bb525c04f1d..b5a3c7ca2605d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -476,14 +476,14 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
 
 static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
 {
-	tp->delivered_ce += ecn_count;
+	WRITE_ONCE(tp->delivered_ce, tp->delivered_ce + ecn_count);
 }
 
 /* Updates the delivered and delivered_ce counts */
 static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 				bool ece_ack)
 {
-	tp->delivered += delivered;
+	WRITE_ONCE(tp->delivered, tp->delivered + delivered);
 	if (tcp_ecn_mode_rfc3168(tp) && ece_ack)
 		tcp_count_delivered_ce(tp, delivered);
 }
@@ -6576,7 +6576,7 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPFASTOPENACTIVE);
 		/* SYN-data is counted as two separate packets in tcp_ack() */
 		if (tp->delivered > 1)
-			--tp->delivered;
+			WRITE_ONCE(tp->delivered, tp->delivered - 1);
 	}
 
 	tcp_fastopen_add_skb(sk, synack);
@@ -7007,7 +7007,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 	SKB_DR_SET(reason, NOT_SPECIFIED);
 	switch (sk->sk_state) {
 	case TCP_SYN_RECV:
-		tp->delivered++; /* SYN-ACK delivery isn't tracked in tcp_ack */
+		WRITE_ONCE(tp->delivered, tp->delivered + 1); /* SYN-ACK delivery isn't tracked in tcp_ack */
 		if (!tp->srtt_us)
 			tcp_synack_rtt_meas(sk, req);
 
-- 
2.53.0




