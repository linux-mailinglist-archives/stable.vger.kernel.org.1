Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC87719DCF
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjFAN03 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbjFAN0O (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:26:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8A2189
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:26:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C4F16447B
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6E7C433EF;
        Thu,  1 Jun 2023 13:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625963;
        bh=NUoxTZV/5qM4RbvWUWzC5OiA5G9fSYk9x5tSBkQQipk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDTPdfZBAeDlV/Kd2dZVsHfQS6ZZ1RQOfeAPDLjVCNkyZTOijLwI4SJeC7GxcO5bn
         F0eY3/KboNSp3VNXNcrE57j7LYreRsR/FZxaO1PugjxcYxqg1iIUAmPIfu+EMbPbs4
         FCZ+gDCXK3y+LbNzQgh71FYxdXLKhfolz+TSCQy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Marek Vasut <marex@denx.de>, Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 05/45] ARM: dts: imx6ull-dhcor: Set and limit the mode for PMIC buck 1, 2 and 3
Date:   Thu,  1 Jun 2023 14:21:01 +0100
Message-Id: <20230601131938.944127083@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christoph Niedermaier <cniedermaier@dh-electronics.com>

[ Upstream commit 892943d7729bbfb2edeed9e323eba9a5cec21c49 ]

According to Renesas Electronics (formerly Dialog Semiconductor), the
standard AUTO mode of the PMIC DA9061 can lead to stability problems
depending on the hardware revision. It is recommended to set a defined
mode such as PFM or PWM permanently. So set and limit the mode for
buck 1, 2 and 3 to a fixed one.

Fixes: 611b6c891e40 ("ARM: dts: imx6ull-dhcom: Add DH electronics DHCOM i.MX6ULL SoM and PDK2 board")
Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6ull-dhcor-som.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi b/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi
index 5882c7565f649..32a6022625d97 100644
--- a/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi
+++ b/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pwm/pwm.h>
+#include <dt-bindings/regulator/dlg,da9063-regulator.h>
 #include "imx6ull.dtsi"
 
 / {
@@ -84,16 +85,20 @@ onkey {
 
 		regulators {
 			vdd_soc_in_1v4: buck1 {
+				regulator-allowed-modes = <DA9063_BUCK_MODE_SLEEP>; /* PFM */
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-initial-mode = <DA9063_BUCK_MODE_SLEEP>;
 				regulator-max-microvolt = <1400000>;
 				regulator-min-microvolt = <1400000>;
 				regulator-name = "vdd_soc_in_1v4";
 			};
 
 			vcc_3v3: buck2 {
+				regulator-allowed-modes = <DA9063_BUCK_MODE_SYNC>; /* PWM */
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-initial-mode = <DA9063_BUCK_MODE_SYNC>;
 				regulator-max-microvolt = <3300000>;
 				regulator-min-microvolt = <3300000>;
 				regulator-name = "vcc_3v3";
@@ -106,8 +111,10 @@ vcc_3v3: buck2 {
 			 * the voltage is set to 1.5V.
 			 */
 			vcc_ddr_1v35: buck3 {
+				regulator-allowed-modes = <DA9063_BUCK_MODE_SYNC>; /* PWM */
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-initial-mode = <DA9063_BUCK_MODE_SYNC>;
 				regulator-max-microvolt = <1500000>;
 				regulator-min-microvolt = <1500000>;
 				regulator-name = "vcc_ddr_1v35";
-- 
2.39.2



