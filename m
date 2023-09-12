Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6389479BC44
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348008AbjIKV2h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240587AbjIKOsM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:48:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F63125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:48:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DC1C433C9;
        Mon, 11 Sep 2023 14:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443687;
        bh=hX5E+jUmdd65OsrFBNZ1odvQAe2ASX4fa9S6GL2hwfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KoftGmuOo59qZwwZfdg/v4tmdS9R3slzhzwV8DDnXgbpHTMyK2ydm4GczD/g8WzCv
         6RDK7WH5ZrUwxlZ+5qXl+fTEz6hXP+5Y6KIO/c/49a5LYpbRsVucatPNDbeVTlFHuV
         rlDEH4AD/Gv5r3RWiD9abV8fjhAkdIehEMAhog9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Russell Currey <ruscur@russell.cc>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 466/737] powerpc/pseries: Rework lppaca_shared_proc() to avoid DEBUG_PREEMPT
Date:   Mon, 11 Sep 2023 15:45:25 +0200
Message-ID: <20230911134703.607656248@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell Currey <ruscur@russell.cc>

[ Upstream commit eac030b22ea12cdfcbb2e941c21c03964403c63f ]

lppaca_shared_proc() takes a pointer to the lppaca which is typically
accessed through get_lppaca().  With DEBUG_PREEMPT enabled, this leads
to checking if preemption is enabled, for example:

  BUG: using smp_processor_id() in preemptible [00000000] code: grep/10693
  caller is lparcfg_data+0x408/0x19a0
  CPU: 4 PID: 10693 Comm: grep Not tainted 6.5.0-rc3 #2
  Call Trace:
    dump_stack_lvl+0x154/0x200 (unreliable)
    check_preemption_disabled+0x214/0x220
    lparcfg_data+0x408/0x19a0
    ...

This isn't actually a problem however, as it does not matter which
lppaca is accessed, the shared proc state will be the same.
vcpudispatch_stats_procfs_init() already works around this by disabling
preemption, but the lparcfg code does not, erroring any time
/proc/powerpc/lparcfg is accessed with DEBUG_PREEMPT enabled.

Instead of disabling preemption on the caller side, rework
lppaca_shared_proc() to not take a pointer and instead directly access
the lppaca, bypassing any potential preemption checks.

Fixes: f13c13a00512 ("powerpc: Stop using non-architected shared_proc field in lppaca")
Signed-off-by: Russell Currey <ruscur@russell.cc>
[mpe: Rework to avoid needing a definition in paca.h and lppaca.h]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230823055317.751786-4-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/lppaca.h        | 11 +++++++++--
 arch/powerpc/platforms/pseries/lpar.c    | 10 +---------
 arch/powerpc/platforms/pseries/lparcfg.c |  4 ++--
 arch/powerpc/platforms/pseries/setup.c   |  2 +-
 drivers/cpuidle/cpuidle-pseries.c        |  8 +-------
 5 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index fe278172e9d42..ee1488d38fdc1 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -45,6 +45,7 @@
 #include <asm/types.h>
 #include <asm/mmu.h>
 #include <asm/firmware.h>
+#include <asm/paca.h>
 
 /*
  * The lppaca is the "virtual processor area" registered with the hypervisor,
@@ -127,14 +128,20 @@ struct lppaca {
  */
 #define LPPACA_OLD_SHARED_PROC		2
 
-static inline bool lppaca_shared_proc(struct lppaca *l)
+#ifdef CONFIG_PPC_PSERIES
+/*
+ * All CPUs should have the same shared proc value, so directly access the PACA
+ * to avoid false positives from DEBUG_PREEMPT.
+ */
+static inline bool lppaca_shared_proc(void)
 {
+	struct lppaca *l = local_paca->lppaca_ptr;
+
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return false;
 	return !!(l->__old_status & LPPACA_OLD_SHARED_PROC);
 }
 
-#ifdef CONFIG_PPC_PSERIES
 #define get_lppaca()	(get_paca()->lppaca_ptr)
 #endif
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 2eab323f69706..cb2f1211f7ebf 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -639,16 +639,8 @@ static const struct proc_ops vcpudispatch_stats_freq_proc_ops = {
 
 static int __init vcpudispatch_stats_procfs_init(void)
 {
-	/*
-	 * Avoid smp_processor_id while preemptible. All CPUs should have
-	 * the same value for lppaca_shared_proc.
-	 */
-	preempt_disable();
-	if (!lppaca_shared_proc(get_lppaca())) {
-		preempt_enable();
+	if (!lppaca_shared_proc())
 		return 0;
-	}
-	preempt_enable();
 
 	if (!proc_create("powerpc/vcpudispatch_stats", 0600, NULL,
 					&vcpudispatch_stats_proc_ops))
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 8acc705095209..1c151d77e74b3 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -206,7 +206,7 @@ static void parse_ppp_data(struct seq_file *m)
 	           ppp_data.active_system_procs);
 
 	/* pool related entries are appropriate for shared configs */
-	if (lppaca_shared_proc(get_lppaca())) {
+	if (lppaca_shared_proc()) {
 		unsigned long pool_idle_time, pool_procs;
 
 		seq_printf(m, "pool=%d\n", ppp_data.pool_num);
@@ -560,7 +560,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
 		   partition_potential_processors);
 
 	seq_printf(m, "shared_processor_mode=%d\n",
-		   lppaca_shared_proc(get_lppaca()));
+		   lppaca_shared_proc());
 
 #ifdef CONFIG_PPC_64S_HASH_MMU
 	if (!radix_enabled())
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index e2a57cfa6c837..0ef2a7e014aa1 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -847,7 +847,7 @@ static void __init pSeries_setup_arch(void)
 	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		vpa_init(boot_cpuid);
 
-		if (lppaca_shared_proc(get_lppaca())) {
+		if (lppaca_shared_proc()) {
 			static_branch_enable(&shared_processor);
 			pv_spinlocks_init();
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index a7d33f3ee01e7..14db9b7d985d1 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -414,13 +414,7 @@ static int __init pseries_idle_probe(void)
 		return -ENODEV;
 
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
-		/*
-		 * Use local_paca instead of get_lppaca() since
-		 * preemption is not disabled, and it is not required in
-		 * fact, since lppaca_ptr does not need to be the value
-		 * associated to the current CPU, it can be from any CPU.
-		 */
-		if (lppaca_shared_proc(local_paca->lppaca_ptr)) {
+		if (lppaca_shared_proc()) {
 			cpuidle_state_table = shared_states;
 			max_idle_state = ARRAY_SIZE(shared_states);
 		} else {
-- 
2.40.1



