Return-Path: <stable+bounces-261037-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wOIgDm9EJWrMFQIAu9opvQ
	(envelope-from <stable+bounces-261037-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:14:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C7364F6EB
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:14:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ZAKMQC2A;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261037-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261037-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2894303DD5A
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EB02E1EFC;
	Sun,  7 Jun 2026 10:10:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F691227B94;
	Sun,  7 Jun 2026 10:10:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827052; cv=none; b=ONgKFB2keD+tRn/w2GECFVP7y7T3kPINV26PW1pmMUBy6AIgw5rJILZnI+DGuueFI9xqzWXvShv55tJUKMTdDMRWPaDDPm2hqImmKWVri5Ef7ZKlGmfcHFXmGqmPsamoD4WGOJZlLCUt7kDqQOGU506KVml+QRfCqXgJy7OHuPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827052; c=relaxed/simple;
	bh=IX7l+0ZhW9CkJM7WWqyg4p9pU2U+G+rb7FjG79b2iAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv7g6eNJzMQhNzKRGAq8s4Uk8kPzjSjfOZ40JDmqUh54LxGWbhIQn39xzRL7cVvSF/Xa+beYa941Rqypvmlu8NBqbY2ekcsw3zF2h2FX8NBc/KlNtyd5tF5yNvWkjwjHTZxG7Vyas3HDeKqGc9gL5vAy59iihaUEGHd8vTYn2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZAKMQC2A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE011F00893;
	Sun,  7 Jun 2026 10:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827051;
	bh=rwIk2sAJWSc0Sfyhhsow+Jwq07MJISvE164AFmqxZhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZAKMQC2AFr871daAPQx7zVaJC8xZKXm99BQiIlior+IglUNZmFWgnzhQQBztpzjwT
	 gwWkB2EeBMbHYT0lRcyLa3AskltiaO+wVcfBC0PxhMQImuEQxzuXU+rfRxmwg27KhH
	 KWkyxYilGzZLOoeS+qmBTEz/c1u/NBwAxZflrvTQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Stefano Brivio <sbrivio@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 058/332] tunnels: load network headers after skb_cow() in iptunnel_pmtud_build_icmp[v6]()
Date: Sun,  7 Jun 2026 11:57:07 +0200
Message-ID: <20260607095730.260723539@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261037-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:edumazet@google.com,m:sbrivio@redhat.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86C7364F6EB

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit b4bc94353050b1fa7b702bd4c6600710dd926cff ]

Sashiko found that iptunnel_pmtud_build_icmp() and
iptunnel_pmtud_build_icmpv6() were caching ip_hdr() and ipv6_hdr()
before an skb_cow() call which can reallocate skb->head.

Fix this possible UAF by initializing the local variables
after the skb_cow() call.

Remove skb_reset_network_header() calls which were not needed.

Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Link: https://patch.msgid.link/20260525201335.2361845-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_tunnel_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index f430d6f0463e7a..a52ba6f671fedf 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -212,7 +212,7 @@ EXPORT_SYMBOL_GPL(iptunnel_handle_offloads);
  */
 static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const struct iphdr *iph;
 	struct icmphdr *icmph;
 	struct iphdr *niph;
 	struct ethhdr eh;
@@ -226,7 +226,6 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
-	skb_reset_network_header(skb);
 
 	err = pskb_trim(skb, 576 - sizeof(*niph) - sizeof(*icmph));
 	if (err)
@@ -236,7 +235,7 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 	err = skb_cow(skb, sizeof(*niph) + sizeof(*icmph) + ETH_HLEN);
 	if (err)
 		return err;
-
+	iph = ip_hdr(skb);
 	icmph = skb_push(skb, sizeof(*icmph));
 	*icmph = (struct icmphdr) {
 		.type			= ICMP_DEST_UNREACH,
@@ -308,7 +307,7 @@ static int iptunnel_pmtud_check_icmp(struct sk_buff *skb, int mtu)
  */
 static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 {
-	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
+	const struct ipv6hdr *ip6h;
 	struct icmp6hdr *icmp6h;
 	struct ipv6hdr *nip6h;
 	struct ethhdr eh;
@@ -323,7 +322,6 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
-	skb_reset_network_header(skb);
 
 	err = pskb_trim(skb, IPV6_MIN_MTU - sizeof(*nip6h) - sizeof(*icmp6h));
 	if (err)
@@ -334,6 +332,7 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 	if (err)
 		return err;
 
+	ip6h = ipv6_hdr(skb);
 	icmp6h = skb_push(skb, sizeof(*icmp6h));
 	*icmp6h = (struct icmp6hdr) {
 		.icmp6_type		= ICMPV6_PKT_TOOBIG,
-- 
2.53.0




