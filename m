Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388CB7ECB24
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbjKOTUY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjKOTUX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:20:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAB9D48
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:20:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911A4C433C9;
        Wed, 15 Nov 2023 19:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076019;
        bh=Llzz/7qhMJnTHegrrt1WY491fpd405+7tCvU563wJGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQBP6P17Ko7535iTPofUO28/rJrH9PhiS1YBlaW4tT4tnEmuXHpd0C0tnFQT397VW
         hawUv6kMbazV2OuVcEsAbM5ESrUGq47RBgTYyxbedr0YjvEoilWJ7wmlG2XHjjvfxA
         gH8TpsDyo79Jd0g8a40bxKQdA/xE8nXf4uHWwu48=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 024/550] cpu/SMT: Create topology_smt_thread_allowed()
Date:   Wed, 15 Nov 2023 14:10:08 -0500
Message-ID: <20231115191602.398456249@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit 38253464bc821d6de6bba81bb1412ebb36f6cbd1 ]

Some architectures allows partial SMT states, i.e. when not all SMT threads
are brought online.

To support that, add an architecture helper which checks whether a given
CPU is allowed to be brought online depending on how many SMT threads are
currently enabled. Since this is only applicable to architecture supporting
partial SMT, only these architectures should select the new configuration
variable CONFIG_SMT_NUM_THREADS_DYNAMIC. For the other architectures, not
supporting the partial SMT states, there is no need to define
topology_cpu_smt_allowed(), the generic code assumed that all the threads
are allowed or only the primary ones.

Call the helper from cpu_smt_enable(), and cpu_smt_allowed() when SMT is
enabled, to check if the particular thread should be onlined. Notably,
also call it from cpu_smt_disable() if CPU_SMT_ENABLED, to allow
offlining some threads to move from a higher to lower number of threads
online.

[ ldufour: Slightly reword the commit's description ]
[ ldufour: Introduce CONFIG_SMT_NUM_THREADS_DYNAMIC ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230705145143.40545-7-ldufour@linux.ibm.com
Stable-dep-of: d91bdd96b55c ("cpu/SMT: Make SMT control more robust against enumeration failures")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/Kconfig |  3 +++
 kernel/cpu.c | 24 +++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index aff2746c8af28..63c5d6a2022bc 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -34,6 +34,9 @@ config ARCH_HAS_SUBPAGE_FAULTS
 config HOTPLUG_SMT
 	bool
 
+config SMT_NUM_THREADS_DYNAMIC
+	bool
+
 # Selected by HOTPLUG_CORE_SYNC_DEAD or HOTPLUG_CORE_SYNC_FULL
 config HOTPLUG_CORE_SYNC
 	bool
diff --git a/kernel/cpu.c b/kernel/cpu.c
index dd59ffeacff2e..21864899c770a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -625,9 +625,23 @@ static int __init smt_cmdline_disable(char *str)
 }
 early_param("nosmt", smt_cmdline_disable);
 
+/*
+ * For Archicture supporting partial SMT states check if the thread is allowed.
+ * Otherwise this has already been checked through cpu_smt_max_threads when
+ * setting the SMT level.
+ */
+static inline bool cpu_smt_thread_allowed(unsigned int cpu)
+{
+#ifdef CONFIG_SMT_NUM_THREADS_DYNAMIC
+	return topology_smt_thread_allowed(cpu);
+#else
+	return true;
+#endif
+}
+
 static inline bool cpu_smt_allowed(unsigned int cpu)
 {
-	if (cpu_smt_control == CPU_SMT_ENABLED)
+	if (cpu_smt_control == CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
 		return true;
 
 	if (topology_is_primary_thread(cpu))
@@ -2644,6 +2658,12 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	for_each_online_cpu(cpu) {
 		if (topology_is_primary_thread(cpu))
 			continue;
+		/*
+		 * Disable can be called with CPU_SMT_ENABLED when changing
+		 * from a higher to lower number of SMT threads per core.
+		 */
+		if (ctrlval == CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
+			continue;
 		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
 		if (ret)
 			break;
@@ -2678,6 +2698,8 @@ int cpuhp_smt_enable(void)
 		/* Skip online CPUs and CPUs on offline nodes */
 		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
 			continue;
+		if (!cpu_smt_thread_allowed(cpu))
+			continue;
 		ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
 		if (ret)
 			break;
-- 
2.42.0



