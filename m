Return-Path: <stable+bounces-127086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4991A76861
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A79A3AD146
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FE621ADA4;
	Mon, 31 Mar 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjgK35UY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333EF221F10;
	Mon, 31 Mar 2025 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431712; cv=none; b=hWnOwBSkaaLr8M/d1Y3U8bXGkOWljPhauKF4p4/BDa3+84vHimFpH+NtCWovjJ/ADzyuU6TFlGGoKuZaioNWMoLIyjA1OLeUV6UGr2lutJXuid04b5FNhdfm3Ay/okCfEOYblbyyFqmY4+Eqj8O6A46SLQ9Er7xjD++V/aPgx4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431712; c=relaxed/simple;
	bh=iJ7msZkpLbraiucr8yp0RmjshWTIEMF4uP3X9n+Q7PA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/LzZ6PTFvkzyjbnCk0qyvqCjY9LnBMkV3tz1O77vEheOs+X/y99XfVx2orvIvhQPgUJ54d6HVB8h/nP6F5uBVC6mfvsqDfOH9XpVcI53eJvUJS0BrjUEvGoQSMXD2j8enUCueI8lgRU7YHXrsbX20DXdxNhFGGCD+WvAStdc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjgK35UY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49E0C4CEE9;
	Mon, 31 Mar 2025 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431709;
	bh=iJ7msZkpLbraiucr8yp0RmjshWTIEMF4uP3X9n+Q7PA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rjgK35UYh8/u45xivYnSk5lQWx82vmZrP33rjXTlSloGORPrQ2BX5Gt2QDylvhyRY
	 Y+zoRBc/+iPWfaINkRe7UhUlmMUyPKhSt+6T0L+qu6/StuqQ0r2fGJNuBW0Wn1n4/K
	 Z9efslt+gyIieoDIKnks8TyJMwJ4Q/rs5VMk1W4NFTULRSBaEBQxRh/pyh9nRdD6uk
	 wdiCGLnFohWCLKxJ7r1rDZpIONdET2tsglW6AsFeLeum/NYg/E8IOD4eP+gT/nTtgx
	 VyQ9/P0gL4nCoRS3FiZdbajz6OjhjJw4d8SXscOwfpJiUDdEU6SLJHqDmAoWB3VTHh
	 Qk2+nuuCULjoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Grobecker <max@grobecker.info>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	mario.limonciello@amd.com,
	riel@surriel.com,
	thomas.lendacky@amd.com,
	john.allen@amd.com,
	darwi@linutronix.de,
	mjguzik@gmail.com
Subject: [PATCH AUTOSEL 6.13 07/16] x86/cpu: Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in a virtual machine
Date: Mon, 31 Mar 2025 10:34:41 -0400
Message-Id: <20250331143450.1685242-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143450.1685242-1-sashal@kernel.org>
References: <20250331143450.1685242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Max Grobecker <max@grobecker.info>

[ Upstream commit a4248ee16f411ac1ea7dfab228a6659b111e3d65 ]

When running in a virtual machine, we might see the original hardware CPU
vendor string (i.e. "AuthenticAMD"), but a model and family ID set by the
hypervisor. In case we run on AMD hardware and the hypervisor sets a model
ID < 0x14, the LAHF cpu feature is eliminated from the the list of CPU
capabilities present to circumvent a bug with some BIOSes in conjunction with
AMD K8 processors.

Parsing the flags list from /proc/cpuinfo seems to be happening mostly in
bash scripts and prebuilt Docker containers, as it does not need to have
additionals tools present – even though more reliable ways like using "kcpuid",
which calls the CPUID instruction instead of parsing a list, should be preferred.
Scripts, that use /proc/cpuinfo to determine if the current CPU is
"compliant" with defined microarchitecture levels like x86-64-v2 will falsely
claim the CPU is incapable of modern CPU instructions when "lahf_lm" is missing
in that flags list.

This can prevent some docker containers from starting or build scripts to create
unoptimized binaries.

Admittably, this is more a small inconvenience than a severe bug in the kernel
and the shoddy scripts that rely on parsing /proc/cpuinfo
should be fixed instead.

This patch adds an additional check to see if we're running inside a
virtual machine (X86_FEATURE_HYPERVISOR is present), which, to my
understanding, can't be present on a real K8 processor as it was introduced
only with the later/other Athlon64 models.

Example output with the "lahf_lm" flag missing in the flags list
(should be shown between "hypervisor" and "abm"):

    $ cat /proc/cpuinfo
    processor       : 0
    vendor_id       : AuthenticAMD
    cpu family      : 15
    model           : 6
    model name      : Common KVM processor
    stepping        : 1
    microcode       : 0x1000065
    cpu MHz         : 2599.998
    cache size      : 512 KB
    physical id     : 0
    siblings        : 1
    core id         : 0
    cpu cores       : 1
    apicid          : 0
    initial apicid  : 0
    fpu             : yes
    fpu_exception   : yes
    cpuid level     : 13
    wp              : yes
    flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
                      cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx rdtscp
                      lm rep_good nopl cpuid extd_apicid tsc_known_freq pni
                      pclmulqdq ssse3 fma cx16 sse4_1 sse4_2 x2apic movbe popcnt
                      tsc_deadline_timer aes xsave avx f16c hypervisor abm
                      3dnowprefetch vmmcall bmi1 avx2 bmi2 xsaveopt

... while kcpuid shows the feature to be present in the CPU:

    # kcpuid -d | grep lahf
         lahf_lm             - LAHF/SAHF available in 64-bit mode

[ mingo: Updated the comment a bit, incorporated Boris's review feedback. ]

Signed-off-by: Max Grobecker <max@grobecker.info>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 79d2e17f6582e..425bed00b2e07 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -627,7 +627,7 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 	 * (model = 0x14) and later actually support it.
 	 * (AMD Erratum #110, docId: 25759).
 	 */
-	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM)) {
+	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM) && !cpu_has(c, X86_FEATURE_HYPERVISOR)) {
 		clear_cpu_cap(c, X86_FEATURE_LAHF_LM);
 		if (!rdmsrl_amd_safe(0xc001100d, &value)) {
 			value &= ~BIT_64(32);
-- 
2.39.5


