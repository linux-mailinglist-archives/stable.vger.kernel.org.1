Return-Path: <stable+bounces-252626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPRzCAQWDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-252626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:13:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDA35994F2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FFF131B142D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94B23F8706;
	Wed, 20 May 2026 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VbYzsTJu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF99348C55;
	Wed, 20 May 2026 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301168; cv=none; b=ZsHbN/IjNEWi/OlxaHlaC9X07DTErvIYFJJTHYj80BGfHlT50aZ7Js3eVRn9+oGGiCC5AuXSIueToK9Jb/UaYRZBYkb0q2XIHFscaLQ6TCUzmgre80XBN9kh052zgJc81wXHbxWDeDFv+8EZv/iBmppcCgR+TYsYKvho4xUdQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301168; c=relaxed/simple;
	bh=C7FoEOG+EkFGSvQENtXAAgD5W2iUz/KGHeFRu0gIV8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JteZh7U8H/CVylFOBmxB2GC0ITY0IXuT4gvJ9f2VamYywhfb0bg9gaEsHgoauphDGR6d4Tb4pfIarp8mtlXdLONDwCRuUlkp4rGcRF94nzSBgigVfwH10rjKhfP6ducTObqran1Wwh9f7lVOT1ZDQMph/N1HPbDCGkDCUILqY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VbYzsTJu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D071F000E9;
	Wed, 20 May 2026 18:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301167;
	bh=PV93MHFjftA0TIx+MPoKVAS433ZKiLNpG/kKFXZSKfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VbYzsTJu7+IYCgmk16iYmmw6gDGN5tFUE0q/jbc8wOXe9tl6X1ATu04bYI52kY9jM
	 4Dmf2a+CgrEqbXMAD/SH5Zi2qsYfP4LfY2CfBMRKWQQPXxSDdt+rPWK4vZazHmE4MZ
	 CPMzHP+DaN2JzqCunpI9HTEv2oVZ9Q8Io581gnX0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 452/666] tcp: annotate data-races around tp->bytes_retrans
Date: Wed, 20 May 2026 18:21:03 +0200
Message-ID: <20260520162121.067723771@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252626-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 4EDA35994F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 5efc7b9f7cbd43401f1af81d3d7f2be00f93390d ]

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: fb31c9b9f6c8 ("tcp: add data bytes retransmitted stats")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260416200319.3608680-9-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c        | 4 ++--
 net/ipv4/tcp_output.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 08678dd21950e..291db82518b03 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4304,8 +4304,8 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 
 	nla_put_u64_64bit(stats, TCP_NLA_BYTES_SENT, READ_ONCE(tp->bytes_sent),
 			  TCP_NLA_PAD);
-	nla_put_u64_64bit(stats, TCP_NLA_BYTES_RETRANS, tp->bytes_retrans,
-			  TCP_NLA_PAD);
+	nla_put_u64_64bit(stats, TCP_NLA_BYTES_RETRANS,
+			  READ_ONCE(tp->bytes_retrans), TCP_NLA_PAD);
 	nla_put_u32(stats, TCP_NLA_DSACK_DUPS, tp->dsack_dups);
 	nla_put_u32(stats, TCP_NLA_REORD_SEEN, tp->reord_seen);
 	nla_put_u32(stats, TCP_NLA_SRTT, tp->srtt_us >> 3);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5d1aa41592720..33c2fb60d0562 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3414,7 +3414,7 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPSYNRETRANS);
 	WRITE_ONCE(tp->total_retrans, tp->total_retrans + segs);
-	tp->bytes_retrans += skb->len;
+	WRITE_ONCE(tp->bytes_retrans, tp->bytes_retrans + skb->len);
 
 	/* make sure skb->data is aligned on arches that require it
 	 * and check if ack-trimming & collapsing extended the headroom
-- 
2.53.0




