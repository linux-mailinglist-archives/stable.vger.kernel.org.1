Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5187552FC
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjGPUOT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjGPUOS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:14:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A549D90
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3967660EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43142C433C7;
        Sun, 16 Jul 2023 20:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538456;
        bh=b4aDIJsYHPCcG85cEpSQBYX4Ui66WK5ExCnv8e0O/i0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=baRYj7z2VXmk0JPqd/PdaSnQK27Y9pMHFwssGXFVEDEYKdn3Db13ws3oHKua6Jthc
         0M5gTAJlGdFG9rZlde6GRP1ONkI+HBZGIOEwjEN7ChVvm4EwOr+13XYMlqWQU8LSuh
         OBYu84m9QGfkjUsE1ZNXB0dRV6Q4jOsrE9/W174s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Walle <mwalle@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 428/800] ARM: dts: lan966x: kontron-d10: fix board reset
Date:   Sun, 16 Jul 2023 21:44:41 +0200
Message-ID: <20230716194959.028141065@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

[ Upstream commit bfcd5714f6424c03e385e0e9296dcd69855cfea7 ]

The pinctrl node was missing which change the pin mux to GPIO mode. Add
it.

Fixes: 79d83b3a458e ("ARM: dts: lan966x: add basic Kontron KSwitch D10 support")
Signed-off-by: Michael Walle <mwalle@kernel.org>
[claudiu.beznea: moved pinctrl-* bindings after compatible]
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230616-feature-d10-dt-cleanups-v1-1-50dd0452b8fe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
index 0097e72e3fb22..42be207509a46 100644
--- a/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
+++ b/arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi
@@ -18,6 +18,8 @@ chosen {
 
 	gpio-restart {
 		compatible = "gpio-restart";
+		pinctrl-0 = <&reset_pins>;
+		pinctrl-names = "default";
 		gpios = <&gpio 56 GPIO_ACTIVE_LOW>;
 		priority = <200>;
 	};
@@ -59,6 +61,12 @@ miim_c_pins: miim-c-pins {
 		function = "miim_c";
 	};
 
+	reset_pins: reset-pins {
+		/* SYS_RST# */
+		pins = "GPIO_56";
+		function = "gpio";
+	};
+
 	sgpio_a_pins: sgpio-a-pins {
 		/* SCK, D0, D1 */
 		pins = "GPIO_32", "GPIO_33", "GPIO_34";
-- 
2.39.2



