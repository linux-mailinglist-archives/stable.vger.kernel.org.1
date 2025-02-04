Return-Path: <stable+bounces-112190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73623A276E3
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9BD3A3C59
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB0921519A;
	Tue,  4 Feb 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opORp5jE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81DB21516C;
	Tue,  4 Feb 2025 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738685673; cv=none; b=awHw6LBaeLqEjR7Wc+JyhxKToIv/FBDLbW7d4f+1XMlGKkMdE9VahV2KXC6HkIb/Y5roKs1N6p5uR7sfu6oyJw5Dw/wwYyKtbYPX6IMaj6Eer2joG8Zu5VK+HdpzPyE8fH4m3RUVSp3c8IDC75RkRITNRGVMibuMdC8yF2p8eoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738685673; c=relaxed/simple;
	bh=GBcXB5AV6YtR0BMwlaL9meSZs1urR7n3hkq4NxMztr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JB6ttRO2QVZIavFR3PNoZTnyA6O/r9PBAB2MIIpIK930wczARbzV1E8mUHPIuNC9c56XovvNFo7jNBStHxMAYWcyK/F+XKd/yNnXGcS4fn4/MG92/8NruAv1UpUCW+J6I5YJhuXN3ESQwpAF7MJlTJeFtPkDm5WUX4snrH+LL8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opORp5jE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0B5C4CEDF;
	Tue,  4 Feb 2025 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738685673;
	bh=GBcXB5AV6YtR0BMwlaL9meSZs1urR7n3hkq4NxMztr0=;
	h=From:To:Cc:Subject:Date:From;
	b=opORp5jEQEYA6NkXiV8/hFMEVuSB7q/VlDuVWp8REJ4ZjfSqvZb5l0Upl5IXfCCH7
	 h7Uh5Zz1M0YBxtxPhmYaXKeQQj5+Llifb0K7gMlMG72jyHp8XIvlXiqr4xN2N983Dn
	 DHUwmyW9VzkYX84vEAazeN/kDbkU3wYQ377Q4ezuEXltPpPRbrnIgWG1o5KG0Ipo+d
	 KaqI/DfCDrCYTBVyLFIJqM5Jh3fjME/d78qO5yhohJC9OIdEAfeFafK9jbjxberwTO
	 smfveWlyGMOoZwN9FhcS5j6QO7NePSUHonJk7qx9WRZP31Lb/x1WJ4UDRgRAzBtY4h
	 nx+co3ay1oe0A==
Received: by wens.tw (Postfix, from userid 1000)
	id 1F16D5FB49; Wed,  5 Feb 2025 00:14:29 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Steven Price <steven.price@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH netdev] net: stmmac: dwmac-rk: Provide FIFO sizes for DWMAC 1000
Date: Wed,  5 Feb 2025 00:13:59 +0800
Message-Id: <20250204161359.3335241-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The DWMAC 1000 DMA capabilities register does not provide actual
FIFO sizes, nor does the driver really care. If they are not
provided via some other means, the driver will work fine, only
disallowing changing the MTU setting.

The recent commit 8865d22656b4 ("net: stmmac: Specify hardware
capability value when FIFO size isn't specified") changed this by
requiring the FIFO sizes to be provided, breaking devices that were
working just fine.

Provide the FIFO sizes through the driver's platform data, to not
only fix the breakage, but also enable MTU changes. The FIFO sizes
are confirmed to be the same across RK3288, RK3328, RK3399 and PX30,
based on their respective manuals. It is likely that Rockchip
synthesized their DWMAC 1000 with the same parameters on all their
chips that have it.

Fixes: eaf4fac47807 ("net: stmmac: Do not accept invalid MTU values")
Fixes: 8865d22656b4 ("net: stmmac: Specify hardware capability value when FIFO size isn't specified")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
The reason for stable inclusion is not to fix the device breakage
(which only broke in v6.14-rc1), but to provide the values so that MTU
changes can work in older kernels.

Since a fix for stmmac in general has already been sent [1] and a revert
was also proposed [2], I'll refrain from sending mine.

[1] https://lore.kernel.org/all/20250203093419.25804-1-steven.price@arm.com/
[2] https://lore.kernel.org/all/Z6Clkh44QgdNJu_O@shell.armlinux.org.uk/

 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index a4dc89e23a68..71a4c4967467 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1966,8 +1966,11 @@ static int rk_gmac_probe(struct platform_device *pdev)
 	/* If the stmmac is not already selected as gmac4,
 	 * then make sure we fallback to gmac.
 	 */
-	if (!plat_dat->has_gmac4)
+	if (!plat_dat->has_gmac4) {
 		plat_dat->has_gmac = true;
+		plat_dat->rx_fifo_size = 4096;
+		plat_dat->tx_fifo_size = 2048;
+	}
 	plat_dat->fix_mac_speed = rk_fix_speed;
 
 	plat_dat->bsp_priv = rk_gmac_setup(pdev, plat_dat, data);
-- 
2.39.5


