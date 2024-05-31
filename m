Return-Path: <stable+bounces-47772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3027D8D5CFD
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 10:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA20E1F22DA5
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559CF153BED;
	Fri, 31 May 2024 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZyDRhXPg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zj0DMVpE"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074EF15383F;
	Fri, 31 May 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144953; cv=none; b=pP/l74I7D288FmmV1kpwocKrzE1bEYdk76nv/+B48r3LJXZBDFrM4XDW9xLi83nCIExi6NEtFSm1vJ8bxmu1CDzXXxW1Fmz2bUtheEcDQ3OJgGucsM+cBeA2+PnxcUmUFTfSTI9QsA2H16KyE2kQHfzQDUlE9KsycS7/Ob3Yvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144953; c=relaxed/simple;
	bh=obwRrHdSQhE14E+BPljTdaZz9fKGC+Z7OnPMryGR2y8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PekerXdkOVx+s53ZPsvau32FQpmGAnEkDUfUUL8BAFp5tXSzB2BGAU9gKyfch7TNddO0FYnkxYYSR/grNlSe/QVQcKL5NRjbGNUVjl0VDWo3mToECD4doQxr6l16dGZD1qmAQHj0l92em+I5T6oOFSS5pmqFgpjt+rew5QaOH9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZyDRhXPg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zj0DMVpE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717144949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UTI2c/7A6hRiAbpj/yTEs+WThsy6r51M1QAj2Eqyrrg=;
	b=ZyDRhXPgyl2XW/yooSOsdQ55MOqnXLyLFf2E/VAy4KSp1SqXxaVecb7H/YTa84VYTApx2K
	xUx4Hfyi5t6R/hIwKPbi01d/Nf5Gwwb3M2XuvpwQtkyYRTw501NzadvNy3UAmmC7DPzqnQ
	1zC2+CIjm1MfL/DwvpixyYyI/aLhNJNGwDV0y1ANM5z4GY4r3OOfmiKCaNmF3+JV6KCQkE
	iCQ8mlWHs5C+gUV5d2kZwQemcVkKJo+HREfTXt/GGSoPqHiFAQOlebPw152TlrBBELbKwz
	FeFuJJSPlH6SgNS7azztVK5yxNF5uSQgC+X2F0rPtc7aO+3NibanFlrIEHkltg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717144949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UTI2c/7A6hRiAbpj/yTEs+WThsy6r51M1QAj2Eqyrrg=;
	b=zj0DMVpEcS1FhmVzjIGd6qojtWrfTT+MCPhya0GJh0aB1AhB2VInHBvzy8phpzBkbP4pqH
	2noxYHUMGO0A+xDg==
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology detection
In-Reply-To: <87ikyu8jp4.ffs@tglx>
References: <877cffcs7h.ffs@tglx>
 <16cd76b1-a512-4a7b-a304-5e4e31af3c8a@googlemail.com>
 <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
 <87zfs78zxq.ffs@tglx>
 <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
 <87r0dj8ls4.ffs@tglx> <87o78n8fe2.ffs@tglx> <87le3r8dyw.ffs@tglx>
 <bd7ff2f3-bf2c-4431-9848-8eb41e7422c6@googlemail.com>
 <87ikyu8jp4.ffs@tglx>
Date: Fri, 31 May 2024 10:42:26 +0200
Message-ID: <87frty8j9p.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, May 31 2024 at 10:33, Thomas Gleixner wrote:

Clearly coffee did not set in yet.

Thanks,

         tglx
---
Subject: x86/topology/intel: Unlock CPUID before evaluating anything
From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 30 May 2024 17:29:18 +0200

Intel CPUs have a MSR bit to limit CPUID enumeration to leaf two. If this
bit is set by the BIOS then CPUID evaluation including topology enumeration
does not work correctly as the evaluation code does not try to analyze any
leaf greater than two.

This went unnoticed before because the original topology code just repeated
evaluation several times and managed to overwrite the initial limited
information with the correct one later. The new evaluation code does it
once and therefore ends up with the limited and wrong information.

Cure this by unlocking CPUID right before evaluating anything which depends
on the maximum CPUID leaf being greater than two instead of rereading stuff
after unlock.

Fixes: 22d63660c35e ("x86/cpu: Use common topology code for Intel")
Reported-by: Peter Schneider <pschneider1968@googlemail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/common.c |    3 ++-
 arch/x86/kernel/cpu/cpu.h    |    2 ++
 arch/x86/kernel/cpu/intel.c  |   25 ++++++++++++++++---------
 3 files changed, 20 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1585,6 +1585,7 @@ static void __init early_identify_cpu(st
 	if (have_cpuid_p()) {
 		cpu_detect(c);
 		get_cpu_vendor(c);
+		intel_unlock_cpuid_leafs(c);
 		get_cpu_cap(c);
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
 		get_cpu_address_sizes(c);
@@ -1744,7 +1745,7 @@ static void generic_identify(struct cpui
 	cpu_detect(c);
 
 	get_cpu_vendor(c);
-
+	intel_unlock_cpuid_leafs(c);
 	get_cpu_cap(c);
 
 	get_cpu_address_sizes(c);
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -61,9 +61,11 @@ extern __ro_after_init enum tsx_ctrl_sta
 
 extern void __init tsx_init(void);
 void tsx_ap_init(void);
+void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c);
 #else
 static inline void tsx_init(void) { }
 static inline void tsx_ap_init(void) { }
+static inline void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c) { }
 #endif /* CONFIG_CPU_SUP_INTEL */
 
 extern void init_spectral_chicken(struct cpuinfo_x86 *c);
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -269,19 +269,26 @@ static void detect_tme_early(struct cpui
 	c->x86_phys_bits -= keyid_bits;
 }
 
+void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c)
+{
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return;
+
+	if (c->x86 < 6 || (c->x86 == 6 && c->x86_model < 0xd))
+		return;
+
+	/*
+	 * The BIOS can have limited CPUID to leaf 2, which breaks feature
+	 * enumeration. Unlock it and update the maximum leaf info.
+	 */
+	if (msr_clear_bit(MSR_IA32_MISC_ENABLE, MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT) > 0)
+		c->cpuid_level = cpuid_eax(0);
+}
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
 
-	/* Unmask CPUID levels if masked: */
-	if (c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xd)) {
-		if (msr_clear_bit(MSR_IA32_MISC_ENABLE,
-				  MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT) > 0) {
-			c->cpuid_level = cpuid_eax(0);
-			get_cpu_cap(c);
-		}
-	}
-
 	if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
 		(c->x86 == 0x6 && c->x86_model >= 0x0e))
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);

