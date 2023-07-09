Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA93F74C374
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjGILcp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjGILcV (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:32:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA84C0
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB75260BC4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E9AC433C8;
        Sun,  9 Jul 2023 11:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902339;
        bh=3zj4oZUJyZWCGWg8Zukn8g9TG9uTMq5TEYYjkZ2RAHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m2/PMnMQqVtPTBSSnpaj9H/kE/s8M0QKKz5L3uv8BrbD8fKD297eN+n17krXqrrE4
         QBlQFfUE1nv52Ue2a2GlHA2mhR2inbAIVuqy/+ZEWJUT6uLl2JdjKWfgB/LD0XtZPW
         +/RIxn4BqDVZ1VkfbQSvEJyuD/YiILnOz80W4HN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Walle <mwalle@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 333/431] ARM: dts: lan966x: kontron-d10: fix SPI CS
Date:   Sun,  9 Jul 2023 13:14:41 +0200
Message-ID: <20230709111458.980874506@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Walle <mwalle@kernel.org>

[ Upstream commit fcb79ee3f0b15ed15f35eca5f24e952fdced9c61 ]

The pinctrl node was missing which change the pin mux to GPIO mode.
Add it so we don't have to rely on the bootloader to set the correct
mode.

Fixes: 79d83b3a458e ("ARM: dts: lan966x: add basic Kontron KSwitch D10 support")
Signed-off-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230616-feature-d10-dt-cleanups-v1-2-50dd0452b8fe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
index 42be207509a46..f4df4cc1dfa5e 100644
--- a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
@@ -41,7 +41,7 @@ &flx3 {
 	status = "okay";
 
 	spi3: spi@400 {
-		pinctrl-0 = <&fc3_b_pins>;
+		pinctrl-0 = <&fc3_b_pins>, <&spi3_cs_pins>;
 		pinctrl-names = "default";
 		status = "okay";
 		cs-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
@@ -79,6 +79,12 @@ sgpio_b_pins: sgpio-b-pins {
 		function = "sgpio_b";
 	};
 
+	spi3_cs_pins: spi3-cs-pins {
+		/* CS# */
+		pins = "GPIO_46";
+		function = "gpio";
+	};
+
 	usart0_pins: usart0-pins {
 		/* RXD, TXD */
 		pins = "GPIO_25", "GPIO_26";
-- 
2.39.2



