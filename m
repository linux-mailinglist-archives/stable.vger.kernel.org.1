Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB8979BED8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbjIKWWT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbjIKOG7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:06:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA0DE40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:06:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B82C433C9;
        Mon, 11 Sep 2023 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441214;
        bh=iYqORxiwUecvKAG95dusQwsS1SR80N21jlOAd0tILXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=scT4xSYSguUbIRBGVQiKhCYFfhXXcExYvgEEVc08FRNldBVbiGODIasqVQk4l1YIU
         R6r/HCrzYtu95wvuEelPox036p5RtXD+VHVD7++uG1mg3WDp0kAZMGhYMRPufV41ig
         KrZz67Oh8PbKMl/FE3M+D//5wF4lSb1OLqVwRd98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Udit Kumar <u-kumar1@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Nishanth Menon <nm@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 334/739] arm64: dts: ti: k3-j784s4-evm: Correct Pin mux offset for ADC
Date:   Mon, 11 Sep 2023 15:42:13 +0200
Message-ID: <20230911134700.421142074@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Udit Kumar <u-kumar1@ti.com>

[ Upstream commit 8be3ac2d8bd77bb9cb9ddbb7a545decf9f5e4181 ]

After splitting wkup_pmx pin mux for J784S4 into four regions.
Pin mux offset for ADC nodes were not updated to align with new
regions, due to this while probing ADC driver out of range
error was seen.

Pin mux offsets for ADC nodes are corrected in this patch.

Fixes: 14462bd0b247 ("arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and pinctrl node offsets")
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Reviewed-by: Vaishnav Achath <vaishnav.a@ti.com>
Link: https://lore.kernel.org/r/20230809050108.751164-1-u-kumar1@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 32 ++++++++++++------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index cb852031c8027..bf772f0641170 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -340,27 +340,27 @@ J784S4_WKUP_IOPAD(0x030, PIN_INPUT, 0) /* (B35) MCU_MDIO0_MDIO */
 
 	mcu_adc0_pins_default: mcu-adc0-default-pins {
 		pinctrl-single,pins = <
-			J784S4_WKUP_IOPAD(0x134, PIN_INPUT, 0) /* (P36) MCU_ADC0_AIN0 */
-			J784S4_WKUP_IOPAD(0x138, PIN_INPUT, 0) /* (V36) MCU_ADC0_AIN1 */
-			J784S4_WKUP_IOPAD(0x13c, PIN_INPUT, 0) /* (T34) MCU_ADC0_AIN2 */
-			J784S4_WKUP_IOPAD(0x140, PIN_INPUT, 0) /* (T36) MCU_ADC0_AIN3 */
-			J784S4_WKUP_IOPAD(0x144, PIN_INPUT, 0) /* (P34) MCU_ADC0_AIN4 */
-			J784S4_WKUP_IOPAD(0x148, PIN_INPUT, 0) /* (R37) MCU_ADC0_AIN5 */
-			J784S4_WKUP_IOPAD(0x14c, PIN_INPUT, 0) /* (R33) MCU_ADC0_AIN6 */
-			J784S4_WKUP_IOPAD(0x150, PIN_INPUT, 0) /* (V38) MCU_ADC0_AIN7 */
+			J784S4_WKUP_IOPAD(0x0cc, PIN_INPUT, 0) /* (P36) MCU_ADC0_AIN0 */
+			J784S4_WKUP_IOPAD(0x0d0, PIN_INPUT, 0) /* (V36) MCU_ADC0_AIN1 */
+			J784S4_WKUP_IOPAD(0x0d4, PIN_INPUT, 0) /* (T34) MCU_ADC0_AIN2 */
+			J784S4_WKUP_IOPAD(0x0d8, PIN_INPUT, 0) /* (T36) MCU_ADC0_AIN3 */
+			J784S4_WKUP_IOPAD(0x0dc, PIN_INPUT, 0) /* (P34) MCU_ADC0_AIN4 */
+			J784S4_WKUP_IOPAD(0x0e0, PIN_INPUT, 0) /* (R37) MCU_ADC0_AIN5 */
+			J784S4_WKUP_IOPAD(0x0e4, PIN_INPUT, 0) /* (R33) MCU_ADC0_AIN6 */
+			J784S4_WKUP_IOPAD(0x0e8, PIN_INPUT, 0) /* (V38) MCU_ADC0_AIN7 */
 		>;
 	};
 
 	mcu_adc1_pins_default: mcu-adc1-default-pins {
 		pinctrl-single,pins = <
-			J784S4_WKUP_IOPAD(0x154, PIN_INPUT, 0) /* (Y38) MCU_ADC1_AIN0 */
-			J784S4_WKUP_IOPAD(0x158, PIN_INPUT, 0) /* (Y34) MCU_ADC1_AIN1 */
-			J784S4_WKUP_IOPAD(0x15c, PIN_INPUT, 0) /* (V34) MCU_ADC1_AIN2 */
-			J784S4_WKUP_IOPAD(0x160, PIN_INPUT, 0) /* (W37) MCU_ADC1_AIN3 */
-			J784S4_WKUP_IOPAD(0x164, PIN_INPUT, 0) /* (AA37) MCU_ADC1_AIN4 */
-			J784S4_WKUP_IOPAD(0x168, PIN_INPUT, 0) /* (W33) MCU_ADC1_AIN5 */
-			J784S4_WKUP_IOPAD(0x16c, PIN_INPUT, 0) /* (U33) MCU_ADC1_AIN6 */
-			J784S4_WKUP_IOPAD(0x170, PIN_INPUT, 0) /* (Y36) MCU_ADC1_AIN7 */
+			J784S4_WKUP_IOPAD(0x0ec, PIN_INPUT, 0) /* (Y38) MCU_ADC1_AIN0 */
+			J784S4_WKUP_IOPAD(0x0f0, PIN_INPUT, 0) /* (Y34) MCU_ADC1_AIN1 */
+			J784S4_WKUP_IOPAD(0x0f4, PIN_INPUT, 0) /* (V34) MCU_ADC1_AIN2 */
+			J784S4_WKUP_IOPAD(0x0f8, PIN_INPUT, 0) /* (W37) MCU_ADC1_AIN3 */
+			J784S4_WKUP_IOPAD(0x0fc, PIN_INPUT, 0) /* (AA37) MCU_ADC1_AIN4 */
+			J784S4_WKUP_IOPAD(0x100, PIN_INPUT, 0) /* (W33) MCU_ADC1_AIN5 */
+			J784S4_WKUP_IOPAD(0x104, PIN_INPUT, 0) /* (U33) MCU_ADC1_AIN6 */
+			J784S4_WKUP_IOPAD(0x108, PIN_INPUT, 0) /* (Y36) MCU_ADC1_AIN7 */
 		>;
 	};
 };
-- 
2.40.1



