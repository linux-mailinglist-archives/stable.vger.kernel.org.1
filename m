Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3078D79BCB9
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238122AbjIKVEA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238875AbjIKOHB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:07:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BE7CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:06:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39C9C433C8;
        Mon, 11 Sep 2023 14:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441217;
        bh=hDcrtlQayZWfhmGGckXrMRdiguSDkVN229akvTcOzZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c6E0qDDjCKXdac3+2qlXminp0lZbYciksFRwjq8di86yKeLa1LepnmCgc5JknhsCg
         956r6Jr1OubEtiHwsLO5OSc/Cvds1FxhIp+TArBN8ZF/uTfzyZ4GL4ZAwCoJAPVz7+
         zochsk39gQlET5KWhmeyZWtpMhFzWjALsP5T9KNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Apelete Seketeli <aseketeli@baylibre.com>,
        Esteban Blanc <eblanc@baylibre.com>,
        Jai Luthra <j-luthra@ti.com>, Nishanth Menon <nm@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 335/739] arm64: dts: ti: k3-j784s4: Fix interrupt ranges for wkup & main gpio
Date:   Mon, 11 Sep 2023 15:42:14 +0200
Message-ID: <20230911134700.453660788@linuxfoundation.org>
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

From: Apelete Seketeli <aseketeli@baylibre.com>

[ Upstream commit 05a1f130101e7a49ff1e8734939facd43596ea26 ]

This patch fixes the interrupt range for wakeup and main domain gpio
interrupt routers. They were wrongly subtracted by 32 instead of
following what is defined in the interrupt map in the TRM (Table 9-35).

Link:  http://www.ti.com/lit/pdf/spruj52
Fixes: 4664ebd8346a ("arm64: dts: ti: Add initial support for J784S4 SoC")
Signed-off-by: Apelete Seketeli <aseketeli@baylibre.com>
Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
Link: https://lore.kernel.org/r/20230810-tps6594-v6-4-2b2e2399e2ef@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       | 2 +-
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 2ea0adae6832f..76e610d8782b5 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -60,7 +60,7 @@ main_gpio_intr: interrupt-controller@a00000 {
 		#interrupt-cells = <1>;
 		ti,sci = <&sms>;
 		ti,sci-dev-id = <10>;
-		ti,interrupt-ranges = <8 360 56>;
+		ti,interrupt-ranges = <8 392 56>;
 	};
 
 	main_pmx0: pinctrl@11c000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 657fb1d72512c..62a0f172fb2d4 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -107,7 +107,7 @@ wkup_gpio_intr: interrupt-controller@42200000 {
 		#interrupt-cells = <1>;
 		ti,sci = <&sms>;
 		ti,sci-dev-id = <177>;
-		ti,interrupt-ranges = <16 928 16>;
+		ti,interrupt-ranges = <16 960 16>;
 	};
 
 	/* MCU_TIMERIO pad input CTRLMMR_MCU_TIMER*_CTRL registers */
-- 
2.40.1



