Return-Path: <stable+bounces-119628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F44AA45798
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 09:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC12A3AC25A
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 08:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CBF1624EA;
	Wed, 26 Feb 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdRhHWk6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7329258CCE
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557035; cv=none; b=uPcv7uK11tqdJmiJgcZ96QvDgPhJD6lIxNgK87RsOkRcqER2gaggL4pEpbBU3s3c3nDHFNzpvMAxrtzeGvPwGBvV2JKOU/Sq8xWNI9wRew+YlZx1EUVqR1NfanAJqQRNBYcTClNb0zrEvmXJHADDjQYuuoiGau5OCrsqxq6BOvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557035; c=relaxed/simple;
	bh=78+WCmRL7UMSP+oVH4i/6nMEeU6eHldUKR2GXrO5Sog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWBOslrGcXAXRrlFNCfoyV2w5yrSgIL+2UWO3J7hvkcHxpEwBa0IXPJDq7vN7xr2nFvPTW53HhsdFvuLWnv/UBNidEWJVOJxio8M9Goi04TKqr8JGiogWbPBk/hGPuXIWDLoCt2QdgnmAv1cJSccOlefaKV1PyflSypFWRJV1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdRhHWk6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740557032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eCeegNS89oMyILXTVZ4CfuWaGztpBT6czwwAMe+Smog=;
	b=cdRhHWk6wR6sKs7rLDGRHw9dS0uNtbaCzc8FwkhjJsbA2T4eAzZ+OaNQj8Y3q2HOOXhlm7
	c8ZG5aSv83PeON30Qbo0n+lAQdbu+yuRL1XDwEDf01tGff64L4fFyK44p5GBJsPLLqu4mc
	T+h1E5+ZrdxBmWjuD2f0Xldj7U5+PaU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-dBcLbMm_MPGfWh-S_7aWRA-1; Wed, 26 Feb 2025 03:03:49 -0500
X-MC-Unique: dBcLbMm_MPGfWh-S_7aWRA-1
X-Mimecast-MFC-AGG-ID: dBcLbMm_MPGfWh-S_7aWRA_1740557029
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f29b4d4adso2602830f8f.3
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 00:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740557029; x=1741161829;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eCeegNS89oMyILXTVZ4CfuWaGztpBT6czwwAMe+Smog=;
        b=Ud3dM1bEY1ybpVrPQzBVDOhH9mWIQxgJk96qD1JTLAPr0h+GB542NPFI/KkJ8WA5Cb
         S5kb8MNjpAmtZpiAVP2pIDmUHb9zpR7rqE+mh8eS/umbXoV2XyFlP8Iaru5QYjEuymF9
         ps9JZ706QEoi6IwRQSRQac6HCRDDj4xhoMJwP1puDKQn7ouT0gXNLJl52c2WFlIrU9lc
         plR5C1uXSKkJajKop59N72uovczlhdzsAU/JFfR2upPVj62+wGmu/4M9AoMI5eszR7G1
         tP4lm+2fIY8RezLMCnl30C5R8+Wmo5bOSgPJZJ9VbkqesWCM58GQhIJ/581mAR2G+/kp
         mYNA==
X-Forwarded-Encrypted: i=1; AJvYcCVyS5bnYaBqMAfw1HHj8X6fYeRii9mOV50IFUxEpR8ns0YzyvJIH4/Sk3LUJwuZ+1DFYO6YXqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YweGqPLtN0RAVzu8CciOLAtAaBMIcJt+sB2SASQdOXN9Vl2NT4n
	mMQPA9U8l7gPvHFSJlMAbh3k9EmG9ja0cgNtv4fwaUoErmueVwLxt82Pa7e4jLPlR6Sp4ctJF6j
	S803sEcoBoqyswZCrGqHNoXUSfFrGj85CJKAgdY4SsuJQ7FLAic6nPg==
X-Gm-Gg: ASbGncucMCZJezTBlo1kRa4Fyi3I0yH14jub9NnE/s3cUriuJbJmjd9sIossmEVm5Rv
	7k4hT5vOX3PrKfDIyGUbGG769cWI80SW6D7KFMXeAc1eo0gArhLOW3xb5EkZFzelvHOR/DHYGb4
	t/d3kr8N42AZojLkvRWtsJFF9sN1ublIFxkcnDwJWH2uknoVG78ulA3p+SC76MF/EL4yzBUlmR6
	Pk16uw5j+DHNeVIlIMWACz6NwFa3c5EUHVrUjNU4wK9TmzRRqNSQ89ZwB25XYFu1xYr5qugpc1i
	PxYBYoZK/+n0FJBIKU6kt98umvdXaO+gRiqfrTEfjksrSZDSEvOyPmWv7UUyzIHOELRLo7mut9j
	E8gs1VpJ83BsLBNy2fyPO95iy4YDgb/7qTaC6zaJGoCU=
X-Received: by 2002:a5d:64af:0:b0:38f:452f:9f89 with SMTP id ffacd0b85a97d-38f6f0ae2c4mr18339728f8f.50.1740557027644;
        Wed, 26 Feb 2025 00:03:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5vemCEa/wTNwtzPZWWIIza8R5syJjrH2yQ7G1UnFqSz7C/o8ol21ZsOJr6ebPGLI2MFa0TQ==
X-Received: by 2002:a5d:64af:0:b0:38f:452f:9f89 with SMTP id ffacd0b85a97d-38f6f0ae2c4mr18339664f8f.50.1740557027106;
        Wed, 26 Feb 2025 00:03:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c747:ff00:9d85:4afb:a7df:6c45? (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5396desm12089565e9.20.2025.02.26.00.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 00:03:46 -0800 (PST)
Message-ID: <129e6d6e-5b1d-4761-b5f4-b4448daf33bc@redhat.com>
Date: Wed, 26 Feb 2025 09:03:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: Fix kernel BUG when userfaultfd_move encounters
 swapcache
To: Barry Song <21cnbao@gmail.com>
Cc: Liam.Howlett@oracle.com, aarcange@redhat.com, akpm@linux-foundation.org,
 axelrasmussen@google.com, bgeffon@google.com, brauner@kernel.org,
 hughd@google.com, jannh@google.com, kaleshsingh@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lokeshgidra@google.com,
 mhocko@suse.com, ngeoffray@google.com, peterx@redhat.com, rppt@kernel.org,
 ryan.roberts@arm.com, shuah@kernel.org, surenb@google.com,
 v-songbaohua@oppo.com, viro@zeniv.linux.org.uk, willy@infradead.org,
 zhangpeng362@huawei.com, zhengtangquan@oppo.com, yuzhao@google.com,
 stable@vger.kernel.org
References: <69dbca2b-cf67-4fd8-ba22-7e6211b3e7c4@redhat.com>
 <20250220092101.71966-1-21cnbao@gmail.com>
 <02f14ee1-923f-47e3-a994-4950afb9afcc@redhat.com>
 <CAGsJ_4yzOXE1KS7J927QSjPRUEyCdgs4VKH7fi_7kQ72a5XtUA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4yzOXE1KS7J927QSjPRUEyCdgs4VKH7fi_7kQ72a5XtUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.02.25 06:37, Barry Song wrote:
> On Thu, Feb 20, 2025 at 11:24 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 20.02.25 10:21, Barry Song wrote:
>>> On Thu, Feb 20, 2025 at 9:40 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 19.02.25 19:58, Suren Baghdasaryan wrote:
>>>>> On Wed, Feb 19, 2025 at 10:30 AM David Hildenbrand <david@redhat.com> wrote:
>>>>>>
>>>>>> On 19.02.25 19:26, Suren Baghdasaryan wrote:
>>>>>>> On Wed, Feb 19, 2025 at 3:25 AM Barry Song <21cnbao@gmail.com> wrote:
>>>>>>>>
>>>>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>>>>
>>>>>>>> userfaultfd_move() checks whether the PTE entry is present or a
>>>>>>>> swap entry.
>>>>>>>>
>>>>>>>> - If the PTE entry is present, move_present_pte() handles folio
>>>>>>>>       migration by setting:
>>>>>>>>
>>>>>>>>       src_folio->index = linear_page_index(dst_vma, dst_addr);
>>>>>>>>
>>>>>>>> - If the PTE entry is a swap entry, move_swap_pte() simply copies
>>>>>>>>       the PTE to the new dst_addr.
>>>>>>>>
>>>>>>>> This approach is incorrect because even if the PTE is a swap
>>>>>>>> entry, it can still reference a folio that remains in the swap
>>>>>>>> cache.
>>>>>>>>
>>>>>>>> If do_swap_page() is triggered, it may locate the folio in the
>>>>>>>> swap cache. However, during add_rmap operations, a kernel panic
>>>>>>>> can occur due to:
>>>>>>>>      page_pgoff(folio, page) != linear_page_index(vma, address)
>>>>>>>
>>>>>>> Thanks for the report and reproducer!
>>>>>>>
>>>>>>>>
>>>>>>>> $./a.out > /dev/null
>>>>>>>> [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c index:0xffffaf150 pfn:0x4667c
>>>>>>>> [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapped:1 pincount:0
>>>>>>>> [   13.337716] memcg:ffff00000405f000
>>>>>>>> [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owner_priv_1|head|swapbacked|node=0|zone=0|lastcpupid=0xffff)
>>>>>>>> [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
>>>>>>>> [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
>>>>>>>> [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
>>>>>>>> [   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
>>>>>>>> [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000 0000000000000001
>>>>>>>> [   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
>>>>>>>> [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, page) != linear_page_index(vma, address))
>>>>>>>> [   13.340190] ------------[ cut here ]------------
>>>>>>>> [   13.340316] kernel BUG at mm/rmap.c:1380!
>>>>>>>> [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>>>>>>>> [   13.340969] Modules linked in:
>>>>>>>> [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc3-gcf42737e247a-dirty #299
>>>>>>>> [   13.341470] Hardware name: linux,dummy-virt (DT)
>>>>>>>> [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>>>>> [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
>>>>>>>> [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
>>>>>>>> [   13.342018] sp : ffff80008752bb20
>>>>>>>> [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0000000000000001
>>>>>>>> [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000000000001
>>>>>>>> [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdffc0199f00
>>>>>>>> [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000000ffffffff
>>>>>>>> [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662866666f67705f
>>>>>>>> [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff800083728ab0
>>>>>>>> [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff80008011bc40
>>>>>>>> [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8000829eebf8
>>>>>>>> [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0000000000000000
>>>>>>>> [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000000000000005f
>>>>>>>> [   13.343876] Call trace:
>>>>>>>> [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
>>>>>>>> [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
>>>>>>>> [   13.344333]  do_swap_page+0x1060/0x1400
>>>>>>>> [   13.344417]  __handle_mm_fault+0x61c/0xbc8
>>>>>>>> [   13.344504]  handle_mm_fault+0xd8/0x2e8
>>>>>>>> [   13.344586]  do_page_fault+0x20c/0x770
>>>>>>>> [   13.344673]  do_translation_fault+0xb4/0xf0
>>>>>>>> [   13.344759]  do_mem_abort+0x48/0xa0
>>>>>>>> [   13.344842]  el0_da+0x58/0x130
>>>>>>>> [   13.344914]  el0t_64_sync_handler+0xc4/0x138
>>>>>>>> [   13.345002]  el0t_64_sync+0x1ac/0x1b0
>>>>>>>> [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
>>>>>>>> [   13.345504] ---[ end trace 0000000000000000 ]---
>>>>>>>> [   13.345715] note: a.out[107] exited with irqs disabled
>>>>>>>> [   13.345954] note: a.out[107] exited with preempt_count 2
>>>>>>>>
>>>>>>>> Fully fixing it would be quite complex, requiring similar handling
>>>>>>>> of folios as done in move_present_pte.
>>>>>>>
>>>>>>> How complex would that be? Is it a matter of adding
>>>>>>> folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
>>>>>>> folio->index = linear_page_index like in move_present_pte() or
>>>>>>> something more?
>>>>>>
>>>>>> If the entry is pte_swp_exclusive(), and the folio is order-0, it cannot
>>>>>> be pinned and we may be able to move it I think.
>>>>>>
>>>>>> So all that's required is to check pte_swp_exclusive() and the folio size.
>>>>>>
>>>>>> ... in theory :) Not sure about the swap details.
>>>>>
>>>>> Looking some more into it, I think we would have to perform all the
>>>>> folio and anon_vma locking and pinning that we do for present pages in
>>>>> move_pages_pte(). If that's correct then maybe treating swapcache
>>>>> pages like a present page inside move_pages_pte() would be simpler?
>>>>
>>>> I'd be more in favor of not doing that. Maybe there are parts we can
>>>> move out into helper functions instead, so we can reuse them?
>>>
>>> I actually have a v2 ready. Maybe we can discuss if some of the code can be
>>> extracted as a helper based on the below before I send it formally?
>>>
>>> I’d say there are many parts that can be shared with present PTE, but there
>>> are two major differences:
>>>
>>> 1. Page exclusivity – swapcache doesn’t require it (try_to_unmap_one has remove
>>> Exclusive flag;)
>>> 2. src_anon_vma and its lock – swapcache doesn’t require it（folio is not mapped）
>>>
>>
>> That's a lot of complicated code you have there (not your fault, it's
>> complicated stuff ... ) :)
>>
>> Some of it might be compressed/simplified by the use of "else if".
>>
>> I'll try to take a closer look later (will have to apply it to see the
>> context better). Just one independent comment because I stumbled over
>> this recently:
>>
>> [...]
>>
>>> @@ -1062,10 +1063,13 @@ static int move_present_pte(struct mm_struct *mm,
>>>        folio_move_anon_rmap(src_folio, dst_vma);
>>>        src_folio->index = linear_page_index(dst_vma, dst_addr);
>>>
>>> -     orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
>>> -     /* Follow mremap() behavior and treat the entry dirty after the move */
>>> -     orig_dst_pte = pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
>>> -
>>> +     if (pte_present(orig_src_pte)) {
>>> +             orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
>>> +             /* Follow mremap() behavior and treat the entry dirty after the move */
>>> +             orig_dst_pte = pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
>>
>> I'll note that the comment and mkdirty is misleading/wrong. It's
>> softdirty that we care about only. But that is something independent of
>> this change.
>>
>> For swp PTEs, we maybe also would want to set softdirty.
>>
>> See move_soft_dirty_pte() on what is actually done on the mremap path.
> 
> I actually don't quite understand the changelog in  commit 0f8975ec4db2
> (" mm: soft-dirty bits for user memory changes tracking").
> 
> "    Another thing to note, is that when mremap moves PTEs they are marked
>      with soft-dirty as well, since from the user perspective mremap modifies
>      the virtual memory at mremap's new address."
> 
> Why is the hardware-dirty bit not relevant? From the user's perspective,
> the memory at the destination virtual address of mremap/userfaultfd_move
> has changed.

Yes, but it did not change from the system POV. For example, if the page 
was R/O clean and we moved it, why should it suddenly be R/O dirty and 
e.g., require writeback again.

Nobody modified *page content*, but from a user perspective the memory 
at that *virtual memory location* (dst) changed, for example, for 
logical zero (no page mapped) to non-zero (page mapped). That's what 
soft-dirty is about.


> 
> For systems where CONFIG_HAVE_ARCH_SOFT_DIRTY is false, how can the dirty status
> be determined?

No soft-dirty tracking, so nothing to maintain.

> 
> Or is the answer that we only care about soft-dirty changes?
 > > For the hardware-dirty bit, do we only care about actual 
modifications to the
> physical page content rather than changes at the virtual address level?

Exactly!

-- 
Cheers,

David / dhildenb


