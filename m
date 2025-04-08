Return-Path: <stable+bounces-131759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635AEA80C79
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908F7503BB7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCCB3D3B8;
	Tue,  8 Apr 2025 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEHaLOXt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4B513AD38
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118984; cv=none; b=C78wn50vqZNhhsbfzqWEHpekZ5AyhFOpXUY4M3BMRJbfWWdCTpMsq1UZgCYSL4kVjne+XUvMU9AP+53IvLPzKt15CAFecNtEJ/DDVP17eQwmM3ytnoJxGUlhAQScc51uTmq5rRAAFvF9Y9pDj9iSKIU4din9YZuSNgLfDnyRNjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118984; c=relaxed/simple;
	bh=hhEKPU7mTPKBKR4dmByEVH/KtxVoZtJXz9E+Ash91rA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s/vJm4huGZWCUFZlxJtffkP7Xlakq6xVGjjeHHbzIhaGSgqCdPEPHonS+dCptZWihiU7+hgZ4RxEjZAlnb9KjwMenHOy3BHfLgr2eCARaX59r50p5GvitlNtxZKc6VqRAKFSLrrwZpRg4Bwdz/L3wWdf7gx/FYY2G7Cyfm4EK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aEHaLOXt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so4543590a91.3
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744118981; x=1744723781; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l7FZGgTZSqkXDWv/nNI1z47hyF9ml1UBTANecRqbq3w=;
        b=aEHaLOXtzNzkZHrLL3MWxt7t2XXpAfYuMG5fREAg4/ZuPkUnDX7cJga06dy6wg5l1e
         QhWuBguDyu4xQaBSQymisDII5wllJDTrg55LMvCr8u8PqQauFJ1CQAy5ypbUOjW7OTK3
         9DuFm/EoYStL8h42PrSiQ7Lbu3M09dOe6S+CAf15HWNbGlRlvuPnx+VZcRwD2hNrtysM
         rESfZmX9FUjWd92eINULhD7QLlufMcw7dY7DuhLY+63hgXnOpYc0tf3cz5d69AkerLYz
         hHPcM+XoG9IjLfPVIXI8lsTnevCdiWd4m/FPn5lDeTrL1VJG+4jldPSG6AwfebhLx0kW
         W1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744118981; x=1744723781;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7FZGgTZSqkXDWv/nNI1z47hyF9ml1UBTANecRqbq3w=;
        b=Q0gBjj0dD1+zWE3jiGTKAssil46aCzgUlau+AkJAT1MwM/7rmC1nQfOGigXHiHNApF
         KB4DLpMPHM/0HRa/J9xuKGD/fVqPO2986j6qNKEVO7TXaGFGH1A+iKejd08mFaM3xYeX
         nL1LcwasO/+09c8+TCFZ8B14EuruQ6cmHCN7c5AD0u8MOeRKzjZoIMLM8fvdPuQHy4Dr
         8+nGI73/T8/Lob4WH2eJJc69G1vyU+xUPHVPjF/NUGh+4/xZ+nzX6HqpwkbK0Ne0/5tX
         7y6Pqi4Nvzf1TdXi+KX7zvwQJ1o5GWxFkTGY/Mr6NrNuWOcQV+Il064B4xbYRtx43gFg
         TnnQ==
X-Gm-Message-State: AOJu0YzOvsIRgv0GWur08A9ZqFdtTitQKcbIFCs023wdP57zn7hmCp58
	Scql4lBFziTockaDgIyEV7iOTaB+lRZ8hKMqNDrA9vcg5M6P50HVGVzYgKo8C9ujpvDtBNS4AyL
	WkEwBoFXKRm+fvzsO6TYDWrDyRfbOnsQOW/cvGvZQyEN0fG+9DS7mwLPUfj4aMegipNNewvE+Jl
	C416WsnOVVj7FaA6NeTfDeZ/u54FKL/mk504oCM2VP2RBvI+stzAlAjg==
X-Google-Smtp-Source: AGHT+IFlHLD8Gw5Upyusq/0geqIe2SvJdKsNEmSorPboHbRXJOwpCUIprUIAHDg46xxxJ/mreiqR+kVYALFAAa1d
X-Received: from pjur6.prod.google.com ([2002:a17:90a:d406:b0:2fc:ccfe:368])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3bcf:b0:2f8:b2c:5ef3 with SMTP id 98e67ed59e1d1-306a612def7mr24573922a91.14.1744118980570;
 Tue, 08 Apr 2025 06:29:40 -0700 (PDT)
Date: Tue,  8 Apr 2025 13:29:37 +0000
In-Reply-To: <2025040827-discern-goldmine-da71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025040827-discern-goldmine-da71@gregkh>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250408132937.4178015-1-vannapurve@google.com>
Subject: [PATCH 6.6.y] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
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
index 8c5ae649d2df..9acfe2bcf1fd 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -56,6 +56,28 @@ static __always_inline void native_halt(void)
 
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
@@ -77,24 +99,6 @@ static __always_inline void arch_local_irq_enable(void)
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
index 6c8ff12140ae..d8537e30cee1 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -103,6 +103,16 @@ static inline void notify_page_enc_status_changed(unsigned long pfn,
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
@@ -168,16 +178,6 @@ static inline void __write_cr4(unsigned long x)
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
index 772d03487520..4149df559aae 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -130,10 +130,9 @@ struct pv_irq_ops {
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
index 8d51c86caa41..234851fe0ef8 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -142,6 +142,11 @@ int paravirt_disable_iospace(void)
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
@@ -162,11 +167,6 @@ noinstr void pv_native_wbinvd(void)
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
@@ -224,9 +224,11 @@ struct paravirt_patch_template pv_ops = {
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


