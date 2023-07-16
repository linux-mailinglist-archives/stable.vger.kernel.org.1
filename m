Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E589C755532
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjGPUia (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjGPUi3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:38:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062559F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99CAB60EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2FAC433C7;
        Sun, 16 Jul 2023 20:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539908;
        bh=U17vQNkQVv2P7h02o5rSzWvB1FbiYJ3N8EKMh/rhc0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z8Zo1rYC/Qddr7+GPLFxabzoWuLfMv9oh5qLn5XWa4Wcx5838Jq82tUoKJLOZ9gXh
         WstrYJ7RrunHua66JjYPa5KgQ8Mf516p3mFrmrpiu5PJQ3pVUXDpw5hclsyBoUgt44
         h6pdnQRYgIQaSf7KRXqRrXgoxypsqLSzOu3OnKl0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robert Marko <robert.marko@sartura.hr>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 175/591] arm64: dts: microchip: sparx5: do not use PSCI on reference boards
Date:   Sun, 16 Jul 2023 21:45:14 +0200
Message-ID: <20230716194928.393824836@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Robert Marko <robert.marko@sartura.hr>

[ Upstream commit 70be83708c925b3f72c508e4756e48ad2330c830 ]

PSCI is not implemented on SparX-5 at all, there is no ATF and U-boot that
is shipped does not implement it as well.

I have tried flashing the latest BSP 2022.12 U-boot which did not work.
After contacting Microchip, they confirmed that there is no ATF for the
SoC nor PSCI implementation which is unfortunate in 2023.

So, disable PSCI as otherwise kernel crashes as soon as it tries probing
PSCI with, and the crash is only visible if earlycon is used.

Since PSCI is not implemented, switch core bringup to use spin-tables
which are implemented in the vendor U-boot and actually work.

Tested on PCB134 with eMMC (VSC5640EV).

Fixes: 6694aee00a4b ("arm64: dts: sparx5: Add basic cpu support")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Link: https://lore.kernel.org/r/20230221105039.316819-1-robert.marko@sartura.hr
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi            |  2 +-
 arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 2dd5e38820b16..088d89801c276 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -61,7 +61,7 @@ arm-pmu {
 		interrupt-affinity = <&cpu0>, <&cpu1>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
 	};
diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
index 9d1a082de3e29..32bb76b3202a0 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
@@ -6,6 +6,18 @@
 /dts-v1/;
 #include "sparx5.dtsi"
 
+&psci {
+	status = "disabled";
+};
+
+&cpu0 {
+	enable-method = "spin-table";
+};
+
+&cpu1 {
+	enable-method = "spin-table";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.39.2



