Return-Path: <stable+bounces-56362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D3F92428F
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7CB282C02
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E1F1BC07E;
	Tue,  2 Jul 2024 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpE4uKKO"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB741BBBF7
	for <stable@vger.kernel.org>; Tue,  2 Jul 2024 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934706; cv=none; b=R051nuB8plFeGiJjCT+NKC6ad6skHRyR3oqy6lgTboEaSAgQBr6XwRLYH6A7hwpxWHC0GgpBBVHMVLIO2VNSeq9EHoTHT7c0VCwAUP9waRka/quCiWf6DMVCUDqj0c+9f1HgDIQ+QvneMY+rf/+2BseLDqAh8/NT4efDzLU4cmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934706; c=relaxed/simple;
	bh=SIsFCrQ/9NTgHBaGGLLFdWsoNHUzgWqjgWYroA8qSyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7anHgY8ACkmNed+3hMckUIAXui4FF+HSMhT2NpfgBcR/aJq1UfLUIRdI7GXOsJ9w8CUCDrhHeKzMRGqQAwQzvBfZX/P3U0n0I02de5P7l4bAx0ZguPG35PWhlHBts+BB5wansTUYY07PzXPXjiMhYGculLBl5g1E48UlzxxRy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpE4uKKO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719934704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iAzfxFyO9LwltD4YxV4jTJpadHiZLqH04rmYDKvnDWc=;
	b=YpE4uKKOXMgSrAx+P9oHmNOGqa8sQvhVHItR7gsnAtMIIXY5Hxpj5HopCbnbIWLfvnbmRD
	8pV2rdiBVSJHMMjlXVnPY227jz82sIvAB5UiwpiJ2gmgikevNG2w+Y9eU1ocIG+2oHbbLS
	7mnZRJ8m6Qitwa9s28F55K+9SiU/oU8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-sRG4jIzmPa23fXedlBqlJg-1; Tue, 02 Jul 2024 11:38:22 -0400
X-MC-Unique: sRG4jIzmPa23fXedlBqlJg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ec507c1b59so52332871fa.3
        for <stable@vger.kernel.org>; Tue, 02 Jul 2024 08:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719934700; x=1720539500;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAzfxFyO9LwltD4YxV4jTJpadHiZLqH04rmYDKvnDWc=;
        b=iKNYTCM7SfUEt2NpJStTAdqVLjZ7Vh+wLwhgAlGbqwW6WLifdGWf/1CEzxYSqtCZN8
         sSz2o9aCszmQxq2l4z+Kh1YEpfOHeDpsaJWRJObsVH9BZjpP72wimgWsHoKx0+QmqLZG
         SGMjU+xOl471w+0eP+QYAobevJvVJbrwT9HM3qWb3yVNiSXxxGaBoRsO+eUvWuaHAAgP
         x+18OL5VMMZ1rK4jCoxMCPpKEhDxQpAUKsAloBuiCK4ZqgY3slz7QeAwvhI7NsBUsShs
         IeIa09sSOrb8fv1vDYsU18j5+88jl1SMYt0RlHZt6OwnupieaFhBf5+CasteXrfdfZNl
         4pXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0NqabBNfR9iseTqKIwzlpdf8fRELrOjPAjlnfvta9jvyUGcuiGQK8qeMZ7EmqZO8sdlZytXz9bnY7rq7lXHLyY+BuZwXq
X-Gm-Message-State: AOJu0YypXONJvueTeb5SN0h5mS92/pyYN3mMkPJ8JR8EAV8SRko+Aiai
	Pgoel2rYZgMErJuwKT8nW19GIZgJlVUCbONcWMJX5iIwTsONVI1dLPG2ASSWE5QWSs1OzSPc7Iv
	rcjQgJ1X6idsc963a9WZp6YPhyCSXeUnCoJblN/6q2Spih00Jzdd3qg==
X-Received: by 2002:a2e:ab0b:0:b0:2ec:5945:62e9 with SMTP id 38308e7fff4ca-2ee5e6f60ccmr91090611fa.32.1719934699727;
        Tue, 02 Jul 2024 08:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8FsOViU0tLBkJ4MYGisQkin3IcHk046lhGDLNQonBPeFO9Vc5cI43qiofMRBy/LRH6fNcow==
X-Received: by 2002:a2e:ab0b:0:b0:2ec:5945:62e9 with SMTP id 38308e7fff4ca-2ee5e6f60ccmr91090361fa.32.1719934699285;
        Tue, 02 Jul 2024 08:38:19 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c6364.dip0.t-ipconnect.de. [91.12.99.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c19eesm208322605e9.45.2024.07.02.08.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:38:18 -0700 (PDT)
Message-ID: <686d3f32-45b0-4dd5-8954-e75748b9c946@redhat.com>
Date: Tue, 2 Jul 2024 17:38:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: Fix khugepaged activation policy
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lance Yang <ioworker0@gmail.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240702144617.2291480-1-ryan.roberts@arm.com>
 <c877a136-4294-4f00-b0ac-7194fe170452@redhat.com>
 <ed5042af-b12f-4a36-a2e7-9d8983141099@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ed5042af-b12f-4a36-a2e7-9d8983141099@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.07.24 17:29, Ryan Roberts wrote:
> On 02/07/2024 15:57, David Hildenbrand wrote:
>> On 02.07.24 16:46, Ryan Roberts wrote:
>>> Since the introduction of mTHP, the docuementation has stated that
>>> khugepaged would be enabled when any mTHP size is enabled, and disabled
>>> when all mTHP sizes are disabled. There are 2 problems with this; 1.
>>> this is not what was implemented by the code and 2. this is not the
>>> desirable behavior.
>>>
>>> Desirable behavior is for khugepaged to be enabled when any PMD-sized
>>> THP is enabled, anon or file. (Note that file THP is still controlled by
>>> the top-level control so we must always consider that, as well as the
>>> PMD-size mTHP control for anon). khugepaged only supports collapsing to
>>> PMD-sized THP so there is no value in enabling it when PMD-sized THP is
>>> disabled. So let's change the code and documentation to reflect this
>>> policy.
>>>
>>> Further, per-size enabled control modification events were not
>>> previously forwarded to khugepaged to give it an opportunity to start or
>>> stop. Consequently the following was resulting in khugepaged eroneously
>>> not being activated:
>>>
>>>     echo never > /sys/kernel/mm/transparent_hugepage/enabled
>>>     echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
>>> Closes:
>>> https://lore.kernel.org/linux-mm/7a0bbe69-1e3d-4263-b206-da007791a5c4@redhat.com/
>>> Cc: stable@vger.kernel.org
>>> ---
>>>
>>> Hi All,
>>>
>>> Applies on top of today's mm-unstable (9bb8753acdd8). No regressions observed in
>>> mm selftests.
>>>
>>> When fixing this I also noticed that khugepaged doesn't get (and never has been)
>>> activated/deactivated by `shmem_enabled=`. I'm not sure if khugepaged knows how
>>> to collapse shmem - perhaps it should be activated in this case?
>>>
>>
>> Call me confused.
>>
>> khugepaged_scan_mm_slot() and madvise_collapse() only all
>> hpage_collapse_scan_file() with ... IS_ENABLED(CONFIG_SHMEM) ?
> 
> Looks like khugepaged_scan_mm_slot() was converted from:
> 
>    if (shmem_file(vma->vm_file)) {
> 
> to:
> 
>    if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
> 
> By 99cb0dbd47a15d395bf3faa78dc122bc5efe3fc0 which adds THP collapse support for
> non-shmem files. Clearly that looks wrong, but I guess never spotted in practice
> because noone disables shemem?
> 
> I guess madvise_collapse() was a copy/paste?
> 

Likely.

>>
>> collapse_file() is only called by hpage_collapse_scan_file() ... and there we
>> check "shmem_file(file)".
>>
>> So why is the IS_ENABLED(CONFIG_SHMEM) check in there if collapse_file() seems
>> to "collapse filemap/tmpfs/shmem pages into huge one".
>>
>> Anyhow, we certainly can collapse shmem (that's how it all started IIUC).
> 
> Yes, thanks for pointing me at it. Should have just searched "shmem" in
> khugepaged.c :-/
> 
>>
>> Besides that, khugepaged only seems to collapse !shmem with
>>    VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
> 
> That makes sense. I guess I could use IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) to
> tighen the (non-shmem) file THP check in hugepage_pmd_enabled() (currently I'm
> unconditionally using the top-level enabled setting as a "is THP enabled for
> files" check).
> 
> But back to my original question, I think hugepage_pmd_enabled() should also be
> explicitly checking the appropriate shmem_enabled controls and ORing in the
> result? Otherwise in a situation where only shmem is THP enabled (and file/anon
> THP is disabled) khugepaged won't run.

I think so.

> 
>>
>> The thp_vma_allowable_order() check tests if we are allowed to collapse a
>> PMD_ORDER in that VMA.
> 
> I don't follow the relevance of this statement.

On whatever VMA we indicate true, we will try to collapse in khugepaged. 
Regarding the question, what khugepaged will try to collapse.

-- 
Cheers,

David / dhildenb


