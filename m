Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CAF7DD4F1
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376265AbjJaRpl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376261AbjJaRpj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:45:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4766BE8
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:45:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBF8C433C7;
        Tue, 31 Oct 2023 17:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774336;
        bh=2kzqAkCYblEV2oGF6wkXM62iy4h6CDncVwUQ2tbXReQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omWFsUinstBuDpPCL1MBPvrt4wJo7tuUYTuW58Q5Jn6VJZ34QSVEzfPgHUivRIup8
         K19h5bEFLdQKOxjo5IqGmjnChmcRefh2r06HWRA2xkWgvCROUaH+GvirfyQcWVFwTX
         Q98y9Kop9p5l2GnEyZXmaMnnK5JcpWX/Zh7iGbIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.5 016/112] arm64: dts: qcom: msm8996-xiaomi: fix missing clock populate
Date:   Tue, 31 Oct 2023 18:00:17 +0100
Message-ID: <20231031165901.822122573@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 725f593692ceedeab639b661298955b6f9ba8ec3 upstream.

Commit 338958e30c68 ("arm64: dts: qcom: msm8996-xiaomi: drop simple-bus
from clocks") removed "simple-bus" compatible from "clocks" node, but
one of the clocks - divclk1 - is a gpio-gate-clock, which does not have
CLK_OF_DECLARE.  This means it will not be instantiated if placed in
some subnode.  Move the clocks to the root node, so regular devices will
be populated.

Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Closes: https://lore.kernel.org/all/CAA8EJprF==p87oN+RiwAiNeURF1JcHGfL2Ez5zxqYPRRbN-hhg@mail.gmail.com/
Cc: stable@vger.kernel.org
Fixes: 338958e30c68 ("arm64: dts: qcom: msm8996-xiaomi: drop simple-bus from clocks")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20230901081812.19121-2-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../boot/dts/qcom/msm8996-xiaomi-common.dtsi  | 32 +++++++++----------
 .../boot/dts/qcom/msm8996-xiaomi-gemini.dts   | 18 +++++------
 2 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
index bcd2397eb373..06f8ff624181 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
@@ -11,26 +11,24 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
-	clocks {
-		divclk1_cdc: divclk1 {
-			compatible = "gpio-gate-clock";
-			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
-			#clock-cells = <0>;
-			enable-gpios = <&pm8994_gpios 15 GPIO_ACTIVE_HIGH>;
+	divclk1_cdc: divclk1 {
+		compatible = "gpio-gate-clock";
+		clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
+		#clock-cells = <0>;
+		enable-gpios = <&pm8994_gpios 15 GPIO_ACTIVE_HIGH>;
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&divclk1_default>;
-		};
+		pinctrl-names = "default";
+		pinctrl-0 = <&divclk1_default>;
+	};
 
-		divclk4: divclk4 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-			clock-output-names = "divclk4";
+	divclk4: divclk4 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "divclk4";
 
-			pinctrl-names = "default";
-			pinctrl-0 = <&divclk4_pin_a>;
-		};
+		pinctrl-names = "default";
+		pinctrl-0 = <&divclk4_pin_a>;
 	};
 
 	gpio-keys {
diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
index d1066edaea47..f8e9d90afab0 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts
@@ -20,16 +20,14 @@ / {
 	qcom,pmic-id = <0x20009 0x2000a 0x00 0x00>;
 	qcom,board-id = <31 0>;
 
-	clocks {
-		divclk2_haptics: divclk2 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <32768>;
-			clock-output-names = "divclk2";
-
-			pinctrl-names = "default";
-			pinctrl-0 = <&divclk2_pin_a>;
-		};
+	divclk2_haptics: divclk2 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "divclk2";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&divclk2_pin_a>;
 	};
 };
 
-- 
2.42.0



