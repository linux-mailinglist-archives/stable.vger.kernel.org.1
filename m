Return-Path: <stable+bounces-158458-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E61CAE70ED
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 22:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD02188A49B
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 20:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36A42E8895;
	Tue, 24 Jun 2025 20:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SArgutJI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/XCoSa1"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E7239E7A;
	Tue, 24 Jun 2025 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750797327; cv=none; b=Pb7NsyDJr6pEvTF7aaxP25bgHzCD3gUVS1qhoW8turq5uCBJcz3s6Wta2SmrSBg9/wZwSKXMtShcH1AsoQoDMV1XIK0nvohhnQFWdf6W/xcm6V6Pu3wfmjJEL4VsKeUs60BiGZIFBvgu9wwpxYCRlV5H6o1o08/T67ulB7KPRPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750797327; c=relaxed/simple;
	bh=c0hAH11k/pzP9SZ9HzIUTlESiZ1K6d35PYqZnTwH+eM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=uJiBuriY7KFar2rd71v598mnw5fj/dgLcqQP30T2lnuf4gowV7sBmp66L0oGzyVovPXzJbTvzdHDSpnABzZTUXbmtzSpeLNDdK8HB/NJ2OQD1vCUIU7wHfybLCQbJj9bcc53EPi+SLDFsFPvi1OiY3XRbCHkK5/Bp/4qeR7Puek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SArgutJI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y/XCoSa1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Jun 2025 20:35:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750797323;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OghVQubO3Zyamo2+5v6BhdfWd7yc9KWHiIblg5Emyt0=;
	b=SArgutJInKVuU4hKNMUfcrJtKEPt7Er+/xcL+Ado601KLAqCKlUjX8zfujl2zQZ9K4Mobc
	IUFbaJ6k/s/TyHel1gmeXnGeg4/lyPxh5xghQ5GD1hVrzGT2dOkkBWrkuSIVzHnk4sOD9k
	0dAbkxLXqxaBzuvbrRIpu3igP+EVNgZlLdOEN8WAEzjbxEGSNz0qiUr4qN6Gbgf+1PRc39
	0B3uhN6o3z+lCB7aen1PW2UAaI62taTif7GkrB8Dv4lvvQjpnQRU4IeS768Uyu8F6KCjfY
	nCNIWAnwCdKa9AAk2zcj7zmJJ1Zd/LyT+vnkvipbYH3nyHZugTaaZvbS0jOnvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750797323;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=OghVQubO3Zyamo2+5v6BhdfWd7yc9KWHiIblg5Emyt0=;
	b=Y/XCoSa1pm0D8it4T/usI19TzfNF/qNgq9cxFJKPmG7vzZg2kk8RTJwzgkY8sfP+Q5dAla
	mnDJWfzbNBLG6FDQ==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/traps: Initialize DR7 by writing its
 architectural reset value
Cc: "Xin Li (Intel)" <xin@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, Sohil Mehta <sohil.mehta@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175079732220.406.9335430223954818839.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fa7d0f83c5c4223a01598876352473cb3d3bd4d7
Gitweb:        https://git.kernel.org/tip/fa7d0f83c5c4223a01598876352473cb3d3bd4d7
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Fri, 20 Jun 2025 16:15:04 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 24 Jun 2025 13:15:52 -07:00

x86/traps: Initialize DR7 by writing its architectural reset value

Initialize DR7 by writing its architectural reset value to always set
bit 10, which is reserved to '1', when "clearing" DR7 so as not to
trigger unanticipated behavior if said bit is ever unreserved, e.g. as
a feature enabling flag with inverted polarity.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Sean Christopherson <seanjc@google.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250620231504.2676902-3-xin%40zytor.com
---
 arch/x86/include/asm/debugreg.h | 19 +++++++++++++++----
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kernel/cpu/common.c    |  2 +-
 arch/x86/kernel/kgdb.c          |  2 +-
 arch/x86/kernel/process_32.c    |  2 +-
 arch/x86/kernel/process_64.c    |  2 +-
 arch/x86/kvm/x86.c              |  4 ++--
 7 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
index 363110e..a2c1f2d 100644
--- a/arch/x86/include/asm/debugreg.h
+++ b/arch/x86/include/asm/debugreg.h
@@ -9,6 +9,14 @@
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
 
+/*
+ * Define bits that are always set to 1 in DR7, only bit 10 is
+ * architecturally reserved to '1'.
+ *
+ * This is also the init/reset value for DR7.
+ */
+#define DR7_FIXED_1	0x00000400
+
 DECLARE_PER_CPU(unsigned long, cpu_dr7);
 
 #ifndef CONFIG_PARAVIRT_XXL
@@ -100,8 +108,8 @@ static __always_inline void native_set_debugreg(int regno, unsigned long value)
 
 static inline void hw_breakpoint_disable(void)
 {
-	/* Zero the control register for HW Breakpoint */
-	set_debugreg(0UL, 7);
+	/* Reset the control register for HW Breakpoint */
+	set_debugreg(DR7_FIXED_1, 7);
 
 	/* Zero-out the individual HW breakpoint address registers */
 	set_debugreg(0UL, 0);
@@ -125,9 +133,12 @@ static __always_inline unsigned long local_db_save(void)
 		return 0;
 
 	get_debugreg(dr7, 7);
-	dr7 &= ~0x400; /* architecturally set bit */
+
+	/* Architecturally set bit */
+	dr7 &= ~DR7_FIXED_1;
 	if (dr7)
-		set_debugreg(0, 7);
+		set_debugreg(DR7_FIXED_1, 7);
+
 	/*
 	 * Ensure the compiler doesn't lower the above statements into
 	 * the critical section; disabling breakpoints late would not
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b4a3919..639d9bc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -31,6 +31,7 @@
 
 #include <asm/apic.h>
 #include <asm/pvclock-abi.h>
+#include <asm/debugreg.h>
 #include <asm/desc.h>
 #include <asm/mtrr.h>
 #include <asm/msr-index.h>
@@ -249,7 +250,6 @@ enum x86_intercept_stage;
 #define DR7_BP_EN_MASK	0x000000ff
 #define DR7_GE		(1 << 9)
 #define DR7_GD		(1 << 13)
-#define DR7_FIXED_1	0x00000400
 #define DR7_VOLATILE	0xffff2bff
 
 #define KVM_GUESTDBG_VALID_MASK \
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0f6c280..27125e0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2246,7 +2246,7 @@ EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 static void initialize_debug_regs(void)
 {
 	/* Control register first -- to make sure everything is disabled. */
-	set_debugreg(0, 7);
+	set_debugreg(DR7_FIXED_1, 7);
 	set_debugreg(DR6_RESERVED, 6);
 	/* dr5 and dr4 don't exist */
 	set_debugreg(0, 3);
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 102641f..8b1a973 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -385,7 +385,7 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
 	struct perf_event *bp;
 
 	/* Disable hardware debugging while we are in kgdb: */
-	set_debugreg(0UL, 7);
+	set_debugreg(DR7_FIXED_1, 7);
 	for (i = 0; i < HBP_NUM; i++) {
 		if (!breakinfo[i].enabled)
 			continue;
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index a10e180..3ef15c2 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -93,7 +93,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 
 	/* Only print out debug registers if they are in their non-default state. */
 	if ((d0 == 0) && (d1 == 0) && (d2 == 0) && (d3 == 0) &&
-	    (d6 == DR6_RESERVED) && (d7 == 0x400))
+	    (d6 == DR6_RESERVED) && (d7 == DR7_FIXED_1))
 		return;
 
 	printk("%sDR0: %08lx DR1: %08lx DR2: %08lx DR3: %08lx\n",
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 8d6cf25..b972bf7 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -133,7 +133,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 
 	/* Only print out debug registers if they are in their non-default state. */
 	if (!((d0 == 0) && (d1 == 0) && (d2 == 0) && (d3 == 0) &&
-	    (d6 == DR6_RESERVED) && (d7 == 0x400))) {
+	    (d6 == DR6_RESERVED) && (d7 == DR7_FIXED_1))) {
 		printk("%sDR0: %016lx DR1: %016lx DR2: %016lx\n",
 		       log_lvl, d0, d1, d2);
 		printk("%sDR3: %016lx DR6: %016lx DR7: %016lx\n",
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b58a74c..a9d992d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11035,7 +11035,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	if (unlikely(vcpu->arch.switch_db_regs &&
 		     !(vcpu->arch.switch_db_regs & KVM_DEBUGREG_AUTO_SWITCH))) {
-		set_debugreg(0, 7);
+		set_debugreg(DR7_FIXED_1, 7);
 		set_debugreg(vcpu->arch.eff_db[0], 0);
 		set_debugreg(vcpu->arch.eff_db[1], 1);
 		set_debugreg(vcpu->arch.eff_db[2], 2);
@@ -11044,7 +11044,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
 			kvm_x86_call(set_dr6)(vcpu, vcpu->arch.dr6);
 	} else if (unlikely(hw_breakpoint_active())) {
-		set_debugreg(0, 7);
+		set_debugreg(DR7_FIXED_1, 7);
 	}
 
 	vcpu->arch.host_debugctl = get_debugctlmsr();

