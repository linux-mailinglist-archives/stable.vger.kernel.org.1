Return-Path: <stable+bounces-252627-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBWREkomDmpZ6gUAu9opvQ
	(envelope-from <stable+bounces-252627-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:23:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A28B259AC7D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACC81360702B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D2D3CCFB0;
	Wed, 20 May 2026 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="twF+K6AZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525CB29B78D;
	Wed, 20 May 2026 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301171; cv=none; b=trFzXqVFUjjfEIyKJ7Zk8wO4K+QzI2aEUnBkQOofOFnxTd2BcrPpMPdb2yF++s0J9Drv8fV/AGBCkR9BWR+pCm6KiIi6g+85Bs4TOv8pqxoEUIIIYkEMvOFBnf5xugekyeWk5ujQ7oqSp7sUTWJ2Rib698y9z1Cq/OsVIuyyM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301171; c=relaxed/simple;
	bh=/blbL7zM5Tse0UKVRW1r3Tg/N1rgToV0doq8gHnIZDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFxUvFefbTcwVXMy43VUodPTtUGHmsDy4QA+2iFgRtOAak+p4HR9tEjXhK7Pcw49ZUaeYiVzWqMcUKi/B4JR2QbEhBFtiFzRW4jTYzriCqERW/GymY0511ArWOTZNNUb3wXvt3xfj4GwscDhLv95NGcGjXmkGjmyq6CwcBdKUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=twF+K6AZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93FF1F000E9;
	Wed, 20 May 2026 18:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301170;
	bh=kseyyzjTh0qML2iAZrZPN31tiCFQhKawuqAHBfokSyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=twF+K6AZyeXnaVveh1rvk9xp48ReFgj6z8eRlCRzN0lkOlTVu56KP5Nm+JhUHUVl5
	 WHcW9j/ek6HjBNu349ap6suMn5kpBZAMKMxl2cvqTvatwkLrwFoOJLNpV6/SLHDu7B
	 AqHdq/Dw1Rjb3G2vjMXhVupXPaA/vp49rcrP8pdY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 453/666] tcp: annotate data-races around tp->dsack_dups
Date: Wed, 20 May 2026 18:21:04 +0200
Message-ID: <20260520162121.089400627@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252627-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: A28B259AC7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a984705ca88b976bf1087978fd98b7f3993da88c ]

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: 7e10b6554ff2 ("tcp: add dsack blocks received stats")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260416200319.3608680-10-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c       | 2 +-
 net/ipv4/tcp_input.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 291db82518b03..cacb298147d4b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4306,7 +4306,7 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 			  TCP_NLA_PAD);
 	nla_put_u64_64bit(stats, TCP_NLA_BYTES_RETRANS,
 			  READ_ONCE(tp->bytes_retrans), TCP_NLA_PAD);
-	nla_put_u32(stats, TCP_NLA_DSACK_DUPS, tp->dsack_dups);
+	nla_put_u32(stats, TCP_NLA_DSACK_DUPS, READ_ONCE(tp->dsack_dups));
 	nla_put_u32(stats, TCP_NLA_REORD_SEEN, tp->reord_seen);
 	nla_put_u32(stats, TCP_NLA_SRTT, tp->srtt_us >> 3);
 	nla_put_u16(stats, TCP_NLA_TIMEOUT_REHASH, tp->timeout_rehash);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 39463842231c0..60c42d612d186 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1059,7 +1059,7 @@ static u32 tcp_dsack_seen(struct tcp_sock *tp, u32 start_seq,
 	else if (tp->tlp_high_seq && tp->tlp_high_seq == end_seq)
 		state->flag |= FLAG_DSACK_TLP;
 
-	tp->dsack_dups += dup_segs;
+	WRITE_ONCE(tp->dsack_dups, tp->dsack_dups + dup_segs);
 	/* Skip the DSACK if dup segs weren't retransmitted by sender */
 	if (tp->dsack_dups > tp->total_retrans)
 		return 0;
-- 
2.53.0




