Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB447BE066
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377309AbjJINjp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377325AbjJINjn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:39:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8C3D3
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:39:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF55DC433C8;
        Mon,  9 Oct 2023 13:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858779;
        bh=E7sl8t7+Nqhgb1Y5tIL06tSdrpRuqDQPuml4DfR09+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxycwfIXmLyQxGcTOH6DrdBCtUlvL3aMh6RMKpPDqjvG1gl7uWRWdAnneVYEtr1Ie
         asOUrgMc6NcLgh09RRZUPbQz/URtt5vkDAR3IV5F9GzbNAGNgdSZhJVPQDLoh+6lW3
         oE5IQGIfgh3HRZ1F9zDetCCJ2FfSg/Yn454SNNEI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 098/226] ARM: dts: Unify pwm-omap-dmtimer node names
Date:   Mon,  9 Oct 2023 15:00:59 +0200
Message-ID: <20231009130129.338542262@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index b113edab76955..9594276acf9d2 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -100,8 +100,9 @@
 
 	};
 
-	guardian_beeper: dmtimer-pwm@7 {
+	guardian_beeper: pwm-7 {
 		compatible = "ti,omap-dmtimer-pwm";
+		#pwm-cells = <3>;
 		ti,timers = <&timer7>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&guardian_beeper_pins>;
diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index c8b80f156ec98..9cc1ae36c4204 100644
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
index 533a47bc4a531..1386a5e63eff7 100644
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
index 4227b7f49e46c..2b9ae5242cdf0 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -156,7 +156,7 @@
 		dais = <&mcbsp2_port>, <&mcbsp3_port>;
 	};
 
-	pwm8: dmtimer-pwm-8 {
+	pwm8: pwm-8 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&vibrator_direction_pin>;
 
@@ -166,7 +166,7 @@
 		ti,clock-source = <0x01>;
 	};
 
-	pwm9: dmtimer-pwm-9 {
+	pwm9: pwm-9 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&vibrator_enable_pin>;
 
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 0333ca0e87fe3..68e56b50652a9 100644
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
index fdd929bc65d79..7dafd69b7d359 100644
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



