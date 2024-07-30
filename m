Return-Path: <stable+bounces-63271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9038994182A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12CF1C230CD
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0361898FF;
	Tue, 30 Jul 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B0Z2CJDG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B05189516;
	Tue, 30 Jul 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356283; cv=none; b=N/H+Vc2xQhrI1oYw7wFIcF+Fz8m+iARvWX9cDh4h0BVSWa+vGJV+l1Vcup+bd9x/owXMprhrCiLzmIArEVvhPfABtJVnycu1+22WAvfgsmgC5SlOKaR2FwJPSUbJnNwhULg83Pn8UtrKIx0W3YpigYXuVCnqmS06M0kxRPhOrG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356283; c=relaxed/simple;
	bh=2c9TZ1r31X0UTRO6YCFi2y2ZJKubLJlJRtm9wmJRsig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLt+3zV2F3bBaC/ChnZCqlz2FU7FcWNTVq0YC+MOxWReeDm5u2zNbJg50CzgtJ9KQYeCdH790iCUXAHLVUno7d0vFIpGDAnxnVZNMXaZzV9UJi0NjrtpNbgMS7Z/9NlM0BCjVkB4x4Pj2rrOze12NJ5V/luW/txlaQLzAM/cQ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B0Z2CJDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF891C32782;
	Tue, 30 Jul 2024 16:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356283;
	bh=2c9TZ1r31X0UTRO6YCFi2y2ZJKubLJlJRtm9wmJRsig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B0Z2CJDG9XCsIVjySXVVtJLZEVakhQMzUd1w6heAmVMSq+5mpiJodA8wQ5nANdbBL
	 G7U22b8oob+bQHTRU00us63oE+8HR6M5LQRUwh8vcI0hEwFKJSE59tqPs8FxGV8ASq
	 E+dJm3qa+rfsVgh48vSEN7k9Rc9WyYVFFUMHIK5U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 136/809] arm64: dts: rockchip: fixes PHY reset for Lunzn Fastrhino R68S
Date: Tue, 30 Jul 2024 17:40:12 +0200
Message-ID: <20240730151729.985159832@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

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




