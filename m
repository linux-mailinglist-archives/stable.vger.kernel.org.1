Return-Path: <stable+bounces-115021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E299A32118
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5C203A2ECD
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 08:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9639F2054FF;
	Wed, 12 Feb 2025 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VPllBvtC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A64B2054E0
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 08:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348935; cv=none; b=N4aiCYrl1GfKVrL5H0bFV4LSPy5oOuPCnjGN4U5P3BxBap8bWCSoxCF209JaH/oF0UuaSyrTY/oCOPS8zl7ATAuklSNXucvnKfdqy4LiRfWJMeK5xk5eMc6QgQmhdmk8jY2Fb1cKrO6QSpNQivzzNJxUTRpfLN+Rs7ecnJVPcrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348935; c=relaxed/simple;
	bh=3rvb4R31pOJPM6kPOEXa54Gw9ZSCN3adegC963dSIn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2It4yDGlfZtjtQXOEzgucvj6xpUJS6ahBNRWRBjchrf14s25n0s+hA1CScdS9S3SbQY584FqZw7gYHUExyEmMw4Ul1HDCW8jbzPXFfGn81n4Wt/M6iDMH74ZbYeFMy/8WsrselXf2lh4zbNZkBNLEsENh/c1gcUc+JRDxYEAGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VPllBvtC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f5a224544so58430255ad.0
        for <stable@vger.kernel.org>; Wed, 12 Feb 2025 00:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739348933; x=1739953733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=612jIvxL1e9qxD4qIQOZLpI6wF7davzI0ud5ar8CQG0=;
        b=VPllBvtCuVo0lxl7HlgesPeZo93hk4bRA1VR0pnSN1zQT8PByVxiD1enHrk7Bou28T
         3/s9SEm2UZCkoP5B7s885JUmICvv6tj+yPBiCs4e5/IR/n65QJJl0RzVIzNDvKwp8/gi
         7iNueJjVHlfjmL+M0hQ32141UT76SGIx+c53Uy76+jkqzMSeXkLBrKHpofnBO04nRhVF
         UHIqha8iMcpFdk+rFP1ZwKFRClAo9PUX8ZQoOuHeJtYzoZLvNQfu5fpLjuiNllExEn4K
         WDfj4odUOxmECh/4+JNlED2U3aRqS2DLDse1hDPFUC3qOVSt0y4i3/El9fIHjn/EYFiH
         3RDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739348933; x=1739953733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=612jIvxL1e9qxD4qIQOZLpI6wF7davzI0ud5ar8CQG0=;
        b=iZ5Lu2XKrMzxqfQq2WeHoYwL05hkGmJ3uKNeWrAg7Cb1KrcBF10bA8EK2LnZNz/tLh
         CcijecZypVYZdGTofpdKuRILFnxXubBrNpqgrQBojSeOxX0cfrvEjwZAhqsuaEW4rqfe
         M7X7xps/RGs1UlGAO7cv/VZgk0XqkGAvUpcUptUa351ueJDPqJMj7oMQfgxHARe9k0c9
         m2AQbOhFJjrGp7DxnWCbzfOJc23dDheuqHAVrzpTh0SfnX4DcIESrV21XOa8QDzApBoz
         QYH4c/QXBQ+BSQGSYsmGaAc1zd725jLt92jfghECj1ZxSrniYITzRIeNhPSrIGrjVwxp
         YwQg==
X-Forwarded-Encrypted: i=1; AJvYcCUpGfu/kZDE2hx6GiCDwBavP7rfqalqSsQi3YRly/q18bwxFfPFVWH0fyrwDH+aHsG7DKFjRtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeUoSfdaueR8M/E8K4WAHbAaequQW6F+LNQNN7QoBFIVDX+4hN
	yyKF9frlYkjVLJYNN8xtP2K53Lo2DyIC8Lsry2QMXV6Bo3EYW5WNvNyRGneesGQ=
X-Gm-Gg: ASbGncs/77ICt+hCCpk3G6Pq3RChlZ1llkmmEj/mvt7++VLMCZGmeAfePORuSmc4aZb
	/WfluQuoGCOX878UswNBNEUP38IroZXDIzCKy/dsrKhPrB7qeLtmcMWCkA5YaSBGPxtgkZCX9aS
	BfPGLUsev4QUCUkMyEIGYPyYE2xoWKd8/LLt1xZrwirW222MCRRuEazHfAA5MmUfXfS8dKpYxsr
	iBCjWVLH97ne3UH+9KBkIHAQ0A6m4V1kfWJytkqAeLdeF+Lo0jjr6Zqq6+khLKvbOMLwAVyhnQ4
	1+tRYRy6XuAxMwZSwpMx1V+456reqapQhdj8k6BIOw==
X-Google-Smtp-Source: AGHT+IHo8yGkr5oWd5KwlTZvIww/CgYd/mju7TZBIcFxDlPlQYOvlk0NqYOCKf+nhwBq6H3RsyfUFg==
X-Received: by 2002:a05:6a21:7a4c:b0:1db:f68a:d943 with SMTP id adf61e73a8af0-1ee5c74731bmr3748745637.17.1739348932670;
        Wed, 12 Feb 2025 00:28:52 -0800 (PST)
Received: from [10.84.150.121] ([203.208.167.154])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aeccfc5sm10700388a12.17.2025.02.12.00.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 00:28:52 -0800 (PST)
Message-ID: <54c30b02-c19e-4e51-8faf-7d6c5560ef6f@bytedance.com>
Date: Wed, 12 Feb 2025 16:28:46 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: pgtable: fix NULL pointer dereference issue
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: linux@armlinux.org.uk, ezra@easyb.ch, hughd@google.com,
 ryan.roberts@arm.com, akpm@linux-foundation.org, muchun.song@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <be323425-2465-423a-a6f4-affbaa1efe09@bytedance.com>
 <20250212064002.55598-1-zhengqi.arch@bytedance.com>
 <d5bba68b-1dba-4367-8d4f-103348b80229@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <d5bba68b-1dba-4367-8d4f-103348b80229@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/2/12 16:20, David Hildenbrand wrote:
> On 12.02.25 07:40, Qi Zheng wrote:
>> When update_mmu_cache_range() is called by update_mmu_cache(), the vmf
>> parameter is NULL, which will cause a NULL pointer dereference issue in
>> adjust_pte():
>>
>> Unable to handle kernel NULL pointer dereference at virtual address 
>> 00000030 when read
>> Hardware name: Atmel AT91SAM9
>> PC is at update_mmu_cache_range+0x1e0/0x278
>> LR is at pte_offset_map_rw_nolock+0x18/0x2c
>> Call trace:
>>   update_mmu_cache_range from remove_migration_pte+0x29c/0x2ec
>>   remove_migration_pte from rmap_walk_file+0xcc/0x130
>>   rmap_walk_file from remove_migration_ptes+0x90/0xa4
>>   remove_migration_ptes from migrate_pages_batch+0x6d4/0x858
>>   migrate_pages_batch from migrate_pages+0x188/0x488
>>   migrate_pages from compact_zone+0x56c/0x954
>>   compact_zone from compact_node+0x90/0xf0
>>   compact_node from kcompactd+0x1d4/0x204
>>   kcompactd from kthread+0x120/0x12c
>>   kthread from ret_from_fork+0x14/0x38
>> Exception stack(0xc0d8bfb0 to 0xc0d8bff8)
>>
>> To fix it, do not rely on whether 'ptl' is equal to decide whether to 
>> hold
>> the pte lock, but decide it by whether CONFIG_SPLIT_PTE_PTLOCKS is
>> enabled. In addition, if two vmas map to the same PTE page, there is no
>> need to hold the pte lock again, otherwise a deadlock will occur. Just 
>> add
>> the need_lock parameter to let adjust_pte() know this information.
>>
>> Reported-by: Ezra Buehler <ezra@easyb.ch>
>> Closes: 
>> https://lore.kernel.org/lkml/CAM1KZSmZ2T_riHvay+7cKEFxoPgeVpHkVFTzVVEQ1BO0cLkHEQ@mail.gmail.com/
>> Fixes: fc9c45b71f43 ("arm: adjust_pte() use pte_offset_map_rw_nolock()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   arch/arm/mm/fault-armv.c | 40 ++++++++++++++++++++++++++++------------
>>   1 file changed, 28 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
>> index 2bec87c3327d2..3627bf0957c75 100644
>> --- a/arch/arm/mm/fault-armv.c
>> +++ b/arch/arm/mm/fault-armv.c
>> @@ -62,7 +62,7 @@ static int do_adjust_pte(struct vm_area_struct *vma, 
>> unsigned long address,
>>   }
>>   static int adjust_pte(struct vm_area_struct *vma, unsigned long 
>> address,
>> -              unsigned long pfn, struct vm_fault *vmf)
>> +              unsigned long pfn, bool need_lock)
>>   {
>>       spinlock_t *ptl;
>>       pgd_t *pgd;
>> @@ -99,12 +99,11 @@ static int adjust_pte(struct vm_area_struct *vma, 
>> unsigned long address,
>>       if (!pte)
>>           return 0;
>> -    /*
>> -     * If we are using split PTE locks, then we need to take the page
>> -     * lock here.  Otherwise we are using shared mm->page_table_lock
>> -     * which is already locked, thus cannot take it.
>> -     */
>> -    if (ptl != vmf->ptl) {
>> +    if (need_lock) {
>> +        /*
>> +         * Use nested version here to indicate that we are already
>> +         * holding one similar spinlock.
>> +         */
>>           spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>           if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
>>               pte_unmap_unlock(pte, ptl);
>> @@ -114,7 +113,7 @@ static int adjust_pte(struct vm_area_struct *vma, 
>> unsigned long address,
>>       ret = do_adjust_pte(vma, address, pfn, pte);
>> -    if (ptl != vmf->ptl)
>> +    if (need_lock)
>>           spin_unlock(ptl);
>>       pte_unmap(pte);
>> @@ -123,16 +122,17 @@ static int adjust_pte(struct vm_area_struct 
>> *vma, unsigned long address,
>>   static void
>>   make_coherent(struct address_space *mapping, struct vm_area_struct 
>> *vma,
>> -          unsigned long addr, pte_t *ptep, unsigned long pfn,
>> -          struct vm_fault *vmf)
>> +          unsigned long addr, pte_t *ptep, unsigned long pfn)
>>   {
>>       struct mm_struct *mm = vma->vm_mm;
>>       struct vm_area_struct *mpnt;
>>       unsigned long offset;
>> +    unsigned long start;
>>       pgoff_t pgoff;
>>       int aliases = 0;
>>       pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
>> +    start = ALIGN_DOWN(addr, PMD_SIZE);
> 
> I assume you can come up with a better name than "start" :)
> 
> aligned_addr ... pmd_start_addr ...
> 
> Maybe simply
> 
> pmd_start_addr = ALIGN_DOWN(addr, PMD_SIZE);
> pmd_end_addr = addr + PMD_SIZE;

you mean:

pmd_end_addr = pmd_start_addr + PMD_SIZE;

Right?

> 
> Then the comparison below also becomes easier to read.
> 
>>       /*
>>        * If we have any shared mappings that are in the same mm
>> @@ -141,6 +141,14 @@ make_coherent(struct address_space *mapping, 
>> struct vm_area_struct *vma,
>>        */
>>       flush_dcache_mmap_lock(mapping);
>>       vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
>> +        unsigned long mpnt_addr;
>> +        /*
>> +         * If we are using split PTE locks, then we need to take the pte
>> +         * lock. Otherwise we are using shared mm->page_table_lock which
>> +         * is already locked, thus cannot take it.
>> +         */
>> +        bool need_lock = IS_ENABLED(CONFIG_SPLIT_PTE_PTLOCKS);
> 
> Nit: move "unsigned long mpnt_addr;" below this longer variable+init.

OK, will do.

> 
>> +
>>           /*
>>            * If this VMA is not in our MM, we can ignore it.
>>            * Note that we intentionally mask out the VMA
>> @@ -151,7 +159,15 @@ make_coherent(struct address_space *mapping, 
>> struct vm_area_struct *vma,
>>           if (!(mpnt->vm_flags & VM_MAYSHARE))
>>               continue;
>>           offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
>> -        aliases += adjust_pte(mpnt, mpnt->vm_start + offset, pfn, vmf);
>> +        mpnt_addr = mpnt->vm_start + offset;
>> +        /*
>> +         * If mpnt_addr and addr are mapped to the same PTE page, there
>> +         * is no need to hold the pte lock again, otherwise a deadlock
>> +         * will occur.
> 
> /*
>   * Avoid deadlocks by not grabbing the PTE lock if we already hold the
>   * PTE lock of this PTE table in the caller.
>   */

Maybe just:

/* Avoid deadlocks by not grabbing the same PTE lock again. */

Thanks,
Qi

> 
> ?
> 
>> +         */
>> +        if (mpnt_addr >= start && mpnt_addr - start < PMD_SIZE)
>> +            need_lock = false;
> 
> 
> 

