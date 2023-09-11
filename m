Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364B079ADE7
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241516AbjIKVHJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241704AbjIKPM1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:12:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D3FFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:12:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDE4C433C8;
        Mon, 11 Sep 2023 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445142;
        bh=wWjrn6+VhbdYAYqV/ghVK26wh0f7Lc1KlsedWoWI1i8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TN0Y/4KhlC8XD/XOxvsFCqyyDjpSMEtaI9u2bTdUHgy1hiYnXZDIbIZeazanMzFII
         fbt5bo3spqcojsFQ76FwD88WuTW+0UiX3p2gBvNQ5h+EiQbgVdRkLCsdjGAqQpE8sV
         M1IA8KBD4kdaPHCawBTM0iTQKG1SkVKpIFglDLy0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 241/600] ARM: dts: stm32: Rename mdio0 to mdio
Date:   Mon, 11 Sep 2023 15:44:34 +0200
Message-ID: <20230911134640.713231195@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

[ Upstream commit a306d8962a24f4e8385853793fd58f9792c7aa61 ]

Replace "mdio0" node with "mdio" to match mdio.yaml DT schema.

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Stable-dep-of: 0ee0ef38aa9f ("ARM: dts: stm32: Add missing detach mailbox for emtrion emSBC-Argon")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi     | 2 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts                | 2 +-
 arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts            | 2 +-
 arch/arm/boot/dts/stm32mp157c-odyssey.dts            | 2 +-
 arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi         | 2 +-
 arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi   | 2 +-
 arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi | 2 +-
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi               | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi b/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
index d540550f7da26..7d11c50b9e408 100644
--- a/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
@@ -173,7 +173,7 @@ &ethernet0 {
 	phy-handle = <&phy0>;
 	st,eth-ref-clk-sel;
 
-	mdio0 {
+	mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "snps,dwmac-mdio";
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 050c3c27a4203..b72d5e8aa4669 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -144,7 +144,7 @@ &ethernet0 {
 	max-speed = <1000>;
 	phy-handle = <&phy0>;
 
-	mdio0 {
+	mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "snps,dwmac-mdio";
diff --git a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
index e8d2ec41d5374..cb00ce7cec8b1 100644
--- a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
@@ -112,7 +112,7 @@ &ethernet0 {
 	phy-handle = <&ethphy>;
 	status = "okay";
 
-	mdio0 {
+	mdio {
 		compatible = "snps,dwmac-mdio";
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/stm32mp157c-odyssey.dts b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
index ed66d25b8bf3d..a8b3f7a547036 100644
--- a/arch/arm/boot/dts/stm32mp157c-odyssey.dts
+++ b/arch/arm/boot/dts/stm32mp157c-odyssey.dts
@@ -41,7 +41,7 @@ &ethernet0 {
 	assigned-clock-rates = <125000000>; /* Clock PLL4 to 750Mhz in ATF/U-Boot */
 	st,eth-clk-sel;
 
-	mdio0 {
+	mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "snps,dwmac-mdio";
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
index d3b85a8764d74..c06edd2eacb0c 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
@@ -125,7 +125,7 @@ &ethernet0 {
 	max-speed = <100>;
 	phy-handle = <&phy0>;
 
-	mdio0 {
+	mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "snps,dwmac-mdio";
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
index f068e4fcc404f..dae602b7a54df 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
@@ -151,7 +151,7 @@ &ethernet0 {
 	max-speed = <1000>;
 	phy-handle = <&phy0>;
 
-	mdio0 {
+	mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "snps,dwmac-mdio";
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi
index bb4ac6c13cbd3..39af79dc654cc 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi
@@ -78,7 +78,7 @@ &ethernet0 {
 	max-speed = <1000>;
 	phy-handle = <&phy0>;
 
-	mdio0 {
+	mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "snps,dwmac-mdio";
diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index fdc48536e97d1..73a6a7b278b90 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -141,7 +141,7 @@ &ethernet0 {
 	max-speed = <1000>;
 	phy-handle = <&phy0>;
 
-	mdio0 {
+	mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "snps,dwmac-mdio";
-- 
2.40.1



