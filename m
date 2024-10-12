Return-Path: <stable+bounces-83540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87EB99B3BB
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25231C22157
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E858198E7F;
	Sat, 12 Oct 2024 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghtaEyj3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4711AB6CC;
	Sat, 12 Oct 2024 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732461; cv=none; b=LsAwha9SQpICsjc3NpzeyZZBTVL4bpY9JKCokoudoMkJnTqWkJvbmqpf+YECc21A/XcwfmKSQSF30yaS5ac6oNVF+RizlM8leXxlMIbbhKSzKXn7M/8yLq80wNj8VI6+F8TfNW4WUTJ/STsKkk8yaJPgLZzWD+VU4moU4FgnH1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732461; c=relaxed/simple;
	bh=uBw5mKaYmKbMmM6SA7OhEUEYjzca53Hg2mGyI3POvZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbPd6mTPBZRPPk2R95K15m3LLkU8VoAcQz0YbazmpHGgtcedZhlTaOz9m1IUy5vwgIMBPSOlXRtjVkBY4JefCDjspQSUMXqJBKqotFL98i7EMA7XP4K9SrA2nxGaLYTZvCvnpM7cTVTtpflkU/hC3EoXIjq/qM7xvF8CQi1B5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghtaEyj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60961C4CEC6;
	Sat, 12 Oct 2024 11:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732460;
	bh=uBw5mKaYmKbMmM6SA7OhEUEYjzca53Hg2mGyI3POvZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghtaEyj3dKuUW0T4IqH8476a3fp0xEgUBnoJVVLaDOFP8SWZySbJ+z1thTRFc2TBg
	 iBsNZrOFy7yC+E3xdf+RKa1P+wCjTCMYeOSGRT1JLbXdeXSASKvljADbd9tAdMShHu
	 vFcNKNcBWbCAvF8gmzhQNRCWuCpgdmHMuW54gPkKQ7MQfrjFH2+WROtAQIoFF8FMpM
	 m71/vOrwVa/AKMYBAY+UmlS7plrCAs0SCi9Jmtln3Y3N5hDuuQrTP5X5vfDCkmihv8
	 tdfkbCWHrcPTjA+WiaGxVuqMO+M8O6Wmxs8Vd6PEO5whNXA151b4k8eCQNn3gAUj2M
	 eUofsFQpq4aPg==
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
Subject: [PATCH AUTOSEL 6.6 10/20] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Sat, 12 Oct 2024 07:26:42 -0400
Message-ID: <20241012112715.1763241-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112715.1763241-1-sashal@kernel.org>
References: <20241012112715.1763241-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
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


