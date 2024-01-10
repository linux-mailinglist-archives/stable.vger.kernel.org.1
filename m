Return-Path: <stable+bounces-10176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 845AB827390
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202331F23C35
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428CB5101D;
	Mon,  8 Jan 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AljamhRG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D55101B;
	Mon,  8 Jan 2024 15:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFEBC433D9;
	Mon,  8 Jan 2024 15:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728241;
	bh=OEyoNzReK0TlUuyCZ8Jl7gKc+T8FkCX78ve1ZVzM+Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AljamhRGzo1EDraVmCpuHEy6n9UYELfUEi9BJuMaHiU8k7mIRhHAsOywlu8mU+x9c
	 0keCbrJ5Iq5oUaSXUCy9PexSMnqbjBe+qa+NqYAfDo2f/llNXBLBPJx2odLD6AIti+
	 uS8FvEsIO6MdixxyU4hytYSIAJqcGApn3+/43GDg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 015/150] netfilter: nf_tables: set transport offset from mac header for netdev/egress
Date: Mon,  8 Jan 2024 16:34:26 +0100
Message-ID: <20240108153511.970280590@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 0ae8e4cca78781401b17721bfb72718fdf7b4912 ]

Before this patch, transport offset (pkt->thoff) provides an offset
relative to the network header. This is fine for the inet families
because skb->data points to the network header in such case. However,
from netdev/egress, skb->data points to the mac header (if available),
thus, pkt->thoff is missing the mac header length.

Add skb_network_offset() to the transport offset (pkt->thoff) for
netdev, so transport header mangling works as expected. Adjust payload
fast eval function to use skb->data now that pkt->thoff provides an
absolute offset. This explains why users report that matching on
egress/netdev works but payload mangling does not.

This patch implicitly fixes payload mangling for IPv4 packets in
netdev/egress given skb_store_bits() requires an offset from skb->data
to reach the transport header.

I suspect that nft_exthdr and the trace infra were also broken from
netdev/egress because they also take skb->data as start, and pkt->thoff
was not correct.

Note that IPv6 is fine because ipv6_find_hdr() already provides a
transport offset starting from skb->data, which includes
skb_network_offset().

The bridge family also uses nft_set_pktinfo_ipv4_validate(), but there
skb_network_offset() is zero, so the update in this patch does not alter
the existing behaviour.

Fixes: 42df6e1d221d ("netfilter: Introduce egress hook")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables_ipv4.h | 2 +-
 net/netfilter/nf_tables_core.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/netfilter/nf_tables_ipv4.h b/include/net/netfilter/nf_tables_ipv4.h
index d8f6cb47ebe37..5225d2bd1a6e9 100644
--- a/include/net/netfilter/nf_tables_ipv4.h
+++ b/include/net/netfilter/nf_tables_ipv4.h
@@ -30,7 +30,7 @@ static inline int __nft_set_pktinfo_ipv4_validate(struct nft_pktinfo *pkt)
 		return -1;
 
 	len = iph_totlen(pkt->skb, iph);
-	thoff = iph->ihl * 4;
+	thoff = skb_network_offset(pkt->skb) + (iph->ihl * 4);
 	if (pkt->skb->len < len)
 		return -1;
 	else if (len < thoff)
diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index cee3e4e905ec8..e0c117229ee9d 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -141,7 +141,7 @@ static bool nft_payload_fast_eval(const struct nft_expr *expr,
 	else {
 		if (!(pkt->flags & NFT_PKTINFO_L4PROTO))
 			return false;
-		ptr = skb_network_header(skb) + nft_thoff(pkt);
+		ptr = skb->data + nft_thoff(pkt);
 	}
 
 	ptr += priv->offset;
-- 
2.43.0




