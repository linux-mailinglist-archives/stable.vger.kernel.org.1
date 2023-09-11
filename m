Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A60279BF67
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358333AbjIKWIg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241671AbjIKPLd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:11:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10451FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:11:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D29C433C9;
        Mon, 11 Sep 2023 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445088;
        bh=QfoZjAqwBJgcQYxB6e8EEd2Xyb16AjlklHmWaZOdaJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FA/nwUJ7hRuDRfsmWqDTPfET9Jd8UGXjGQuBgu5vyaOPvtkaTp0sv9hpvNFHIp5Bp
         QklmyzrExp5gw1Nwix82uHyTY7SZqWE/ai3pXUrwxpcugp+PmkJeiBDcGAFqKLvwa/
         2Cku6KHeChd/9+2/SJPBAqMQOE4XmzYRByxFPFpw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 224/600] arm64: dts: qcom: sm8250: correct dynamic power coefficients
Date:   Mon, 11 Sep 2023 15:44:17 +0200
Message-ID: <20230911134640.227920982@linuxfoundation.org>
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

From: Vincent Guittot <vincent.guittot@linaro.org>

[ Upstream commit 775a5283c25d160b2a1359018c447bc518096547 ]

sm8250 faces the same problem with its Energy Model as sdm845. The energy
cost of LITTLE cores is reported to be higher than medium or big cores

EM computes the energy with formula:

energy = OPP's cost / maximum cpu capacity * utilization

On v6.4-rc6 we have:
max capacity of CPU0 = 284
capacity of CPU0's OPP(1612800 Hz) = 253
cost of CPU0's OPP(1612800 Hz) = 191704

max capacity of CPU4 = 871
capacity of CPU4's OPP(710400 Hz) = 255
cost of CPU4's OPP(710400 Hz) = 343217

Both OPPs have almost the same compute capacity but the estimated energy
per unit of utilization will be estimated to:

energy CPU0 = 191704 / 284 * 1 = 675
energy CPU4 = 343217 / 871 * 1 = 394

EM estimates that little CPU0 will consume 71% more than medium CPU4 for
the same compute capacity. According to [1], little consumes 25% less than
medium core for Coremark benchmark at those OPPs for the same duration.

Set the dynamic-power-coefficient of CPU0-3 to 105 to fix the energy model
for little CPUs.

[1] https://github.com/kdrag0n/freqbench/tree/master/results/sm8250/k30s

Fixes: 6aabed5526ee ("arm64: dts: qcom: sm8250: Add CPU capacities and energy model")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20230615154852.130076-1-vincent.guittot@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index e93955525a107..c27f88c9f7b2a 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -99,7 +99,7 @@ CPU0: cpu@0 {
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <448>;
-			dynamic-power-coefficient = <205>;
+			dynamic-power-coefficient = <105>;
 			next-level-cache = <&L2_0>;
 			power-domains = <&CPU_PD0>;
 			power-domain-names = "psci";
@@ -123,7 +123,7 @@ CPU1: cpu@100 {
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <448>;
-			dynamic-power-coefficient = <205>;
+			dynamic-power-coefficient = <105>;
 			next-level-cache = <&L2_100>;
 			power-domains = <&CPU_PD1>;
 			power-domain-names = "psci";
@@ -144,7 +144,7 @@ CPU2: cpu@200 {
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <448>;
-			dynamic-power-coefficient = <205>;
+			dynamic-power-coefficient = <105>;
 			next-level-cache = <&L2_200>;
 			power-domains = <&CPU_PD2>;
 			power-domain-names = "psci";
@@ -165,7 +165,7 @@ CPU3: cpu@300 {
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <448>;
-			dynamic-power-coefficient = <205>;
+			dynamic-power-coefficient = <105>;
 			next-level-cache = <&L2_300>;
 			power-domains = <&CPU_PD3>;
 			power-domain-names = "psci";
-- 
2.40.1



