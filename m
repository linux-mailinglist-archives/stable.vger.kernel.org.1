Return-Path: <stable+bounces-70016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD9C95CF42
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3191F2968B
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BE119E7DC;
	Fri, 23 Aug 2024 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/3GTTh2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE93518BC37;
	Fri, 23 Aug 2024 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421880; cv=none; b=LV7JsSK+MPK6siA9uQJYuKDPNP9pBrm4ovMMzA17I7e5IYhXtD4oOPWipVEc8LA8jdkqlAm6Aum0FerhPIk2U/C1ViK1WpTmvkYanmC4sO19DYnnaeveY5TXrXRZOdWbxJDziuAaimhsDLhBGJYoXAzfS/77yxhhIvDITaeW1I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421880; c=relaxed/simple;
	bh=uBw5mKaYmKbMmM6SA7OhEUEYjzca53Hg2mGyI3POvZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdeImAfp/XI0r3qrzqxn7rZx5ROVnJi5WesZCq6C8ZAMvku7t7iDJraGq8XlqzxnwgACP9xg1nKYl/12zXWuCzvDf3TEz/onJDYthW2qkxaGkLWAcUwiaNgpDrDG/Eta7MhuKHkjGsHyG9cguo0Fn6jsihhxSH6+0b0Nad6od5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/3GTTh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3051FC4AF09;
	Fri, 23 Aug 2024 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421880;
	bh=uBw5mKaYmKbMmM6SA7OhEUEYjzca53Hg2mGyI3POvZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/3GTTh2Au6CQxgYgRTPbCpvLnM/zAgUBRH9YvvgeoKgqD2+e+XQzrWvx0px0GNQX
	 p/k7M8FUkxfAi4TTNIBE++VGz6s4I3BhQ+WvVYHrnO1u5QZLPWnNa8Er4xnkRLneWM
	 VY4SAfKf/zFLJbWlrqu6pNk6DW2X8ynksVpAy10Z22FSE17vKt38rstJyRRWKfAn1y
	 3QHWGG2iLU7DNproxin8X++TeuopdHNGIcD3JipQOwC2CDQOFR27DrNOE/X1Aw/i19
	 iJWn4I/9uik6oPXIQpMWpJR1FXLkZG/iX4XutfPCDnqVPbGTMl+Lzj/XR2iZRerFvl
	 nxDKLxZ4pikfg==
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
	horms@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/13] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Fri, 23 Aug 2024 10:03:54 -0400
Message-ID: <20240823140425.1975208-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140425.1975208-1-sashal@kernel.org>
References: <20240823140425.1975208-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.106
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
index 1732ec3c3dbdc..a718207988f2c 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -946,15 +946,13 @@ jme_udpsum(struct sk_buff *skb)
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


