Return-Path: <stable+bounces-115022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCAAA3211D
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F9B18826E0
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 08:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ECC1FECDF;
	Wed, 12 Feb 2025 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2eToQi0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD11FAC56
	for <stable@vger.kernel.org>; Wed, 12 Feb 2025 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739349028; cv=none; b=A69HQwJSK7AlCxf+R/a3Zb+tF2sX9x1jY4dF8wfwCnUXPg1gSG+r8MyNevv9HCxmXERSaWk00mCAQ2O7NVBJxgaX+MMEy9ubd65nxKzErACyN26GO3rs2Y/4cQnb1RIcr3uVuQLn6PGxzkh4TppVxZwlRhNIo7L17AkMOYlgS10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739349028; c=relaxed/simple;
	bh=LyRFRGzMpxHUa1ARDr2U2B+Ce2olVmz7Y6F0OYPoZN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpZ5nL4yKTo1TJdeFrRGUA2t0EJbxz62Fj6ICI4zYAoN9xsyejcN0n4FPcmicjQkfpZ5QZEuonAQ2I7CQLIiV6mObI2IH61MIWRqUvweCf1R73bXuj6l8CWOeevbIWoD4X1TFKBxu8aWYLnkX4CFafSE/DxiRBs7ANX+EXwgrHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2eToQi0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739349025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HySIueFNNrdqyZ9t5cvOG6oajgzigJ0xtnthc9wXE54=;
	b=R2eToQi0OXelWC2o48hMFt1Leh8QXURzI3C8ySftdgGfeBeysoXslx9BCUwlEgGWazM30O
	pIR+EYAf5xoZLAQOXVAMQZ2g8gBELu0IWwLdjd8t18jTlOPdufOyybZZ33qFbcqZjTiadZ
	vGs2hEMuRLshAFeNLjt00Xn0tuA3ciQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-0ywE_70jP4iTT6W-M9fDlg-1; Wed, 12 Feb 2025 03:30:24 -0500
X-MC-Unique: 0ywE_70jP4iTT6W-M9fDlg-1
X-Mimecast-MFC-AGG-ID: 0ywE_70jP4iTT6W-M9fDlg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38de11a0002so602120f8f.3
        for <stable@vger.kernel.org>; Wed, 12 Feb 2025 00:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739349023; x=1739953823;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HySIueFNNrdqyZ9t5cvOG6oajgzigJ0xtnthc9wXE54=;
        b=MlpnwPPTe45AkTesmFmdH8pQkEi4iLPbwUEp+8O6pRitR1xPSJVgusmUn1fon3/qqs
         mksuot0UUoIQ087uQuJ4pWtvfxKb2SEU4sqXhV/Um2bF3YamvR+U4eKR2uZUMfw1CAUx
         68TPuQsYfODonpJSP3Myb7OZgz/5b2yIaeBUsaWvC239MMJVuElkA9Dx9WpcEDOHbh3A
         9z7pJp781xlGkJzx+drw5D2sNBqpxl753LUhQGE1waP2pTGyrCMGzTtpiDMNgOXTx4tt
         iTz2yGPItINRp+YyL1N02+RWl+PNDXThDNaYSFnnPISTd5w0mwmdFYULf15D9ro0M0hY
         4Bgg==
X-Forwarded-Encrypted: i=1; AJvYcCXSiD4yeZv+TYRq9GJh87AAZ3nyetgjbT8jVxMjkdcKxn0AG+cNkp5POhLV7UcKi4lufVt+GpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhfzsaLPpB7pVitFy68x8oQyO1OLFu09T6k50VFcuRdBVVQKev
	9c9HVszyrBal6LfLG9wHlscWL3m6psFY9m9CvZraqETzG/CM7Nm4eR6K3QxcVdU4SmxetBYreEv
	E+av3aqoDZ1PiIgo2M3iwz1MR3wKB3Yj9Q76JulJ3byRe9QtG+KDlFQ==
X-Gm-Gg: ASbGncuQvJG6MQxHqAjsl0tAFf7fsWyWmybmvZVENT8u3wjmWMEv/uRb7pRzxPKJDmY
	gFGNPqyO0Li5c4XuPLtlJXhZZsxjt5N4j3BcuFDOQIfdUFZ1XUYiPytEuuwzRY8EzhmZwhKLgMT
	CtFmc/Fjgae4ylbEKlvgvgkQAtsK0NMrH7e5F6o8Iy+mh+0jIbvT6kqQZfMemPvRQPejna8lx9Y
	qzVO7YDAQsWBQXspDK90vcCjIqYknI2jFAXHQ+T5eHR2/3ESpYK3vHtwTPAxH24rWvZxpjQY4cl
	p+MrK6i+79+vIAOmZfT07DeylK8J/koDKRGjFs+wwwLtMXF5h2zjLpgxPcTTwXEY2v9l5Gf7VZb
	vgwkj1bpmzuADTdSNeZ/cys1ZCg0pLw==
X-Received: by 2002:a5d:6107:0:b0:38d:d3e2:db40 with SMTP id ffacd0b85a97d-38dea271527mr1246844f8f.17.1739349022851;
        Wed, 12 Feb 2025 00:30:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXM4Spi0sx5c4IGLUIHF8A1qqqZcsJbmawcndR3hb6ZbF2T223kr192mn2XjxsoZmlUj/XcA==
X-Received: by 2002:a5d:6107:0:b0:38d:d3e2:db40 with SMTP id ffacd0b85a97d-38dea271527mr1246814f8f.17.1739349022370;
        Wed, 12 Feb 2025 00:30:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:a600:1e3e:c75:d269:867a? (p200300cbc70ca6001e3e0c75d269867a.dip0.t-ipconnect.de. [2003:cb:c70c:a600:1e3e:c75:d269:867a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f2084ebdesm244867f8f.70.2025.02.12.00.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 00:30:21 -0800 (PST)
Message-ID: <1399ea09-b53c-4eba-a023-34b8906c9bdd@redhat.com>
Date: Wed, 12 Feb 2025 09:30:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: pgtable: fix NULL pointer dereference issue
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux@armlinux.org.uk, ezra@easyb.ch, hughd@google.com,
 ryan.roberts@arm.com, akpm@linux-foundation.org, muchun.song@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <be323425-2465-423a-a6f4-affbaa1efe09@bytedance.com>
 <20250212064002.55598-1-zhengqi.arch@bytedance.com>
 <d5bba68b-1dba-4367-8d4f-103348b80229@redhat.com>
 <54c30b02-c19e-4e51-8faf-7d6c5560ef6f@bytedance.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <54c30b02-c19e-4e51-8faf-7d6c5560ef6f@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.02.25 09:28, Qi Zheng wrote:
> 
> 
> On 2025/2/12 16:20, David Hildenbrand wrote:
>> On 12.02.25 07:40, Qi Zheng wrote:
>>> When update_mmu_cache_range() is called by update_mmu_cache(), the vmf
>>> parameter is NULL, which will cause a NULL pointer dereference issue in
>>> adjust_pte():
>>>
>>> Unable to handle kernel NULL pointer dereference at virtual address
>>> 00000030 when read
>>> Hardware name: Atmel AT91SAM9
>>> PC is at update_mmu_cache_range+0x1e0/0x278
>>> LR is at pte_offset_map_rw_nolock+0x18/0x2c
>>> Call trace:
>>>    update_mmu_cache_range from remove_migration_pte+0x29c/0x2ec
>>>    remove_migration_pte from rmap_walk_file+0xcc/0x130
>>>    rmap_walk_file from remove_migration_ptes+0x90/0xa4
>>>    remove_migration_ptes from migrate_pages_batch+0x6d4/0x858
>>>    migrate_pages_batch from migrate_pages+0x188/0x488
>>>    migrate_pages from compact_zone+0x56c/0x954
>>>    compact_zone from compact_node+0x90/0xf0
>>>    compact_node from kcompactd+0x1d4/0x204
>>>    kcompactd from kthread+0x120/0x12c
>>>    kthread from ret_from_fork+0x14/0x38
>>> Exception stack(0xc0d8bfb0 to 0xc0d8bff8)
>>>
>>> To fix it, do not rely on whether 'ptl' is equal to decide whether to
>>> hold
>>> the pte lock, but decide it by whether CONFIG_SPLIT_PTE_PTLOCKS is
>>> enabled. In addition, if two vmas map to the same PTE page, there is no
>>> need to hold the pte lock again, otherwise a deadlock will occur. Just
>>> add
>>> the need_lock parameter to let adjust_pte() know this information.
>>>
>>> Reported-by: Ezra Buehler <ezra@easyb.ch>
>>> Closes:
>>> https://lore.kernel.org/lkml/CAM1KZSmZ2T_riHvay+7cKEFxoPgeVpHkVFTzVVEQ1BO0cLkHEQ@mail.gmail.com/
>>> Fixes: fc9c45b71f43 ("arm: adjust_pte() use pte_offset_map_rw_nolock()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>>    arch/arm/mm/fault-armv.c | 40 ++++++++++++++++++++++++++++------------
>>>    1 file changed, 28 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
>>> index 2bec87c3327d2..3627bf0957c75 100644
>>> --- a/arch/arm/mm/fault-armv.c
>>> +++ b/arch/arm/mm/fault-armv.c
>>> @@ -62,7 +62,7 @@ static int do_adjust_pte(struct vm_area_struct *vma,
>>> unsigned long address,
>>>    }
>>>    static int adjust_pte(struct vm_area_struct *vma, unsigned long
>>> address,
>>> -              unsigned long pfn, struct vm_fault *vmf)
>>> +              unsigned long pfn, bool need_lock)
>>>    {
>>>        spinlock_t *ptl;
>>>        pgd_t *pgd;
>>> @@ -99,12 +99,11 @@ static int adjust_pte(struct vm_area_struct *vma,
>>> unsigned long address,
>>>        if (!pte)
>>>            return 0;
>>> -    /*
>>> -     * If we are using split PTE locks, then we need to take the page
>>> -     * lock here.  Otherwise we are using shared mm->page_table_lock
>>> -     * which is already locked, thus cannot take it.
>>> -     */
>>> -    if (ptl != vmf->ptl) {
>>> +    if (need_lock) {
>>> +        /*
>>> +         * Use nested version here to indicate that we are already
>>> +         * holding one similar spinlock.
>>> +         */
>>>            spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
>>>            if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
>>>                pte_unmap_unlock(pte, ptl);
>>> @@ -114,7 +113,7 @@ static int adjust_pte(struct vm_area_struct *vma,
>>> unsigned long address,
>>>        ret = do_adjust_pte(vma, address, pfn, pte);
>>> -    if (ptl != vmf->ptl)
>>> +    if (need_lock)
>>>            spin_unlock(ptl);
>>>        pte_unmap(pte);
>>> @@ -123,16 +122,17 @@ static int adjust_pte(struct vm_area_struct
>>> *vma, unsigned long address,
>>>    static void
>>>    make_coherent(struct address_space *mapping, struct vm_area_struct
>>> *vma,
>>> -          unsigned long addr, pte_t *ptep, unsigned long pfn,
>>> -          struct vm_fault *vmf)
>>> +          unsigned long addr, pte_t *ptep, unsigned long pfn)
>>>    {
>>>        struct mm_struct *mm = vma->vm_mm;
>>>        struct vm_area_struct *mpnt;
>>>        unsigned long offset;
>>> +    unsigned long start;
>>>        pgoff_t pgoff;
>>>        int aliases = 0;
>>>        pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
>>> +    start = ALIGN_DOWN(addr, PMD_SIZE);
>>
>> I assume you can come up with a better name than "start" :)
>>
>> aligned_addr ... pmd_start_addr ...
>>
>> Maybe simply
>>
>> pmd_start_addr = ALIGN_DOWN(addr, PMD_SIZE);
>> pmd_end_addr = addr + PMD_SIZE;
> 
> you mean:
> 
> pmd_end_addr = pmd_start_addr + PMD_SIZE;
> 
> Right?

Yes :)

>>
>>> +
>>>            /*
>>>             * If this VMA is not in our MM, we can ignore it.
>>>             * Note that we intentionally mask out the VMA
>>> @@ -151,7 +159,15 @@ make_coherent(struct address_space *mapping,
>>> struct vm_area_struct *vma,
>>>            if (!(mpnt->vm_flags & VM_MAYSHARE))
>>>                continue;
>>>            offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
>>> -        aliases += adjust_pte(mpnt, mpnt->vm_start + offset, pfn, vmf);
>>> +        mpnt_addr = mpnt->vm_start + offset;
>>> +        /*
>>> +         * If mpnt_addr and addr are mapped to the same PTE page, there
>>> +         * is no need to hold the pte lock again, otherwise a deadlock
>>> +         * will occur.
>>
>> /*
>>    * Avoid deadlocks by not grabbing the PTE lock if we already hold the
>>    * PTE lock of this PTE table in the caller.
>>    */
> 
> Maybe just:
> 
> /* Avoid deadlocks by not grabbing the same PTE lock again. */
> 

Agreed.

-- 
Cheers,

David / dhildenb


