Return-Path: <stable+bounces-223749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FtjGdWQr2kragIAu9opvQ
	(envelope-from <stable+bounces-223749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:32:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1C2244D59
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A726830BDF32
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 03:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44CE3B9606;
	Tue, 10 Mar 2026 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ctT3+zfM"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E6F280CD5;
	Tue, 10 Mar 2026 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773113379; cv=none; b=VgPHYp8OTHdIwYcvVuoJ0W4xIiJcwfZsYfEqZ0rrsgSjK0FVsFh3H1E4jzUa5XlgzCXzKGyaqSSbzvoDEbWh6YPpWexUQ2mzTBi0xsg+cEJbQfeGRWdyXUc4tulKcu3GeZWZeGfduLRjTn/NNH1Biw+m5n4BByDqF4BT3eiYNsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773113379; c=relaxed/simple;
	bh=GO2UOPH+XbBPRFrqvOhfhAdG5OHgB0+ySTUPhB7r7qU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qVk43naOcKc2NPlnYmut6At+pXJalcSef1PwoHMgDwtHKN0I2AC6J1ne009njGiQumWVyS6GGaU4qtVDZjlPEeCSP26DHpqlQrKFQOs2GGrMDK3GESAmFBILzpTTgt94qCqNBRF83rgTCBZiFfyXEVzwLA1Hg75p+fL0cXgZB2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ctT3+zfM; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kje1eZfcLfoGw4eodwbTMTi2f+I7QIR9DyQQLzPnscU=;
	b=ctT3+zfMVigcgSx5Oi4o6AihKaQOVTpaMZTp63q2EF9GF44LlRmhxb4YLp/SvjVhjFtpnf1Di
	JTCz65Qg8Z4VpwtnjHOQnOSbz34LCF1Us5hAau6WuZ2nq8Hyf/XMotZI4fK0MMXheTgc+kQlEPt
	4qSa2/YMHyeRJq5bX6GNWRc=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fVK3f4FPQz12LCw;
	Tue, 10 Mar 2026 11:23:58 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id BC53E404AD;
	Tue, 10 Mar 2026 11:29:34 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Mar 2026 11:29:33 +0800
Message-ID: <9d0d4685-fe6b-4ffd-b9bd-6a560c0d7c9f@huawei.com>
Date: Tue, 10 Mar 2026 11:29:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] ACPI: Rename get_acpi_id_for_cpu() to
 acpi_get_cpu_acpi_id() on non-x86
To: Huacai Chen <chenhuacai@kernel.org>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, WANG Xuerui
	<kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, Mark Rutland
	<mark.rutland@arm.com>, <linux-acpi@vger.kernel.org>, <wei.huang2@amd.com>,
	<Eric.VanTassell@amd.com>, <jonathan.cameron@huawei.com>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <stable@vger.kernel.org>, <jeremy.linton@arm.com>,
	<sunilvl@oss.qualcomm.com>, <chenhuacai@loongson.cn>,
	<wangliupu@loongson.cn>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <linux-perf-users@vger.kernel.org>
References: <20260303003625.39035-1-fengchengwen@huawei.com>
 <20260309041659.18815-1-fengchengwen@huawei.com>
 <20260309041659.18815-2-fengchengwen@huawei.com>
 <CAAhV-H7Cy1OuReaoGotZvdvHWLic_ECESFVZgbvNpk2HVjPjuw@mail.gmail.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <CAAhV-H7Cy1OuReaoGotZvdvHWLic_ECESFVZgbvNpk2HVjPjuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: 0E1C2244D59
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-223749-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Huacai,

On 3/9/2026 9:29 PM, Huacai Chen wrote:
> Hi, Chengwen,
> 
> On Mon, Mar 9, 2026 at 12:17 PM Chengwen Feng <fengchengwen@huawei.com> wrote:
>>
>> To unify the CPU ACPI ID retrieval interface across architectures,
>> rename the existing get_acpi_id_for_cpu() function to
>> acpi_get_cpu_acpi_id() on arm64/riscv/loongarch platforms.
> Can we also rename cpu_acpi_id() to acpi_get_cpu_acpi_id() for x86?

Remove cpu_acpi_id() would make it look more concise, this was done in v5, thanks.

> 
> Huacai
> 
>>
>> This is a pure rename with no functional change, preparing for a
>> consistent ACPI Processor UID retrieval interface across all ACPI-enabled
>> platforms.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  arch/arm64/include/asm/acpi.h      |  4 ++--
>>  arch/loongarch/include/asm/acpi.h  |  2 +-
>>  arch/riscv/include/asm/acpi.h      |  2 +-
>>  arch/riscv/kernel/acpi_numa.c      |  2 +-
>>  drivers/acpi/pptt.c                | 16 ++++++++--------
>>  drivers/acpi/riscv/rhct.c          |  2 +-
>>  drivers/perf/arm_cspmu/arm_cspmu.c |  2 +-
>>  7 files changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index c07a58b96329..202107aeb05b 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -114,7 +114,7 @@ static inline bool acpi_has_cpu_in_madt(void)
>>  }
>>
>>  struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu);
>> -static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
>> +static inline u32 acpi_get_cpu_acpi_id(unsigned int cpu)
>>  {
>>         return  acpi_cpu_get_madt_gicc(cpu)->uid;
>>  }
>> @@ -125,7 +125,7 @@ static inline int get_cpu_for_acpi_id(u32 uid)
>>
>>         for (cpu = 0; cpu < nr_cpu_ids; cpu++)
>>                 if (acpi_cpu_get_madt_gicc(cpu) &&
>> -                   uid == get_acpi_id_for_cpu(cpu))
>> +                   uid == acpi_get_cpu_acpi_id(cpu))
>>                         return cpu;
>>
>>         return -EINVAL;
>> diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
>> index 7376840fa9f7..89c6c8f52cc3 100644
>> --- a/arch/loongarch/include/asm/acpi.h
>> +++ b/arch/loongarch/include/asm/acpi.h
>> @@ -40,7 +40,7 @@ extern struct acpi_madt_core_pic acpi_core_pic[MAX_CORE_PIC];
>>
>>  extern int __init parse_acpi_topology(void);
>>
>> -static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
>> +static inline u32 acpi_get_cpu_acpi_id(unsigned int cpu)
>>  {
>>         return acpi_core_pic[cpu_logical_map(cpu)].processor_id;
>>  }
>> diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
>> index 6e13695120bc..1d23681b61b5 100644
>> --- a/arch/riscv/include/asm/acpi.h
>> +++ b/arch/riscv/include/asm/acpi.h
>> @@ -61,7 +61,7 @@ static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>>
>>  void acpi_init_rintc_map(void);
>>  struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu);
>> -static inline u32 get_acpi_id_for_cpu(int cpu)
>> +static inline u32 acpi_get_cpu_acpi_id(int cpu)
>>  {
>>         return acpi_cpu_get_madt_rintc(cpu)->uid;
>>  }
>> diff --git a/arch/riscv/kernel/acpi_numa.c b/arch/riscv/kernel/acpi_numa.c
>> index 130769e3a99c..c2eb4824d0f7 100644
>> --- a/arch/riscv/kernel/acpi_numa.c
>> +++ b/arch/riscv/kernel/acpi_numa.c
>> @@ -40,7 +40,7 @@ static inline int get_cpu_for_acpi_id(u32 uid)
>>         int cpu;
>>
>>         for (cpu = 0; cpu < nr_cpu_ids; cpu++)
>> -               if (uid == get_acpi_id_for_cpu(cpu))
>> +               if (uid == acpi_get_cpu_acpi_id(cpu))
>>                         return cpu;
>>
>>         return -EINVAL;
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index de5f8c018333..c1a8fba4c2b2 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -459,7 +459,7 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
>>  {
>>         struct acpi_pptt_cache *found_cache;
>>         struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>> -       u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>> +       u32 acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
>>         struct cacheinfo *this_leaf;
>>         unsigned int index = 0;
>>         struct acpi_pptt_processor *cpu_node = NULL;
>> @@ -546,7 +546,7 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>>                                      unsigned int cpu, int level, int flag)
>>  {
>>         struct acpi_pptt_processor *cpu_node;
>> -       u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>> +       u32 acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
>>
>>         cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>>         if (cpu_node) {
>> @@ -622,7 +622,7 @@ static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
>>  static int check_acpi_cpu_flag(unsigned int cpu, int rev, u32 flag)
>>  {
>>         struct acpi_table_header *table;
>> -       u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>> +       u32 acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
>>         struct acpi_pptt_processor *cpu_node = NULL;
>>         int ret = -ENOENT;
>>
>> @@ -671,7 +671,7 @@ int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
>>
>>         pr_debug("Cache Setup: find cache levels for CPU=%d\n", cpu);
>>
>> -       acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>> +       acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
>>         cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>>         if (!cpu_node)
>>                 return -ENOENT;
>> @@ -797,7 +797,7 @@ int find_acpi_cpu_topology_cluster(unsigned int cpu)
>>         if (!table)
>>                 return -ENOENT;
>>
>> -       acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>> +       acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
>>         cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
>>         if (!cpu_node || !cpu_node->parent)
>>                 return -ENOENT;
>> @@ -872,7 +872,7 @@ static void acpi_pptt_get_child_cpus(struct acpi_table_header *table_hdr,
>>         cpumask_clear(cpus);
>>
>>         for_each_possible_cpu(cpu) {
>> -               acpi_id = get_acpi_id_for_cpu(cpu);
>> +               acpi_id = acpi_get_cpu_acpi_id(cpu);
>>                 cpu_node = acpi_find_processor_node(table_hdr, acpi_id);
>>
>>                 while (cpu_node) {
>> @@ -966,7 +966,7 @@ int find_acpi_cache_level_from_id(u32 cache_id)
>>         for_each_possible_cpu(cpu) {
>>                 bool empty;
>>                 int level = 1;
>> -               u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>> +               u32 acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
>>                 struct acpi_pptt_cache *cache;
>>                 struct acpi_pptt_processor *cpu_node;
>>
>> @@ -1030,7 +1030,7 @@ int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
>>         for_each_possible_cpu(cpu) {
>>                 bool empty;
>>                 int level = 1;
>> -               u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>> +               u32 acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
>>                 struct acpi_pptt_cache *cache;
>>                 struct acpi_pptt_processor *cpu_node;
>>
>> diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
>> index caa2c16e1697..c15ce8c13136 100644
>> --- a/drivers/acpi/riscv/rhct.c
>> +++ b/drivers/acpi/riscv/rhct.c
>> @@ -44,7 +44,7 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
>>         struct acpi_rhct_isa_string *isa_node;
>>         struct acpi_table_rhct *rhct;
>>         u32 *hart_info_node_offset;
>> -       u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
>> +       u32 acpi_cpu_id = acpi_get_cpu_acpi_id(cpu);
>>
>>         BUG_ON(acpi_disabled);
>>
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
>> index 34430b68f602..506b661c60fd 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>> @@ -1115,7 +1115,7 @@ static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
>>         if (affinity_flag == ACPI_APMT_FLAGS_AFFINITY_PROC) {
>>                 for_each_possible_cpu(cpu) {
>>                         if (apmt_node->proc_affinity ==
>> -                           get_acpi_id_for_cpu(cpu)) {
>> +                           acpi_get_cpu_acpi_id(cpu)) {
>>                                 cpumask_set_cpu(cpu, &cspmu->associated_cpus);
>>                                 break;
>>                         }
>> --
>> 2.17.1
>>
> 


