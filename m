Return-Path: <stable+bounces-65234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23922944702
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 10:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E451C23D74
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD7716C85D;
	Thu,  1 Aug 2024 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEDo3vE1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32BF4503A
	for <stable@vger.kernel.org>; Thu,  1 Aug 2024 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502225; cv=none; b=Gg7xuXQcotiawb3WANjbnMEh7ISyffSLtFPiLUfjq59ji9zqXq6bDuUw7rXLX7kZsEI2F8lAg8CewNXdka9QlFHDf65h26/v60NrfNZQkCUBmI4aL7tdN+0wEGtPPpxR4Wge0I+ah9Is3aiLeULq+uwIb3HS8+hh8nzZ7kkhu9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502225; c=relaxed/simple;
	bh=ouxwYyhcm6jhKBX44wNx6bi9KEpKO+V6mnvxb5oHiSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGVOR7xJWLzcxsgvgkgDOiEf+FR7zeuJRmwQ0cpYu/wPstQstV1xqTlh+lBzXUIBrvuXc+hyLV7HG/9P/L/9Ti53jlwfD1Esvo1IQYg676jhD7vVVmfnWm3D3dE1UInadDlagRzNipHcvCP5tv5aTJKpipTF3MvDZ5kppKZYAa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEDo3vE1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722502222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=clzayXSw0T9Pink1HUicNm+MIZ3TP2gz+wqmLrsBXaU=;
	b=DEDo3vE1ZZlzevu7XxjKL1CzWzlfP8DKkgnEFNJnTrRQ/90OQqHszq6bb0G7nlMUn6ESeq
	eyBabF1zVj1P+pXanqjAxYz5IRo2Tu8Ps49RghRrgeRtHHByl8wOg0YW3YO1OE3wId3HLF
	eJ0JjZTrsLU5PicJqwudohTdbEzHC7U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-XHRx_O7hMBahXE5MvBwsRw-1; Thu, 01 Aug 2024 04:50:21 -0400
X-MC-Unique: XHRx_O7hMBahXE5MvBwsRw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42808efc688so42057565e9.0
        for <stable@vger.kernel.org>; Thu, 01 Aug 2024 01:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722502220; x=1723107020;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=clzayXSw0T9Pink1HUicNm+MIZ3TP2gz+wqmLrsBXaU=;
        b=qCqM34g46OzQuAIg+KoWPZZAs1kIKT5y5MVMk+rGx8WRGsdp6hgtZv3/hALIQNXYoU
         bI2g1tOePVlLF/nPV3eyE3ix/rnm/3pbZxCQ/OQ42YTSbNXY7RGYmFm8ud8sfDom2Zes
         GmyCpsCG3gqtQQEUpoVlNirfZzw0jcBIhySwA50VwYDWBS1yRE0MbKStq1OL41nWVlsc
         leLhWzyKgoyMdI1F0ozUUZbvGAZ6A3w6yoljbPBziRrFQlT9A1l9d3NeofLjzkW8hrhy
         1MQepDUZCc9cFntimBdvOdPO4RUvwS7aZCpiIedquz7TYnmIZON0zCH/GjlQxWPBL+Mp
         UENQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+poPVB64G4UDLK6bXft+hdaEcYL0kkAKL6hfo8gxPtLkx/GEBMWtiehh+7iknz8o9lgBV5NnmahcnQrAoiT/7v1Cy2CXG
X-Gm-Message-State: AOJu0Yy15vCzrnqLRGNrIl8/ItfLgTq41nhi+pSQ2r6OICIMNmjR7lbF
	oiwcfafieTyJod5mlNoULnhpZGr9XTOyjzro2GvFfTCacbino1V9HTlfm8Qkn0HzB5nwNDD6KNP
	qy+0z0fgU8iEss+uXDP/mqdksxFT4OyB/t+GqOKexrLZL2TOQP8ugkg==
X-Received: by 2002:a5d:6046:0:b0:368:4638:add0 with SMTP id ffacd0b85a97d-36baaee6a08mr1057721f8f.35.1722502220057;
        Thu, 01 Aug 2024 01:50:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbxlsN1Q/32e+LZJga1SOQCPV4S5aIJTLoE5J2Z5dJwTMAydx5HcZxt2teUWtnH/PZ1/wMPw==
X-Received: by 2002:a5d:6046:0:b0:368:4638:add0 with SMTP id ffacd0b85a97d-36baaee6a08mr1057697f8f.35.1722502219530;
        Thu, 01 Aug 2024 01:50:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fd071sm18902825f8f.62.2024.08.01.01.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 01:50:19 -0700 (PDT)
Message-ID: <541f6c23-77ad-4d46-a8ed-fb18c9b635b3@redhat.com>
Date: Thu, 1 Aug 2024 10:50:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, James Houghton <jthoughton@google.com>,
 stable@vger.kernel.org, Peter Xu <peterx@redhat.com>,
 Oscar Salvador <osalvador@suse.de>, Muchun Song <muchun.song@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20240731122103.382509-1-david@redhat.com>
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
In-Reply-To: <20240731122103.382509-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.07.24 14:21, David Hildenbrand wrote:
> We recently made GUP's common page table walking code to also walk hugetlb
> VMAs without most hugetlb special-casing, preparing for the future of
> having less hugetlb-specific page table walking code in the codebase.
> Turns out that we missed one page table locking detail: page table locking
> for hugetlb folios that are not mapped using a single PMD/PUD.

James, Peter,

the following seems to get the job done. Thoughts?

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8e462205400d..776dc3914d9e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -938,10 +938,40 @@ static inline bool htlb_allow_alloc_fallback(int reason)
  static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
  					   struct mm_struct *mm, pte_t *pte)
  {
-	if (huge_page_size(h) == PMD_SIZE)
+	unsigned long size = huge_page_size(h);
+
+	VM_WARN_ON(size == PAGE_SIZE);
+
+	/*
+	 * hugetlb must use the exact same PT locks as core-mm page table
+	 * walkers would. When modifying a PTE table, hugetlb must take the
+	 * PTE PT lock, when modifying a PMD table, hugetlb must take the PMD
+	 * PT lock etc.
+	 *
+	 * The expectation is that any hugetlb folio smaller than a PMD is
+	 * always mapped into a single PTE table and that any hugetlb folio
+	 * smaller than a PUD (but at least as big as a PMD) is always mapped
+	 * into a single PMD table.
+	 *
+	 * If that does not hold for an architecture, then that architecture
+	 * must disable split PT locks such that all *_lockptr() functions
+	 * will give us the same result: the per-MM PT lock.
+	 *
+	 * Note that with e.g., CONFIG_PGTABLE_LEVELS=2 where
+	 * PGDIR_SIZE==P4D_SIZE==PUD_SIZE==PMD_SIZE, we'd use the MM PT lock
+	 * directly with a PMD hugetlb size, whereby core-mm would call
+	 * pmd_lockptr() instead. However, in such configurations split PMD
+	 * locks are disabled -- split locks don't make sense on a single
+	 * PGDIR page table -- and the end result is the same.
+	 */
+	if (size >= P4D_SIZE)
+		return &mm->page_table_lock;
+	else if (size >= PUD_SIZE)
+		return pud_lockptr(mm, (pud_t *) pte);
+	else if (size >= PMD_SIZE || IS_ENABLED(CONFIG_HIGHPTE))
  		return pmd_lockptr(mm, (pmd_t *) pte);
-	VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
-	return &mm->page_table_lock;
+	/* pte_alloc_huge() only applies with !CONFIG_HIGHPTE */
+	return ptep_lockptr(mm, pte);
  }
  
  #ifndef hugepages_supported
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a890a1731c14..bd219ac9c026 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2869,6 +2869,13 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
  	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
  }
  
+static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
+{
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
+	BUILD_BUG_ON(MAX_PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
+	return ptlock_ptr(virt_to_ptdesc(pte));
+}
+
  static inline bool ptlock_init(struct ptdesc *ptdesc)
  {
  	/*
@@ -2893,6 +2900,10 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
  {
  	return &mm->page_table_lock;
  }
+static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
+{
+	return &mm->page_table_lock;
+}
  static inline void ptlock_cache_init(void) {}
  static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
  static inline void ptlock_free(struct ptdesc *ptdesc) {}
-- 
2.45.2


-- 
Cheers,

David / dhildenb


