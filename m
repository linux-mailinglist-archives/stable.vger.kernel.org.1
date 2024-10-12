Return-Path: <stable+bounces-83575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E9099B422
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5D528BA59
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0BF1FA256;
	Sat, 12 Oct 2024 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rv5FiEJw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77431FA24D;
	Sat, 12 Oct 2024 11:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732571; cv=none; b=kPLxobRD0XmEz8+uzpty2ChD9ee1bTggNQSlwgUgM+R/QEXDlo2WA3k1yMY+GNykK8Yf0gsS+zpyPihNYLD177PDFPRuYpXwIxaXIZYhZWaWhay06bp1xNk6dmxBNqj1fv6MMLMWGMhEjSFCBr6JwHC0Qn8Rje9pVtBy0OzPrnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732571; c=relaxed/simple;
	bh=BBbpl+Jaz8owFH3li+2vNQMDyDDM8/Ufc4ojWTrHyJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gih91W/rD/EJ+w78GbfbszEmRlWZojHlP1PmRm2iz53MJDXWF2HZJEJGJJ2RyKS0FIXj4caOQadVS0Q0RHhRt3CN4mRypVrJdibPcvwZpktbPflFq/wtLC+IK7dj5Kmu+PJm1kaaTwxZzkLFnGDmiY0BBV8hR09w107rdy/+hY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rv5FiEJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C80C4CECE;
	Sat, 12 Oct 2024 11:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732571;
	bh=BBbpl+Jaz8owFH3li+2vNQMDyDDM8/Ufc4ojWTrHyJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rv5FiEJw996i+Z5WWM8gGV8+hAYp1OUQQE5N4RsHxAv0CR0ydueWvBItl68Sen0iK
	 hJK/ac+J1lan1a52Oud/hGyYRwThfDGi1D/9BPnrtDaEVeSvJBuSBr1fGDp6IfC45l
	 jpHr3e+y799cdbjRC1Gpt7k6V2hnNtEsmC6fTR2EQi1qGdF+7rNMMTe2plp0VHmmhp
	 wluqdvbotrAbRSzilofBNYF2WCDzM4ueDWqzn5/dFJetMV2eWYaMk5IXuV5dg8HWQ9
	 KsC2qObsaERd+eifR8ZTuTyo2UugO2vhiNTvbwvm2f8xMBHmDDzxBbJFiPcQG7ze2R
	 +yQOPmWZotyag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Moon Yeounsu <yyyynoom@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	cooldavid@cooldavid.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jacob.e.keller@intel.com,
	shannon.nelson@amd.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/9] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Sat, 12 Oct 2024 07:29:08 -0400
Message-ID: <20241012112922.1764240-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112922.1764240-1-sashal@kernel.org>
References: <20241012112922.1764240-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
Content-Transfer-Encoding: 8bit

From: Moon Yeounsu <yyyynoom@gmail.com>

[ Upstream commit 9a039eeb71a42c8b13408a1976e300f3898e1be0 ]

`ip_hdr(skb)->ihl << 2` is the same as `ip_hdrlen(skb)`
Therefore, we should use a well-defined function not a bit shift
to find the header length.

It also compresses two lines to a single line.

Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/jme.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index e9efe074edc11..80858206c5147 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -947,15 +947,13 @@ jme_udpsum(struct sk_buff *skb)
 	if (skb->protocol != htons(ETH_P_IP))
 		return csum;
 	skb_set_network_header(skb, ETH_HLEN);
-	if ((ip_hdr(skb)->protocol != IPPROTO_UDP) ||
-	    (skb->len < (ETH_HLEN +
-			(ip_hdr(skb)->ihl << 2) +
-			sizeof(struct udphdr)))) {
+
+	if (ip_hdr(skb)->protocol != IPPROTO_UDP ||
+	    skb->len < (ETH_HLEN + ip_hdrlen(skb) + sizeof(struct udphdr))) {
 		skb_reset_network_header(skb);
 		return csum;
 	}
-	skb_set_transport_header(skb,
-			ETH_HLEN + (ip_hdr(skb)->ihl << 2));
+	skb_set_transport_header(skb, ETH_HLEN + ip_hdrlen(skb));
 	csum = udp_hdr(skb)->check;
 	skb_reset_transport_header(skb);
 	skb_reset_network_header(skb);
-- 
2.43.0


