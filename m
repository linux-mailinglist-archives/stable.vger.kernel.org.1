Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A870E7B8866
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244044AbjJDSPp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244046AbjJDSPo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:15:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BE5C1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:15:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278CEC433C9;
        Wed,  4 Oct 2023 18:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443339;
        bh=9eLZMmF93PqxODXPri9ks99qIEdGceXB9dklq2g3rkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9AUnqaERGRmoO7jv5b6/SseoUrch+tq4a2+7dftMXl+qhiG3IsxI8qbRZlu6VnIe
         ZmmFuaQb2pVl4dZ4a6h6pOTihNqUN52i2nZVWijEHqEYo5cw24b1ArfLzpMvzFpxy1
         SQirPcyoxUsh0iaHVLZGFFPriZSxL/PlBTGbzCTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 121/259] ARM: dts: Unify pwm-omap-dmtimer node names
Date:   Wed,  4 Oct 2023 19:54:54 +0200
Message-ID: <20231004175222.915694343@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 4f15fc7c0f28ffcd6e9a56396db6edcdfa4c9925 ]

There is no reg property for pwm-omap-dmtimer.

Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Stable-dep-of: ac08bda1569b ("ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boot")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-guardian.dts            | 3 ++-
 arch/arm/boot/dts/am3517-evm.dts                 | 2 +-
 arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi | 2 +-
 arch/arm/boot/dts/motorola-mapphone-common.dtsi  | 4 ++--
 arch/arm/boot/dts/omap3-gta04.dtsi               | 2 +-
 arch/arm/boot/dts/omap3-n900.dts                 | 2 +-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index f6356266564c8..b357364e93f99 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -103,8 +103,9 @@
 
 	};
 
-	guardian_beeper: dmtimer-pwm@7 {
+	guardian_beeper: pwm-7 {
 		compatible = "ti,omap-dmtimer-pwm";
+		#pwm-cells = <3>;
 		ti,timers = <&timer7>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&guardian_beeper_pins>;
diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index 35b653014f2b0..7bab0a9dadb30 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -150,7 +150,7 @@
 		enable-gpios = <&gpio6 22 GPIO_ACTIVE_HIGH>; /* gpio_182 */
 	};
 
-	pwm11: dmtimer-pwm@11 {
+	pwm11: pwm-11 {
 		compatible = "ti,omap-dmtimer-pwm";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm_pins>;
diff --git a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
index d3da8b1b473b8..e0cbac500e172 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-baseboard.dtsi
@@ -59,7 +59,7 @@
 		};
 	};
 
-	pwm10: dmtimer-pwm {
+	pwm10: pwm-10 {
 		compatible = "ti,omap-dmtimer-pwm";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwm_pins>;
diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index c7a1f3ffc48ca..f7cc8fc678fa5 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -133,7 +133,7 @@
 		dais = <&mcbsp2_port>, <&mcbsp3_port>;
 	};
 
-	pwm8: dmtimer-pwm-8 {
+	pwm8: pwm-8 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&vibrator_direction_pin>;
 
@@ -143,7 +143,7 @@
 		ti,clock-source = <0x01>;
 	};
 
-	pwm9: dmtimer-pwm-9 {
+	pwm9: pwm-9 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&vibrator_enable_pin>;
 
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index da578719ac5a2..e0be0fb23f80f 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -147,7 +147,7 @@
 		pinctrl-0 = <&backlight_pins>;
 	};
 
-	pwm11: dmtimer-pwm {
+	pwm11: pwm-11 {
 		compatible = "ti,omap-dmtimer-pwm";
 		ti,timers = <&timer11>;
 		#pwm-cells = <3>;
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 98a67581bdd23..89ab08d83261a 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -156,7 +156,7 @@
 		io-channel-names = "temp", "bsi", "vbat";
 	};
 
-	pwm9: dmtimer-pwm {
+	pwm9: pwm-9 {
 		compatible = "ti,omap-dmtimer-pwm";
 		#pwm-cells = <3>;
 		ti,timers = <&timer9>;
-- 
2.40.1



