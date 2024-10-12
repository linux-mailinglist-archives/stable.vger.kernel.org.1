Return-Path: <stable+bounces-83555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD199B3E9
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8636287719
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CC41D0DEB;
	Sat, 12 Oct 2024 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXfLHFU0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA871D0B97;
	Sat, 12 Oct 2024 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732512; cv=none; b=a0XA9pzcSk0GjbyZRRXWLIXqzUkgTZD0IT3UKT9gTPng9JTr5lrYUDN40rj77i/KNHoClx1L+FPBiEZElxXNpkz0eejUuihp0nc2ltuuByUfsWE9Qo/3PNCnqFWLz/Pad3J3Qg3A6TmGmcousxpVGpveHcTbNCX4uOsmGWcCSck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732512; c=relaxed/simple;
	bh=uBw5mKaYmKbMmM6SA7OhEUEYjzca53Hg2mGyI3POvZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqd6vaM94bjIzQHbX41ULghgFqI2xxYyrgIqR2PqiYojKWfTmQvW3jXFuYCov0kAJ6H5tS2zq5Qog1TNIoc3OlK9RS+RVzdm4aQlP54lwkVtTqqrkoXrBID5Kd5jED3GoTvrExDx/sjOHXvdjYkJ8l1SsVW1LxMTKs5K+QdwN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXfLHFU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC8CC4CEC7;
	Sat, 12 Oct 2024 11:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732512;
	bh=uBw5mKaYmKbMmM6SA7OhEUEYjzca53Hg2mGyI3POvZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXfLHFU0DfpKP0iCEelN+wUPKN51JcQBn0l81oaBVFZpdkotsT+qDeI/lSxglMFVn
	 pVWCE30uGWjaaJ/LVUK7oklVhxP0Y9pWdZkJorsVuUy/vu05WGaIfY7Npi4S7Q0uoS
	 7vPEu580JXhafAsWRfBZjlTZjgFPmdbsvk6c/BrBo6DyGYhAV5zp8jLjWi5iVECXWC
	 OCMvj3biLl4A9LzXXZqyhUOLHx90b/Vl4oji/RFVCy2dvHmgWWqGT1/pddf5C+e8vC
	 D6t6/Morv/0IjjGGUdVl4WzC1WVathEdmMGftSwq9fdXZjKHTDl7+QxYCkaLSez21Y
	 1UDzL6z2UFccQ==
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
	sd@queasysnail.net,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/13] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Sat, 12 Oct 2024 07:27:54 -0400
Message-ID: <20241012112818.1763719-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112818.1763719-1-sashal@kernel.org>
References: <20241012112818.1763719-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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


