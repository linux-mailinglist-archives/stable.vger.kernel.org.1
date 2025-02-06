Return-Path: <stable+bounces-114180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C09A2B4FF
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 23:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E3A16702F
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 22:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317DF22FF3E;
	Thu,  6 Feb 2025 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4KNDw16"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B73415B99E
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 22:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738880888; cv=none; b=Ou6X4hS97O4kgcCwUyZjTelZGpYYeeOuejr0Bc7ei6vaJqiUkoXu0D79lUiFw8GUrF1Dg1U36fGxHdoMqOrY7gricGDmV8anTVVI5vjq0Nd2U0vkSJId/oLeqhSKK+EuQnJDZgBrBf4dDDbYoIo0P8qgRSQRvdU4K/P1UGALhf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738880888; c=relaxed/simple;
	bh=68S+7ZlsuMe2fEeqhZuUrws52Dw8cqaMxh/N9g6qQgg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=f3x5gb3VZ9/wndrcX/TCpz4RuTMK/4k8aqa73y/SPb0P+T/aLEN0IaoAWvRYu17MQI93nLYTmhjkOlkY4YSOBWOCpc7xKdA/4ROWPFGZWI/MscNrjPBcAz8FAyIHwlhM2oV/rKPv1j2ReBv6mgee9LVz23zkDOKJG2ecWEupqTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l4KNDw16; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f022fc6a3so29809285ad.1
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 14:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738880886; x=1739485686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8P4AhcS+GNaWZWjxWYlbkE1kh/676R53jJusOmDR5nw=;
        b=l4KNDw16bG8QRPPd7Ebi13w4o0rOGTUgkPBS8cwWl3BJAcaHR+P9SlYSmGkztr+sqV
         NnpzvXIDeFEh/YJw4Uusk62+r04VY2++oi6cyspKtjfoNg5pO+vv96W9n7FsSvaRbRWu
         cAsOdr+Bre8mm3I76ew2xoOxd9IZ3p0QgHKf5JB63ljn7cQxpVbTiKIoNdOfU2nS7VX/
         kNo0lXv9O7090WhnlUg9pgfIbEjNoR93Rlvv7IkQTL0B/1jLvgeuK6ktfQ3MHtmJ147T
         s0/F77Uw/PE0AFkeoTjLBmNlwi3SBtQNyVKoLDM6enlpUtb9I9DF68xsq4ASXu018xsc
         RIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738880886; x=1739485686;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8P4AhcS+GNaWZWjxWYlbkE1kh/676R53jJusOmDR5nw=;
        b=OKMpZqdWxhgpxs5VMiLuIU6/lFZfdC/Qj55G/GlrTo76rYrzdcppFhHSqrbAcgFQGk
         NFS2wEhmfo5cea++gZYrt/Zo9hkjHqWoKkIZgHBg8ZU908946L0kubWGGWl5zDVbRP6v
         +hIBplrQoTwTq7kUsoP+1VIiB5cAfwwTqjQjlehVa7wGyrT85oIBj10gCwMUoz1AuRQv
         KbjSpb9Nkes0Yj5hlG/LShwgpAp4hAWNaHBIFMHvn0834L6iAeGD/cQSSNuuLLJ8Z67T
         2Qbg1Ujc9qfCZYo0UrNKBZUuTt9CXnOO1KbcJliiFFxDj6YYeeiyvT/q4N78DF0+o4Tb
         EOJg==
X-Forwarded-Encrypted: i=1; AJvYcCXHchsxmRf8oqpHXyjNiSOCtNITTXegOYyyLZLZcPHroi6kttMrALAWKi5X8OQ9Q1uNZIrc9pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwydIK6BHEyAL3cCZ9bIlScMxoZJHKnTCGomB+U8g8FrgfJDGpH
	jSYz/+cncdqpOR98iWKXv/BfImz/G7QJ5eX0tAAQlWICVA/tqSwA8YbZtZfkT4pL/k+Rft8MjxC
	T7fLn8zSRfqzoruXNPg==
X-Google-Smtp-Source: AGHT+IGV2oh05tX4Vjgo2rH9ZwUrNxYtXWIw0ieeSiG3VAWoKfP6hvB9RpQpAjOsrL8oZOFBbq18FpN8lc54sQDS
X-Received: from plbx9.prod.google.com ([2002:a17:902:ea89:b0:21f:40e5:a651])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ec89:b0:215:758c:52e8 with SMTP id d9443c01a7336-21f4f16fe8dmr10682555ad.12.1738880885742;
 Thu, 06 Feb 2025 14:28:05 -0800 (PST)
Date: Thu,  6 Feb 2025 22:27:12 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250206222714.1079059-1-vannapurve@google.com>
Subject: [PATCH V3 1/2] x86/tdx: Route safe halt execution via tdx_safe_halt()
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, kirill@shutemov.name, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, Vishal Annapurve <vannapurve@google.com>, stable@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. safe_halt() routines execute HLT in STI-shadow
so IRQs need to remain disabled until the TDCALL to ensure that pending
IRQs are correctly treated as wake events. So "sti;hlt" sequence needs to
be replaced with "TDCALL; raw_local_irq_enable()" for TDX VMs.

Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
prevented the idle routines from using "sti;hlt". But it missed the
paravirt routine which can be reached like this as an example:
        acpi_safe_halt() =>
        raw_safe_halt()  =>
        arch_safe_halt() =>
        irq.safe_halt()  =>
        pv_native_safe_halt()

Modify tdx_safe_halt() to implement the sequence "TDCALL;
raw_local_irq_enable()" and invoke tdx_halt() from idle routine which just
executes TDCALL without changing state of interrupts.

If CONFIG_PARAVIRT_XXL is disabled, "sti;hlt" sequences can still get
executed from TDX VMs via paths like:
        acpi_safe_halt() =>
        raw_safe_halt()  =>
        arch_safe_halt() =>
	native_safe_halt()
There is a long term plan to fix these paths by carving out
irq.safe_halt() outside paravirt framework.

Cc: stable@vger.kernel.org
Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>@linux.intel.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
Changes since V2:
1) Addressed comments from Dave H and Kirill S.

V2: https://lore.kernel.org/lkml/20250129232525.3519586-1-vannapurve@google.com/

 arch/x86/coco/tdx/tdx.c    | 18 +++++++++++++++++-
 arch/x86/include/asm/tdx.h |  2 +-
 arch/x86/kernel/process.c  |  2 +-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 32809a06dab4..5e68758666a4 100644
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
 
@@ -409,6 +410,12 @@ void __cpuidle tdx_safe_halt(void)
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
 }
 
+static void __cpuidle tdx_safe_halt(void)
+{
+	tdx_halt();
+	raw_local_irq_enable();
+}
+
 static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_module_args args = {
@@ -1109,6 +1116,15 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_kexec_begin	     = tdx_kexec_begin;
 	x86_platform.guest.enc_kexec_finish	     = tdx_kexec_finish;
 
+#ifdef CONFIG_PARAVIRT_XXL
+	/*
+	 * Avoid the literal hlt instruction in TDX guests. hlt will
+	 * induce a #VE in the STI-shadow which will enable interrupts
+	 * in a place where they are not wanted.
+	 */
+	pv_ops.irq.safe_halt = tdx_safe_halt;
+#endif
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
2.48.1.502.g6dc24dfdaf-goog


