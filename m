Return-Path: <stable+bounces-166950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F1FB1F8C2
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 09:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8E8165B1C
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C19E23371B;
	Sun, 10 Aug 2025 07:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToUhHRaI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D30533D8;
	Sun, 10 Aug 2025 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754810412; cv=none; b=tlYhJKvajrnJduCObZkib+uLrxtUuFageWosH/xlNYDX0cCJ+J60snxb/jFL0+xdVU25vQLQate5pOIzBQhncP2dE2nmQFa3QLg8dxkrn0HGA7H/1IgKb7GcnRnUQUSEQOeP9jq2Lkw37x3vZcPLF01LgPUj6y//h356JbpS/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754810412; c=relaxed/simple;
	bh=COJswfLh+C+wgDlpQkhGJEDr7gSl5xY9ZoHfsp8rhnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKWPf8TnVdaU4r2vouCKRfiEfsSrnu5BUyBsrhrXx8fZp1UcV5toE4H2523DXDJSE1XA4ypl2bCctXbgPXnIEDSkTpT21OyYPZjtB2N8wf4YYieo7HxpKMnghsccNM44bIoqs/GMj1gdavXDlJwUB8UHerGFJLxrAx+xsk52rs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToUhHRaI; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3b78d729bb8so2065605f8f.0;
        Sun, 10 Aug 2025 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754810408; x=1755415208; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=usiKZlBsNPpg98V431afWvqjVaCZGADXKOBURWPD0Fg=;
        b=ToUhHRaIi7g2QGDr7BbkvF0MQ5lCrhTfm+i83qUlJ880cXXZ3DZ4xpU0B6LTNjoKxy
         1ezi9GDoVK6DvcRzpEaaBpAEygbbvfqc3hc4hsC986aj23llm+S2nAjaOOeUOMXIfft3
         cJMh/An5X+mmxi3ekE9kDbpR1tGJqJEcjTrsIg8HEizuwPIiOpwxvnwftlNVl1u1310e
         wmst/j08iATp7fjHKXjp5jX3JuPWIb4q31Mi3eTOKQUj9PNzOyMXg3UmKk9Ztg610Lcb
         2atPhpNcJ/Ee0mSKNpTjWtksPoJlaryeZKbfvNdkHjI8cTjVfalaOO4SQ35iPb/14QQ6
         yl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754810408; x=1755415208;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usiKZlBsNPpg98V431afWvqjVaCZGADXKOBURWPD0Fg=;
        b=w9YpXXoRUePnqp29kLGekTcs4q5eRBhhS7lIw8ADJYNRNJcisRHIfxeEyfxvFhHBD2
         /1cWwoa6ity/Z1j0+OOVfIYwYYTWDcvYeEkvNkjOhN6CTt8s7x23NRjNeUi8oGVmUmWQ
         sGLRQzNEdfD/2NwWMmaeYR3uj8II1CAtBMzIy7+O4y933BWf67ETyDuVNwI6Qz4DLgU/
         qjlDEbrLCUO9/NZI79q5nPyf/1w9CUnumUJgL3u693wxe+0dGit61AscQKTjWrEpkGzp
         LnTsK5i2K8WDvHyEhlKct4kju6yCCVRhi0KI1bHUjUOlAja7MlX078yH/AeryFPxSkDR
         FsWA==
X-Forwarded-Encrypted: i=1; AJvYcCVaCALbYFRmQdlpLVGD7jFbv02VGlsius0hqDQKBI0KCZvP8XlfyHWVzAbKApniACelY0b5ADP03o4LgOI=@vger.kernel.org, AJvYcCXXznTNKZYktFu2t0AtyPwxhwBG5Nl6MCZkcGa0aaDNgQ5+L3KrFUGU0JQ4j/UM6wKnZ/XrSKnc@vger.kernel.org
X-Gm-Message-State: AOJu0YwKaDOeP1wVYVAZRhGEu5/8QfJfaWfKUTRUdQWIJmoRa07ml0Fz
	Dq3QJS7gUVhzXEuwJqETc8e2tixjXyvwRC1eC6T6H1fzIk4qQ1UXetrY
X-Gm-Gg: ASbGncuZdaq5jyvL1b2J4wUK4baH9xVlWrRmeTURB2uhF/BIGqxm2NkdML3fSg77Ffm
	9IB3RHnGuvAf3noaMs8XI8KZ+nvg181m7fRhzlIzYX5l6h6czixIeSTKq/9rh6kYbqjs7qtMg6L
	ldDhiJEjOvY/t9YDXBMQ+n5k2ZQAjXGouDV/ULk0ZKOyl3Hu2+p1WZPZOGXoRNexr0fhk/xBzvH
	yRcWTMO3LYxWcshxYjbAG3dZJKJzSDlfYgo0dt2yh7H9PyySW8pJxIuymVcbZuRgIp0CN70iegr
	rPAX64qFRVX9lsKlINWNamMSHo8ysX6QYnJecjT5eq5xxOVisKdm8+bQt2lRHuWIDo22zI396vP
	vlUoEntWVFlZQxaFodO6NtbtpYJd0Np/ycG/QBhd212bOXp2qA6hX1pKeHJUk4D1YDQsp72WoYf
	SEvzX/Ayqv9rGDNGWiX9ub
X-Google-Smtp-Source: AGHT+IFQNmeW5ocY8AhqhfJKQxl8wqmvU/MCXEjuQJK8w0HHDDuYkoExIyY4hLkvboPUpQkEdj+r6w==
X-Received: by 2002:a05:6000:26c8:b0:3b7:7898:6df5 with SMTP id ffacd0b85a97d-3b900b4da22mr6180905f8f.14.1754810408182;
        Sun, 10 Aug 2025 00:20:08 -0700 (PDT)
Received: from [26.26.26.1] (95.112.207.35.bc.googleusercontent.com. [35.207.112.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f5ca8ab7sm15204757f8f.59.2025.08.10.00.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 00:20:07 -0700 (PDT)
Message-ID: <2611981e-3678-4619-b2ab-d9daace5a68a@gmail.com>
Date: Sun, 10 Aug 2025 15:19:58 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
To: Baolu Lu <baolu.lu@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
 <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/8/2025 1:15 PM, Baolu Lu wrote:
> On 8/7/25 23:31, Dave Hansen wrote:
>>> +void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>>> +{
>>> +    struct page *page = virt_to_page(pte);
>>> +
>>> +    guard(spinlock)(&kernel_pte_work.lock);
>>> +    list_add(&page->lru, &kernel_pte_work.list);
>>> +    schedule_work(&kernel_pte_work.work);
>>> +}
>>> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/ 
>>> pgalloc.h
>>> index 3c8ec3bfea44..716ebab67636 100644
>>> --- a/include/asm-generic/pgalloc.h
>>> +++ b/include/asm-generic/pgalloc.h
>>> @@ -46,6 +46,7 @@ static inline pte_t
>>> *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>>>   #define pte_alloc_one_kernel(...)
>>> alloc_hooks(pte_alloc_one_kernel_noprof(__VA_ARGS__))
>>>   #endif
>>>
>>> +#ifndef __HAVE_ARCH_PTE_FREE_KERNEL
>>>   /**
>>>    * pte_free_kernel - free PTE-level kernel page table memory
>>>    * @mm: the mm_struct of the current context
>>> @@ -55,6 +56,7 @@ static inline void pte_free_kernel(struct mm_struct
>>> *mm, pte_t *pte)
>>>   {
>>>       pagetable_dtor_free(virt_to_ptdesc(pte));
>>>   }
>>> +#endif
>>>
>>>   /**
>>>    * __pte_alloc_one - allocate memory for a PTE-level user page table
>> I'd much rather the arch-generic code looked like this:
>>
>> #ifdef CONFIG_ASYNC_PGTABLE_FREE
>> // code and struct here, or dump them over in some
>> // other file and do this in a header
>> #else
>> static void pte_free_kernel_async(struct page *page) {}
>> #endif
>>
>> void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>> {
>>      struct page *page = virt_to_page(pte);
>>
>>      if (IS_DEFINED(CONFIG_ASYNC_PGTABLE_FREE)) {
>>     pte_free_kernel_async(page);
>>      else
>>     pagetable_dtor_free(page_ptdesc(page));
>> }
>>
>> Then in Kconfig, you end up with something like:
>>
>> config ASYNC_PGTABLE_FREE
>>     def_bool y
>>     depends on INTEL_IOMMU_WHATEVER
>>
>> That very much tells much more of the whole story in code. It also gives
>> the x86 folks that compile out the IOMMU the exact same code as the
>> arch-generic folks. It_also_ makes it dirt simple and obvious for the
>> x86 folks to optimize out the async behavior if they don't like it in
>> the future by replacing the compile-time IOMMU check with a runtime one.
>>
>> Also, if another crazy IOMMU implementation comes along that happens to
>> do what the x86 IOMMUs do, then they have a single Kconfig switch to
>> flip. If they follow what this patch tries to do, they'll start by
>> copying and pasting the x86 implementation.
> 
> I'll do it like this.  Does that look good to you?
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 70d29b14d851..6f1113e024fa 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -160,6 +160,7 @@ config IOMMU_DMA
>   # Shared Virtual Addressing
>   config IOMMU_SVA
>       select IOMMU_MM_DATA
> +    select ASYNC_PGTABLE_FREE if X86
>       bool
> 
>   config IOMMU_IOPF
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 3c8ec3bfea44..dbddacdca2ce 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -46,6 +46,19 @@ static inline pte_t 
> *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>   #define pte_alloc_one_kernel(...) 
> alloc_hooks(pte_alloc_one_kernel_noprof(__VA_ARGS__))
>   #endif
> 
> +#ifdef CONFIG_ASYNC_PGTABLE_FREE
> +struct pgtable_free_work {
> +    struct list_head list;
> +    spinlock_t lock;
> +    struct work_struct work;
> +};
> +extern struct pgtable_free_work kernel_pte_work;
> +
> +void pte_free_kernel_async(struct ptdesc *ptdesc);
> +#else
> +static inline void pte_free_kernel_async(struct ptdesc *ptdesc) {}
> +#endif
> +
>   /**
>    * pte_free_kernel - free PTE-level kernel page table memory
>    * @mm: the mm_struct of the current context
> @@ -53,7 +66,12 @@ static inline pte_t 
> *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
>    */
>   static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>   {
> -    pagetable_dtor_free(virt_to_ptdesc(pte));
> +    struct ptdesc *ptdesc = virt_to_ptdesc(pte);
> +
> +    if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE))
> +        pte_free_kernel_async(ptdesc);
> +    else
> +        pagetable_dtor_free(ptdesc);
>   }
> 
>   /**
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e443fe8cd6cf..528550cfa7fe 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1346,6 +1346,13 @@ config LOCK_MM_AND_FIND_VMA
>   config IOMMU_MM_DATA
>       bool
> 
> +config ASYNC_PGTABLE_FREE
> +    bool "Asynchronous kernel page table freeing"
> +    help
> +      Perform kernel page table freeing asynchronously. This is required
> +      for systems with IOMMU Shared Virtual Address (SVA) to flush IOTLB
> +      paging structure caches.
> +
>   config EXECMEM
>       bool
> 
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index 567e2d084071..6639ee6641d4 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -13,6 +13,7 @@
>   #include <linux/swap.h>
>   #include <linux/swapops.h>
>   #include <linux/mm_inline.h>
> +#include <linux/iommu.h>
>   #include <asm/pgalloc.h>
>   #include <asm/tlb.h>
> 
> @@ -406,3 +407,32 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm, 
> pmd_t *pmd,
>       pte_unmap_unlock(pte, ptl);
>       goto again;
>   }
> +
> +#ifdef CONFIG_ASYNC_PGTABLE_FREE
> +static void kernel_pte_work_func(struct work_struct *work);
> +struct pgtable_free_work kernel_pte_work = {
> +    .list = LIST_HEAD_INIT(kernel_pte_work.list),
> +    .lock = __SPIN_LOCK_UNLOCKED(kernel_pte_work.lock),
> +    .work = __WORK_INITIALIZER(kernel_pte_work.work, 
> kernel_pte_work_func),
> +};
> +
> +static void kernel_pte_work_func(struct work_struct *work)
> +{
> +    struct ptdesc *ptdesc, *next;
> +
> +    iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
> +
> +    guard(spinlock)(&kernel_pte_work.lock);
> +    list_for_each_entry_safe(ptdesc, next, &kernel_pte_work.list, 
> pt_list) {
> +        list_del_init(&ptdesc->pt_list);
> +        pagetable_dtor_free(ptdesc);
> +    }
> +}
> +
> +void pte_free_kernel_async(struct ptdesc *ptdesc)
> +{
> +    guard(spinlock)(&kernel_pte_work.lock);
> +    list_add(&ptdesc->pt_list, &kernel_pte_work.list);
> +    schedule_work(&kernel_pte_work.work);
> +}
kernel_pte_work.list is global shared var, it would make the producer
pte_free_kernel() and the consumer kernel_pte_work_func() to operate in 
serialized timing. In a large system, I don't think you design this 
deliberately :)

Thanks,
Ethan
  > +#endif


