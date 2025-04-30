Return-Path: <stable+bounces-139226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C19AA5741
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F091BA21C9
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FA82D0AB7;
	Wed, 30 Apr 2025 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFXT0tN6"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25EE2C2593
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048364; cv=none; b=u7b6IDTaZPmR7flxv7uuY2knGKMgUOrw3jB+pcKFcTHQGU+l8d4ZI/2RzHsPPw96tCC5KzsqfloeUeVvRAu3hu2gI4OzKr3VXBAvir5hicQFrmQb75vYAqg4wbtT8MDSftKsVtKtTliuOOdOuGJJVUPwvXZyP/ruYEfo3NE7L5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048364; c=relaxed/simple;
	bh=IdoeiYkTyB736+q8Oz0UQ9zz2bEVa3PJ4UzoyInD/ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAOzTcYqXaIFMfgTe5juG52lBTk4Z1mhLWl6AKmp3tvHgXtOxlaHuK8bJPqKo+Ll9Ioe8JP+KJepp1cPvPxTujWAn6a7g6w4HTnJh2fIvwXu4WAzwOdChyRq0qbJmPvpuMXQKeYPlRqoIjVMtObX+PH/j9o2uq1T0ekbCcpmFuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFXT0tN6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746048360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P0hqLgkuFwczFuWQejRvpFmQgCbvdtkrt3GHoFfacwg=;
	b=YFXT0tN6n3mL3Es965+2c8yb7Z0MZSMAXaDCsf7R66uZmEujCHEhatchNPRtoUbEmr1qGt
	O3A/GSOZsmpyGVr5I1E6I+m0eXS5k9+kCpNe8Hu5EYt7sw4KjulUEoEO8mfecQ8U+fIybf
	XYtBv1mSwyFveR0Bv/VKibhLvPlM1oc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-DcpIFWaUOiyWmy6lmPcNaQ-1; Wed, 30 Apr 2025 17:25:59 -0400
X-MC-Unique: DcpIFWaUOiyWmy6lmPcNaQ-1
X-Mimecast-MFC-AGG-ID: DcpIFWaUOiyWmy6lmPcNaQ_1746048358
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d007b2c79so1516665e9.2
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048358; x=1746653158;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P0hqLgkuFwczFuWQejRvpFmQgCbvdtkrt3GHoFfacwg=;
        b=hXDKqOFSphi+Bk0cIxw+GuzaVxUksHuPwevNnqfZ+a7WxTlxNkbX1Qnnd8FMVf1eUA
         zE485uWFtfG8FJ8snitnV87Rf+zpNfMku4NEH2pTMTpn2e2E9JXjK/LknGDx4AkMsM8K
         FexMeHZkO7sV/0JTC9fKGa2Dw+pq3cn8UtDsBINTyP35z0Hd/ZOajh7GTc4toHCBW5x2
         Ve0i0THqBHPDZlDKTDWn8TZn+77On4pS/3depY6GHGcOEcpHNwZh7F9NAEi6BZdhPPWr
         YhtjbyAdEDr2ObF+UGijONi3Ggs0Xz5c9LyRcKPcUVb7a5l496FmtslV8ZfIK2ZhBoKr
         WVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJV5dfpmIa2uONIw4FKr+zk+GxKS79l5fcOl+UDdTkHrmzKPyX8O0bWO0ZqvmniCkbNRjyt4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtcGrpeCWrQY9jKk2ACevbQ1wrWEJyUU7OtQ1qxnT/c86j6nwm
	L1LvOGY/XUVP7CzF37Z7Fe6RkX3gOmT6AOvGkPjuNE52ile6qWCy51gT0nzBEWfvtBQLangk2nK
	qY9pWi6sTH511n2+5cnSvKIhzGanw152PQ3pDUCGHKf8CH9ZWmE8dyg==
X-Gm-Gg: ASbGncstFx/cPlhaAQY2n4EfJcwKVYoU+rmfA3mTJJtWsQ2UdIhD1jRWJqIwWR6+rxs
	LqiOM0T40WXZ5tTHKs825VhIMs+q/EqaRgMKK7nQYTLz6p0CwmXbgsBjw30jCdIyCm2JRJsIVJS
	BvBz8lmaeoLCf0krrnpdo6rpEnw6d3vF+fCgzZugzXQ5YC8sZ1lCJTtl+b7MmZF+4I8wtxghLeg
	w+QhsBGryDQ4dUXSe3a5vPd83C5rl+5vL/6eMr9BAz9Hz/yMyM1IjU7gCj3VT3s3113cNnKgtDA
	Ytw51yPwBBY0dUl2tVriklTCGAeZOifogsJnHpUDzQ2NL42zjuA+HBFkbwh40OI9zK+lwrdNow3
	lnlAEA3ibxjrNd/KdwdJe37xg9LYilY1b9f1RFNg=
X-Received: by 2002:a05:6000:40c9:b0:39f:fd4:aec7 with SMTP id ffacd0b85a97d-3a08f752673mr4236866f8f.7.1746048358044;
        Wed, 30 Apr 2025 14:25:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeTLR8opCStfNUraDLVuL8xHwKHLe9iq+teCwCB6RPSb4S+15g+nH1pqP6wPQLvtkzN+P+Lw==
X-Received: by 2002:a05:6000:40c9:b0:39f:fd4:aec7 with SMTP id ffacd0b85a97d-3a08f752673mr4236857f8f.7.1746048357703;
        Wed, 30 Apr 2025 14:25:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:a500:7f54:d66b:cf40:8ee9? (p200300cbc745a5007f54d66bcf408ee9.dip0.t-ipconnect.de. [2003:cb:c745:a500:7f54:d66b:cf40:8ee9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e46869sm18034585f8f.72.2025.04.30.14.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 14:25:57 -0700 (PDT)
Message-ID: <91c4e7e6-e4c2-4ff0-8b13-7b3ff138e98e@redhat.com>
Date: Wed, 30 Apr 2025 23:25:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: Fix folio_pte_batch() overcount with zero PTEs
To: =?UTF-8?Q?Petr_Van=C4=9Bk?= <arkamar@atlas.cz>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20250429142237.22138-1-arkamar@atlas.cz>
 <20250429142237.22138-2-arkamar@atlas.cz>
 <d53fd549-887f-4220-b0d1-ebc336eecb9f@redhat.com>
 <2025429144547-aBDmGzJBQc9RMBj--arkamar@atlas.cz>
 <ef317615-3e26-4641-8141-4d3913ced47f@redhat.com>
 <b6613b71-3eb9-4348-9031-c1dd172b9814@redhat.com>
 <2025429183321-aBEbcQQY3WX6dsNI-arkamar@atlas.cz>
 <1df577bb-eaba-4e34-9050-309ee1c7dc57@redhat.com>
 <202543011526-aBIO5nq6Olsmq2E--arkamar@atlas.cz>
 <9c412f4f-3bdf-43c0-a3cd-7ce52233f4e5@redhat.com>
 <202543016037-aBJJJdupFVd_6FTX-arkamar@atlas.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <202543016037-aBJJJdupFVd_6FTX-arkamar@atlas.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.04.25 18:00, Petr Vaněk wrote:
> On Wed, Apr 30, 2025 at 04:37:21PM +0200, David Hildenbrand wrote:
>> On 30.04.25 13:52, Petr Vaněk wrote:
>>> On Tue, Apr 29, 2025 at 08:56:03PM +0200, David Hildenbrand wrote:
>>>> On 29.04.25 20:33, Petr Vaněk wrote:
>>>>> On Tue, Apr 29, 2025 at 05:45:53PM +0200, David Hildenbrand wrote:
>>>>>> On 29.04.25 16:52, David Hildenbrand wrote:
>>>>>>> On 29.04.25 16:45, Petr Vaněk wrote:
>>>>>>>> On Tue, Apr 29, 2025 at 04:29:30PM +0200, David Hildenbrand wrote:
>>>>>>>>> On 29.04.25 16:22, Petr Vaněk wrote:
>>>>>>>>>> folio_pte_batch() could overcount the number of contiguous PTEs when
>>>>>>>>>> pte_advance_pfn() returns a zero-valued PTE and the following PTE in
>>>>>>>>>> memory also happens to be zero. The loop doesn't break in such a case
>>>>>>>>>> because pte_same() returns true, and the batch size is advanced by one
>>>>>>>>>> more than it should be.
>>>>>>>>>>
>>>>>>>>>> To fix this, bail out early if a non-present PTE is encountered,
>>>>>>>>>> preventing the invalid comparison.
>>>>>>>>>>
>>>>>>>>>> This issue started to appear after commit 10ebac4f95e7 ("mm/memory:
>>>>>>>>>> optimize unmap/zap with PTE-mapped THP") and was discovered via git
>>>>>>>>>> bisect.
>>>>>>>>>>
>>>>>>>>>> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
>>>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>>>> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
>>>>>>>>>> ---
>>>>>>>>>>        mm/internal.h | 2 ++
>>>>>>>>>>        1 file changed, 2 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>>>>>>>> index e9695baa5922..c181fe2bac9d 100644
>>>>>>>>>> --- a/mm/internal.h
>>>>>>>>>> +++ b/mm/internal.h
>>>>>>>>>> @@ -279,6 +279,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>>>>>>>>>>        			dirty = !!pte_dirty(pte);
>>>>>>>>>>        		pte = __pte_batch_clear_ignored(pte, flags);
>>>>>>>>>>        
>>>>>>>>>> +		if (!pte_present(pte))
>>>>>>>>>> +			break;
>>>>>>>>>>        		if (!pte_same(pte, expected_pte))
>>>>>>>>>>        			break;
>>>>>>>>>
>>>>>>>>> How could pte_same() suddenly match on a present and non-present PTE.
>>>>>>>>
>>>>>>>> In the problematic case pte.pte == 0 and expected_pte.pte == 0 as well.
>>>>>>>> pte_same() returns a.pte == b.pte -> 0 == 0. Both are non-present PTEs.
>>>>>>>
>>>>>>> Observe that folio_pte_batch() was called *with a present pte*.
>>>>>>>
>>>>>>> do_zap_pte_range()
>>>>>>> 	if (pte_present(ptent))
>>>>>>> 		zap_present_ptes()
>>>>>>> 			folio_pte_batch()
>>>>>>>
>>>>>>> How can we end up with an expected_pte that is !present, if it is based
>>>>>>> on the provided pte that *is present* and we only used pte_advance_pfn()
>>>>>>> to advance the pfn?
>>>>>>
>>>>>> I've been staring at the code for too long and don't see the issue.
>>>>>>
>>>>>> We even have
>>>>>>
>>>>>> VM_WARN_ON_FOLIO(!pte_present(pte), folio);
>>>>>>
>>>>>> So the initial pteval we got is present.
>>>>>>
>>>>>> I don't see how
>>>>>>
>>>>>> 	nr = pte_batch_hint(start_ptep, pte);
>>>>>> 	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
>>>>>>
>>>>>> would suddenly result in !pte_present(expected_pte).
>>>>>
>>>>> The issue is not happening in __pte_batch_clear_ignored but later in
>>>>> following line:
>>>>>
>>>>>      expected_pte = pte_advance_pfn(expected_pte, nr);
>>>>>
>>>>> The issue seems to be in __pte function which converts PTE value to
>>>>> pte_t in pte_advance_pfn, because warnings disappears when I change the
>>>>> line to
>>>>>
>>>>>      expected_pte = (pte_t){ .pte = pte_val(expected_pte) + (nr << PFN_PTE_SHIFT) };
>>>>>
>>>>> The kernel probably uses __pte function from
>>>>> arch/x86/include/asm/paravirt.h because it is configured with
>>>>> CONFIG_PARAVIRT=y:
>>>>>
>>>>>      static inline pte_t __pte(pteval_t val)
>>>>>      {
>>>>>      	return (pte_t) { PVOP_ALT_CALLEE1(pteval_t, mmu.make_pte, val,
>>>>>      					  "mov %%rdi, %%rax", ALT_NOT_XEN) };
>>>>>      }
>>>>>
>>>>> I guess it might cause this weird magic, but I need more time to
>>>>> understand what it does :)
>>>
>>> I understand it slightly more. __pte() uses xen_make_pte(), which calls
>>> pte_pfn_to_mfn(), however, mfn for this pfn contains INVALID_P2M_ENTRY
>>> value, therefore the pte_pfn_to_mfn() returns 0, see [1].
>>>
>>> I guess that the mfn was invalidated by xen-balloon driver?
>>>
>>> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/xen/mmu_pv.c?h=v6.15-rc4#n408
>>>
>>>> What XEN does with basic primitives that convert between pteval and
>>>> pte_t is beyond horrible.
>>>>
>>>> How come set_ptes() that uses pte_next_pfn()->pte_advance_pfn() does not
>>>> run into this?
>>>
>>> I don't know, but I guess it is somehow related to pfn->mfn translation.
>>>
>>>> Is it only a problem if we exceed a certain pfn?
>>>
>>> No, it is a problem if the corresponding mft to given pfn is invalid.
>>>
>>> I am not sure if my original patch is a good fix.
>>
>> No :)
>>
>> Maybe it would be
>>> better to have some sort of native_pte_advance_pfn() which will use
>>> native_make_pte() rather than __pte(). Or do you think the issue is in
>>> Xen part?
>>
>> I think what's happening is that -- under XEN only -- we might get garbage when
>> calling pte_advance_pfn() and the next PFN would no longer fall into the folio. And
>> the current code cannot deal with that XEN garbage.
>>
>> But still not 100% sure.
>>
>> The following is completely untested, could you give that a try?
> 
> Yes, it solves the issue for me.

Cool!

> 
> However, maybe it would be better to solve it with the following patch.
> The pte_pfn_to_mfn() actually returns the same value for non-present
> PTEs. I suggest to return original PTE if the mfn is INVALID_P2M_ENTRY,
> rather than empty non-present PTE, but the _PAGE_PRESENT bit will be set
> to zero. Thus, we will not loose information about original pfn but it
> will be clear that the page is not present.
> 
>  From e84781f9ec4fb7275d5e7629cf7e222466caf759 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
> Date: Wed, 30 Apr 2025 17:08:41 +0200
> Subject: [PATCH] x86/mm: Reset pte _PAGE_PRESENT bit for invalid mft
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
> ---
>   arch/x86/xen/mmu_pv.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index 38971c6dcd4b..92a6a9af0c65 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -392,28 +392,25 @@ static pteval_t pte_mfn_to_pfn(pteval_t val)
>   static pteval_t pte_pfn_to_mfn(pteval_t val)
>   {
>   	if (val & _PAGE_PRESENT) {
>   		unsigned long pfn = (val & PTE_PFN_MASK) >> PAGE_SHIFT;
>   		pteval_t flags = val & PTE_FLAGS_MASK;
>   		unsigned long mfn;
>   
>   		mfn = __pfn_to_mfn(pfn);
>   
>   		/*
> -		 * If there's no mfn for the pfn, then just create an
> -		 * empty non-present pte.  Unfortunately this loses
> -		 * information about the original pfn, so
> -		 * pte_mfn_to_pfn is asymmetric.
> +		 * If there's no mfn for the pfn, then just reset present pte bit.
>   		 */
>   		if (unlikely(mfn == INVALID_P2M_ENTRY)) {
> -			mfn = 0;
> -			flags = 0;
> +			mfn = pfn;
> +			flags &= ~_PAGE_PRESENT;
>   		} else
>   			mfn &= ~(FOREIGN_FRAME_BIT | IDENTITY_FRAME_BIT);
>   		val = ((pteval_t)mfn << PAGE_SHIFT) | flags;
>   	}
>   
>   	return val;
>   }
>   
>   __visible pteval_t xen_pte_val(pte_t pte)
>   {

That might do as well.


I assume the following would also work? (removing the early ==1 check)

It has the general benefit of removing the pte_pfn() call
from the loop body, which is why I like that fix. (almost looks like a cleanup)


 From 75948778b586d4759a480bf412fd4682067b12ea Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 30 Apr 2025 16:35:12 +0200
Subject: [PATCH] tmp

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/internal.h | 27 +++++++++++----------------
  1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index e9695baa59226..25a29872c634b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -248,11 +248,9 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
  		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
  		bool *any_writable, bool *any_young, bool *any_dirty)
  {
-	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
-	const pte_t *end_ptep = start_ptep + max_nr;
  	pte_t expected_pte, *ptep;
  	bool writable, young, dirty;
-	int nr;
+	int nr, cur_nr;
  
  	if (any_writable)
  		*any_writable = false;
@@ -265,11 +263,15 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
  	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
  	VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) != folio, folio);
  
+	/* Limit max_nr to the actual remaining PFNs in the folio we could batch. */
+	max_nr = min_t(unsigned long, max_nr,
+		       folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte));
+
  	nr = pte_batch_hint(start_ptep, pte);
  	expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);
  	ptep = start_ptep + nr;
  
-	while (ptep < end_ptep) {
+	while (nr < max_nr) {
  		pte = ptep_get(ptep);
  		if (any_writable)
  			writable = !!pte_write(pte);
@@ -282,14 +284,6 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
  		if (!pte_same(pte, expected_pte))
  			break;
  
-		/*
-		 * Stop immediately once we reached the end of the folio. In
-		 * corner cases the next PFN might fall into a different
-		 * folio.
-		 */
-		if (pte_pfn(pte) >= folio_end_pfn)
-			break;
-
  		if (any_writable)
  			*any_writable |= writable;
  		if (any_young)
@@ -297,12 +291,13 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
  		if (any_dirty)
  			*any_dirty |= dirty;
  
-		nr = pte_batch_hint(ptep, pte);
-		expected_pte = pte_advance_pfn(expected_pte, nr);
-		ptep += nr;
+		cur_nr = pte_batch_hint(ptep, pte);
+		expected_pte = pte_advance_pfn(expected_pte, cur_nr);
+		ptep += cur_nr;
+		nr += cur_nr;
  	}
  
-	return min(ptep - start_ptep, max_nr);
+	return min(nr, max_nr);
  }
  
  /**
-- 
2.49.0


-- 
Cheers,

David / dhildenb


