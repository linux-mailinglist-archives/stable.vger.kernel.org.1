Return-Path: <stable+bounces-186203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D405ABE5442
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C53B545BA4
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 19:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA50A2DC798;
	Thu, 16 Oct 2025 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlPCNJEy"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E932DC77C
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760643906; cv=none; b=K/L/uK2CiEEub+oj4jWZJ1PwbqtS87N8oNL1Eb6ay/7mbRNb5HoLDfmIJz4pgR/ealQAzYy+X3ycfv96M+vBmzmJHT8mtGWLY+2lemsyfLFAQU0gjHwHzNqJY5IE0vidfGK+OGmtNGrs7tiqAo0t3pPwsdta8myxVjPf6oz/H6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760643906; c=relaxed/simple;
	bh=osBjfGeNjpJ9/RBRJZly9EpO2J5jBussZghjXnhs6MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXxxmAs+9oSFbDont9xE/ILS4+zdVadcS5BIYcn5zE07l0QJXBSw/j4YDpG1b0CvYECUpxwvX/4W/YJPYpvPgiYnaI88WAlh4R7M4NO+ACyOVbxYQevNtrX6T2aSNqX/79fW0ujDbcV4FH1mcYmwh4YyMHS8F9TrDM8Ea52FlN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GlPCNJEy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760643903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ksp8408IsxwecTmUGjzpuXH4WucsZWUXVX7U4eYiGcs=;
	b=GlPCNJEySTFxeu1oPRxOAGx3GHwb8YJnOczCBiIxvuPNFeaQaiebmB0oWX2qegMSe3O62p
	mziei8vG2tZ5qoPJtv1oZWipQXPl9KK0PLcRg+NBnJAaYxrf6gfb1QH1t3PiaLO4hxPVTm
	yUVru8LdxKNIRYJmYBNHP3aBJvrL2kw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-ItpeUEh8PquA8FPxE4Kmew-1; Thu, 16 Oct 2025 15:45:02 -0400
X-MC-Unique: ItpeUEh8PquA8FPxE4Kmew-1
X-Mimecast-MFC-AGG-ID: ItpeUEh8PquA8FPxE4Kmew_1760643901
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-471168953bdso6125545e9.1
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760643901; x=1761248701;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ksp8408IsxwecTmUGjzpuXH4WucsZWUXVX7U4eYiGcs=;
        b=w429svIKVFIH7BZfHf5IpoEWDcO5btkrCI0AtlNEFyuNqV5oJaeG1CZeYv8a0X3PXV
         mpyg0ENPcXeBHg0Z/wMfioqIhOFtpRz3XGVfwCaUzOE0lmlZiZT+8I6NT8DbqHMdNOrF
         idYk4dSW4rubs1J7QFH5CZHZsrwwLV4gUzMILC3q/om1L9tTbeZvvD448jGJR1PA77pg
         RZs6wHi3bmNawbYbB4s0SsdSJFPgmaOe8o8+GMWTZ/DK+EzI0Oof1/lfLUYl3z72zNPe
         HUPdO1PVdm5h6v4OrsnyseA3PEsCppSC8izgNTzi13cXRyvEdFxjEno/nWb8U5E1NPCl
         hnTw==
X-Forwarded-Encrypted: i=1; AJvYcCWiYMqQ2KoS1h+DT54wtiB887IWyzGy7sE5fsUZsHu4Orcs49xige4m+OjEAhIb5LUS97oUF3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGIQPO+TlQqgkDgd7jO+WIAKFyQd7k1wMa+w6FrNSHHkLy+Nw5
	9Sj7drNbGcuc0A1bswyH0jduDublZW0iO9L/mYysGmBwRoXLcJHpR7L08akvH3dxd1y3V/SL9Xo
	i4hNMHq9jSFIN7T5Ca3clgqudzBcg2RuRL5TTuLV+j0xEQPc1bUZMCLxBaA==
X-Gm-Gg: ASbGnctD2dplTCvBqBh1b/JNGKGLwUgDIvtW8WI6KKLbjsqo6Pv+/wGNI1O/uL9Pt3K
	XDmri2MtGHfwztC9Snj6RxreAmLJDGnqQSu8AtHIFzX9TnK80W7ewbBj8E0hBuLfXjrlkzfmCo2
	7krDnAptu1MbB/QMD9DiKTzMhALqoTsRYVHzkrTRKf9rmhYQvYg2mk69HeoeNGZ6CcbyKr3HbbX
	1bShbxYfpr9AehVhUxtrRZ7vdGhDvd70E8hwash9+Z3HDzn04XO6fsbLprQBEAkmcIWP9/g39pQ
	6/6uq1b+CbADhBFt9Szb8e4VO9cjj6iCQafne34/Z+Z4IDMKWUKXTsmXISopDb48OcQOibCZc4D
	+snTbjJNQo3ofH+QbCLDaqzoVVThGytt/JALnUzl/8QS1NArj/EScXo99eHyJkgQDM3OKy4lnyG
	no/TsTbpdXzDqKqBJq91Cv46vzqE4=
X-Received: by 2002:a05:600c:2a94:b0:45b:92a6:63e3 with SMTP id 5b1f17b1804b1-47109a24fddmr26392965e9.9.1760643901291;
        Thu, 16 Oct 2025 12:45:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIKmtm5OtXO7fBnLBPXWoptqR/y0fSk3woBtfDJ5Y9MjcCQX5Zq0k9GsqIgEbeF4forh+F7A==
X-Received: by 2002:a05:600c:2a94:b0:45b:92a6:63e3 with SMTP id 5b1f17b1804b1-47109a24fddmr26392895e9.9.1760643900900;
        Thu, 16 Oct 2025 12:45:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711444d919sm43215855e9.14.2025.10.16.12.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 12:45:00 -0700 (PDT)
Message-ID: <9d9912fe-3b0b-4754-87f6-6efb49d92a7b@redhat.com>
Date: Thu, 16 Oct 2025 21:44:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
To: Jann Horn <jannh@google.com>
Cc: "Uschakow, Stanislav" <suschako@amazon.de>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "trix@redhat.com"
 <trix@redhat.com>, "ndesaulniers@google.com" <ndesaulniers@google.com>,
 "nathan@kernel.org" <nathan@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
 "osalvador@suse.de" <osalvador@suse.de>, "vbabka@suse.cz" <vbabka@suse.cz>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
 <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com>
 <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <e4277c1a-c8d4-429d-b455-8daa9f4bbd14@redhat.com>
 <CAG48ez0yz2DauOuJy=-CcpQpqReWhYH1dpW3QGHPSHQ1VbAf3g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAG48ez0yz2DauOuJy=-CcpQpqReWhYH1dpW3QGHPSHQ1VbAf3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.10.25 21:26, Jann Horn wrote:
> On Thu, Oct 16, 2025 at 9:10 PM David Hildenbrand <david@redhat.com> wrote:
>>>> I'm currently looking at the fix and what sticks out is "Fix it with an
>>>> explicit broadcast IPI through tlb_remove_table_sync_one()".
>>>>
>>>> (I don't understand how the page table can be used for "normal,
>>>> non-hugetlb". I could only see how it is used for the remaining user for
>>>> hugetlb stuff, but that's different question)
>>>
>>> If I remember correctly:
>>> When a hugetlb shared page table drops to refcount 1, it turns into a
>>> normal page table. If you then afterwards split the hugetlb VMA, unmap
>>> one half of it, and place a new unrelated VMA in its place, the same
>>> page table will be reused for PTEs of this new unrelated VMA.
>>
>> That makes sense.
>>
>>>
>>> So the scenario would be:
>>>
>>> 1. Initially, we have a hugetlb shared page table covering 1G of
>>> address space which maps hugetlb 2M pages, which is used by two
>>> hugetlb VMAs in different processes (processes P1 and P2).
>>> 2. A thread in P2 begins a gup_fast() walk in the hugetlb region, and
>>> walks down through the PUD entry that points to the shared page table,
>>> then when it reaches the loop in gup_fast_pmd_range() gets interrupted
>>> for a while by an NMI or preempted by the hypervisor or something.
>>> 3. P2 removes its VMA, and the hugetlb shared page table effectively
>>> becomes a normal page table in P1.
>>> 4. Then P1 splits the hugetlb VMA in the middle (at a 2M boundary),
>>> leaving two VMAs VMA1 and VMA2.
>>> 5. P1 unmaps VMA1, and creates a new VMA (VMA3) in its place, for
>>> example an anonymous private VMA.
>>> 6. P1 populates VMA3 with page table entries.
>>> 7. The gup_fast() walk in P2 continues, and gup_fast_pmd_range() now
>>> uses the new PMD/PTE entries created for VMA3.
>>
>> Yeah, sounds possible. And nasty.
>>
>>>
>>>> How does the fix work when an architecture does not issue IPIs for TLB
>>>> shootdown? To handle gup-fast on these architectures, we use RCU.
>>>
>>> gup-fast disables interrupts, which synchronizes against both RCU and IPI.
>>
>> Right, but RCU is only used for prevent walking a page table that has
>> been freed+reused in the meantime (prevent us from de-referencing
>> garbage entries).
>>
>> It does not prevent walking the now-unshared page table that has been
>> modified by the other process.
> 
> Hm, I'm a bit lost... which page table walk implementation are you
> worried about that accesses page tables purely with RCU? I believe all
> page table walks should be happening either with interrupts off (in
> gup_fast()) or under the protection of higher-level locks; in
> particular, hugetlb page walks take an extra hugetlb specific lock
> (for hugetlb VMAs that are eligible for page table sharing, that is
> the rw_sema in hugetlb_vma_lock).

I'm only concerned about gup-fast, but your comment below explains why 
your fix works as it triggers an IPI in any case, not just during the 
TLB flush.

Sorry for missing that detail.

> 
> Regarding gup_fast():
> 
> In the case where CONFIG_MMU_GATHER_RCU_TABLE_FREE is defined, the fix
> commit 1013af4f585f uses a synchronous IPI with
> tlb_remove_table_sync_one() to wait for any concurrent GUP-fast
> software page table walks, and some time after the call to
> huge_pmd_unshare() we will do a TLB flush that synchronizes against
> hardware page table walks.

Right, so we definetly issue an IPI.

> 
> In the case where CONFIG_MMU_GATHER_RCU_TABLE_FREE is not defined, I
> believe the expectation is that the TLB flush implicitly does an IPI
> which synchronizes against both software and hardware page table
> walks.

Yes, that's what I had in mind, not an explicit sync.


So the big question is whether we could avoid this IPI on every unsharing.

Assume we would ever reuse a page table that was shared, we'd have to do 
this IPI only before freeing the page table I guess, or free the page 
table through RCU.

-- 
Cheers

David / dhildenb


