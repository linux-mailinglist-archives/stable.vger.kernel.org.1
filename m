Return-Path: <stable+bounces-95273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B72A9D763C
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01B9B847C8
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535B0188CCA;
	Sun, 24 Nov 2024 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzEfD/pE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97C2471D9;
	Sun, 24 Nov 2024 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456561; cv=none; b=pnx7m6HK4fSwr8ua3VKXM1cI+rYfOsf6krr+8gTz7XQparcvxa+gdm9kbK+HG2d2guEIfBiaXxiaC0gCyFY3xYtEGSE2JLGt0uxHSVvGW8tPLW4gYavpVVCIqLxwlm1zYop7UIKI8HiLNldV1My2WC8wsB7llpU6ziazDNF1DyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456561; c=relaxed/simple;
	bh=CGETTyCWoXPdn1YRwd2zWw1iVkn0FqNHobWiAX6+d5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJKLPYJ538p8q7XHEHl23jcDKUaS2q80yKTEWBqoZBAr/7ulxR+hOvLO4bSgW1u7aC2XTMl2900ZnwYQEaxlSjE1Rf/3R4X7jmjYYhjT+RH1iWcwYTNDo9oOBtgvGk2p1bfkf1iDQclqcWlAKofK+/GAk488MkJbAIBrQBEXBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzEfD/pE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F81C4CED7;
	Sun, 24 Nov 2024 13:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456560;
	bh=CGETTyCWoXPdn1YRwd2zWw1iVkn0FqNHobWiAX6+d5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mzEfD/pEG7yvBvOIiq/Li4LZtupBWWeAdn7pFZnp9B1UhiDNnehLnEiVcIV45baC1
	 gmRIRH3+4sxMnxemHGcyig0jBKe9pZJlDicrrhxHmkWO7yTrTW0oSThmTgOjJLEMTW
	 xLpUJCYBvD27FGjb0FEw/38sEFShMUxK2xdNJNo6aUviA4Tj/90h3qGBzD3MLANu3D
	 b3oOvZ03ikjquPzPcEuCESP22ZuLEzn0ezbuTg0M7xnhQHUhcTfUollszFjEiLITYx
	 exWDspfYiwlVH6+lc7Om8KvJvNuhMWwdX/2c5dXruBBShw1DnB1rSCDYGI7wKg2Rbt
	 Xin536vAfrYtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	u.kleine-koenig@baylibre.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 05/28] net: fec_mpc52xx_phy: Use %pa to format resource_size_t
Date: Sun, 24 Nov 2024 08:55:05 -0500
Message-ID: <20241124135549.3350700-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Simon Horman <horms@kernel.org>

[ Upstream commit 020bfdc4ed94be472138c891bde4d14241cf00fd ]

The correct format string for resource_size_t is %pa which
acts on the address of the variable to be formatted [1].

[1] https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/core-api/printk-formats.rst#L229

Introduced by commit 9d9326d3bc0e ("phy: Change mii_bus id field to a string")

Flagged by gcc-14 as:

drivers/net/ethernet/freescale/fec_mpc52xx_phy.c: In function 'mpc52xx_fec_mdio_probe':
drivers/net/ethernet/freescale/fec_mpc52xx_phy.c:97:46: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
   97 |         snprintf(bus->id, MII_BUS_ID_SIZE, "%x", res.start);
      |                                             ~^   ~~~~~~~~~
      |                                              |      |
      |                                              |      resource_size_t {aka long long unsigned int}
      |                                              unsigned int
      |                                             %llx

No functional change intended.
Compile tested only.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/netdev/711d7f6d-b785-7560-f4dc-c6aad2cce99@linux-m68k.org/
Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Link: https://patch.msgid.link/20241014-net-pa-fmt-v1-1-dcc9afb8858b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
index b5497e3083020..7e631e2f710fb 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
@@ -92,7 +92,7 @@ static int mpc52xx_fec_mdio_probe(struct platform_device *of)
 		goto out_free;
 	}
 
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%x", res.start);
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%pa", &res.start);
 	bus->priv = priv;
 
 	bus->parent = dev;
-- 
2.43.0


