Return-Path: <stable+bounces-83591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF3A99B478
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C8F1F26135
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262C7207A3D;
	Sat, 12 Oct 2024 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvlV+Vp/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85D207A37;
	Sat, 12 Oct 2024 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732618; cv=none; b=PY9CNIqMdPHXKcbkGMdhuNGxRPm6h6MjDNomYM2orrvdNHVrZgyzvTjDsKHwY0patJQS8pHtNqQqF1Pc1fVZs61H6e99Sa3hQOj7Juls5l17F7YIUACmgIGdwKNAT/DYTTo5h3sidix/rgSuPYI4wlowP4udl4JpCtDn7+gxqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732618; c=relaxed/simple;
	bh=j8GEwSJ1gj4zKfxPjLXi3N7hglC5ZlDyEGbK3SNrinU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFjMRykaIZoWNsfUeSFmPy0DYoilm5B0gbVijFDV9kM02pthJ9Y3HoAc5MDrMN3KyrJY9qhgk/75VuY6I8gwg1X7yDA8YvXEU1qddPUP8fJrx8B55H5CiQEt09zn/17CMtzkzy8sl8uaba9yEsCTrQhBmK0ZujldWKKVEGEF7Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvlV+Vp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284E6C4CEC6;
	Sat, 12 Oct 2024 11:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732618;
	bh=j8GEwSJ1gj4zKfxPjLXi3N7hglC5ZlDyEGbK3SNrinU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EvlV+Vp/1dcovot7fIBdoG0SKdyZSXoG/JQFw1wUwD+Cs8yhSfDoubVeHLBADP0tK
	 UURVn/DOoLl8tE4+47vD62HWjh+sYcklaUbc0tNT8Lb6k8GvuZD9mmQGk3x/iMNSx2
	 UQnTE4zm1reNV4AjA7b1KzC/wcTpCN9XjmlpH6GAHxyaMcAP0bGNmMLkBKjP9kkVd5
	 8kmidbxoxaUD9BrQlPRejzbVjOL3z9b6fz9/Fv6w9o212B5eVhXCg1qDb71zr7QL1w
	 +9nzai9g9qsGJt0aXcjgtvpNQfQWVn+CkthHBBj5Ufx24s5mYxM8ZWpgzseN2kL5rt
	 8VbZaImstUuTw==
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
	horms@kernel.org,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/6] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Sat, 12 Oct 2024 07:30:00 -0400
Message-ID: <20241012113009.1764620-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012113009.1764620-1-sashal@kernel.org>
References: <20241012113009.1764620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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


