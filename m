Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7A17A3BA8
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbjIQUUt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbjIQUUY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:20:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D716A10F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:20:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14E2C433C8;
        Sun, 17 Sep 2023 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982016;
        bh=gzCOzBRmgP41oHoDFU2KJM+9G7vE2EJS0VLeTgqK63o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ar5sZn1xIHkqRQj36LLI7iIfTLAoOFGc9Vtl472pMK+/j9sWw4VFqEUQKnj8i8Es9
         rjWhq1buJIS1KTEirJYkHKugqT7r8MHQoRPE+7Pmqihb/adVVTR/oPsLJD+Gg3Q7h/
         3R+jCLTZYAxyCd1Dxeds8XyJKAzjjiyB3F9cMpg8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 139/511] arm64: dts: qcom: sm8250: Mark PCIe hosts as DMA coherent
Date:   Sun, 17 Sep 2023 21:09:26 +0200
Message-ID: <20230917191117.218419579@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 339d38a436f30d0f874815eafc7de2257346bf26 ]

The PCIe hosts on SM8250 are cache-coherent. Mark them as such.

Fixes: e53bdfc00977 ("arm64: dts: qcom: sm8250: Add PCIe support")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230704-topic-8250_pcie_dmac-v1-1-799603a980b0@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 005e75dc6919e..5d6551e1fcd8d 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1439,6 +1439,7 @@ pcie0: pci@1c00000 {
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie0_default_state>;
+			dma-coherent;
 
 			status = "disabled";
 		};
@@ -1545,6 +1546,7 @@ pcie1: pci@1c08000 {
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie1_default_state>;
+			dma-coherent;
 
 			status = "disabled";
 		};
@@ -1653,6 +1655,7 @@ pcie2: pci@1c10000 {
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie2_default_state>;
+			dma-coherent;
 
 			status = "disabled";
 		};
-- 
2.40.1



