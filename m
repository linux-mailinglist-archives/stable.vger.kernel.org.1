Return-Path: <stable+bounces-127120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E405A768C6
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CDD73AD3E5
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253E022A4FD;
	Mon, 31 Mar 2025 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTuvc+j7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D809122A4F4;
	Mon, 31 Mar 2025 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431818; cv=none; b=PDYZ6KPuflmhy5pWaFVMxdRgyKZGkz98HwuaUqfa4hwUN0IggnRL9AI7McYMzIxTIbEc5vGMDQ/tIeKN6QDHD8NHwQBZg38gJmAVDcYWhmO7Ywf9XXUDEOliV1uo4XnYTriLBgEkPsjoGc8ROx408hCL2+j37XsxZyWQf43JfFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431818; c=relaxed/simple;
	bh=D4fqQ3YoWqku+ZAeyLtCqPUwRYSDWm+bBxtAOF/fmGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAS7OYcqywFpXm6XYijVFA6O29udI9e1bQ5ZU5opUNJVTU9frA8lJQ444CzjuVOm6JuRM4KKtGSrpX20s+8cI4Zmo/QszD11bW2AF7gtURagQ5w80/MhYjj4VRO6lZReysGu598vGDoeZxdYA0ZioGP7DHvt2TsFRGLwrlQTw9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTuvc+j7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59A3C4CEE4;
	Mon, 31 Mar 2025 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431818;
	bh=D4fqQ3YoWqku+ZAeyLtCqPUwRYSDWm+bBxtAOF/fmGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PTuvc+j7v5619WrZbyAite9/UviAA8KnZHlsYb/4N/alzkGOJqxoG45X30XrZfPvM
	 1DWXyIqVjlbHMdXVHnVZ8JyDlLXHvNlAV89QzPHco4Z+0ZMKG0MDLB6lWQ3/6+ZN3Z
	 W4SY3rnmfi5aLHR0WqbjJOUtJaVwdx0BR93XLm1woxM8TWBGyJq/DeEJmaLOB/TWo4
	 pMVtg19Yn7em8MdHPyYaZWabXHxuVmIDZNxjJjfsOHGjgCUxjIA//Exa9x2BUBr1FL
	 A6FKSQbX++NckfyOMf14OpOdaXnD+6nTP5AenIDDhnyJw3iZpBMKFXXEvqeUEoZrv1
	 cLeaUJ43tcoqQ==
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
	thomas.lendacky@amd.com,
	perry.yuan@amd.com,
	riel@surriel.com,
	mjguzik@gmail.com,
	john.allen@amd.com,
	darwi@linutronix.de
Subject: [PATCH AUTOSEL 5.15 2/6] x86/cpu: Don't clear X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in a virtual machine
Date: Mon, 31 Mar 2025 10:36:47 -0400
Message-Id: <20250331143652.1686503-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143652.1686503-1-sashal@kernel.org>
References: <20250331143652.1686503-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index ce5b27db65e10..a8dc7fe5f1003 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -811,7 +811,7 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
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


