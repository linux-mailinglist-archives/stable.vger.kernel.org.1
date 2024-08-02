Return-Path: <stable+bounces-65291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5B6945A2B
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 10:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E4B0B227AF
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 08:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451D81C232C;
	Fri,  2 Aug 2024 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UACRYhr9"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5C1BF30C
	for <stable@vger.kernel.org>; Fri,  2 Aug 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588236; cv=none; b=lVrO+7ezznzKDl73R/DFV/JUBoDcgn6sYFlcdVrMC+IxCXA3A3pELzdn5HqPnyhd+IjjxFhvv0m8xtz0RzheA2T9Tux0PK/zjuqDLTYS3ZvTCI231EsBnXhBFijdMhyuyfarHfWW9LGG8AUu+AhaF4H0t+OrwAd/ONQY1ezvVxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588236; c=relaxed/simple;
	bh=z0BCkJ4NTxYvM6aHmq0rZOPxWvurZDIkiCE3MTkXp4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYDWfX9cYmCiY3yqZurdgL7yN9FpJoBtXrIsN54C82XVyvpEErx4hqqUOuDUDCfnA+MmiMKgVXAOkT1FkJvZuvj8GLRngqJpda6ZRMzejgM9aW1/SRiWLOiA9Tueqcqxo/cEXyWT6ORHs5ScWYiJ0uDkxKFxcW31b3uVSoIsotw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UACRYhr9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722588232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r6y1+GLVtzb5hCeleoqTqjVmnFypTb6V7p2s4oCxWJc=;
	b=UACRYhr97PiTvlT6GUMuP968AU3HIq4pdwFsg7csY+XH+FkkMV8PiksnjQ5gzdoWdCWkcf
	LkQB37X/4w8Gth0mX6Mrw3QMhoEgxC6RBl2yMOo3OZelWUeYrz1RuTawJyXjV29NIsxj8G
	cInCyKrLUa4RrJjQ0r4msbC/Hlx/EGc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-ibQTzDd4PUKw-mU8-iE7hQ-1; Fri, 02 Aug 2024 04:43:51 -0400
X-MC-Unique: ibQTzDd4PUKw-mU8-iE7hQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36875698d0dso3836787f8f.3
        for <stable@vger.kernel.org>; Fri, 02 Aug 2024 01:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722588230; x=1723193030;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r6y1+GLVtzb5hCeleoqTqjVmnFypTb6V7p2s4oCxWJc=;
        b=MJZJKRo3RIy7jCyjDvU+tOObQcS+N3ZFO4FESFO4V0Wr5m8etLBALx7K0Prg3G9gqS
         ctwgDGZlG390KLBqcjriiP4xopvrezf3aUDVHpLYjPGFkK/EAYm1Y2BmUMQLWAJh59Xj
         DbT/t4bLh/rqfdJ01EIL7id2A8tbuiKijPWhI4LlVgnkk0iSzkGaxXCUX17WKf01B3PK
         LYmssJR63H/orr6KKraghFXdZMYMV3DV94tWAmYq6pRFntcPZ3ptt3UVYF3pm0k7Rsl+
         BFMBgzCxhRDsqSt3GbK50FYdc0zGkrgzR7zbT1X9mPU+ILsx07ta4QV9kKe4HMofyFfI
         0yOw==
X-Forwarded-Encrypted: i=1; AJvYcCVRNdzhSo7RAtWm3Tr1O8qJ6q17qmMo8UiYqEx7g8ei5SmZQzMsm4UpD59BgekNGkNoaLejqGlePbY6bBKF7i2ywZ/1r7ye
X-Gm-Message-State: AOJu0YwFpHbPujaD05sI/P4f+LrulJmnAxdEFH3st1MOhoyCqGvviWKq
	2OsE1rbSVPR4zn1OmD4sTE1GoE2VFr2RhaozJ+UFOoGIHzNXGo+YgHGr3kfE3OO8kBy19g6C2H6
	L4r6il84ZztzMxzQUpyPw1/DHHsAooKOQnstVCJVzDeqJQ+r2ZyECdg==
X-Received: by 2002:a5d:5101:0:b0:367:9575:2820 with SMTP id ffacd0b85a97d-36bbc14ada2mr1362682f8f.45.1722588229705;
        Fri, 02 Aug 2024 01:43:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi34wunMzP/bVnXyvIX7U9igb8O7SRA55KE5sUw6/TuRWJbqd74s/Zss5QXdTtwij04Er83g==
X-Received: by 2002:a5d:5101:0:b0:367:9575:2820 with SMTP id ffacd0b85a97d-36bbc14ada2mr1362666f8f.45.1722588229175;
        Fri, 02 Aug 2024 01:43:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:e700:a3df:9aa8:9edb:dcac? (p200300cbc717e700a3df9aa89edbdcac.dip0.t-ipconnect.de. [2003:cb:c717:e700:a3df:9aa8:9edb:dcac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd0597a7sm1385941f8f.75.2024.08.02.01.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 01:43:48 -0700 (PDT)
Message-ID: <066fc0d9-748b-445c-b440-607125b481fe@redhat.com>
Date: Fri, 2 Aug 2024 10:43:47 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Peter Xu <peterx@redhat.com>, stable@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Muchun Song <muchun.song@linux.dev>
References: <20240801204748.99107-1-david@redhat.com>
 <0eb66533-445f-45d5-8f68-0281e4ed017d@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0eb66533-445f-45d5-8f68-0281e4ed017d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.08.24 05:56, Baolin Wang wrote:
> 
> 
> On 2024/8/2 04:47, David Hildenbrand wrote:
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
>> Handle CONFIG_PGTABLE_LEVELS correctly by checking in reverse order,
>> such that when e.g., CONFIG_PGTABLE_LEVELS==2 with
>> PGDIR_SIZE==P4D_SIZE==PUD_SIZE==PMD_SIZE will work as expected.
>> Document why that works.
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
>> Acked-by: Peter Xu <peterx@redhat.com>
>> Cc: <stable@vger.kernel.org>
>> Cc: Peter Xu <peterx@redhat.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Muchun Song <muchun.song@linux.dev>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> I tried your reproducer on my ARM64 machine, and this patch can fix the
> problem.
> 
> Although I know nothing about HIGHPTE, the other parts look good to me.
> So feel free to add:
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thanks! Took longer than expected to get this (hopefully ;) ) right.

HIGHPTE means that we allocate PTE page tables from highmem on 32bit
architectures. I think it's only supported on x86 and arm.

If we allocate page tables from highmem, when we want to read/write
them, we have to kmap them into kernel virtual address space. This
is what the whole pte_offset_map_lock() / pte_unmap() does. On
!highmem configs, the "map/unmap" is a NOP.

Hugetlb doesn't use pte_offset_map_lock/pte_unmap() when accessing
page tables and assumes that they are never allocated from highmem.
So there is the implicit assumption that architectures that use
PTE page tables for hugetlb don't use HIGHPTE. For this reason, also
pte_alloc_huge() is guarded by CONFIG_HIGHPTE:

include/linux/hugetlb.h:
"
#ifndef CONFIG_HIGHPTE
/*
  * pte_offset_huge() and pte_alloc_huge() are helpers for those architectures
  * which may go down to the lowest PTE level in their huge_pte_offset() and
  * huge_pte_alloc(): to avoid reliance on pte_offset_map() without pte_unmap().
  */
"
-- 
Cheers,

David / dhildenb


