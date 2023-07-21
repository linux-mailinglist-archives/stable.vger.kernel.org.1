Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6924E75D228
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjGUS4h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjGUS4g (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:56:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CCA35AF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:56:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA68261D79
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7EDC433C8;
        Fri, 21 Jul 2023 18:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965791;
        bh=7/UNODC6QqytK2XtO1GR5CwVgbeQ7QWuiIlkWDJvCuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QmIAfsETKZJUUA8eFvCaYTKMMOR7EW6Puut+LetKNx4ARUniLC4dUNg3T2NMxC8en
         CDcQazlwaBAPKxACDaj85nQQTUEXJ2G4CfPtTVBHLlBpu/314eOntMjTuEfdpcefu8
         qRHCW9+3VZedGdtzDjpQeXrK3TaeLpAn7konwUEY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robert Marko <robert.marko@sartura.hr>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 116/532] arm64: dts: microchip: sparx5: do not use PSCI on reference boards
Date:   Fri, 21 Jul 2023 18:00:20 +0200
Message-ID: <20230721160620.810249972@linuxfoundation.org>
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
index 787ebcec121d6..a6405059636c3 100644
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



