Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D1979BE3A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351371AbjIKVnF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240465AbjIKOo5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:44:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A6D12A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:44:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF6CC433C8;
        Mon, 11 Sep 2023 14:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443492;
        bh=Hyb5+ZsvhQ2CaHSjvn7U7zH+pPczvySRWObgaaTtYPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTXNI6DUTWJ1b0WNDosyQe0wsoDDR0nItKshj6bml3/+dhEeGRyuRlZv2Q1JIDli1
         pyPJfLK8FZvbuUuHUr+r47Kz4z2Phfr0YxnTqnyFnc1MGdV5wldm1AH3X30KOJs43Z
         b6tL94FhLw8dd9ja1eerLR59nS9+2QdegQVk+19g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 389/737] arm64: dts: qcom: msm8998: Add missing power domain to MMSS SMMU
Date:   Mon, 11 Sep 2023 15:44:08 +0200
Message-ID: <20230911134701.456714850@linuxfoundation.org>
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

[ Upstream commit 7f828f3207142351750e9545527341425187de7b ]

The MMSS SMMU has its own power domain. Attach it so that we can drop
the "keep it always-on" hack.

Fixes: 05ce21b54423 ("arm64: dts: qcom: msm8998: Configure the multimedia subsystem iommu")
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230531-topic-8998_mmssclk-v3-2-ba1b1fd9ee75@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 0bc98d3602340..f7c2820b1aacb 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2455,6 +2455,8 @@ mmss_smmu: iommu@cd00000 {
 				<GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+
+			power-domains = <&mmcc BIMC_SMMU_GDSC>;
 		};
 
 		remoteproc_adsp: remoteproc@17300000 {
-- 
2.40.1



