Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD907ECEA6
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjKOToW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbjKOToV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:44:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E2712C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:44:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25261C433C7;
        Wed, 15 Nov 2023 19:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077458;
        bh=G8kp/b3wADm3pUji1DHKKJZHWlA1OH7Q9EsHsgSkTO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v5k0e7ME8xSGtzfmyXNlQnJ3vUL1dL4g91HqWKQWBUkqldkq9Z8p/vu7f+59FQnSJ
         bImHCyiBttaCGxcuuv8bqbMSY4JI1NwwdV0igP81y6mVJ3f1AYPfW2MV1pToo63uco
         F4clvvmdw7eOs24GxM/XpWG9r/KP1pW6HfI+JGaE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fabio Estevam <festevam@denx.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 315/603] arm64: dts: imx8mp-debix-model-a: Remove USB hub reset-gpios
Date:   Wed, 15 Nov 2023 14:14:20 -0500
Message-ID: <20231115191635.268344842@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 0ce9a2c121e3ab354cf66aeecd3ed0758f3c5067 ]

The SAI2_TXC pin is left unconnected per the imx8mp-debix-model-a
schematics:

https://debix.io/Uploads/Temp/file/20230331/DEBIX%20Model%20A%20Schematics.pdf

Also, the RTS5411E USB hub chip does not have a reset pin.

Remove this pin description to properly describe the hardware.

This also fixes the following schema warning:

hub@1: 'reset-gpios' does not match any of the regexes: 'pinctrl-[0-9]+'
from schema $id: http://devicetree.org/schemas/usb/realtek,rts5411.yaml#

Fixes: 0253e1cb6300 ("arm64: dts: imx8mp-debix: add USB host support")
Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
index 28db9349ed62c..267ceffc02d84 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
@@ -284,7 +284,6 @@ &usb_dwc3_1 {
 	usb_hub_2_x: hub@1 {
 		compatible = "usbbda,5411";
 		reg = <1>;
-		reset-gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;
 		vdd-supply = <&reg_usb_hub>;
 		peer-hub = <&usb_hub_3_x>;
 	};
@@ -293,7 +292,6 @@ usb_hub_2_x: hub@1 {
 	usb_hub_3_x: hub@2 {
 		compatible = "usbbda,411";
 		reg = <2>;
-		reset-gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;
 		vdd-supply = <&reg_usb_hub>;
 		peer-hub = <&usb_hub_2_x>;
 	};
@@ -443,7 +441,6 @@ MX8MP_IOMUXC_UART4_TXD__UART4_DCE_TX				0x49
 	pinctrl_usb1: usb1grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR				0x10
-			MX8MP_IOMUXC_SAI2_TXC__GPIO4_IO25				0x19
 		>;
 	};
 
-- 
2.42.0



