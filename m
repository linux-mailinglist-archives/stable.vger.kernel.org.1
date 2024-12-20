Return-Path: <stable+bounces-105429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A52939F969A
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3B2164CBA
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7617921A931;
	Fri, 20 Dec 2024 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/9VT4wI"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710AD21A450
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712237; cv=none; b=Ba7VQlISoVNLOaBaFFKgTIyf2wbxABxctbyO6NCH96q/rVYhnfeiw4B63HdlkEYmtUh/Yu6Yy6oBH9GqTAmVbzmfM+MrogVjUODuI4aPjGYBXm6vjW1u3h6n51hUPixv2L5mPwrIq8AiCRTFcaYkoaRT7G8F8PGY7bJN3KU9SUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712237; c=relaxed/simple;
	bh=3gbCA1WLPAGfNVUpUoQiw3HwSiJ0CyLSQOZqig2XLgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbJ/6vOv71RkNwtTQ+Yk3ozIwXU6MLFw4Xt/wxPGt4vVnEzsRiVP5Pm0GYDLiq1NVhS0bJJ/P8q2RGfDVxBIfu1PArcg4Ap7kDSJer/dBtD0Xxl/fg+QoNCLcRO3mhK6enQIDSB9G8+sOPiTX2gHaCFwnvGwn5Xd/j55NaOpRW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/9VT4wI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734712234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/iWn0Ce3tJncXqJxpZDoZJspbC1CR6Ur+Lnwih/c65o=;
	b=d/9VT4wIaiDdCKpm2dBVSD+WQf42rX/+WF/E51iyTOade2z+282UplCn45Nouh+NN91o+C
	8S+BvDAM3B4M7x8Vddh652PyCgTzDWx2cGamhhu1YQ7E1EWO2yqt4Qf1gzSY9NbyKNEfxN
	zNuJoVw8KXWP6UYhwaYLQkySm+0MaAQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-J5kR51JNPVCGbLXlkn2ktQ-1; Fri, 20 Dec 2024 11:30:28 -0500
X-MC-Unique: J5kR51JNPVCGbLXlkn2ktQ-1
X-Mimecast-MFC-AGG-ID: J5kR51JNPVCGbLXlkn2ktQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38a2140a400so885206f8f.0
        for <stable@vger.kernel.org>; Fri, 20 Dec 2024 08:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734712227; x=1735317027;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/iWn0Ce3tJncXqJxpZDoZJspbC1CR6Ur+Lnwih/c65o=;
        b=rXO+g0x54kp7MrpejS0f+cAJlSBBAvsKWww7seW6hrwQOpKYMwXv1ExXKiyGMH+02j
         VIeoiCp8GGh9hJnPM1vdfg5cbWXqaq0kLWWGldA1nDai0YTQw3IBu0Is4++BGRnyg69h
         wN03RuQfYeVszu3Unq6+Eqhoqvk0gLujH22CDLF4ZOR/0xM4dB0b4zdgtRxERBcJM+Jv
         UAtnTd4AoZYhRWhzbAr5J8HAkeqUzAcLssmCV8KBYNwZU5A038Wld3uXflTQ1rPJ8RXN
         tdtmsHevRFSp2EiWJM8d2IeSSmJbV/RrG/90FjO5JLay4YMQ18MSDfqepXFfQNbMSuj6
         f1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWOXz02SSOwvGcFxYQzsvFNjnxKh/LX1RgZt5MPtiy9nreMS/Cj3b9H4u2z0POelwZ5Vn0rG+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkRc7Tk++vLkWNDL7mThZF9CP3mG5u9gWXGTz+5ZD4jRGpYCYw
	x4PvP2e2poAq8LLtfjXdHgb1/2mqXlV0FsM2Ey20J+g5iXvUsy712t5M/lQm4AAQcHpbBxYUzPX
	LXvT+GcUzcSuwb2VUlO7IuPjtqT872aQ1Li4f6F54k0K4jWsR/djL9uRLPvKA9XIs
X-Gm-Gg: ASbGnculvdW0AfBhEYKtkZRtYkfaE9yEaX64SErkXeoT3U9e4DeBk7VnzCiMppdVtIM
	cZ8Q9SshzNK3XBJn9Xatg8z3yugiz0qvq0yGuwOwbdF4KBmTZKkVzba+q2cQctouh9Fg0ROmI9H
	khS5lp8V6FYkBrPJ3XeF7mHfT512yBcb+zTGN8Itw4FO8Sh7FvEujUGBxWz3QUu/eNMKQmItdgC
	6W1ojHx05nPXDjFEFgdRrJ4rDvcFx5qrbxX1+ulo5P/dQVs8m9KYfX/hlTdcy0hXiEwUo4Co5//
	YoWZz/YKS/FZ816A9/XyGtjDDELzEKXNZ16zIqlh1un5iMiCEQloMEHGEq/+ltBLFXa2l5havwu
	qf1Ml1Q0N
X-Received: by 2002:a05:6000:4b10:b0:385:f470:c2c6 with SMTP id ffacd0b85a97d-38a221e21a9mr3688462f8f.11.1734712227542;
        Fri, 20 Dec 2024 08:30:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhviMmp8oDzO2Vta4bKn4D5S3CRPFiVnXNDNvJbrNTZ/ExTBrmwBLoZcRLAHjKTrK+tbTEEA==
X-Received: by 2002:a05:6000:4b10:b0:385:f470:c2c6 with SMTP id ffacd0b85a97d-38a221e21a9mr3688437f8f.11.1734712227128;
        Fri, 20 Dec 2024 08:30:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:9d00:edd9:835b:4bfb:2ce3? (p200300cbc7089d00edd9835b4bfb2ce3.dip0.t-ipconnect.de. [2003:cb:c708:9d00:edd9:835b:4bfb:2ce3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c833155sm4364949f8f.24.2024.12.20.08.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 08:30:25 -0800 (PST)
Message-ID: <fe57ef80-bbdb-44dc-97d9-b390778430a4@redhat.com>
Date: Fri, 20 Dec 2024 17:30:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replace free hugepage folios after migration
To: Ge Yang <yangge1116@126.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 liuzixing@hygon.cn, Oscar Salvador <osalvador@suse.de>,
 Michal Hocko <mhocko@kernel.org>
References: <1734503588-16254-1-git-send-email-yangge1116@126.com>
 <0b41cc6b-5c93-408f-801f-edd9793cb979@redhat.com>
 <1241b567-88b6-462c-9088-8f72a45788b7@126.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1241b567-88b6-462c-9088-8f72a45788b7@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.12.24 09:56, Ge Yang wrote:
> 
> 
> 在 2024/12/20 0:40, David Hildenbrand 写道:
>> On 18.12.24 07:33, yangge1116@126.com wrote:
>>> From: yangge <yangge1116@126.com>
>>
>> CCing Oscar, who worked on migrating these pages during memory offlining
>> and alloc_contig_range().
>>
>>>
>>> My machine has 4 NUMA nodes, each equipped with 32GB of memory. I
>>> have configured each NUMA node with 16GB of CMA and 16GB of in-use
>>> hugetlb pages. The allocation of contiguous memory via the
>>> cma_alloc() function can fail probabilistically.
>>>
>>> The cma_alloc() function may fail if it sees an in-use hugetlb page
>>> within the allocation range, even if that page has already been
>>> migrated. When in-use hugetlb pages are migrated, they may simply
>>> be released back into the free hugepage pool instead of being
>>> returned to the buddy system. This can cause the
>>> test_pages_isolated() function check to fail, ultimately leading
>>> to the failure of the cma_alloc() function:
>>> cma_alloc()
>>>       __alloc_contig_migrate_range() // migrate in-use hugepage
>>>       test_pages_isolated()
>>>           __test_page_isolated_in_pageblock()
>>>                PageBuddy(page) // check if the page is in buddy
>>
>> I thought this would be working as expected, at least we tested it with
>> alloc_contig_range / virtio-mem a while ago.
>>
>> On the memory_offlining path, we migrate hugetlb folios, but also
>> dissolve any remaining free folios even if it means that we will going
>> below the requested number of hugetlb pages in our pool.
>>
>> During alloc_contig_range(), we only migrate them, to then free them up
>> after migration.
>>
>> Under which circumstances doe sit apply that "they may simply be
>> released back into the free hugepage pool instead of being returned to
>> the buddy system"?
>>
> 
> After migration, in-use hugetlb pages are only released back to the
> hugetlb pool and are not returned to the buddy system.

We had

commit ae37c7ff79f1f030e28ec76c46ee032f8fd07607
Author: Oscar Salvador <osalvador@suse.de>
Date:   Tue May 4 18:35:29 2021 -0700

     mm: make alloc_contig_range handle in-use hugetlb pages
     
     alloc_contig_range() will fail if it finds a HugeTLB page within the
     range, without a chance to handle them.  Since HugeTLB pages can be
     migrated as any LRU or Movable page, it does not make sense to bail out
     without trying.  Enable the interface to recognize in-use HugeTLB pages so
     we can migrate them, and have much better chances to succeed the call.


And I am trying to figure out if it never worked correctly, or if
something changed that broke it.


In start_isolate_page_range()->isolate_migratepages_block(), we do the

	ret = isolate_or_dissolve_huge_page(page, &cc->migratepages);

to add these folios to the cc->migratepages list.

In __alloc_contig_migrate_range(), we migrate the pages using migrate_pages().


After that, the src hugetlb folios should still be isolated? But I'm getting
confused when these pages get un-silated and putback to hugetlb/freed.


> 
> The specific steps for reproduction are as follows:
> 1，Reserve hugetlb pages. Some of these hugetlb pages are allocated
> within the CMA area.
> echo 10240 > /proc/sys/vm/nr_hugepages
> 
> 2，To ensure that hugetlb pages are in an in-use state, we can use the
> following command.
> qemu-system-x86_64 \
>     -mem-prealloc \
>     -mem-path /dev/hugepage/ \
>     ...
> 
> 3，At this point, using cma_alloc() to allocate contiguous memory may
> result in a probable failure.
>

Will these free hugetlb folios become surplus pages? I would have assumed
they get freed immediately to the buddy, or does you config maybe allow for
surplus pages?

-- 
Cheers,

David / dhildenb


