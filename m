Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD62E73E835
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjFZSXu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjFZSXZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:23:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06672269E
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E52D60E76
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699CAC433C8;
        Mon, 26 Jun 2023 18:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803693;
        bh=7PKezqBwVf2n/vLQqNTcNM58UvcVlGXiRTaYp1oOv5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pimE9lhBHmxSrdDcydNG+uB6bEjznULC0wsoCzMNjvu9GjDinwSvLw17fBeU+Y/EW
         21TJN/CtE+rNhzlB6ZOF7EbEFxmdL58vAPItliaAc4ZOIqHKno6FXaSx5VLQjr9AP+
         UUapKcZCKdJUZ82UiYk/4Ok1BJzTyWllI3OIjYrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 145/199] arm64: dts: rockchip: fix nEXTRST on SOQuartz
Date:   Mon, 26 Jun 2023 20:10:51 +0200
Message-ID: <20230626180811.974318515@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

[ Upstream commit cf9ae4a0077496e8224d68fc88e3df13dd7e5f37 ]

In pre-production prototypes (of which I only know one person
having one, Peter Geis), GPIO0 pin A5 was tied to the SDMMC
power enable pin on the CM4 connector. On all production models,
this is not the case; instead, this pin is used for the nEXTRST
signal, and the SDMMC power enable pin is always pulled high.

Since everyone currently using the SOQuartz device trees will
want this change, it is made to the tree without splitting the
trees into two separate ones of which users will then inevitably
choose the wrong one.

This fixes USB and PCIe on a wide variety of CM4IO-compatible
boards which use the nEXTRST signal.

Fixes: 5859b5a9c3ac ("arm64: dts: rockchip: add SoQuartz CM4IO dts")
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Link: https://lore.kernel.org/r/20230421152610.21688-1-frattaroli.nicolas@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/rockchip/rk3566-soquartz-cm4.dts | 18 +++++++-----
 .../boot/dts/rockchip/rk3566-soquartz.dtsi    | 29 +++++++++----------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
index 263ce40770dde..cddf6cd2fecb1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
@@ -28,6 +28,16 @@
 		regulator-max-microvolt = <5000000>;
 		vin-supply = <&vcc12v_dcin>;
 	};
+
+	vcc_sd_pwr: vcc-sd-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sd_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
 };
 
 /* phy for pcie */
@@ -130,13 +140,7 @@
 };
 
 &sdmmc0 {
-	vmmc-supply = <&sdmmc_pwr>;
-	status = "okay";
-};
-
-&sdmmc_pwr {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
+	vmmc-supply = <&vcc_sd_pwr>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
index 102e448bc026a..31aa2b8efe393 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -104,16 +104,6 @@
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
-
-	sdmmc_pwr: sdmmc-pwr-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdmmc_pwr_h>;
-		regulator-name = "sdmmc_pwr";
-		status = "disabled";
-	};
 };
 
 &cpu0 {
@@ -155,6 +145,19 @@
 	status = "disabled";
 };
 
+&gpio0 {
+	nextrst-hog {
+		gpio-hog;
+		/*
+		 * GPIO_ACTIVE_LOW + output-low here means that the pin is set
+		 * to high, because output-low decides the value pre-inversion.
+		 */
+		gpios = <RK_PA5 GPIO_ACTIVE_LOW>;
+		line-name = "nEXTRST";
+		output-low;
+	};
+};
+
 &gpu {
 	mali-supply = <&vdd_gpu>;
 	status = "okay";
@@ -538,12 +541,6 @@
 			rockchip,pins = <2 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
-
-	sdmmc-pwr {
-		sdmmc_pwr_h: sdmmc-pwr-h {
-			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
 };
 
 &pmu_io_domains {
-- 
2.39.2



