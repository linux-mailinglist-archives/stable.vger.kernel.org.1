Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFFF6FAD74
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbjEHLfF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbjEHLeq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:34:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E973D3E31A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1F9363235
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA6CC433EF;
        Mon,  8 May 2023 11:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545630;
        bh=5vb0kASsDos90wnTP2lJCWpx+TEOys0Iy4ogLbj+Yxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nknfMHVQqPovonL32CrB3ClQoob4XbRiQHwk7clyExTTsuPfiB3rD9nIjhCH1vUQ0
         j18vyqDV+sc0wIemg4aVIRhofBw/NTBmctX1A1jSvx6rqbuIQcqpsoKTPiwoZLDAVA
         /PKJiIUswn8e2Jo9QI51qGCLRRW+XYIkWK0uSdAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Danny Lin <danny@kdrag0n.dev>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 095/371] arm64: dts: qcom: sdm845: correct dynamic power coefficients
Date:   Mon,  8 May 2023 11:44:56 +0200
Message-Id: <20230508094815.820033555@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 0e0a8e35d72533b3eef3365e900baacd7cede8e2 ]

Following sm8150/sm8250 update sdm845 capacity-dmips-mhz and
dynamic-power-coefficient based on the measurements [1], [2].

The energy model dynamic-power-coefficient values were calculated with
    DPC = µW / MHz / V^2
for each OPP, and averaged across all OPPs within each cluster for the
final coefficient. Voltages were obtained from the qcom-cpufreq-hw
driver that reads voltages from the OSM LUT programmed into the SoC.

Normalized DMIPS/MHz capacity scale values for each CPU were calculated
from CoreMarks/MHz (CoreMark iterations per second per MHz), which
serves the same purpose. For each CPU, the final capacity-dmips-mhz
value is the C/MHz value of its maximum frequency normalized to
SCHED_CAPACITY_SCALE (1024) for the fastest CPU in the system.

For more details on measurement process see the commit message for the
commit 6aabed5526ee ("arm64: dts: qcom: sm8250: Add CPU capacities and
energy model").

[1] https://github.com/kdrag0n/freqbench
[2] https://github.com/kdrag0n/freqbench/tree/master/results/sdm845/main

Cc: Danny Lin <danny@kdrag0n.dev>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/r/20220315141104.730235-1-dmitry.baryshkov@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index ed293f635f145..26849cece1eb9 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -196,8 +196,8 @@
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			capacity-dmips-mhz = <607>;
-			dynamic-power-coefficient = <100>;
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <290>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -221,8 +221,8 @@
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			capacity-dmips-mhz = <607>;
-			dynamic-power-coefficient = <100>;
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <290>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -243,8 +243,8 @@
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			capacity-dmips-mhz = <607>;
-			dynamic-power-coefficient = <100>;
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <290>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -265,8 +265,8 @@
 			cpu-idle-states = <&LITTLE_CPU_SLEEP_0
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			capacity-dmips-mhz = <607>;
-			dynamic-power-coefficient = <100>;
+			capacity-dmips-mhz = <611>;
+			dynamic-power-coefficient = <290>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -288,7 +288,7 @@
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			dynamic-power-coefficient = <396>;
+			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -310,7 +310,7 @@
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			dynamic-power-coefficient = <396>;
+			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -332,7 +332,7 @@
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			dynamic-power-coefficient = <396>;
+			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -354,7 +354,7 @@
 			cpu-idle-states = <&BIG_CPU_SLEEP_0
 					   &BIG_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
-			dynamic-power-coefficient = <396>;
+			dynamic-power-coefficient = <442>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
 			operating-points-v2 = <&cpu4_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
-- 
2.39.2



