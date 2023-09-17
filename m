Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA7C7A3BA1
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbjIQUUU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240781AbjIQUT5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:19:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADE2101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:19:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0B4C433C7;
        Sun, 17 Sep 2023 20:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981992;
        bh=ElmzyMbt+jrh8D499sen3H/rcq2c77XH+2n0ZxSx914=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SuL/HokoC8OPkWB7rf5mCIskVk3RNSFBEmXIIlR1A45R9OjJUguSKDXahaGh7G5ej
         zZuf3hCEVVEjwxu81vCJhwnNjW2p7OGa3kkY8i45NfFHQi2nqWhCCM4ZUpnyG5mLnu
         hBDGNiMWQPT6Z0Qp+2fbs7a6JEp3BkiYOYHYquwk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 136/511] arm64: dts: qcom: sm8350: Add missing LMH interrupts to cpufreq
Date:   Sun, 17 Sep 2023 21:09:23 +0200
Message-ID: <20230917191117.148272713@linuxfoundation.org>
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
index 1ef16975d13a1..635e9f17a549f 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1052,6 +1052,13 @@ cpufreq_hw: cpufreq@18591000 {
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



