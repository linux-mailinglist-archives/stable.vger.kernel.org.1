Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9886679B5A0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358288AbjIKWI3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238672AbjIKOCX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:02:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36800CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:02:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C056C433C8;
        Mon, 11 Sep 2023 14:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440935;
        bh=USkA6PRYOkaNd7Hlu4Q27q7z21uBe2wuyXgg6tffenY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2eq4DrtzncBkHMj6CRcn2BUGUDPUG57lqA4etSMzzEbWphGvzNhbYr+Mgu2uxjhCx
         WTMutC8iep5d53KSDmCl+MJtwq74GC/oycMF1BcdlX/V9QHOCz0ZxNJAPUm5+3kKg+
         IWxKF9a6rAO9eyKjEGfAMTI481uigaXOnYNQS9z4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 238/739] arm64: dts: qcom: minor whitespace cleanup around =
Date:   Mon, 11 Sep 2023 15:40:37 +0200
Message-ID: <20230911134657.811425408@linuxfoundation.org>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 934a3b4d5a2d4c265ca22d3cf471a72ec8d9ee65 ]

The DTS code coding style expects exactly one space before and after '='
sign.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230702185051.43867-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: 4cb19bd7c632 ("arm64: dts: qcom: sm8250: Mark SMMUs as DMA coherent")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |   8 +-
 .../dts/qcom/msm8916-samsung-serranove.dts    |   6 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi         |  12 +-
 .../boot/dts/qcom/msm8953-xiaomi-daisy.dts    |   2 +-
 .../boot/dts/qcom/msm8953-xiaomi-vince.dts    |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |   6 +-
 .../dts/qcom/msm8996pro-xiaomi-natrium.dts    |   2 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         |  18 +-
 arch/arm64/boot/dts/qcom/qcm2290.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |   8 +-
 arch/arm64/boot/dts/qcom/sa8540p.dtsi         |   2 +-
 .../sc7280-herobrine-audio-rt5682-3mic.dtsi   |   2 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/sc8180x.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/sdm630.dtsi          |  10 +-
 .../dts/qcom/sdm845-oneplus-enchilada.dts     |   2 +-
 arch/arm64/boot/dts/qcom/sdx75.dtsi           |   4 +-
 arch/arm64/boot/dts/qcom/sm6115.dtsi          |   2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 198 +++++++++---------
 arch/arm64/boot/dts/qcom/sm8350.dtsi          | 196 ++++++++---------
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 194 ++++++++---------
 arch/arm64/boot/dts/qcom/sm8550.dtsi          | 196 ++++++++---------
 22 files changed, 438 insertions(+), 438 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 68839acbd613f..00ed71936b472 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -794,10 +794,10 @@ frame@b128000 {
 
 		pcie1: pci@10000000 {
 			compatible = "qcom,pcie-ipq8074";
-			reg =  <0x10000000 0xf1d>,
-			       <0x10000f20 0xa8>,
-			       <0x00088000 0x2000>,
-			       <0x10100000 0x1000>;
+			reg = <0x10000000 0xf1d>,
+			      <0x10000f20 0xa8>,
+			      <0x00088000 0x2000>,
+			      <0x10100000 0x1000>;
 			reg-names = "dbi", "elbi", "parf", "config";
 			device_type = "pci";
 			linux,pci-domain = <1>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 15dc246e84e2b..126e8b5cf49fd 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -219,9 +219,9 @@ magnetometer@2e {
 		compatible = "yamaha,yas537";
 		reg = <0x2e>;
 
-		mount-matrix =  "0",  "1",  "0",
-				"1",  "0",  "0",
-				"0",  "0", "-1";
+		mount-matrix = "0",  "1",  "0",
+			       "1",  "0",  "0",
+			       "0",  "0", "-1";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 3d9270b5482b4..559a5d1ba615b 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -1646,7 +1646,7 @@ sdhc_2: mmc@7864900 {
 			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
 				 <&gcc GCC_SDCC2_APPS_CLK>,
 				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
-			clock-names =  "iface", "core", "xo";
+			clock-names = "iface", "core", "xo";
 			resets = <&gcc GCC_SDCC2_BCR>;
 			pinctrl-0 = <&sdc2_default>;
 			pinctrl-1 = <&sdc2_sleep>;
@@ -1733,7 +1733,7 @@ blsp_i2c2: i2c@78b6000 {
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
-			clock-names =  "core", "iface";
+			clock-names = "core", "iface";
 			dmas = <&blsp_dma 6>, <&blsp_dma 7>;
 			dma-names = "tx", "rx";
 			pinctrl-0 = <&blsp_i2c2_default>;
@@ -1767,7 +1767,7 @@ blsp_i2c3: i2c@78b7000 {
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
-			clock-names =  "core", "iface";
+			clock-names = "core", "iface";
 			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
 			dma-names = "tx", "rx";
 			pinctrl-0 = <&blsp_i2c3_default>;
@@ -1801,7 +1801,7 @@ blsp_i2c4: i2c@78b8000 {
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
-			clock-names =  "core", "iface";
+			clock-names = "core", "iface";
 			dmas = <&blsp_dma 10>, <&blsp_dma 11>;
 			dma-names = "tx", "rx";
 			pinctrl-0 = <&blsp_i2c4_default>;
@@ -1835,7 +1835,7 @@ blsp_i2c5: i2c@78b9000 {
 			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
-			clock-names =  "core", "iface";
+			clock-names = "core", "iface";
 			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
 			dma-names = "tx", "rx";
 			pinctrl-0 = <&blsp_i2c5_default>;
@@ -1869,7 +1869,7 @@ blsp_i2c6: i2c@78ba000 {
 			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
-			clock-names =  "core", "iface";
+			clock-names = "core", "iface";
 			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
 			dma-names = "tx", "rx";
 			pinctrl-0 = <&blsp_i2c6_default>;
diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
index 1d672e6086532..790d19c99af14 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-daisy.dts
@@ -17,7 +17,7 @@ / {
 	compatible = "xiaomi,daisy", "qcom,msm8953";
 	chassis-type = "handset";
 	qcom,msm-id = <293 0>;
-	qcom,board-id= <0x1000b 0x9>;
+	qcom,board-id = <0x1000b 0x9>;
 
 	chosen {
 		#address-cells = <2>;
diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
index b5be55034fd36..0956c866d6cb1 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
@@ -20,7 +20,7 @@ / {
 	compatible = "xiaomi,vince", "qcom,msm8953";
 	chassis-type = "handset";
 	qcom,msm-id = <293 0>;
-	qcom,board-id= <0x1000b 0x08>;
+	qcom,board-id = <0x1000b 0x08>;
 
 	gpio-keys {
 		compatible = "gpio-keys";
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index dd5f2b9677832..8a0561f1820f5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1138,9 +1138,9 @@ mdss_dsi1_phy: phy@996400 {
 
 			hdmi: hdmi-tx@9a0000 {
 				compatible = "qcom,hdmi-tx-8996";
-				reg =	<0x009a0000 0x50c>,
-					<0x00070000 0x6158>,
-					<0x009e0000 0xfff>;
+				reg = <0x009a0000 0x50c>,
+				      <0x00070000 0x6158>,
+				      <0x009e0000 0xfff>;
 				reg-names = "core_physical",
 					    "qfprom_physical",
 					    "hdcp_physical";
diff --git a/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dts b/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dts
index 7957c8823f0d5..5e3fd1637f449 100644
--- a/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996pro-xiaomi-natrium.dts
@@ -106,7 +106,7 @@ &slpi_pil {
 &sound {
 	compatible = "qcom,apq8096-sndcard";
 	model = "natrium";
-	audio-routing =	"RX_BIAS", "MCLK";
+	audio-routing = "RX_BIAS", "MCLK";
 
 	mm1-dai-link {
 		link-name = "MultiMedia1";
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f0e943ff00464..d5cb244d00d0e 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -909,10 +909,10 @@ anoc2_smmu: iommu@16c0000 {
 
 		pcie0: pci@1c00000 {
 			compatible = "qcom,pcie-msm8998", "qcom,pcie-msm8996";
-			reg =	<0x01c00000 0x2000>,
-				<0x1b000000 0xf1d>,
-				<0x1b000f20 0xa8>,
-				<0x1b100000 0x100000>;
+			reg = <0x01c00000 0x2000>,
+			      <0x1b000000 0xf1d>,
+			      <0x1b000f20 0xa8>,
+			      <0x1b100000 0x100000>;
 			reg-names = "parf", "dbi", "elbi", "config";
 			device_type = "pci";
 			linux,pci-domain = <0>;
@@ -2074,11 +2074,11 @@ sram@290000 {
 
 		spmi_bus: spmi@800f000 {
 			compatible = "qcom,spmi-pmic-arb";
-			reg =	<0x0800f000 0x1000>,
-				<0x08400000 0x1000000>,
-				<0x09400000 0x1000000>,
-				<0x0a400000 0x220000>,
-				<0x0800a000 0x3000>;
+			reg = <0x0800f000 0x1000>,
+			      <0x08400000 0x1000000>,
+			      <0x09400000 0x1000000>,
+			      <0x0a400000 0x220000>,
+			      <0x0800a000 0x3000>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
 			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 0ed11e80e5e29..1d1de156f8f04 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -790,7 +790,7 @@ gpi_dma0: dma-controller@4a00000 {
 				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
-			dma-channels =  <10>;
+			dma-channels = <10>;
 			dma-channel-mask = <0x1f>;
 			iommus = <&apps_smmu 0xf6 0x0>;
 			#dma-cells = <3>;
diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 972f753847e13..f2568aff14c84 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -1459,10 +1459,10 @@ glink-edge {
 
 		pcie: pci@10000000 {
 			compatible = "qcom,pcie-qcs404";
-			reg =  <0x10000000 0xf1d>,
-			       <0x10000f20 0xa8>,
-			       <0x07780000 0x2000>,
-			       <0x10001000 0x2000>;
+			reg = <0x10000000 0xf1d>,
+			      <0x10000f20 0xa8>,
+			      <0x07780000 0x2000>,
+			      <0x10001000 0x2000>;
 			reg-names = "dbi", "elbi", "parf", "config";
 			device_type = "pci";
 			linux,pci-domain = <0>;
diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
index bacbdec562814..96b2c59ad02b4 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
@@ -207,7 +207,7 @@ &pcie3a {
 
 	linux,pci-domain = <2>;
 
-	interrupts =  <GIC_SPI 567 IRQ_TYPE_LEVEL_HIGH>;
+	interrupts = <GIC_SPI 567 IRQ_TYPE_LEVEL_HIGH>;
 	interrupt-names = "msi";
 
 	interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 541 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
index 485f9942e1285..a90c70b1b73ea 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682-3mic.dtsi
@@ -13,7 +13,7 @@ sound: sound {
 		compatible = "google,sc7280-herobrine";
 		model = "sc7280-rt5682-max98360a-3mic";
 
-		audio-routing =	"VA DMIC0", "vdd-micb",
+		audio-routing = "VA DMIC0", "vdd-micb",
 				"VA DMIC1", "vdd-micb",
 				"VA DMIC2", "vdd-micb",
 				"VA DMIC3", "vdd-micb",
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index a0e8db8270e7a..925428a5f6aea 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2449,7 +2449,7 @@ lpass_cpu: audio@3987000 {
 				 <&apps_smmu 0x1821 0>,
 				 <&apps_smmu 0x1832 0>;
 
-			power-domains =	<&rpmhpd SC7280_LCX>;
+			power-domains = <&rpmhpd SC7280_LCX>;
 			power-domain-names = "lcx";
 			required-opps = <&rpmhpd_opp_nom>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index e58f931c2e459..363f438ff6059 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2252,7 +2252,7 @@ opp-177000000 {
 		};
 
 		gmu: gmu@2c6a000 {
-			compatible="qcom,adreno-gmu-680.1", "qcom,adreno-gmu";
+			compatible = "qcom,adreno-gmu-680.1", "qcom,adreno-gmu";
 
 			reg = <0 0x02c6a000 0 0x30000>,
 			      <0 0x0b290000 0 0x10000>,
diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index bba0f366ef03b..759b3a5964cc9 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1196,11 +1196,11 @@ sram@290000 {
 
 		spmi_bus: spmi@800f000 {
 			compatible = "qcom,spmi-pmic-arb";
-			reg =	<0x0800f000 0x1000>,
-				<0x08400000 0x1000000>,
-				<0x09400000 0x1000000>,
-				<0x0a400000 0x220000>,
-				<0x0800a000 0x3000>;
+			reg = <0x0800f000 0x1000>,
+			      <0x08400000 0x1000000>,
+			      <0x09400000 0x1000000>,
+			      <0x0a400000 0x220000>,
+			      <0x0800a000 0x3000>;
 			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
 			interrupt-names = "periph_irq";
 			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
index 623a826b18a3e..62fe72ff37630 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
@@ -57,7 +57,7 @@ &pmi8998_charger {
 
 &sound {
 	model = "OnePlus 6";
-	audio-routing =	"RX_BIAS", "MCLK",
+	audio-routing = "RX_BIAS", "MCLK",
 			"AMIC2", "MIC BIAS2",
 			"AMIC3", "MIC BIAS4",
 			"AMIC4", "MIC BIAS1",
diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
index 21d5d55da5ebf..7d39a615f4f78 100644
--- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
@@ -484,14 +484,14 @@ qupv3_se1_2uart_active: qupv3-se1-2uart-active-state {
 				tx-pins {
 					pins = "gpio12";
 					function = "qup_se1_l2_mira";
-					drive-strength= <2>;
+					drive-strength = <2>;
 					bias-disable;
 				};
 
 				rx-pins {
 					pins = "gpio13";
 					function = "qup_se1_l3_mira";
-					drive-strength= <2>;
+					drive-strength = <2>;
 					bias-disable;
 				};
 			};
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 55118577bf923..7d30b504441ad 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1052,7 +1052,7 @@ gpi_dma0: dma-controller@4a00000 {
 				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
-			dma-channels =  <10>;
+			dma-channels = <10>;
 			dma-channel-mask = <0xf>;
 			iommus = <&apps_smmu 0xf6 0x0>;
 			#dma-cells = <3>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 9b77aa7d0c1e1..b811592f9b759 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3062,7 +3062,7 @@ in-ports {
 				port@7 {
 					reg = <7>;
 					funnel_swao_in_funnel_merg: endpoint {
-						remote-endpoint= <&funnel_merg_out_funnel_swao>;
+						remote-endpoint = <&funnel_merg_out_funnel_swao>;
 					};
 				};
 			};
@@ -5301,104 +5301,104 @@ apps_smmu: iommu@15000000 {
 			reg = <0 0x15000000 0 0x100000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
-			interrupts =    <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		adsp: remoteproc@17300000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 435a807841158..c236967725c1b 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -3077,104 +3077,104 @@ apps_smmu: iommu@15000000 {
 			reg = <0 0x15000000 0 0x100000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
-			interrupts =    <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		adsp: remoteproc@17300000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 1c71c0a2cd811..42b23ba7a573f 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3810,103 +3810,103 @@ apps_smmu: iommu@15000000 {
 			reg = <0 0x15000000 0 0x100000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
-			interrupts =    <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		intc: interrupt-controller@17100000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 41d60af936920..6e8aba2569316 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1600,7 +1600,7 @@ uart7: serial@a9c000 {
 				pinctrl-0 = <&qup_uart7_default>;
 				interrupts = <GIC_SPI 579 IRQ_TYPE_LEVEL_HIGH>;
 				interconnect-names = "qup-core", "qup-config";
-				interconnects =	<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
+				interconnects = <&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
 						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
 				status = "disabled";
 			};
@@ -3517,103 +3517,103 @@ apps_smmu: iommu@15000000 {
 			reg = <0 0x15000000 0 0x100000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <1>;
-			interrupts =	<GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 706 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 689 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 706 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 689 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		intc: interrupt-controller@17100000 {
-- 
2.40.1



