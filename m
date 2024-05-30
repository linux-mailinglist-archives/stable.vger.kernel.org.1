Return-Path: <stable+bounces-47728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB66F8D4FC7
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 18:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A905A283644
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 16:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FEC22EED;
	Thu, 30 May 2024 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1VW6tcj8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dlTcygrV"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150A8219F6;
	Thu, 30 May 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086284; cv=none; b=W055kUA8bkbBkUdfStG3Mw80uj/R75nhrij4wRxkqgS14S7RbovOY5ScT+6+FfirAZqmi8grhLgQ3oBjXMRVbOXCSilVkpQPrpTXQA32KDwkMly6j+2+hALU/Lz9Jkb1fwrZn8IevKKpH4tiJGmqRCG5+NWAFX/8Sd8MCCDtW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086284; c=relaxed/simple;
	bh=vXWTXGZIzOjj6SO56PbBHSdngFth82k1cfiLOtC6JKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tKUieBYdTzyw99ag/BcpuedkKx2hi+MBbBmzgzp+NK0R/BWbL46xcsqBb0iroImfK0yz/5nqbZymc2Pg5dKWy3Doa+3avtQk8SzkxtJaLvKtP13LANPMEt0RWIMapOLA3YD4X3mQla3Q3Xm9OokqMMwEzLPkOuNd4H/kbWDioyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1VW6tcj8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dlTcygrV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717086281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=su+nBpg+I//Su4qJT5o+I2Xt7bzzHBxGQXv4g2dGYMs=;
	b=1VW6tcj85D/9Rn/mj6JEpzRAiK5GP8ZWQTlhFkL8PZwhIbwZInZ5VCYIJOWuBCKjQCNCYy
	7fGWWLd3i305NyzYV0dGY7UqA0Gzl+v3zQKHcRyT65f6xvTnxnNM794z05JFVHbrpYLZFH
	ZA1COKQJExm9AEQ9e7nhMtQKhSfdYfH6WWxrC5co8Krpo2Y1dJAcuq1OJIWPJ1cHrCkOw5
	+Em7rhn1IoKGBa880/fjgt7DILsh5XSHg23J1/q/DTnivbYRVMkP+fSZh0S7koFiqGO8Hy
	AEJHxUabb9+o/31dVH1ZGb53cB0uvTM4bvjaUjyNsyKpoP5QFAuJ+bkixEQJyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717086281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=su+nBpg+I//Su4qJT5o+I2Xt7bzzHBxGQXv4g2dGYMs=;
	b=dlTcygrV0LHqp6LzvKBkScrYdBB2Ubuu4Y459H4noqSYzuOyO2U4dEwVtUopkQld0T5RJ9
	j/DF0JgPa4eUzGDQ==
To: Peter Schneider <pschneider1968@googlemail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Kernel 6.9 regression: X86: Bogus messages from topology detection
In-Reply-To: <87o78n8fe2.ffs@tglx>
References: <877cffcs7h.ffs@tglx>
 <16cd76b1-a512-4a7b-a304-5e4e31af3c8a@googlemail.com>
 <ce3abe01-4c37-416e-a5ed-25703318318a@googlemail.com>
 <87zfs78zxq.ffs@tglx>
 <76b1e0b9-26ae-4915-920d-9093f057796b@googlemail.com>
 <87r0dj8ls4.ffs@tglx> <87o78n8fe2.ffs@tglx>
Date: Thu, 30 May 2024 18:24:39 +0200
Message-ID: <87le3r8dyw.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 30 2024 at 17:53, Thomas Gleixner wrote:
> On Thu, May 30 2024 at 15:35, Thomas Gleixner wrote:
>> On Thu, May 30 2024 at 12:06, Peter Schneider wrote:
>> Now the million-dollar question is what unlocks CPUID to read the proper
>> value of EAX of leaf 0. All I could come up with is to sprinkle a dozen
>> of printks into that code. Updated debug patch below.
>
> Don't bother. Dave pointed out to me that this is unlocked in
> early_init_intel() via MSR_IA32_MISC_ENABLE_LIMIT_CPUID...
>
> Let me figure out how to fix that sanely.

The original code just worked because it was reevaluating this stuff
over and over until it magically became "correct".

The proper fix is obviously to unlock CPUID on Intel _before_ anything
which depends on cpuid_level is evaluated.

Thanks,

        tglx
---
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -969,7 +969,7 @@ static void init_speculation_control(str
 	}
 }
 
-void get_cpu_cap(struct cpuinfo_x86 *c)
+static void get_cpu_cap(struct cpuinfo_x86 *c)
 {
 	u32 eax, ebx, ecx, edx;
 
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
@@ -61,14 +61,15 @@ extern __ro_after_init enum tsx_ctrl_sta
 
 extern void __init tsx_init(void);
 void tsx_ap_init(void);
+void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c);
 #else
 static inline void tsx_init(void) { }
 static inline void tsx_ap_init(void) { }
+static inline void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c) { }
 #endif /* CONFIG_CPU_SUP_INTEL */
 
 extern void init_spectral_chicken(struct cpuinfo_x86 *c);
 
-extern void get_cpu_cap(struct cpuinfo_x86 *c);
 extern void get_cpu_address_sizes(struct cpuinfo_x86 *c);
 extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
 extern void init_scattered_cpuid_features(struct cpuinfo_x86 *c);
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





