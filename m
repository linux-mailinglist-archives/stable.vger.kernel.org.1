Return-Path: <stable+bounces-64675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B990942221
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 23:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A1D1B258D3
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 21:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD7818E028;
	Tue, 30 Jul 2024 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHPeOLUI"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EE918CC16
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722374380; cv=none; b=KPdkldXon0YmCH/J5AFalKRdFfzZOnmhNcdWrbL3sj+ftbGkGJdY37hNocTMNL8w4j6uLkJf20eg+rbdmae/UbnakbNU0/f7y69MR4kn2jJrURamOm4yAReIGJRpzm+ir2SAALAphk64xy6QM41rRWObdXCXGvaSnaUnwFiGSOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722374380; c=relaxed/simple;
	bh=4LF/D0DfeuxRHOITwtmYNI1LWDVraPm1XSsnlnZ/6eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqfoijzCz/mG5WxKSjk7jZ5T6+yuSiRWG0kCXziVj9vi58SpKWFPomvQf510U/waZmewqngVKSEBOFv1g4br1yV7CpPptinXSKw/4gwWk9YMOI/NtLpeouyp+AnWjP/6MVbgvOBxZwF4mPKHkRagYb9eQIJWZxfF1iXUPeNIilU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PHPeOLUI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722374377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=URA8y1RcRCZ1Ayj47MpTEZ208uMuNs4kA4WTu7Sh2AE=;
	b=PHPeOLUII9I+acX/pNSNDeWCAS3Bi+vVU5oGI684HycPGtKkEpileq2QVKI8pHDkDcEPLl
	LNttTYKTjNdjlydAYmX7UZiqIpPJvyKhwycL1TxYL9SF0+kk2mkTsp9d2PBN7c/zDksb92
	aMWBwXzM2/5Vm9CXReomnfhEX/SKnKQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-ZC-7dQqaMP-1sACThVKz5g-1; Tue, 30 Jul 2024 17:19:30 -0400
X-MC-Unique: ZC-7dQqaMP-1sACThVKz5g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4281b7196bbso23081375e9.0
        for <stable@vger.kernel.org>; Tue, 30 Jul 2024 14:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722374370; x=1722979170;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=URA8y1RcRCZ1Ayj47MpTEZ208uMuNs4kA4WTu7Sh2AE=;
        b=U57rGV/wTpgFQ8bKEECvOdkuy6CLvbX6+6FThOOUXXakT2uQ7GAjdG1yHgm6zUeMyB
         bhYuF6eWBvPlnN86MO/VeKPNOK95c9k2/SLj2EuYIQJRcINoi7n7HjGMjj/zXwVWoND2
         Y6Mwe0EjIOeK+i9L9G8K2+tNb+sJ1GVtrNZqvdrE84HEbbJsPlqHRvAdYZs+YE4oB/Oa
         LBLC+Pez+TLvzK8m4ycUDOI9dkfmPj0yRCV7f1keuu7YJpTUR+2k8tmXTv45vymEw0Xe
         Ik2IAf1WDsjYINX500Co9R1L553aiwPghHdyKS01ey/LDU8I2UAiYhTWSWJXRnH8/lon
         8t7g==
X-Forwarded-Encrypted: i=1; AJvYcCWLzkrfZ5YeA8Q8S+78Vscu8oIkmSSErDQcysaG2dUF4EYb6hnZkUHe/FE6tnK0ddnDghIXuNKOCFMLzDWXtDF3hSyIn+NK
X-Gm-Message-State: AOJu0Yx9+BN4o5pw69G3sWQZAXLFrMiEh4lTB2ZXU/48JoqNVQrJ5yD3
	2oHFKN4VzJoxwXq605gC+S8tWbXQiMdXrCHChvjQETz/a8jBtFyea4qm/ZQmvVgRNVI+4w5Pk6y
	UwvbGYXoLQISVWgyk04jumvJDro2DA4+YxY76spcmGs46cx5rxluBvw==
X-Received: by 2002:a05:600c:1550:b0:426:5e8e:410a with SMTP id 5b1f17b1804b1-42811dd7a57mr84363735e9.24.1722374369710;
        Tue, 30 Jul 2024 14:19:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmHtZuDi/lqf35W1WSyS4+8hGZXWl3pM1BZxyElWRmesjHG2v45gayHNvfBJaztXUcCsyyow==
X-Received: by 2002:a05:600c:1550:b0:426:5e8e:410a with SMTP id 5b1f17b1804b1-42811dd7a57mr84363615e9.24.1722374369158;
        Tue, 30 Jul 2024 14:19:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:4e00:31ad:5274:e21c:b59? (p200300cbc7064e0031ad5274e21c0b59.dip0.t-ipconnect.de. [2003:cb:c706:4e00:31ad:5274:e21c:b59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281fb6369esm66618535e9.48.2024.07.30.14.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 14:19:28 -0700 (PDT)
Message-ID: <1c527333-e837-4a40-afa8-eb8728332055@redhat.com>
Date: Tue, 30 Jul 2024 23:19:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: James Houghton <jthoughton@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Oscar Salvador <osalvador@suse.de>,
 Muchun Song <muchun.song@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20240730200341.1642904-1-david@redhat.com>
 <CADrL8HXRCNFzmg67p=j0_0Y_NAFo5rUDmvnr40F5HGAsQMvbnw@mail.gmail.com>
 <3f6c97b5-ccd8-4226-a9ac-78d555b0d048@redhat.com>
 <b74fcedb-60c5-4fd3-bcc7-74959e12c38d@redhat.com>
 <CADrL8HUvxp8TX31SsVaQg_HBgTWMDUKWxOJqCp-G_c9Lqz9n+g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CADrL8HUvxp8TX31SsVaQg_HBgTWMDUKWxOJqCp-G_c9Lqz9n+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.07.24 23:17, James Houghton wrote:
> On Tue, Jul 30, 2024 at 2:07 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 30.07.24 23:00, David Hildenbrand wrote:
>>> On 30.07.24 22:43, James Houghton wrote:
>>>> On Tue, Jul 30, 2024 at 1:03 PM David Hildenbrand <david@redhat.com> wrote:
>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>> index b100df8cb5857..1b1f40ff00b7d 100644
>>>>> --- a/include/linux/mm.h
>>>>> +++ b/include/linux/mm.h
>>>>> @@ -2926,6 +2926,12 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>>>>>            return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
>>>>>     }
>>>>>
>>>>> +static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
>>>>> +{
>>>>> +       BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
>>>>> +       return ptlock_ptr(virt_to_ptdesc(pte));
>>>>
>>>> Hi David,
>>>>
>>>
>>> Hi!
>>>
>>>> Small question: ptep_lockptr() does not handle the case where the size
>>>> of the PTE table is larger than PAGE_SIZE, but pmd_lockptr() does.
>>>
>>> I thought I convinced myself that leaf page tables are always single
>>> pages and had a comment in v1.
>>>
>>> But now I have to double-check again, and staring at
>>> pagetable_pte_ctor() callers I am left confused.
>>>
>>> It certainly sounds more future proof to just align the pointer down to
>>> the start of the PTE table like pmd_lockptr() would.
>>>
>>>> IIUC, for pte_lockptr() and ptep_lockptr() to return the same result
>>>> in this case, ptep_lockptr() should be doing the masking that
>>>> pmd_lockptr() is doing. Are you sure that you don't need to be doing
>>>> it? (Or maybe I am misunderstanding something.)
>>>
>>> It's a valid concern even if it would not be required. But I'm afraid I
>>> won't dig into the details and simply do the alignment in a v3.
>>
>> To be precise, the following on top:
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 1b1f40ff00b7d..f6c7fe8f5746f 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2926,10 +2926,22 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>>           return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
>>    }
>>
>> -static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
>> +static inline struct page *ptep_pgtable_page(pte_t *pte)
>>    {
>> +       unsigned long mask = ~(PTRS_PER_PTE * sizeof(pte_t) - 1);
>> +
>>           BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
>> -       return ptlock_ptr(virt_to_ptdesc(pte));
>> +       return virt_to_page((void *)((unsigned long)pte & mask));
>> +}
>> +
>> +static inline struct ptdesc *ptep_ptdesc(pte_t *pte)
>> +{
>> +       return page_ptdesc(ptep_pgtable_page(pte));
>> +}
>> +
>> +static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
>> +{
>> +       return ptlock_ptr(ptep_ptdesc(pte));
>>    }
> 
> Thanks! That looks right to me. Feel free to add
> 
> Reviewed-by: James Houghton <jthoughton@google.com>

Thanks for the review, will send a v3 tomorrow after having wasted more 
valuable life time setting up the ARM environment again ... :)

-- 
Cheers,

David / dhildenb


