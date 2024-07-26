Return-Path: <stable+bounces-61835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE893CF34
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 10:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B850BB225E9
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 08:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8854F176ACE;
	Fri, 26 Jul 2024 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSKcjBF0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF18524B4
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981094; cv=none; b=qavA/+V6s4F7oU48d+0N0WTsfPEgN8MPznIMZoxG7ORi9LnCk4b3VxCF7ySegnNz7lRNHa9BU3bwl4BBxcPn6HM/j3I2ZKKe/XTAgbDgluCYusVmbs0EP04lWyVlITyRM32coYd727pNeWdHaA1A8kM0yvMbAjfGqbyiKkWU5LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981094; c=relaxed/simple;
	bh=yUuFltt45FQtFzuK1w8hJRFb23L+VeB3qRdS/ehuEqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mi533lTnP0xNlpSmBuKZ0Nq7Aw9/vRr3iyOGG+Vhn1ijcDBSUDXc30eUO4X1vYt/dP1pChR0vAbv1pDa5S+hgZ03ERo+rqf2qFkflQ+MvNWG0QOcXGPUhb/WIwhmZyS6Z+YKKrCxXNXjW84orN9MjGEZe7c7UT16kcezndDKJxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSKcjBF0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721981091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KeiNTJdmCJ20vhBFNxxCabsImvLk+JzwPPZxTwy4a88=;
	b=gSKcjBF0e5OYsu1IiwfRA8GU6hnYPaxF4At3rSrjxuwkA9sth+IZQdgEm8yJB6AT3DGFkl
	QxYS1eFbA4A51eYfNGyEQ03I50/smuWbkjoW02gOjn4DExZBAcedMDoxla1HzHXHOzl3sU
	InQydC5cCEL6C30kEeAgTV5/EKrUK9E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-Sox6PxmkNzmH-PSnGT2C3A-1; Fri, 26 Jul 2024 04:04:49 -0400
X-MC-Unique: Sox6PxmkNzmH-PSnGT2C3A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280d8e685eso2545525e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jul 2024 01:04:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721981088; x=1722585888;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeiNTJdmCJ20vhBFNxxCabsImvLk+JzwPPZxTwy4a88=;
        b=EgmUBjGnlchtZXCEAhS39zQ7vPFVawv4DmgWeJgMDWKYssod6sC6uzIstf3vkNFfLm
         /av0l68ElYgMKX6CyTzAMh61tE8LzttGbtHB4JgGsLYyj6Wiei+Jn8MkmtvWrZtAmHP2
         BnHY+Wdcba+GvcEle6nQRIqQ9e/vnGtaTcGifLiSxGoMsTl/c2/leGnDSbF5doFvdwN6
         NcvgWHaNcDjl2W6meFKWaIUygim5Y3guUG00B9c1H4bF0Cm1SIvjWA1wZWtLThX4QFB/
         IE8kKggxQxVveFYdqIZ1q6vSecnxZJ6Cl5WjrmpVLokHj7MUFkG6MumI6d9BXg0L3jPx
         xfNA==
X-Forwarded-Encrypted: i=1; AJvYcCV6GYd0j9tznzNf2vzz03MwvVZ6SjIkvEJ+T2wuQ/P4n0TKBUyiiIdbON5l6qp+9ogrmUbeSyVB/6NO6pX+F/3i95NrN+LE
X-Gm-Message-State: AOJu0YzN8lCzQ7We0eqgrO9cJteTzCiUwcEkrJQFrlfkVoUEaHAEV/TV
	SSPUsdSSHWSjIQtzBK+LphryXWilMeUKxd4XGjve5lnY0qe1TAT2s8e2SXcorQeXZZjeiTP2XiF
	sU0AHf4fjN1jJ3LfOkigfkpS78v2QseVsmRX3G3UGKvtnRXGvgK463w==
X-Received: by 2002:a05:600c:1d92:b0:427:dae6:8416 with SMTP id 5b1f17b1804b1-4280579efcbmr31573485e9.36.1721981088390;
        Fri, 26 Jul 2024 01:04:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkub+jgUxfHcNsWmweJcOhKL/25xmLrvMu2yPzE1IqHOfHep7o/J1rzZaaOTz80NtiwLL27g==
X-Received: by 2002:a05:600c:1d92:b0:427:dae6:8416 with SMTP id 5b1f17b1804b1-4280579efcbmr31573275e9.36.1721981088002;
        Fri, 26 Jul 2024 01:04:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:a600:7ca0:23b3:d48a:97c7? (p200300cbc713a6007ca023b3d48a97c7.dip0.t-ipconnect.de. [2003:cb:c713:a600:7ca0:23b3:d48a:97c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9576sm4396129f8f.31.2024.07.26.01.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 01:04:47 -0700 (PDT)
Message-ID: <17256b99-ab26-4f7b-9100-2fc42b233af2@redhat.com>
Date: Fri, 26 Jul 2024 10:04:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>,
 Oscar Salvador <osalvador@suse.de>, stable@vger.kernel.org
References: <20240725183955.2268884-1-david@redhat.com>
 <20240725183955.2268884-3-david@redhat.com>
 <0067dfe6-b9a6-4e98-9eef-7219299bfe58@linux.alibaba.com>
 <707d8937-d4c8-43b3-bc19-70f0038522a9@linux.alibaba.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <707d8937-d4c8-43b3-bc19-70f0038522a9@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>
>>> +     *
>>> +     * If that does not hold for an architecture, then that architecture
>>> +     * must disable split PT locks such that all *_lockptr() functions
>>> +     * will give us the same result: the per-MM PT lock.
>>> +     */
>>> +    if (huge_page_size(h) < PMD_SIZE)
>>> +        return pte_lockptr(mm, pte);
>>> +    else if (huge_page_size(h) < PUD_SIZE)
>>>            return pmd_lockptr(mm, (pmd_t *) pte);
>>
>> IIUC, as I said above, this change doesn't fix the inconsistent lock for
>> cont-PMD size hugetlb for GUP, and it will also break the lock rule for
>> unmapping/migrating a cont-PMD size hugetlb (use mm->page_table_lock
>> before for cont-PMD size hugetlb before).
> 
> After more thinking, I realized I confused the PMD table with the PMD
> entry. Therefore, using the PMD table's lock is safe for cont-PMD size
> hugetlb. This change looks good to me. Sorry for noise.
> 

Thanks for the review, highly appreciated!

-- 
Cheers,

David / dhildenb


