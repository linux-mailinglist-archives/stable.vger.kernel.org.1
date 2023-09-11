Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4FB79BF77
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354295AbjIKVxV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbjIKOj3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:39:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D0CF2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:39:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA535C433C8;
        Mon, 11 Sep 2023 14:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443164;
        bh=epapR4rCWpbCcWOJ81lVy8k7uhU0Z+4x8bXmCQFJJi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WD6uPhXfiGomrAhenA6ZdXCuDwC4jZRPwmj5xhvw9e+S82YcZiZ8ygY3dnXuA0m5G
         ETs5TKbaDpdhgixzmP3CUVS1Ms2ztvYIG4XN05KmsisIEv/a5t0syM4nJFwuFydp8z
         C+UO1iFT1FF2asC2cQbUMfFz9G60Qac6gh+4CTsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Degdag Mohamed <degdagmohamed@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 281/737] arm64: dts: qcom: sm8150: use proper DSI PHY compatible
Date:   Mon, 11 Sep 2023 15:42:20 +0200
Message-ID: <20230911134658.418096283@linuxfoundation.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 3091e5820a367f3368132f57e0a9ba6d545da15d ]

The DSI PHY on the Qualcomm SM8150 platform requires platform-specific
handling. Use the proper SoC-specific compatible string for the DSI
PHYs.

Reported-by: Degdag Mohamed <degdagmohamed@gmail.com>
Fixes: 2ef3bb17c45c ("arm64: dts: qcom: sm8150: Add DISPCC node")
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230612031623.3620155-1-dmitry.baryshkov@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 27dcda0d4288f..fe2d401a858a7 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3805,7 +3805,7 @@ opp-358000000 {
 			};
 
 			mdss_dsi0_phy: phy@ae94400 {
-				compatible = "qcom,dsi-phy-7nm";
+				compatible = "qcom,dsi-phy-7nm-8150";
 				reg = <0 0x0ae94400 0 0x200>,
 				      <0 0x0ae94600 0 0x280>,
 				      <0 0x0ae94900 0 0x260>;
@@ -3879,7 +3879,7 @@ mdss_dsi1_out: endpoint {
 			};
 
 			mdss_dsi1_phy: phy@ae96400 {
-				compatible = "qcom,dsi-phy-7nm";
+				compatible = "qcom,dsi-phy-7nm-8150";
 				reg = <0 0x0ae96400 0 0x200>,
 				      <0 0x0ae96600 0 0x280>,
 				      <0 0x0ae96900 0 0x260>;
-- 
2.40.1



