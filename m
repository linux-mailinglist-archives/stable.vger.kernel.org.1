Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D810879B998
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351154AbjIKVmr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbjIKPMZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:12:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67F8FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:12:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A3DC433C8;
        Mon, 11 Sep 2023 15:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445139;
        bh=WMgmYze9uiw9HUbn+Ok3wojIe8rPcRy6DIg94auhLJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZrkF7ysb+eHtNiInKYXIbcKoppFiZbceU9ACN7fMFXDrYS5eO7C/CPb7Y/a2GFWQh
         gYTYbUot+1RsA7uohjEC4B1F8e/4AMc3uLhzqFnMdtfud0bBzdO2I1fA1eam2pANoK
         DnqcyOISS+KRNRcymZmhCdMH6iv8QZI5Gm8Zj/ak=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 240/600] arm64: dts: qcom: sm8250: Mark PCIe hosts as DMA coherent
Date:   Mon, 11 Sep 2023 15:44:33 +0200
Message-ID: <20230911134640.684100670@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index c27f88c9f7b2a..4d9b30f0b2841 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1862,6 +1862,7 @@ pcie0: pci@1c00000 {
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie0_default_state>;
+			dma-coherent;
 
 			status = "disabled";
 		};
@@ -1968,6 +1969,7 @@ pcie1: pci@1c08000 {
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie1_default_state>;
+			dma-coherent;
 
 			status = "disabled";
 		};
@@ -2076,6 +2078,7 @@ pcie2: pci@1c10000 {
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie2_default_state>;
+			dma-coherent;
 
 			status = "disabled";
 		};
-- 
2.40.1



