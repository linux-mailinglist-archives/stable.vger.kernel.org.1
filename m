Return-Path: <stable+bounces-70001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 378F095CF0A
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87BE2818BA
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAFB198E99;
	Fri, 23 Aug 2024 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vk+54zgU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF718990B;
	Fri, 23 Aug 2024 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421818; cv=none; b=WsSXnwM8tS+y6wFZ86B4Dh+lNN9AgMUQz8k7tY7BdyqU2IUal+niqA6+5O7axIK3663bC9EcPfzBXQWINfPX619l1DI/MiErfoc3uG8Fr2P+DyQoZ5K6xkPpCRtyvItCG62LjbAsTKhOQO2X72+L5wAKNwHReNu5zB3+TUv+ra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421818; c=relaxed/simple;
	bh=uBw5mKaYmKbMmM6SA7OhEUEYjzca53Hg2mGyI3POvZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4Y1BQBGKCPP/dliiV2F8VoSb+bd1v4cckq3g0ggImvXl6aOWQZa8vEe8NCSLV43NBMLmjV3tRjsPMn3Gv7SFluUAwz7WavDoao1iI7hdSFycbSdMOJ1p6t938fjNxl07WeVVTjwTGQINoER96liRC9ft2I/qOj8x00QDuAyBJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vk+54zgU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F11C32786;
	Fri, 23 Aug 2024 14:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421818;
	bh=uBw5mKaYmKbMmM6SA7OhEUEYjzca53Hg2mGyI3POvZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vk+54zgUccvYFZV6ZLLg0XytXNFHySlLDXjoijclZcmCJH8fHf9CEPoKYUnsOYoRu
	 u9I8xt94gbT1FQzKI0Jx6yeUPLukX0p3/pv9rweEy/WUxnIEHphedsUckkh6QU6JcC
	 2L/RQGqxQtO//QM981D+D+Y+cl8ccF+2QlOxrDzeYVNZ7PyH7oPMM5rzA7T8xmqSnf
	 5yX2xvJ7nKj68qyRf5LNQunS4pds4UXdKwMH6AXbt3logoAQkUjW+dmU3uE4bbPqaQ
	 NDy78YDa6xTNq2X6GXL6ZX71RrqOJ7yb8LnqbonNzPN/gE2l+nzgdp7RMntFsJGvlM
	 iVE/xJnY5TTKw==
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
	jacob.e.keller@intel.com,
	shannon.nelson@amd.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 10/20] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Fri, 23 Aug 2024 10:02:24 -0400
Message-ID: <20240823140309.1974696-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140309.1974696-1-sashal@kernel.org>
References: <20240823140309.1974696-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.47
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


