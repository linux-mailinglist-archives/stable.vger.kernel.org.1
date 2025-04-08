Return-Path: <stable+bounces-131755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BC0A80C5E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBE7505F7F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC32A38384;
	Tue,  8 Apr 2025 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UzOlG4QV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7193C00
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118628; cv=none; b=LB51ZS7+Z2GKIWn+inZ/sFDCjsQ+JS8f6TdV32xFjrv28nJkcL+AfmcYJ7bmSPiwFJW978RXE4Nr8YoYMjQHktztjFPeR1kipNUXUAp02kDL/NdCkzJ6Ut/G7DYUP031KMFUECZSmj3GnMv9gbFBv6lgfPI02uo2l2Lw019/PYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118628; c=relaxed/simple;
	bh=VPh94gHdKh6/2QpkVPVg/G355e99j/3iSMRbq5NG3mM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=agAF4xvXzmYXmV6Qdkgqy5O6gmM+mIspoYqnTWE9jCDRrY4Hp+t6QsStzFJB3FrY1pgkEn6o297ihMdRf7ZRs21qSO/EN4wnb3CFQ1i012mzgLDfi3DA3r1x+VX1SUDb7SJj03s631gAwfQRsTsdxUc+FafrjagN1lwIAcDkMbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UzOlG4QV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff68033070so5174049a91.2
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744118626; x=1744723426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GPtwMLZid2k6gJoto2LYLLGHVCKTRfR94BA1hq3T+uo=;
        b=UzOlG4QV8DJMHEq0DQMl1caAojtuYcW/9aieQ8RnxFWU5Y/zqIPFz2IwFKnE/18oL+
         wBu9U8/XbmwLsDmFD3r+Cafb3XuOCT1HGX9IZnP9cocS3EoSkG5Eu4klb8Z0pyF5uH7p
         0+RwTJ2k72KGpwlU9CRP7epYkEqdghvcx/YMWfbiK2e5ngiL/Pp2THowN60rpTwKhWKr
         yF5dsk/DObXUpyHvl5S4bq5TVYPicsokmygJfpbEFifC1t4FOWks9eaEVrCG5WiqNMAT
         xzAkZfQLW5liB/sSSzPMKGSU0HKnmRdaydR/XDa4+Qq8V51mmd3HzDtGOHHiQuYhStHf
         eI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744118626; x=1744723426;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPtwMLZid2k6gJoto2LYLLGHVCKTRfR94BA1hq3T+uo=;
        b=XDylkEcJMHG4mP0SLez06E0UX89uWOJOHgvdmYXcutC4eYJj0PyB+Eb5Q1YR6NA/HB
         F0Ul84ePaJRkv/gEoprpBhaugZj1pvRlhoG+a+7fHrmGVSfCuHlUA2KL0Om2JyuVuw4D
         0I+YBkQ3gSKp4mGXrUGSgDHUZ4xieGYMIq3kvlkB7L24OGpv3r/uQV3t9xAue41KSC85
         ObBz2S/x18WxbKPnfuP8+BptwW4QPvQGkWNyalbnOb/bgl9ZgktBpvvbWmCXkbVVD00X
         1vlkYxUSYJhWu4PkvYXKH70mz10vxhAlZY0Wq8tdQXjSvebKz4apbXRPO64P8QYN0tHh
         SZBA==
X-Gm-Message-State: AOJu0Yw/6HP/ta80IRekEgfqNJCqq3Z/iMYgj8SbaCSlzQuNlKmQWyY6
	PEMUZbt4+wyd6xhFL7kRL5Q+f+KpzsX9SQWkxUSssQmgr7t0MnSphej9/6WVYeK5Yc1DJ5jzVi/
	7d/34ELmCm8WJuOqSbF6CYrDNrcRAZ5Eb/qmjRc/PWCrqQZE106h5oq8nvGn/8CIyrzahjg9yCp
	4sP/P/QV7J8XbEKiL4z1xjRWQtkvqeWGl5C3K40tULqR+CPD5SxMhbrg==
X-Google-Smtp-Source: AGHT+IFPRgtsk6vBoDQ+H1bHrH4yQdGyuMMxXyKEQFnOaMv1FHEE/kLE7UqEYuIMR4FtAV8dTcu6F6A4fTJaGFvA
X-Received: from pjyr13.prod.google.com ([2002:a17:90a:e18d:b0:2fc:2b96:2d4b])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2f03:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-306a48a57f9mr20423759a91.21.1744118625999;
 Tue, 08 Apr 2025 06:23:45 -0700 (PDT)
Date: Tue,  8 Apr 2025 13:23:41 +0000
In-Reply-To: <2025040827-manila-alkalize-ba6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025040827-manila-alkalize-ba6e@gregkh>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250408132341.4175633-1-vannapurve@google.com>
Subject: [PATCH 6.12.y] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
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
 arch/x86/kernel/paravirt.c            | 13 +++++----
 4 files changed, 41 insertions(+), 35 deletions(-)

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
index fec381533555..0c1b915d7efa 100644
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
@@ -121,10 +126,6 @@ noinstr void pv_native_wbinvd(void)
 	native_wbinvd();
 }
 
-static noinstr void pv_native_safe_halt(void)
-{
-	native_safe_halt();
-}
 #endif
 
 struct pv_info pv_info = {
@@ -182,9 +183,11 @@ struct paravirt_patch_template pv_ops = {
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


