Return-Path: <stable+bounces-131763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9ACA80CE1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2C6168FA4
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8E618E75A;
	Tue,  8 Apr 2025 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUEGpsvN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F815746F
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120043; cv=none; b=lPI6G6TYDYLIzIs7cELoDBOuaxwc1NhI1kPdReOhBQ/PJpnzL+psc+KTrZqHqrs/z8c2vg1Dk+VbRWAdm7V6cLbSclCCy2qGES6OwxRaHcVhKICw0LNM1icpoNRf/pP3kQbOadcZjj5CAfHpHPbOo+VxQ4N3OfbI/qWFvm4C09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120043; c=relaxed/simple;
	bh=x3/EW7RiAVZsEAq0f10OxPo0+PmIpuZrdvjiFssETuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dzncGEjdJfn9e8qbMfZZ68UsyNTp7dqfMK1pCKnnlDPknhJidBTlhTCIqOuxOiDYpT/BvWr1MPSjPkuuZzXH5wlJvpVuwbV3eCjhbJCmYtNMRVsOFpMoEId5DrWlhM9L9yswr0Gozcyg8EhTI6eMndOqAbA6U3NTVmr91tBIO30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YUEGpsvN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224347aef79so78601845ad.2
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 06:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744120041; x=1744724841; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ze+B7utKWGJE3wLfObv9Frh3fhaZXl1/6jePibI72Dw=;
        b=YUEGpsvN0YIxgSOuhdt/rRL0sAg5iKHd5GeTuW8asAFHmDTVNH43zKkZlnVDczHg7v
         2UkDwB4mhAdpZScZ5WIZ27w0LV/JaaSs675rdaBgYg2lD3MaiSOJZrK661lbqWvCWs+0
         B2sYP7cpN871LIyzVRKNy9Yxt3tyyJpQeFTy/0xs/6BPE+8OQ1RhqZu372OUyd9agh/t
         O5/qt5JVCGPBisEoFsbyLU6q4DKSb1eSroIHv+hVY6FK/2jkNW6b7NTjR5LnMgvKAZbE
         X8IRn+RaDrNUK7wdOU8SbT2DXQZu1cAHZNiuqYtdXosYpkwLlwrUgMxwaS/sXuU8jOc7
         oFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744120041; x=1744724841;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ze+B7utKWGJE3wLfObv9Frh3fhaZXl1/6jePibI72Dw=;
        b=myn2CBH19gCOip4NRsu+S2Oyi+MNQqsN3vjElmyA5jlDzktzKjnCafDTRP6Rj2G4pc
         65jcUv/Ivk9h0m7sw/jftF5rbakvBkvOLY14Cc3OD7F5ppmt/GXlfUMevE3WvR4l/1Ks
         XJ9C5FThzXPnuvg0zRs/JslBtp8mCvscQoafUDS5rCvPCihi3SiqvtvSUMddsMB2rCje
         5MFvtFd7AQYguLUx7+Sv+AL8djDUA9HitW/wtbluENPndX4MNJIUd98kgHeMZpNTfiuT
         rhxbFBM3QrILFIDWGpri55L8nmAZPWi6DoOvpFX0wS+O8FiWuEBsjAy4vuXs4VL6O6J1
         6NTQ==
X-Gm-Message-State: AOJu0Yz6P/SenZ6JXOQZPi3zZ59q7Bd3OYOlhx2BhhbJDQR2VWdqKJ+k
	l2bJeCsdck1M5qvoeUdu4qYOLmhh4/nr+celygyryqamkIkCII5zRn/OHazfSGYzQx0mWk7+76r
	aJnsxFR/ZIVrSCayK7nK1Vhi2gDGDfqMhRi+SEDJdo4VbPGwczAi0BARl6STqcsBjWMTtPKKz65
	22VQrlwD4SmAwheCF1jEuBT4fHmWpmIaMsSGK8bgxoBxgWlcTbnOrQrg==
X-Google-Smtp-Source: AGHT+IEBnBH8AAMiwj4uSqdcphfz9sE3pQbPRnBpKlh82f7hJtW7CnGUDpLKNA+KnUSokJfzrnMWid+y5EMU3yac
X-Received: from pfjt14.prod.google.com ([2002:a05:6a00:21ce:b0:730:8e17:ed13])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cf06:b0:216:644f:bc0e with SMTP id d9443c01a7336-22a9551f8e9mr220799965ad.24.1744120040495;
 Tue, 08 Apr 2025 06:47:20 -0700 (PDT)
Date: Tue,  8 Apr 2025 13:47:17 +0000
In-Reply-To: <2025040844-busload-dumpling-45ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025040844-busload-dumpling-45ff@gregkh>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250408134717.304476-1-vannapurve@google.com>
Subject: [PATCH 6.6.y] x86/tdx: Fix arch_safe_halt() execution for TDX VMs
From: Vishal Annapurve <vannapurve@google.com>
To: stable@vger.kernel.org
Cc: Vishal Annapurve <vannapurve@google.com>, Ingo Molnar <mingo@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ryan Afranji <afranji@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. If HLT is executed in STI-shadow, resulting #VE
handler will enable interrupts before TDCALL is routed to hypervisor
leading to missed wakeup events, as current TDX spec doesn't expose
interruptibility state information to allow #VE handler to selectively
enable interrupts.

Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
prevented the idle routines from executing HLT instruction in STI-shadow.
But it missed the paravirt routine which can be reached via this path
as an example:

	kvm_wait()       =>
        safe_halt()      =>
        raw_safe_halt()  =>
        arch_safe_halt() =>
        irq.safe_halt()  =>
        pv_native_safe_halt()

To reliably handle arch_safe_halt() for TDX VMs, introduce explicit
dependency on CONFIG_PARAVIRT and override paravirt halt()/safe_halt()
routines with TDX-safe versions that execute direct TDCALL and needed
interrupt flag updates. Executing direct TDCALL brings in additional
benefit of avoiding HLT related #VEs altogether.

As tested by Ryan Afranji:

  "Tested with the specjbb2015 benchmark. It has heavy lock contention which leads
   to many halt calls. TDX VMs suffered a poor score before this patchset.

   Verified the major performance improvement with this patchset applied."

Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Ryan Afranji <afranji@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250228014416.3925664-3-vannapurve@google.com
(cherry picked from commit 9f98a4f4e7216dbe366010b4cdcab6b220f229c4)
---
 arch/x86/Kconfig           |  1 +
 arch/x86/coco/tdx/tdx.c    | 26 +++++++++++++++++++++++++-
 arch/x86/include/asm/tdx.h |  4 ++--
 arch/x86/kernel/process.c  |  2 +-
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a06fab5016fd..be36ee4f6616 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -881,6 +881,7 @@ config INTEL_TDX_GUEST
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
 	depends on EFI_STUB
+	depends on PARAVIRT
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 2f67e196a2ea..98d0ee9600eb 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -13,6 +13,7 @@
 #include <asm/ia32.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/paravirt_types.h>
 #include <asm/pgtable.h>
 #include <asm/traps.h>
 
@@ -334,7 +335,7 @@ static int handle_halt(struct ve_info *ve)
 	return ve_instr_len(ve);
 }
 
-void __cpuidle tdx_safe_halt(void)
+void __cpuidle tdx_halt(void)
 {
 	const bool irq_disabled = false;
 
@@ -345,6 +346,16 @@ void __cpuidle tdx_safe_halt(void)
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
 }
 
+static void __cpuidle tdx_safe_halt(void)
+{
+	tdx_halt();
+	/*
+	 * "__cpuidle" section doesn't support instrumentation, so stick
+	 * with raw_* variant that avoids tracing hooks.
+	 */
+	raw_local_irq_enable();
+}
+
 static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_hypercall_args args = {
@@ -888,6 +899,19 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
 
+	/*
+	 * Avoid "sti;hlt" execution in TDX guests as HLT induces a #VE that
+	 * will enable interrupts before HLT TDCALL invocation if executed
+	 * in STI-shadow, possibly resulting in missed wakeup events.
+	 *
+	 * Modify all possible HLT execution paths to use TDX specific routines
+	 * that directly execute TDCALL and toggle the interrupt state as
+	 * needed after TDCALL completion. This also reduces HLT related #VEs
+	 * in addition to having a reliable halt logic execution.
+	 */
+	pv_ops.irq.safe_halt = tdx_safe_halt;
+	pv_ops.irq.halt = tdx_halt;
+
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
 	 * bringup low level code. That raises #VE which cannot be handled
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 603e6d1e9d4a..c632f09f0c97 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -46,7 +46,7 @@ void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
-void tdx_safe_halt(void);
+void tdx_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
@@ -55,7 +55,7 @@ int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
 #else
 
 static inline void tdx_early_init(void) { };
-static inline void tdx_safe_halt(void) { };
+static inline void tdx_halt(void) { };
 
 static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5351f293f770..64128a501446 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -950,7 +950,7 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
 		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		pr_info("using TDX aware idle routine\n");
-		static_call_update(x86_idle, tdx_safe_halt);
+		static_call_update(x86_idle, tdx_halt);
 	} else
 		static_call_update(x86_idle, default_idle);
 }
-- 
2.49.0.504.g3bcea36a83-goog


