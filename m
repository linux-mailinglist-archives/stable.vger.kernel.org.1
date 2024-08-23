Return-Path: <stable+bounces-70052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C795CFFD
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586F5B21C14
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BEF1B1428;
	Fri, 23 Aug 2024 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ufsw7Mpm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F164188A15;
	Fri, 23 Aug 2024 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422007; cv=none; b=kX5aUtItNnFILYwkvpyyp60Ld4SJk+LY4ezEnB6Z3H0zP3jtm3Xy/ejD3llAOv5kcyHPsiHfE99y8nsMcjvz1QNLUP6QBd81Ut5J4/95mUJP3yoBKuuqJ9igXQpE6pdoVo1ENsKzhWDXByaSPj4aA7YSw2C6NEVGMe6VaoANNJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422007; c=relaxed/simple;
	bh=j8GEwSJ1gj4zKfxPjLXi3N7hglC5ZlDyEGbK3SNrinU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8VI1WL12bQ0HISXmIqWajnxbclbAwtbLtplAdH/udJbek0zWcWzOUNBLmQSyXPf6AJjuBAD3KB5knRh02KWowt7vsLfh2325SpYuPxbEQsDGu91Wn37xe0Yr8s2czNjZ0BcTOdJQ2pcjXwRDCbs0jgxEOsyjBNn7Zq6yh+jhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ufsw7Mpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA8BC32786;
	Fri, 23 Aug 2024 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724422006;
	bh=j8GEwSJ1gj4zKfxPjLXi3N7hglC5ZlDyEGbK3SNrinU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ufsw7Mpm8rW07B2yZP5ioyjXMVb6WU3rFA8+mWLTNhaUpuy3aPHSj71feI9r2YvEQ
	 9OwmNNWzLV5dL4c+lXg6vyCX2uNTDKUUl7uSZipQgLXH3YkwOZP7ckjI6pSbRHA0IJ
	 8G/6CkWo/5XvNdGBebGXNCbdTGpobjCi6VhE6wYu9Vi2GwO5ld5Bx0WLWqsVTu9iqC
	 oSXjcb6qFZcDzk+HhVWXIFmJFkTaWz8TY63+I9G7ftDo0GksJyGcxx03HmkUQ2MOZ2
	 JdZO50kEIMe2AZHX3Riq5lGFsxKO2BjqZ3pH0Fr9AXY7ER7SKLIFCQLEIvu5G9YS9e
	 lfXLkKoX+tA6w==
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
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/6] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Fri, 23 Aug 2024 10:06:24 -0400
Message-ID: <20240823140636.1976114-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140636.1976114-1-sashal@kernel.org>
References: <20240823140636.1976114-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.320
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
index a5ab6f3403ae0..9b2471b2a9559 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -966,15 +966,13 @@ jme_udpsum(struct sk_buff *skb)
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


