Return-Path: <stable+bounces-61887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67A93D62F
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 17:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54291C229DE
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 15:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BDA17A5AD;
	Fri, 26 Jul 2024 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnEgtyuM"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27AC17578
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007931; cv=none; b=A0gCTVh2hg7FS4MtQK8ACChKKnQUtqo2YAqRJCVged3T7Sv9Opo1hItghrp1D7kYowMcHjUHahMWOPlQ5UlTDxci4DyULQtA/KgOESgVoKmGP79BTsA1UYvMV2c0DFsxSg+rNUZwAehfqFPKWlhw3oKGQv+1snfsr9VS8eXO+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007931; c=relaxed/simple;
	bh=Ej8/Ht8a/iMSYkUocZh9vZHCoTuvEa2ZotwQ9icFplY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIkxt26Pmee4kdgG29tLE0bBHVJfgFNnTtbsLnzyEtSeJF1o35sfEpjcF1aFcykmiGvcLH5/4IP0F435UrYVCfjqiFKh6qx2UuFFauKG4PjBLN6T5TmjeWhPOrYH9YQJDhApbN5ffwcwqXSaKRq/iSWKP7txIeSfvmZ8mkgJQX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LnEgtyuM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722007928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8Ycth9+LBlSYBAQt5hef55NWuGeGl5lxoPpY/WIRu5w=;
	b=LnEgtyuMoXxlb1yFGobekAB+Q7CzXhsCNvQb0wNDGbhOfGZxWOeuLS06YjDY7wkEpQeoKs
	pWWCNJZg47eZDpsXupxymNejHptYrWAinI4d/u/ZXLkvYXhk8TVsstFUsrn0r2Ixsbj88+
	3l+bz35uJmtT2qEM2F3wHV2O5uVt/b4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-PSDLri_JOKaoJMKXG0gCxg-1; Fri, 26 Jul 2024 11:32:06 -0400
X-MC-Unique: PSDLri_JOKaoJMKXG0gCxg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f01bd7ad5eso13225511fa.2
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 08:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722007925; x=1722612725;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Ycth9+LBlSYBAQt5hef55NWuGeGl5lxoPpY/WIRu5w=;
        b=OaHDBFKBj8Bz+PTq9junqT++qIG09dUL7Z9IueC3MuNT5McZ04mD9ugQYajy37OnEs
         rjhb3i73mTBjQoET1oNoYrZLSPEFfcjfdp+pBzOorCoSXeTh1F1K7HnOQq0lCCLf3BVa
         YJKWAV8iKSIACVAjTOC4Xc6xk22WkCDLnqfENs9Dky3aws40V/KxXvzrrtXNJd44iq7G
         pC8m9JX4IQ5d6BnbRv5SsN2aAXt3NeR/RaUquRFICNmqNkzww/eBy0Dl8fcksGs7dKIe
         nzvGsYWduTFwVt9GfREaD/S/aZ7AYzb7lWqQbf1x+7zsneMCJwvDV2owOPL61w+L4lzy
         w55g==
X-Forwarded-Encrypted: i=1; AJvYcCUeJ5GiQPx2TXKj8lFZVOep3QjtZJ/WIUKoAUWrI1Q4rcqdvZQCEMhQ0x+YYiA7MfX7qBTAY6KuJc1gWX0jqiH6gipfER1X
X-Gm-Message-State: AOJu0YwbnTz069jShDkHO9/GyKo2Hp85R4vRuV/K3eu9MNg702UcdK42
	5m6H2unG1ltds2PIg0VEulCmn2ZX3T2v+481TT2gF6XIc3q1h6tJcgKL9bVZ+f3RICN8QMzXaEL
	vIUtPn3bdrnZme5o8Xh3qlqBBcrxntfxQr9E4wvbX/X3ZweNZL5onGQ==
X-Received: by 2002:a2e:80cd:0:b0:2ef:2332:5e63 with SMTP id 38308e7fff4ca-2f12edd6bc9mr350261fa.23.1722007924873;
        Fri, 26 Jul 2024 08:32:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFyXy8M7HOVMNlPdorYprerISt2DRk41ZnUMBik8Qskml6v/WdKDelYreTxESB6bf7zGgnPg==
X-Received: by 2002:a2e:80cd:0:b0:2ef:2332:5e63 with SMTP id 38308e7fff4ca-2f12edd6bc9mr350041fa.23.1722007924353;
        Fri, 26 Jul 2024 08:32:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:a600:7ca0:23b3:d48a:97c7? (p200300cbc713a6007ca023b3d48a97c7.dip0.t-ipconnect.de. [2003:cb:c713:a600:7ca0:23b3:d48a:97c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057b7274sm83556925e9.40.2024.07.26.08.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 08:32:03 -0700 (PDT)
Message-ID: <4a12630b-bd2b-45ec-9a2d-57ed9ac2faa0@redhat.com>
Date: Fri, 26 Jul 2024 17:32:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 stable@vger.kernel.org
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-3-david@redhat.com> <ZqPAHDBDOtABrk_3@x1n>
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
In-Reply-To: <ZqPAHDBDOtABrk_3@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.07.24 17:26, Peter Xu wrote:
> On Thu, Jul 25, 2024 at 08:39:55PM +0200, David Hildenbrand wrote:
>> We recently made GUP's common page table walking code to also walk
>> hugetlb VMAs without most hugetlb special-casing, preparing for the
>> future of having less hugetlb-specific page table walking code in the
>> codebase. Turns out that we missed one page table locking detail: page
>> table locking for hugetlb folios that are not mapped using a single
>> PMD/PUD.
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
>> Let's make huge_pte_lockptr() effectively uses the same PT locks as any
>> core-mm page table walker would.
>>
>> There is one ugly case: powerpc 8xx, whereby we have an 8 MiB hugetlb
>> folio being mapped using two PTE page tables. While hugetlb wants to take
>> the PMD table lock, core-mm would grab the PTE table lock of one of both
>> PTE page tables. In such corner cases, we have to make sure that both
>> locks match, which is (fortunately!) currently guaranteed for 8xx as it
>> does not support SMP.
> 
> Do you mean "does not support SPLIT_PMD_PTLOCK" here instead of SMP?

Split PT locks are only enabled once we have NR_CPUS >= 4, so without 
SMP (NR_CPUS == 1), no split PT locks are used. I document that in the 
other series that I just sent out in a better way.

> 
>>
>> Fixes: 9cb28da54643 ("mm/gup: handle hugetlb in the generic follow_page_mask code")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Patch looks all right to me:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Thanks!

Thanks Peter!

-- 
Cheers,

David / dhildenb


