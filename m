Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A539175D256
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjGUS6e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjGUS6d (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:58:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F223A82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:58:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9694561D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A527AC433C7;
        Fri, 21 Jul 2023 18:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965910;
        bh=n864Qwvm3+DhajX6LfEIbhrNfhpZBlQ77yTbDl/t1do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jy16Ez7bgyMUgYFoF4r5dGrv+HI8J+sE5yefJ3kDnSTH/qOpAyWZHYluol49ck+Df
         uJKoA+CBl5+mMEdjMe+H2fXWFR8S83SKjJfoxTxf50RBCv72HVe4xg+caIrxIFJLXM
         s/3OwVYz7qvdOEl3kBpCzi3gNHJEp4l3k8lyEe7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Keerthy <j-keerthy@ti.com>,
        Udit Kumar <u-kumar1@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 157/532] arm64: dts: ti: k3-j7200: Fix physical address of pin
Date:   Fri, 21 Jul 2023 18:01:01 +0200
Message-ID: <20230721160622.934165974@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

[ Upstream commit 3d011933000ed9054c649952d83162d24f020a93 ]

wkup_pmx splits into multiple regions. Like

    wkup_pmx0 -> 13 pins (WKUP_PADCONFIG 0 - 12)
    wkup_pmx1 -> 2 pins (WKUP_PADCONFIG 14 - 15)
    wkup_pmx2 -> 59 pins (WKUP_PADCONFIG 26 - 84)
    wkup_pmx3 -> 8 pins (WKUP_PADCONFIG 93 - 100)

With this split, pin offset needs to be adjusted to
match with new pmx for all pins above wkup_pmx0.

Example a pin under wkup_pmx1 should start from 0 instead of
old offset(0x38 WKUP_PADCONFIG 14 offset)

J7200 Datasheet (Table 6-106, Section 6.4 Pin Multiplexing) :
https://www.ti.com/lit/ds/symlink/dra821u.pdf

Fixes: 9ae21ac445e9 ("arm64: dts: ti: k3-j7200: Fix wakeup pinmux range")

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Link: https://lore.kernel.org/r/20230419040007.3022780-2-u-kumar1@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 4417fe81afd7f..ee244df75eaea 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -80,25 +80,25 @@ vdd_sd_dv: gpio-regulator-TLV71033 {
 &wkup_pmx2 {
 	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
 		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x0068, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
-			J721E_WKUP_IOPAD(0x006c, PIN_INPUT, 0) /* MCU_RGMII1_RX_CTL */
-			J721E_WKUP_IOPAD(0x0070, PIN_OUTPUT, 0) /* MCU_RGMII1_TD3 */
-			J721E_WKUP_IOPAD(0x0074, PIN_OUTPUT, 0) /* MCU_RGMII1_TD2 */
-			J721E_WKUP_IOPAD(0x0078, PIN_OUTPUT, 0) /* MCU_RGMII1_TD1 */
-			J721E_WKUP_IOPAD(0x007c, PIN_OUTPUT, 0) /* MCU_RGMII1_TD0 */
-			J721E_WKUP_IOPAD(0x0088, PIN_INPUT, 0) /* MCU_RGMII1_RD3 */
-			J721E_WKUP_IOPAD(0x008c, PIN_INPUT, 0) /* MCU_RGMII1_RD2 */
-			J721E_WKUP_IOPAD(0x0090, PIN_INPUT, 0) /* MCU_RGMII1_RD1 */
-			J721E_WKUP_IOPAD(0x0094, PIN_INPUT, 0) /* MCU_RGMII1_RD0 */
-			J721E_WKUP_IOPAD(0x0080, PIN_OUTPUT, 0) /* MCU_RGMII1_TXC */
-			J721E_WKUP_IOPAD(0x0084, PIN_INPUT, 0) /* MCU_RGMII1_RXC */
+			J721E_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0) /* MCU_RGMII1_TX_CTL */
+			J721E_WKUP_IOPAD(0x0004, PIN_INPUT, 0) /* MCU_RGMII1_RX_CTL */
+			J721E_WKUP_IOPAD(0x0008, PIN_OUTPUT, 0) /* MCU_RGMII1_TD3 */
+			J721E_WKUP_IOPAD(0x000c, PIN_OUTPUT, 0) /* MCU_RGMII1_TD2 */
+			J721E_WKUP_IOPAD(0x0010, PIN_OUTPUT, 0) /* MCU_RGMII1_TD1 */
+			J721E_WKUP_IOPAD(0x0014, PIN_OUTPUT, 0) /* MCU_RGMII1_TD0 */
+			J721E_WKUP_IOPAD(0x0020, PIN_INPUT, 0) /* MCU_RGMII1_RD3 */
+			J721E_WKUP_IOPAD(0x0024, PIN_INPUT, 0) /* MCU_RGMII1_RD2 */
+			J721E_WKUP_IOPAD(0x0028, PIN_INPUT, 0) /* MCU_RGMII1_RD1 */
+			J721E_WKUP_IOPAD(0x002c, PIN_INPUT, 0) /* MCU_RGMII1_RD0 */
+			J721E_WKUP_IOPAD(0x0018, PIN_OUTPUT, 0) /* MCU_RGMII1_TXC */
+			J721E_WKUP_IOPAD(0x001c, PIN_INPUT, 0) /* MCU_RGMII1_RXC */
 		>;
 	};
 
 	mcu_mdio_pins_default: mcu-mdio1-pins-default {
 		pinctrl-single,pins = <
-			J721E_WKUP_IOPAD(0x009c, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
-			J721E_WKUP_IOPAD(0x0098, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
+			J721E_WKUP_IOPAD(0x0034, PIN_OUTPUT, 0) /* (L1) MCU_MDIO0_MDC */
+			J721E_WKUP_IOPAD(0x0030, PIN_INPUT, 0) /* (L4) MCU_MDIO0_MDIO */
 		>;
 	};
 };
-- 
2.39.2



