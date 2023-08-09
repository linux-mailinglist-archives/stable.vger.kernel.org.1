Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E6B775749
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjHIKoR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjHIKoR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:44:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE6B1BCF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:44:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B69F63121
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A4F5C433CB;
        Wed,  9 Aug 2023 10:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577855;
        bh=5a7Oq63p1QLP8zO/1A7eNOeunBsui6KdmOwlBsehQAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXLDhq39Xtn7DITG9zjAkz60x83E5u+jLD2HbILco7+nl1e9lG82kOsBnuofBJT+b
         83u/Co+CKDRKwQ0yfVAp6Q9Si733W6sj2EsCfiFB01m/AJQgoJgIJ6no+zqD3ozPmw
         03kF0u8bKHFkw4JPyk6dY8OpKZimEIzfIUHzTSlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 019/165] ARM: dts: at91: use clock-controller name for sckc nodes
Date:   Wed,  9 Aug 2023 12:39:10 +0200
Message-ID: <20230809103643.410678105@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 3ecb546333089195b6a1508cb58627b0797a26ca ]

Use clock-controller generic name for slow clock controller nodes.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230517094119.2894220-5-claudiu.beznea@microchip.com
Stable-dep-of: f6ad3c13f1b8 ("ARM: dts: at91: sam9x60: fix the SOC detection")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi  | 2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi  | 2 +-
 arch/arm/boot/dts/sam9x60.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d2.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d3.dtsi     | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi     | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 76afeb31b7f54..498cb92b29f96 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -923,7 +923,7 @@
 				status = "disabled";
 			};
 
-			clk32k: sckc@fffffd50 {
+			clk32k: clock-controller@fffffd50 {
 				compatible = "atmel,at91sam9x5-sckc";
 				reg = <0xfffffd50 0x4>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index a12e6c419fe3d..d7e8a115c916c 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -799,7 +799,7 @@
 				status = "disabled";
 			};
 
-			clk32k: sckc@fffffd50 {
+			clk32k: clock-controller@fffffd50 {
 				compatible = "atmel,at91sam9x5-sckc";
 				reg = <0xfffffd50 0x4>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index af19ef2a875c4..0123ee47151cb 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -154,7 +154,7 @@
 				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			};
 
-			clk32k: sckc@fffffe50 {
+			clk32k: clock-controller@fffffe50 {
 				compatible = "atmel,at91sam9x5-sckc";
 				reg = <0xfffffe50 0x4>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index 89aafb9a8b0fe..c8bedfa987e57 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -1322,7 +1322,7 @@
 				clocks = <&pmc PMC_TYPE_CORE PMC_MCK>;
 			};
 
-			clk32k: sckc@fffffe50 {
+			clk32k: clock-controller@fffffe50 {
 				compatible = "microchip,sam9x60-sckc";
 				reg = <0xfffffe50 0x4>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 86009dd28e623..5f632e3f039e6 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -704,7 +704,7 @@
 				status = "disabled";
 			};
 
-			clk32k: sckc@f8048050 {
+			clk32k: clock-controller@f8048050 {
 				compatible = "atmel,sama5d4-sckc";
 				reg = <0xf8048050 0x4>;
 
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 4524a16322d16..0eebf6c760b3d 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1040,7 +1040,7 @@
 				status = "disabled";
 			};
 
-			clk32k: sckc@fffffe50 {
+			clk32k: clock-controller@fffffe50 {
 				compatible = "atmel,sama5d3-sckc";
 				reg = <0xfffffe50 0x4>;
 				clocks = <&slow_xtal>;
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index e94f3a661f4bb..de6c829692327 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -761,7 +761,7 @@
 				status = "disabled";
 			};
 
-			clk32k: sckc@fc068650 {
+			clk32k: clock-controller@fc068650 {
 				compatible = "atmel,sama5d4-sckc";
 				reg = <0xfc068650 0x4>;
 				#clock-cells = <0>;
-- 
2.40.1



