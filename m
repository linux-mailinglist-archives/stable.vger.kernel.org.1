Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051376FA46F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbjEHJ7V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbjEHJ7U (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:59:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4C12CD1B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83EF362291
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9346FC433D2;
        Mon,  8 May 2023 09:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539958;
        bh=kkZ63bzUyIuxGSGDDpFcQzopMT0n9cVo7k3BL5YRyS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcrqBKt4+PXCOdk9FH8xZuxO1h3GAOQMel1zLvjud5VEpMsRXwEmI5EEL8MJKTna9
         R3VKgvsYKep0QH4KyWkGejzOtmgsvL+pTjo6zphZggDXfs/6BCfgq0RSi80otpG5en
         7db108H3JsXKukagtY8qct01OIVuCODKdXaFXhAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 192/611] ARM: dts: stm32: fix spi1 pin assignment on stm32mp15
Date:   Mon,  8 May 2023 11:40:34 +0200
Message-Id: <20230508094428.611721588@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ Upstream commit 1b9f0ec81af0012aae30aa3b4c711ad71d42e246 ]

Bank A and B IOs can't be handled by the pin controller 'Z'. This patch
assign spi1 pin definition to the correct controller.

Fixes: 9ad65d245b7b ("ARM: dts: stm32: stm32mp15-pinctrl: add spi1-1 pinmux group")

Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 30 ++++++++++++------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
index a9d2bec990141..e15a3b2a9b399 100644
--- a/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
@@ -1880,6 +1880,21 @@
 		};
 	};
 
+	spi1_pins_b: spi1-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('A', 5, AF5)>, /* SPI1_SCK */
+				 <STM32_PINMUX('B', 5, AF5)>; /* SPI1_MOSI */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <1>;
+		};
+
+		pins2 {
+			pinmux = <STM32_PINMUX('A', 6, AF5)>; /* SPI1_MISO */
+			bias-disable;
+		};
+	};
+
 	spi2_pins_a: spi2-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('B', 10, AF5)>, /* SPI2_SCK */
@@ -2448,19 +2463,4 @@
 			bias-disable;
 		};
 	};
-
-	spi1_pins_b: spi1-1 {
-		pins1 {
-			pinmux = <STM32_PINMUX('A', 5, AF5)>, /* SPI1_SCK */
-				 <STM32_PINMUX('B', 5, AF5)>; /* SPI1_MOSI */
-			bias-disable;
-			drive-push-pull;
-			slew-rate = <1>;
-		};
-
-		pins2 {
-			pinmux = <STM32_PINMUX('A', 6, AF5)>; /* SPI1_MISO */
-			bias-disable;
-		};
-	};
 };
-- 
2.39.2



