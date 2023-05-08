Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D96E6FAA9C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjEHLEW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjEHLD4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090833413D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:03:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87A9A60DE9
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F99C433D2;
        Mon,  8 May 2023 11:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543788;
        bh=08hUQEn+VYwrM7/bNpl17sYbHo5GpzvLyMux3XBKkmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=erWw2qv026uZzZlj4XF2Ck3UXoowKhLGW8tAmAWac+ulQ5HbDZf/Xg3fKfdNGYiYv
         XxEhW+3v1To4XpKheAM4fgCv3Am6aM1Pob8sPtuu0o5DDvkciafG8tdLKlJ7AtsD1N
         7I5xM8aJC8jTrNdZGuu09foR/YCm1RMLTOJaI5+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 201/694] arm64: dts: qcom: sm8550: misc style fixes
Date:   Mon,  8 May 2023 11:40:36 +0200
Message-Id: <20230508094438.920168452@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Neil Armstrong <neil.armstrong@linaro.org>

[ Upstream commit f03908b23f84ecd49f12facf4acf34c3ad24f27a ]

Miscellaneous DT fixes to remove spurious blank line and enhance readability.

Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
Fixes: d7da51db5b81 ("arm64: dts: qcom: sm8550: add display hardware devices")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230308-topic-sm8550-upstream-dt-fixups-v1-3-595b02067672@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 7da28b36470e8..f05cdb376a175 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -412,7 +412,6 @@
 			no-map;
 		};
 
-
 		hyp_tags_reserved_mem: hyp-tags-reserved-region@811d0000 {
 			reg = <0 0x811d0000 0 0x30000>;
 			no-map;
@@ -2195,7 +2194,8 @@
 
 				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
 						  <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
-				assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
+				assigned-clock-parents = <&mdss_dsi0_phy 0>,
+							 <&mdss_dsi0_phy 1>;
 
 				operating-points-v2 = <&mdss_dsi_opp_table>;
 
@@ -2287,8 +2287,10 @@
 
 				power-domains = <&rpmhpd SM8550_MMCX>;
 
-				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
-				assigned-clock-parents = <&mdss_dsi1_phy 0>, <&mdss_dsi1_phy 1>;
+				assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>,
+						  <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
+				assigned-clock-parents = <&mdss_dsi1_phy 0>,
+							 <&mdss_dsi1_phy 1>;
 
 				operating-points-v2 = <&mdss_dsi_opp_table>;
 
@@ -3156,7 +3158,7 @@
 
 		intc: interrupt-controller@17100000 {
 			compatible = "arm,gic-v3";
-			reg = <0 0x17100000 0 0x10000>,	/* GICD */
+			reg = <0 0x17100000 0 0x10000>,		/* GICD */
 			      <0 0x17180000 0 0x200000>;	/* GICR * 8 */
 			ranges;
 			#interrupt-cells = <3>;
-- 
2.39.2



