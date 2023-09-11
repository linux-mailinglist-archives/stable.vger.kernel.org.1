Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C618D79BAE0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359414AbjIKWQc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241717AbjIKPMr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:12:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A514CFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:12:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44C9C433C8;
        Mon, 11 Sep 2023 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445162;
        bh=i3zXFUPIWJBDKKP5F0uOd+NeV3hdzNOZoOu7Sjhn2J0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ox3E+bEc98K+lZ9L0dDPTZWF1VO+VRCOrBHIMW9Dmd8oHB0Vv0WUKhSgBfmFprqu9
         qz6lqOAAXC5VC+eTF75+voFiE4GLxQNwGU19Ki8MuZB2Y+VeCMVIYOIPKHAcXUVgfR
         VlXjn6ORyf0SnnFJ0I3AFWSx9TZWwv1GI924VsT0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 247/600] ARM: dts: stm32: Update to generic ADC channel binding on DHSOM systems
Date:   Mon, 11 Sep 2023 15:44:40 +0200
Message-ID: <20230911134640.885019773@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>

[ Upstream commit 9bcfc3cdc903485a52c6f471f4ae96a41fa51803 ]

The generic ADC channel binding is recommended over legacy one, update the
DT to the modern binding. No functional change. For further details, see
commit which adds the generic binding to STM32 ADC binding document:
'664b9879f56e ("dt-bindings: iio: stm32-adc: add generic channel binding")'

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
Stable-dep-of: deb7edbc27a6 ("ARM: dts: stm32: Add missing detach mailbox for DHCOM SoM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi  | 18 +++++----
 .../boot/dts/stm32mp15xx-dhcor-avenger96.dtsi | 38 +++++++++++++++----
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
index c06edd2eacb0c..e61df23d361a7 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
@@ -80,17 +80,19 @@ &adc {
 	vdda-supply = <&vdda>;
 	vref-supply = <&vdda>;
 	status = "okay";
+};
 
-	adc1: adc@0 {
-		st,min-sample-time-nsecs = <5000>;
-		st,adc-channels = <0>;
-		status = "okay";
+&adc1 {
+	channel@0 {
+		reg = <0>;
+		st,min-sample-time-ns = <5000>;
 	};
+};
 
-	adc2: adc@100 {
-		st,adc-channels = <1>;
-		st,min-sample-time-nsecs = <5000>;
-		status = "okay";
+&adc2 {
+	channel@1 {
+		reg = <1>;
+		st,min-sample-time-ns = <5000>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
index dae602b7a54df..b7ba43865514d 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi
@@ -112,17 +112,39 @@ &adc {
 	vdda-supply = <&vdda>;
 	vref-supply = <&vdda>;
 	status = "okay";
+};
 
-	adc1: adc@0 {
-		st,adc-channels = <0 1 6>;
-		st,min-sample-time-nsecs = <5000>;
-		status = "okay";
+&adc1 {
+	channel@0 {
+		reg = <0>;
+		st,min-sample-time-ns = <5000>;
 	};
 
-	adc2: adc@100 {
-		st,adc-channels = <0 1 2>;
-		st,min-sample-time-nsecs = <5000>;
-		status = "okay";
+	channel@1 {
+		reg = <1>;
+		st,min-sample-time-ns = <5000>;
+	};
+
+	channel@6 {
+		reg = <6>;
+		st,min-sample-time-ns = <5000>;
+	};
+};
+
+&adc2 {
+	channel@0 {
+		reg = <0>;
+		st,min-sample-time-ns = <5000>;
+	};
+
+	channel@1 {
+		reg = <1>;
+		st,min-sample-time-ns = <5000>;
+	};
+
+	channel@2 {
+		reg = <2>;
+		st,min-sample-time-ns = <5000>;
 	};
 };
 
-- 
2.40.1



