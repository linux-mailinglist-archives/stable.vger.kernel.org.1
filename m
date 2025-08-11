Return-Path: <stable+bounces-167014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 192AFB20309
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 11:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9920B3B2B17
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A67F26E6E3;
	Mon, 11 Aug 2025 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyNSvg7i"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6A6335C7;
	Mon, 11 Aug 2025 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903765; cv=none; b=BE/lDfhy4Yw01K/bVIy9nbP+ypxFAsyagQVxR9Fi4t2Jy2rgAwmGjX/gNmYySkYaenL9bgI7nAEbEbg8mAPpIV5JrnrsuRApcwH/qQt4qo9c22qJ1Msy8YU8+NFiWBKhzRtowehFRuxYMbdvsmrIZiHxQDM2x4HAhwXa5kTQKUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903765; c=relaxed/simple;
	bh=JPSAJBEftYZ0F/ryaeFTW1S8tpF0D8X8nemI7lk4Ov0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6zrjFm8Nj8nKh1ZS+MQ/i7DD4NAsecVbKCE2kiKa8UG8u9DVxTQ+s4Kee3RrzYOlZo5iBa3Mnpdqox3R00b21yogr+aQ6zx1hZjoiAsf6Mgz5UkDTxKHCNRGc/3rPqgK3l/L8UiBuhdZfb4N+F+Gu94e4AC7+PF9dVJQKExFZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyNSvg7i; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55b733911b3so4710777e87.2;
        Mon, 11 Aug 2025 02:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754903762; x=1755508562; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZbLfZuJibKMWWd+Di+kV/C8asmfMe0JJbEqm1icB4tM=;
        b=ZyNSvg7iwCwhpNtNpgWmFHhK/Q+irrT+NeeHaSvLuIrmvAcsdU5kJ81jCYPLqnHO6i
         P064o2bpgaL0zCjT+cL2QEPoYInerw0LgZNbieyIobMrrTzBwGk9trR1xLisnaJqC2xC
         kRUWt04fGY2BnbwbmcIod/173Rx5vdClDFAoS7NFfbQ+XYTjJQBlKkmuhSplZJxQtCwc
         JjAK+Wc/zSUCZgWOQdzSBawBg8/wSiDQwvPeMd3OVgGxmR0zRVe/BFP6y2K+PRkiobXb
         0JagodY9mTUEyq5275id6MW7oZnfkA4jWXS3DzK7TGLlBGQdg+5upd2XQwPvE2Qp/rp4
         Iajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754903762; x=1755508562;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbLfZuJibKMWWd+Di+kV/C8asmfMe0JJbEqm1icB4tM=;
        b=TiVx7cmaCZfSNxY4vMA40yveNZkq1Q/+kl1Hdpdf7GAdPG6XbNB3vziPZTLbQ/uT6m
         +JSovzqxZA3c0wRS0wQ5gXZp39c74vjr/ZuUvi7EvlXnnP7Gj4e+cVydUi3aD/aOi757
         KzO6qiAczovu/DXMjmafiPA6dAsSDRIVNUbnfS9dfx0sBResafArx0H02VhTpOTRhw8H
         JmjMXwUoaEOAElly6whSAuDiIC/hFmwgbtiTMqbygl7hcV0ewjmH6Y2xc6LDjfrYyMox
         hdH13871kpHTuqw2irX3ipJbR2kULwyA3LDrlQvyRUvqdIt+AGIiMgnn+WB3rGQVy12p
         ENVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb5VmWwFN8rd0TMZtZsk3Llip25Oghrp4RqbiTpFwoeNTpBLDeJ5CBwgmJW+F5uEFKfPKIIgBa@vger.kernel.org, AJvYcCVRaKA/SB/Os7+Qkkod/aMeMB99niiCWtdhmOX6zLwl1YsOmih/T0YZjK7Q5mq+Y9ZytlmCqnjFcu2BuJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdyGJdc27vhNn/MXJNtISznl1MpHAVSiYDiCMbVFD3ilh06kZ/
	+Eb/KLC8N6Tj70bgakChNigdSy80SCw9m8ELRvwffOsp+BajIaUTXAfj
X-Gm-Gg: ASbGnctnepR7Fgi7pt55+cOcAoLxyGjJJAr6bSIz8/HXu1yd+iEaBkSQWrs075ux+L6
	0JXc/yV4r068xzz2L9ipUUZINYqKdM+KNL7dIeepn9TerJ86J60KxqmT/iYSa8j2ox53n1Al8kl
	b7Y5TyZncuXCjhs4mEyyRm+peTPYDPvZqFoBwjkuszdACVBTZWe9fBSJcAbWGlRZtzm1srBofbZ
	rkZfT8lWOgkVmc2hbeS+e6JUBw3q+ooxuksgeXVkKyXQpHWAC0tgunfkrdUDr0twX3tkb/pcPzC
	FPKlrRLSBuqeBIJ9ECvv1CCOyczmrJZSOVKOLU0GkQT72lAKO2Oyu9UDRQ3Q1g/8XDghuP+zWGm
	djHEcDOcw2wW6YcP4CDOrjIWU1ijXRhxz17QMJwBiEuqv8VCw2Q==
X-Google-Smtp-Source: AGHT+IElIGCLzD5l7Ej9guePvaniyav9FRhNwGtWqAJO0RmsmAmOPJQk/HhgSuRWmtJVFhe0j1KpUQ==
X-Received: by 2002:a05:6512:63d3:20b0:55c:c9d5:d347 with SMTP id 2adb3069b0e04-55cc9d5dc3emr1292257e87.35.1754903761586;
        Mon, 11 Aug 2025 02:16:01 -0700 (PDT)
Received: from pc636 (host-95-203-26-173.mobileonline.telia.com. [95.203.26.173])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898c164sm4118657e87.23.2025.08.11.02.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:16:00 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 11 Aug 2025 11:15:58 +0200
To: Ethan Zhao <etzhao1900@gmail.com>, Baolu Lu <baolu.lu@linux.intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jann Horn <jannh@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	iommu@lists.linux.dev, security@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] iommu/sva: Invalidate KVA range on kernel TLB
 flush
Message-ID: <aJm0znaAqBRWqOCT@pc636>
References: <20250806052505.3113108-1-baolu.lu@linux.intel.com>
 <d646d434-f680-47a3-b6b9-26f4538c1209@intel.com>
 <20250806155223.GV184255@nvidia.com>
 <d02cb97a-7cea-4ad3-82b3-89754c5278ad@intel.com>
 <20250806160904.GX184255@nvidia.com>
 <62d21545-9e75-41e3-89a3-f21dda15bf16@intel.com>
 <4a8df0e8-bd5a-44e4-acce-46ba75594846@linux.intel.com>
 <4ce79c80-1fc8-4684-920a-c8d82c4c3dc8@intel.com>
 <b6defa2a-164e-4c2f-ac55-fef5b4a9ba0f@linux.intel.com>
 <2611981e-3678-4619-b2ab-d9daace5a68a@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2611981e-3678-4619-b2ab-d9daace5a68a@gmail.com>

On Sun, Aug 10, 2025 at 03:19:58PM +0800, Ethan Zhao wrote:
> 
> 
> On 8/8/2025 1:15 PM, Baolu Lu wrote:
> > On 8/7/25 23:31, Dave Hansen wrote:
> > > > +void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> > > > +{
> > > > +    struct page *page = virt_to_page(pte);
> > > > +
> > > > +    guard(spinlock)(&kernel_pte_work.lock);
> > > > +    list_add(&page->lru, &kernel_pte_work.list);
> > > > +    schedule_work(&kernel_pte_work.work);
> > > > +}
> > > > diff --git a/include/asm-generic/pgalloc.h
> > > > b/include/asm-generic/ pgalloc.h
> > > > index 3c8ec3bfea44..716ebab67636 100644
> > > > --- a/include/asm-generic/pgalloc.h
> > > > +++ b/include/asm-generic/pgalloc.h
> > > > @@ -46,6 +46,7 @@ static inline pte_t
> > > > *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
> > > >   #define pte_alloc_one_kernel(...)
> > > > alloc_hooks(pte_alloc_one_kernel_noprof(__VA_ARGS__))
> > > >   #endif
> > > > 
> > > > +#ifndef __HAVE_ARCH_PTE_FREE_KERNEL
> > > >   /**
> > > >    * pte_free_kernel - free PTE-level kernel page table memory
> > > >    * @mm: the mm_struct of the current context
> > > > @@ -55,6 +56,7 @@ static inline void pte_free_kernel(struct mm_struct
> > > > *mm, pte_t *pte)
> > > >   {
> > > >       pagetable_dtor_free(virt_to_ptdesc(pte));
> > > >   }
> > > > +#endif
> > > > 
> > > >   /**
> > > >    * __pte_alloc_one - allocate memory for a PTE-level user page table
> > > I'd much rather the arch-generic code looked like this:
> > > 
> > > #ifdef CONFIG_ASYNC_PGTABLE_FREE
> > > // code and struct here, or dump them over in some
> > > // other file and do this in a header
> > > #else
> > > static void pte_free_kernel_async(struct page *page) {}
> > > #endif
> > > 
> > > void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> > > {
> > >      struct page *page = virt_to_page(pte);
> > > 
> > >      if (IS_DEFINED(CONFIG_ASYNC_PGTABLE_FREE)) {
> > >     pte_free_kernel_async(page);
> > >      else
> > >     pagetable_dtor_free(page_ptdesc(page));
> > > }
> > > 
> > > Then in Kconfig, you end up with something like:
> > > 
> > > config ASYNC_PGTABLE_FREE
> > >     def_bool y
> > >     depends on INTEL_IOMMU_WHATEVER
> > > 
> > > That very much tells much more of the whole story in code. It also gives
> > > the x86 folks that compile out the IOMMU the exact same code as the
> > > arch-generic folks. It_also_ makes it dirt simple and obvious for the
> > > x86 folks to optimize out the async behavior if they don't like it in
> > > the future by replacing the compile-time IOMMU check with a runtime one.
> > > 
> > > Also, if another crazy IOMMU implementation comes along that happens to
> > > do what the x86 IOMMUs do, then they have a single Kconfig switch to
> > > flip. If they follow what this patch tries to do, they'll start by
> > > copying and pasting the x86 implementation.
> > 
> > I'll do it like this.  Does that look good to you?
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 70d29b14d851..6f1113e024fa 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -160,6 +160,7 @@ config IOMMU_DMA
> >   # Shared Virtual Addressing
> >   config IOMMU_SVA
> >       select IOMMU_MM_DATA
> > +    select ASYNC_PGTABLE_FREE if X86
> >       bool
> > 
> >   config IOMMU_IOPF
> > diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> > index 3c8ec3bfea44..dbddacdca2ce 100644
> > --- a/include/asm-generic/pgalloc.h
> > +++ b/include/asm-generic/pgalloc.h
> > @@ -46,6 +46,19 @@ static inline pte_t
> > *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
> >   #define pte_alloc_one_kernel(...)
> > alloc_hooks(pte_alloc_one_kernel_noprof(__VA_ARGS__))
> >   #endif
> > 
> > +#ifdef CONFIG_ASYNC_PGTABLE_FREE
> > +struct pgtable_free_work {
> > +    struct list_head list;
> > +    spinlock_t lock;
> > +    struct work_struct work;
> > +};
> > +extern struct pgtable_free_work kernel_pte_work;
> > +
> > +void pte_free_kernel_async(struct ptdesc *ptdesc);
> > +#else
> > +static inline void pte_free_kernel_async(struct ptdesc *ptdesc) {}
> > +#endif
> > +
> >   /**
> >    * pte_free_kernel - free PTE-level kernel page table memory
> >    * @mm: the mm_struct of the current context
> > @@ -53,7 +66,12 @@ static inline pte_t
> > *pte_alloc_one_kernel_noprof(struct mm_struct *mm)
> >    */
> >   static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> >   {
> > -    pagetable_dtor_free(virt_to_ptdesc(pte));
> > +    struct ptdesc *ptdesc = virt_to_ptdesc(pte);
> > +
> > +    if (IS_ENABLED(CONFIG_ASYNC_PGTABLE_FREE))
> > +        pte_free_kernel_async(ptdesc);
> > +    else
> > +        pagetable_dtor_free(ptdesc);
> >   }
> > 
> >   /**
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index e443fe8cd6cf..528550cfa7fe 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -1346,6 +1346,13 @@ config LOCK_MM_AND_FIND_VMA
> >   config IOMMU_MM_DATA
> >       bool
> > 
> > +config ASYNC_PGTABLE_FREE
> > +    bool "Asynchronous kernel page table freeing"
> > +    help
> > +      Perform kernel page table freeing asynchronously. This is required
> > +      for systems with IOMMU Shared Virtual Address (SVA) to flush IOTLB
> > +      paging structure caches.
> > +
> >   config EXECMEM
> >       bool
> > 
> > diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> > index 567e2d084071..6639ee6641d4 100644
> > --- a/mm/pgtable-generic.c
> > +++ b/mm/pgtable-generic.c
> > @@ -13,6 +13,7 @@
> >   #include <linux/swap.h>
> >   #include <linux/swapops.h>
> >   #include <linux/mm_inline.h>
> > +#include <linux/iommu.h>
> >   #include <asm/pgalloc.h>
> >   #include <asm/tlb.h>
> > 
> > @@ -406,3 +407,32 @@ pte_t *__pte_offset_map_lock(struct mm_struct *mm,
> > pmd_t *pmd,
> >       pte_unmap_unlock(pte, ptl);
> >       goto again;
> >   }
> > +
> > +#ifdef CONFIG_ASYNC_PGTABLE_FREE
> > +static void kernel_pte_work_func(struct work_struct *work);
> > +struct pgtable_free_work kernel_pte_work = {
> > +    .list = LIST_HEAD_INIT(kernel_pte_work.list),
> > +    .lock = __SPIN_LOCK_UNLOCKED(kernel_pte_work.lock),
> > +    .work = __WORK_INITIALIZER(kernel_pte_work.work,
> > kernel_pte_work_func),
> > +};
> > +
> > +static void kernel_pte_work_func(struct work_struct *work)
> > +{
> > +    struct ptdesc *ptdesc, *next;
> > +
> > +    iommu_sva_invalidate_kva_range(0, TLB_FLUSH_ALL);
> > +
> > +    guard(spinlock)(&kernel_pte_work.lock);
> > +    list_for_each_entry_safe(ptdesc, next, &kernel_pte_work.list,
> > pt_list) {
> > +        list_del_init(&ptdesc->pt_list);
> > +        pagetable_dtor_free(ptdesc);
> > +    }
> > +}
> > +
> > +void pte_free_kernel_async(struct ptdesc *ptdesc)
> > +{
> > +    guard(spinlock)(&kernel_pte_work.lock);
> > +    list_add(&ptdesc->pt_list, &kernel_pte_work.list);
> > +    schedule_work(&kernel_pte_work.work);
> > +}
> kernel_pte_work.list is global shared var, it would make the producer
> pte_free_kernel() and the consumer kernel_pte_work_func() to operate in
> serialized timing. In a large system, I don't think you design this
> deliberately :)
>
Sorry for jumping.

Agree, unless it is never considered as a hot path or something that can
be really contented. It looks like you can use just a per-cpu llist to drain
thinks.

As for reference you can have a look at how vfree_atomic() handles deferred
freeing.

Thanks!

--
Uladzislau Rezki

