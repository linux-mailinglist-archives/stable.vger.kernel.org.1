Return-Path: <stable+bounces-65946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB0594AF7B
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 20:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25AC1F22B60
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5328F13D53F;
	Wed,  7 Aug 2024 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BFnDfoB7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oCi0/loU"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650F963CB;
	Wed,  7 Aug 2024 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054618; cv=none; b=A/ZoAKcSDyiKKPIfRnRjNYIuWxChHLG3nvLeaeGw98LMnr2yYMDMbrEGE6GPXBmJigxJjQNnpeaEEqRvacfzU4IF6xwWJGtk2JcUxYwCOstlU45qW1MHYCMcS515EADP0+vVtxjEZzIxq1mGj2taae2P30+ahajhLPVA8JbHs4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054618; c=relaxed/simple;
	bh=fovnZ+mR1PwPdA+bmfn7kZU6EdTCr9GwZubpU50GBSA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TDUV4aBBW1dA8BPBNOplOb9oD+WEqr0T+aAUC17o2BjAnSG7NvdKPwc55VsbHQIJrdKoMtndmiuyItD99CKUhN7+qDdiFPyX/R96P8VGAgwqs3610HTwhHppzospyqX7QqBFqz1y5KqdTdmdJ2bB/Nk+n4Wm1r4yHoSfL/SUqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BFnDfoB7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oCi0/loU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 18:16:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723054614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNLONl1f2zcfsl0InUB3MoJrhRtPKlaRMQA1J9B0LD4=;
	b=BFnDfoB7NMqV1tlQdm5lR34CKZx4H/KT0CRiEYxleRiOTykEENbPuajDovSe2CEeMPYum8
	5ankM/uyXCMsU1/FEBwOUIouW4bwjNDgNm36uIOC9VeqACTrDak3dMZ+liq94WP6vkzAmo
	qMRHqkNyrxRwXAxUI6e3lWKreVg/TXM+QylPdPvxihHk6hEpCtWAJIL/Kz9SBjYz0nWiiY
	kIgy5PApIvy22ww0LKqQo3pKQQS4HvgMulisi/0MPcjm+pGmoXAeM3WeOfCDynYmZRPOhN
	bPzNFhgQ/wx0ozeu6iLaE/DI6JgYeaJoeN7tT/TCMEbJRFf64dYVXZOa3qtrBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723054614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cNLONl1f2zcfsl0InUB3MoJrhRtPKlaRMQA1J9B0LD4=;
	b=oCi0/loUDkPuCiILYssPNQSYDXmIjhK8oxVVELIgwWBUxtosJKRiXWI95UW1kX68s+2Fim
	qG4+ZPJBG6hkCLDA==
From: "tip-bot2 for Chen Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/paravirt: Fix incorrect virt spinlock setting
 on bare metal
Cc: Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, Chen Yu <yu.c.chen@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240806112207.29792-1-yu.c.chen@intel.com>
References: <20240806112207.29792-1-yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172305461394.2215.8417540090685275248.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e639222a51196c69c70b49b67098ce2f9919ed08
Gitweb:        https://git.kernel.org/tip/e639222a51196c69c70b49b67098ce2f9919ed08
Author:        Chen Yu <yu.c.chen@intel.com>
AuthorDate:    Tue, 06 Aug 2024 19:22:07 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 20:04:38 +02:00

x86/paravirt: Fix incorrect virt spinlock setting on bare metal

The kernel can change spinlock behavior when running as a guest. But this
guest-friendly behavior causes performance problems on bare metal.

The kernel uses a static key to switch between the two modes.

In theory, the static key is enabled by default (run in guest mode) and
should be disabled for bare metal (and in some guests that want native
behavior or paravirt spinlock).

A performance drop is reported when running encode/decode workload and
BenchSEE cache sub-workload.

Bisect points to commit ce0a1b608bfc ("x86/paravirt: Silence unused
native_pv_lock_init() function warning"). When CONFIG_PARAVIRT_SPINLOCKS is
disabled the virt_spin_lock_key is incorrectly set to true on bare
metal. The qspinlock degenerates to test-and-set spinlock, which decreases
the performance on bare metal.

Set the default value of virt_spin_lock_key to false. If booting in a VM,
enable this key. Later during the VM initialization, if other
high-efficient spinlock is preferred (e.g. paravirt-spinlock), or the user
wants the native qspinlock (via nopvspin boot commandline), the
virt_spin_lock_key is disabled accordingly.

This results in the following decision matrix:

X86_FEATURE_HYPERVISOR         Y    Y       Y     N
CONFIG_PARAVIRT_SPINLOCKS      Y    Y       N     Y/N
PV spinlock                    Y    N       N     Y/N

virt_spin_lock_key             N    Y/N     Y     N

Fixes: ce0a1b608bfc ("x86/paravirt: Silence unused native_pv_lock_init() function warning")
Reported-by: Prem Nath Dey <prem.nath.dey@intel.com>
Reported-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Suggested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Suggested-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240806112207.29792-1-yu.c.chen@intel.com
---
 arch/x86/include/asm/qspinlock.h | 12 +++++++-----
 arch/x86/kernel/paravirt.c       |  7 +++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index a053c12..68da67d 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -66,13 +66,15 @@ static inline bool vcpu_is_preempted(long cpu)
 
 #ifdef CONFIG_PARAVIRT
 /*
- * virt_spin_lock_key - enables (by default) the virt_spin_lock() hijack.
+ * virt_spin_lock_key - disables by default the virt_spin_lock() hijack.
  *
- * Native (and PV wanting native due to vCPU pinning) should disable this key.
- * It is done in this backwards fashion to only have a single direction change,
- * which removes ordering between native_pv_spin_init() and HV setup.
+ * Native (and PV wanting native due to vCPU pinning) should keep this key
+ * disabled. Native does not touch the key.
+ *
+ * When in a guest then native_pv_lock_init() enables the key first and
+ * KVM/XEN might conditionally disable it later in the boot process again.
  */
-DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
+DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
 
 /*
  * Shortcut for the queued_spin_lock_slowpath() function that allows
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 5358d43..fec3815 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -51,13 +51,12 @@ DEFINE_ASM_FUNC(pv_native_irq_enable, "sti", .noinstr.text);
 DEFINE_ASM_FUNC(pv_native_read_cr2, "mov %cr2, %rax", .noinstr.text);
 #endif
 
-DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
+DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
 
 void __init native_pv_lock_init(void)
 {
-	if (IS_ENABLED(CONFIG_PARAVIRT_SPINLOCKS) &&
-	    !boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		static_branch_disable(&virt_spin_lock_key);
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		static_branch_enable(&virt_spin_lock_key);
 }
 
 static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)

