Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0E07ECC04
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjKOT01 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjKOT0L (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:26:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F17C1A8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:26:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CC4C433C8;
        Wed, 15 Nov 2023 19:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076368;
        bh=AKoCM3z0NPiNfD82F6eua9Y5Ltd2uMNh5X8gJMwyxyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFj4Sohbm11TQri+Pgd0ObpH6P/BRsimUz2rGuO49u9xS0yh2h8uD+Brkbs7CLtU2
         E7+txoEmcVNiFdQcRvaVcb0Wti3ema52B2K3iw+JizjLK8zq/f7Q/jrEhqW9FcelfL
         PLX+pjpC4duKAONXp61dfBQjWJsmdLh7P9oe7xcI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
        Bertrand Marquis <bertrand.marquis@arm.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 247/550] arm64/arm: xen: enlighten: Fix KPTI checks
Date:   Wed, 15 Nov 2023 14:13:51 -0500
Message-ID: <20231115191617.839026656@linuxfoundation.org>
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

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 20f3b8eafe0ba5d3c69d5011a9b07739e9645132 ]

When KPTI is in use, we cannot register a runstate region as XEN
requires that this is always a valid VA, which we cannot guarantee. Due
to this, xen_starting_cpu() must avoid registering each CPU's runstate
region, and xen_guest_init() must avoid setting up features that depend
upon it.

We tried to ensure that in commit:

  f88af7229f6f22ce (" xen/arm: do not setup the runstate info page if kpti is enabled")

... where we added checks for xen_kernel_unmapped_at_usr(), which wraps
arm64_kernel_unmapped_at_el0() on arm64 and is always false on 32-bit
arm.

Unfortunately, as xen_guest_init() is an early_initcall, this happens
before secondary CPUs are booted and arm64 has finalized the
ARM64_UNMAP_KERNEL_AT_EL0 cpucap which backs
arm64_kernel_unmapped_at_el0(), and so this can subsequently be set as
secondary CPUs are onlined. On a big.LITTLE system where the boot CPU
does not require KPTI but some secondary CPUs do, this will result in
xen_guest_init() intializing features that depend on the runstate
region, and xen_starting_cpu() registering the runstate region on some
CPUs before KPTI is subsequent enabled, resulting the the problems the
aforementioned commit tried to avoid.

Handle this more robsutly by deferring the initialization of the
runstate region until secondary CPUs have been initialized and the
ARM64_UNMAP_KERNEL_AT_EL0 cpucap has been finalized. The per-cpu work is
moved into a new hotplug starting function which is registered later
when we're certain that KPTI will not be used.

Fixes: f88af7229f6f ("xen/arm: do not setup the runstate info page if kpti is enabled")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Bertrand Marquis <bertrand.marquis@arm.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/xen/enlighten.c   | 25 ++++++++++++++++---------
 include/linux/cpuhotplug.h |  1 +
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 7d59765aef220..6cdcd39fb0961 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -164,9 +164,6 @@ static int xen_starting_cpu(unsigned int cpu)
 	BUG_ON(err);
 	per_cpu(xen_vcpu, cpu) = vcpup;
 
-	if (!xen_kernel_unmapped_at_usr())
-		xen_setup_runstate_info(cpu);
-
 after_register_vcpu_info:
 	enable_percpu_irq(xen_events_irq, 0);
 	return 0;
@@ -523,9 +520,6 @@ static int __init xen_guest_init(void)
 		return -EINVAL;
 	}
 
-	if (!xen_kernel_unmapped_at_usr())
-		xen_time_setup_guest();
-
 	if (xen_initial_domain())
 		pvclock_gtod_register_notifier(&xen_pvclock_gtod_notifier);
 
@@ -535,7 +529,13 @@ static int __init xen_guest_init(void)
 }
 early_initcall(xen_guest_init);
 
-static int __init xen_pm_init(void)
+static int xen_starting_runstate_cpu(unsigned int cpu)
+{
+	xen_setup_runstate_info(cpu);
+	return 0;
+}
+
+static int __init xen_late_init(void)
 {
 	if (!xen_domain())
 		return -ENODEV;
@@ -548,9 +548,16 @@ static int __init xen_pm_init(void)
 		do_settimeofday64(&ts);
 	}
 
-	return 0;
+	if (xen_kernel_unmapped_at_usr())
+		return 0;
+
+	xen_time_setup_guest();
+
+	return cpuhp_setup_state(CPUHP_AP_ARM_XEN_RUNSTATE_STARTING,
+				 "arm/xen_runstate:starting",
+				 xen_starting_runstate_cpu, NULL);
 }
-late_initcall(xen_pm_init);
+late_initcall(xen_late_init);
 
 
 /* empty stubs */
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 25b6e6e6ba6bc..f0231cc66746e 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -190,6 +190,7 @@ enum cpuhp_state {
 	/* Must be the last timer callback */
 	CPUHP_AP_DUMMY_TIMER_STARTING,
 	CPUHP_AP_ARM_XEN_STARTING,
+	CPUHP_AP_ARM_XEN_RUNSTATE_STARTING,
 	CPUHP_AP_ARM_CORESIGHT_STARTING,
 	CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
 	CPUHP_AP_ARM64_ISNDEP_STARTING,
-- 
2.42.0



