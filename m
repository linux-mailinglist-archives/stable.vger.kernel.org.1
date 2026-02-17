Return-Path: <stable+bounces-217076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKMMKETUlGmfIAIAu9opvQ
	(envelope-from <stable+bounces-217076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:49:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C671F15055B
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E3053006D71
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BA4284B3B;
	Tue, 17 Feb 2026 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BO/Xd6Hp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B82B261B70;
	Tue, 17 Feb 2026 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361342; cv=none; b=coVr4zmTGY+RKCTzyyjahd0KuFYL21lt+9adepShGgV6aagajAMP3H15m00hjl/txgghtYqZKV9wBMD26B6u0ACPZAKGiB6+A2M5XT4wwmoAITVzdynDMEW5yEWhcPddN7Xu5ffoK834Yn+1cH0TXVk7mXz3J89ak9b4mslMe94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361342; c=relaxed/simple;
	bh=kjVv+WoadetU2TlEortb11yin+cG9YvI5nBCug+ql6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wy06MXosl3OaMosuh76NbOLdsBlcWk/dih8L0LvKs/nDUSyuWs1t1HcbAG3ByI7hRlf+rwgA5P9DXFSrihfHcf6JivY81g8+mvnADdZegWQSW62KjkQJkza8KrVdvy6Suj58sVCB1m8CA5c/58wj36LgQ8wF8JaXDk6bu77jfmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BO/Xd6Hp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879FAC4CEF7;
	Tue, 17 Feb 2026 20:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361342;
	bh=kjVv+WoadetU2TlEortb11yin+cG9YvI5nBCug+ql6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BO/Xd6HpFvSxTDJ3dapua+Fzm5ZMa8UixSCRV7ywjdZiHupbP0JfLDptEBahkt+3P
	 QIXD8U+XTzB4zhSL5BMTAdjRpw1SJJoxLuZSoIrJ+iy2YCyX0TqaaPz4RXDgfQo7h4
	 AywXSKaiYvtkOHB5GIz15GF2TBYRKPz6tHrF1ggs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 64/64] net: tunnel: make skb_vlan_inet_prepare() return drop reasons
Date: Tue, 17 Feb 2026 21:32:00 +0100
Message-ID: <20260217200009.901776152@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200007.505931165@linuxfoundation.org>
References: <20260217200007.505931165@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-217076-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C671F15055B
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Menglong Dong <menglong8.dong@gmail.com>

[ Upstream commit 9990ddf47d4168088e2246c3d418bf526e40830d ]

Make skb_vlan_inet_prepare return the skb drop reasons, which is just
what pskb_may_pull_reason() returns. Meanwhile, adjust all the call of
it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bareudp.c    |  4 ++--
 drivers/net/geneve.c     |  4 ++--
 include/net/ip_tunnels.h | 13 ++++++++-----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 54767154de265..cfbc0240126ef 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -319,7 +319,7 @@ static int bareudp_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be32 saddr;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+	if (skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
 		return -EINVAL;
 
 	if (!sock)
@@ -385,7 +385,7 @@ static int bareudp6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
+	if (skb_vlan_inet_prepare(skb, skb->protocol != htons(ETH_P_TEB)))
 		return -EINVAL;
 
 	if (!sock)
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index b31441fc99fc4..6234a3c711c53 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -932,7 +932,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
+	if (skb_vlan_inet_prepare(skb, inner_proto_inherit))
 		return -EINVAL;
 
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
@@ -1031,7 +1031,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
+	if (skb_vlan_inet_prepare(skb, inner_proto_inherit))
 		return -EINVAL;
 
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index e93db837412b2..c649192ddbacf 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -354,11 +354,12 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 
 /* Variant of pskb_inet_may_pull().
  */
-static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
-					 bool inner_proto_inherit)
+static inline enum skb_drop_reason
+skb_vlan_inet_prepare(struct sk_buff *skb, bool inner_proto_inherit)
 {
 	int nhlen = 0, maclen = inner_proto_inherit ? 0 : ETH_HLEN;
 	__be16 type = skb->protocol;
+	enum skb_drop_reason reason;
 
 	/* Essentially this is skb_protocol(skb, true)
 	 * And we get MAC len.
@@ -379,11 +380,13 @@ static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
 	/* For ETH_P_IPV6/ETH_P_IP we make sure to pull
 	 * a base network header in skb->head.
 	 */
-	if (!pskb_may_pull(skb, maclen + nhlen))
-		return false;
+	reason = pskb_may_pull_reason(skb, maclen + nhlen);
+	if (reason)
+		return reason;
 
 	skb_set_network_header(skb, maclen);
-	return true;
+
+	return SKB_NOT_DROPPED_YET;
 }
 
 static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
-- 
2.51.0




