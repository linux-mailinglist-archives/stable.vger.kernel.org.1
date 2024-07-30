Return-Path: <stable+bounces-63293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3119D941842
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB73C1F22840
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2C2189537;
	Tue, 30 Jul 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CmRwLR+o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18E1A6193;
	Tue, 30 Jul 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356358; cv=none; b=rMWahxDAg4kXmSxhoXf59d7H5gogQ23Mawzi887o44JtLQ+z+Nuna3y+lnsPxft4EYjRXgrvW9J565BfeMSt55umqBCrLLyavPkuoSVB9NtNkbk+660gnxeJRS6GvQFqKS9aCUhE5cyw1McBM0/4HzbUW711YYFXMu0gvD8JcNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356358; c=relaxed/simple;
	bh=caIMO3bTK2MoZVibbg8JO102clWWfH7Zr8BMYEjA69I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpYt0Gq7NTfcxSeKV+igDTYT6f6TTnh//zQTNcyKqzprbjzZvhtcL4+ZGbhO9jPd5AN+IPPkjekTrIorvwm1WZUl4u/xvBS9xQ9GIZmDn72ntWCfoWyssvTn+fb0Lls6SOsnlairSfb78R76/th0Olz3J9DdCaTlGDs45VFy3u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CmRwLR+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD50BC32782;
	Tue, 30 Jul 2024 16:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356358;
	bh=caIMO3bTK2MoZVibbg8JO102clWWfH7Zr8BMYEjA69I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmRwLR+on328mY0eRDAs9iZ3zNbcsRENHz3ksPUW1ZG/X1f95Yu4DZZ5OQAZixCTH
	 upXtWv9bU/h7d0VKbZggXzUczKMc6nl33t/pljGuNbT14TTRj5qwkUz5BxHAQ0fmj2
	 oVDEQoGLUe7u3uIKrHdAuB+zsCMc2i8efWKxwDFU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ismael Luceno <iluceno@suse.de>,
	Julian Anastasov <ja@ssi.bg>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 141/568] ipvs: Avoid unnecessary calls to skb_is_gso_sctp
Date: Tue, 30 Jul 2024 17:44:08 +0200
Message-ID: <20240730151645.388732367@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ismael Luceno <iluceno@suse.de>

[ Upstream commit 53796b03295cf7ab1fc8600016fa6dfbf4a494a0 ]

In the context of the SCTP SNAT/DNAT handler, these calls can only
return true.

Fixes: e10d3ba4d434 ("ipvs: Fix checksumming on GSO of SCTP packets")
Signed-off-by: Ismael Luceno <iluceno@suse.de>
Acked-by: Julian Anastasov <ja@ssi.bg>
Acked-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/ip_vs_proto_sctp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_proto_sctp.c b/net/netfilter/ipvs/ip_vs_proto_sctp.c
index 1e689c7141271..83e452916403d 100644
--- a/net/netfilter/ipvs/ip_vs_proto_sctp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_sctp.c
@@ -126,7 +126,7 @@ sctp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 	if (sctph->source != cp->vport || payload_csum ||
 	    skb->ip_summed == CHECKSUM_PARTIAL) {
 		sctph->source = cp->vport;
-		if (!skb_is_gso(skb) || !skb_is_gso_sctp(skb))
+		if (!skb_is_gso(skb))
 			sctp_nat_csum(skb, sctph, sctphoff);
 	} else {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -175,7 +175,7 @@ sctp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 	    (skb->ip_summed == CHECKSUM_PARTIAL &&
 	     !(skb_dst(skb)->dev->features & NETIF_F_SCTP_CRC))) {
 		sctph->dest = cp->dport;
-		if (!skb_is_gso(skb) || !skb_is_gso_sctp(skb))
+		if (!skb_is_gso(skb))
 			sctp_nat_csum(skb, sctph, sctphoff);
 	} else if (skb->ip_summed != CHECKSUM_PARTIAL) {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
-- 
2.43.0




