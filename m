Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5AC703A80
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244878AbjEORvk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244771AbjEORvQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:51:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7CE176F3
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:49:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C72062F1F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42983C4339C;
        Mon, 15 May 2023 17:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172959;
        bh=SMyDjsvPg0O3gSLkeDUOVPBL2g1q2ESth9owsfqiEPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2aeI3p+ywmiu/Hwd4BalsYmMdopVvEsJaRrsrChFhLe7yRUxAr3rJuaOHUgxhthfn
         I/YDCyUOH/X41m9NaTHPVk/pXcGCE5YORndc++U6mLRerV1LdT1eZvRMf3dqyUSI9y
         euI+V3A6drPvuP18gc8mL9z8qhE72GybmIk6O2Es=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 5.10 293/381] arm64: dts: qcom: sdm845: correct dynamic power coefficients - again
Date:   Mon, 15 May 2023 18:29:04 +0200
Message-Id: <20230515161750.024507265@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Vincent Guittot <vincent.guittot@linaro.org>

commit 44750f153699b6e4f851a399287e5c8df208d696 upstream.

While stressing EAS on my dragonboard RB3, I have noticed that LITTLE cores
where never selected as the most energy efficient CPU whatever the
utilization level of waking task.

energy model framework uses its cost field to estimate the energy with
the formula:

  nrg = cost of the selected OPP * utilization / CPU's max capacity

which ends up selecting the CPU with lowest cost / max capacity ration
as long as the utilization fits in the OPP's capacity.

If we compare the cost of a little OPP with similar capacity of a big OPP
like :
       OPP(kHz)   OPP capacity    cost     max capacity   cost/max capacity
LITTLE 1766400    407             351114   407            863
big    1056000    408             520267   1024           508

This can be interpreted as the LITTLE core consumes 70% more than big core
for the same compute capacity.

According to [1], LITTLE consumes 10% less than big core for Coremark
benchmark at those OPPs. If we consider that everything else stays
unchanged, the dynamic-power-coefficient of LITTLE core should be
only 53% of the current value: 290 * 53% = 154

Set the dynamic-power-coefficient of CPU0-3 to 154 to fix the energy model.

[1] https://github.com/kdrag0n/freqbench/tree/master/results/sdm845/main

Fixes: 0e0a8e35d725 ("arm64: dts: qcom: sdm845: correct dynamic power coefficients")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230106164618.1845281-1-vincent.guittot@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -197,7 +197,7 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <611>;
-			dynamic-power-coefficient = <290>;
+			dynamic-power-coefficient = <154>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -222,7 +222,7 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <611>;
-			dynamic-power-coefficient = <290>;
+			dynamic-power-coefficient = <154>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -244,7 +244,7 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <611>;
-			dynamic-power-coefficient = <290>;
+			dynamic-power-coefficient = <154>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
@@ -266,7 +266,7 @@
 					   &LITTLE_CPU_SLEEP_1
 					   &CLUSTER_SLEEP_0>;
 			capacity-dmips-mhz = <611>;
-			dynamic-power-coefficient = <290>;
+			dynamic-power-coefficient = <154>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
 			operating-points-v2 = <&cpu0_opp_table>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,


