Return-Path: <stable+bounces-231625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMkfDRn/y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-231625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:06:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B743436DE14
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51B5831F6912
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4EF421F1F;
	Tue, 31 Mar 2026 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rq8v6HqZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C341324B
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974649; cv=none; b=Uo8iLJ7xCgDZKCwEa6q/Xbo84gNvd7GT0crl6lp/bPBUbQRLSuzuvIE5BkkrPfTmFGyvaHl5GsRaS1rYEE109E2BHjeAKKv261uv91BCuWK4qluqyOMEjcWhQ0PnO+wqCLsvD8rDOoSbEtH50q5cQhmW8TgOUy7LNOE9TCDqXxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974649; c=relaxed/simple;
	bh=MThYt0YbLnu5nihvDtVpAUkcTkmqeVhK9GJ17p/B2ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HMg5h5oLk0PAUvOiHkWTeLmB0EA10dimzv2cZkYCbvIkIJgfMhRe2FlruyoqWFp3VmynNJaOZ6L4CkCIlRoDZQAanHoNI4Bh1ymU2DKbUgc9jl5saD163PgigyFcCdsElkTUl5H+DagSyVCxmIub9BqDHkMY7d9+Ji+L1EjgIj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rq8v6HqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58B6C19423;
	Tue, 31 Mar 2026 16:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774974649;
	bh=MThYt0YbLnu5nihvDtVpAUkcTkmqeVhK9GJ17p/B2ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rq8v6HqZF17H+BqGsc/tIFGMit01GRd2KDi75RRGU3BJHmODAjBGSW8XXWtH6HyUQ
	 sYjFVni1Du4cB43sWwducUBJIOIcdG30F+6u222eYKboOEtYIBeejVHG3y4K9Ipa2g
	 u3zre+U0zdx6Iu4YIc80nSUR7QwoEVogYF6R5LGweqUxxjF/EqaYNQFEYbaNVF/ulF
	 /8mTK3qfLayWlrDblmla8uIWChUoNZtooY6fcXknQIjD8Ehm1IqosvG6M/xMkuH4Pf
	 7WCj39A/sJQ/w02KUgrQbGha+ViDoho5Wh2KGvwahfwMG6+yv/fdmREc7Y9h741gDq
	 vR7fFrn4O/szQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	Tangxin Xie <xietangxin@yeah.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] net: correctly handle tunneled traffic on IPV6_CSUM GSO fallback
Date: Tue, 31 Mar 2026 12:30:43 -0400
Message-ID: <20260331163043.2733473-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026033029-given-mustang-a404@gregkh>
References: <2026033029-given-mustang-a404@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,yeah.net,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231625-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,yeah.net:email]
X-Rspamd-Queue-Id: B743436DE14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit c4336a07eb6b2526dc2b62928b5104b41a7f81f5 ]

NETIF_F_IPV6_CSUM only advertises support for checksum offload of
packets without IPv6 extension headers. Packets with extension
headers must fall back onto software checksumming. Since TSO
depends on checksum offload, those must revert to GSO.

The below commit introduces that fallback. It always checks
network header length. For tunneled packets, the inner header length
must be checked instead. Extend the check accordingly.

A special case is tunneled packets without inner IP protocol. Such as
RFC 6951 SCTP in UDP. Those are not standard IPv6 followed by
transport header either, so also must revert to the software GSO path.

Cc: stable@vger.kernel.org
Fixes: 864e3396976e ("net: gso: Forbid IPv6 TSO with extensions on devices with only IPV6_CSUM")
Reported-by: Tangxin Xie <xietangxin@yeah.net>
Closes: https://lore.kernel.org/netdev/0414e7e2-9a1c-4d7c-a99d-b9039cf68f40@yeah.net/
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260320190148.2409107-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c8e49eef45198..26f844e25c450 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3755,6 +3755,22 @@ static netdev_features_t dflt_features_check(struct sk_buff *skb,
 	return vlan_features_check(skb, features);
 }
 
+static bool skb_gso_has_extension_hdr(const struct sk_buff *skb)
+{
+	if (!skb->encapsulation)
+		return ((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
+			 (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+			  vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
+			skb_transport_header_was_set(skb) &&
+			skb_network_header_len(skb) != sizeof(struct ipv6hdr));
+	else
+		return (!skb_inner_network_header_was_set(skb) ||
+			((skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
+			  (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+			   inner_ip_hdr(skb)->version == 6)) &&
+			 skb_inner_network_header_len(skb) != sizeof(struct ipv6hdr)));
+}
+
 static netdev_features_t gso_features_check(const struct sk_buff *skb,
 					    struct net_device *dev,
 					    netdev_features_t features)
@@ -3802,11 +3818,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * so neither does TSO that depends on it.
 	 */
 	if (features & NETIF_F_IPV6_CSUM &&
-	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
-	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
-	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
-	    skb_transport_header_was_set(skb) &&
-	    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
+	    skb_gso_has_extension_hdr(skb) &&
 	    !ipv6_has_hopopt_jumbo(skb))
 		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
-- 
2.53.0


