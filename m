Return-Path: <stable+bounces-153522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7EEADD562
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C918B19E099A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8162EA165;
	Tue, 17 Jun 2025 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nKeTpaky"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA862F234A;
	Tue, 17 Jun 2025 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176235; cv=none; b=NTjm0vXhi7VsvZgXPJBtyHoDPNN8ycQrh9c6sAlpOSEX1KRsqjmlrFLgi/zhScQC8s93Yic/2DIqHd4aG/QNlQZwEcEvXuCSAWEV3NaFqfM0qg/mG7cQaM4tUPbAuJK8wJ4bXOxvhTjNA7RaXK0O4IAJNimNHc5ttNUG9L6Gqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176235; c=relaxed/simple;
	bh=JrUmZYWvyxoqg3oIxU/Ny5kX9a33XwxLpyDDnlvYmvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WdSx4A/fai/WSGkHoz0hkgHwCYiTbKpyf2iPgHt6QBsvDLWxOybxZGuDVVNR0oR1FQLU9Ug0ARZCdkFyc9hUOaiXLPs2PD3o/inC0Prpi0fFRwa4TAdFNO9FGuzOU7ILbkAgtuJ0mHDdg54d0x6S4curkpUv5vkwjQ5SS+4qRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nKeTpaky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4122FC4CEE3;
	Tue, 17 Jun 2025 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176235;
	bh=JrUmZYWvyxoqg3oIxU/Ny5kX9a33XwxLpyDDnlvYmvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nKeTpakycTmJZA1EHa7SCKc9HV98/nK9Gm0ySHDfFNPS6UlsUQztpXuHHmEe9UP2d
	 /G83uyRoYfpTJrR1nEKNv7p+SRO/nTzDj5zxGNYTstBq3Tg7GOxN2yIMUcoze8nRSD
	 o/+R0nEhEEfk3PH2l2S+rf2lQh9d2mmywNvGZQZY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thangaraj Samynathan <thangaraj.s@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 209/512] net: lan743x: Fix PHY reset handling during initialization and WOL
Date: Tue, 17 Jun 2025 17:22:55 +0200
Message-ID: <20250617152428.101813807@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thangaraj Samynathan <thangaraj.s@microchip.com>

[ Upstream commit 82d1096ca8b5dbb3158d707e6fb3ad21c3403a49 ]

Remove lan743x_phy_init from lan743x_hardware_init as it resets the PHY
registers, causing WOL to fail on subsequent attempts. Add a call to
lan743x_hw_reset_phy in the probe function to ensure the PHY is reset
during device initialization.

Fixes: 23f0703c125be ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250526053048.287095-3-thangaraj.s@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 8d53a35a2b561..9836fbbea0cc2 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1346,11 +1346,6 @@ static int lan743x_hw_reset_phy(struct lan743x_adapter *adapter)
 				  50000, 1000000);
 }
 
-static int lan743x_phy_init(struct lan743x_adapter *adapter)
-{
-	return lan743x_hw_reset_phy(adapter);
-}
-
 static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 {
 	u32 id_rev;
@@ -3505,10 +3500,6 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 	if (ret)
 		return ret;
 
-	ret = lan743x_phy_init(adapter);
-	if (ret)
-		return ret;
-
 	ret = lan743x_ptp_init(adapter);
 	if (ret)
 		return ret;
@@ -3642,6 +3633,10 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 	if (ret)
 		goto cleanup_pci;
 
+	ret = lan743x_hw_reset_phy(adapter);
+	if (ret)
+		goto cleanup_pci;
+
 	ret = lan743x_hardware_init(adapter, pdev);
 	if (ret)
 		goto cleanup_pci;
-- 
2.39.5




