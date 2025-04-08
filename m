Return-Path: <stable+bounces-131674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096D8A80B69
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC8F4E6487
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E94D27C84B;
	Tue,  8 Apr 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFkg2FMK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA726A0CF
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117029; cv=none; b=co90VPk5RDCBtAW9bIdCNu4WCqkuWVoionagaA+uBIzCP8Vp/3y8iLlanRIsdjU81w2eQLgf/SBsM78XN/cxeJp14dUdszutRqjWneaeUW57OAOkVpz9jacPW+8lHYDcoo3boqtyYVOr2kV1CgczdJprjlz9N1N8dIkyGxH4GWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117029; c=relaxed/simple;
	bh=HS32FDHnwO9D5q/PDNWKE+t0rkIVsBEs3AaieanNPIw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JNTHRNyEnXoez2zSJXynFtT1LJjCoWQ/HnkwW0bhSlpZpeZFzVAczDt+w4yrSvd5s1oJWx5gR7YFh3Fk7YnmnmE2/BJQMU/n9+RUKavVisbyaonR6Imaij/Pv82IL6VnjR7+P62huYhQINDosKuKtUBpX2lNboTf+TbBp5CtRd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PFkg2FMK; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7375e2642b4so4080134b3a.2
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 05:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744117027; x=1744721827; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LnqhIMCQHB6CFvqY2YZ8tKwcu01Xt5J4P8tYyUgFo8w=;
        b=PFkg2FMK/DnIuA1JB3KaLvuH58oKog2B3Tf74lJvDPyQDvuNJlUMCCrVpJjkEMhPre
         +LvDun+o4rXL6BKX3QcWFaKQecvUHLw5BrV9yFRLD1sX6Vp2ATL0P1iJmD5bgml94LBq
         7tIXIErFPeswuviuMZEz5Mjv2ZrVXMELvmKZEctHAoZRE5fomLkjBZQD+p4VWq9NDy/W
         AOacYgoZU6hJ/y5amrgnoW0kvIrNJl/bBnZ0s6v5S00YPviym1nOlNunOYi23mUy8QR7
         63rbGGWVUGRappEM6z0UoxJTIrvCVPDgT5emTeoTzym59XKhnPtulpIW3/nlnPq77F2O
         mXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744117027; x=1744721827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LnqhIMCQHB6CFvqY2YZ8tKwcu01Xt5J4P8tYyUgFo8w=;
        b=fl+dV2/GJLoYAa+K4JXd28FlJoZv/Vq+UT73ZyOxrfCEH2N4iFm15KSODRHLcksr4m
         VDxOl8oMaIWnvAQOnQiof0vbW6tyOYzjH2ZkDzVkjjUdk55vEsulZMQLZGFgkX3c5Hew
         +IEmmaLlFETO4fUx3j1PbTp0ozQZSBYvvhdCPFq7c322yKzDycEyjDljwO/k/iZt4TRD
         RVnhUTRkRXjbmjlzlgtS6hqtFrgGIZRiij1WwyFXc7yeaLr1M7hvlsIAC2W7blw3b190
         7c2aEKIWC7XBcIbrDiUkOUukIm41v3aLitkA1yFd/vvfllq7jkeFVQzovRWfvzFiITiI
         +VHA==
X-Gm-Message-State: AOJu0YwJf5AqsoXCzsnpzi6P2we93pfNsmS57K8dMav2KjsKb4nivtYm
	vapWZGzbdkKOgG8qw3hco/zN+mx/kCQ3hs+Lxi0XF2iKJft6rFTi/EsQ4IoORkbqjDx0R2rCeXq
	IWpNvabQ/Jt8xWxwsbltr0iOcUGKRZvDK4eZO3cOd0mW5awqmEhFDz9XcH4lZmqPYNkI4ILGrO3
	O1rDl+OFNmZnvIO85KYekUaKC0q43EMhFv75PNWt5tYD6Dwu8xvccNqQ==
X-Google-Smtp-Source: AGHT+IHFN2cs9watR/VB5JqI0en/LGjMbOB5njRDmiUDs62Z2vOTRzqr7Qg3/cMhYistuaxoSnFb4tfp5h+dySvz
X-Received: from pgbi18.prod.google.com ([2002:a63:5412:0:b0:b01:96fa:516f])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6f8b:b0:1ee:c8e7:203c with SMTP id adf61e73a8af0-2010462b41bmr24370778637.24.1744117026915;
 Tue, 08 Apr 2025 05:57:06 -0700 (PDT)
Date: Tue,  8 Apr 2025 12:56:45 +0000
In-Reply-To: <2025040826-tracing-shanty-607f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025040826-tracing-shanty-607f@gregkh>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250408125645.3856166-1-vannapurve@google.com>
Subject: [PATCH 6.13.y] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
From: Vishal Annapurve <vannapurve@google.com>
To: stable@vger.kernel.org
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ingo Molnar <mingo@kernel.org>, 
	Andi Kleen <ak@linux.intel.com>, Tony Luck <tony.luck@intel.com>, 
	Juergen Gross <jgross@suse.com>, Ryan Afranji <afranji@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, stable@kernel.org
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

Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: Ryan Afranji <afranji@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20250228014416.3925664-2-vannapurve@google.com
(cherry picked from commit 22cc5ca5de52bbfc36a7d4a55323f91fb4492264)
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
index d4eb9e1d61b8..75d4c994f5e2 100644
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
 extern noinstr void pv_native_wbinvd(void);
 
 static __always_inline void wbinvd(void)
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 8d4fbe1be489..9334fdd1f635 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -122,10 +122,9 @@ struct pv_irq_ops {
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
index fec381533555..edaa74c311c8 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -100,6 +100,11 @@ int paravirt_disable_iospace(void)
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
@@ -120,11 +125,6 @@ noinstr void pv_native_wbinvd(void)
 {
 	native_wbinvd();
 }
-
-static noinstr void pv_native_safe_halt(void)
-{
-	native_safe_halt();
-}
 #endif
 
 struct pv_info pv_info = {
@@ -182,9 +182,11 @@ struct paravirt_patch_template pv_ops = {
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
2.49.0.504.g3bcea36a83-goog


