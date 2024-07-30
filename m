Return-Path: <stable+bounces-63173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDDC9417BF
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796BE286E13
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA1D1A618D;
	Tue, 30 Jul 2024 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FmgVP4bJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8B41A616E;
	Tue, 30 Jul 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355906; cv=none; b=m37q9k1S6AtdzIGBnHUO7dEpmjYojzhrCTqK16w6IKc0B5IVUEO4gHhp6zu7FAu22MO5SNMBdevEuAYgRGSzF2YNTZwmQYsE3++g6oZWyCkS4oaEYcQpSFBErDVJRSPj7LlSehKzG9os2T9A6eChVd51jeqjrd3o4JgAxK+H5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355906; c=relaxed/simple;
	bh=SOmeLuxaucqjj4qKPPIXd4OLAKwTyrGAjnL1zl1HJKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5BDHwzOJNW/icK0AJacvI0T2oLMxy3wqC+3kyDBgVg4A1+mI50AZYdU2tnBmMQNbfUQgFn6lSt6b44hL3GzdT3RTleiIjJpp60hRGbPUZ9rk0ZJ3X/nIbOncTnG/rBDP0g1gX5F7Pb4udYH0AsgpHHUSFaydrIkud1i6smoqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FmgVP4bJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50896C4AF0C;
	Tue, 30 Jul 2024 16:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355906;
	bh=SOmeLuxaucqjj4qKPPIXd4OLAKwTyrGAjnL1zl1HJKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmgVP4bJT32q5o1UrkgluiMng9nBIc1wJS7egjvA4KMOTlSehBvWDGSRna9DKHnAN
	 RPraL6xfTWNXLAIjN9yBn0ZiRjI5m/p7bRGt8SBh/3zYq9CdwHE3Sf18/WVkuX78MZ
	 UrxDOTu7w2E9rbvqYK0gDJ2Alsm5lz0LGmbkhflc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 101/568] arm64: dts: rockchip: fixes PHY reset for Lunzn Fastrhino R68S
Date: Tue, 30 Jul 2024 17:43:28 +0200
Message-ID: <20240730151643.823006741@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chukun Pan <amadeus@jmu.edu.cn>

[ Upstream commit e261bd74000ca80e5483ba8a8bda509de8cbe7fd ]

Fixed the PHY address and reset GPIOs (does not match the corresponding
pinctrl) for gmac0 and gmac1.

Fixes: b9f8ca655d80 ("arm64: dts: rockchip: Add Lunzn Fastrhino R68S")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
Link: https://lore.kernel.org/r/20240630150010.55729-7-amadeus@jmu.edu.cn
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/rockchip/rk3568-fastrhino-r68s.dts      | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
index a3339186e89c8..ce2a5e1ccefc3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
@@ -39,7 +39,7 @@ &gmac0_tx_bus2
 		     &gmac0_rx_bus2
 		     &gmac0_rgmii_clk
 		     &gmac0_rgmii_bus>;
-	snps,reset-gpio = <&gpio0 RK_PB0 GPIO_ACTIVE_LOW>;
+	snps,reset-gpio = <&gpio1 RK_PB0 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	/* Reset time is 15ms, 50ms for rtl8211f */
 	snps,reset-delays-us = <0 15000 50000>;
@@ -61,7 +61,7 @@ &gmac1m1_tx_bus2
 		     &gmac1m1_rx_bus2
 		     &gmac1m1_rgmii_clk
 		     &gmac1m1_rgmii_bus>;
-	snps,reset-gpio = <&gpio0 RK_PB1 GPIO_ACTIVE_LOW>;
+	snps,reset-gpio = <&gpio1 RK_PB1 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	/* Reset time is 15ms, 50ms for rtl8211f */
 	snps,reset-delays-us = <0 15000 50000>;
@@ -71,18 +71,18 @@ &gmac1m1_rgmii_clk
 };
 
 &mdio0 {
-	rgmii_phy0: ethernet-phy@0 {
+	rgmii_phy0: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <0>;
+		reg = <0x1>;
 		pinctrl-0 = <&eth_phy0_reset_pin>;
 		pinctrl-names = "default";
 	};
 };
 
 &mdio1 {
-	rgmii_phy1: ethernet-phy@0 {
+	rgmii_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <0>;
+		reg = <0x1>;
 		pinctrl-0 = <&eth_phy1_reset_pin>;
 		pinctrl-names = "default";
 	};
-- 
2.43.0




