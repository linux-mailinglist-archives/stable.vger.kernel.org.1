Return-Path: <stable+bounces-154747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47340ADFF31
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE37217C1AF
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 07:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCD1246784;
	Thu, 19 Jun 2025 07:55:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C10D230BF2;
	Thu, 19 Jun 2025 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319736; cv=none; b=FnKwd2HhhDYlo7rHwuvL3ZYgOd5L31vUpld0V5kCfj3/Vn0D9MrDOs4BlLCQRo3xrXhpnDJpeg/UJECas6QL+tl8sQuP3uE806AWear4ocCC2lC6evv3CgzC8G/WRwP7iOBhKP6pRwmm7ANXTAF/N5Vee1j6b7GaOyxg3ZYguuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319736; c=relaxed/simple;
	bh=f4vTpMQgH6hjBMjYYSMsrAQ9uauN0x5DGtU+5NDgL4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X/K/Wq6TosChnjvv9Ge57IQ0kF8E8cal1lD7RKdJI7qPGKjZQ7h4OEOdGm5ScgbyXufoGkYFVHihwdIfWrZ4641eit9MpkvFfpzkoNcbGexRRsTHDznl7FyxZR1onu9J8T064G5zvBV6JBXpYvWa4AFHUl6tt3sLpn0NDJUNhTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68ECB106F;
	Thu, 19 Jun 2025 00:55:12 -0700 (PDT)
Received: from [10.163.35.214] (unknown [10.163.35.214])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C8DD3F66E;
	Thu, 19 Jun 2025 00:55:30 -0700 (PDT)
Message-ID: <fb86e753-95c0-41bd-b8f6-ebc810cd8a94@arm.com>
Date: Thu, 19 Jun 2025 13:25:27 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/ptdump: Ensure memory hotplug is prevented during
 ptdump_check_wx()
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 Dev Jain <dev.jain@arm.com>
References: <20250609041214.285664-1-anshuman.khandual@arm.com>
 <20250612145808.GA12912@willie-the-truck>
 <5c22c792-0648-4ced-b0ed-86882610b4be@arm.com>
 <20250618113635.GA20157@willie-the-truck>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250618113635.GA20157@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/06/25 5:06 PM, Will Deacon wrote:
> On Fri, Jun 13, 2025 at 10:39:02AM +0530, Anshuman Khandual wrote:
>>
>>
>> On 12/06/25 8:28 PM, Will Deacon wrote:
>>> On Mon, Jun 09, 2025 at 05:12:14AM +0100, Anshuman Khandual wrote:
>>>> The arm64 page table dump code can race with concurrent modification of the
>>>> kernel page tables. When a leaf entries are modified concurrently, the dump
>>>> code may log stale or inconsistent information for a VA range, but this is
>>>> otherwise not harmful.
>>>>
>>>> When intermediate levels of table are freed, the dump code will continue to
>>>> use memory which has been freed and potentially reallocated for another
>>>> purpose. In such cases, the dump code may dereference bogus addresses,
>>>> leading to a number of potential problems.
>>>>
>>>> This problem was fixed for ptdump_show() earlier via commit 'bf2b59f60ee1
>>>> ("arm64/mm: Hold memory hotplug lock while walking for kernel page table
>>>> dump")' but a same was missed for ptdump_check_wx() which faced the race
>>>> condition as well. Let's just take the memory hotplug lock while executing
>>>> ptdump_check_wx().
>>>
>>> How do other architectures (e.g. x86) handle this? I don't see any usage
>>> of {get,put}_online_mems() over there. Should this be moved into the core
>>> code?
>>
>> Memory hot remove on arm64 unmaps kernel linear and vmemmap mapping while
>> also freeing page table pages if those become empty. Although this might
>> not be true for all other architectures, which might just unmap affected
>> kernel regions but does not tear down the kernel page table.
> 
> ... that sounds like something we should be able to give a definitive
> answer to?

Agreed.

arch_remove_memory() is the primary arch callback which does the unmapping
and also tearing down of the required kernel page table regions i.e linear
and vmemmap mapping . These are the call paths that reach platform specific
memory removal via arch_remove_memory().

A) ZONE_DEVICE

devm_memremap_pages()
    devm_memremap_pages_release()
        devm_memunmap_pages()
            memunmap_pages()
                arch_remove_memory()

B) Normal DRAM

echo 1 > /sys/devices/system/memory/memoryX/offline

memory_subsys_offline()
    device_offline()
        memory_offline()
            offline_memory_block()
                remove_memory()
                    __remove_memory()
                        arch_remove_memory()

Currently there are six platforms which enable ARCH_ENABLE_MEMORY_HOTREMOVE
thus implementing arch_remove_memory(). Core memory hot removal process does
not have any set expectations from these callbacks. So platforms are free to
implement unmap and page table tearing down operation as deemed necessary.

ARCH_ENABLE_MEMORY_HOTREMOVE - arm64, loongarch, powerpc, riscv, s390, x86
ARCH_HAS_PTDUMP              - arm64, powerpc, riscv, s390, x86

In summary all the platforms that support memory hot remove and ptdump do
try and free the unmapped regions of the page table when possible. Hence
they are indeed exposed to possible race with ptdump walk.

But as mentioned earlier the callback arch_remove_memory() does not have to
tear down the page tables. Unless there are objections from other platforms,
standard memory hotplug lock could indeed be taken during all generic ptdump
walk paths. 

arm64
=====
    arch_remove_memory()
        __remove_pages()
            sparse_remove_section()
                section_deactivate()
                    depopulate_section_memmap()
                    free_map_bootmem()
                        vmemmap_free()              /* vmemap mapping */
                            unmap_hotplug_range()   /* Unmap */
                            free_empty_tables()     /* Tear down */

        __remove_pgd_mapping()
            __remove_pgd_mapping()                  /* linear Mapping */
                unmap_hotplug_range()               /* Unmap */
                free_empty_tables()                 /* Tear down */

powerpc
=======
    arch_remove_memory()
        __remove_pages()
            sparse_remove_section()
                    section_deactivate()
                        depopulate_section_memmap()
                            vmemmap_free()
                                __vmemmap_free()            /* Hash */
                                radix__vmemmap_free()       /* Radix */

        arch_remove_linear_mapping()
            remove_section_mapping()
                hash__remove_section_mapping()              /* Hash */
                radix__remove_section_mapping()             /* Radix */
    
riscv
=====
    arch_remove_memory()
        __remove_pages()
            sparse_remove_section()
                    section_deactivate()
                        depopulate_section_memmap()
                            vmemmap_free()
                                remove_pgd_mapping()

        remove_linear_mapping()
            remove_pgd_mapping()
    
remove_pgd_mapping() recursively calls remove_pxd_mapping() and
free_pxd_table() when applicable.

s390
=====
    arch_remove_memory()
        __remove_pages()
            sparse_remove_section()
                section_deactivate()
                    depopulate_section_memmap()
                        vmemmap_free()
                            remove_pagetable()
                                modify_pagetable()
        
        vmem_remove_mapping()
            vmem_remove_range()
                remove_pagetable() 
                        modify_pagetable()

modify_pagetable() on s390 does try to tear down the page table
when possible.
 
x86
===
    arch_remove_memory()
        __remove_pages()
            sparse_remove_section()
                section_deactivate()
                    depopulate_section_memmap()
                    free_map_bootmem()
                        vmemmap_free()              /* vmemap mapping */
                            remove_pagetable()

        kernel_physical_mapping_remove()            /* linear Mapping */
            remove_pagetable()

remove_pagetable() on x86 calls remove_pxd_table() followed up call
with free_pxd_table() which does tear down the page table as well
and hence exposed to race with PTDUMP which scans over the entire
kernel page table.

