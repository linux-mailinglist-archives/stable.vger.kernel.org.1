Return-Path: <stable+bounces-164507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390D4B0FCF1
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 00:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153DB17CC5A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 22:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AA0273D66;
	Wed, 23 Jul 2025 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=n621.de header.i=@n621.de header.b="oWz675rP"
X-Original-To: stable@vger.kernel.org
Received: from nyx.n621.de (v4gw.hekate.n621.de [136.243.2.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76237273D60;
	Wed, 23 Jul 2025 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.2.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309949; cv=none; b=Tt+ql2BaAM8XGVP7n7O2s9TheXOyaJWD4kvWdZWpU3tFOcwxRTfSXPkmhO3cuig2ZANRozRaG6sUCTLeZEioUlXcaXt9LC9CsHfuQ5uO72ClfbwkfOIleadeCiXf4H7j4/Okc8p54SC7Y3gG5RrLmhuaVWBTSw7vH3YztGNiIMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309949; c=relaxed/simple;
	bh=H5dLFQLR80zyzGXaWyzLG3KAZqe+SuFTxe0PJa5w1d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKugATd6iYbpaOd1f/olkF2Hz57o9g/7Rr7ojL8o9g2WqcS/yLy4mVG/0+OYUendugh9ZIKzEr7MntudYPu8TeBWsaWp1mVrYBxuAq68RDnLsKcgGyaV8aUGVQbsq3Hsuvl4Ejl7KiApsRVrnTPCXsrBDjPpB4bR7tQX9WY604U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=n621.de; spf=pass smtp.mailfrom=n621.de; dkim=pass (1024-bit key) header.d=n621.de header.i=@n621.de header.b=oWz675rP; arc=none smtp.client-ip=136.243.2.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=n621.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=n621.de
Received: from eos.home.n621.de (localhost [127.0.0.1])
	by nyx.n621.de (Postfix) with ESMTP id C3180E002AF;
	Thu, 24 Jul 2025 00:23:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n621.de; s=dkim;
	t=1753309388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FHC/FhBnpS0kU/U/rZh5/dUh3Fl0ZDAJeeBOGbTp50w=;
	b=oWz675rPKlbZ8OpIlElDVCiM0hlKbtAlMQXiZgApQrxC60YFH1+4XN+WBCeiRI/tgBvpqx
	dwKUOxDqmcDxisZNyDbkU5VfumbdCGVasDhAWVbEoBKJoGpTQQswaMppEeyCicAHZ8N+M6
	F9F/zPRieeit9ayyuNE9vFwu73MBnps=
From: Florian Larysch <fl@n621.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Divya.Koppera@microchip.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Larysch <fl@n621.de>,
	stable@vger.kernel.org
Subject: [PATCH net] net: phy: micrel: fix KSZ8081/KSZ8091 cable test
Date: Thu, 24 Jul 2025 00:20:42 +0200
Message-ID: <20250723222250.13960-1-fl@n621.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 21b688dabecb ("net: phy: micrel: Cable Diag feature for lan8814
phy") introduced cable_test support for the LAN8814 that reuses parts of
the KSZ886x logic and introduced the cable_diag_reg and pair_mask
parameters to account for differences between those chips.

However, it did not update the ksz8081_type struct, so those members are
now 0, causing no pairs to be tested in ksz886x_cable_test_get_status
and ksz886x_cable_test_wait_for_completion to poll the wrong register
for the affected PHYs (Basic Control/Reset, which is 0 in normal
operation) and exit immediately.

Fix this by setting both struct members accordingly.

Fixes: 21b688dabecb ("net: phy: micrel: Cable Diag feature for lan8814 phy")
Cc: stable@vger.kernel.org
Signed-off-by: Florian Larysch <fl@n621.de>
---
 drivers/net/phy/micrel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 64aa03aed770..50c6a4e8cfa1 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -472,6 +472,8 @@ static const struct kszphy_type ksz8051_type = {
 
 static const struct kszphy_type ksz8081_type = {
 	.led_mode_reg		= MII_KSZPHY_CTRL_2,
+	.cable_diag_reg		= KSZ8081_LMD,
+	.pair_mask		= KSZPHY_WIRE_PAIR_MASK,
 	.has_broadcast_disable	= true,
 	.has_nand_tree_disable	= true,
 	.has_rmii_ref_clk_sel	= true,
-- 
2.50.1


