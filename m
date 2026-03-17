Return-Path: <stable+bounces-226241-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIKSGS6GuWlyIgIAu9opvQ
	(envelope-from <stable+bounces-226241-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:49:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 974CA2AE7E8
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B21EE3038B8D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F24B3EE1C1;
	Tue, 17 Mar 2026 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LqqcwfrT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631E53EBF2F;
	Tue, 17 Mar 2026 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765863; cv=none; b=D74AzrBDtU5O11Jw0Ax/qZzBjLhzEUoaohZEaZP+ciIHpADF3UKtsJxrmWTxsqBK3X1RXbQtC8fpDQEqWYsupOlFPrkv32U6wNoAvZabA2KCZXk98MIKCFedFNrqgZj5aSkqAbexhM1TekH9wDtzNNmtP1rmZ/YEB8jVw5ilhU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765863; c=relaxed/simple;
	bh=nU1YHOjT3o9PmnwP3uHIideTJDzu795OHyE7ZOMS0XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qz0f/5lFMwmGAKXSaSRuK4H8kJGiFGQueU0WmYb0xofiNDotIIOXuQGc+aNOZ/PjYSPVSsMvM3Gegm+zx9pKO/bxghANFzIUJMyyA+E61ZntIgVo0qzZ68K6zS3ii7J6w6J4/nzTNN+6VBfsR1/qRtnGXCF3K+GhBa8GWJJDeuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LqqcwfrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A8CC4CEF7;
	Tue, 17 Mar 2026 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773765862;
	bh=nU1YHOjT3o9PmnwP3uHIideTJDzu795OHyE7ZOMS0XY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LqqcwfrT8M22WzU+zw4u6TJS5LozBetbn3mOL8O1yF68ke62ZYTwk4GPxvmnRRUja
	 K1LqTIs0JLkVuWdmsX3mbuMPIFkHeU3oqrXGo6di/Lkshxhu25e8L+hV6F3UO9Faia
	 6qOtuEjsJaTxsex5iAspDKkfZVnjBL/FcrK5puxw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Weiming Shi <bestswngs@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 111/378] net: prevent NULL deref in ip[6]tunnel_xmit()
Date: Tue, 17 Mar 2026 17:31:08 +0100
Message-ID: <20260317163011.099054139@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,gmail.com,redhat.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-226241-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 974CA2AE7E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit c38b8f5f791ecce13ab77e2257f8fd2444ba80f6 ]

Blamed commit missed that both functions can be called with dev == NULL.

Also add unlikely() hints for these conditions that only fuzzers can hit.

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Signed-off-by: Eric Dumazet <edumazet@google.com>
CC: Weiming Shi <bestswngs@gmail.com>
Link: https://patch.msgid.link/20260312043908.2790803-1-edumazet@google.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip6_tunnel.h  | 10 ++++++----
 net/ipv4/ip_tunnel_core.c | 10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index 1253cbb4b0a45..359b595f1df93 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -156,10 +156,12 @@ static inline void ip6tunnel_xmit(struct sock *sk, struct sk_buff *skb,
 {
 	int pkt_len, err;
 
-	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
-		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
-				     dev->name);
-		DEV_STATS_INC(dev, tx_errors);
+	if (unlikely(dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT)) {
+		if (dev) {
+			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
+					     dev->name);
+			DEV_STATS_INC(dev, tx_errors);
+		}
 		kfree_skb(skb);
 		return;
 	}
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index b1b6bf949f65a..5683c328990f4 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -58,10 +58,12 @@ void iptunnel_xmit(struct sock *sk, struct rtable *rt, struct sk_buff *skb,
 	struct iphdr *iph;
 	int err;
 
-	if (dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT) {
-		net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
-				     dev->name);
-		DEV_STATS_INC(dev, tx_errors);
+	if (unlikely(dev_recursion_level() > IP_TUNNEL_RECURSION_LIMIT)) {
+		if (dev) {
+			net_crit_ratelimited("Dead loop on virtual device %s, fix it urgently!\n",
+					     dev->name);
+			DEV_STATS_INC(dev, tx_errors);
+		}
 		ip_rt_put(rt);
 		kfree_skb(skb);
 		return;
-- 
2.51.0




