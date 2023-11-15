Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93487ED0C2
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343630AbjKOT5X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343533AbjKOT5V (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:57:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C49189
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:57:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F27C433C7;
        Wed, 15 Nov 2023 19:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078237;
        bh=XwvQ25VxUBErvTZt/uzsLTbONwEy+7yzPD24zdaoZjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1vYusJ8RpCoP4Scql8WJ5ugGk/H4KvVret0vcoqMxUx3NdVQ0fDwZEe+z/x9zhEd
         cWDmB1jh5dHCsiLNfiasPUxFp1heOIcJaZVoeqNooClrioc8RUyR4nIA6DQmnWK7l0
         AD7B1dmZGFezEMypakw3iD2hNB0oYRqGIarZ4PyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bryan ODonoghue <bryan.odonoghue@linaro.org>,
        Gaurav Kohli <quic_gkohli@quicinc.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 162/379] arm64: dts: qcom: msm8916: Fix iommu local address range
Date:   Wed, 15 Nov 2023 14:23:57 -0500
Message-ID: <20231115192654.690368747@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gaurav Kohli <quic_gkohli@quicinc.com>

[ Upstream commit 2de8ee9f58fa51f707c71f8fbcd8470ab0078102 ]

Fix the apps iommu local address space range as per data sheet.

Fixes: 6a6729f38436 ("arm64: dts: qcom: msm8916: Add IOMMU support")
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Gaurav Kohli <quic_gkohli@quicinc.com>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230915143304.477-1-quic_gkohli@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index f84b3c1a03c53..bafac2cf7e3d6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1257,7 +1257,7 @@ apps_iommu: iommu@1ef0000 {
 			#size-cells = <1>;
 			#iommu-cells = <1>;
 			compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
-			ranges = <0 0x01e20000 0x40000>;
+			ranges = <0 0x01e20000 0x20000>;
 			reg = <0x01ef0000 0x3000>;
 			clocks = <&gcc GCC_SMMU_CFG_CLK>,
 				 <&gcc GCC_APSS_TCU_CLK>;
-- 
2.42.0



