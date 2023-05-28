Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71F3713A1A
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 16:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjE1Ofc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 10:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1Ofb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 10:35:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C21BD
        for <stable@vger.kernel.org>; Sun, 28 May 2023 07:35:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0035060D2E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 14:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C912C433D2;
        Sun, 28 May 2023 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685284529;
        bh=1aloG2ebKxgN/VIGXKH6JTE0ZsDy3s4xr9GZ1s6WVQ4=;
        h=Subject:To:Cc:From:Date:From;
        b=HLJSqCGPIedJgF1mFpCChxys7BtHAeXuQ92dKNpyG7w3xKbUJmSTOz6qFiPjvzoxy
         mp2HGHs1TXpTb2Fu8J3d9Ode7DLRR0QtX1Scv+awWy70JpH588LpsNsDuC4jHFLyW4
         28aMqM1nZon9t8W/EU4R5Ec9geMDhv5g/ETr4mV0=
Subject: FAILED: patch "[PATCH] x86/topology: Fix erroneous smp_num_siblings on Intel Hybrid" failed to apply to 4.14-stable tree
To:     rui.zhang@intel.com, dave.hansen@linux.intel.com,
        len.brown@intel.com, peterz@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 15:35:18 +0100
Message-ID: <2023052818-glider-vivacious-f7d5@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x edc0a2b5957652f4685ef3516f519f84807087db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052818-glider-vivacious-f7d5@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

edc0a2b59576 ("x86/topology: Fix erroneous smp_num_siblings on Intel Hybrid platforms")
7745f03eb395 ("x86/topology: Add CPUID.1F multi-die/package support")
95f3d39ccf7a ("x86/cpu/topology: Provide detect_extended_topology_early()")
55e6d279abd9 ("x86/cpu: Remove the pointless CPU printout")
9305bd6ca7b4 ("x86/CPU: Move x86_cpuinfo::x86_max_cores assignment to detect_num_cpu_cores()")
a2aa578fec8c ("x86/Centaur: Report correct CPU/cache topology")
2cc61be60e37 ("x86/CPU: Make intel_num_cpu_cores() generic")
b5cf8707e6c9 ("x86/CPU: Move cpu local function declarations to local header")
6c4f5abaf356 ("x86/CPU: Modify detect_extended_topology() to return result")
60882cc159e1 ("x86/Centaur: Initialize supported CPU features properly")
7d5905dc14a8 ("x86 / CPU: Always show current CPU frequency in /proc/cpuinfo")
b29c6ef7bb12 ("x86 / CPU: Avoid unnecessary IPIs in arch_freq_get_on_cpu()")
d6ec9d9a4def ("Merge branch 'x86-asm-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From edc0a2b5957652f4685ef3516f519f84807087db Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Thu, 23 Mar 2023 09:56:40 +0800
Subject: [PATCH] x86/topology: Fix erroneous smp_num_siblings on Intel Hybrid
 platforms

Traditionally, all CPUs in a system have identical numbers of SMT
siblings.  That changes with hybrid processors where some logical CPUs
have a sibling and others have none.

Today, the CPU boot code sets the global variable smp_num_siblings when
every CPU thread is brought up. The last thread to boot will overwrite
it with the number of siblings of *that* thread. That last thread to
boot will "win". If the thread is a Pcore, smp_num_siblings == 2.  If it
is an Ecore, smp_num_siblings == 1.

smp_num_siblings describes if the *system* supports SMT.  It should
specify the maximum number of SMT threads among all cores.

Ensure that smp_num_siblings represents the system-wide maximum number
of siblings by always increasing its value. Never allow it to decrease.

On MeteorLake-P platform, this fixes a problem that the Ecore CPUs are
not updated in any cpu sibling map because the system is treated as an
UP system when probing Ecore CPUs.

Below shows part of the CPU topology information before and after the
fix, for both Pcore and Ecore CPU (cpu0 is Pcore, cpu 12 is Ecore).
...
-/sys/devices/system/cpu/cpu0/topology/package_cpus:000fff
-/sys/devices/system/cpu/cpu0/topology/package_cpus_list:0-11
+/sys/devices/system/cpu/cpu0/topology/package_cpus:3fffff
+/sys/devices/system/cpu/cpu0/topology/package_cpus_list:0-21
...
-/sys/devices/system/cpu/cpu12/topology/package_cpus:001000
-/sys/devices/system/cpu/cpu12/topology/package_cpus_list:12
+/sys/devices/system/cpu/cpu12/topology/package_cpus:3fffff
+/sys/devices/system/cpu/cpu12/topology/package_cpus_list:0-21

Notice that the "before" 'package_cpus_list' has only one CPU.  This
means that userspace tools like lscpu will see a little laptop like
an 11-socket system:

-Core(s) per socket:  1
-Socket(s):           11
+Core(s) per socket:  16
+Socket(s):           1

This is also expected to make the scheduler do rather wonky things
too.

[ dhansen: remove CPUID detail from changelog, add end user effects ]

CC: stable@kernel.org
Fixes: bbb65d2d365e ("x86: use cpuid vector 0xb when available for detecting cpu topology")
Fixes: 95f3d39ccf7a ("x86/cpu/topology: Provide detect_extended_topology_early()")
Suggested-by: Len Brown <len.brown@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20230323015640.27906-1-rui.zhang%40intel.com

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 5e868b62a7c4..0270925fe013 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -79,7 +79,7 @@ int detect_extended_topology_early(struct cpuinfo_x86 *c)
 	 * initial apic id, which also represents 32-bit extended x2apic id.
 	 */
 	c->initial_apicid = edx;
-	smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 #endif
 	return 0;
 }
@@ -109,7 +109,8 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	 */
 	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
 	c->initial_apicid = edx;
-	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 	die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
 	pkg_mask_width = die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);

