Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76DE79BEE2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348865AbjIKVba (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240295AbjIKOkr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:40:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D873F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:40:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0338C433C7;
        Mon, 11 Sep 2023 14:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443243;
        bh=/dw0PdWLhq8PXZG/HH3yVgaPHTanHl1qQ8ntVEW5pe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CyGhZhr6+VlI4J7B9lB8FcrBIfaNcbs68BX/W3sYpj2sRC+BtZyBj3Laa57Nlv2Y5
         Snu1upOlkr+Nh+WN5w+N2WK2vpOJUzodAZJ56MKu70VsGUrU2BPbxAFbaBAqk6Qzp+
         RQr1koSweKxIeKBmaCSvMe9K8lDPYOdNKv4J2ZTA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 309/737] ARM: dts: BCM53573: Drop nonexistent "default-off" LED trigger
Date:   Mon, 11 Sep 2023 15:42:48 +0200
Message-ID: <20230911134659.201311685@linuxfoundation.org>
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

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit be7e1e5b0f67c58ec4be0a54db23b6a4fa6e2116 ]

There is no such trigger documented or implemented in Linux. It was a
copy & paste mistake.

This fixes:
arch/arm/boot/dts/broadcom/bcm47189-luxul-xap-1440.dtb: leds: led-wlan:linux,default-trigger: 'oneOf' conditional failed, one must be fixed:
        'default-off' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'disk-read', 'disk-write', 'timer', 'pattern', 'audio-micmute', 'audio-mute', 'bluetooth-power', 'flash', 'kbd-capslock', 'mtd', 'nand-disk', 'none', 'torch', 'usb-gadget', 'usb-host', 'usbport']
        'default-off' does not match '^cpu[0-9]*$'
        'default-off' does not match '^hci[0-9]+-power$'
        'default-off' does not match '^mmc[0-9]+$'
        'default-off' does not match '^phy[0-9]+tx$'
        From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/r/20230707114004.2740-1-zajec5@gmail.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts | 1 -
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts  | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
index 0734aa249b8e0..b9dd508444198 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
@@ -26,7 +26,6 @@ leds {
 		led-wlan {
 			label = "bcm53xx:blue:wlan";
 			gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
-			linux,default-trigger = "default-off";
 		};
 
 		led-system {
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
index e6fb6cbe69633..cb22ae2a02e54 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
@@ -26,7 +26,6 @@ leds-0 {
 		led-5ghz {
 			label = "bcm53xx:blue:5ghz";
 			gpios = <&chipcommon 11 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 
 		led-system {
@@ -42,7 +41,6 @@ leds-1 {
 		led-2ghz {
 			label = "bcm53xx:blue:2ghz";
 			gpios = <&pcie0_chipcommon 3 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "default-off";
 		};
 	};
 
-- 
2.40.1



