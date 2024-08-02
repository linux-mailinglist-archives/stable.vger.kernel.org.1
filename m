Return-Path: <stable+bounces-65293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A6A945B1A
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 11:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD12B20F9B
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 09:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DED31DAC4A;
	Fri,  2 Aug 2024 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tLHhHxnr"
X-Original-To: stable@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029F71BF311;
	Fri,  2 Aug 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591328; cv=none; b=GlhYjlNbs23jxNGQj0oAX3g6PTvvza8EBhIei/AhwNojc+Y3Jx2WOLf1HkA9kpwspaqop74WNnIQqXF/RgEq2OVE9OWpWOcUFVL/+xiT8PJ0oH42X5TVSiT8XndG2zCyVYOUsHlBVmG46nXr5xRBihDcyNQsgsCwXp0ndlfNN+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591328; c=relaxed/simple;
	bh=EvznqY/WGEHNboqxD/NcGa8tDQgQ8tk7rbOwdsCzhwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hycrjn97PZpEBnCFtnit29F1pwKfNi6gx7hDsA27t2nCYfbLozhgsi3lp9aoOS67ILNerzq91t4u7mHUD+gYIgNuHZDLW7zfDnhLq7FGEPHvtsSGJ8jFG+KGUwV1b95v690wqRdqWrn6oADJ7UZbE4FsCaainyXs32TWygcpj9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tLHhHxnr; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722591316; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=k1MZ89lfvnLgvmQSZXS0n03RYabkk/ngfiG3YiBmHE8=;
	b=tLHhHxnrqmbu1RdqkHh+/+88k+pJvI11OA+idXwTFmkMy+5S9wow63GBLJhLnsxfTa3rMh0a+TrV3ikEOksxK3eWEyeqc0wL1jUPILBFI2eULsYjXXsgLN35dBHdz8Vdm8Fo6oqszMb6hSTqqiJCpk6KcqLGiz6Z8ivkkikwikE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0WBx0EmP_1722591314;
Received: from 30.97.56.76(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBx0EmP_1722591314)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 17:35:15 +0800
Message-ID: <111927ac-752b-422e-b313-5a96bc736899@linux.alibaba.com>
Date: Fri, 2 Aug 2024 17:35:14 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Peter Xu <peterx@redhat.com>, stable@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Muchun Song <muchun.song@linux.dev>
References: <20240801204748.99107-1-david@redhat.com>
 <0eb66533-445f-45d5-8f68-0281e4ed017d@linux.alibaba.com>
 <066fc0d9-748b-445c-b440-607125b481fe@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <066fc0d9-748b-445c-b440-607125b481fe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/2 16:43, David Hildenbrand wrote:
> On 02.08.24 05:56, Baolin Wang wrote:
>>
>>
>> On 2024/8/2 04:47, David Hildenbrand wrote:
>>> We recently made GUP's common page table walking code to also walk 
>>> hugetlb
>>> VMAs without most hugetlb special-casing, preparing for the future of
>>> having less hugetlb-specific page table walking code in the codebase.
>>> Turns out that we missed one page table locking detail: page table 
>>> locking
>>> for hugetlb folios that are not mapped using a single PMD/PUD.
>>>
>>> Assume we have hugetlb folio that spans multiple PTEs (e.g., 64 KiB
>>> hugetlb folios on arm64 with 4 KiB base page size). GUP, as it walks the
>>> page tables, will perform a pte_offset_map_lock() to grab the PTE table
>>> lock.
>>>
>>> However, hugetlb that concurrently modifies these page tables would
>>> actually grab the mm->page_table_lock: with USE_SPLIT_PTE_PTLOCKS, the
>>> locks would differ. Something similar can happen right now with hugetlb
>>> folios that span multiple PMDs when USE_SPLIT_PMD_PTLOCKS.
>>>
>>> This issue can be reproduced [1], for example triggering:
>>>
>>> [ 3105.936100] ------------[ cut here ]------------
>>> [ 3105.939323] WARNING: CPU: 31 PID: 2732 at mm/gup.c:142 
>>> try_grab_folio+0x11c/0x188
>>> [ 3105.944634] Modules linked in: [...]
>>> [ 3105.974841] CPU: 31 PID: 2732 Comm: reproducer Not tainted 
>>> 6.10.0-64.eln141.aarch64 #1
>>> [ 3105.980406] Hardware name: QEMU KVM Virtual Machine, BIOS 
>>> edk2-20240524-4.fc40 05/24/2024
>>> [ 3105.986185] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS 
>>> BTYPE=--)
>>> [ 3105.991108] pc : try_grab_folio+0x11c/0x188
>>> [ 3105.994013] lr : follow_page_pte+0xd8/0x430
>>> [ 3105.996986] sp : ffff80008eafb8f0
>>> [ 3105.999346] x29: ffff80008eafb900 x28: ffffffe8d481f380 x27: 
>>> 00f80001207cff43
>>> [ 3106.004414] x26: 0000000000000001 x25: 0000000000000000 x24: 
>>> ffff80008eafba48
>>> [ 3106.009520] x23: 0000ffff9372f000 x22: ffff7a54459e2000 x21: 
>>> ffff7a546c1aa978
>>> [ 3106.014529] x20: ffffffe8d481f3c0 x19: 0000000000610041 x18: 
>>> 0000000000000001
>>> [ 3106.019506] x17: 0000000000000001 x16: ffffffffffffffff x15: 
>>> 0000000000000000
>>> [ 3106.024494] x14: ffffb85477fdfe08 x13: 0000ffff9372ffff x12: 
>>> 0000000000000000
>>> [ 3106.029469] x11: 1fffef4a88a96be1 x10: ffff7a54454b5f0c x9 : 
>>> ffffb854771b12f0
>>> [ 3106.034324] x8 : 0008000000000000 x7 : ffff7a546c1aa980 x6 : 
>>> 0008000000000080
>>> [ 3106.038902] x5 : 00000000001207cf x4 : 0000ffff9372f000 x3 : 
>>> ffffffe8d481f000
>>> [ 3106.043420] x2 : 0000000000610041 x1 : 0000000000000001 x0 : 
>>> 0000000000000000
>>> [ 3106.047957] Call trace:
>>> [ 3106.049522]  try_grab_folio+0x11c/0x188
>>> [ 3106.051996]  follow_pmd_mask.constprop.0.isra.0+0x150/0x2e0
>>> [ 3106.055527]  follow_page_mask+0x1a0/0x2b8
>>> [ 3106.058118]  __get_user_pages+0xf0/0x348
>>> [ 3106.060647]  faultin_page_range+0xb0/0x360
>>> [ 3106.063651]  do_madvise+0x340/0x598
>>>
>>> Let's make huge_pte_lockptr() effectively use the same PT locks as any
>>> core-mm page table walker would. Add ptep_lockptr() to obtain the PTE
>>> page table lock using a pte pointer -- unfortunately we cannot convert
>>> pte_lockptr() because virt_to_page() doesn't work with kmap'ed page
>>> tables we can have with CONFIG_HIGHPTE.
>>>
>>> Handle CONFIG_PGTABLE_LEVELS correctly by checking in reverse order,
>>> such that when e.g., CONFIG_PGTABLE_LEVELS==2 with
>>> PGDIR_SIZE==P4D_SIZE==PUD_SIZE==PMD_SIZE will work as expected.
>>> Document why that works.
>>>
>>> There is one ugly case: powerpc 8xx, whereby we have an 8 MiB hugetlb
>>> folio being mapped using two PTE page tables.  While hugetlb wants to 
>>> take
>>> the PMD table lock, core-mm would grab the PTE table lock of one of both
>>> PTE page tables.  In such corner cases, we have to make sure that both
>>> locks match, which is (fortunately!) currently guaranteed for 8xx as it
>>> does not support SMP and consequently doesn't use split PT locks.
>>>
>>> [1] 
>>> https://lore.kernel.org/all/1bbfcc7f-f222-45a5-ac44-c5a1381c596d@redhat.com/
>>>
>>> Fixes: 9cb28da54643 ("mm/gup: handle hugetlb in the generic 
>>> follow_page_mask code")
>>> Acked-by: Peter Xu <peterx@redhat.com>
>>> Cc: <stable@vger.kernel.org>
>>> Cc: Peter Xu <peterx@redhat.com>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Muchun Song <muchun.song@linux.dev>
>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> I tried your reproducer on my ARM64 machine, and this patch can fix the
>> problem.
>>
>> Although I know nothing about HIGHPTE, the other parts look good to me.
>> So feel free to add:
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Thanks! Took longer than expected to get this (hopefully ;) ) right.
> 
> HIGHPTE means that we allocate PTE page tables from highmem on 32bit
> architectures. I think it's only supported on x86 and arm.
> 
> If we allocate page tables from highmem, when we want to read/write
> them, we have to kmap them into kernel virtual address space. This
> is what the whole pte_offset_map_lock() / pte_unmap() does. On
> !highmem configs, the "map/unmap" is a NOP.
> 
> Hugetlb doesn't use pte_offset_map_lock/pte_unmap() when accessing
> page tables and assumes that they are never allocated from highmem.
> So there is the implicit assumption that architectures that use
> PTE page tables for hugetlb don't use HIGHPTE. For this reason, also
> pte_alloc_huge() is guarded by CONFIG_HIGHPTE:
> 
> include/linux/hugetlb.h:
> "
> #ifndef CONFIG_HIGHPTE
> /*
>   * pte_offset_huge() and pte_alloc_huge() are helpers for those 
> architectures
>   * which may go down to the lowest PTE level in their huge_pte_offset() 
> and
>   * huge_pte_alloc(): to avoid reliance on pte_offset_map() without 
> pte_unmap().
>   */
> "

Thanks for the explanation:)

