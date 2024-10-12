Return-Path: <stable+bounces-83566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8885A99B408
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F271C20D98
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EBC19CC2A;
	Sat, 12 Oct 2024 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3ycOpr/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3260E1EF92E;
	Sat, 12 Oct 2024 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732544; cv=none; b=TaDl1XgjjOPMPMj0+MQG8CB2KQ8bhcLEz3yb5hYZeO7zEI/w5byWwuZlKVqCsUs2F8A9RJQOjoQ6UYGglrLyqF3OKq468xjSChsN0zMAbdaBoLP+EjMCynwhjMIqmoXjOdaWNejzgCPMEpmXpvvKCuG0fqWwHM2lpu1/6eqYCPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732544; c=relaxed/simple;
	bh=R43+CoaWsWEVWoLHesWvTZ7ddgaI1Mm3eKkjbHixtnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iz57YLSPaS1cSrdv8pAIKPg/iDZHsWpCGma5iGeS7qVkyZQO6Le9FojxnQpWjoqmctogUrWIGsw6tpstY6/MukefCVjPFBrfxxoDTn0WkBNnMWqcUhe5sm20asC/ilkBLujAhiSR45CpoSYsfBP6hZJaZJoH6MoF4vDGhQXCXgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3ycOpr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFA6C4CEC6;
	Sat, 12 Oct 2024 11:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732543;
	bh=R43+CoaWsWEVWoLHesWvTZ7ddgaI1Mm3eKkjbHixtnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s3ycOpr/7FOCVHlbTfcOLx3lQFe8JeOpCaiacy23Gp7ZmYOl+CQpCnICX3D//nii9
	 lDqjJvRuxGcXo9hdc+S1kfjyBOUriAFGaZVJ4bRy+icrwcRDnwjAF8K8WU7rqa7ptF
	 1pb2FEZ0LQlYtin/0kp9XLk6nLFX3EXk/wc0co9gmfqeVpS3BqgNnNFoWqrHuUgc+j
	 LRMw2ZsCFAuoT/uavL+Mzf0H2jLlVz7ZTPVX41fK+vKRI7PSqN0KEXyd7nePb9dxh/
	 3eNUGgQTJR/RWpXrTbed8TZe/ww17iqoG+5n7DZFN/S6i10hQdRh+zJToWd3agA7nv
	 Tsh9VB2K2rbew==
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
	sd@queasysnail.net,
	shannon.nelson@amd.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/9] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Sat, 12 Oct 2024 07:28:41 -0400
Message-ID: <20241012112855.1764028-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112855.1764028-1-sashal@kernel.org>
References: <20241012112855.1764028-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index 1bdc4f23e1e57..06890993662ad 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -945,15 +945,13 @@ jme_udpsum(struct sk_buff *skb)
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


