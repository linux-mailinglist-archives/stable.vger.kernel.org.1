Return-Path: <stable+bounces-114972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22918A31A29
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 01:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1BFC3A7E4B
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 00:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABA6259C;
	Wed, 12 Feb 2025 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5aFYlFc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C216136
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318898; cv=none; b=lJ1iOOs4gSjBQK4d5nMmcwQ96fWzvR97yeVkgI0+KQJrWQnlkRm6w5/MCdrZhe62AMWRS1ZTzwAkzttv8J1SzlX8Gf0sdtuFeVM1adk+4WAhpPLpHYLR2uljFH3o4/bdWrQ3XsKd03cXqccfkdLLacDNXhnDa54LfoP8T+pkwn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318898; c=relaxed/simple;
	bh=ehLYTG6Xoh6RePEuOdsJO1YiF66iXfldRHD0ATxH28M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mipRzr0lSE+hARfLlLPe90IbFV2kZI89SnJqoTXyrLu/D7FUF4d/yvCuQf6v6Z2GhX+j3Pt2x+4K/r8Ou0DIl/AcuZzUvuld/qKgYS8v9C4vv68RvK7qgtyzuok+33c2eMYWiiT065if7noDWVsqJNJlmGeAy7CJU3nPZdgdTYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d5aFYlFc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa166cf693so17881248a91.1
        for <stable@vger.kernel.org>; Tue, 11 Feb 2025 16:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739318895; x=1739923695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aflUMaVdfiypUqtPtl++K+1MuoyNGKota/M1UlzbiMc=;
        b=d5aFYlFcPz68rfIoI3Nm0O3H2FUUA8m++SrnBOhazh85Qe//glBuoSQ6VnjdLvZkQU
         M+KNMbhmIzG26UFs/RQbIZBPfo+Mz8N0xSx6UAgMS/U+oFYUEetGlTJ/K2TNO4NucEy4
         qYPDKrVIh/ryDIZ1Dz6Zus7agIycoLtjD0VGzQes991YuW1ZXpp+v61e+cCKnwZBKqUw
         ZfZEOz+on9x0gf/bDoueuUQQ6R3J3jrAgiSwSKnFKLzGMjCRYmdS2tDchrtvcKQIbHwT
         OAgPcFuxjmrIaGN2r5eiwwbI7foiB48AedsKpjIYSOgwuqcT+9UKS8FQdU9YFGRvAkKV
         RYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318895; x=1739923695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aflUMaVdfiypUqtPtl++K+1MuoyNGKota/M1UlzbiMc=;
        b=uAaG9hZgBeOeCZr6C9uV5n39HZNjmDPWW51jvQFt206+hK8wX33NwhCqFW11lV+q4+
         lg5RK8Qza0kQRjL0VtN3qnUdKWyc+TuEd7qMxGEBisMkcyuse7nQFMMd9ZD76GwErvz+
         X1ybiEuEAIh/36Z8AZzRxlRCDkBAnVI+215WmKuzcTcZbaboUIdne/emAgK5GWuYWYdU
         qMs5yybaZHnq7P8Fc7q770ldPeAIDCV9RV3WvUJXVmoWeUdYPX61otYXVe2gl3WcSMZx
         e3Ts2OQdxBOogif3DVdEztmsfOjC6UY5uSxiOmqfrcVEXXKEwMMW+fq5rnXFluJjDID8
         /J3A==
X-Forwarded-Encrypted: i=1; AJvYcCUQqegnXQiV7NtpTkX/nTPM8njiXxJZHbtXXJWmv5BHdRJJfZ2GoBcx+sxJ28VC85S8HqA2WHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2uI87mvsRQLScYW1eno16hJXgva55kMhhcM9qxSUDYvSjsyl
	cjFoAcdTFwHCcNcpotIa4Bt7247G0SyxrfhqU+j/CZK452g6UpCptjaaRlqZ1gJvngNw/CwG+Sx
	L1x9BGpTBHfZHhv6byg==
X-Google-Smtp-Source: AGHT+IHPxfAdpM1iOOY8z1AmixqeOmuG/IEf4j5AgcwJnfrRV4HF54kPCepPnvhuZO3QjCmSQoEz/uA6jsv32fdY
X-Received: from pgtq26.prod.google.com ([2002:a65:685a:0:b0:ad5:444f:7093])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2450:b0:1e1:bdae:e04d with SMTP id adf61e73a8af0-1ee5c85db6bmr2527873637.36.1739318895379;
 Tue, 11 Feb 2025 16:08:15 -0800 (PST)
Date: Wed, 12 Feb 2025 00:07:44 +0000
In-Reply-To: <20250212000747.3403836-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212000747.3403836-1-vannapurve@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212000747.3403836-2-vannapurve@google.com>
Subject: [PATCH V4 1/4] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, kirill@shutemov.name, dave.hansen@linux.intel.com, 
	linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, stable@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Tony Luck <tony.luck@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

CONFIG_PARAVIRT_XXL is mainly defined/used by XEN PV guests. For
other VM guest types, features supported under CONFIG_PARAVIRT
are self sufficient. CONFIG_PARAVIRT mainly provides support for
TLB flush operations and time related operations.

For TDX guest as well, paravirt calls under CONFIG_PARVIRT meets
most of its requirement except the need of HLT and SAFE_HLT
paravirt calls, which is currently defined under
CONFIG_PARAVIRT_XXL.

Since enabling CONFIG_PARAVIRT_XXL is too bloated for TDX guest
like platforms, move HLT and SAFE_HLT paravirt calls under
CONFIG_PARAVIRT.

Moving HLT and SAFE_HLT paravirt calls are not fatal and should not
break any functionality for current users of CONFIG_PARAVIRT.

Cc: stable@vger.kernel.org
Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/include/asm/irqflags.h       | 40 +++++++++++++++------------
 arch/x86/include/asm/paravirt.h       | 20 +++++++-------
 arch/x86/include/asm/paravirt_types.h |  3 +-
 arch/x86/kernel/paravirt.c            | 14 ++++++----
 4 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index cf7fc2b8e3ce..1c2db11a2c3c 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -76,6 +76,28 @@ static __always_inline void native_local_irq_restore(unsigned long flags)
 
 #endif
 
+#ifndef CONFIG_PARAVIRT
+#ifndef __ASSEMBLY__
+/*
+ * Used in the idle loop; sti takes one instruction cycle
+ * to complete:
+ */
+static __always_inline void arch_safe_halt(void)
+{
+	native_safe_halt();
+}
+
+/*
+ * Used when interrupts are already enabled or to
+ * shutdown the processor:
+ */
+static __always_inline void halt(void)
+{
+	native_halt();
+}
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
@@ -97,24 +119,6 @@ static __always_inline void arch_local_irq_enable(void)
 	native_irq_enable();
 }
 
-/*
- * Used in the idle loop; sti takes one instruction cycle
- * to complete:
- */
-static __always_inline void arch_safe_halt(void)
-{
-	native_safe_halt();
-}
-
-/*
- * Used when interrupts are already enabled or to
- * shutdown the processor:
- */
-static __always_inline void halt(void)
-{
-	native_halt();
-}
-
 /*
  * For spinlocks, etc:
  */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 041aff51eb50..29e7331a0c98 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -107,6 +107,16 @@ static inline void notify_page_enc_status_changed(unsigned long pfn,
 	PVOP_VCALL3(mmu.notify_page_enc_status_changed, pfn, npages, enc);
 }
 
+static __always_inline void arch_safe_halt(void)
+{
+	PVOP_VCALL0(irq.safe_halt);
+}
+
+static inline void halt(void)
+{
+	PVOP_VCALL0(irq.halt);
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static inline void load_sp0(unsigned long sp0)
 {
@@ -170,16 +180,6 @@ static inline void __write_cr4(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
-static __always_inline void arch_safe_halt(void)
-{
-	PVOP_VCALL0(irq.safe_halt);
-}
-
-static inline void halt(void)
-{
-	PVOP_VCALL0(irq.halt);
-}
-
 static inline u64 paravirt_read_msr(unsigned msr)
 {
 	return PVOP_CALL1(u64, cpu.read_msr, msr);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index fea56b04f436..abccfccc2e3f 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -120,10 +120,9 @@ struct pv_irq_ops {
 	struct paravirt_callee_save save_fl;
 	struct paravirt_callee_save irq_disable;
 	struct paravirt_callee_save irq_enable;
-
+#endif
 	void (*safe_halt)(void);
 	void (*halt)(void);
-#endif
 } __no_randomize_layout;
 
 struct pv_mmu_ops {
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 1ccaa3397a67..c5bb980b8a67 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -110,6 +110,11 @@ int paravirt_disable_iospace(void)
 	return request_resource(&ioport_resource, &reserve_ioports);
 }
 
+static noinstr void pv_native_safe_halt(void)
+{
+	native_safe_halt();
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static noinstr void pv_native_write_cr2(unsigned long val)
 {
@@ -125,11 +130,6 @@ static noinstr void pv_native_set_debugreg(int regno, unsigned long val)
 {
 	native_set_debugreg(regno, val);
 }
-
-static noinstr void pv_native_safe_halt(void)
-{
-	native_safe_halt();
-}
 #endif
 
 struct pv_info pv_info = {
@@ -186,9 +186,11 @@ struct paravirt_patch_template pv_ops = {
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(pv_native_save_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(pv_native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(pv_native_irq_enable),
+#endif /* CONFIG_PARAVIRT_XXL */
+
+	/* Irq HLT ops. */
 	.irq.safe_halt		= pv_native_safe_halt,
 	.irq.halt		= native_halt,
-#endif /* CONFIG_PARAVIRT_XXL */
 
 	/* Mmu ops. */
 	.mmu.flush_tlb_user	= native_flush_tlb_local,
-- 
2.48.1.502.g6dc24dfdaf-goog


