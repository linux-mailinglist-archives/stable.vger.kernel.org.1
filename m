Return-Path: <stable+bounces-253263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEJxFYYHDmp25gUAu9opvQ
	(envelope-from <stable+bounces-253263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:12:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 762F8597ED4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA5F8399BCBB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF13427A06;
	Wed, 20 May 2026 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W/S5tql1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733F400DFF;
	Wed, 20 May 2026 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302821; cv=none; b=Ae6u2wFUfJ6dG0CTYwBGsgmec2i+7f8yvHXku9yWNHGpux+TCXr67faRaysZAmwlA0sBGifsYaBVqd7OiFQOhzFNkkHzTX3HbBCh2lg4szm4OHwwNxOuY674Y01SixD8Cd1JuwfNsvt13QaTdTQlI2mFafsMJVq654e9BoZhTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302821; c=relaxed/simple;
	bh=NEHfrzHer/+Asff3G5e05nKhTuVjqGEvfknBxHdyd9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1BmRFzwLzR4BEeDQP2+9Pk1iX9yXb09+xZUIgP7OvGqhXHQ6Wv3nac1Vg6niaTjl54NBPofxjID/iSEc0mUH66cHkOW76lPp3Abkz4C3wVygDhZVOjM1ol7ADbyI8y3oP8OReRGgWSzZKAHv1q5ZUJKkZVSoXDhMuHpH9sZBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W/S5tql1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFF41F000E9;
	Wed, 20 May 2026 18:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302819;
	bh=e50GI9MbFFbp4ZrDIiviwt1J91z9/PlX0llI4qlVEOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W/S5tql1NDtkQgPXo2t4B4K0aEuQbkTehRVnPw70NLQ/NnxOuCtZ6RGm5gLj+G9/c
	 m+EUO7HdbXpkt/jE27c4XyiXMMGlJtMFlbCvcDt0y6D/sXwr6OuROPRo+csVvw4ti8
	 UJ3DqQU267AIKQq72sdAsXJRmLZIfms8g+ZRho3Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guillaume Nault <gnault@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 412/508] ipv4: remove "proto" argument from udp_tunnel_dst_lookup()
Date: Wed, 20 May 2026 18:23:55 +0200
Message-ID: <20260520162107.536402431@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,gmail.com,kernel.org,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253263-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,davemloft.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 762F8597ED4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Beniamino Galvani <b.galvani@gmail.com>

[ Upstream commit 78f3655adcb52412275f282267ee771421731632 ]

The function is now UDP-specific, the protocol is always IPPROTO_UDP.

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: aa6c6d9ee064 ("bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bareudp.c      | 4 ++--
 include/net/udp_tunnel.h   | 2 +-
 net/ipv4/udp_tunnel_core.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index bbc246d27f88a..1a9a43ed462a8 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -326,7 +326,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		return -ESHUTDOWN;
 
 	rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, &saddr, info,
-				   IPPROTO_UDP, use_cache);
+				   use_cache);
 
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
@@ -506,7 +506,7 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		__be32 saddr;
 
 		rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, &saddr,
-					   info, IPPROTO_UDP, use_cache);
+					   info, use_cache);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
 
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 42a03485c5975..fd664b2001053 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -165,7 +165,7 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 				     struct net_device *dev,
 				     struct net *net, __be32 *saddr,
 				     const struct ip_tunnel_info *info,
-				     u8 protocol, bool use_cache);
+				     bool use_cache);
 
 struct metadata_dst *udp_tun_rx_dst(struct sk_buff *skb, unsigned short family,
 				    __be16 flags, __be64 tunnel_id,
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 96f93f92b6ced..9b0cfd72d5fda 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -208,7 +208,7 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 				     struct net_device *dev,
 				     struct net *net, __be32 *saddr,
 				     const struct ip_tunnel_info *info,
-				     u8 protocol, bool use_cache)
+				     bool use_cache)
 {
 #ifdef CONFIG_DST_CACHE
 	struct dst_cache *dst_cache;
@@ -227,7 +227,7 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 #endif
 	memset(&fl4, 0, sizeof(fl4));
 	fl4.flowi4_mark = skb->mark;
-	fl4.flowi4_proto = protocol;
+	fl4.flowi4_proto = IPPROTO_UDP;
 	fl4.daddr = info->key.u.ipv4.dst;
 	fl4.saddr = info->key.u.ipv4.src;
 	tos = info->key.tos;
-- 
2.53.0




