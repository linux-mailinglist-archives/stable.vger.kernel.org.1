Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267FD7A37F9
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbjIQT3f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239603AbjIQT3Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:29:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B275D9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:29:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7098FC433C8;
        Sun, 17 Sep 2023 19:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978950;
        bh=QpDdtjAieqavsHRFTQxNSWB4mHrRg9BZUCplTGQ2JdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKTKzns3oUAtSSErqTM9d8Jefp+7j9IiApVYxbcIHu1HZv/KPBNlCCY9Ba8X/4Mjg
         lkN+IDRxLs3JUSA84C16iMfL1IPPYbb0khLFxe3utzzC56zKZCqr2R78K0rC+NEUAo
         Nbfc9t87ZcSihx6DCvGyfJrb3+ASsDXSHCEgJyyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 136/406] ARM: dts: BCM53573: Use updated "spi-gpio" binding properties
Date:   Sun, 17 Sep 2023 21:09:50 +0200
Message-ID: <20230917191104.752735192@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 2c0fd6b3d0778ceab40205315ccef74568490f17 ]

Switch away from deprecated properties.

This fixes:
arch/arm/boot/dts/broadcom/bcm947189acdbmr.dtb: spi: gpio-sck: False schema does not allow [[3, 21, 0]]
        From schema: Documentation/devicetree/bindings/spi/spi-gpio.yaml
arch/arm/boot/dts/broadcom/bcm947189acdbmr.dtb: spi: gpio-miso: False schema does not allow [[3, 22, 0]]
        From schema: Documentation/devicetree/bindings/spi/spi-gpio.yaml
arch/arm/boot/dts/broadcom/bcm947189acdbmr.dtb: spi: gpio-mosi: False schema does not allow [[3, 23, 0]]
        From schema: Documentation/devicetree/bindings/spi/spi-gpio.yaml
arch/arm/boot/dts/broadcom/bcm947189acdbmr.dtb: spi: 'sck-gpios' is a required property
        From schema: Documentation/devicetree/bindings/spi/spi-gpio.yaml
arch/arm/boot/dts/broadcom/bcm947189acdbmr.dtb: spi: Unevaluated properties are not allowed ('gpio-miso', 'gpio-mosi', 'gpio-sck' were unexpected)
        From schema: Documentation/devicetree/bindings/spi/spi-gpio.yaml

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/r/20230707114004.2740-4-zajec5@gmail.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm947189acdbmr.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm947189acdbmr.dts b/arch/arm/boot/dts/bcm947189acdbmr.dts
index b0b8c774a37f9..1f0be30e54435 100644
--- a/arch/arm/boot/dts/bcm947189acdbmr.dts
+++ b/arch/arm/boot/dts/bcm947189acdbmr.dts
@@ -60,9 +60,9 @@ wps {
 	spi {
 		compatible = "spi-gpio";
 		num-chipselects = <1>;
-		gpio-sck = <&chipcommon 21 0>;
-		gpio-miso = <&chipcommon 22 0>;
-		gpio-mosi = <&chipcommon 23 0>;
+		sck-gpios = <&chipcommon 21 0>;
+		miso-gpios = <&chipcommon 22 0>;
+		mosi-gpios = <&chipcommon 23 0>;
 		cs-gpios = <&chipcommon 24 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.40.1



