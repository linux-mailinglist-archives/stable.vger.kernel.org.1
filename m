Return-Path: <stable+bounces-65251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B99F944F69
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 17:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44B19B2722D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 15:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72081A3BDA;
	Thu,  1 Aug 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2ed3l3A"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171142049
	for <stable@vger.kernel.org>; Thu,  1 Aug 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526536; cv=none; b=P0o/NQoqIWevzXTl8J3zpWu5aD9eiVpunyNkxTR1KFxBbzbYxEQOdTdT/5XLibmFkNSvsI8qrZ5CDTHBQdQqU503ZIEeFUnmP1bk3wdsVmt+LohziPn9Ki1myL7PMk46foGzSCRsneCn1qLVq2/CTYNU3S0GCmXcirtlBwpPBkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526536; c=relaxed/simple;
	bh=dZ5+3OyYBXk4vMl3A+qwDkERG7+OkWxAKh5vaq2B/hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nc1c16uSRmV1Sc0Rt13XRSGPycNiZNv3cm0LOS/8DauUQOOaihyvtCYXbA0lsut3pXy2pIn/hMgQflXugU0Gwry/h5z3xrzsuJNU2um8SVJo1culuoyierUoW05OHNznzBH3ZXMCCz0Bd8DL5lFegrZhAxOv0Du8hRJ3rwbjdQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N2ed3l3A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722526525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bxHd67g8QE4/irwnJReh3lj340LNkEJq3nJucVFKn8c=;
	b=N2ed3l3A/jpiQs6pPYkA+Ut5Y+YdQJWiFlyqkJQvz/e1XfP97iK7/HetY9pz36cWGrXEin
	gFDJ1NzlYJrWuZhZZBkxpzOalv0U1Ls80GMtxHNdLS1ouVe4sQZ3qvcD1gm5WOlxPyOya6
	m9rExZ6dKkjP8CQIJVl2Rej0dLHfaz4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-gksjva8QOyiVlYTxGADYpg-1; Thu, 01 Aug 2024 11:35:23 -0400
X-MC-Unique: gksjva8QOyiVlYTxGADYpg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42817980766so42290155e9.3
        for <stable@vger.kernel.org>; Thu, 01 Aug 2024 08:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722526522; x=1723131322;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bxHd67g8QE4/irwnJReh3lj340LNkEJq3nJucVFKn8c=;
        b=wvYfH5E5r5aM5PUAJ1KRIGPG4X3jlI70E3GX0naE+ArKTe62aAOwVaStrzXNOe/yYx
         Rl6LdQSIBXYpYr76ZIzuoI2pdM1NBs+N/042BDPmHBboWG0AuN4j7OQxjxT35sksZdL8
         O4yY6bpiZzjZ1wSBnKSq2qHgoeHulv9v8Y6LK9iy9tfxzgWNfwMiWhfq2LlT0Q246myP
         9Teqcf7wv0gi/oIcZcQIPSXKpJqPyBJgp/NwHSqOBEfzh9aLGs0jBIcmzNvgJC/fsF8K
         3TZ5IrXvm/ybff4vL7jXbl9Y7hnwhPh7ESMpEOvoi0ldXsuHELuLEGmaBfSsvHEDC6tC
         OdIA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ41VOfC/387EdZeHQGM3S6pH8vOV2CpA2ZSrSt4A0ZR1F/G9dO2R9TEt6HzL8OC3eGKYhp+t0kVPUFfr82YjXCUqce1EF
X-Gm-Message-State: AOJu0YzgLbf4/P9PFTRO4JwhQWXeWUM2rV3e+1aulHY4DBCizWtdwSW4
	aujq4Pf2ORJrsOxFhVJND/dFq5j2BXEQIop51XPUolcTgWNr4lIC92WgJMJJUPKR7LG/+JOK4Qo
	JVR0X2C/SRqaLTISCWv7XN4a5yYEVh4OZkQSvrq1Uu2GGLebn5OP/BQ==
X-Received: by 2002:a05:600c:4e90:b0:428:314:f08e with SMTP id 5b1f17b1804b1-428e6af4c75mr2083835e9.5.1722526522310;
        Thu, 01 Aug 2024 08:35:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9LYRGdwSXLVTsgo1QyvkIvyA52WmWe8W15IZpd4pfL+707kYosP/uCOB+TcLEyF2rYl3G6g==
X-Received: by 2002:a05:600c:4e90:b0:428:314:f08e with SMTP id 5b1f17b1804b1-428e6af4c75mr2083565e9.5.1722526521768;
        Thu, 01 Aug 2024 08:35:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8adaadsm63082695e9.12.2024.08.01.08.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 08:35:21 -0700 (PDT)
Message-ID: <934885c5-512b-41bf-8501-b568ece34e18@redhat.com>
Date: Thu, 1 Aug 2024 17:35:20 +0200
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
 Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20240731122103.382509-1-david@redhat.com>
 <541f6c23-77ad-4d46-a8ed-fb18c9b635b3@redhat.com> <ZquTHvK0Rc0xBA4y@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZquTHvK0Rc0xBA4y@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peter,

>> -	if (huge_page_size(h) == PMD_SIZE)
>> +	unsigned long size = huge_page_size(h);
>> +
>> +	VM_WARN_ON(size == PAGE_SIZE);
>> +
>> +	/*
>> +	 * hugetlb must use the exact same PT locks as core-mm page table
>> +	 * walkers would. When modifying a PTE table, hugetlb must take the
>> +	 * PTE PT lock, when modifying a PMD table, hugetlb must take the PMD
>> +	 * PT lock etc.
>> +	 *
>> +	 * The expectation is that any hugetlb folio smaller than a PMD is
>> +	 * always mapped into a single PTE table and that any hugetlb folio
>> +	 * smaller than a PUD (but at least as big as a PMD) is always mapped
>> +	 * into a single PMD table.
>> +	 *
>> +	 * If that does not hold for an architecture, then that architecture
>> +	 * must disable split PT locks such that all *_lockptr() functions
>> +	 * will give us the same result: the per-MM PT lock.
>> +	 *
>> +	 * Note that with e.g., CONFIG_PGTABLE_LEVELS=2 where
>> +	 * PGDIR_SIZE==P4D_SIZE==PUD_SIZE==PMD_SIZE, we'd use the MM PT lock
>> +	 * directly with a PMD hugetlb size, whereby core-mm would call
>> +	 * pmd_lockptr() instead. However, in such configurations split PMD
>> +	 * locks are disabled -- split locks don't make sense on a single
>> +	 * PGDIR page table -- and the end result is the same.
>> +	 */
>> +	if (size >= P4D_SIZE)
>> +		return &mm->page_table_lock;
> 
> I'd drop this so the mm lock fallback will be done below (especially in
> reality the pud lock is always mm lock for now..).  Also this line reads
> like there can be P4D size huge page but in reality PUD is the largest
> (nopxx doesn't count).  We also same some cycles in most cases if removed.

The compiler should be smart enough to optimize most of that out. But
I agree that there is no need to be that future-proof here.

These two are interesting:

arch/powerpc/mm/hugetlbpage.c:  if (!mm_pud_folded(mm) && sz >= P4D_SIZE)
arch/riscv/mm/hugetlbpage.c:    else if (sz >= P4D_SIZE)

But I assume they are only fordward-looking. (GUP would already be
pretty broken if that would exist)


>> +	else if (size >= PUD_SIZE)
>> +		return pud_lockptr(mm, (pud_t *) pte);
>> +	else if (size >= PMD_SIZE || IS_ENABLED(CONFIG_HIGHPTE))
> 
> I thought this HIGHPTE can also be dropped? Because in HIGHPTE it should
> never have lower-than-PMD huge pages or we're in trouble.  That's why I
> kept one WARN_ON() in my pesudo code but only before trying to take the pte
> lockptr.

Then the compiler won't optimize out the ptep_lockptr() call and we'll run
into a build error. And I think the HIGHPTE builderror serves good purpose.

In file included from <command-line>:
In function 'ptep_lockptr',
     inlined from 'huge_pte_lockptr' at ./include/linux/hugetlb.h:974:9,
     inlined from 'huge_pte_lock' at ./include/linux/hugetlb.h:1248:8,
     inlined from 'pagemap_scan_hugetlb_entry' at fs/proc/task_mmu.c:2581:8:
././include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_256' declared with attribute error: BUILD_BUG_ON failed: IS_ENABLED(CONFIG_HIGHPTE)
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
./include/linux/mm.h:2874:9: note: in expansion of macro 'BUILD_BUG_ON'
  2874 |         BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));



It would be even better to have a way to know whether an arch even has
hugetlb < PMD_SIZE (config option?) and use that instead here; but I'll leave
that as an optimization.


-- 
Cheers,

David / dhildenb


