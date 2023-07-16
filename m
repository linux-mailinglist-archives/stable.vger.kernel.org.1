Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A79275529E
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjGPUJy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjGPUJy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:09:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC979B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:09:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95D8460EA6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12ADC433C8;
        Sun, 16 Jul 2023 20:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538192;
        bh=7CyZ9Se5iyVlpgCPS0OulQndlhx6cRyDUzwrdGVPgI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z+XENF8KxIRJrixaNkkRJ4ozfXEF1PKgdpJcRhs5E+rwLDHPWPHyHlBG/IDASwMsh
         /54DUewdqSG8ykaKP1wpDl85YH09Kv5xk0+OYdmDF+HnHUil/ogdwQKMrtxEwknmHB
         VnzI9r7IYDU0w3YbTY1wB7/3w4wliHI/C2h3h16U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 364/800] MIPS: DTS: CI20: Fix ACT8600 regulator node names
Date:   Sun, 16 Jul 2023 21:43:37 +0200
Message-ID: <20230716194957.533609145@linuxfoundation.org>
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

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit 08384e80a70fb1942510ab5f0ce27bad134e634e ]

The Device Tree was using invalid node names for the ACT8600 regulators.
To be fair, it is not the original committer's fault, as the
documentation did gives invalid names as well.

In theory, the fix should have been to modify the driver to accept the
alternative names. However, even though the act8865 driver spits
warnings, the kernel seemed to work fine with what is currently
supported upstream. For that reason, I think it is okay to just update
the DTS.

I removed the "regulator-name" too, since they really didn't bring any
information. The node names are enough.

Fixes: 73f2b940474d ("MIPS: CI20: DTS: Add I2C nodes")
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 239c4537484d0..2b1284c6c64a6 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -237,59 +237,49 @@ &i2c0 {
 	act8600: act8600@5a {
 		compatible = "active-semi,act8600";
 		reg = <0x5a>;
-		status = "okay";
 
 		regulators {
-			vddcore: SUDCDC1 {
-				regulator-name = "DCDC_REG1";
+			vddcore: DCDC1 {
 				regulator-min-microvolt = <1100000>;
 				regulator-max-microvolt = <1100000>;
 				regulator-always-on;
 			};
-			vddmem: SUDCDC2 {
-				regulator-name = "DCDC_REG2";
+			vddmem: DCDC2 {
 				regulator-min-microvolt = <1500000>;
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 			};
-			vcc_33: SUDCDC3 {
-				regulator-name = "DCDC_REG3";
+			vcc_33: DCDC3 {
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-always-on;
 			};
-			vcc_50: SUDCDC4 {
-				regulator-name = "SUDCDC_REG4";
+			vcc_50: SUDCDC_REG4 {
 				regulator-min-microvolt = <5000000>;
 				regulator-max-microvolt = <5000000>;
 				regulator-always-on;
 			};
-			vcc_25: LDO_REG5 {
-				regulator-name = "LDO_REG5";
+			vcc_25: LDO5 {
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
 				regulator-always-on;
 			};
-			wifi_io: LDO_REG6 {
-				regulator-name = "LDO_REG6";
+			wifi_io: LDO6 {
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
 				regulator-always-on;
 			};
-			vcc_28: LDO_REG7 {
-				regulator-name = "LDO_REG7";
+			cim_io_28: LDO7 {
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				regulator-always-on;
 			};
-			vcc_15: LDO_REG8 {
-				regulator-name = "LDO_REG8";
+			cim_io_15: LDO8 {
 				regulator-min-microvolt = <1500000>;
 				regulator-max-microvolt = <1500000>;
 				regulator-always-on;
 			};
 			vrtc_18: LDO_REG9 {
-				regulator-name = "LDO_REG9";
 				/* Despite the datasheet stating 3.3V
 				 * for REG9 and the driver expecting that,
 				 * REG9 outputs 1.8V.
@@ -303,7 +293,6 @@ vrtc_18: LDO_REG9 {
 				regulator-always-on;
 			};
 			vcc_11: LDO_REG10 {
-				regulator-name = "LDO_REG10";
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <1200000>;
 				regulator-always-on;
-- 
2.39.2



