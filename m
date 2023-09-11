Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5324B79B782
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244622AbjIKVIU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbjIKOCX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:02:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF73CE5
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:02:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85645C433C7;
        Mon, 11 Sep 2023 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440939;
        bh=rmA2ZigYZ7eiVQdVvPLOQCMg8zvUNZHYsV/lz0OQTgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmIhCfBrgPagOqjnbDAQ8oT2sLHOyiR5pmRwMpZSBho9F59FNS1VTGwdbxuicDOTM
         PnXz36v2bxq3TG0RdF+qYm8HpJJojr4WJ3GNrC5C8krorQjU5CSfLKrKTFhIsXaUXh
         1K8D6MxjANRz4MPQpaufQwOTLmtJKxNTRcarJUpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 239/739] arm64: dts: qcom: sm8250: Mark SMMUs as DMA coherent
Date:   Mon, 11 Sep 2023 15:40:38 +0200
Message-ID: <20230911134657.840432623@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 4cb19bd7c6329c4702f92c6dd4e7c02eb903ca13 ]

The SMMUs on SM8250 are cache-coherent. Mark them as such.

Fixes: a89441fcd09d ("arm64: dts: qcom: sm8250: add apps_smmu node")
Fixes: 04a3605b184e ("arm64: dts: qcom: add sm8250 GPU nodes")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230704-topic-8250_pcie_dmac-v1-2-799603a980b0@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index b811592f9b759..e03007e23e918 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2729,6 +2729,7 @@ adreno_smmu: iommu@3da0000 {
 			clock-names = "ahb", "bus", "iface";
 
 			power-domains = <&gpucc GPU_CX_GDSC>;
+			dma-coherent;
 		};
 
 		slpi: remoteproc@5c00000 {
@@ -5399,6 +5400,7 @@ apps_smmu: iommu@15000000 {
 				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
 		};
 
 		adsp: remoteproc@17300000 {
-- 
2.40.1



