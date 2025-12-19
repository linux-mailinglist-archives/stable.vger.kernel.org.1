Return-Path: <stable+bounces-203064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC236CCF609
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 11:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79E83302E046
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E9A1FC101;
	Fri, 19 Dec 2025 10:21:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769C919DF4F
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766139705; cv=none; b=FBdO2AsnIAqG4UzYkk54lTYdbf2T3hqD/waSBjKsJW6dsM1KuJwPBOGQlamUtcmMh5lxiSx8RxJHKj3ak4KUBkICPUwW8M7WV3znpqb70tn/jkwIjxRgI2gc9aW+oAJ1nFeydB22XkQfp4FL0kO/b4TwXvqLrQWtD7Fv05jLReA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766139705; c=relaxed/simple;
	bh=Q0KFiLT3DuFJzWLOwTK1mafVeKxPVUxR8/TJwqrKoDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tg1GbHX8WkYiNPMJ/Yae45hFVNx/AuEU1SRjvEqh3KMU3K9sWbRBNudJqjV7ep5XK7obSfWon3V+XynBBGj7Sa4MS5dkGeDXrZ9tsvg4bMfAiHEw16gx3eD3rtLI+nwTp0+A9Ar7ZzbYdMin6cqQUcLiVyxycCaCA2rnXz9DdLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C15931596;
	Fri, 19 Dec 2025 02:21:35 -0800 (PST)
Received: from workstation-e142269.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BB2D3F5CA;
	Fri, 19 Dec 2025 02:21:41 -0800 (PST)
From: Wei-Lin Chang <weilin.chang@arm.com>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wei-Lin Chang <weilin.chang@arm.com>
Subject: [PATCH 6.12.y 2/3] KVM: arm64: Initialize SCTLR_EL1 in __kvm_hyp_init_cpu()
Date: Fri, 19 Dec 2025 10:21:22 +0000
Message-ID: <20251219102123.730823-3-weilin.chang@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219102123.730823-1-weilin.chang@arm.com>
References: <20251219102123.730823-1-weilin.chang@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Genidi <ahmed.genidi@arm.com>

[ Upstream commit 3855a7b91d42ebf3513b7ccffc44807274978b3d ]

When KVM is in protected mode, host calls to PSCI are proxied via EL2,
and cold entries from CPU_ON, CPU_SUSPEND, and SYSTEM_SUSPEND bounce
through __kvm_hyp_init_cpu() at EL2 before entering the host kernel's
entry point at EL1. While __kvm_hyp_init_cpu() initializes SPSR_EL2 for
the exception return to EL1, it does not initialize SCTLR_EL1.

Due to this, it's possible to enter EL1 with SCTLR_EL1 in an UNKNOWN
state. In practice this has been seen to result in kernel crashes after
CPU_ON as a result of SCTLR_EL1.M being 1 in violation of the initial
core configuration specified by PSCI.

Fix this by initializing SCTLR_EL1 for cold entry to the host kernel.
As it's necessary to write to SCTLR_EL12 in VHE mode, this
initialization is moved into __kvm_host_psci_cpu_entry() where we can
use write_sysreg_el1().

The remnants of the '__init_el2_nvhe_prepare_eret' macro are folded into
its only caller, as this is clearer than having the macro.

Fixes: cdf367192766ad11 ("KVM: arm64: Intercept host's CPU_ON SMCs")
Reported-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Ahmed Genidi <ahmed.genidi@arm.com>
[ Mark: clarify commit message, handle E2H, move to C, remove macro ]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ahmed Genidi <ahmed.genidi@arm.com>
Cc: Ben Horgan <ben.horgan@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Leo Yan <leo.yan@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Link: https://lore.kernel.org/r/20250227180526.1204723-3-mark.rutland@arm.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Wei-Lin Chang <weilin.chang@arm.com>
---
 arch/arm64/include/asm/el2_setup.h   | 5 -----
 arch/arm64/kernel/head.S             | 3 ++-
 arch/arm64/kvm/hyp/nvhe/hyp-init.S   | 2 --
 arch/arm64/kvm/hyp/nvhe/psci-relay.c | 3 +++
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 00b27c8ed9a2..859aa1a3b996 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -265,11 +265,6 @@
 .Lskip_fgt2_\@:
 .endm
 
-.macro __init_el2_nvhe_prepare_eret
-	mov	x0, #INIT_PSTATE_EL1
-	msr	spsr_el2, x0
-.endm
-
 /**
  * Initialize EL2 registers to sane values. This should be called early on all
  * cores that were booted in EL2. Note that everything gets initialised as
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4d28c1e56cb5..25c08a0d228a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -319,7 +319,8 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	msr	sctlr_el1, x1
 	mov	x2, xzr
 3:
-	__init_el2_nvhe_prepare_eret
+	mov	x0, #INIT_PSTATE_EL1
+	msr	spsr_el2, x0
 
 	mov	w0, #BOOT_CPU_MODE_EL2
 	orr	x0, x0, x2
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index 3fb5504a7d7f..f8af11189572 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -214,8 +214,6 @@ SYM_CODE_START_LOCAL(__kvm_hyp_init_cpu)
 
 	bl	__kvm_init_el2_state
 
-	__init_el2_nvhe_prepare_eret
-
 	/* Enable MMU, set vectors and stack. */
 	mov	x0, x28
 	bl	___kvm_hyp_init			// Clobbers x0..x2
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index dfe8fe0f7eaf..bd0f308b694c 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -218,6 +218,9 @@ asmlinkage void __noreturn __kvm_host_psci_cpu_entry(bool is_cpu_on)
 	if (is_cpu_on)
 		release_boot_args(boot_args);
 
+	write_sysreg_el1(INIT_SCTLR_EL1_MMU_OFF, SYS_SCTLR);
+	write_sysreg(INIT_PSTATE_EL1, SPSR_EL2);
+
 	__host_enter(host_ctxt);
 }
 
-- 
2.43.0


