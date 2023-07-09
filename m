Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C793D74C301
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjGIL1J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjGIL1I (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:27:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A0818F
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:27:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74B1E60BC9
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894FFC433C8;
        Sun,  9 Jul 2023 11:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902026;
        bh=aVqPtqN9KSC3+rXYxvR2XVxlvfASt2jscX6w0ita1PQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b+hkVO2hT98DMIszpsQe+s69fcTR9gy0l6J/g3bKKIiKTmn1HbIp+dmaupsaFBusI
         2hKy66EYHdvefdwn6in53rDQPiUKK1NDH6ade+40LbqMzPvLJtU3U5pJSjgMsdUN+f
         ir3aq4cwVPZJNafjYKIfe95lsmhQ3n3PFp+srgKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 230/431] arm64: dts: qcom: msm8976: correct MMC unit address
Date:   Sun,  9 Jul 2023 13:12:58 +0200
Message-ID: <20230709111456.559757483@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 80284797a4cb8ceae71e3c403bafc6648263a060 ]

Match unit-address to reg entry to fix dtbs W=1 warnings:

  Warning (simple_bus_reg): /soc@0/mmc@7824000: simple-bus unit address format error, expected "7824900"
  Warning (simple_bus_reg): /soc@0/mmc@7864000: simple-bus unit address format error, expected "7864900"
  Warning (simple_bus_reg): /soc@0/mmc@7a24000: simple-bus unit address format error, expected "7a24900"

Fixes: 0484d3ce0902 ("arm64: dts: qcom: Add DTS for MSM8976 and MSM8956 SoCs")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230419211856.79332-7-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8976.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index e55baafd9efd0..e1617b9a73df2 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -821,7 +821,7 @@ spmi_bus: spmi@200f000 {
 			cell-index = <0>;
 		};
 
-		sdhc_1: mmc@7824000 {
+		sdhc_1: mmc@7824900 {
 			compatible = "qcom,msm8976-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07824900 0x500>, <0x07824000 0x800>;
 			reg-names = "hc", "core";
@@ -837,7 +837,7 @@ sdhc_1: mmc@7824000 {
 			status = "disabled";
 		};
 
-		sdhc_2: mmc@7864000 {
+		sdhc_2: mmc@7864900 {
 			compatible = "qcom,msm8976-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07864900 0x11c>, <0x07864000 0x800>;
 			reg-names = "hc", "core";
@@ -956,7 +956,7 @@ otg: usb@78db000 {
 			#reset-cells = <1>;
 		};
 
-		sdhc_3: mmc@7a24000 {
+		sdhc_3: mmc@7a24900 {
 			compatible = "qcom,msm8976-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x07a24900 0x11c>, <0x07a24000 0x800>;
 			reg-names = "hc", "core";
-- 
2.39.2



