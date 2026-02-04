Return-Path: <stable+bounces-214194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMHiOZlqg2l+mgMAu9opvQ
	(envelope-from <stable+bounces-214194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:49:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1018CE96EA
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D3AB730772AF
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC083D994;
	Wed,  4 Feb 2026 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yO+8b4ed"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62029BD80;
	Wed,  4 Feb 2026 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218878; cv=none; b=C5GnPm+vapa5N+L1pRIiC3pHsGhSFPDx1kppUU9lnoG6d2gQTjMTT1WuOyZqetU1qA8eOjyofJIoUa3z6Q+I9QVi0VKUkmr/eOWGbzUDSn5IxWz2Co33NlAQwK46/OQc6CeRObZK3rllMoIH+/qw2hH5GbkP1qfy43WsJ9PoPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218878; c=relaxed/simple;
	bh=hm3ackOcubCoEA2mRnRokSUxsmpgEui2d1tBU7K5vP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZSffVv2+we8qiYYzwhqsPqti8cPfi5vZU8VqQZ9HQFMWsW/dqK3tyTxyQRx4ubaQ704GVAIdLTGAVxzK7gbK4kQLm3hVKEc0iz+/EJySamLCLGBmcdLAPNMtKgdJe4HfZDuL/7Uv4wBxvHzmb1qSCnnuueXAEqL+nKJhug4wTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yO+8b4ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B565C4CEF7;
	Wed,  4 Feb 2026 15:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218878;
	bh=hm3ackOcubCoEA2mRnRokSUxsmpgEui2d1tBU7K5vP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yO+8b4edRVFsWJB+sfMy2Tpk/w0wYei2m15D3Z6fX3xjfI0iUgJrS3zsRaJXH+LMQ
	 WP61QCQc2+ek4ju6mJ2D43NJk8E61E1P6vowc2yQhY1xYB9ZTYzLyvx+Nl2f++bIs9
	 4x0fpe74vnpAz/4RNhfTdQMnnmaj+yX1KXq/m4uY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jibin Zhang <jibin.zhang@mediatek.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12 55/87] net: fix segmentation of forwarding fraglist GRO
Date: Wed,  4 Feb 2026 15:40:53 +0100
Message-ID: <20260204143848.897998555@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
References: <20260204143846.906385641@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214194-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,mediatek.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 1018CE96EA
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jibin Zhang <jibin.zhang@mediatek.com>

commit 426ca15c7f6cb6562a081341ca88893a50c59fa2 upstream.

This patch enhances GSO segment handling by properly checking
the SKB_GSO_DODGY flag for frag_list GSO packets, addressing
low throughput issues observed when a station accesses IPv4
servers via hotspots with an IPv6-only upstream interface.

Specifically, it fixes a bug in GSO segmentation when forwarding
GRO packets containing a frag_list. The function skb_segment_list
cannot correctly process GRO skbs that have been converted by XLAT,
since XLAT only translates the header of the head skb. Consequently,
skbs in the frag_list may remain untranslated, resulting in protocol
inconsistencies and reduced throughput.

To address this, the patch explicitly sets the SKB_GSO_DODGY flag
for GSO packets in XLAT's IPv4/IPv6 protocol translation helpers
(bpf_skb_proto_4_to_6 and bpf_skb_proto_6_to_4). This marks GSO
packets as potentially modified after protocol translation. As a
result, GSO segmentation will avoid using skb_segment_list and
instead falls back to skb_segment for packets with the SKB_GSO_DODGY
flag. This ensures that only safe and fully translated frag_list
packets are processed by skb_segment_list, resolving protocol
inconsistencies and improving throughput when forwarding GRO packets
converted by XLAT.

Signed-off-by: Jibin Zhang <jibin.zhang@mediatek.com>
Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260126152114.1211-1-jibin.zhang@mediatek.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/filter.c        |    2 ++
 net/ipv4/tcp_offload.c   |    3 ++-
 net/ipv4/udp_offload.c   |    3 ++-
 net/ipv6/tcpv6_offload.c |    3 ++-
 4 files changed, 8 insertions(+), 3 deletions(-)

--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3360,6 +3360,7 @@ static int bpf_skb_proto_4_to_6(struct s
 			shinfo->gso_type &= ~SKB_GSO_TCPV4;
 			shinfo->gso_type |=  SKB_GSO_TCPV6;
 		}
+		shinfo->gso_type |=  SKB_GSO_DODGY;
 	}
 
 	bpf_skb_change_protocol(skb, ETH_P_IPV6);
@@ -3390,6 +3391,7 @@ static int bpf_skb_proto_6_to_4(struct s
 			shinfo->gso_type &= ~SKB_GSO_TCPV6;
 			shinfo->gso_type |=  SKB_GSO_TCPV4;
 		}
+		shinfo->gso_type |=  SKB_GSO_DODGY;
 	}
 
 	bpf_skb_change_protocol(skb, ETH_P_IP);
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -107,7 +107,8 @@ static struct sk_buff *tcp4_gso_segment(
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
 		struct tcphdr *th = tcp_hdr(skb);
 
-		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
+		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
+		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
 			return __tcp4_gso_segment_list(skb, features);
 
 		skb->ip_summed = CHECKSUM_NONE;
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -358,7 +358,8 @@ struct sk_buff *__udp_gso_segment(struct
 
 	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
 		 /* Detect modified geometry and pass those to skb_segment. */
-		if (skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size)
+		if ((skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size) &&
+		    !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_DODGY))
 			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
 
 		ret = __skb_linearize(gso_skb);
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -171,7 +171,8 @@ static struct sk_buff *tcp6_gso_segment(
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
 		struct tcphdr *th = tcp_hdr(skb);
 
-		if (skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size)
+		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
+		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
 			return __tcp6_gso_segment_list(skb, features);
 
 		skb->ip_summed = CHECKSUM_NONE;



