Return-Path: <stable+bounces-64790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 265DB943430
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 18:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09D8284AA2
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 16:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5065B1BC066;
	Wed, 31 Jul 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTdrA9mk"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4364717C77
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722443642; cv=none; b=H7DRgZDC5SXXORz3maaEReS1BZJMpNxlgrQ0Y0B6Cp5iI3vIoZV/ShdSo6AUJKJt/EYtZjVhY3uVW3AeYOIrzi9C5a1aOXPQp/9Hey7gFGs7n3oAr+cEaYA7btHUZW/Ljt5Ta41pEKhJ+eneHOi4qknvC5MDRj/aX9yjggUNBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722443642; c=relaxed/simple;
	bh=tZSgy1oh7CLyEaHX/JX2UT8Rn/p9ywF6HP2+MJ6Xnw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFyvx0Tu0v6mS4wfCR1P44gBrgxlFo6NDxFV3ijxtVwI9GSyde+7DvXSumpvBeWzVLf96x2aO6PtO9pxmB9aeumE3SvejCffGXDp/MyYgZnHRynApow5t9eQ/EJU6xczyBQYNCXRql/v02stckJVHZbtyNBpS4Fr+mO+Lv+W0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTdrA9mk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722443638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b6vAN3LgYm9qWDFzsaOW2AFCcfYE6122Dy5W7zWUuSE=;
	b=VTdrA9mk8hXQFiOg8FS9VZnyn2xdOQGKXlp9OINN+BDx84Yw7WPycIkaIGqLsd/m8zXHGq
	TsEkz3rwBK5yAJAlU/t6C7ScgwIMntTeretyJkobTujZlTBqX+7cUjZxhUDOTKWoGa9JsP
	6kvN0/nZs3Tc91r6pfx/gxckxFEsk/U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-P1PwpRdtNayBBP55WMrX6A-1; Wed, 31 Jul 2024 12:33:56 -0400
X-MC-Unique: P1PwpRdtNayBBP55WMrX6A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-368665a3fdfso2939567f8f.1
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 09:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722443635; x=1723048435;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b6vAN3LgYm9qWDFzsaOW2AFCcfYE6122Dy5W7zWUuSE=;
        b=QkgvMaJ+7EEYybLzexEwE0mA8Xxs5+eJMmgD9Cz1zPBy0TavV67u0hfVO81MJVUOQt
         VQEf5TEP2tfEK0auL8HaHhTgV1bcYpvccgLl2/x437TIL0i9IgwIdImBrYccihoEyMog
         4b0LDoE3tzT4SqbALIf7hXzbbw2xhUiXS6cjBVhnbgmibPxtWGKV17iFExdSdI6OkhEf
         /BGyt/De5cMNfMSq1QCMkt/SKvyRRgnHI/k4XJZaqJ3J7Ba2MlSvr7UmGIju9mxvB7fG
         KxLe2mSMXULvvHwa+eEGPgU8jvWxnd2kDgruuORQnAuvz7KB0IOEFCprrsRCaJox59kH
         NSNw==
X-Forwarded-Encrypted: i=1; AJvYcCVT5O//H1S386GOTYYVJu94HQU1Y0k9+EmS9Mg/AhQIW89wyohs416Wvl6peWZGm5edNqw2rjwNizlaMbxo02ZR3phj4iQB
X-Gm-Message-State: AOJu0YyHLhp2PF99Jy6kVeQJPPgoSUWQ3InE6wfhsqwbBJln7QEJrjNB
	t4a+gXs9tpEVGzVrnelMGVKJ+kmywCrtZgqppswQScdjbe0uOB6tOqkluM8Y5FFB9R+nNMcPSwv
	XvAPP2vSDhSHW+VTn2RqCeOAC6RcwXitN2Yz2dC7+BDVkALp8qo13tg==
X-Received: by 2002:adf:fa06:0:b0:368:4bc0:9210 with SMTP id ffacd0b85a97d-36b5d0237a8mr9171857f8f.25.1722443635267;
        Wed, 31 Jul 2024 09:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNimitYzcBdriOzVFG5XNa3xpUSnTVXi0BGsjluk7ESowqwbbgCj0xG4elvQHCmKEKRYaQIg==
X-Received: by 2002:adf:fa06:0:b0:368:4bc0:9210 with SMTP id ffacd0b85a97d-36b5d0237a8mr9171830f8f.25.1722443634648;
        Wed, 31 Jul 2024 09:33:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:5f00:9b61:28a2:eea1:fa49? (p200300cbc70b5f009b6128a2eea1fa49.dip0.t-ipconnect.de. [2003:cb:c70b:5f00:9b61:28a2:eea1:fa49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8adc7dsm26951425e9.14.2024.07.31.09.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:33:54 -0700 (PDT)
Message-ID: <2b0131cf-d066-44ba-96d9-a611448cbaf9@redhat.com>
Date: Wed, 31 Jul 2024 18:33:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 James Houghton <jthoughton@google.com>, stable@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Muchun Song <muchun.song@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20240731122103.382509-1-david@redhat.com> <ZqpQILQ7A_7qTvtq@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZqpQILQ7A_7qTvtq@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.07.24 16:54, Peter Xu wrote:
> On Wed, Jul 31, 2024 at 02:21:03PM +0200, David Hildenbrand wrote:
>> We recently made GUP's common page table walking code to also walk hugetlb
>> VMAs without most hugetlb special-casing, preparing for the future of
>> having less hugetlb-specific page table walking code in the codebase.
>> Turns out that we missed one page table locking detail: page table locking
>> for hugetlb folios that are not mapped using a single PMD/PUD.
>>
>> Assume we have hugetlb folio that spans multiple PTEs (e.g., 64 KiB
>> hugetlb folios on arm64 with 4 KiB base page size). GUP, as it walks the
>> page tables, will perform a pte_offset_map_lock() to grab the PTE table
>> lock.
>>
>> However, hugetlb that concurrently modifies these page tables would
>> actually grab the mm->page_table_lock: with USE_SPLIT_PTE_PTLOCKS, the
>> locks would differ. Something similar can happen right now with hugetlb
>> folios that span multiple PMDs when USE_SPLIT_PMD_PTLOCKS.
>>
>> This issue can be reproduced [1], for example triggering:
>>
>> [ 3105.936100] ------------[ cut here ]------------
>> [ 3105.939323] WARNING: CPU: 31 PID: 2732 at mm/gup.c:142 try_grab_folio+0x11c/0x188
>> [ 3105.944634] Modules linked in: [...]
>> [ 3105.974841] CPU: 31 PID: 2732 Comm: reproducer Not tainted 6.10.0-64.eln141.aarch64 #1
>> [ 3105.980406] Hardware name: QEMU KVM Virtual Machine, BIOS edk2-20240524-4.fc40 05/24/2024
>> [ 3105.986185] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [ 3105.991108] pc : try_grab_folio+0x11c/0x188
>> [ 3105.994013] lr : follow_page_pte+0xd8/0x430
>> [ 3105.996986] sp : ffff80008eafb8f0
>> [ 3105.999346] x29: ffff80008eafb900 x28: ffffffe8d481f380 x27: 00f80001207cff43
>> [ 3106.004414] x26: 0000000000000001 x25: 0000000000000000 x24: ffff80008eafba48
>> [ 3106.009520] x23: 0000ffff9372f000 x22: ffff7a54459e2000 x21: ffff7a546c1aa978
>> [ 3106.014529] x20: ffffffe8d481f3c0 x19: 0000000000610041 x18: 0000000000000001
>> [ 3106.019506] x17: 0000000000000001 x16: ffffffffffffffff x15: 0000000000000000
>> [ 3106.024494] x14: ffffb85477fdfe08 x13: 0000ffff9372ffff x12: 0000000000000000
>> [ 3106.029469] x11: 1fffef4a88a96be1 x10: ffff7a54454b5f0c x9 : ffffb854771b12f0
>> [ 3106.034324] x8 : 0008000000000000 x7 : ffff7a546c1aa980 x6 : 0008000000000080
>> [ 3106.038902] x5 : 00000000001207cf x4 : 0000ffff9372f000 x3 : ffffffe8d481f000
>> [ 3106.043420] x2 : 0000000000610041 x1 : 0000000000000001 x0 : 0000000000000000
>> [ 3106.047957] Call trace:
>> [ 3106.049522]  try_grab_folio+0x11c/0x188
>> [ 3106.051996]  follow_pmd_mask.constprop.0.isra.0+0x150/0x2e0
>> [ 3106.055527]  follow_page_mask+0x1a0/0x2b8
>> [ 3106.058118]  __get_user_pages+0xf0/0x348
>> [ 3106.060647]  faultin_page_range+0xb0/0x360
>> [ 3106.063651]  do_madvise+0x340/0x598
>>
>> Let's make huge_pte_lockptr() effectively use the same PT locks as any
>> core-mm page table walker would. Add ptep_lockptr() to obtain the PTE
>> page table lock using a pte pointer -- unfortunately we cannot convert
>> pte_lockptr() because virt_to_page() doesn't work with kmap'ed page
>> tables we can have with CONFIG_HIGHPTE.
>>
>> Take care of PTE tables possibly spanning multiple pages, and take care of
>> CONFIG_PGTABLE_LEVELS complexity when e.g., PMD_SIZE == PUD_SIZE. For
>> example, with CONFIG_PGTABLE_LEVELS == 2, core-mm would detect
>> with hugepagesize==PMD_SIZE pmd_leaf() and use the pmd_lockptr(), which
>> would end up just mapping to the per-MM PT lock.
>>
>> There is one ugly case: powerpc 8xx, whereby we have an 8 MiB hugetlb
>> folio being mapped using two PTE page tables.  While hugetlb wants to take
>> the PMD table lock, core-mm would grab the PTE table lock of one of both
>> PTE page tables.  In such corner cases, we have to make sure that both
>> locks match, which is (fortunately!) currently guaranteed for 8xx as it
>> does not support SMP and consequently doesn't use split PT locks.
>>
>> [1] https://lore.kernel.org/all/1bbfcc7f-f222-45a5-ac44-c5a1381c596d@redhat.com/
>>
>> Fixes: 9cb28da54643 ("mm/gup: handle hugetlb in the generic follow_page_mask code")
>> Reviewed-by: James Houghton <jthoughton@google.com>
>> Cc: <stable@vger.kernel.org>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Muchun Song <muchun.song@linux.dev>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Nitpick: I wonder whether some of the lines can be simplified if we write
> it downwards from PUD, like,
> 
> huge_pte_lockptr()
> {
>          if (size >= PUD_SIZE)
>             return pud_lockptr(...);
>          if (size >= PMD_SIZE)
>             return pmd_lockptr(...);
>          /* Sub-PMD only applies to !CONFIG_HIGHPTE, see pte_alloc_huge() */
>          WARN_ON(IS_ENABLED(CONFIG_HIGHPTE));
>          return ptep_lockptr(...);
> }

Let me think about it. For PUD_SIZE == PMD_SIZE instead of like core-mm
calling pmd_lockptr we'd call pud_lockptr().

Likely it would work because we default in most cases to the per-MM lock:

arch/x86/Kconfig:       select ARCH_ENABLE_SPLIT_PMD_PTLOCK if (PGTABLE_LEVELS > 2) && (X86_64 || X86_PAE)



> 
> The ">=" checks should avoid checking over pgtable level, iiuc.
> 
> The other nitpick is, I didn't yet find any arch that use non-zero order
> page for pte pgtables.  I would give it a shot with dropping the mask thing
> then see what explodes (which I don't expect any, per my read..), but yeah
> I understand we saw some already due to other things, so I think it's fine
> in this hugetlb path (that we're removing) we do a few more math if you
> think that's easier for you.

I threw
	BUILD_BUG_ON(PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
into pte_lockptr() and did a bunch of cross-compiles.

And for some reason it blows up for powernv (powernv_defconfig) and
pseries (pseries_defconfig).


In function 'pte_lockptr',
     inlined from 'pte_offset_map_nolock' at mm/pgtable-generic.c:316:11:
././include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_291' declared with attribute error: BUILD_BUG_ON failed: PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE
   510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
       |                                             ^
././include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
   491 |                         prefix ## suffix();                             \
       |                         ^~~~~~
././include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
   510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
       |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
       |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
    50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
       |         ^~~~~~~~~~~~~~~~
./include/linux/mm.h:2926:9: note: in expansion of macro 'BUILD_BUG_ON'
  2926 |         BUILD_BUG_ON(PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
       |         ^~~~~~~~~~~~
In function 'pte_lockptr',
     inlined from '__pte_offset_map_lock' at mm/pgtable-generic.c:374:8:
././include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_291' declared with attribute error: BUILD_BUG_ON failed: PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE
   510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
       |                                             ^
././include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
   491 |                         prefix ## suffix();                             \
       |                         ^~~~~~
././include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
   510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
       |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
       |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
    50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
       |         ^~~~~~~~~~~~~~~~
./include/linux/mm.h:2926:9: note: in expansion of macro 'BUILD_BUG_ON'
  2926 |         BUILD_BUG_ON(PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
       |         ^~~~~~~~~~~~


pte_alloc_one() ends up calling pte_fragment_alloc(mm, 0). But there we always
end up calling pagetable_alloc(, 0).

And fragments are supposed to be <= a single page.

Now I'm confused what's wrong here ... am I missing something obvious?

CCing some powerpc folks. Is this some pte_t oddity?

But in mm_inc_nr_ptes/mm_dec_nr_ptes we use the exact same calculation :/

-- 
Cheers,

David / dhildenb


