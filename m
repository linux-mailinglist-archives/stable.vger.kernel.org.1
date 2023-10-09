Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9637BE064
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376368AbjJINjl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376990AbjJINjf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:39:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450789C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:39:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81919C433CD;
        Mon,  9 Oct 2023 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858772;
        bh=spuL/08/uHBJXeg3esvlqx1EoW0zmOHnTfOoUknmTJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=znFLn/OV1z+sAxoPDX5Fy1BDJJRfBSrvYxpYymF1X9NSLOev3CbYDkaS2w5o8+pkW
         2E6oeGnrZsZ/4cZgJlgaRcKYFTwFxZaIjJi398iqoBzv19wHXTlv7ZekEotnxBkD3a
         GytABYmY91OLyAxeByf6OW2socfeSg0pdi9oSVsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 096/226] ARM: dts: motorola-mapphone: Drop second ti,wlcore compatible value
Date:   Mon,  9 Oct 2023 15:00:57 +0200
Message-ID: <20231009130129.277829080@linuxfoundation.org>
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

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 7ebe6e99f7702dad342486e5b30d989a0a6499af ]

The TI wlcore DT bindings specify using a single compatible value for
each variant, and the Linux kernel driver matches against the first
compatible value since commit 078b30da3f074f2e ("wlcore: add wl1285
compatible") in v4.13.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Stable-dep-of: ac08bda1569b ("ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boot")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/motorola-mapphone-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index ab0672131c212..4227b7f49e46c 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -407,7 +407,7 @@
 	#address-cells = <1>;
 	#size-cells = <0>;
 	wlcore: wlcore@2 {
-		compatible = "ti,wl1285", "ti,wl1283";
+		compatible = "ti,wl1285";
 		reg = <2>;
 		/* gpio_100 with gpmc_wait2 pad as wakeirq */
 		interrupts-extended = <&gpio4 4 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.40.1



