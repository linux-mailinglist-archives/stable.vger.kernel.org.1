Return-Path: <stable+bounces-226908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFWkHWLGuWmcNQIAu9opvQ
	(envelope-from <stable+bounces-226908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:23:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D070B2B29E2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A43631429FC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF03B391501;
	Tue, 17 Mar 2026 21:21:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313B639150E;
	Tue, 17 Mar 2026 21:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782484; cv=none; b=DqmirSTN3auUii/S6avFAPB9JyG1Kq5df9m5Ifx2wz7WtZvX/rKFpXTHszRxKG9bAI8yahkNwml5GD8LpiKIefJAaVICLX/lNi32b2xULeedEgxlc0/qzYdw0EaLiP2XvsQ5E3LiirljK/FQrnRnfw98OP0lBvRox2kWURt+NhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782484; c=relaxed/simple;
	bh=PJs3oxRB8lT0Tg8YppcpewTxR0d/WbnMS5j5WICltOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCa55ziCe0evhHgfFWa6f64Pi80mJx6qNzU7ur6h2p5WlU/l/F4TlR4UjBFcG0qJKn2WyJ+vpjZrIa9ApHqhbhM4QVtKDxne/7DXiJdG8Uz8mTYZW1s3if5pllVn2sd6S5a6d1xjFtAUm4kvR47PcJCqe/pqfvtyvEAxOGlPDmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F53A16F2;
	Tue, 17 Mar 2026 14:21:14 -0700 (PDT)
Received: from [172.27.42.179] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E1313F73B;
	Tue, 17 Mar 2026 14:21:15 -0700 (PDT)
Message-ID: <48f70869-6628-46ec-9ab1-cb3fefa99ba2@arm.com>
Date: Tue, 17 Mar 2026 16:21:14 -0500
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
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
 Juergen Gross <jgross@suse.com>, Sohil Mehta <sohil.mehta@intel.com>,
 Ilkka Koskinen <ilkka@os.amperecomputing.com>,
 Robin Murphy <robin.murphy@arm.com>, James Clark <james.clark@linaro.org>,
 Besar Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
 Wei Huang <wei.huang2@amd.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, kees@kernel.org,
 punit.agrawal@oss.qualcomm.com, guohanjun@huawei.com,
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226908-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeremy.linton@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.951];
	RCPT_COUNT_GT_50(0.00)[54];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,arm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D070B2B29E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

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

I moved get_cpu_for_acpi_id() into arm64/kernel/acpi.c, and granted 
didn't test a wide range of configs, but i'm not seeing the circular 
dependency, what is causing that?

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
I think this should be cpu_possible() because we have a number of 
for_each_possible() calls that end up in here and AFAIK nr_cpu_ids can 
be more restrictive than the possible list.> +
> +	gicc = acpi_cpu_get_madt_gicc(cpu);
> +	if (!gicc)
> +		return -ENODEV;
So, on arm64, I didn't think it was possible to have a logical cpu 
lookup that didn't map to a gicc uid, because the logical core couldn't 
exist otherwise and (AFAIK) we don't have holes in the possible cpu 
mask. Once you know the logical core is less than nr_cpu_ids it must 
have a MADT mapping. So check this is redundant too, no?

But, if its possible to call this with an invalid logical cpu then we 
probably want to know that, so nr_cpu_ids/cpu_possible() check should 
have pr_warn_once() because there is a bug somewhere, particularly from 
all the pptt calls below where I guess there is an implication there is 
an ID mismatch between the MADT and the PPTT or simply that the user has 
clamped max cpus less than the for_each_possible() calls in the pptt/etc 
code.


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
This change is redundant, no? Your walking a limited list of possible 
CPUs that have GICC entries and checking to see if one of the known 
logical cores has a matching ACPI id. AKA you can't have an invalid 
logical core here, so the previous call must have a valid acpi id. But 
at the same time so was the acpi_cpu_get_madt_gicc() check in there 
before, which was probably left over from when the tables were being 
mapped rather than cached.

> +		if (ret == 0 && uid == cpu_uid)
> +			return cpu;
> +	}
> +
> +	return -EINVAL;
> +}
> +
I didn't actually manage to hit the case here that keeps this from 
compiling cleanly in acpi.c above if its placed immediately following 
acpi_get_cpu_uid(). IMHO, these two functions are kept close to each 
other since they are so conceptually related.

>   static int __init acpi_parse_gicc_pxm(union acpi_subtable_headers *header,
>   				      const unsigned long end)
>   {
> diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
> index 7376840fa9f7..eda9d4d0a493 100644
> --- a/arch/loongarch/include/asm/acpi.h
> +++ b/arch/loongarch/include/asm/acpi.h
> @@ -40,11 +40,6 @@ extern struct acpi_madt_core_pic acpi_core_pic[MAX_CORE_PIC];
>   
>   extern int __init parse_acpi_topology(void);
>   
> -static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
> -{
> -	return acpi_core_pic[cpu_logical_map(cpu)].processor_id;
> -}
> -
>   #endif /* !CONFIG_ACPI */
>   
>   #define ACPI_TABLE_UPGRADE_MAX_PHYS ARCH_LOW_ADDRESS_LIMIT
> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
> index 1367ca759468..058f0dbe8e8f 100644
> --- a/arch/loongarch/kernel/acpi.c
> +++ b/arch/loongarch/kernel/acpi.c
> @@ -385,3 +385,12 @@ int acpi_unmap_cpu(int cpu)
>   EXPORT_SYMBOL(acpi_unmap_cpu);
>   
>   #endif /* CONFIG_ACPI_HOTPLUG_CPU */
> +
> +int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
> +{
> +	if (cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +	*uid = acpi_core_pic[cpu_logical_map(cpu)].processor_id;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_cpu_uid);
> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
> index 6e13695120bc..26ab37c171bc 100644
> --- a/arch/riscv/include/asm/acpi.h
> +++ b/arch/riscv/include/asm/acpi.h
> @@ -61,10 +61,6 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>   
>   void acpi_init_rintc_map(void);
>   struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
> -static inline u32 get_acpi_id_for_cpu(int cpu)
> -{
> -	return acpi_cpu_get_madt_rintc(cpu)->uid;
> -}
>   
>   int acpi_get_riscv_isa(struct acpi_table_header *table,
>   		       unsigned int cpu, const char **isa);
> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> index 71698ee11621..322ea92aa39f 100644
> --- a/arch/riscv/kernel/acpi.c
> +++ b/arch/riscv/kernel/acpi.c
> @@ -337,3 +337,19 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
>   }
>   
>   #endif	/* CONFIG_PCI */
> +
> +int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
> +{
> +	struct acpi_madt_rintc *rintc;
> +
> +	if (cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	rintc = acpi_cpu_get_madt_rintc(cpu);
> +	if (!rintc)
> +		return -ENODEV;
> +
> +	*uid = rintc->uid;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_cpu_uid);
> diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
> index 130769e3a99c..6a2d4289f806 100644
> --- a/arch/riscv/kernel/acpi_numa.c
> +++ b/arch/riscv/kernel/acpi_numa.c
> @@ -37,11 +37,14 @@ static int __init acpi_numa_get_nid(unsigned int cpu)
>   
>   static inline int get_cpu_for_acpi_id(u32 uid)
>   {
> -	int cpu;
> +	u32 cpu_uid;
> +	int ret;
>   
> -	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> -		if (uid == get_acpi_id_for_cpu(cpu))
> +	for (int cpu = 0; cpu < nr_cpu_ids; cpu++) {
> +		ret = acpi_get_cpu_uid(cpu, &cpu_uid);
> +		if (ret == 0 && uid == cpu_uid)
>   			return cpu;
> +	}
>   
>   	return -EINVAL;
>   }
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index de5f8c018333..7bd5bc1f225a 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -459,11 +459,14 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>   {
>   	struct acpi_pptt_cache *found_cache;
>   	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> -	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +	u32 acpi_cpu_id;
>   	struct cacheinfo *this_leaf;
>   	unsigned int index = 0;
>   	struct acpi_pptt_processor *cpu_node = NULL;
>   
> +	if (acpi_get_cpu_uid(cpu, &acpi_cpu_id) != 0)
> +		return;
> +
>   	while (index < get_cpu_cacheinfo(cpu)->num_leaves) {
>   		this_leaf = this_cpu_ci->info_list + index;
>   		found_cache = acpi_find_cache_node(table, acpi_cpu_id,
> @@ -546,7 +549,10 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>   				     unsigned int cpu, int level, int flag)
>   {
>   	struct acpi_pptt_processor *cpu_node;
> -	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +	u32 acpi_cpu_id;
> +
> +	if (acpi_get_cpu_uid(cpu, &acpi_cpu_id) != 0)
> +		return -ENOENT;
>   
>   	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>   	if (cpu_node) {
> @@ -614,18 +620,22 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
>    *
>    * Check the node representing a CPU for a given flag.
>    *
> - * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found or
> - *	   the table revision isn't new enough.
> + * Return: -ENOENT if can't get CPU's ACPI Processor UID, the PPTT doesn't
> + *	   exist, the CPU cannot be found or the table revision isn't new
> + *	   enough.
>    *	   1, any passed flag set
>    *	   0, flag unset
>    */
>   static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
>   {
>   	struct acpi_table_header *table;
> -	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +	u32 acpi_cpu_id;
>   	struct acpi_pptt_processor *cpu_node = NULL;
>   	int ret = -ENOENT;
>   
> +	if (acpi_get_cpu_uid(cpu, &acpi_cpu_id) != 0)
> +		return -ENOENT;
> +
>   	table = acpi_get_pptt();
>   	if (!table)
>   		return -ENOENT;
> @@ -651,7 +661,8 @@ static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
>    * in the PPTT. Errors caused by lack of a PPTT table, or otherwise, return 0
>    * indicating we didn't find any cache levels.
>    *
> - * Return: -ENOENT if no PPTT table or no PPTT processor struct found.
> + * Return: -ENOENT if no PPTT table, can't get CPU's ACPI Process UID or no PPTT
> + *	   processor struct found.
>    *	   0 on success.
>    */
>   int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
> @@ -671,7 +682,9 @@ int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
>   
>   	pr_debug("Cache Setup: find cache levels for CPU=%d\n", cpu);
>   
> -	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +	if (acpi_get_cpu_uid(cpu, &acpi_cpu_id))
> +		return -ENOENT;
> +
>   	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>   	if (!cpu_node)
>   		return -ENOENT;
> @@ -780,8 +793,9 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
>    * It may not exist in single CPU systems. In simple multi-CPU systems,
>    * it may be equal to the package topology level.
>    *
> - * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found
> - * or there is no toplogy level above the CPU..
> + * Return: -ENOENT if the PPTT doesn't exist, can't get CPU's ACPI
> + * Processor UID, the CPU cannot be found or there is no toplogy level
> + * above the CPU.
>    * Otherwise returns a value which represents the package for this CPU.
>    */
>   
> @@ -797,7 +811,9 @@ int find_acpi_cpu_topology_cluster(unsigned int cpu)
>   	if (!table)
>   		return -ENOENT;
>   
> -	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +	if (acpi_get_cpu_uid(cpu, &acpi_cpu_id) != 0)
> +		return -ENOENT;
> +
>   	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>   	if (!cpu_node || !cpu_node->parent)
>   		return -ENOENT;
> @@ -872,7 +888,9 @@ static void acpi_pptt_get_child_cpus(struct acpi_table_header *table_hdr,
>   	cpumask_clear(cpus);
>   
>   	for_each_possible_cpu(cpu) {
> -		acpi_id = get_acpi_id_for_cpu(cpu);
> +		if (acpi_get_cpu_uid(cpu, &acpi_id) != 0)
> +			continue;
> +
>   		cpu_node = acpi_find_processor_node(table_hdr, acpi_id);
>   
>   		while (cpu_node) {
> @@ -966,10 +984,13 @@ int find_acpi_cache_level_from_id(u32 cache_id)
>   	for_each_possible_cpu(cpu) {
>   		bool empty;
>   		int level = 1;
> -		u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +		u32 acpi_cpu_id;
>   		struct acpi_pptt_cache *cache;
>   		struct acpi_pptt_processor *cpu_node;
>   
> +		if (acpi_get_cpu_uid(cpu, &acpi_cpu_id) != 0)
> +			continue;
> +
>   		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>   		if (!cpu_node)
>   			continue;
> @@ -1030,10 +1051,13 @@ int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
>   	for_each_possible_cpu(cpu) {
>   		bool empty;
>   		int level = 1;
> -		u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +		u32 acpi_cpu_id;
>   		struct acpi_pptt_cache *cache;
>   		struct acpi_pptt_processor *cpu_node;
>   
> +		if (acpi_get_cpu_uid(cpu, &acpi_cpu_id) != 0)
> +			continue;
> +
>   		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>   		if (!cpu_node)
>   			continue;
> diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
> index caa2c16e1697..8f3f38c64a88 100644
> --- a/drivers/acpi/riscv/rhct.c
> +++ b/drivers/acpi/riscv/rhct.c
> @@ -44,10 +44,15 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
>   	struct acpi_rhct_isa_string *isa_node;
>   	struct acpi_table_rhct *rhct;
>   	u32 *hart_info_node_offset;
> -	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> +	u32 acpi_cpu_id;
> +	int ret;
>   
>   	BUG_ON(acpi_disabled);
>   
> +	ret = acpi_get_cpu_uid(cpu, &acpi_cpu_id);
> +	if (ret != 0)
> +		return ret;
> +
>   	if (!table) {
>   		rhct = acpi_get_rhct();
>   		if (!rhct)
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 34430b68f602..ed72c3d1f796 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -1107,15 +1107,17 @@ static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
>   {
>   	struct acpi_apmt_node *apmt_node;
>   	int affinity_flag;
> +	u32 cpu_uid;
>   	int cpu;
> +	int ret;
>   
>   	apmt_node = arm_cspmu_apmt_node(cspmu->dev);
>   	affinity_flag = apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
>   
>   	if (affinity_flag == ACPI_APMT_FLAGS_AFFINITY_PROC) {
>   		for_each_possible_cpu(cpu) {
> -			if (apmt_node->proc_affinity ==
> -			    get_acpi_id_for_cpu(cpu)) {
> +			ret = acpi_get_cpu_uid(cpu, &cpu_uid);
> +			if (ret == 0 && apmt_node->proc_affinity == cpu_uid) {
>   				cpumask_set_cpu(cpu, &cspmu->associated_cpus);
>   				break;
>   			}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4d2f0bed7a06..035094a55f18 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -324,6 +324,19 @@ int acpi_unmap_cpu(int cpu);
>   
>   acpi_handle acpi_get_processor_handle(int cpu);
>   
> +#ifndef CONFIG_X86
> +/*
> + * acpi_get_cpu_uid() - Get ACPI Processor UID of a specified CPU from MADT table
> + * @cpu: Logical CPU number (0-based)
> + * @uid: Pointer to store the ACPI Processor UID (valid only on successful return)
> + *
> + * Return: 0 on successful retrieval (the ACPI Processor ID is stored in *uid);
> + *         -EINVAL if the CPU number is invalid or out of range;
> + *         -ENODEV if the ACPI Processor UID for the specified CPU is not found.
> + */
> +int acpi_get_cpu_uid(unsigned int cpu, u32 *uid);
> +#endif
> +
>   #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
>   int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
>   #endif


