Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD237A37CD
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbjIQTZU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbjIQTY6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:24:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82907DB
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:24:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14D2C433C7;
        Sun, 17 Sep 2023 19:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978692;
        bh=XZG6X/l5R0Tp2JuK3l89oH54UVqAbMbzee0HPd5LSCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XSvod/3kNuoJH7/3cQoHEthmcybg6uPXuX1maB2B3I4MuvfB/oz8vGBrVcrxRgpaJ
         eD8t9/zpui4KUpBp0P27dyD3ixI0ZYCiyOAMKkMnBpFYDbCO99AQUd2Ndh5pqA/S9k
         SXTI8Bq8dDhv41Mdtrd8cF1c4U1Cp2wCFhxE73gY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 132/406] ARM: dts: BCM5301X: Harmonize EHCI/OHCI DT nodes name
Date:   Sun, 17 Sep 2023 21:09:46 +0200
Message-ID: <20230917191104.645929868@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

[ Upstream commit 74abbfe99f43eb7466d26d9e48fbeb46b8f3d804 ]

In accordance with the Generic EHCI/OHCI bindings the corresponding node
name is suppose to comply with the Generic USB HCD DT schema, which
requires the USB nodes to have the name acceptable by the regexp:
"^usb(@.*)?" . Make sure the "generic-ehci" and "generic-ohci"-compatible
nodes are correctly named.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Stable-dep-of: 05d2c3d552b8 ("ARM: dts: BCM53573: Drop nonexistent #usb-cells")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 4 ++--
 arch/arm/boot/dts/bcm53573.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 4e9bb10f37d0f..9189a9489464b 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -267,7 +267,7 @@ usb2: usb2@21000 {
 
 			interrupt-parent = <&gic>;
 
-			ehci: ehci@21000 {
+			ehci: usb@21000 {
 				#usb-cells = <0>;
 
 				compatible = "generic-ehci";
@@ -289,7 +289,7 @@ ehci_port2: port@2 {
 				};
 			};
 
-			ohci: ohci@22000 {
+			ohci: usb@22000 {
 				#usb-cells = <0>;
 
 				compatible = "generic-ohci";
diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index 4af8e3293cff4..51546fccc6168 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -135,7 +135,7 @@ usb2: usb2@4000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			ehci: ehci@4000 {
+			ehci: usb@4000 {
 				compatible = "generic-ehci";
 				reg = <0x4000 0x1000>;
 				interrupt-parent = <&gic>;
@@ -155,7 +155,7 @@ ehci_port2: port@2 {
 				};
 			};
 
-			ohci: ohci@d000 {
+			ohci: usb@d000 {
 				#usb-cells = <0>;
 
 				compatible = "generic-ohci";
-- 
2.40.1



