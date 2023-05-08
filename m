Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C893D6FA70B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjEHK0k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbjEHK0L (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:26:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B2525509
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:26:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06585625DE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB535C433D2;
        Mon,  8 May 2023 10:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541564;
        bh=oo+mgKjtrMb1Vi08fabsduXLpZhxuZyzQg9XKNt2FCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Te2xLd89UaRvSXJ0Oec8hx5ACOSJbz5FDGuUFX+XnKvPcylunj7gEzHXBtP8zYK9S
         lrSpwW+O4exrLI3EUBoqfIarWREnENMPRoJA6k8t+q4L7nb6LhqwmFoOdFzBi7ZeoZ
         N1s7sVn08gs5potuc9jUBE9A0zvWZsgpGCn1eMWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 155/663] arm64: dts: broadcom: bcmbca: bcm4908: fix LED nodenames
Date:   Mon,  8 May 2023 11:39:41 +0200
Message-Id: <20230508094433.530816417@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 23be9f68f933adee8163b8efc9c6bff71410cc7c ]

This fixes:
arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dtb: leds@800: 'led-lan@19', 'led-power@11', 'led-wan-red@12', 'led-wan-white@15', 'led-wps@14' do not match any of the regexes: '^led@[a-f0-9]+$', 'pinctrl-[0-9]+'
        From schema: Documentation/devicetree/bindings/leds/leds-bcm63138.yaml

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/all/20230228144400.21689-2-zajec5@gmail.com/
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts     | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
index 839ca33178b01..d94a53d68320b 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dts
@@ -120,7 +120,7 @@
 };
 
 &leds {
-	led-power@11 {
+	led@11 {
 		reg = <0x11>;
 		function = LED_FUNCTION_POWER;
 		color = <LED_COLOR_ID_WHITE>;
@@ -130,7 +130,7 @@
 		pinctrl-0 = <&pins_led_17_a>;
 	};
 
-	led-wan-red@12 {
+	led@12 {
 		reg = <0x12>;
 		function = LED_FUNCTION_WAN;
 		color = <LED_COLOR_ID_RED>;
@@ -139,7 +139,7 @@
 		pinctrl-0 = <&pins_led_18_a>;
 	};
 
-	led-wps@14 {
+	led@14 {
 		reg = <0x14>;
 		function = LED_FUNCTION_WPS;
 		color = <LED_COLOR_ID_WHITE>;
@@ -148,7 +148,7 @@
 		pinctrl-0 = <&pins_led_20_a>;
 	};
 
-	led-wan-white@15 {
+	led@15 {
 		reg = <0x15>;
 		function = LED_FUNCTION_WAN;
 		color = <LED_COLOR_ID_WHITE>;
@@ -157,7 +157,7 @@
 		pinctrl-0 = <&pins_led_21_a>;
 	};
 
-	led-lan@19 {
+	led@19 {
 		reg = <0x19>;
 		function = LED_FUNCTION_LAN;
 		color = <LED_COLOR_ID_WHITE>;
-- 
2.39.2



