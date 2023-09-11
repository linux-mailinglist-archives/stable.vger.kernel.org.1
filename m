Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEF679AE76
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378691AbjIKWgj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbjIKOoR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:44:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB3CCF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:44:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B3FC433C8;
        Mon, 11 Sep 2023 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443452;
        bh=eB8l9yyz+WBgtryRoy3+LPnaRvBCbMYnrAa/LOOc6IM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r3vOUYPyEeXpSsGMIclpdn92ZCfovIzt0vjEe2XxUaz060OTOMuMUkmHq6oOYiYGf
         GFQKSLkUJQGtBVq9zai8MOzj/uDs/AaTIfDI6G6jqVidWhEV8/cyTuYpkBoHQUe0Ic
         0VldWaSgjGK1nJrtHjW5u5gx5H2bG7k+L/+zfT5Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephan Gerhold <stephan@gerhold.net>,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 382/737] arm64: dts: qcom: msm8916-longcheer-l8910: Add front flash LED
Date:   Mon, 11 Sep 2023 15:44:01 +0200
Message-ID: <20230911134701.247361529@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: André Apitzsch <git@apitzsch.eu>

[ Upstream commit 5d8d9330921770fb953e8e749bbd049ac0fae988 ]

l8910 uses OCP8110 flash LED driver. Add it to the device tree.

Tested-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: André Apitzsch <git@apitzsch.eu>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230514-x5_front_flash-v2-1-845a8bb0483b@apitzsch.eu
Stable-dep-of: 4facccb44a82 ("arm64: dts: qcom: apq8016-sbc: Rename ov5640 enable-gpios to powerdown-gpios")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index b79e80913af9f..6046e2c1f1586 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -20,6 +20,21 @@ chosen {
 		stdout-path = "serial0";
 	};
 
+	flash-led-controller {
+		compatible = "ocs,ocp8110";
+		enable-gpios = <&msmgpio 49 GPIO_ACTIVE_HIGH>;
+		flash-gpios = <&msmgpio 119 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&camera_front_flash_default>;
+		pinctrl-names = "default";
+
+		flash_led: led {
+			function = LED_FUNCTION_FLASH;
+			color = <LED_COLOR_ID_WHITE>;
+			flash-max-timeout-us = <250000>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -246,6 +261,13 @@ button_backlight_default: button-backlight-default-state {
 		bias-disable;
 	};
 
+	camera_front_flash_default: camera-front-flash-default-state {
+		pins = "gpio49", "gpio119";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107";
 		function = "gpio";
-- 
2.40.1



