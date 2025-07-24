Return-Path: <stable+bounces-164526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65D9B0FE49
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EF24E3340
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 00:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD8E7081E;
	Thu, 24 Jul 2025 00:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRxXuWKP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74333E1
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753318760; cv=none; b=VaWOFAWyMHZ17Je/H6s68zkhtJhEpz3Mn6POxUZyLg8zfBAKNDayi2kKr4G7K1XKl7LzQLQsbsLHIum+DcEHzFEfncJsCqYjmaeKDRoQoZxuwfxX+3p0uBNgq0ATFiSseJCCjgRjWNNS052N02pX/X0NIBRj6CJMMxwrp8tuycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753318760; c=relaxed/simple;
	bh=5WRpU720LppW69M3U9csj1Yx5MW42Cw8Mf9mvg4QKRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRixSVuFZv9rXcY3/aUboq7ErkY2SyB/Aur4Zca6vjITp6cQlAYROvI+sd6tHK6GxtrK5xBr7gJVP0fRTWe7WY8zm4NaBSY7ELnFJfQbKuCxVinTAduGr3yE/l1tIHd+Jx6MbobqGEf1c8T3yMisDCTXrRFQ1H2WjHvPGKzTdn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRxXuWKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291BCC4CEE7;
	Thu, 24 Jul 2025 00:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753318759;
	bh=5WRpU720LppW69M3U9csj1Yx5MW42Cw8Mf9mvg4QKRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRxXuWKP/mUOHuCV/WfciD4b3XO0XJ3/BZjibLAKw6FdVqcBEKDHgCI8oi7Guzn2w
	 unJILJDWw/OWOSLrYKCLX3QHd2u8oU9lWTyI4v7bpGtkdPjBHcyTkWdMGJxYGbwCYH
	 Wa/0pY36SEFqv1xzUAGDNKBWkdTGTZQkoTnyJ8nY9n7/BWVeJ+XZcBUN6vK72wBA71
	 X12Ytp7Unqheg48a60IWpKqTWb/3OVeIOFU9nwK3T3XhIrh6rwo/jx5uV5fBChmYUo
	 b+PnSvQ09As7ceivmrhZeN/aPmiCRvhSVwBAkO59gtHDNOVPzylIsWiCHYGFA1JAK3
	 mBRUPhTCOFOWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Xin Li (Intel)" <xin@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y] x86/traps: Initialize DR7 by writing its architectural reset value
Date: Wed, 23 Jul 2025 20:58:49 -0400
Message-Id: <20250724005849.1216420-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025063026-replace-hardly-8dd1@gregkh>
References: <2025063026-replace-hardly-8dd1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Xin Li (Intel)" <xin@zytor.com>

[ Upstream commit fa7d0f83c5c4223a01598876352473cb3d3bd4d7 ]

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
[ context adjusted: no KVM_DEBUGREG_AUTO_SWITCH flag test" ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index fdbbbfec745aa..820b4aeabd0c2 100644
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
index f094493232b64..8980786686bff 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -31,6 +31,7 @@
 
 #include <asm/apic.h>
 #include <asm/pvclock-abi.h>
+#include <asm/debugreg.h>
 #include <asm/desc.h>
 #include <asm/mtrr.h>
 #include <asm/msr-index.h>
@@ -247,7 +248,6 @@ enum x86_intercept_stage;
 #define DR7_BP_EN_MASK	0x000000ff
 #define DR7_GE		(1 << 9)
 #define DR7_GD		(1 << 13)
-#define DR7_FIXED_1	0x00000400
 #define DR7_VOLATILE	0xffff2bff
 
 #define KVM_GUESTDBG_VALID_MASK \
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c39c5c37f4e82..bab44900b937c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2220,7 +2220,7 @@ EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 static void initialize_debug_regs(void)
 {
 	/* Control register first -- to make sure everything is disabled. */
-	set_debugreg(0, 7);
+	set_debugreg(DR7_FIXED_1, 7);
 	set_debugreg(DR6_RESERVED, 6);
 	/* dr5 and dr4 don't exist */
 	set_debugreg(0, 3);
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 102641fd21728..8b1a9733d13e3 100644
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
index 4636ef3599737..3c7621663800b 100644
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
index 7196ca7048be0..8565aa31afafe 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -132,7 +132,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 
 	/* Only print out debug registers if they are in their non-default state. */
 	if (!((d0 == 0) && (d1 == 0) && (d2 == 0) && (d3 == 0) &&
-	    (d6 == DR6_RESERVED) && (d7 == 0x400))) {
+	    (d6 == DR6_RESERVED) && (d7 == DR7_FIXED_1))) {
 		printk("%sDR0: %016lx DR1: %016lx DR2: %016lx\n",
 		       log_lvl, d0, d1, d2);
 		printk("%sDR3: %016lx DR6: %016lx DR7: %016lx\n",
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index be7bb6d20129d..7bae91eb7b234 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10979,7 +10979,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		wrmsrl(MSR_IA32_XFD_ERR, vcpu->arch.guest_fpu.xfd_err);
 
 	if (unlikely(vcpu->arch.switch_db_regs)) {
-		set_debugreg(0, 7);
+		set_debugreg(DR7_FIXED_1, 7);
 		set_debugreg(vcpu->arch.eff_db[0], 0);
 		set_debugreg(vcpu->arch.eff_db[1], 1);
 		set_debugreg(vcpu->arch.eff_db[2], 2);
@@ -10988,7 +10988,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		if (unlikely(vcpu->arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT))
 			kvm_x86_call(set_dr6)(vcpu, vcpu->arch.dr6);
 	} else if (unlikely(hw_breakpoint_active())) {
-		set_debugreg(0, 7);
+		set_debugreg(DR7_FIXED_1, 7);
 	}
 
 	vcpu->arch.host_debugctl = get_debugctlmsr();
-- 
2.39.5


