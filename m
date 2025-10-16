Return-Path: <stable+bounces-186190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F34BE5315
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEBE5E53A8
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 19:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B5F27FB05;
	Thu, 16 Oct 2025 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jp5G6clF"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707D02550CA
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641815; cv=none; b=qhPQkuq0j6kvt5fD/in/Xl5joB4Ci5cKpCOjVXWiW8Yit+JuKjlN3fRNCb8BD9C1eeJM1fqbthxf9psuOEXMN/6JxsHxSGfYIeP0ghJHLcAosotak2cYqSF5nIhO+GfuMkHzUi25eXrDN1BiRxf96UH3ChNEBOkPAA/BqOL+szE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641815; c=relaxed/simple;
	bh=1YIxE/5Vi3hruKRl+eohYotPfaWKW71gmzDh9nJEsTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/nycvOaPTAI5OQzSr2dQsEMIUUYpnqWvt770M1hws/xMNYpzpb2ef2vU5A2ntBFXIQjr6fm44aQWTuER/pRY5JD+zBg8Fnlune8M68uH6RuMEtlBc4CFEB60bcMc8dp00iwkW/nD6gBn8TBiZqxMvt6DIq50NR9OBG49V8N++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jp5G6clF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760641812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+3AAg05Yf1Z3P5L48FsHnTWstB0ReAZ8G/euj8J0YSU=;
	b=Jp5G6clFe2pld9iyHQXrXZgqGO7u3tY0/7N+wsCFM34QOqkPauHPvFNRmWVlHJ7Wo4P6Ha
	zExmULYiDW15TWiwvCHJi0xGjoleA388fJuo7kE2nzLGO6zoYjz2IvRH57gHFIWtpLIY5Y
	cskDBVvgZOo62wye0NVd16K2xWnbDR0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-K0MBdO4APgiAbKXG6WR8_g-1; Thu, 16 Oct 2025 15:10:10 -0400
X-MC-Unique: K0MBdO4APgiAbKXG6WR8_g-1
X-Mimecast-MFC-AGG-ID: K0MBdO4APgiAbKXG6WR8_g_1760641806
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso11693385e9.2
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 12:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760641806; x=1761246606;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3AAg05Yf1Z3P5L48FsHnTWstB0ReAZ8G/euj8J0YSU=;
        b=JvNOQkAbaGTe/STZpV7bRE1EDPBKMtyflKjFMbIxin8nJbukyfe/jFAwYQzeHLk6Zx
         Iz1G0BK3GSyMhNCs1qsDtvKO8otZn5px6hdpz+7xX2TTRqYUkoWCf3/++qsJtIT3Ek8+
         jdfSCv/rl0Y8PBTDJVrkkuiMttTOSvx0hKfD713OEaWu/VBfZwjBLa2K5qMibh3EA6HE
         aGFFqihZSE0nuDav2uz9Nv8+kAs+pZ1U2dZWO+1uUfi28y7IGRiZ2AYKaBgXXh4oAxbu
         qzE/6RiLi4EJuB0WHYvlXTNvVX9Q5wjNMkYcXgfYnlflDiORmiATg/QuSTr086N6NGxj
         K/Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWrQs1akc+5XGDnIcp27WFQdHXh0iJ9KkBRp37jqjsd4daz2hHXuClTp6EhaEMLDAc503MXW8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo7x5jzh/xaTGeUiEfTqbFd+SiuVAuFLI268JZxx4ABEyexZvi
	mgaO8r3CbvR0ZCVtIuQA/TuHLm64J5R4d9tBU7EQeod6d8ufw8C1RI40zlQRJ8enjFOVlkC4YV8
	8FGP0xJsswoqC8NGjc8DUbOVamRtEQTC5xbEq7FG7A7cxv0Y4ZrzpuQnWqw==
X-Gm-Gg: ASbGncuHxoabc1cSbmN0oj4TKXyb9DB7kqmqG7EoX+X6mr5U2RjSsb+tur2vL/B2K99
	44DI+mQYw5cxN7wvprtWgDaF11/fKOeU/WE6Sy1nx+/1pLqqIXVc4ih0jGO14wpcOoFm8gh/Hzk
	lpp8Brc/9/GE2tfGBebmrnA86DXUrW+X9CA0+jKzBfWOfecHbppksHdXgHsbYEDG/I4sOxWQlP2
	CbxUqGchtk0YtmruORRdI95B0UM+VS/hAzt9P2X0MKjYr6sYwtgHjZrl9YTRcvEppV2xOao+4yH
	0KFrwgnG7G4bk74tM44gC755xmpjhtiMimb3rfwBF4PaM7B1be8Bj9GKNXk/HgYP+ahllrQYctM
	PzKOdfFAhPBR0tj4Kk2Gg2Tiyb01tcMVicXxSjHoL47x2DgU/JbJC45RzyJw2RD3nGqCdpJ5gkD
	r4b/YwIV5b6oCBh/u2wJjOE44MuNw=
X-Received: by 2002:a05:600c:3b83:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47117925171mr12364025e9.34.1760641805977;
        Thu, 16 Oct 2025 12:10:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc5h2vbpz69OVWKGuaFjCUjxbNEASV+GvR8Na4j9NprkAExd41lL0K2813EC7L3Hmt8vs2XQ==
X-Received: by 2002:a05:600c:3b83:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47117925171mr12363635e9.34.1760641805466;
        Thu, 16 Oct 2025 12:10:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711441f776sm46310535e9.3.2025.10.16.12.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 12:10:04 -0700 (PDT)
Message-ID: <e4277c1a-c8d4-429d-b455-8daa9f4bbd14@redhat.com>
Date: Thu, 16 Oct 2025 21:10:03 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> I'm currently looking at the fix and what sticks out is "Fix it with an
>> explicit broadcast IPI through tlb_remove_table_sync_one()".
>>
>> (I don't understand how the page table can be used for "normal,
>> non-hugetlb". I could only see how it is used for the remaining user for
>> hugetlb stuff, but that's different question)
> 
> If I remember correctly:
> When a hugetlb shared page table drops to refcount 1, it turns into a
> normal page table. If you then afterwards split the hugetlb VMA, unmap
> one half of it, and place a new unrelated VMA in its place, the same
> page table will be reused for PTEs of this new unrelated VMA.

That makes sense.

> 
> So the scenario would be:
> 
> 1. Initially, we have a hugetlb shared page table covering 1G of
> address space which maps hugetlb 2M pages, which is used by two
> hugetlb VMAs in different processes (processes P1 and P2).
> 2. A thread in P2 begins a gup_fast() walk in the hugetlb region, and
> walks down through the PUD entry that points to the shared page table,
> then when it reaches the loop in gup_fast_pmd_range() gets interrupted
> for a while by an NMI or preempted by the hypervisor or something.
> 3. P2 removes its VMA, and the hugetlb shared page table effectively
> becomes a normal page table in P1.
> 4. Then P1 splits the hugetlb VMA in the middle (at a 2M boundary),
> leaving two VMAs VMA1 and VMA2.
> 5. P1 unmaps VMA1, and creates a new VMA (VMA3) in its place, for
> example an anonymous private VMA.
> 6. P1 populates VMA3 with page table entries.
> 7. The gup_fast() walk in P2 continues, and gup_fast_pmd_range() now
> uses the new PMD/PTE entries created for VMA3.

Yeah, sounds possible. And nasty.

> 
>> How does the fix work when an architecture does not issue IPIs for TLB
>> shootdown? To handle gup-fast on these architectures, we use RCU.
> 
> gup-fast disables interrupts, which synchronizes against both RCU and IPI.

Right, but RCU is only used for prevent walking a page table that has 
been freed+reused in the meantime (prevent us from de-referencing 
garbage entries).

It does not prevent walking the now-unshared page table that has been 
modified by the other process.

For that, we need the back-off described below. IIRC we implemented that 
in the PMD case for khugepaged.

Or is there somewhere a guaranteed RCU sync before the shared page table 
gets reused?

> 
>> So I'm wondering whether we use RCU somehow.
>>
>> But note that in gup_fast_pte_range(), we are validating whether the PMD
>> changed:
>>
>> if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
>>       unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
>>          gup_put_folio(folio, 1, flags);
>>          goto pte_unmap;
>> }
>>
>>
>> So in case the page table got reused in the meantime, we should just
>> back off and be fine, right?
> 
> The shared page table is mapped with a PUD entry, and we don't check
> whether the PUD entry changed here.

Yes, see my follow-up mail, that's what we'd have to add.

On an arch without IPI, page tables will be freed with RCU and it just 
works. We walk the wrong page table, realize that the PUD changed and 
back off.

On an arch with IPI it's tricky: if we don't issue the IPI you added, we 
might still back off once we check the PUD entry didn't changee, but I'm 
afraid nothing would stop us from walking the previous page table that 
was freed in the meantime, containing garbage.

Easy fix would be never reusing a page table once shared once?

-- 
Cheers

David / dhildenb


