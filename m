Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574047BDE72
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377057AbjJINTt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377045AbjJINTt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:19:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B836F91
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:19:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05669C433C9;
        Mon,  9 Oct 2023 13:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857585;
        bh=ljqZpdBqiCD+VKxaqKJq3zF0Jh1r3ylawd4mNTXe1YY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pf/5JEO/fLrW6dW0ur+9wniH/ZsUgRZ2RSnOdM05yeCPzxRW51bLRxiTcnWLQf3xn
         8eIkEc6AKP1aeOYEKwA9mxJkVG7llbJSMeYsxX/aBBF5gkemaLz7kXywPm4iBuMv17
         sbr9fK1CfvV4SgPFrRrvS6GK1elIRvs5I1bXKqjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sandipan Das <sandipan.das@amd.com>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 092/162] perf/x86/amd/core: Fix overflow reset on hotplug
Date:   Mon,  9 Oct 2023 15:01:13 +0200
Message-ID: <20231009130125.459317603@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sandipan Das <sandipan.das@amd.com>

[ Upstream commit 23d2626b841c2adccdeb477665313c02dff02dc3 ]

Kernels older than v5.19 do not support PerfMonV2 and the PMI handler
does not clear the overflow bits of the PerfCntrGlobalStatus register.
Because of this, loading a recent kernel using kexec from an older
kernel can result in inconsistent register states on Zen 4 systems.

The PMI handler of the new kernel gets confused and shows a warning when
an overflow occurs because some of the overflow bits are set even if the
corresponding counters are inactive. These are remnants from overflows
that were handled by the older kernel.

During CPU hotplug, the PerfCntrGlobalCtl and PerfCntrGlobalStatus
registers should always be cleared for PerfMonV2-capable processors.
However, a condition used for NB event constaints applicable only to
older processors currently prevents this from happening. Move the reset
sequence to an appropriate place and also clear the LBR Freeze bit.

Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/882a87511af40792ba69bb0e9026f19a2e71e8a3.1694696888.git.sandipan.das@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 6672a3f05fc68..bb9d99b45a459 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -534,8 +534,12 @@ static void amd_pmu_cpu_reset(int cpu)
 	/* Clear enable bits i.e. PerfCntrGlobalCtl.PerfCntrEn */
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
 
-	/* Clear overflow bits i.e. PerfCntrGLobalStatus.PerfCntrOvfl */
-	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, amd_pmu_global_cntr_mask);
+	/*
+	 * Clear freeze and overflow bits i.e. PerfCntrGLobalStatus.LbrFreeze
+	 * and PerfCntrGLobalStatus.PerfCntrOvfl
+	 */
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+	       GLOBAL_STATUS_LBRS_FROZEN | amd_pmu_global_cntr_mask);
 }
 
 static int amd_pmu_cpu_prepare(int cpu)
@@ -570,6 +574,7 @@ static void amd_pmu_cpu_starting(int cpu)
 	int i, nb_id;
 
 	cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
+	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
@@ -591,8 +596,6 @@ static void amd_pmu_cpu_starting(int cpu)
 
 	cpuc->amd_nb->nb_id = nb_id;
 	cpuc->amd_nb->refcnt++;
-
-	amd_pmu_cpu_reset(cpu);
 }
 
 static void amd_pmu_cpu_dead(int cpu)
@@ -601,6 +604,7 @@ static void amd_pmu_cpu_dead(int cpu)
 
 	kfree(cpuhw->lbr_sel);
 	cpuhw->lbr_sel = NULL;
+	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
@@ -613,8 +617,6 @@ static void amd_pmu_cpu_dead(int cpu)
 
 		cpuhw->amd_nb = NULL;
 	}
-
-	amd_pmu_cpu_reset(cpu);
 }
 
 static inline void amd_pmu_set_global_ctl(u64 ctl)
-- 
2.40.1



