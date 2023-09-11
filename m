Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAE679AFC3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbjIKV0V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240518AbjIKOqY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:46:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB30106
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:46:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB4FC433C9;
        Mon, 11 Sep 2023 14:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443579;
        bh=cuOIeAWaJH+gn8pAUQ5v/JDB3KSUChyIolC4uHtGctg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=saHocYBAhxW8iIlWeQpqMsbrVBZh52dd1QBHue96EtnnGAXsZQ3M4VJ7xmlybwfmU
         wuVirLouHMXuEcg9F25uKS5NxmvO67DclRVZ1WaBAz64cgxW1K4tvjsfT0sOA2WLzi
         5OI8RfFT/qk6yhP36Tt0xoze4OqwzzcchZMTR0Xg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 388/737] arm64: dts: qcom: msm8998: Drop bus clock reference from MMSS SMMU
Date:   Mon, 11 Sep 2023 15:44:07 +0200
Message-ID: <20230911134701.427789792@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit a3ce236364b82688ca4c7605f63c4efd68e9589c ]

The MMSS SMMU has been abusingly consuming the exposed RPM interconnect
clock. Drop it.

Fixes: 05ce21b54423 ("arm64: dts: qcom: msm8998: Configure the multimedia subsystem iommu")
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230531-topic-8998_mmssclk-v3-1-ba1b1fd9ee75@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 3ec941fed14fe..0bc98d3602340 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2428,10 +2428,10 @@ mmss_smmu: iommu@cd00000 {
 
 			clocks = <&mmcc MNOC_AHB_CLK>,
 				 <&mmcc BIMC_SMMU_AHB_CLK>,
-				 <&rpmcc RPM_SMD_MMAXI_CLK>,
 				 <&mmcc BIMC_SMMU_AXI_CLK>;
-			clock-names = "iface-mm", "iface-smmu",
-				      "bus-mm", "bus-smmu";
+			clock-names = "iface-mm",
+				      "iface-smmu",
+				      "bus-smmu";
 
 			#global-interrupts = <0>;
 			interrupts =
-- 
2.40.1



