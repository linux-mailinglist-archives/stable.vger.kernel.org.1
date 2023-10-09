Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511167BE065
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377308AbjJINjp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377316AbjJINji (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:39:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6365B9C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:39:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E90C433C8;
        Mon,  9 Oct 2023 13:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858776;
        bh=nqXVHuRomkD6GtiHTupAYEnOPhhxOHYLj2BzBDePmmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d5E9HkdGG7MdW/VIdCrSW1huqbeRCxYVaGxtEm1JlV0W+EeQDnQDP7n5eIwvPFrXS
         OqIpRFXzdz01d0K+CGtxHo1y+PeMzcSM+PVfMLMbBsZpjgfqLTgkA79NaPNqMlRgUP
         F2O8H4ZycEC5rHYNwW7epW08wKUxCcxYFatO8E0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 097/226] ARM: dts: am335x: Guardian: Update beeper label
Date:   Mon,  9 Oct 2023 15:00:58 +0200
Message-ID: <20231009130129.311248905@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

[ Upstream commit b5bf6b434575d32aeaa70c82ec84b3cec92e2973 ]

 * Update lable pwm to guardian beeper

Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
Message-Id: <20220325100613.1494-8-Gireesh.Hiremath@in.bosch.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Stable-dep-of: ac08bda1569b ("ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boot")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-guardian.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-guardian.dts b/arch/arm/boot/dts/am335x-guardian.dts
index 1918766c1f809..b113edab76955 100644
--- a/arch/arm/boot/dts/am335x-guardian.dts
+++ b/arch/arm/boot/dts/am335x-guardian.dts
@@ -100,11 +100,11 @@
 
 	};
 
-	pwm7: dmtimer-pwm {
+	guardian_beeper: dmtimer-pwm@7 {
 		compatible = "ti,omap-dmtimer-pwm";
 		ti,timers = <&timer7>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&dmtimer7_pins>;
+		pinctrl-0 = <&guardian_beeper_pins>;
 		ti,clock-source = <0x01>;
 	};
 
@@ -343,9 +343,9 @@
 		>;
 	};
 
-	dmtimer7_pins: pinmux_dmtimer7_pins {
+	guardian_beeper_pins: pinmux_dmtimer7_pins {
 		pinctrl-single,pins = <
-			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE5)
+			AM33XX_IOPAD(0x968, PIN_OUTPUT | MUX_MODE5) /* (E18) timer7 */
 		>;
 	};
 
-- 
2.40.1



