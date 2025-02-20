Return-Path: <stable+bounces-118480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B8FA3E115
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06ADE7A95C7
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460AC20B211;
	Thu, 20 Feb 2025 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJNJYCpa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC63D13A87C;
	Thu, 20 Feb 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069705; cv=none; b=C9PRK7qtOSAfEGV/KAn9rnCbVXtaulZ4qLauSO/31E0LpT1CWxaBvNZPaTrgnL/22UUwBFj+M2vyj7b8EIhohNmxLt1cIoFJ/VWcxu8qfRg7gY4ErAm7L/6a2nUMKYnCpShu9m+yW+ITkG9wQdX19RginuqDGTfiOtdn/Ml0pqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069705; c=relaxed/simple;
	bh=HyXshobuVqA0RqPRtuVurArIvohbfETQanVpkFcibTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QW+X3UYnjvMG1YnYnhXKYKLFpWYAYJukEnOHym72Bt7YO8hST9Rvruz4amOehGAad21s/JjiG1q4GY9oI+Oh6ctUaocahz0eQleOvDOpdKM9o3S3tIxzD2NIIMNmUJbkx7ZL9eoe832eLdsMskl4Y04G/N3U9U5e3a681gRR1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJNJYCpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F95C4CED1;
	Thu, 20 Feb 2025 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740069704;
	bh=HyXshobuVqA0RqPRtuVurArIvohbfETQanVpkFcibTg=;
	h=From:To:Cc:Subject:Date:From;
	b=NJNJYCpaUum1F7pXgvxKAzTey+/y/cSpzoDM/1W7Qu5koLF4xu5BI9n4sa6HJrJ2p
	 gTuBaxgIbeEIo4Iw53vdKou1gUzUOt7Pi8aPAvlifYsVd4zFObR5+XPDUi+e5Gke7y
	 f7lqiUbf6rjVoBOlQvZxwRXgoWv1FobuJruVyuN+NSNAx62rUj0LWxpiy9mOZ7Do/h
	 MFM4NdiPOX3m0jOTCqbL8SxY45FE/byY60Y5VWf7/lzFYQIILdEk0nG05icel81aWu
	 ak0P+K0yHJt+VNYirpTV1eKknp3F9X3zw9nwgs0cn4sqJbEIuMxAlFieytPCCiq77q
	 iOjR9ZiBdHF6A==
Received: by wens.tw (Postfix, from userid 1000)
	id 984635FB8F; Fri, 21 Feb 2025 00:41:41 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND net-next] net: stmmac: dwmac-rk: Provide FIFO sizes for DWMAC 1000
Date: Fri, 21 Feb 2025 00:40:31 +0800
Message-Id: <20250220164031.1886057-1-wens@kernel.org>
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
(Resending to net-next instead of netdev.)

The commit that broke things has already been reverted in netdev.

The reason for stable inclusion is not to fix the device breakage
(which only broke in v6.14-rc1), but to provide the values so that MTU
changes can work in older kernels.

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


