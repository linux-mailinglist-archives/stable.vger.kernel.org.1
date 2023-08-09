Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCDF77574C
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjHIKoa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjHIKo1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:44:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B742112
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAFEE6311F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E79C433C8;
        Wed,  9 Aug 2023 10:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691577864;
        bh=+iNwGQses/SvbmlJy8x4N/eQpUAviko1J+QkN9HH9vE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FbKg29Ybr8mXAHjBaFM11AM6t9kjpvATDasEo3LNx3kq3GL9GsEKkk/SsoesmJOKN
         V0qZjPqvfCEY5BoZIZ8jYzLGX4jaOaNkyKGiWew9IhFgwA4PKQVtVXQSIH09AlHtLz
         /YPluVRzHNLfhid/b9UE3b/EciqoK8ZC9x0/eFOo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Durai Manickam KR <durai.manickamkr@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 021/165] ARM: dts: at91: sam9x60: fix the SOC detection
Date:   Wed,  9 Aug 2023 12:39:12 +0200
Message-ID: <20230809103643.485419217@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Durai Manickam KR <durai.manickamkr@microchip.com>

[ Upstream commit f6ad3c13f1b8c4e785cb7bd423887197142f47b0 ]

Remove the dbgu compatible strings in the UART submodule of the
flexcom for the proper SOC detection.

Fixes: 99c808335877 (ARM: dts: at91: sam9x60: Add missing flexcom definitions)
Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
Link: https://lore.kernel.org/r/20230712100042.317856-1-durai.manickamkr@microchip.com
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sam9x60.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index 8b53997675e75..73d570a172690 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -172,7 +172,7 @@
 				status = "disabled";
 
 				uart4: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -240,7 +240,7 @@
 				status = "disabled";
 
 				uart5: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
 					interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -370,7 +370,7 @@
 				status = "disabled";
 
 				uart11: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -419,7 +419,7 @@
 				status = "disabled";
 
 				uart12: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -576,7 +576,7 @@
 				status = "disabled";
 
 				uart6: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -625,7 +625,7 @@
 				status = "disabled";
 
 				uart7: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -674,7 +674,7 @@
 				status = "disabled";
 
 				uart8: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -723,7 +723,7 @@
 				status = "disabled";
 
 				uart0: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -791,7 +791,7 @@
 				status = "disabled";
 
 				uart1: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -859,7 +859,7 @@
 				status = "disabled";
 
 				uart2: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -927,7 +927,7 @@
 				status = "disabled";
 
 				uart3: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -1050,7 +1050,7 @@
 				status = "disabled";
 
 				uart9: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
@@ -1099,7 +1099,7 @@
 				status = "disabled";
 
 				uart10: serial@200 {
-					compatible = "microchip,sam9x60-dbgu", "microchip,sam9x60-usart", "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
+					compatible = "microchip,sam9x60-usart", "atmel,at91sam9260-usart";
 					reg = <0x200 0x200>;
 					interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
 					dmas = <&dma0
-- 
2.40.1



