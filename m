Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A06713DFD
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjE1Tav (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjE1Tav (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:30:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882D8EC
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C78861D63
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37811C433EF;
        Sun, 28 May 2023 19:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302245;
        bh=834YX/0/RE92nZ3+SlAcAzzW44ch7gk7cGLTOVHCudY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwXLD9HM2UloRxwWnHbd78wGqa/2sUBoPJ21gSQ98BqBtoFtux0Lt0rRlciD1SUsX
         lqkBZzvUGvx1xgYuRrsA74Al/bEYXTYYJEQN/RF3arVMWk5u7BNjd9VhwXDbIeUdsl
         WdTF3+BFvaUkeEVZI0ywvjbUPbKP3ZZ7AVq1NL4o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.3 057/127] x86/topology: Fix erroneous smp_num_siblings on Intel Hybrid platforms
Date:   Sun, 28 May 2023 20:10:33 +0100
Message-Id: <20230528190838.227984820@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Zhang Rui <rui.zhang@intel.com>

commit edc0a2b5957652f4685ef3516f519f84807087db upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/topology.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -79,7 +79,7 @@ int detect_extended_topology_early(struc
 	 * initial apic id, which also represents 32-bit extended x2apic id.
 	 */
 	c->initial_apicid = edx;
-	smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 #endif
 	return 0;
 }
@@ -109,7 +109,8 @@ int detect_extended_topology(struct cpui
 	 */
 	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
 	c->initial_apicid = edx;
-	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 	die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
 	pkg_mask_width = die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);


