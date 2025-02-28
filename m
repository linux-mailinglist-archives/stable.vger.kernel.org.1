Return-Path: <stable+bounces-119877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BADA48E1B
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 02:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05C137A834A
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 01:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1367014D70E;
	Fri, 28 Feb 2025 01:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRIJm+wE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3223914F9E2
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740707069; cv=none; b=ekaA+z6eomJ79BsXt5jX9joBpziAR7iiqvDhUZzQHZil510B+zOFcTU0mlYSNbme/WXD+Ab5asXNbKXFhZA/h2TxD2IisGVDvAFX5Hmsaoi5bk818i5Om5iq148O/0xUMWYufWFOAABGPEhkd1F7wi2Ipr4JIn+LEBpQYm3EMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740707069; c=relaxed/simple;
	bh=i9ENWjo/o96Aa8fPKMPX7NLngVCt8HtPrHWOTzQE0Fk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tiP/GaFv5iPiJQn/TOsugrx2S8uO5UBIVe8q5GVbDrclx95T2lYpfSeypboGKmk9V64Tdw8QHarIRFnh5CwpbrPY1tdczY3K2nlR4yrN0Xv2oTsdckGvqsKz8+B166jiS0w+T4374bJ8RRqvYAWuxuuW2GXI1tY77uZ3TV7xZqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRIJm+wE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220d8599659so30904015ad.0
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 17:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740707067; x=1741311867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i0wFOSqRndidkNXiBiYSW4ce7lxfSxMD1v4SsnHkoVc=;
        b=mRIJm+wE0sUbmDRhVgWPZyVfDXfiWoubqasnmSNHG9CSUq25UTWLoEVmFiU0bSR4ZL
         8UKCv0QwxAMLupgiUdsrwSZPKpV8+58Ka6dfQ0/qSiv+q/bg19MTpI1Y9MZX0Wk5bnmS
         FpwzYQaWO6XTxqHcfit6mw7JBXFxZ0Sk5FFNdcOWkgh4tJXbi0GUr4k5euGhULcFM9SM
         C1ffsboqtz2Kne2VVuGF3iPECVASPVVdDnzvsqamM1l+7FDIwOGDh5E5wR4Lv4YtnlO0
         3KLC9t6HhAkAIjVLKTyiRNa3IWpfYJeOGkmo/y0jn+NZ7KUN7yOwXAfmHaj/YqmCggaf
         tuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740707067; x=1741311867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0wFOSqRndidkNXiBiYSW4ce7lxfSxMD1v4SsnHkoVc=;
        b=BcXfvBG32b08A01P9ywkqh8FuYQQi0AwNC1lqb66SaDyTK/nRymYDidMs7M4HOvSW3
         tNm9lJ82IjVPUzln7oZ2061I5emVXfLdXIRM+lENduiZsvAZYYSS9W9fSo3LXg0mHwCi
         0mhogLUW35LPUAklR1fQspuXNnsjv8DbNy9UsK8gRHkfcLXmxOGeQmcTx7bl3cl38Pri
         ZMwssaegct+fXtyr2MikVmOXYTQO2bDQIcAtzqPMCb/xX3ffd56WhGniLLXKbQAugYzH
         dv/IcH0dstxpnXGvrXSBLCf/n8ey0qGT4VnIt+g6px3TZ9XcLYxKVX5Pb/dzjbXg9fvE
         ISJw==
X-Forwarded-Encrypted: i=1; AJvYcCVWQlEjFGFXJH+Nx9OD9hxZtM6iOkGMPSE7dSb+r0sOWS9j3TrZZ3fzRJ6rAh93hz4O+uBJTdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP8u6cvG/EY9uZezgY+k6vWNeRkn4NOTUmd43xeGeZj1EBLOaf
	9Zvzen4x4/223FU1lP6DK3Dhj8kkW536xdnvURpZ18B96KyJw9gYnS9J8H+bd7TvwfH/FivuWcE
	NmHlZQWfpLlOP2LnPDw==
X-Google-Smtp-Source: AGHT+IHcdEevikITtyeaqM8Mz1NP3XkKvs0CtF/JDlO8or0UrfQF1zHQplot1E2vAsgNiVwgy8W10dEeyX49rVAZ
X-Received: from pfbhu34.prod.google.com ([2002:a05:6a00:69a2:b0:730:876e:7b1c])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d4a:b0:730:8768:76d7 with SMTP id d2e1a72fcca58-734ac41c74cmr2179681b3a.17.1740707067419;
 Thu, 27 Feb 2025 17:44:27 -0800 (PST)
Date: Fri, 28 Feb 2025 01:44:15 +0000
In-Reply-To: <20250228014416.3925664-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228014416.3925664-1-vannapurve@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228014416.3925664-3-vannapurve@google.com>
Subject: [PATCH v7 2/3] x86/tdx: Fix arch_safe_halt() execution for TDX VMs
From: Vishal Annapurve <vannapurve@google.com>
To: dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, ak@linux.intel.com, 
	tony.luck@intel.com, thomas.lendacky@amd.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	pbonzini@redhat.com, seanjc@google.com, kai.huang@intel.com, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, 
	afranji@google.com, kees@kernel.org, jikos@kernel.org, peterz@infradead.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, 
	Vishal Annapurve <vannapurve@google.com>, stable@vger.kernel.org
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

Cc: stable@vger.kernel.org
Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/Kconfig           |  1 +
 arch/x86/coco/tdx/tdx.c    | 26 +++++++++++++++++++++++++-
 arch/x86/include/asm/tdx.h |  4 ++--
 arch/x86/kernel/process.c  |  2 +-
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be2c311f5118..933c046e8966 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -902,6 +902,7 @@ config INTEL_TDX_GUEST
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
 	depends on EFI_STUB
+	depends on PARAVIRT
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 32809a06dab4..6aad910d119d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -14,6 +14,7 @@
 #include <asm/ia32.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/paravirt_types.h>
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
 #include <asm/traps.h>
@@ -398,7 +399,7 @@ static int handle_halt(struct ve_info *ve)
 	return ve_instr_len(ve);
 }
 
-void __cpuidle tdx_safe_halt(void)
+void __cpuidle tdx_halt(void)
 {
 	const bool irq_disabled = false;
 
@@ -409,6 +410,16 @@ void __cpuidle tdx_safe_halt(void)
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
 	struct tdx_module_args args = {
@@ -1109,6 +1120,19 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_kexec_begin	     = tdx_kexec_begin;
 	x86_platform.guest.enc_kexec_finish	     = tdx_kexec_finish;
 
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
index b4b16dafd55e..40f9a97371a9 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -58,7 +58,7 @@ void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
-void tdx_safe_halt(void);
+void tdx_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
@@ -72,7 +72,7 @@ void __init tdx_dump_td_ctls(u64 td_ctls);
 #else
 
 static inline void tdx_early_init(void) { };
-static inline void tdx_safe_halt(void) { };
+static inline void tdx_halt(void) { };
 
 static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 6da6769d7254..d11956a178df 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -934,7 +934,7 @@ void __init select_idle_routine(void)
 		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		pr_info("using TDX aware idle routine\n");
-		static_call_update(x86_idle, tdx_safe_halt);
+		static_call_update(x86_idle, tdx_halt);
 	} else {
 		static_call_update(x86_idle, default_idle);
 	}
-- 
2.48.1.711.g2feabab25a-goog


