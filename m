Return-Path: <stable+bounces-226914-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDCdEMzJuWl/NgIAu9opvQ
	(envelope-from <stable+bounces-226914-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:38:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B413A2B2CB7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F028306839C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA02395247;
	Tue, 17 Mar 2026 21:38:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A842391831;
	Tue, 17 Mar 2026 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783495; cv=none; b=ARlNr58CGDddW6EqCnXx/fk2JLizJkN+s/viLMSTBLjPTbIgy0R6EQFWdb3C820rSgFrv+9d2e5IqpMxuKI8s7mqpQu8p4PF8f0L1GgYQTReEYzyIQabpGgLDQS+fffozxYTEMml/CzUT5NuRX4c7bLIsMPACw9fCsqrRrJtCfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783495; c=relaxed/simple;
	bh=IROtxSZbQxzVA3jvI9dW9jeRBXHSY1MInI2EvT1PUH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blSRblOIaQ+Vm6ZJ6Q2CB1Nsm2fInExfubT+mMzcM8ZEtT3mg15WXVWfziLJoFH9eiWh8SonNe4IpWfbatCweXRsY6DDDKao4Ro3p60Fyv4adnSoIIdWanX8dm+/rH8ABygeuJiUyKR2pO+yHTztzKcTokd2FksEZKu3gOa/m9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 419131477;
	Tue, 17 Mar 2026 14:38:07 -0700 (PDT)
Received: from [172.27.42.179] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E05563F73B;
	Tue, 17 Mar 2026 14:38:11 -0700 (PDT)
Message-ID: <e4b0aefa-7108-47b4-ad5d-d62d385b8f33@arm.com>
Date: Tue, 17 Mar 2026 16:38:11 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] ACPI: Refactor get_acpi_id_for_cpu() to
 acpi_get_cpu_uid() on non-x86
To: Chengwen Feng <fengchengwen@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: punit.agrawal@oss.qualcomm.com, guohanjun@huawei.com,
 suzuki.poulose@arm.com, ryan.roberts@arm.com, chenl311@chinatelecom.cn,
 masahiroy@kernel.org, wangyuquan1236@phytium.com.cn,
 anshuman.khandual@arm.com, heinrich.schuchardt@canonical.com,
 Eric.VanTassell@amd.com, jonathan.cameron@huawei.com,
 wangzhou1@hisilicon.com, wanghuiqiang@huawei.com, liuyonglong@huawei.com,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
 linux-perf-users@vger.kernel.org, stable@vger.kernel.org
References: <20260313022144.40942-1-fengchengwen@huawei.com>
 <20260313022144.40942-2-fengchengwen@huawei.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20260313022144.40942-2-fengchengwen@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226914-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeremy.linton@arm.com,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.954];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: B413A2B2CB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Lets try this again, since the last one looks like it got caught in the 
moderation system and wasn't quite right anyway.

On 3/12/26 9:21 PM, Chengwen Feng wrote:
> Unify CPU ACPI ID retrieval interface across architectures by
> refactoring get_acpi_id_for_cpu() to acpi_get_cpu_uid() on
> arm64/riscv/loongarch:
> - Add input parameter validation
> - Adjust interface to int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
>    (old: u32 get_acpi_id_for_cpu(unsigned int cpu), no input check)
> 
> This refactoring (not a pure rename) enhances interface robustness while
> preparing for consistent ACPI Processor UID retrieval across all
> ACPI-enabled platforms. Valid inputs retain original behavior.
> 
> Note: Move the ARM64-specific get_cpu_for_acpi_id() implementation to
>        arch/arm64/kernel/acpi_numa.c to fix compilation errors from
>        circular header dependencies introduced by the rename.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>   arch/arm64/include/asm/acpi.h      | 16 +---------
>   arch/arm64/kernel/acpi.c           | 16 ++++++++++
>   arch/arm64/kernel/acpi_numa.c      | 14 +++++++++
>   arch/loongarch/include/asm/acpi.h  |  5 ---
>   arch/loongarch/kernel/acpi.c       |  9 ++++++
>   arch/riscv/include/asm/acpi.h      |  4 ---
>   arch/riscv/kernel/acpi.c           | 16 ++++++++++
>   arch/riscv/kernel/acpi_numa.c      |  9 ++++--
>   drivers/acpi/pptt.c                | 50 ++++++++++++++++++++++--------
>   drivers/acpi/riscv/rhct.c          |  7 ++++-
>   drivers/perf/arm_cspmu/arm_cspmu.c |  6 ++--
>   include/linux/acpi.h               | 13 ++++++++
>   12 files changed, 122 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index c07a58b96329..106a08556cbf 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -114,22 +114,8 @@ static inline bool acpi_has_cpu_in_madt(void)
>   }
>   
>   struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu);
> -static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
> -{
> -	return	acpi_cpu_get_madt_gicc(cpu)->uid;
> -}
> -
> -static inline int get_cpu_for_acpi_id(u32 uid)
> -{
> -	int cpu;
> -
> -	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> -		if (acpi_cpu_get_madt_gicc(cpu) &&
> -		    uid == get_acpi_id_for_cpu(cpu))
> -			return cpu;
>   
> -	return -EINVAL;
> -}
> +int get_cpu_for_acpi_id(u32 uid);
>   
>   static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>   void __init acpi_init_cpus(void);
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index af90128cfed5..f3866606fc46 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -458,3 +458,19 @@ int acpi_unmap_cpu(int cpu)
>   }
>   EXPORT_SYMBOL(acpi_unmap_cpu);
>   #endif /* CONFIG_ACPI_HOTPLUG_CPU */
> +
> +int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
> +{
> +	struct acpi_madt_generic_interrupt *gicc;
> +
> +	if (cpu >= nr_cpu_ids)
> +		return -EINVAL;
If this actually happens, its probably useful to know it with a 
pr_warn/pr_warn_once.> +
> +	gicc = acpi_cpu_get_madt_gicc(cpu);
> +	if (!gicc)
I think this check is redundant because we can't have logical cpu's that 
aren't in the cpu_possible() list, which on arm64 doesn't AFAIK have 
holes. In the past this might have made sense if we weren't maintaining 
a copy of the gicc structure from the MADT for each core.> +		return 
-ENODEV;
> +
> +	*uid = gicc->uid;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_cpu_uid);
> diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> index 2465f291c7e1..41d1e46a4338 100644
> --- a/arch/arm64/kernel/acpi_numa.c
> +++ b/arch/arm64/kernel/acpi_numa.c
> @@ -34,6 +34,20 @@ int __init acpi_numa_get_nid(unsigned int cpu)
>   	return acpi_early_node_map[cpu];
>   }
>   
> +int get_cpu_for_acpi_id(u32 uid)
> +{
> +	u32 cpu_uid;
> +	int ret;
> +
> +	for (int cpu = 0; cpu < nr_cpu_ids; cpu++) {
> +		ret = acpi_get_cpu_uid(cpu, &cpu_uid);
This might have been a simplification, but since we are basically doing 
a for_each_possible_cpu(cpu) and every possible cpu will have a GICC 
entry before it becomes 'possible' there will be a UID, so all the error 
checking AFAIK, is impossible here.> +		if (ret == 0 && uid == cpu_uid)
> +			return cpu;
> +	}
> +
> +	return -EINVAL;
> +}
> +
I also moved this below acpi_get_cpu_uid() in acpi.c and I don't see the 
a forward error issue you mentioned. It seems to me that they should be 
kept close to each other since they are basically inverses of each other.

