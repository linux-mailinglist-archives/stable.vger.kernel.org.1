Return-Path: <stable+bounces-119433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 875C6A4320E
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 01:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F91189C869
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 00:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865BC71750;
	Tue, 25 Feb 2025 00:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFwYHChJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F9525771
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 00:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444445; cv=none; b=bMY1TuVkMoPhAGzN0QDKJAwpWxRRKzB2pEyC+wnK/gRMRzhWESif5WIdLtQQp7nmmJOe9yga+vM2nX76rmwRqBMphKEsLX2lz8w9Ls6eCXwHyvytTe/e4a9D657mqNMOpxfphROcQawJMXxm0gISdtEND0tHo2iqkbYECAA1hMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444445; c=relaxed/simple;
	bh=iHJaUeFoAWphLfCjsYML3X/VoIYmwlw5kToWD4VsQ0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i8caD1L+gweynbLVyd1at06f1mYQT0c8ieNpr7Ze/eaB7E5Y27JDyf0xl1C3FnKUV9p1ooOvdNaDBOhP+gL1uHj4OBJHaxNlKrOh7lnvSCfsjPXBXa/oV1wM/ZuWmnhHJmImW7UoMUIRIlsOfpSqhSEFzLOo8IUBh/tc2PLT07o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFwYHChJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2210121ac27so105310105ad.1
        for <stable@vger.kernel.org>; Mon, 24 Feb 2025 16:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740444443; x=1741049243; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GSwXzpaQg6jWvjSpCxDF7Wv8BuKNQfehCGdAdnzxu5w=;
        b=CFwYHChJivUDw99FvIi6zE9G4hyehkakbESp47UREFTbSfsXdraG/ASxJhD+Lmz9ui
         fyTMFKuL8hTJovo71INfofVREOnhnbFyQG71xBzQoQO1B2PSIyueS8teqeegows0qAc9
         nVx2+1IQ8lW7KOPudreKfCpFsoHgioNqXDWlEfFjBoIWD36izxwiKHmufqw8+r0TivEp
         jRcyWzD+bOksIctq8MRnMduI4ks5PCKlv+Up5/Mam3g667WzpjkxOu+i/UOeg8V+/53b
         bNbXzpCuHXST4pdQdSrsOGMaCQZ2tWlEBOhEdtc/pOHKMKxC+T/6QD+p3rYvSjP7tb0D
         kBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740444443; x=1741049243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSwXzpaQg6jWvjSpCxDF7Wv8BuKNQfehCGdAdnzxu5w=;
        b=BiOpaYWC5Ra6HKl7cf4tBSN4GOik0W9kDhMZIIkMG4+iWFEnXpI8eIZnyHsVkF32wz
         sE9dtfYPupVUklxMNKwgrS/Fgc8OYn28ldxVNajx/gStVlvzhawWFGQYIMidUAtPu261
         KGtZW/+eudyE2zGzJLjoHtw1mhlcH/WakHkoWl/A7zunZMwX6+fHtiuHf2A51IikxMQr
         7qRBqr7INPhkw/2oOLc5UNvK2Q+q7b/GJypdNqja67F3YEXSESROinX5RZ3ZFRmsEyga
         S+mN2YYp45DOSqj3NQYOHiOTTQUk99mCaUugMYdnwB4hyY9T6KIMRRvfKrq+recHhLpU
         ZEYg==
X-Forwarded-Encrypted: i=1; AJvYcCXsL7YrpKGZaqyllJI1bIyO9MC/u5+yFea0ME5mCmiFtUZ7msI0NnfeKqiqFoEVR7BrErCp9FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx11Xawocs5AMDQtoXqJs3nZN5CmiuHhJNZq7iKhKflsNFABxr7
	LbvvNjBDax7OP/y0OhCAKbLRrGPzpmJflAigXwBfK2mIndIxPq/HGAZvtNw4l/ivZCOhu0IGx5N
	nCqd7Ayn1M2UatWPlsQ==
X-Google-Smtp-Source: AGHT+IENsRnPp7jn8IuysVjH0YnI4eclJId+egEJWA+BbEYzZDe3tiL9fs29LuBPMsnBKu2yRyxTuOgeH23qbt74
X-Received: from plfn11.prod.google.com ([2002:a17:902:e54b:b0:21f:4ecc:af8d])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f705:b0:220:d257:cdbd with SMTP id d9443c01a7336-2219ffbf52emr272898735ad.48.1740444442957;
 Mon, 24 Feb 2025 16:47:22 -0800 (PST)
Date: Tue, 25 Feb 2025 00:47:03 +0000
In-Reply-To: <20250225004704.603652-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250225004704.603652-1-vannapurve@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225004704.603652-3-vannapurve@google.com>
Subject: [PATCH v6 2/3] x86/tdx: Fix arch_safe_halt() execution for TDX VMs
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
leading to missed wakeup events.

Current TDX spec doesn't expose interruptibility state information to
allow #VE handler to selectively enable interrupts. To bypass this
issue, TDX VMs need to replace "sti;hlt" execution with direct TDCALL
followed by explicit interrupt flag update.

Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
prevented the idle routines from executing HLT instruction in STI-shadow.
But it missed the paravirt routine which can be reached like this as an
example:
        acpi_safe_halt() =>
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
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/Kconfig           |  1 +
 arch/x86/coco/tdx/tdx.c    | 26 +++++++++++++++++++++++++-
 arch/x86/include/asm/tdx.h |  2 +-
 arch/x86/kernel/process.c  |  2 +-
 4 files changed, 28 insertions(+), 3 deletions(-)

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
index b4b16dafd55e..393ee2dfaab1 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -58,7 +58,7 @@ void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
-void tdx_safe_halt(void);
+void tdx_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
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
2.48.1.658.g4767266eb4-goog


