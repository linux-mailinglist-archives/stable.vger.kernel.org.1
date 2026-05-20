Return-Path: <stable+bounces-251836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIdpMx8fDmro6AUAu9opvQ
	(envelope-from <stable+bounces-251836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:52:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4253E59A3E7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01DDA3772A08
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D813B0AD6;
	Wed, 20 May 2026 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lI4XRBTN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84F36F901;
	Wed, 20 May 2026 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299015; cv=none; b=mzmwIFCAyzKMATfFOBRxnsZ2tbkO0vhnBVxe/rFfiQ2F1yq9VoYzqCp1C1un3pQUIyvitWFRWP4CmllOszkBRok7ejRnbF/7YWLscWiXCOZ0FCCIMwqHSJzXdx6+1i30ZcVB5yNQJoYRlyrDAs9c3+JRmJ+6qVkiSCv1BSo/iB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299015; c=relaxed/simple;
	bh=jmtnQkpPiPnnbcm1LqG+ys2gJKHM1jQOkuR06sUKtQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRGrnVVNbVdd44lsgQyKP/8WsMzmHAmzHQy9Q2/N+gxNvY6YtKIJKlMjfsEFcqpTtOokgU54zrmhysgrLPaImyMTOnoTeGt/sxCkK6JVp2vhywT3292/XZedrb7d2vJ2/lRy1c7aWcP7vczjWBMRwMzS9XISUMzWhEwOasM882M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lI4XRBTN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8031F000E9;
	Wed, 20 May 2026 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299014;
	bh=lbBCAQN4fuka4JfSnL5GxQtOvb6CUNsr49LkUI0INm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lI4XRBTN1d87O06XjuCMVkpMtaTEdJSMisek+RA2P0LyPRsvCiYEjIHVMxmdMbwUO
	 0WebTLTW6R7UYtht3y/WbjVY9Sy5Ga1+MnLTYLvWqdX47ypOcqWUPC4+1N9jQ4l9KX
	 Ma2QCmnqhCGXhowL5TDuQnDZ1+fhce+9Z8NRRKkg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 631/957] tcp: annotate data-races in tcp_get_info_chrono_stats()
Date: Wed, 20 May 2026 18:18:34 +0200
Message-ID: <20260520162148.214246188@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251836-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4253E59A3E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 267bf3cf9a6f0ffb98b8afd983c1950e835f07c9 ]

tcp_get_timestamping_opt_stats() does not own the socket lock,
this is intentional.

It calls tcp_get_info_chrono_stats() while other threads could
change chrono fields in tcp_chrono_set().

I do not think we need coherent TCP socket state snapshot
in tcp_get_timestamping_opt_stats(), I chose to only
add annotations to keep KCSAN happy.

Fixes: 1c885808e456 ("tcp: SOF_TIMESTAMPING_OPT_STATS option for SO_TIMESTAMPING")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260416200319.3608680-2-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/tcp.h | 10 +++++++---
 net/ipv4/tcp.c    | 14 ++++++++++----
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6805961726dc1..236d9e0d35ed7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2129,10 +2129,14 @@ static inline void tcp_chrono_set(struct tcp_sock *tp, const enum tcp_chrono new
 	const u32 now = tcp_jiffies32;
 	enum tcp_chrono old = tp->chrono_type;
 
+	/* Following WRITE_ONCE()s pair with READ_ONCE()s in
+	 * tcp_get_info_chrono_stats().
+	 */
 	if (old > TCP_CHRONO_UNSPEC)
-		tp->chrono_stat[old - 1] += now - tp->chrono_start;
-	tp->chrono_start = now;
-	tp->chrono_type = new;
+		WRITE_ONCE(tp->chrono_stat[old - 1],
+			   tp->chrono_stat[old - 1] + now - tp->chrono_start);
+	WRITE_ONCE(tp->chrono_start, now);
+	WRITE_ONCE(tp->chrono_type, new);
 }
 
 static inline void tcp_chrono_start(struct sock *sk, const enum tcp_chrono type)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 94e029c70247d..a33641b9ed7e4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4151,12 +4151,18 @@ static void tcp_get_info_chrono_stats(const struct tcp_sock *tp,
 				      struct tcp_info *info)
 {
 	u64 stats[__TCP_CHRONO_MAX], total = 0;
-	enum tcp_chrono i;
+	enum tcp_chrono i, cur;
 
+	/* Following READ_ONCE()s pair with WRITE_ONCE()s in tcp_chrono_set().
+	 * This is because socket lock might not be owned by us at this point.
+	 * This is best effort, tcp_get_timestamping_opt_stats() can
+	 * see wrong values. A real fix would be too costly for TCP fast path.
+	 */
+	cur = READ_ONCE(tp->chrono_type);
 	for (i = TCP_CHRONO_BUSY; i < __TCP_CHRONO_MAX; ++i) {
-		stats[i] = tp->chrono_stat[i - 1];
-		if (i == tp->chrono_type)
-			stats[i] += tcp_jiffies32 - tp->chrono_start;
+		stats[i] = READ_ONCE(tp->chrono_stat[i - 1]);
+		if (i == cur)
+			stats[i] += tcp_jiffies32 - READ_ONCE(tp->chrono_start);
 		stats[i] *= USEC_PER_SEC / HZ;
 		total += stats[i];
 	}
-- 
2.53.0




