Return-Path: <stable+bounces-42962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A307D8B9B52
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 15:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F6E280DAB
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 13:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3804D7580A;
	Thu,  2 May 2024 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqBtfaXB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8609732C60
	for <stable@vger.kernel.org>; Thu,  2 May 2024 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655308; cv=none; b=Sn+Ph8LxDxkkum+WDUvwqn+SJBeio+zMPjkmCRzZkuJQ91TeqBaSmKkDIF2Af/TcXz/l48dRZK8/4UVCnLwVjgli3uFvKhE14O3F8+xozgPd3XGoRfSdQUSFhuzzAZeCCiqPjqxoFDOOcs1kXGFu9dKQf5mieioKXQKpQy2tueY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655308; c=relaxed/simple;
	bh=nzEle+AIKVBxuUYToukONGWIIzFxkcl6FDdN+X3jExE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBijo0PB7Em0o4T0cv6JhDiwAK1ZUn/YLG02/GorkvGcojDUiOYHlUvyivZoTfRcUbtBbUnMnzVuLqDyBD2VHqOY1vrBC+TEq0iVPT6HcjgFv+bxrK+AxGS0AiEX8fXuZPhXhtGqM3nLBkPlaL2jojfjrwMP4iCBKnwiE0Chqhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eqBtfaXB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714655305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ylGHOp62O7s37wB6m2TxWSrAjoDqOAFGMczJ+VHsbgs=;
	b=eqBtfaXBNl5GikEWf/KHttXLemIShNIoqpkCj+RquRs7l0l2DLKuEgkGP933YWcLIu9EI4
	+96pgaKRuzJQzgBbIKSj6a825tp5Un+XacKpi7ciQTppXrBpRxP1TqMHhMC3/p5M8+sTVl
	zmcnNctHIHo2dt6L0QPN9C3ZsU9H9tk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-K6nKRhK6Nm-KCIECEU61TQ-1; Thu, 02 May 2024 09:08:24 -0400
X-MC-Unique: K6nKRhK6Nm-KCIECEU61TQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34e0836d91eso621636f8f.2
        for <stable@vger.kernel.org>; Thu, 02 May 2024 06:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714655303; x=1715260103;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ylGHOp62O7s37wB6m2TxWSrAjoDqOAFGMczJ+VHsbgs=;
        b=XP2jFt66Mzm2cVMRCKKuN5oDP126P7lZVQGFXrGSad/wOBma2/eIUglTzqclJrWDuU
         GraHkuifwuF/7NgxnzhBnuF1gZRItoqdFeSlVbsGiryWHGQKWIa3mzk37n3+jSzJCRGh
         hQmNh8XD3lbeGmNMPJflnaSeqbxztjXqO7gh6QE4YqDxNI1StSlyqhtOKLbsE/GpttIv
         62u+hrK0uveJSONLoo12I0i9SgBy7DVICi+s8FeAek7NtDJlVuoFrRY16lkTk6hnVyg9
         PIdGsb+sO7ph8xTq/g0yUoB7CGUhD3+zlO2Du1VSJhZBKI8hTPppcZURm64HvQjsZd0S
         L+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUlm1Z2kxUrKlre3eH/nEh159VV0YMthEbOrqGS5RYDiRP+XPtLf7PMSRshXQmO3fj1LptK9479QtI9h/V1+RpP3OJKI58k
X-Gm-Message-State: AOJu0Ywsvsf8KzTn37WlT/CpS8ZYJL/g+pTDRCSpLVJ09vfaTG6/cT4f
	0N19Dayq1TYkGj2S/SzSE+eLt/9O7Fv4ryuymZvWXl31O2rjXOg4wGabOI2NMkLOle9uuG6CHDf
	4EeUmQ/az4NIsL+rwpYTYlUZGTAp3t+9frIqOH8+I/qHXNlqEbsibzA==
X-Received: by 2002:adf:f98e:0:b0:34d:a1fb:8f73 with SMTP id f14-20020adff98e000000b0034da1fb8f73mr3886724wrr.4.1714655302885;
        Thu, 02 May 2024 06:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfLT78sbXYQRxgwK2Hy1T4Th/2e9EhWCInI4nKulB33e+Jnf3IyyQTLTOz97wAG24nnpNYBQ==
X-Received: by 2002:adf:f98e:0:b0:34d:a1fb:8f73 with SMTP id f14-20020adff98e000000b0034da1fb8f73mr3886686wrr.4.1714655302365;
        Thu, 02 May 2024 06:08:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:bf00:eba1:3ab9:ab0f:d676? (p200300cbc71ebf00eba13ab9ab0fd676.dip0.t-ipconnect.de. [2003:cb:c71e:bf00:eba1:3ab9:ab0f:d676])
        by smtp.gmail.com with ESMTPSA id dn2-20020a0560000c0200b0034e14d59f07sm1240196wrb.73.2024.05.02.06.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 06:08:21 -0700 (PDT)
Message-ID: <3d88297b-ce6f-4b97-8a25-75f0987af6fd@redhat.com>
Date: Thu, 2 May 2024 15:08:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Zi Yan
 <zi.yan@cs.rutgers.edu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20240501143310.1381675-1-ryan.roberts@arm.com>
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
In-Reply-To: <20240501143310.1381675-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.05.24 16:33, Ryan Roberts wrote:
> __split_huge_pmd_locked() can be called for a present THP, devmap or
> (non-present) migration entry. It calls pmdp_invalidate()
> unconditionally on the pmdp and only determines if it is present or not
> based on the returned old pmd. This is a problem for the migration entry
> case because pmd_mkinvalid(), called by pmdp_invalidate() must only be
> called for a present pmd.
> 
> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
> future call to pmd_present() will return true. And therefore any
> lockless pgtable walker could see the migration entry pmd in this state
> and start interpretting the fields as if it were present, leading to
> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker.
> 
> x86 does not suffer the above problem, but instead pmd_mkinvalid() will
> corrupt the offset field of the swap entry within the swap pte. See link
> below for discussion of that problem.

Could that explain:

https://lore.kernel.org/all/YjoGbhreg8lGCGIJ@linutronix.de/

Where the PFN of a migration entry might have been corrupted?

Ccing Felix


Patch itself looks good to me

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


