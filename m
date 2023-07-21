Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D22875D258
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGUS6j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjGUS6i (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:58:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9986E30CF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:58:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3097D61D82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42773C433C8;
        Fri, 21 Jul 2023 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965915;
        bh=PMBJsMkFykAf6X8rTs8rOCsR1p+vlUCBEtCBWalm45U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bWv7anmenes1Yq19+qcyTs8WRK+umn+zRxu/lbBzxMVp8Tx4JpWGKRxeq9ldfi8K8
         D6RhK9lwrKls7kICFkoIb4lEEvm91YZKGmv868SmQDngZTXVYykGzkq+RsLLXlxjAx
         owaPpIwb1rBb4AtYhT1PGHZYn44nt9FLZPUr448s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 132/532] arm64: dts: qcom: db820c: Move blsp1_uart2 pin states to msm8996.dtsi
Date:   Fri, 21 Jul 2023 18:00:36 +0200
Message-ID: <20230721160621.626858712@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

[ Upstream commit c57b4247faaf6d17a319c91d5eb736c3bc65aca2 ]

Move blsp1_uart2_default and blsp1_uart2_sleep to the SoC device tree to
avoid duplicating them in other device trees.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20210901193214.250375-2-y.oudjana@protonmail.com
Stable-dep-of: e27654df20d7 ("arm64: dts: qcom: apq8016-sbc: Fix regulator constraints")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 29 --------------------
 arch/arm64/boot/dts/qcom/msm8996.dtsi        | 17 ++++++++++++
 2 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 51e17094d7b18..eca428ab2517a 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -148,9 +148,6 @@ &blsp1_spi1 {
 &blsp1_uart2 {
 	label = "BT-UART";
 	status = "okay";
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&blsp1_uart2_default>;
-	pinctrl-1 = <&blsp1_uart2_sleep>;
 
 	bluetooth {
 		compatible = "qcom,qca6174-bt";
@@ -437,32 +434,6 @@ config {
 		};
 	};
 
-	blsp1_uart2_default: blsp1_uart2_default {
-		mux {
-			pins = "gpio41", "gpio42", "gpio43", "gpio44";
-			function = "blsp_uart2";
-		};
-
-		config {
-			pins = "gpio41", "gpio42", "gpio43", "gpio44";
-			drive-strength = <16>;
-			bias-disable;
-		};
-	};
-
-	blsp1_uart2_sleep: blsp1_uart2_sleep {
-		mux {
-			pins = "gpio41", "gpio42", "gpio43", "gpio44";
-			function = "gpio";
-		};
-
-		config {
-			pins = "gpio41", "gpio42", "gpio43", "gpio44";
-			drive-strength = <2>;
-			bias-disable;
-		};
-	};
-
 	hdmi_hpd_active: hdmi_hpd_active {
 		mux {
 			pins = "gpio34";
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 893c241f72030..ec3ef14048cc0 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1228,6 +1228,20 @@ wake {
 				};
 			};
 
+			blsp1_uart2_default: blsp1-uart2-default {
+				pins = "gpio41", "gpio42", "gpio43", "gpio44";
+				function = "blsp_uart2";
+				drive-strength = <16>;
+				bias-disable;
+			};
+
+			blsp1_uart2_sleep: blsp1-uart2-sleep {
+				pins = "gpio41", "gpio42", "gpio43", "gpio44";
+				function = "gpio";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			blsp1_i2c3_default: blsp1-i2c2-default {
 				pins = "gpio47", "gpio48";
 				function = "blsp_i2c3";
@@ -2724,6 +2738,9 @@ blsp1_uart2: serial@7570000 {
 			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
 			clock-names = "core", "iface";
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&blsp1_uart2_default>;
+			pinctrl-1 = <&blsp1_uart2_sleep>;
 			dmas = <&blsp1_dma 2>, <&blsp1_dma 3>;
 			dma-names = "tx", "rx";
 			status = "disabled";
-- 
2.39.2



