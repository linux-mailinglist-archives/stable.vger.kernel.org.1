Return-Path: <stable+bounces-258540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPQyI7ooG2ra/ggAu9opvQ
	(envelope-from <stable+bounces-258540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:13:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6A761140D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D87D73020ECC
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82953AB26B;
	Sat, 30 May 2026 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VGPrC+Dq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9642F90E0;
	Sat, 30 May 2026 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164692; cv=none; b=RPim+JUHFhiSWVvgQrH4kUXkQUbdno06Dg8lM+xiuE3kViQiO881ibmHZ6aB/5+5UJvUpQ0ihfslmoYy1i27q+nVhorHUGhwA1Kt+bT09Bh29Z+/juZM2HK5yy8jwPqfWEi3R3zruAAofPIX3qlbXPJUqy39mienghgaXu+ZD2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164692; c=relaxed/simple;
	bh=zqfxe404sN/y0GxKl4FfpooVu8bG5n0hqNcSmTb+Gyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcgBimLE69iQg6Iw7AP+jIp3yHyvE59KQO6Tb3C0KfLTlkc1S5J1JXmztsMNKbHmsM6L9typsnOuB5b4CpQxqJfdHdTsdYtJbPdIquasovgncR5teYvfXbwI3SmEVnDWHfMdZIC/ikc+ddTwiXx6ZWtDXX1co8ISQpGawsifiJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VGPrC+Dq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709B11F00893;
	Sat, 30 May 2026 18:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164691;
	bh=hmuDrdVLCsZOQs6kvivt+RsFNDzvnZHxVBtVeJZjOTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VGPrC+DqR4VV8f+j5w0Yf32WAKZ1Ai3yEy09vkMxBunRYFOiHLaN8E+zuHjpnwFPq
	 HabUVpEmtnvq1YnQ2XrChz94vGGWjtVKWoSKz5lezB5XyJoqQ3blYEAUPfve9QwSwg
	 ySMPqRYslsDmDVIP7ig1/cyukqbx54RKk7Sj3L1Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guillaume Nault <gnault@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 631/776] ipv4: add new arguments to udp_tunnel_dst_lookup()
Date: Sat, 30 May 2026 18:05:45 +0200
Message-ID: <20260530160256.276257915@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258540-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,redhat.com,gmail.com,kernel.org,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0A6A761140D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Beniamino Galvani <b.galvani@gmail.com>

[ Upstream commit 72fc68c6356b663a8763f02d9b0ec773d59a4949 ]

We want to make the function more generic so that it can be used by
other UDP tunnel implementations such as geneve and vxlan. To do that,
add the following arguments:

 - source and destination UDP port;
 - ifindex of the output interface, needed by vxlan;
 - the tos, because in some cases it is not taken from struct
   ip_tunnel_info (for example, when it's inherited from the inner
   packet);
 - the dst cache, because not all tunnel types (e.g. vxlan) want to
   use the one from struct ip_tunnel_info.

With these parameters, the function no longer needs the full struct
ip_tunnel_info as argument and we can pass only the relevant part of
it (struct ip_tunnel_key).

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: aa6c6d9ee064 ("bareudp: fix NULL pointer dereference in bareudp_fill_metadata_dst()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bareudp.c      | 11 +++++++----
 include/net/udp_tunnel.h   |  8 +++++---
 net/ipv4/udp_tunnel_core.c | 26 +++++++++++++-------------
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 21ad3a7bbbf12..91c3138c408f7 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -318,8 +318,10 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	if (!sock)
 		return -ESHUTDOWN;
 
-	rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, &saddr, info,
-				   use_cache);
+	rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, 0, &saddr, &info->key,
+				   0, 0, key->tos,
+				   use_cache ?
+				   (struct dst_cache *)&info->dst_cache : NULL);
 
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
@@ -498,8 +500,9 @@ static int bareudp_fill_metadata_dst(struct net_device *dev,
 		struct rtable *rt;
 		__be32 saddr;
 
-		rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, &saddr,
-					   info, use_cache);
+		rt = udp_tunnel_dst_lookup(skb, dev, bareudp->net, 0, &saddr,
+					   &info->key, 0, 0, info->key.tos,
+					   use_cache ? &info->dst_cache : NULL);
 		if (IS_ERR(rt))
 			return PTR_ERR(rt);
 
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index ac9a8f635a5b1..f2e015fc66ca4 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -163,9 +163,11 @@ void udp_tunnel_sock_release(struct socket *sock);
 
 struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 				     struct net_device *dev,
-				     struct net *net, __be32 *saddr,
-				     const struct ip_tunnel_info *info,
-				     bool use_cache);
+				     struct net *net, int oif,
+				     __be32 *saddr,
+				     const struct ip_tunnel_key *key,
+				     __be16 sport, __be16 dport, u8 tos,
+				     struct dst_cache *dst_cache);
 
 struct metadata_dst *udp_tun_rx_dst(struct sk_buff *skb, unsigned short family,
 				    __be16 flags, __be64 tunnel_id,
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index ad5e9ae28d190..749f163d45777 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -209,31 +209,31 @@ EXPORT_SYMBOL_GPL(udp_tun_rx_dst);
 
 struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 				     struct net_device *dev,
-				     struct net *net, __be32 *saddr,
-				     const struct ip_tunnel_info *info,
-				     bool use_cache)
+				     struct net *net, int oif,
+				     __be32 *saddr,
+				     const struct ip_tunnel_key *key,
+				     __be16 sport, __be16 dport, u8 tos,
+				     struct dst_cache *dst_cache)
 {
-#ifdef CONFIG_DST_CACHE
-	struct dst_cache *dst_cache;
-#endif
 	struct rtable *rt = NULL;
 	struct flowi4 fl4;
-	__u8 tos;
 
 #ifdef CONFIG_DST_CACHE
-	dst_cache = (struct dst_cache *)&info->dst_cache;
-	if (use_cache) {
+	if (dst_cache) {
 		rt = dst_cache_get_ip4(dst_cache, saddr);
 		if (rt)
 			return rt;
 	}
 #endif
+
 	memset(&fl4, 0, sizeof(fl4));
 	fl4.flowi4_mark = skb->mark;
 	fl4.flowi4_proto = IPPROTO_UDP;
-	fl4.daddr = info->key.u.ipv4.dst;
-	fl4.saddr = info->key.u.ipv4.src;
-	tos = info->key.tos;
+	fl4.flowi4_oif = oif;
+	fl4.daddr = key->u.ipv4.dst;
+	fl4.saddr = key->u.ipv4.src;
+	fl4.fl4_dport = dport;
+	fl4.fl4_sport = sport;
 	fl4.flowi4_tos = RT_TOS(tos);
 
 	rt = ip_route_output_key(net, &fl4);
@@ -247,7 +247,7 @@ struct rtable *udp_tunnel_dst_lookup(struct sk_buff *skb,
 		return ERR_PTR(-ELOOP);
 	}
 #ifdef CONFIG_DST_CACHE
-	if (use_cache)
+	if (dst_cache)
 		dst_cache_set_ip4(dst_cache, &rt->dst, fl4.saddr);
 #endif
 	*saddr = fl4.saddr;
-- 
2.53.0




