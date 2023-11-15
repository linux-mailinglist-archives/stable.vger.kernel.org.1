Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3137ECCE0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbjKOTdI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjKOTdI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:33:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5209FA4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:33:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7659C433CB;
        Wed, 15 Nov 2023 19:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076784;
        bh=EGlBQYv/7VoH1+xFzBhd0GzxzlYuOpfREKviQfjPj/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PsZFdGH3ykxRGSG/KDhhSBBjMZAx5QZTNyH1i+fcacQyK7/UK87ZCLJcDrgYdtEm2
         UfGT7GGPJEvBiuYjjjMXMdEL83R/Qi17kfoVVkuEHbqXqmSjDddlBzfxiUlhPkLEit
         N1C6AvaPBs+B2vLr8gAIibiJ/k1P+cyltEqXAE+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 025/603] x86/apic: Fake primary thread mask for XEN/PV
Date:   Wed, 15 Nov 2023 14:09:30 -0500
Message-ID: <20231115191614.920169287@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 965e05ff8af98c44f9937366715c512000373164 ]

The SMT control mechanism got added as speculation attack vector
mitigation. The implemented logic relies on the primary thread mask to
be set up properly.

This turns out to be an issue with XEN/PV guests because their CPU hotplug
mechanics do not enumerate APICs and therefore the mask is never correctly
populated.

This went unnoticed so far because by chance XEN/PV ends up with
smp_num_siblings == 2. So cpu_smt_control stays at its default value
CPU_SMT_ENABLED and the primary thread mask is never evaluated in the
context of CPU hotplug.

This stopped "working" with the upcoming overhaul of the topology
evaluation which legitimately provides a fake topology for XEN/PV. That
sets smp_num_siblings to 1, which causes the core CPU hot-plug core to
refuse to bring up the APs.

This happens because cpu_smt_control is set to CPU_SMT_NOT_SUPPORTED which
causes cpu_bootable() to evaluate the unpopulated primary thread mask with
the conclusion that all non-boot CPUs are not valid to be plugged.

The core code has already been made more robust against this kind of fail,
but the primary thread mask really wants to be populated to avoid other
issues all over the place.

Just fake the mask by pretending that all XEN/PV vCPUs are primary threads,
which is consistent because all of XEN/PVs topology is fake or non-existent.

Fixes: 6a4d2657e048 ("x86/smp: Provide topology_is_primary_thread()")
Fixes: f54d4434c281 ("x86/apic: Provide cpu_primary_thread mask")
Reported-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085112.210011520@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/apic/apic.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 760adac3d1a82..3cdf48493546d 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -36,6 +36,8 @@
 #include <linux/smp.h>
 #include <linux/mm.h>
 
+#include <xen/xen.h>
+
 #include <asm/trace/irq_vectors.h>
 #include <asm/irq_remapping.h>
 #include <asm/pc-conf-reg.h>
@@ -2344,6 +2346,15 @@ static int __init smp_init_primary_thread_mask(void)
 {
 	unsigned int cpu;
 
+	/*
+	 * XEN/PV provides either none or useless topology information.
+	 * Pretend that all vCPUs are primary threads.
+	 */
+	if (xen_pv_domain()) {
+		cpumask_copy(&__cpu_primary_thread_mask, cpu_possible_mask);
+		return 0;
+	}
+
 	for (cpu = 0; cpu < nr_logical_cpuids; cpu++)
 		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
 	return 0;
-- 
2.42.0



