Return-Path: <stable+bounces-250829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP0DI//4DWqq5AUAu9opvQ
	(envelope-from <stable+bounces-250829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:10:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC931595715
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEA73337E00D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A059C3EEAD6;
	Wed, 20 May 2026 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2CB+0L0L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5183336A01E;
	Wed, 20 May 2026 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296415; cv=none; b=nq7z+LRlA4x+H7crFTuOLmAnEsPRkxco05DXUqLLM9OA6xrcC8ODnPkzVZqtyUgtVRMbXYiqF6HqMVcWGYd8z82HSlD9xFYv8sUxjADp8KP+WGtPr+l8/OHLt+qewxsIIYfWC2/detO0Ub9ptEwEUwGIMIQ7OHKvK5lgJjU4cl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296415; c=relaxed/simple;
	bh=OE2euJiFZ9nFs6RRrXY5tPEGhPfp+xdLW8nqBYDf7TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgtRb1Gg1c5dzrN/qVBeaG1GR0crff+Mo+Wp5yQ1N3iO2ZOXQacee60h0AtTsCcdejJvvrp7bYXlv+9QdPh0LM+nr4ZQ5ppG/BBiCbhssrLbbp/R6l3D6UMC99iTPdaGi1fecLIFU/m+q/ivZ7UEk69j2KmgTDCLJ2ozpwW1jFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2CB+0L0L; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8761D1F000E9;
	Wed, 20 May 2026 17:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296414;
	bh=RbJkXJ4kYWEP9MQyspy7K11N+iJ5vkuBOVRsKQuGkcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2CB+0L0LgpIDOw7sgTS15vy9te06ZYFLz4zsXEwYl11SVhTvci91IYdyWnQTJru59
	 qGT8BBbFIsvFrMDFK8nU94jXFQc/TO+LkNfuznB/9VZhCuwjm6t6NWKLmDa5yocYUH
	 GaHzM8SYTOFsiwPxR/IfNLrUpI8JOzixk1QLVtL0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0791/1146] tcp: annotate data-races around tp->timeout_rehash
Date: Wed, 20 May 2026 18:17:21 +0200
Message-ID: <20260520162206.125557268@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-250829-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: EC931595715
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 71c675358b711bbfd8528949249419dc2dfa4ce1 ]

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: 32efcc06d2a1 ("tcp: export count for rehash attempts")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260416200319.3608680-13-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c       | 3 ++-
 net/ipv4/tcp_timer.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 566a04088fdc5..60ca350fb5341 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4503,7 +4503,8 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	nla_put_u32(stats, TCP_NLA_DSACK_DUPS, READ_ONCE(tp->dsack_dups));
 	nla_put_u32(stats, TCP_NLA_REORD_SEEN, READ_ONCE(tp->reord_seen));
 	nla_put_u32(stats, TCP_NLA_SRTT, READ_ONCE(tp->srtt_us) >> 3);
-	nla_put_u16(stats, TCP_NLA_TIMEOUT_REHASH, tp->timeout_rehash);
+	nla_put_u16(stats, TCP_NLA_TIMEOUT_REHASH,
+		    READ_ONCE(tp->timeout_rehash));
 	nla_put_u32(stats, TCP_NLA_BYTES_NOTSENT,
 		    max_t(int, 0, tp->write_seq - tp->snd_nxt));
 	nla_put_u64_64bit(stats, TCP_NLA_EDT, orig_skb->skb_mstamp_ns,
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 5a14a53a3c9ef..153c5888580ca 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -297,7 +297,7 @@ static int tcp_write_timeout(struct sock *sk)
 	}
 
 	if (sk_rethink_txhash(sk)) {
-		tp->timeout_rehash++;
+		WRITE_ONCE(tp->timeout_rehash, tp->timeout_rehash + 1);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEOUTREHASH);
 	}
 
-- 
2.53.0




