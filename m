Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3B37A7AF8
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjITLsA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjITLr6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:47:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C9CB4
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:47:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E594DC433C7;
        Wed, 20 Sep 2023 11:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210472;
        bh=NptdzZPkC+s8zSKynUER9agfpeplYLjaD7q80hnYJho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GnogxbKJrB4t0PumNUMA7Fmi//lifzDgNX9Zjr9fhfDc9vrK8+xqrPFOxoA6QJZAv
         XygdifP6KFfkZqer7PSuKAUy3vGRrBz7kNrQ3nqcDchZ/1hWDKS9/vuXxilkfOb73+
         ndCGQhF//uO7hWJb3Pk6w/PUCuKHogwIBemQ89yI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 089/211] arm64: dts: qcom: sc8280xp-x13s: Add camera activity LED
Date:   Wed, 20 Sep 2023 13:28:53 +0200
Message-ID: <20230920112848.573091499@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

[ Upstream commit 1c63dd1c5fdafa8854526d7d60d2b741c813678d ]

Disappointigly, the camera activity LED is implemented in software.
Hook it up as a gpio-led and (until we have camera *and* a "camera on"
LED trigger) configure it as a panic indicator.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230805-topic-x13s_cam_led-v1-1-443d752158c4@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 059dfccdfe7c2..b51787b6561d7 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -12,6 +12,7 @@
 #include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sc8280xp.dtsi"
@@ -78,6 +79,21 @@ switch-lid {
 		};
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led-camera-indicator {
+			label = "white:camera-indicator";
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_WHITE>;
+			gpios = <&tlmm 28 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "none";
+			default-state = "off";
+			/* Reuse as a panic indicator until we get a "camera on" trigger */
+			panic-indicator;
+		};
+	};
+
 	pmic-glink {
 		compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
 
-- 
2.40.1



