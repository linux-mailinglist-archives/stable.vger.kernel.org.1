Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6B97B89DB
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244284AbjJDSaH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244263AbjJDSaG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:30:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5749E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:30:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AC8C433C7;
        Wed,  4 Oct 2023 18:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444202;
        bh=FQW1PYKxlrC2Re4u2EromdWphWUAWTiP4UmCpBPBeJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIXUlKfLeBTA8JsRSEP3Qvhigm2XGmzp+IjEtEryXTRSlZyLeBudhTuors+m/eTte
         VVqEWgVBrWaJ5flmcoI6TBqZ0NK9mImfRTHDzmyMbErVRaHQ63c4g7gDvt5IQJmaeQ
         /KCCgZFNVcrAYME3XzECKwJ1vqX6AYBZq1bLAtOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liu Ying <victor.liu@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 149/321] arm64: dts: imx8mm-evk: Fix hdmi@3d node
Date:   Wed,  4 Oct 2023 19:54:54 +0200
Message-ID: <20231004175236.157854357@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Ying <victor.liu@nxp.com>

[ Upstream commit efa97aed071e0607b15ee08ddb1b7d775b664352 ]

The hdmi@3d node's compatible string is "adi,adv7535" instead of
"adi,adv7533" or "adi,adv751*".

Fix the hdmi@3d node by means of:
* Use default register addresses for "cec", "edid" and "packet", because
  there is no need to use a non-default address map.
* Add missing interrupt related properties.
* Drop "adi,input-*" properties which are only valid for adv751*.
* Add VDDEXT_3V3 fixed regulator
* Add "*-supply" properties, since most are required.
* Fix label names - s/adv7533/adv7535/.

Fixes: a27335b3f1e0 ("arm64: dts: imx8mm-evk: Add HDMI support")
Signed-off-by: Liu Ying <victor.liu@nxp.com>
Tested-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 32 ++++++++++++-------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index df8e808ac4739..6752c30274369 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -26,7 +26,7 @@
 
 		port {
 			hdmi_connector_in: endpoint {
-				remote-endpoint = <&adv7533_out>;
+				remote-endpoint = <&adv7535_out>;
 			};
 		};
 	};
@@ -72,6 +72,13 @@
 		enable-active-high;
 	};
 
+	reg_vddext_3v3: regulator-vddext-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDEXT_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm1 0 5000000 0>;
@@ -317,15 +324,16 @@
 
 	hdmi@3d {
 		compatible = "adi,adv7535";
-		reg = <0x3d>, <0x3c>, <0x3e>, <0x3f>;
-		reg-names = "main", "cec", "edid", "packet";
+		reg = <0x3d>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
 		adi,dsi-lanes = <4>;
-
-		adi,input-depth = <8>;
-		adi,input-colorspace = "rgb";
-		adi,input-clock = "1x";
-		adi,input-style = <1>;
-		adi,input-justification = "evenly";
+		avdd-supply = <&buck5_reg>;
+		dvdd-supply = <&buck5_reg>;
+		pvdd-supply = <&buck5_reg>;
+		a2vdd-supply = <&buck5_reg>;
+		v3p3-supply = <&reg_vddext_3v3>;
+		v1p2-supply = <&buck5_reg>;
 
 		ports {
 			#address-cells = <1>;
@@ -334,7 +342,7 @@
 			port@0 {
 				reg = <0>;
 
-				adv7533_in: endpoint {
+				adv7535_in: endpoint {
 					remote-endpoint = <&dsi_out>;
 				};
 			};
@@ -342,7 +350,7 @@
 			port@1 {
 				reg = <1>;
 
-				adv7533_out: endpoint {
+				adv7535_out: endpoint {
 					remote-endpoint = <&hdmi_connector_in>;
 				};
 			};
@@ -408,7 +416,7 @@
 			reg = <1>;
 
 			dsi_out: endpoint {
-				remote-endpoint = <&adv7533_in>;
+				remote-endpoint = <&adv7535_in>;
 				data-lanes = <1 2 3 4>;
 			};
 		};
-- 
2.40.1



