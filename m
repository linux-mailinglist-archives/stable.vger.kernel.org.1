Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4154873E921
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjFZSct (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjFZSci (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:32:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCE810E2
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C5CC60F39
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E32C433C8;
        Mon, 26 Jun 2023 18:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804356;
        bh=ZYGApEylCF+SC6ULFh+ZVTcwL8rOxJfB8prOZi2Q9/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vyz0uODPD+HmMQcj17LWJz1SqTv4r5STBqQf/A3RKdmPJdbufEnbCtZ+WEMgKGMpt
         1kKtYcnkk3XPt+TKb/SF8PwhhGAkga5U03vy7l7eWDdwOaIV0lRDuNIVxYy54JPjfq
         CEESjkQqxB0MfIcEIeVYNKVie+tDaTjsDKFKEfts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 128/170] arm64: dts: rockchip: fix nEXTRST on SOQuartz
Date:   Mon, 26 Jun 2023 20:11:37 +0200
Message-ID: <20230626180806.305285237@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index e00568a6be5cc..6ba562b922e6c 100644
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
 
 &gmac1 {
@@ -119,13 +129,7 @@
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
index 4ceb9a979f6ad..ba56ca2e66c8d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -92,16 +92,6 @@
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
@@ -143,6 +133,19 @@
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
@@ -485,12 +488,6 @@
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



