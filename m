Return-Path: <stable+bounces-231088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNIhHrBEymky7AUAu9opvQ
	(envelope-from <stable+bounces-231088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:38:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A41358505
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FF1230013AC
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38D03AB29D;
	Mon, 30 Mar 2026 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0hhLwW1n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99EA3AEF34
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863531; cv=none; b=eQOrnYhstv1AIVEntzjmmEptajZa0Mc70z+ktfbM+apafFw7v0d/H50T86SLir3W/fk5hREECT+y8y8lWuYT/MfVzgcVkYbx0xjFcWLHMzI+UM1GL8bx3qQowLmI6xW0t+vvlg4hZo8E19jC6DJFRD/auAWpaoN0bz4vdPFWXh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863531; c=relaxed/simple;
	bh=ktZfqvWSEwpyAh8xgSH6n9Z+3m43uR72bmX9FkcaGu0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VJel95O8od3ttlfnyt+I1NLHeafds0fR/wSyuByJc8qi0N7j2YQAuy+f8p7thfrQ0tPtTEcDsxYxHvSpsQcNhinJ8UQLH6fVDvDjsCk5Ck6imor0KOIw9bJoWPLRUyamrprCDuFwrkp2P8Zl4rQPsai+uItmBYZgqkUiPC2XCbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0hhLwW1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490F2C4CEF7;
	Mon, 30 Mar 2026 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774863530;
	bh=ktZfqvWSEwpyAh8xgSH6n9Z+3m43uR72bmX9FkcaGu0=;
	h=Subject:To:Cc:From:Date:From;
	b=0hhLwW1ntukZp77MUJUxspw6mtfzLOkH00/urM2tvkCgmR75fd6lveiCJrtY0sy5T
	 K9Y6lV/WgIPnma6UQl+jXaVrEviTJdrVMUU3unz8ucAi4l0BBYX5mrApzKhsIYXOmQ
	 qcdMQIaNQRSH0e1LAvuyu/ljKeU4A2bSnLSjWi+A=
Subject: FAILED: patch "[PATCH] net: correctly handle tunneled traffic on IPV6_CSUM GSO" failed to apply to 6.6-stable tree
To: willemb@google.com,pabeni@redhat.com,xietangxin@yeah.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:38:31 +0200
Message-ID: <2026033031-camera-abridge-0bb5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231088-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,redhat.com,yeah.net];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: 68A41358505
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c4336a07eb6b2526dc2b62928b5104b41a7f81f5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033031-camera-abridge-0bb5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c4336a07eb6b2526dc2b62928b5104b41a7f81f5 Mon Sep 17 00:00:00 2001
From: Willem de Bruijn <willemb@google.com>
Date: Fri, 20 Mar 2026 15:01:46 -0400
Subject: [PATCH] net: correctly handle tunneled traffic on IPV6_CSUM GSO
 fallback

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

diff --git a/net/core/dev.c b/net/core/dev.c
index 14a83f2035b9..fc5557062414 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3769,6 +3769,22 @@ static netdev_features_t dflt_features_check(struct sk_buff *skb,
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
@@ -3816,11 +3832,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 	 * so neither does TSO that depends on it.
 	 */
 	if (features & NETIF_F_IPV6_CSUM &&
-	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
-	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
-	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
-	    skb_transport_header_was_set(skb) &&
-	    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
+	    skb_gso_has_extension_hdr(skb))
 		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
 
 	return features;


