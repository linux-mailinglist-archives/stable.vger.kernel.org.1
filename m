Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4064F79B672
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbjIKUxl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240416AbjIKOnq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:43:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1545112A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:43:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60448C433C8;
        Mon, 11 Sep 2023 14:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443421;
        bh=xjUP/0LFZREV59DGmXibWAhIDMg29Nmd4Mg9Tg2zDbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RXTRh9CPaL2MbwzsFnQ7FM6swPYYTQagtoozqiNfiU/52f7Dr8YMpJJrNK9jU5S/d
         mb/50bqWBtMmiYd+vUFgJMlHzdeFPw3OV/AqeBOdFBbjkCfWL1mJmGSIOjx17GYkn+
         DbBUVijQnS2yildNkpVpaPbLj7zBVaxGujuz2SuA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Apelete Seketeli <aseketeli@baylibre.com>,
        Esteban Blanc <eblanc@baylibre.com>,
        Jai Luthra <j-luthra@ti.com>, Nishanth Menon <nm@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 372/737] arm64: dts: ti: k3-j784s4: Fix interrupt ranges for wkup & main gpio
Date:   Mon, 11 Sep 2023 15:43:51 +0200
Message-ID: <20230911134700.941300617@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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
index e9169eb358c16..320c31cba0a43 100644
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
index ed2b40369c59a..77208349eb22b 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -92,7 +92,7 @@ wkup_gpio_intr: interrupt-controller@42200000 {
 		#interrupt-cells = <1>;
 		ti,sci = <&sms>;
 		ti,sci-dev-id = <177>;
-		ti,interrupt-ranges = <16 928 16>;
+		ti,interrupt-ranges = <16 960 16>;
 	};
 
 	mcu_conf: syscon@40f00000 {
-- 
2.40.1



