Return-Path: <stable+bounces-252720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEREBbAoDmqk6gUAu9opvQ
	(envelope-from <stable+bounces-252720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:33:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 640DF59B035
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86F3237004DC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0492A3FC5A9;
	Wed, 20 May 2026 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pFs8A7Py"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19993FC5A6;
	Wed, 20 May 2026 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301413; cv=none; b=Le7Z4RCWXY/5YNOizDimI4uOvP3dxXK9qc6osH+rTY9HBTsGBi625RN1UoO18932sYEukvhYADOpLJYWpU/mhnlaXJbaQttFSC//rzc2sqcG3VEX1Hut0F64gPXNPxyPVIWJgGRCr+m8L9XD0zu/HmSvQo7DXa/A2BGvm7YTgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301413; c=relaxed/simple;
	bh=Bd8jklfnL8wHMWT3Wl694J8bJtgJDqyM25cB8rDla+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjUu+5gfByU3OMolpFQfcL2pkqY3RUCq94JdkqY5QNn0/gu5LhKajlwwc+jIRTldwR8KBCO7QirlnPtJMyWuC/HfgHGHPSu43N5QHErSdfx2YloD21F7HGjPYhsCd4xX8C1ZmWi6meYxfifaUl/Mt5EG5bLAKhJUcrOMUD6+al0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pFs8A7Py; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD46F1F000E9;
	Wed, 20 May 2026 18:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301412;
	bh=ORGRiS1oY7/cKv6IXoWztq/LeXX/RebL6fkNpH2V4f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pFs8A7PyRAcOlSvxhyBHW4HVIgIS5u09CyxgOaeZcC/M4erX5bTD8c+0B8vOSbGYG
	 0iVvQoLb3LU96FlbDqnB7ahgiWGqKcYS1Oq+bXNswQgF6XDNlpGk05q7lbNrcANWBc
	 paTnTX7NUF7tBdb8qn0dSOW6xytRreelMXIU8CCA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Altan Hacigumus <ahacigu.linux@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 545/666] tcp: make probe0 timer handle expired user timeout
Date: Wed, 20 May 2026 18:22:36 +0200
Message-ID: <20260520162123.083914611@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,google.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252720-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 640DF59B035
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Altan Hacigumus <ahacigu.linux@gmail.com>

[ Upstream commit 2b9f6f7065d4cfb65ba19126e0b35ac4544c3f3a ]

tcp_clamp_probe0_to_user_timeout() computes remaining time in jiffies
using subtraction with an unsigned lvalue.  If elapsed probing time
exceeds the configured TCP_USER_TIMEOUT, the underflow yields a large
value.

This ends up re-arming the probe timer for a full backoff interval
instead of expiring immediately, delaying connection teardown beyond
the configured timeout.

Fix this by preventing underflow so user-set timeout expiration is
handled correctly without extending the probe timer.

Fixes: 344db93ae3ee ("tcp: make TCP_USER_TIMEOUT accurate for zero window probes")
Link: https://lore.kernel.org/r/20260414013634.43997-1-ahacigu.linux@gmail.com
Signed-off-by: Altan Hacigumus <ahacigu.linux@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260424014639.54110-1-ahacigu.linux@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_timer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 79064580c8c0d..0cc8f19bc1024 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -49,7 +49,8 @@ static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
 u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
-	u32 remaining, user_timeout;
+	u32 user_timeout;
+	s32 remaining;
 	s32 elapsed;
 
 	user_timeout = READ_ONCE(icsk->icsk_user_timeout);
@@ -60,7 +61,7 @@ u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
 	if (unlikely(elapsed < 0))
 		elapsed = 0;
 	remaining = msecs_to_jiffies(user_timeout) - elapsed;
-	remaining = max_t(u32, remaining, TCP_TIMEOUT_MIN);
+	remaining = max_t(int, remaining, TCP_TIMEOUT_MIN);
 
 	return min_t(u32, remaining, when);
 }
-- 
2.53.0




