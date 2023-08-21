Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1BE7832AC
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjHUT4d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjHUT4d (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:56:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92117D3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE0A56460B
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873D0C433C7;
        Mon, 21 Aug 2023 19:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647788;
        bh=JGNYzMgKzQPZ78O0Bvefa6wTKzu7OZ1KPUwMrLfvvpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dOLP0cD0rVnjgHi5pN1wM4Vo7v09lFDIjpssubmHfwziWX0yG/yxBwJglaSpK43lE
         CxdNlq+z0rUf07FBEVmfawjdN0pdelckQswGCn3p+6jqYSo51Iw04pMg46JIgxltcY
         n/QrMcWqGLfQZHYnZseQ+M1XBpxy7ZIVomP+ayxE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 139/194] ARM: dts: imx: align LED node names with dtschema
Date:   Mon, 21 Aug 2023 21:41:58 +0200
Message-ID: <20230821194128.803256503@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 4b0d1f2738899dbcc7a026d826373530019aa31b ]

The node names should be generic and DT schema expects certain pattern:

  imx50-kobo-aura.dtb: gpio-leds: 'on' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
  imx6dl-yapp4-draco.dtb: led-controller@30: 'chan@0', 'chan@1', 'chan@2' do not match any of the regexes: '^led@[0-8]$', '^multi-led@[0-8]$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: 762b700982a1 ("ARM: dts: imx6: phytec: fix RTC interrupt level")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx50-kobo-aura.dts            |  2 +-
 arch/arm/boot/dts/imx53-cx9020.dts               | 10 +++++-----
 arch/arm/boot/dts/imx53-m53evk.dts               |  4 ++--
 arch/arm/boot/dts/imx53-m53menlo.dts             |  6 +++---
 arch/arm/boot/dts/imx53-tx53.dtsi                |  2 +-
 arch/arm/boot/dts/imx53-usbarmory.dts            |  2 +-
 arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6dl-riotboard.dts           |  4 ++--
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi       |  6 +++---
 arch/arm/boot/dts/imx6q-gw5400-a.dts             |  6 +++---
 arch/arm/boot/dts/imx6q-h100.dts                 |  6 +++---
 arch/arm/boot/dts/imx6q-kp.dtsi                  |  4 ++--
 arch/arm/boot/dts/imx6q-marsboard.dts            |  4 ++--
 arch/arm/boot/dts/imx6q-tbs2910.dts              |  2 +-
 arch/arm/boot/dts/imx6qdl-emcon.dtsi             |  4 ++--
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi            |  4 ++--
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi            |  2 +-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi            |  4 ++--
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi            |  2 +-
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw5907.dtsi            |  4 ++--
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw5912.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw5913.dtsi            |  4 ++--
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi         | 10 +++++-----
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi     |  4 ++--
 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi       |  6 +++---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi     |  4 ++--
 arch/arm/boot/dts/imx6qdl-rex.dtsi               |  2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi         |  2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi           |  2 +-
 arch/arm/boot/dts/imx6qdl-ts7970.dtsi            |  4 ++--
 arch/arm/boot/dts/imx6qdl-tx6.dtsi               |  2 +-
 arch/arm/boot/dts/imx6sl-evk.dts                 |  2 +-
 arch/arm/boot/dts/imx6sll-evk.dts                |  2 +-
 arch/arm/boot/dts/imx6sx-sabreauto.dts           |  2 +-
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi           |  4 ++--
 arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi |  2 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi              |  2 +-
 44 files changed, 93 insertions(+), 93 deletions(-)

diff --git a/arch/arm/boot/dts/imx50-kobo-aura.dts b/arch/arm/boot/dts/imx50-kobo-aura.dts
index 51bf6117fb124..467db6b4ed7f8 100644
--- a/arch/arm/boot/dts/imx50-kobo-aura.dts
+++ b/arch/arm/boot/dts/imx50-kobo-aura.dts
@@ -26,7 +26,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_leds>;
 
-		on {
+		led-on {
 			label = "kobo_aura:orange:on";
 			gpios = <&gpio6 24 GPIO_ACTIVE_LOW>;
 			panic-indicator;
diff --git a/arch/arm/boot/dts/imx53-cx9020.dts b/arch/arm/boot/dts/imx53-cx9020.dts
index cfb18849a92b4..055d23a9aee7c 100644
--- a/arch/arm/boot/dts/imx53-cx9020.dts
+++ b/arch/arm/boot/dts/imx53-cx9020.dts
@@ -86,27 +86,27 @@
 	leds {
 		compatible = "gpio-leds";
 
-		pwr-r {
+		led-pwr-r {
 			gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		pwr-g {
+		led-pwr-g {
 			gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 
-		pwr-b {
+		led-pwr-b {
 			gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		sd1-b {
+		led-sd1-b {
 			linux,default-trigger = "mmc0";
 			gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
 		};
 
-		sd2-b {
+		led-sd2-b {
 			linux,default-trigger = "mmc1";
 			gpios = <&gpio3 17 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index a1a6228d1aa66..2bd2432d317ff 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -52,13 +52,13 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&led_pin_gpio>;
 
-		user1 {
+		led-user1 {
 			label = "user1";
 			gpios = <&gpio2 8 0>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		user2 {
+		led-user2 {
 			label = "user2";
 			gpios = <&gpio2 9 0>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx53-m53menlo.dts b/arch/arm/boot/dts/imx53-m53menlo.dts
index d5c68d1ea707c..4d77b6077fc1b 100644
--- a/arch/arm/boot/dts/imx53-m53menlo.dts
+++ b/arch/arm/boot/dts/imx53-m53menlo.dts
@@ -34,19 +34,19 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		user1 {
+		led-user1 {
 			label = "TestLed601";
 			gpios = <&gpio6 1 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
 		};
 
-		user2 {
+		led-user2 {
 			label = "TestLed602";
 			gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		eth {
+		led-eth {
 			label = "EthLedYe";
 			gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "netdev";
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 892dd1a4bac35..a439a47fb65ac 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -94,7 +94,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_stk5led>;
 
-		user {
+		led-user {
 			label = "Heartbeat";
 			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx53-usbarmory.dts b/arch/arm/boot/dts/imx53-usbarmory.dts
index f34993a490ee8..acc44010d5106 100644
--- a/arch/arm/boot/dts/imx53-usbarmory.dts
+++ b/arch/arm/boot/dts/imx53-usbarmory.dts
@@ -67,7 +67,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		user {
+		led-user {
 			label = "LED";
 			gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi b/arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi
index 337db29b0010a..37697fac9dea9 100644
--- a/arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi
+++ b/arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi
@@ -211,17 +211,17 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_q7_gpio1 &pinctrl_q7_gpio3 &pinctrl_q7_gpio5>;
 
-		alarm1 {
+		led-alarm1 {
 			label = "alarm:red";
 			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 		};
 
-		alarm2 {
+		led-alarm2 {
 			label = "alarm:yellow";
 			gpios = <&gpio4 27 GPIO_ACTIVE_HIGH>;
 		};
 
-		alarm3 {
+		led-alarm3 {
 			label = "alarm:blue";
 			gpios = <&gpio4 15 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index e7be05f205d32..24c7f535f63bd 100644
--- a/arch/arm/boot/dts/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
@@ -25,14 +25,14 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio3 28 GPIO_ACTIVE_LOW>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index 52162e8c7274b..aacbf317feea6 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -274,7 +274,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		chan@0 {
+		led@0 {
 			chan-name = "R";
 			led-cur = /bits/ 8 <0x20>;
 			max-cur = /bits/ 8 <0x60>;
@@ -282,7 +282,7 @@
 			color = <LED_COLOR_ID_RED>;
 		};
 
-		chan@1 {
+		led@1 {
 			chan-name = "G";
 			led-cur = /bits/ 8 <0x20>;
 			max-cur = /bits/ 8 <0x60>;
@@ -290,7 +290,7 @@
 			color = <LED_COLOR_ID_GREEN>;
 		};
 
-		chan@2 {
+		led@2 {
 			chan-name = "B";
 			led-cur = /bits/ 8 <0x20>;
 			max-cur = /bits/ 8 <0x60>;
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index e894faba571f9..522a51042965a 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -34,20 +34,20 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* 102 -> MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>; /* 106 -> MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* 111 -> MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6q-h100.dts b/arch/arm/boot/dts/imx6q-h100.dts
index b8feadbff967d..6406ade14f57b 100644
--- a/arch/arm/boot/dts/imx6q-h100.dts
+++ b/arch/arm/boot/dts/imx6q-h100.dts
@@ -76,19 +76,19 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_h100_leds>;
 
-		led0: power {
+		led0: led-power {
 			label = "power";
 			gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 
-		led1: stream {
+		led1: led-stream {
 			label = "stream";
 			gpios = <&gpio2 29 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		led2: rec {
+		led2: led-rec {
 			label = "rec";
 			gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi b/arch/arm/boot/dts/imx6q-kp.dtsi
index 1ade0bff681d6..5e0ed55600405 100644
--- a/arch/arm/boot/dts/imx6q-kp.dtsi
+++ b/arch/arm/boot/dts/imx6q-kp.dtsi
@@ -66,14 +66,14 @@
 	leds {
 		compatible = "gpio-leds";
 
-		green {
+		led-green {
 			label = "led1";
 			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "gpio";
 			default-state = "off";
 		};
 
-		red {
+		led-red {
 			label = "led0";
 			gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "gpio";
diff --git a/arch/arm/boot/dts/imx6q-marsboard.dts b/arch/arm/boot/dts/imx6q-marsboard.dts
index cc18010023942..2c9961333b0a8 100644
--- a/arch/arm/boot/dts/imx6q-marsboard.dts
+++ b/arch/arm/boot/dts/imx6q-marsboard.dts
@@ -73,14 +73,14 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		user1 {
+		led-user1 {
 			label = "imx6:green:user1";
 			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 			linux,default-trigger = "heartbeat";
 		};
 
-		user2 {
+		led-user2 {
 			label = "imx6:green:user2";
 			gpios = <&gpio3 28 GPIO_ACTIVE_LOW>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index 8daef65d5bb35..2f576e2ce73f2 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -49,7 +49,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		blue {
+		led-blue {
 			label = "blue_status_led";
 			gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
 			default-state = "keep";
diff --git a/arch/arm/boot/dts/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
index 7228b894a763f..ee2dd75cead6d 100644
--- a/arch/arm/boot/dts/imx6qdl-emcon.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
@@ -46,14 +46,14 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_som_leds>;
 
-		green {
+		led-green {
 			label = "som:green";
 			gpios = <&gpio3 0 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			default-state = "on";
 		};
 
-		red {
+		led-red {
 			label = "som:red";
 			gpios = <&gpio3 1 GPIO_ACTIVE_LOW>;
 			default-state = "keep";
diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 069c27fab432c..e75e1a5364b85 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -71,14 +71,14 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 728810b9d677d..47d9a8d08197d 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -80,20 +80,20 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 6c0c109046d80..fb1d29abe0991 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -80,20 +80,20 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index a9b04f9f1c2bc..4e20cb97058eb 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -81,20 +81,20 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index 435dec6338fe6..0fa4b8eeddee7 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -115,7 +115,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 7 GPIO_ACTIVE_LOW>;
 			default-state = "on";
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index 2e61102ae6946..77ae611b817a4 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -72,20 +72,20 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
index 4662408b225a5..7f16c602cc075 100644
--- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
@@ -113,14 +113,14 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 11 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
index 4b81a975c979d..46cf4080fec38 100644
--- a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
@@ -139,20 +139,20 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
index 1fdb7ba630f1b..a74cde0501589 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
@@ -123,7 +123,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio6 14 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
index 612b6e068e282..9fc79af2bc9aa 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
@@ -120,20 +120,20 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw5907.dtsi b/arch/arm/boot/dts/imx6qdl-gw5907.dtsi
index fcd3bdfd61827..955a51226eda7 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5907.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5907.dtsi
@@ -71,14 +71,14 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
index 6bb4855d13ce5..218d6e667ed24 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
@@ -74,20 +74,20 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw5912.dtsi b/arch/arm/boot/dts/imx6qdl-gw5912.dtsi
index 0415bcb416400..40e235e315cc4 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5912.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5912.dtsi
@@ -72,20 +72,20 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw5913.dtsi b/arch/arm/boot/dts/imx6qdl-gw5913.dtsi
index 696427b487f01..82f47c295b085 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5913.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5913.dtsi
@@ -71,14 +71,14 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
index a53a5d0766a51..6d4eab1942b94 100644
--- a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
@@ -85,31 +85,31 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_leds>;
 
-		j14-pin1 {
+		led-j14-pin1 {
 			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
 			retain-state-suspended;
 			default-state = "off";
 		};
 
-		j14-pin3 {
+		led-j14-pin3 {
 			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 			retain-state-suspended;
 			default-state = "off";
 		};
 
-		j14-pins8-9 {
+		led-j14-pins8-9 {
 			gpios = <&gpio3 29 GPIO_ACTIVE_LOW>;
 			retain-state-suspended;
 			default-state = "off";
 		};
 
-		j46-pin2 {
+		led-j46-pin2 {
 			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
 			retain-state-suspended;
 			default-state = "off";
 		};
 
-		j46-pin3 {
+		led-j46-pin3 {
 			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 			retain-state-suspended;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index 57c21a01f126d..81a9a302aec1b 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -181,13 +181,13 @@
 	leds {
 		compatible = "gpio-leds";
 
-		speaker-enable {
+		led-speaker-enable {
 			gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
 			retain-state-suspended;
 			default-state = "off";
 		};
 
-		ttymxc4-rs232 {
+		led-ttymxc4-rs232 {
 			gpios = <&gpio6 10 GPIO_ACTIVE_HIGH>;
 			retain-state-suspended;
 			default-state = "on";
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
index 120d6e997a4c5..1a599c294ab86 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
@@ -25,17 +25,17 @@
 		pinctrl-0 = <&pinctrl_gpioleds>;
 		status = "disabled";
 
-		red {
+		led-red {
 			label = "phyboard-mira:red";
 			gpios = <&gpio5 22 GPIO_ACTIVE_HIGH>;
 		};
 
-		green {
+		led-green {
 			label = "phyboard-mira:green";
 			gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>;
 		};
 
-		blue {
+		led-blue {
 			label = "phyboard-mira:blue";
 			gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 768bc0e3a2b38..80adb2a02cc94 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -47,12 +47,12 @@
 		pinctrl-0 = <&pinctrl_leds>;
 		compatible = "gpio-leds";
 
-		led_green: green {
+		led_green: led-green {
 			label = "phyflex:green";
 			gpios = <&gpio1 30 0>;
 		};
 
-		led_red: red {
+		led_red: led-red {
 			label = "phyflex:red";
 			gpios = <&gpio2 31 0>;
 		};
diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi b/arch/arm/boot/dts/imx6qdl-rex.dtsi
index de514eb5aa99d..f804ff95a6ad6 100644
--- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
@@ -55,7 +55,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		led0: usr {
+		led0: led-usr {
 			label = "usr";
 			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 3dbb460ef102e..10886a1461bfb 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -21,7 +21,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		user {
+		led-user {
 			label = "debug";
 			gpios = <&gpio5 15 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 37482a9023fce..bcb83d52e26ed 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -130,7 +130,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		red {
+		led-red {
 			gpios = <&gpio1 2 0>;
 			default-state = "on";
 		};
diff --git a/arch/arm/boot/dts/imx6qdl-ts7970.dtsi b/arch/arm/boot/dts/imx6qdl-ts7970.dtsi
index c096d25a6f5b5..1e0a041e9f60a 100644
--- a/arch/arm/boot/dts/imx6qdl-ts7970.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-ts7970.dtsi
@@ -73,13 +73,13 @@
 			default-state = "off";
 		};
 
-		en-usb-5v {
+		en-usb-5v-led {
 			label = "en-usb-5v";
 			gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 
-		sel_dc_usb {
+		sel-dc-usb-led {
 			label = "sel_dc_usb";
 			gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index f41f86a76ea95..a197bac95cbac 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -92,7 +92,7 @@
 	leds {
 		compatible = "gpio-leds";
 
-		user_led: user {
+		user_led: led-user {
 			label = "Heartbeat";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_user_led>;
diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index f16c830f1e918..dc5d596c18db4 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -33,7 +33,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		user {
+		led-user {
 			label = "debug";
 			gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 32b3d82fec53c..269092ac881c5 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -37,7 +37,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		user {
+		led-user {
 			label = "debug";
 			gpios = <&gpio2 4 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 83ee97252ff11..b0c27b9b02446 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -20,7 +20,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		user {
+		led-user {
 			label = "debug";
 			gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
index c84ea1fac5e98..725d0b5cb55f6 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
@@ -15,14 +15,14 @@
 	leds {
 		compatible = "gpio-leds";
 
-		red {
+		led-red {
 			label = "udoo-neo:red:mmc";
 			gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 			linux,default-trigger = "mmc0";
 		};
 
-		orange {
+		led-orange {
 			label = "udoo-neo:orange:user";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;
 			default-state = "keep";
diff --git a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
index 3cddc68917a08..e4d2652a75c0b 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
@@ -30,7 +30,7 @@
 		pinctrl-0 = <&pinctrl_gpioleds_som>;
 		compatible = "gpio-leds";
 
-		phycore-green {
+		led-phycore-green {
 			gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index 15ee0275feaff..70cef5e817bd1 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -131,7 +131,7 @@
 	leds {
 		compatible = "gpio-leds";
 
-		user_led: user {
+		user_led: led-user {
 			label = "Heartbeat";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_led>;
-- 
2.40.1



