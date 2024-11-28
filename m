Return-Path: <stable+bounces-95704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E41D9DB70C
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 13:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF2A163351
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 12:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D4819AD87;
	Thu, 28 Nov 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JTGJrbur"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D182194A7C;
	Thu, 28 Nov 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732795201; cv=none; b=ulm2KPvwQWScsVkUX/q9uaIj4u9VluMTvYQ6IJ3ia8NTWNNKH8KreHwEZpFBScMDiCDOP0/O5UXjcgx4HBBRuCLHN7pj86qUA2fTDEtEYqBNqCZ3sBsuKNwBFaS3Ia3awFHUAp2X3vMzuLDl1pODuHzkMsgMF1o/rsDH+BaS8Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732795201; c=relaxed/simple;
	bh=+H89slcqF/x/AS51hYkfzYFQbbZyDwlLDQw38FJrWpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcCYJYF/UNLhf7ixsNjeCNx9s960by85wr+3xGU3OLIZGw2g1U4bR/opimiYMgeAf3UHAIjsG8KbThwpCfBVbYU3k+wnpegOO6LWJE5iADjjwbrxUswqkr7p1OZD9u+vy9VGMtgdawdwqrYBXgybNMpWN8LqM0jXQaKOo6yxo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JTGJrbur; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AB16B40E0169;
	Thu, 28 Nov 2024 11:59:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id c0ui3ku6PkJW; Thu, 28 Nov 2024 11:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732795189; bh=RCgx+3+yhhfPyaV1ju+BABtGpmAnfIuT4DmDVsGdm0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JTGJrburDCTQ3oTOuKKrE6X+WARUS2ypTyzh2DuYzIfZE3uSrcFjFNdfPesZgQITV
	 WslLZ3c5+9VUKdNE4MfBDc7VXiKce7Bj66IH+O+c+jLusMevn2NWRg6xP3mno/m5Am
	 gunlub4kVx1YIR7l+Jx/o2p3F1RSvZEDy4NG5O8KtPKY1uevf6+5nMey+WRPRF7sE3
	 achizw2D76VDFgw2foAeLDYq+nSvgtB++1TLKpgRg+W5D9yVK74T4Or8MZKamblxiS
	 B7goE5GH9Mpe6mR+kz/z4zkWls19csLmdM+im1S0aVWQ83f6ChUME0wqntkWFrnzEg
	 QjTaTD8brXzCGTGCHXTKS6UKZVKSX+7IPhduMU1gZseXav9fNM+puCfSNqgMiIoV+S
	 qjI180Wz0g3FPOFdfYauqKlGHjsEAG3FXzpjPpcYl3C2C/hY1Dfe3NXnP36ibVkQUp
	 fSPgxA13yRLNMSbBHSxau1ESph8Cp+x8ee0zFTG0ox5XT3XOnn/NhqczhcEu4Zm4KB
	 ba3ulVqX2dd0ksoq1Xk/rOhfctvCQ6ugn7qIw9idqXyumDkjrVsBi2qVyCax5yxmi3
	 8zCSuBYoiO0OK1haOt1cx7xnaj0UirOgMc6k5RHP4/KdXBxRcZTmxEl8C8v2NVT0F8
	 ncDWGtG6rgpAiA26347BhGQw=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8124540E021C;
	Thu, 28 Nov 2024 11:59:25 +0000 (UTC)
Date: Thu, 28 Nov 2024 12:59:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, puwen@hygon.cn, seanjc@google.com,
	kim.phillips@amd.com, jmattson@google.com, babu.moger@amd.com,
	peterz@infradead.org, rick.p.edgecombe@intel.com, brgerst@gmail.com,
	ashok.raj@intel.com, mjguzik@gmail.com, jpoimboe@kernel.org,
	nik.borisov@suse.com, aik@amd.com, vegard.nossum@oracle.com,
	daniel.sneddon@linux.intel.com, acdunlap@google.com,
	Erwan Velu <erwanaliasr1@gmail.com>
Subject: Re: [PATCH AUTOSEL 5.15 11/12] x86/barrier: Do not serialize MSR
 accesses on AMD
Message-ID: <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local>
References: <20240115232718.209642-1-sashal@kernel.org>
 <20240115232718.209642-11-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115232718.209642-11-sashal@kernel.org>

Hey folks,

On Mon, Jan 15, 2024 at 06:26:56PM -0500, Sasha Levin wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> [ Upstream commit 04c3024560d3a14acd18d0a51a1d0a89d29b7eb5 ]
> 
> AMD does not have the requirement for a synchronization barrier when
> acccessing a certain group of MSRs. Do not incur that unnecessary
> penalty there.

Erwan just mentioned that this one is not in 6.1 and in 5.15. And I have mails
about it getting picked up by AUTOSEL.

Did the AI reconsider in the meantime?

:-P

Thx.

Two autosel messages are:

https://lore.kernel.org/r/20240115232718.209642-11-sashal@kernel.org
https://lore.kernel.org/r/20240115232611.209265-13-sashal@kernel.org

Leaving in the rest for reference.

> There will be a CPUID bit which explicitly states that a MFENCE is not
> needed. Once that bit is added to the APM, this will be extended with
> it.
> 
> While at it, move to processor.h to avoid include hell. Untangling that
> file properly is a matter for another day.
> 
> Some notes on the performance aspect of why this is relevant, courtesy
> of Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>:
> 
> On a AMD Zen4 system with 96 cores, a modified ipi-bench[1] on a VM
> shows x2AVIC IPI rate is 3% to 4% lower than AVIC IPI rate. The
> ipi-bench is modified so that the IPIs are sent between two vCPUs in the
> same CCX. This also requires to pin the vCPU to a physical core to
> prevent any latencies. This simulates the use case of pinning vCPUs to
> the thread of a single CCX to avoid interrupt IPI latency.
> 
> In order to avoid run-to-run variance (for both x2AVIC and AVIC), the
> below configurations are done:
> 
>   1) Disable Power States in BIOS (to prevent the system from going to
>      lower power state)
> 
>   2) Run the system at fixed frequency 2500MHz (to prevent the system
>      from increasing the frequency when the load is more)
> 
> With the above configuration:
> 
> *) Performance measured using ipi-bench for AVIC:
>   Average Latency:  1124.98ns [Time to send IPI from one vCPU to another vCPU]
> 
>   Cumulative throughput: 42.6759M/s [Total number of IPIs sent in a second from
>   				     48 vCPUs simultaneously]
> 
> *) Performance measured using ipi-bench for x2AVIC:
>   Average Latency:  1172.42ns [Time to send IPI from one vCPU to another vCPU]
> 
>   Cumulative throughput: 40.9432M/s [Total number of IPIs sent in a second from
>   				     48 vCPUs simultaneously]
> 
> From above, x2AVIC latency is ~4% more than AVIC. However, the expectation is
> x2AVIC performance to be better or equivalent to AVIC. Upon analyzing
> the perf captures, it is observed significant time is spent in
> weak_wrmsr_fence() invoked by x2apic_send_IPI().
> 
> With the fix to skip weak_wrmsr_fence()
> 
> *) Performance measured using ipi-bench for x2AVIC:
>   Average Latency:  1117.44ns [Time to send IPI from one vCPU to another vCPU]
> 
>   Cumulative throughput: 42.9608M/s [Total number of IPIs sent in a second from
>   				     48 vCPUs simultaneously]
> 
> Comparing the performance of x2AVIC with and without the fix, it can be seen
> the performance improves by ~4%.
> 
> Performance captured using an unmodified ipi-bench using the 'mesh-ipi' option
> with and without weak_wrmsr_fence() on a Zen4 system also showed significant
> performance improvement without weak_wrmsr_fence(). The 'mesh-ipi' option ignores
> CCX or CCD and just picks random vCPU.
> 
>   Average throughput (10 iterations) with weak_wrmsr_fence(),
>         Cumulative throughput: 4933374 IPI/s
> 
>   Average throughput (10 iterations) without weak_wrmsr_fence(),
>         Cumulative throughput: 6355156 IPI/s
> 
> [1] https://github.com/bytedance/kvm-utils/tree/master/microbenchmark/ipi-bench
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/20230622095212.20940-1-bp@alien8.de
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/include/asm/barrier.h     | 18 ------------------
>  arch/x86/include/asm/cpufeatures.h |  2 +-
>  arch/x86/include/asm/processor.h   | 18 ++++++++++++++++++
>  arch/x86/kernel/cpu/amd.c          |  3 +++
>  arch/x86/kernel/cpu/common.c       |  7 +++++++
>  arch/x86/kernel/cpu/hygon.c        |  3 +++
>  6 files changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index 3ba772a69cc8..dab2db15a8c4 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -81,22 +81,4 @@ do {									\
>  
>  #include <asm-generic/barrier.h>
>  
> -/*
> - * Make previous memory operations globally visible before
> - * a WRMSR.
> - *
> - * MFENCE makes writes visible, but only affects load/store
> - * instructions.  WRMSR is unfortunately not a load/store
> - * instruction and is unaffected by MFENCE.  The LFENCE ensures
> - * that the WRMSR is not reordered.
> - *
> - * Most WRMSRs are full serializing instructions themselves and
> - * do not require this barrier.  This is only required for the
> - * IA32_TSC_DEADLINE and X2APIC MSRs.
> - */
> -static inline void weak_wrmsr_fence(void)
> -{
> -	asm volatile("mfence; lfence" : : : "memory");
> -}
> -
>  #endif /* _ASM_X86_BARRIER_H */
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index d6089072ee41..dd6f714c215e 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -305,10 +305,10 @@
>  
>  
>  #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
> -
>  #define X86_FEATURE_SRSO		(11*32+24) /* "" AMD BTB untrain RETs */
>  #define X86_FEATURE_SRSO_ALIAS		(11*32+25) /* "" AMD BTB untrain RETs through aliasing */
>  #define X86_FEATURE_IBPB_ON_VMEXIT	(11*32+26) /* "" Issue an IBPB only on VMEXIT */
> +#define X86_FEATURE_APIC_MSRS_FENCE	(11*32+27) /* "" IA32_TSC_DEADLINE and X2APIC MSRs need fencing */
>  
>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index bbbf27cfe701..52329752dd4f 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -861,4 +861,22 @@ enum mds_mitigations {
>  
>  extern bool gds_ucode_mitigated(void);
>  
> +/*
> + * Make previous memory operations globally visible before
> + * a WRMSR.
> + *
> + * MFENCE makes writes visible, but only affects load/store
> + * instructions.  WRMSR is unfortunately not a load/store
> + * instruction and is unaffected by MFENCE.  The LFENCE ensures
> + * that the WRMSR is not reordered.
> + *
> + * Most WRMSRs are full serializing instructions themselves and
> + * do not require this barrier.  This is only required for the
> + * IA32_TSC_DEADLINE and X2APIC MSRs.
> + */
> +static inline void weak_wrmsr_fence(void)
> +{
> +	alternative("mfence; lfence", "", ALT_NOT(X86_FEATURE_APIC_MSRS_FENCE));
> +}
> +
>  #endif /* _ASM_X86_PROCESSOR_H */
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> index dba7fe7ecea9..06186b7d0ed0 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1158,6 +1158,9 @@ static void init_amd(struct cpuinfo_x86 *c)
>  	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
>  	     cpu_has_amd_erratum(c, amd_erratum_1485))
>  		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
> +
> +	/* AMD CPUs don't need fencing after x2APIC/TSC_DEADLINE MSR writes. */
> +	clear_cpu_cap(c, X86_FEATURE_APIC_MSRS_FENCE);
>  }
>  
>  #ifdef CONFIG_X86_32
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 01c4f8f45b83..1e870f6dd51c 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1687,6 +1687,13 @@ static void identify_cpu(struct cpuinfo_x86 *c)
>  	c->apicid = apic->phys_pkg_id(c->initial_apicid, 0);
>  #endif
>  
> +
> +	/*
> +	 * Set default APIC and TSC_DEADLINE MSR fencing flag. AMD and
> +	 * Hygon will clear it in ->c_init() below.
> +	 */
> +	set_cpu_cap(c, X86_FEATURE_APIC_MSRS_FENCE);
> +
>  	/*
>  	 * Vendor-specific initialization.  In this section we
>  	 * canonicalize the feature flags, meaning if there are
> diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
> index 9e8380bd4fb9..8a80d5343f3a 100644
> --- a/arch/x86/kernel/cpu/hygon.c
> +++ b/arch/x86/kernel/cpu/hygon.c
> @@ -347,6 +347,9 @@ static void init_hygon(struct cpuinfo_x86 *c)
>  		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
>  
>  	check_null_seg_clears_base(c);
> +
> +	/* Hygon CPUs don't need fencing after x2APIC/TSC_DEADLINE MSR writes. */
> +	clear_cpu_cap(c, X86_FEATURE_APIC_MSRS_FENCE);
>  }
>  
>  static void cpu_detect_tlb_hygon(struct cpuinfo_x86 *c)
> -- 
> 2.43.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

