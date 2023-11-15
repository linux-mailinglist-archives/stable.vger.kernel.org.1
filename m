Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D217ED645
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 22:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbjKOVwq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 16:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344510AbjKOU4B (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:56:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695ECD55
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:55:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D13CC4E778;
        Wed, 15 Nov 2023 20:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081755;
        bh=zD1s3NW3pjTlJauBy8DlMuSkVbdxeNaJrbal4MIsjB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOtAiDtHq02nY03J3Kgu1ZC1FJe67dottFU436WfRygUKzAjo7HuULft4bmcst0Xm
         5ejwBM+mJtqbvXWS21PbD2t+HctB5UN1iHJTjvV92zKmh50V6mCNjgBSSRRjba1LaZ
         ujbTOWXsZDUawlHEX0bZeLE33gZOAHyRpTu1sZzA=
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
Subject: [PATCH 5.10 080/191] arm64: dts: qcom: msm8916: Fix iommu local address range
Date:   Wed, 15 Nov 2023 15:45:55 -0500
Message-ID: <20231115204649.403242354@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115204644.490636297@linuxfoundation.org>
References: <20231115204644.490636297@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 5b79e4a373311..c39a299fc636f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1175,7 +1175,7 @@ apps_iommu: iommu@1ef0000 {
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



