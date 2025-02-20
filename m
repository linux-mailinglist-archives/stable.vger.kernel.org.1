Return-Path: <stable+bounces-118411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07676A3D678
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 11:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10513188FE2D
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 10:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666B21F0E45;
	Thu, 20 Feb 2025 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYnw/r3r"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111A01EF080
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740047050; cv=none; b=QaZFBPE5fzkcAOBgImty0T7T7GzFzPcgjcDP9nXn6CkwjYhPKq5KiBKdXIz9xZ00VYBakFih9y9nxclGmmRvsspACxCpeti0nKOxL8oRpX4u4odD0hxWpERPA33sxGVJ3jylb54iy3stbWHiay5B/6FQcHYC97ewPSR4QtmePB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740047050; c=relaxed/simple;
	bh=T6C6/yt6mh3mFanDt8kCp8w3RSLW1X0SJGe4BfK/rLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFFtJ4JhjaOUCtYD6IZxyYVbmSS7yP9ZzoQYI3llscfiqrJY589cs6gYcD4t6/8M2+0nWw6/BpsQvG/7uzzDrZre/VyyTTFfFqmGCs6XTYDQsPtG3fgwDxz0fP9+E6qjkQ+do4nKym47rRPfij0H/joKYRMobCXFFhYdwuks2CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYnw/r3r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740047046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mf2cDKQ5L9gU2E8fN/2evuT1C1fjualTRcJKcrTRx4g=;
	b=eYnw/r3ry5OPI0DBJiB46kmFz8nNg6sgDkIT/anJwmQgFd/DTgC+EWQOnR/KUKPSfAigs8
	mIjM/TTbQW3o7USr9k2bLilmqffALc4z0/aCiRQdnxkoQKpI3GDH7EliDiuoZ5qG1XcJxc
	19nhFeeBmko1JEqfMrEWQmlJbYGr7BI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-q-4grncJOJqfkA-gEKoiBQ-1; Thu, 20 Feb 2025 05:24:05 -0500
X-MC-Unique: q-4grncJOJqfkA-gEKoiBQ-1
X-Mimecast-MFC-AGG-ID: q-4grncJOJqfkA-gEKoiBQ_1740047044
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso4973875e9.1
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 02:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740047044; x=1740651844;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mf2cDKQ5L9gU2E8fN/2evuT1C1fjualTRcJKcrTRx4g=;
        b=LA8NpFyMZABqK8iTKfwkYCNGbv/oeHWoln+CIwF7pfwEq6I2GIGIjcBI10BUHAfyLo
         l/D0CkXlhFu7hLsIohoVCst0sQMdOYhYp3q1I3V/mlyZRlsSCRrq9c4ZVFiTjbkzTll5
         fanAH2TTxRDlT92vpch3nL+r8YVnQ3j+MdGSBwV+OetGJJt1oo2AqboJGYaIzTK59/yN
         3WK28oSDMClwBOV9+xaPiF1Srix9dbyHzaUrcx5MFDQ1UVD2+i0d8iXAPXUjHT7WFdKh
         DxD9/ZougqNmY0HFk1B21qgP8JbRGzNeal9QHa1C4FmDmIgCgyx8Ge5jimOvSlwCV8Ja
         4zrg==
X-Forwarded-Encrypted: i=1; AJvYcCXdUjJBujLAAmfgGuLRNcdT1XOIkVeR96YDQOhlv90gF/gDlqnlTpF3putLFARbXj/WaVtX4YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwknudcyQ1KxXC1ZclDIVAAqw4JE6ywaCLbMs/5dE+RTyfR6CuA
	rZBZuXq/uDSBFjqAWRb45XLMNJkYuCjAODxd9CtqkCJuWp/o8WHTBwSCCwLlPRjSlof9rJFfryG
	OeHiycGSKzjz3MuTn1FeuggP84fv4GtX4TYQfSMtI6A6s/Fa/phb9Bg==
X-Gm-Gg: ASbGncs7wtXK2t3fZw1LGXzZ9/rDnnurdAV0W4U+5IP5qJ6lVQGaQRKHf/NjrXIXVwa
	RuYmTqcC7EiOriKkGp/Mq0XubWuewfEKykfelgwp+WL/OK+jTOHW6pml5wiyGeI/767Ex+9KY2k
	JxNYNrGRwk2I5egak46wC6Ti7wPyxDD9O7GMKPFa7rQqoKgjey7ucdIEth247hP0dlZ6P17jEvv
	3iL7eM2IT4UzOHMmOul5ZpNNAXUnlG5Hk9KI4eC2hUnlPwWo5SPmJsp1i+r9nAhNHNtUGS0n+U+
	oWvAvDqNP8ejnR+WrktltyCmkcC8WxCZ5AU7r4tqOCkQxD+79NXxth7yAWOdvtbxJOj7lPnA6mQ
	dmDGEfVqOnDN/BsblOuTATNqvFqNcQA==
X-Received: by 2002:a05:600c:3b8c:b0:439:9ee2:5534 with SMTP id 5b1f17b1804b1-4399ee257f2mr54075485e9.12.1740047044177;
        Thu, 20 Feb 2025 02:24:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHd9rEb7gsSDCdQFRuLZkwh4+ij2UtULFUF81rRtRtD1I3bB5L2syyipAqMmVY57Bued0MhDw==
X-Received: by 2002:a05:600c:3b8c:b0:439:9ee2:5534 with SMTP id 5b1f17b1804b1-4399ee257f2mr54075125e9.12.1740047043745;
        Thu, 20 Feb 2025 02:24:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:2000:e44c:bc46:d8d3:be5? (p200300cbc7062000e44cbc46d8d30be5.dip0.t-ipconnect.de. [2003:cb:c706:2000:e44c:bc46:d8d3:be5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43982bcc607sm117006065e9.16.2025.02.20.02.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 02:24:02 -0800 (PST)
Message-ID: <02f14ee1-923f-47e3-a994-4950afb9afcc@redhat.com>
Date: Thu, 20 Feb 2025 11:24:01 +0100
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250220092101.71966-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.02.25 10:21, Barry Song wrote:
> On Thu, Feb 20, 2025 at 9:40 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 19.02.25 19:58, Suren Baghdasaryan wrote:
>>> On Wed, Feb 19, 2025 at 10:30 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 19.02.25 19:26, Suren Baghdasaryan wrote:
>>>>> On Wed, Feb 19, 2025 at 3:25 AM Barry Song <21cnbao@gmail.com> wrote:
>>>>>>
>>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>>
>>>>>> userfaultfd_move() checks whether the PTE entry is present or a
>>>>>> swap entry.
>>>>>>
>>>>>> - If the PTE entry is present, move_present_pte() handles folio
>>>>>>      migration by setting:
>>>>>>
>>>>>>      src_folio->index = linear_page_index(dst_vma, dst_addr);
>>>>>>
>>>>>> - If the PTE entry is a swap entry, move_swap_pte() simply copies
>>>>>>      the PTE to the new dst_addr.
>>>>>>
>>>>>> This approach is incorrect because even if the PTE is a swap
>>>>>> entry, it can still reference a folio that remains in the swap
>>>>>> cache.
>>>>>>
>>>>>> If do_swap_page() is triggered, it may locate the folio in the
>>>>>> swap cache. However, during add_rmap operations, a kernel panic
>>>>>> can occur due to:
>>>>>>     page_pgoff(folio, page) != linear_page_index(vma, address)
>>>>>
>>>>> Thanks for the report and reproducer!
>>>>>
>>>>>>
>>>>>> $./a.out > /dev/null
>>>>>> [   13.336953] page: refcount:6 mapcount:1 mapping:00000000f43db19c index:0xffffaf150 pfn:0x4667c
>>>>>> [   13.337520] head: order:2 mapcount:1 entire_mapcount:0 nr_pages_mapped:1 pincount:0
>>>>>> [   13.337716] memcg:ffff00000405f000
>>>>>> [   13.337849] anon flags: 0x3fffc0000020459(locked|uptodate|dirty|owner_priv_1|head|swapbacked|node=0|zone=0|lastcpupid=0xffff)
>>>>>> [   13.338630] raw: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
>>>>>> [   13.338831] raw: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
>>>>>> [   13.339031] head: 03fffc0000020459 ffff80008507b538 ffff80008507b538 ffff000006260361
>>>>>> [   13.339204] head: 0000000ffffaf150 0000000000004000 0000000600000000 ffff00000405f000
>>>>>> [   13.339375] head: 03fffc0000000202 fffffdffc0199f01 ffffffff00000000 0000000000000001
>>>>>> [   13.339546] head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
>>>>>> [   13.339736] page dumped because: VM_BUG_ON_PAGE(page_pgoff(folio, page) != linear_page_index(vma, address))
>>>>>> [   13.340190] ------------[ cut here ]------------
>>>>>> [   13.340316] kernel BUG at mm/rmap.c:1380!
>>>>>> [   13.340683] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>>>>>> [   13.340969] Modules linked in:
>>>>>> [   13.341257] CPU: 1 UID: 0 PID: 107 Comm: a.out Not tainted 6.14.0-rc3-gcf42737e247a-dirty #299
>>>>>> [   13.341470] Hardware name: linux,dummy-virt (DT)
>>>>>> [   13.341671] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>>> [   13.341815] pc : __page_check_anon_rmap+0xa0/0xb0
>>>>>> [   13.341920] lr : __page_check_anon_rmap+0xa0/0xb0
>>>>>> [   13.342018] sp : ffff80008752bb20
>>>>>> [   13.342093] x29: ffff80008752bb20 x28: fffffdffc0199f00 x27: 0000000000000001
>>>>>> [   13.342404] x26: 0000000000000000 x25: 0000000000000001 x24: 0000000000000001
>>>>>> [   13.342575] x23: 0000ffffaf0d0000 x22: 0000ffffaf0d0000 x21: fffffdffc0199f00
>>>>>> [   13.342731] x20: fffffdffc0199f00 x19: ffff000006210700 x18: 00000000ffffffff
>>>>>> [   13.342881] x17: 6c203d2120296567 x16: 6170202c6f696c6f x15: 662866666f67705f
>>>>>> [   13.343033] x14: 6567617028454741 x13: 2929737365726464 x12: ffff800083728ab0
>>>>>> [   13.343183] x11: ffff800082996bf8 x10: 0000000000000fd7 x9 : ffff80008011bc40
>>>>>> [   13.343351] x8 : 0000000000017fe8 x7 : 00000000fffff000 x6 : ffff8000829eebf8
>>>>>> [   13.343498] x5 : c0000000fffff000 x4 : 0000000000000000 x3 : 0000000000000000
>>>>>> [   13.343645] x2 : 0000000000000000 x1 : ffff0000062db980 x0 : 000000000000005f
>>>>>> [   13.343876] Call trace:
>>>>>> [   13.344045]  __page_check_anon_rmap+0xa0/0xb0 (P)
>>>>>> [   13.344234]  folio_add_anon_rmap_ptes+0x22c/0x320
>>>>>> [   13.344333]  do_swap_page+0x1060/0x1400
>>>>>> [   13.344417]  __handle_mm_fault+0x61c/0xbc8
>>>>>> [   13.344504]  handle_mm_fault+0xd8/0x2e8
>>>>>> [   13.344586]  do_page_fault+0x20c/0x770
>>>>>> [   13.344673]  do_translation_fault+0xb4/0xf0
>>>>>> [   13.344759]  do_mem_abort+0x48/0xa0
>>>>>> [   13.344842]  el0_da+0x58/0x130
>>>>>> [   13.344914]  el0t_64_sync_handler+0xc4/0x138
>>>>>> [   13.345002]  el0t_64_sync+0x1ac/0x1b0
>>>>>> [   13.345208] Code: aa1503e0 f000f801 910f6021 97ff5779 (d4210000)
>>>>>> [   13.345504] ---[ end trace 0000000000000000 ]---
>>>>>> [   13.345715] note: a.out[107] exited with irqs disabled
>>>>>> [   13.345954] note: a.out[107] exited with preempt_count 2
>>>>>>
>>>>>> Fully fixing it would be quite complex, requiring similar handling
>>>>>> of folios as done in move_present_pte.
>>>>>
>>>>> How complex would that be? Is it a matter of adding
>>>>> folio_maybe_dma_pinned() checks, doing folio_move_anon_rmap() and
>>>>> folio->index = linear_page_index like in move_present_pte() or
>>>>> something more?
>>>>
>>>> If the entry is pte_swp_exclusive(), and the folio is order-0, it cannot
>>>> be pinned and we may be able to move it I think.
>>>>
>>>> So all that's required is to check pte_swp_exclusive() and the folio size.
>>>>
>>>> ... in theory :) Not sure about the swap details.
>>>
>>> Looking some more into it, I think we would have to perform all the
>>> folio and anon_vma locking and pinning that we do for present pages in
>>> move_pages_pte(). If that's correct then maybe treating swapcache
>>> pages like a present page inside move_pages_pte() would be simpler?
>>
>> I'd be more in favor of not doing that. Maybe there are parts we can
>> move out into helper functions instead, so we can reuse them?
> 
> I actually have a v2 ready. Maybe we can discuss if some of the code can be
> extracted as a helper based on the below before I send it formally?
> 
> I’d say there are many parts that can be shared with present PTE, but there
> are two major differences:
> 
> 1. Page exclusivity – swapcache doesn’t require it (try_to_unmap_one has remove
> Exclusive flag;)
> 2. src_anon_vma and its lock – swapcache doesn’t require it（folio is not mapped）
> 

That's a lot of complicated code you have there (not your fault, it's 
complicated stuff ... ) :)

Some of it might be compressed/simplified by the use of "else if".

I'll try to take a closer look later (will have to apply it to see the 
context better). Just one independent comment because I stumbled over 
this recently:

[...]

> @@ -1062,10 +1063,13 @@ static int move_present_pte(struct mm_struct *mm,
>   	folio_move_anon_rmap(src_folio, dst_vma);
>   	src_folio->index = linear_page_index(dst_vma, dst_addr);
>   
> -	orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
> -	/* Follow mremap() behavior and treat the entry dirty after the move */
> -	orig_dst_pte = pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);
> -
> +	if (pte_present(orig_src_pte)) {
> +		orig_dst_pte = mk_pte(&src_folio->page, dst_vma->vm_page_prot);
> +		/* Follow mremap() behavior and treat the entry dirty after the move */
> +		orig_dst_pte = pte_mkwrite(pte_mkdirty(orig_dst_pte), dst_vma);

I'll note that the comment and mkdirty is misleading/wrong. It's 
softdirty that we care about only. But that is something independent of 
this change.

For swp PTEs, we maybe also would want to set softdirty.

See move_soft_dirty_pte() on what is actually done on the mremap path.

-- 
Cheers,

David / dhildenb


