Return-Path: <stable+bounces-227430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFHzFzO9vGlz2gIAu9opvQ
	(envelope-from <stable+bounces-227430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:21:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E662D5810
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 04:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C89030D20DB
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 03:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1D2E1F11;
	Fri, 20 Mar 2026 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BmbPRJic"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161E261B91;
	Fri, 20 Mar 2026 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976857; cv=none; b=rd83aJbBPajPBvE83RYQ6MxefunA05+TpCeyp/cNMnfg5KlsVvmuhZgzVoBncDk/+RhbdDNR5IP9bOVv6R/vswzSS64VyJyErRespgKBNgbGnl4EPSvBfQU42YxAYgi1zMr/W9zOF0wnsdc4L9XEGTSltSSDcDq4KbgjxxuD5YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976857; c=relaxed/simple;
	bh=lzyTHdRmfvwTUmaa5s/1Z8QQ1tjYuHEX6fmBI+qlbkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pS8yHLcLF9qrPFSWKe845g6ZjTGAGGVnGpU0f96+lZQJRZoo+o8ONZgp+PQOGr8p4qpzt/cKjBGElLSqHPxLiDBMNFpjeql+SskZSzjRxipINn+MI/GxapmOosbZj5JLeTdcMNQHwn5LPQchF6BU7Ii7mDXlnJ2qEr+8cnJ6jTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BmbPRJic; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lktLkGPyIysx/WhMm6zhFs4+/dKUCu1VRaLJ2DTbNKk=;
	b=BmbPRJicL0i4h9s8skOHMSkzRHoRkrfIchJvOxTmvfFrO197DbtNbsJ3/cHCjYhsoXNVBbdKq
	OoMYj4CbYb7pX1jqI899B/8GePSsfcvWqXsNyTaDCPL9bpQo/J8OYh712QYGDjmKOlq7aqwKF4y
	zBdbCmbvNplVO//KpM+ko5w=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fcSPg71l7zKm4t;
	Fri, 20 Mar 2026 11:15:51 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 356FF40363;
	Fri, 20 Mar 2026 11:20:53 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Mar 2026 11:20:50 +0800
Message-ID: <ece36c60-ed45-4cb8-b6f4-8a13e8e55949@huawei.com>
Date: Fri, 20 Mar 2026 11:20:50 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/7] arm64/acpi: Add acpi_get_cpu_uid() and switch
 arm_cspmu to use it
To: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
	<kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H . Peter Anvin"
	<hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Len Brown <lenb@kernel.org>, Sunil V L
	<sunilvl@ventanamicro.com>, Mark Rutland <mark.rutland@arm.com>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Kees Cook <kees@kernel.org>, Yanteng
 Si <si.yanteng@linux.dev>, Sean Christopherson <seanjc@google.com>, Kai Huang
	<kai.huang@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Huth
	<thuth@redhat.com>, Thorsten Blum <thorsten.blum@linux.dev>, Kevin Loughlin
	<kevinloughlin@google.com>, Zheyun Shen <szy0127@sjtu.edu.cn>, Peter Zijlstra
	<peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Xin
 Li <xin@zytor.com>, "Ahmed S . Darwish" <darwi@linutronix.de>, Sohil Mehta
	<sohil.mehta@intel.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, Robin
 Murphy <robin.murphy@arm.com>, James Clark <james.clark@linaro.org>, Besar
 Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>, Wei Huang
	<wei.huang2@amd.com>, Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>, <guohanjun@huawei.com>,
	<suzuki.poulose@arm.com>, <ryan.roberts@arm.com>, <chenl311@chinatelecom.cn>,
	<masahiroy@kernel.org>, <wangyuquan1236@phytium.com.cn>,
	<anshuman.khandual@arm.com>, <heinrich.schuchardt@canonical.com>,
	<Eric.VanTassell@amd.com>, <wangzhou1@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <liuyonglong@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linux-riscv@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>, <linux-acpi@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260319065735.45954-1-fengchengwen@huawei.com>
 <20260319065735.45954-2-fengchengwen@huawei.com> <87341vq0u1.fsf@stealth>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <87341vq0u1.fsf@stealth>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227430-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_GT_50(0.00)[69];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8E662D5810
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/2026 11:46 PM, Punit Agrawal wrote:
> Chengwen Feng <fengchengwen@huawei.com> writes:
> 
>> Add arch-specific acpi_get_cpu_uid() for arm64, and update dependent
>> code:
>> - Declare acpi_get_cpu_uid() in arch/arm64/include/asm/acpi.h
>> - Implement acpi_get_cpu_uid() with input parameter validation
>> - Replace get_acpi_id_for_cpu() with acpi_get_cpu_uid() in
>>   drivers/perf/arm_cspmu/arm_cspmu.c
>> - Reimplement get_cpu_for_acpi_id() based on acpi_get_cpu_uid() (to
>>   align with new interface) and move its implementation next to
>>   acpi_get_cpu_uid()
> 
> There is no benefit in describing the code changes like this in the
> commit log. It makes it hard to follow the intent of the patch.
> 
>> This is the first step towards unifying ACPI CPU UID retrieval interface
>> across architectures, while adding input validation for robustness.
> 
> I would simplify the commit log to something along the lines of -
> 
>     As a step towards unifying the interface for retrieving ACPI CPU uid
>     across architectures, introduce a new function
>     acpi_get_cpu_uid(). While at it, also add input validation to make
>     the code more robust.

Thank you for your advice.
I've reviewed all the commit logs and made some optimizations, and done in v10

> 
> Just my 2c.
> 
> The code changes looks fine.
> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> ---
>>  arch/arm64/include/asm/acpi.h      | 14 ++------------
>>  arch/arm64/kernel/acpi.c           | 30 ++++++++++++++++++++++++++++++
>>  drivers/perf/arm_cspmu/arm_cspmu.c |  6 ++++--
>>  3 files changed, 36 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index c07a58b96329..2219a3301e72 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -118,18 +118,8 @@ static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
>>  {
>>  	return	acpi_cpu_get_madt_gicc(cpu)->uid;
>>  }
>> -
>> -static inline int get_cpu_for_acpi_id(u32 uid)
>> -{
>> -	int cpu;
>> -
>> -	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
>> -		if (acpi_cpu_get_madt_gicc(cpu) &&
>> -		    uid == get_acpi_id_for_cpu(cpu))
>> -			return cpu;
>> -
>> -	return -EINVAL;
>> -}
>> +int acpi_get_cpu_uid(unsigned int cpu, u32 *uid);
>> +int get_cpu_for_acpi_id(u32 uid);
>>  
>>  static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>>  void __init acpi_init_cpus(void);
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index af90128cfed5..24b9d934be54 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -458,3 +458,33 @@ int acpi_unmap_cpu(int cpu)
>>  }
>>  EXPORT_SYMBOL(acpi_unmap_cpu);
>>  #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>> +
>> +int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
>> +{
>> +	struct acpi_madt_generic_interrupt *gicc;
>> +
>> +	if (cpu >= nr_cpu_ids)
>> +		return -EINVAL;
>> +
>> +	gicc = acpi_cpu_get_madt_gicc(cpu);
>> +	if (!gicc)
>> +		return -ENODEV;
>> +
>> +	*uid = gicc->uid;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_get_cpu_uid);
>> +
>> +int get_cpu_for_acpi_id(u32 uid)
>> +{
>> +	u32 cpu_uid;
>> +	int ret;
>> +
>> +	for (int cpu = 0; cpu < nr_cpu_ids; cpu++) {
>> +		ret = acpi_get_cpu_uid(cpu, &cpu_uid);
>> +		if (ret == 0 && uid == cpu_uid)
>> +			return cpu;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
>> index 34430b68f602..ed72c3d1f796 100644
>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>> @@ -1107,15 +1107,17 @@ static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
>>  {
>>  	struct acpi_apmt_node *apmt_node;
>>  	int affinity_flag;
>> +	u32 cpu_uid;
>>  	int cpu;
>> +	int ret;
>>  
>>  	apmt_node = arm_cspmu_apmt_node(cspmu->dev);
>>  	affinity_flag = apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
>>  
>>  	if (affinity_flag == ACPI_APMT_FLAGS_AFFINITY_PROC) {
>>  		for_each_possible_cpu(cpu) {
>> -			if (apmt_node->proc_affinity ==
>> -			    get_acpi_id_for_cpu(cpu)) {
>> +			ret = acpi_get_cpu_uid(cpu, &cpu_uid);
>> +			if (ret == 0 && apmt_node->proc_affinity == cpu_uid) {
>>  				cpumask_set_cpu(cpu, &cspmu->associated_cpus);
>>  				break;
>>  			}
> 
> I think cspmu changes go via a separate pull request. You might have to
> split this change into a separate commit.

done in v10

Thanks

