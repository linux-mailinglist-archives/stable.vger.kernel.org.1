Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B2979C001
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359664AbjIKWSS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbjIKODI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:03:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B2FCD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:03:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCC4C433C7;
        Mon, 11 Sep 2023 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440984;
        bh=vzpqWc+a9ImDPnTujd2eE31OfhlY+RpdRFQL/98E+UU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vp9AH18ySWqnnCcKJ7kwis0xglkeeR91WlzHpisKo7QuKPcVR+iqYjVB/DYsUIFQ/
         kyODzkyjaEqwh3wlzTQu//rdUTcAOBgzyOhWdne6USD11F2qjMY2whcyAZJTG7vRZK
         iuCOfODPswCH9XLs1bP+kiEMfFYQlBRMDrq5xhQE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 228/739] arm64: dts: qcom: sm8350: Fix CPU idle state residency times
Date:   Mon, 11 Sep 2023 15:40:27 +0200
Message-ID: <20230911134657.543174521@linuxfoundation.org>
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

[ Upstream commit 91ce3693e2fb685f31d39605a5ad1fbd940804da ]

The present values look to have been copypasted from 8150 or 8180.
Fix that.

Fixes: 07ddb302811e ("arm64: dts: qcom: sm8350: Add CPU topology and idle-states")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230705-topic-sm8350_fixes-v1-2-0f69f70ccb6a@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index ec451c616f3e4..318ec37da5cd6 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -246,8 +246,8 @@ LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
 				compatible = "arm,idle-state";
 				idle-state-name = "silver-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000004>;
-				entry-latency-us = <355>;
-				exit-latency-us = <909>;
+				entry-latency-us = <360>;
+				exit-latency-us = <531>;
 				min-residency-us = <3934>;
 				local-timer-stop;
 			};
@@ -256,8 +256,8 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 				compatible = "arm,idle-state";
 				idle-state-name = "gold-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000004>;
-				entry-latency-us = <241>;
-				exit-latency-us = <1461>;
+				entry-latency-us = <702>;
+				exit-latency-us = <1061>;
 				min-residency-us = <4488>;
 				local-timer-stop;
 			};
-- 
2.40.1



