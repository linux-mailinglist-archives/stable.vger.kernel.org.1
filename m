Return-Path: <stable+bounces-225234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGyDE3x3s2mwWgAAu9opvQ
	(envelope-from <stable+bounces-225234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 03:33:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B326027CCEB
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 03:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B8383130A90
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 02:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3034167B;
	Fri, 13 Mar 2026 02:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kwa1qp22"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC26340A51;
	Fri, 13 Mar 2026 02:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773369159; cv=none; b=EU9g1ykuCwEnkQjMjb7SE1v/4O5YO2mboS6QxDDdApPSZJVxlIoFDAjGbOmLp5IjHHm94ld+xnMi8bOZj2ugYlXFVrarijxIGz+WEqL/XzxLZyi62oh7PlTiAQ7cp8BJt+HMHcbAovsGraxnFFIpUqThW+uz/x1/8pKmp4XoMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773369159; c=relaxed/simple;
	bh=LExNlQiCZUjsXaPNmcgYrwD6RjjtJjnzxerVrDGlSOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HSXYTS+SkczcvlmNShcKeiaGoXwDrpxbwnd/ObMN2YZ1hJzpzdrY9wCXb8N4F8GNm3fMwVnLHemqIzsjwOyUa2Vft4OUMUM7ct7R1o3QWHvj+yqYXP2e2JI5mrQtQiBJh0hyCXKhWL0egl5PnxvhCZfHWpfJa9+IW2fj03I6JF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kwa1qp22; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=droVX0NUC4A+GNH3y57ZGeXheGPpw9m67aw4WCFjXtI=;
	b=kwa1qp22L/gdJGPkqfbGAAXcu+LyOqhrEw20HKvhNdqzvoQKMdK9OzPtPhARsHhl6j2D6P+Zr
	j6GC+HeoE9kX8IxSB+U4y21CjsurYvoSHiov38HwUlAKYHAcTB7jnvqfYq4tyu+pAfwUx7PDu7P
	JI+N0ZgVvFlAzWAcsIeXyiI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fX7gC35ghz1prLS;
	Fri, 13 Mar 2026 10:27:35 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A2E040569;
	Fri, 13 Mar 2026 10:32:34 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Mar 2026 10:32:31 +0800
Message-ID: <90505ea3-d842-4092-9743-6ed58c59ca55@huawei.com>
Date: Fri, 13 Mar 2026 10:32:31 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] x86: Implement acpi_get_cpu_uid()
To: Peter Zijlstra <peterz@infradead.org>
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
	<kevinloughlin@google.com>, Zheyun Shen <szy0127@sjtu.edu.cn>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Xin Li <xin@zytor.com>, "Ahmed S .
 Darwish" <darwi@linutronix.de>, Sohil Mehta <sohil.mehta@intel.com>, Ilkka
 Koskinen <ilkka@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>,
	James Clark <james.clark@linaro.org>, Besar Wicaksono
	<bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>, Wei Huang
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
References: <20260312072316.4806-1-fengchengwen@huawei.com>
 <20260312072316.4806-3-fengchengwen@huawei.com>
 <20260312110205.GG606826@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260312110205.GG606826@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225234-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[69];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B326027CCEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/2026 7:02 PM, Peter Zijlstra wrote:
> On Thu, Mar 12, 2026 at 03:23:15PM +0800, Chengwen Feng wrote:
>> Add acpi_get_cpu_uid() implementation for x86, replacing the existing
>> cpu_acpi_id() function. This completes the unified ACPI Processor UID
>> retrieval interface across all ACPI-enabled architectures.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  arch/x86/include/asm/cpu.h   |  1 -
>>  arch/x86/include/asm/smp.h   |  1 -
>>  arch/x86/kernel/cpu/common.c | 15 +++++++++++++++
>>  arch/x86/xen/enlighten_hvm.c |  5 +++--
>>  include/linux/acpi.h         |  2 --
>>  5 files changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
>> index ad235dda1ded..57a0786dfd75 100644
>> --- a/arch/x86/include/asm/cpu.h
>> +++ b/arch/x86/include/asm/cpu.h
>> @@ -11,7 +11,6 @@
>>  
>>  #ifndef CONFIG_SMP
>>  #define cpu_physical_id(cpu)			boot_cpu_physical_apicid
>> -#define cpu_acpi_id(cpu)			0
>>  #endif /* CONFIG_SMP */
>>  
>>  #ifdef CONFIG_HOTPLUG_CPU
>> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
>> index 84951572ab81..05d1d479b4cf 100644
>> --- a/arch/x86/include/asm/smp.h
>> +++ b/arch/x86/include/asm/smp.h
>> @@ -130,7 +130,6 @@ __visible void smp_call_function_interrupt(struct pt_regs *regs);
>>  __visible void smp_call_function_single_interrupt(struct pt_regs *r);
>>  
>>  #define cpu_physical_id(cpu)	per_cpu(x86_cpu_to_apicid, cpu)
>> -#define cpu_acpi_id(cpu)	per_cpu(x86_cpu_to_acpiid, cpu)
>>  
>>  /*
>>   * This function is needed by all SMP systems. It must _always_ be valid
>> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>> index 1c3261cae40c..3081557542c7 100644
>> --- a/arch/x86/kernel/cpu/common.c
>> +++ b/arch/x86/kernel/cpu/common.c
>> @@ -28,6 +28,7 @@
>>  #include <linux/stackprotector.h>
>>  #include <linux/utsname.h>
>>  #include <linux/efi.h>
>> +#include <linux/acpi.h>
>>  
>>  #include <asm/alternative.h>
>>  #include <asm/cmdline.h>
>> @@ -57,6 +58,7 @@
>>  #include <asm/asm.h>
>>  #include <asm/bugs.h>
>>  #include <asm/cpu.h>
>> +#include <asm/smp.h>
>>  #include <asm/mce.h>
>>  #include <asm/msr.h>
>>  #include <asm/cacheinfo.h>
>> @@ -2643,3 +2645,16 @@ void __init arch_cpu_finalize_init(void)
>>  	 */
>>  	mem_encrypt_init();
>>  }
>> +
>> +int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
>> +{
>> +	if (cpu >= nr_cpu_ids)
>> +		return -EINVAL;
>> +#ifndef CONFIG_SMP
>> +	*uid = 0;
>> +#else
>> +	*uid = per_cpu(x86_cpu_to_acpiid, cpu);
>> +#endif
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_get_cpu_uid);
>> diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
>> index fe57ff85d004..2f9fa27e5a3c 100644
>> --- a/arch/x86/xen/enlighten_hvm.c
>> +++ b/arch/x86/xen/enlighten_hvm.c
>> @@ -151,6 +151,7 @@ static void xen_hvm_crash_shutdown(struct pt_regs *regs)
>>  
>>  static int xen_cpu_up_prepare_hvm(unsigned int cpu)
>>  {
>> +	u32 cpu_uid;
>>  	int rc = 0;
>>  
>>  	/*
>> @@ -161,8 +162,8 @@ static int xen_cpu_up_prepare_hvm(unsigned int cpu)
>>  	 */
>>  	xen_uninit_lock_cpu(cpu);
>>  
>> -	if (cpu_acpi_id(cpu) != CPU_ACPIID_INVALID)
>> -		per_cpu(xen_vcpu_id, cpu) = cpu_acpi_id(cpu);
>> +	if (acpi_get_cpu_uid(cpu, &cpu_uid) == 0)
>> +		per_cpu(xen_vcpu_id, cpu) = cpu_uid;
>>  	else
>>  		per_cpu(xen_vcpu_id, cpu) = cpu;
>>  	xen_vcpu_setup(cpu);
> 
> This doesn't look right, it will now set CPU_ACPIID_INVALID, while
> previously it would not.

This is indeed an issue, it has been fixed in v7 (by treating CPU_ACPIID_INVALID as an error).

Thanks

> 
> 


