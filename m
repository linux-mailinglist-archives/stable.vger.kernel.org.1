Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D95779BF90
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbjIKVLA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240429AbjIKOoB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:44:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47872CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:43:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0DDC433C8;
        Mon, 11 Sep 2023 14:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443435;
        bh=/vJ8Kt3PKBK/kHx3NG+c35hyIct0noXuk6tulHHOuCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2BqMoACsxlslE+jXKWrt2+yATxu9R16lXRshrPVXg6osBt1fQF860HTTrMTLrh+Hh
         E8c+/GpyeqHVxSeLmbAmFqx3dfkBmq7hkVnyhLZGZXaPoSEj7hmOMcRzGtQHBgffVy
         4VkPqtugiXePtJ2ndJ2ELUFVuLML19h/dQH03WP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robert Marko <robert.marko@sartura.hr>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 377/737] ARM: dts: qcom: ipq4019: correct SDHCI XO clock
Date:   Mon, 11 Sep 2023 15:43:56 +0200
Message-ID: <20230911134701.098904985@linuxfoundation.org>
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

From: Robert Marko <robert.marko@sartura.hr>

[ Upstream commit b5ed7a5c1fdb3981713f7b637b72aa390c3db036 ]

Using GCC_DCD_XO_CLK as the XO clock for SDHCI controller is not correct,
it seems that I somehow made a mistake of passing it instead of the fixed
XO clock.

Fixes: 04b3b72b5b8f ("ARM: dts: qcom: ipq4019: Add SDHCI controller node")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230811110150.229966-1-robert.marko@sartura.hr
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index f0ef86fadc9d9..e328216443135 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -230,9 +230,12 @@ sdhci: mmc@7824900 {
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
 			bus-width = <8>;
-			clocks = <&gcc GCC_SDCC1_AHB_CLK>, <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&gcc GCC_DCD_XO_CLK>;
-			clock-names = "iface", "core", "xo";
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>,
+				 <&xo>;
+			clock-names = "iface",
+				      "core",
+				      "xo";
 			status = "disabled";
 		};
 
-- 
2.40.1



