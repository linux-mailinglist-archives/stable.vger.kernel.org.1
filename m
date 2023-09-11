Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889DD79AE3E
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358449AbjIKWLD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238852AbjIKOGN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:06:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460FA120
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:06:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876E7C433C8;
        Mon, 11 Sep 2023 14:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441168;
        bh=vw3qlOfWDHQNNCkg6JMZ67DssPZQzgUXd7GowLMJ19A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r20+T/SnjnaH6cjkSZgNia3JoLinr7q6byeuMMgvvzQwxbxjHBzQSyS/xTL+TSg9+
         NS+5yCk8n6CWpFpcpQuitq4rhgtEfVpQpk4NxN0Rxp7BmHcJdT3BRYgzjGXqT3kgqI
         8DCX8uNPAmHESv9iLf3NXdlQNMeXo2bUg3plSojQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 281/739] arm64: dts: rockchip: Fix PCIe regulators on Radxa E25
Date:   Mon, 11 Sep 2023 15:41:20 +0200
Message-ID: <20230911134658.971073004@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Karlman <jonas@kwiboo.se>

[ Upstream commit a87852e37f782257ebc57cc44a0d3fbf806471f6 ]

Despite its name, the regulator vcc3v3_pcie30x1 has nothing to do with
pcie30x1. Instead, it supply power to VBAT1-5 on the M.2 KEY B port as
seen on page 8 of the schematic [1].

pcie30x1 is used for the mini PCIe slot, and as seen on page 9 the
vcc3v3_minipcie regulator is instead related to pcie30x1.

The M.2 KEY B port can be used for WWAN USB2 modules or SATA drives.

Use correct regulator vcc3v3_minipcie for pcie30x1.

[1] https://dl.radxa.com/cm3p/e25/radxa-e25-v1.4-sch.pdf

Fixes: 2bf2f4d9f673 ("arm64: dts: rockchip: Add Radxa CM3I E25")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Link: https://lore.kernel.org/r/20230724145213.3833099-1-jonas@kwiboo.se
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../arm64/boot/dts/rockchip/rk3568-radxa-e25.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts b/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
index 63c4bd873188e..f0e4884438e39 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
@@ -47,6 +47,9 @@ vbus_typec: vbus-typec-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};
 
+	/* actually fed by vcc5v0_sys, dependent
+	 * on pi6c clock generator
+	 */
 	vcc3v3_minipcie: vcc3v3-minipcie-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -54,9 +57,9 @@ vcc3v3_minipcie: vcc3v3-minipcie-regulator {
 		pinctrl-names = "default";
 		pinctrl-0 = <&minipcie_enable_h>;
 		regulator-name = "vcc3v3_minipcie";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc5v0_sys>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc3v3_pi6c_05>;
 	};
 
 	vcc3v3_ngff: vcc3v3-ngff-regulator {
@@ -71,9 +74,6 @@ vcc3v3_ngff: vcc3v3-ngff-regulator {
 		vin-supply = <&vcc5v0_sys>;
 	};
 
-	/* actually fed by vcc5v0_sys, dependent
-	 * on pi6c clock generator
-	 */
 	vcc3v3_pcie30x1: vcc3v3-pcie30x1-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
@@ -83,7 +83,7 @@ vcc3v3_pcie30x1: vcc3v3-pcie30x1-regulator {
 		regulator-name = "vcc3v3_pcie30x1";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc3v3_pi6c_05>;
+		vin-supply = <&vcc5v0_sys>;
 	};
 
 	vcc3v3_pi6c_05: vcc3v3-pi6c-05-regulator {
@@ -117,7 +117,7 @@ &pcie3x1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie30x1m0_pins>;
 	reset-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
-	vpcie3v3-supply = <&vcc3v3_pcie30x1>;
+	vpcie3v3-supply = <&vcc3v3_minipcie>;
 	status = "okay";
 };
 
-- 
2.40.1



