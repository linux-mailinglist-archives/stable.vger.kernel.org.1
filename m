Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9659879B8C9
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359203AbjIKWPr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbjIKOBe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:01:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39E9CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:01:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFB8C433C8;
        Mon, 11 Sep 2023 14:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440890;
        bh=4mg+ryVNLhQL+i7kqODLbghs+CW3GihIR7bNheDiPJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wuuLa9I+dYwEPDTU+CWNU8eWxyDG9+b8sT/A+lCnEVGg7+JnVfKSXqqOJ1bgNzT6+
         U4dvvW/jLDU6zdTPTNrG3JFvvtVl9BGcJZF2ZW/tKx318L9bapC6AHN6ch4hyF/6eO
         okVBfffQXZqWLE0WEbbq1iblriKoDYUfbUrUuZlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 221/739] arm64: dts: qcom: sm8250-edo: Rectify gpio-keys
Date:   Mon, 11 Sep 2023 15:40:20 +0200
Message-ID: <20230911134657.357255962@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit a422c6a91a667b309ca1a6c08b30dbfcf7d4e866 ]

Set up the corresponding GPIOs properly and add the leftover hardware
buttons to mark this piece of the puzzle complete.

Fixes: 46e14907c716 ("arm64: dts: qcom: sm8250-edo: Add hardware keys")
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230614-topic-edo_pinsgpiopmic-v2-4-6f90bba54c53@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../qcom/sm8250-sony-xperia-edo-pdx206.dts    | 10 ++++
 .../boot/dts/qcom/sm8250-sony-xperia-edo.dtsi | 54 ++++++++++++++++---
 2 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
index ea4571bf4fbf0..58a521046f5f5 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
@@ -20,6 +20,8 @@ &framebuffer {
 };
 
 &gpio_keys {
+	pinctrl-0 = <&focus_n &snapshot_n &vol_down_n &g_assist_n>;
+
 	g-assist-key {
 		label = "Google Assistant Key";
 		linux,code = <KEY_LEFTMETA>;
@@ -48,6 +50,14 @@ &pm8150_gpios {
 			  "SP_ARI_PWR_ALARM",
 			  "NC",
 			  "NC"; /* GPIO_10 */
+
+	g_assist_n: g-assist-n-state {
+		pins = "gpio6";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
 };
 
 &pm8150b_gpios {
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index 8ab82bacba81f..4727a4e0fc95b 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -51,12 +51,26 @@ framebuffer: framebuffer@9c000000 {
 	gpio_keys: gpio-keys {
 		compatible = "gpio-keys";
 
-		/*
-		 * Camera focus (light press) and camera snapshot (full press)
-		 * seem not to work properly.. Adding the former one stalls the CPU
-		 * and the latter kills the volume down key for whatever reason. In any
-		 * case, they are both on &pm8150b_gpios: camera focus(2), camera snapshot(1).
-		 */
+		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n>;
+		pinctrl-names = "default";
+
+		key-camera-focus {
+			label = "Camera Focus";
+			linux,code = <KEY_CAMERA_FOCUS>;
+			gpios = <&pm8150b_gpios 2 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			gpio-key,wakeup;
+		};
+
+		key-camera-snapshot {
+			label = "Camera Snapshot";
+			linux,code = <KEY_CAMERA>;
+			gpios = <&pm8150b_gpios 1 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			gpio-key,wakeup;
+		};
 
 		key-vol-down {
 			label = "Volume Down";
@@ -551,6 +565,34 @@ &pcie2_phy {
 	vdda-pll-supply = <&vreg_l9a_1p2>;
 };
 
+&pm8150_gpios {
+	vol_down_n: vol-down-n-state {
+		pins = "gpio1";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&pm8150b_gpios {
+	snapshot_n: snapshot-n-state {
+		pins = "gpio1";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+
+	focus_n: focus-n-state {
+		pins = "gpio2";
+		function = "normal";
+		power-source = <0>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
 &pon_pwrkey {
 	status = "okay";
 };
-- 
2.40.1



