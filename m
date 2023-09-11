Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346DB79BFE4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379590AbjIKWpB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbjIKODL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:03:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6C8CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:03:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A27C433CA;
        Mon, 11 Sep 2023 14:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440987;
        bh=lI43M3o8MaSl4Gl0wyYl26uLCRABMF5017jQrIYHFec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZi8WzuzUV5fHqX7x+F74Bta4y2zGUXF553+0fvjqIamsYlAPkyXVHlq8vy0mQmqO
         KV6390rgjFiYVmuf+uZ5n5x0VsBg3r0xfq16UiypgMWd3TTpW2fJAxbRLofxxNl/DK
         fbVAJZZdghKdtJhTd++oevXpbUsvodUzu4ofYZDU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 229/739] arm64: dts: qcom: sm8350: Add missing LMH interrupts to cpufreq
Date:   Mon, 11 Sep 2023 15:40:28 +0200
Message-ID: <20230911134657.569780871@linuxfoundation.org>
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

[ Upstream commit 951151c2bb548e0f6b2c40ab4c48675f5342c914 ]

Add the missing interrupts that communicate the hardware-managed
throttling to Linux.

Fixes: ccbb3abb23a5 ("arm64: dts: qcom: sm8350: Add cpufreq node")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230705-topic-sm8350_fixes-v1-3-0f69f70ccb6a@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 318ec37da5cd6..35b68de50e227 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -3399,6 +3399,13 @@ cpufreq_hw: cpufreq@18591000 {
 			      <0 0x18593000 0 0x1000>;
 			reg-names = "freq-domain0", "freq-domain1", "freq-domain2";
 
+			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "dcvsh-irq-0",
+					  "dcvsh-irq-1",
+					  "dcvsh-irq-2";
+
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GCC_GPLL0>;
 			clock-names = "xo", "alternate";
 
-- 
2.40.1



