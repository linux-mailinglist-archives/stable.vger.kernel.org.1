Return-Path: <stable+bounces-224638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLs0OMXasGmHnwIAu9opvQ
	(envelope-from <stable+bounces-224638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 04:00:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D2525B377
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 04:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 702A030C0FEB
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84272F3C3E;
	Wed, 11 Mar 2026 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UIuMwL2Z"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38E2868B5;
	Wed, 11 Mar 2026 03:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773198010; cv=none; b=r2B2jtdlS8LPfpbojXZP9TCgg97CKHFEWD4sVdtoVBICOSCBF0fQEIHhN4c3CrVUNgamKxl3pc4YnkFRb06e1q1DFrVWrhxvmOBFOpFsXF5jRRdEk9Pk555JEqNI/TWJ0j1duYei0b1hdzG0Ci4dJ114H6qFdi+SX0phiSh4PyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773198010; c=relaxed/simple;
	bh=ZVNRdZOlzeflVbYT5vXQDtqpMaNUZi2VFbF2LUVNHBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uooMZMzvm+9QtcxRJHnoRy+yySxcTYX1uUmvguXmrTJHhwsr2/TS42k4wK4PoQvKPNOnYEzwG2d7JW4NyqEcNJywz/Pd1UgmjUwHf1OM8z1lXAUikJNP8e9t2YD1QhletZxajT1hqFEWozyZHJQhbRWUQklVN9xBo145vUE+79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UIuMwL2Z; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DUKycpPzpFIpG0env8jwSvfK5sQZJJ1YY0eqvDa9Ls4=;
	b=UIuMwL2ZnQBHKt0OSz5st4Og2VYIGREkqW4SE+XsyKkbHXGhNjJEsAWrxVSqy6OOZJ3NLbK9Z
	kP8s3Xd0pnLT2F4QMacoWnfn19/NxFuvNNLMkzdoJPW46wBbTVsZOQsEtjgpquwRCBs94A0/o7e
	g1HUZD+aWdwNP2wFTTnfWEY=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fVwMy3T5lzLlSf;
	Wed, 11 Mar 2026 10:55:10 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 7FEF34056C;
	Wed, 11 Mar 2026 11:00:05 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Mar 2026 11:00:03 +0800
Message-ID: <9ef9b529-839b-4cf0-a294-5b68fe8aa768@huawei.com>
Date: Wed, 11 Mar 2026 11:00:02 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] PCI/TPH: Fix get cpu steer-tag fail on ARM64
 platform
To: Bjorn Helgaas <helgaas@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>
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
 Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>, Ajit Khaparde
	<ajit.khaparde@broadcom.com>, Wei Huang <wei.huang2@amd.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>, <linux-pci@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <xen-devel@lists.xenproject.org>,
	<linux-acpi@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<stable@vger.kernel.org>, Wathsala Vithanage <wathsala.vithanage@arm.com>
References: <20260310220920.GA826995@bhelgaas>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260310220920.GA826995@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: 37D2525B377
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-224638-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_GT_50(0.00)[63];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/11/2026 6:09 AM, Bjorn Helgaas wrote:
> On Tue, Mar 10, 2026 at 10:58:49AM -0500, Jeremy Linton wrote:
>> On 3/9/26 10:20 PM, Chengwen Feng wrote:
>>> pcie_tph_get_cpu_st() is broken on ARM64:
>>> 1. pcie_tph_get_cpu_st() passes cpu_uid to the PCI ACPI DSM method.
>>>     cpu_uid should be the ACPI Processor UID [1].
>>> 2. In BNXT, pcie_tph_get_cpu_st() is passed a cpu_uid obtained via
>>>     cpumask_first(irq->cpu_mask) - the logical CPU ID of a CPU core,
>>>     generated and managed by kernel (e.g., [0,255] for a system  with 256
>>>     logical CPU cores).
>>> 3. On ARM64 platforms, ACPI assigns Processor UID to cores listed in the
>>>     MADT table, and this UID may not match the kernel's logical CPU ID.
>>>     When this occurs, the mismatch results in the wrong CPU steer-tag.
>>> 4. On AMD x86 the logical CPU ID is identical to the ACPI Processor UID
>>>     so the mismatch is not seen.
> 
>>>   int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
>>> -			unsigned int cpu_uid, u16 *tag)
>>> +			unsigned int cpu, u16 *tag)
>>>   {
>>>   #ifdef CONFIG_ACPI
>>> +	u32 cpu_uid = acpi_get_cpu_acpi_id(cpu);
> 
> From AI review (gemini/gemini-3.1-pro-preview):
> 
>   Does this code need to validate that `cpu` is within bounds before
>   using it?  Before this change, the `cpu_uid` parameter was passed
>   opaquely to the ACPI firmware via `tph_invoke_dsm()`, which would
>   gracefully handle invalid values.
> 
>   Now, `cpu` is treated as a logical CPU index and passed to
>   `acpi_get_cpu_acpi_id(cpu)`. On architectures like arm64 and riscv,
>   `acpi_get_cpu_acpi_id()` uses `cpu` directly as an array index
>   (`&cpu_madt_gicc[cpu]` and `&cpu_madt_rintc[cpu]`). On x86, it uses
>   `per_cpu(x86_cpu_to_acpiid, cpu)`.
> 
>   If a caller passes an out-of-bounds `cpu` index (for example, if an
>   IRQ affinity mask is empty and `cpumask_first()` returns
>   `nr_cpu_ids`, or if userspace passes an arbitrary ID via
>   `mlx5_st_alloc_index()`), this will result in an out-of-bounds
>   memory read.
> 
>   Consider adding a bounds check:
> 
>     if (cpu >= nr_cpu_ids)
>       return -EINVAL;
> 
> I agree that this is an issue, and I think implementations of
> acpi_get_cpu_acpi_id() should validate their inputs.
> 
> I don't know if there's a value that can never be a valid ACPI CPU UID
> and could be used as an error value from acpi_get_cpu_acpi_id().  I do
> see a few mentions of a ~0 value meaning "all processors" (ACPI r6.6,
> sec 5.2.12.13).  

I only have the ACPI Specification Version 6.5, so I will use v6.5 as an example.

The ACPI specification does not define invalid value ranges for the ACPI UID.
For the arm64 platform (Section 5.2.12.14):
  ACPI Processor UID: The OS associates this GICC Structure with a processor device
                      object in the namespace when the _UID child object of the
                      processor device evaluates to a numeric value that matches
                      the numeric value in this field.

I am concerned that we cannot implement it like this:
	int acpi_get_cpu_uid(unsigned int cpu) {
		if (cpu >= nr_cpu_ids)
			return -EINVAL;
		...
	}
or:
	u32 acpi_get_cpu_uid(unsigned int cpu) {
		if (cpu >= nr_cpu_ids)
			return U32_MAX;
		...
	}

How about implementing it as follows:
	s64 acpi_get_cpu_uid(unsigned int cpu) {
		if (cpu >= nr_cpu_ids)
			return -EINVAL;
		...
	}
or
	int acpi_get_cpu_uid(unsigned int cpu, u32 *uid) {
		if (cpu >= nr_cpu_ids)
			return -EINVAL;
		*uid = xxx;
		return 0;
	}



Another issue: This commit also provides an implementation for the x86 platform.
However, further code analysis revealed a potential problem in the implementation:

The acpi_get_cpu_acpi_id() retrieves uid from x86_cpu_to_acpiid in SMP, and
x86_cpu_to_acpiid is set through the call chain: acpi_parse_lapic() ->
topology_register_apic() -> topo_register_apic() -> topo_set_cpuids() ->
x86_cpu_to_acpiid. It appears to retrieve the "ACPI Processor UID" from
ACPI Section 5.2.12.2, but the problem is that this field is only one byte in length,
which may cause issues in huge-core systems.

Therefore, I suggest re-implementing the acpi_get_cpu_uid function for the x86
platform. Either I provide a default implementation (shown below), or x86 guys
contribute to the implementation:

	s64 acpi_get_cpu_uid(unsigned int cpu) {
		if (cpu >= nr_cpu_ids)
			return -EINVAL;
		return cpu;
	}

Thanks

> 


