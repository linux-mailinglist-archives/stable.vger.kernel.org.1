Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595F57ECC15
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjKOT05 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjKOT0k (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:26:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1ABD5C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:26:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88937C433C9;
        Wed, 15 Nov 2023 19:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076396;
        bh=3DiZLQa/hgXFj4phstTErLDyO3H9cb6C2CUJnviu4Js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NA3D2G/LMddKo+HKQ7F7VCClrHvda/p5tylaXQm2nnC/gyyhUeSwG1VZ+xa74w7fj
         iG+wcNV/MEsr6xn+POayNA1vVVJ84jRJTCZUKMgVhwu/+6oFfo+i6bd5l2SFvfNUpO
         7gjezngxgcROXkhyxflJMhHAKLFwrs70nPoSmgik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 266/550] arm64: dts: qcom: sm6125: Pad APPS IOMMU address to 8 characters
Date:   Wed, 15 Nov 2023 14:14:10 -0500
Message-ID: <20231115191619.157471916@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marijn Suijten <marijn.suijten@somainline.org>

[ Upstream commit 310cdafc4a56827d1aeda7cc297939034adb8f99 ]

APPS IOMMU is the only node in sm6125.dtsi that doesn't have its
address padded to 8 hexadecimals; fix this by prepending a 0.

Fixes: 8ddb4bc3d3b5 ("arm64: dts: qcom: sm6125: Configure APPS SMMU")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Link: https://lore.kernel.org/r/20230723-sm6125-dpu-v4-2-a3f287dd6c07@somainline.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index a596baa6ce3eb..367a083786e07 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -1204,7 +1204,7 @@ spmi_bus: spmi@1c40000 {
 
 		apps_smmu: iommu@c600000 {
 			compatible = "qcom,sm6125-smmu-500", "qcom,smmu-500", "arm,mmu-500";
-			reg = <0xc600000 0x80000>;
+			reg = <0x0c600000 0x80000>;
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.42.0



