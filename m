Return-Path: <stable+bounces-227226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBvENyWiu2kLmAIAu9opvQ
	(envelope-from <stable+bounces-227226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 08:13:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E60D2C720D
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 08:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77200308A24A
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 07:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA8739E18F;
	Thu, 19 Mar 2026 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RRC8Qk+v"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5746039B97D;
	Thu, 19 Mar 2026 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773904399; cv=none; b=s4FV7qYhWzK2fvO1C8ispQVrp25j/71PuVIrYCec5Pei75a8alZbq+VSj/xK1VvY0J1w9pHRwdn8gM9VnSpczg4OIiscyhBWpVGYINp1vhmRCIgj50MrRqbkn1lGzg/dJRFIUGwxhopmiTwxjMHCtZqxs/CTM4EU1qKDs7nQ0GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773904399; c=relaxed/simple;
	bh=ObpxqKdd4T1HHP+LHUq29v7pjRvtkMicxQwklMl+rDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dq8xF1/veYqrn9XqbsFescYUGtSbk8SncJvlshK/c2VpMlskkK6yh9LbA9o0vjzWeHp4vDtyzag+lPXbvZAgow2E2REVaH582cYiiEf+EHzMcxSDYbsO3K+XAIzRrpqCTraj24IST6TvqO/UtBcpoHmd6Shf7AkMrRvXcpQPG/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RRC8Qk+v; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rOgEX5LRjbf3VsJc30kly4+FTpT24EGUmpEIfFvp8FU=;
	b=RRC8Qk+vDk32R8JHqebkm1tGtkV6aqC7Rw/5tqI1aHILlK2h2Fd3giMbyZt1JjR+/2C5nr3jN
	LCoxznkWL7DSqvcKp14FgIYEdmkocS9XrRO5OVujVzcsJ5/bSzagK1Q0OB6Ne0iQgcMvxD/5fTO
	P3k1x2ro3WxAtvbL88NnXM8=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fbxcD4jF6z1cyPP;
	Thu, 19 Mar 2026 15:08:12 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 8543840363;
	Thu, 19 Mar 2026 15:13:12 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 19 Mar 2026 15:13:10 +0800
Message-ID: <264525a9-aa36-4848-80c0-f8cf246f93b8@huawei.com>
Date: Thu, 19 Mar 2026 15:13:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/3] ACPI: Refactor get_acpi_id_for_cpu() to
 acpi_get_cpu_uid() on non-x86
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Ingo Molnar
	<mingo@redhat.com>, Juergen Gross <jgross@suse.com>, Boris Ostrovsky
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
	Somnath Kotur <somnath.kotur@broadcom.com>, <punit.agrawal@oss.qualcomm.com>,
	<guohanjun@huawei.com>, <suzuki.poulose@arm.com>, <ryan.roberts@arm.com>,
	<chenl311@chinatelecom.cn>, <masahiroy@kernel.org>,
	<wangyuquan1236@phytium.com.cn>, <anshuman.khandual@arm.com>,
	<heinrich.schuchardt@canonical.com>, <Eric.VanTassell@amd.com>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <linux-pci@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <xen-devel@lists.xenproject.org>,
	<linux-acpi@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260318213458.GA474040@bhelgaas>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260318213458.GA474040@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
	TAGGED_FROM(0.00)[bounces-227226-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_GT_50(0.00)[58];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E60D2C720D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/2026 5:34 AM, Bjorn Helgaas wrote:
> On Wed, Mar 18, 2026 at 02:01:49PM +0800, Chengwen Feng wrote:
>> Unify CPU ACPI ID retrieval interface across architectures by
>> refactoring get_acpi_id_for_cpu() to acpi_get_cpu_uid() on
>> arm64/riscv/loongarch:
>> - Add input parameter validation
>> - Adjust interface to int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
>>   (old: u32 get_acpi_id_for_cpu(unsigned int cpu), no input check)
>>
>> This refactoring (not a pure rename) enhances interface robustness while
>> preparing for consistent ACPI Processor UID retrieval across all
>> ACPI-enabled platforms. Valid inputs retain original behavior.
>>
>> Note: Move the ARM64-specific get_cpu_for_acpi_id() implementation to
>>       arch/arm64/kernel/acpi.c to fix compilation errors from circular
>>       header dependencies introduced by the rename.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> ---
>>  arch/arm64/include/asm/acpi.h      | 16 +---------
>>  arch/arm64/kernel/acpi.c           | 30 ++++++++++++++++++
>>  arch/loongarch/include/asm/acpi.h  |  5 ---
>>  arch/loongarch/kernel/acpi.c       |  9 ++++++
>>  arch/riscv/include/asm/acpi.h      |  4 ---
>>  arch/riscv/kernel/acpi.c           | 16 ++++++++++
>>  arch/riscv/kernel/acpi_numa.c      |  9 ++++--
>>  drivers/acpi/pptt.c                | 50 ++++++++++++++++++++++--------
>>  drivers/acpi/riscv/rhct.c          |  7 ++++-
>>  drivers/perf/arm_cspmu/arm_cspmu.c |  6 ++--
>>  include/linux/acpi.h               | 13 ++++++++
>>  11 files changed, 122 insertions(+), 43 deletions(-)
> 
> There's a lot going on in this single patch, which makes it hard to
> review.  I think this might make more sense as several patches:
> 
>   - arm64: declare acpi_get_cpu_uid() in arch/arm64/include, implement
>     it, and use in drivers/perf/arm_cspmu/arm_cspmu.c
> 
>   - loongarch: declare acpi_get_cpu_uid() in arch/loongarch/include
>     and implement
> 
>   - riscv: declare acpi_get_cpu_uid() in arch/riscv/include, implement
>     it, and use in rhct.c, riscv/kernel/acpi_numa.c
> 
>   - x86: declare acpi_get_cpu_uid() in arch/x86/include, implement it,
>     and use in xen
> 
>   - declare acpi_get_cpu_uid() in include/linux/acpi.h, remove
>     declarations from arm64, loongarch, riscv, x86
> 
>   - convert acpi/pptt.c to use acpi_get_cpu_uid(), remove unused
>     get_acpi_id_for_cpu() from arm64, loongarch, riscv
> 
>   - use acpi_get_cpu_uid() in tph.c

Thanks for the detailed guidance, done in v9

> 
> Doc nit below.
> 

...

>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 4d2f0bed7a06..035094a55f18 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -324,6 +324,19 @@ int acpi_unmap_cpu(int cpu);
>>  
>>  acpi_handle acpi_get_processor_handle(int cpu);
>>  
>> +#ifndef CONFIG_X86
>> +/*
>> + * acpi_get_cpu_uid() - Get ACPI Processor UID of a specified CPU from MADT table
>> + * @cpu: Logical CPU number (0-based)
>> + * @uid: Pointer to store the ACPI Processor UID (valid only on successful return)
> 
> This would normally go at the implementation, but it probably does
> make sense here because each arch has its own implementation.
> 
> Should start with "/**" to make it kernel-doc though.
> 
> Wrap to fit in 78 columns, like other comments in this file.

done in v9

Thanks

> 
>> + * Return: 0 on successful retrieval (the ACPI Processor ID is stored in *uid);
>> + *         -EINVAL if the CPU number is invalid or out of range;
>> + *         -ENODEV if the ACPI Processor UID for the specified CPU is not found.
>> + */
>> +int acpi_get_cpu_uid(unsigned int cpu, u32 *uid);
>> +#endif
> 


