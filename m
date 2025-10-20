Return-Path: <stable+bounces-188125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E56ECBF1B9F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6888534D24D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 14:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF41C320380;
	Mon, 20 Oct 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2hqfhWT"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1DD31DD82
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969254; cv=none; b=Gu8LQkZZLmKWlmlnetKos/Ct4WRN9nb3yqqDsttOKbvbpRFnwFdOPEe4E5K2/hSK/On06QXGzZm6eMM4N795uBwapsaHqvU5eXXm+9DkbLOVvtzh4fWx+f2CPCv9z6k08cLb8c+o7hu5QiDfJTPXpk3ZR6fm+NRk62JMshRpvA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969254; c=relaxed/simple;
	bh=1sZXfQdrxQCKHpKxc5F96Lf9VMLPvAMvMgkDev/v+qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/+RmiSwxz7BQBaWsWyBeq/Dx8w49VbZWTCXJHQz5rwfi0+90JmNZK5R+QBH4ylvtY8giQv077A6lzNfIQNtDuKyLUwt7CLM5XFiGqLZEF5TR0MDEaegPCx7DMNZKptnFOLnMXdkl9Y2WCmNIADwa/ji5sQEevPDAPjjjA+vyJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2hqfhWT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760969251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bDRwF8i9GvZpeQJfAlGt77aYUSNIWfGo/XsoAzNEum0=;
	b=T2hqfhWTe8HiaJOgUwd2iSKHv/x/vVFJeFvn6LdFp8HNO/buSxt84YFA6pnYDtjHYsLmwB
	P7sxxSh5AcERPMUL8Xx5CtdY3xQIR0xHebvsTyf063ugtQNLFnXCs7BfV2MH7KyI5QBTzE
	IV0ocuYhFvzJHF6LtwhA5GkghumuBPM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-OGBAGY-sMH-RxuR7mUTh-g-1; Mon, 20 Oct 2025 10:07:29 -0400
X-MC-Unique: OGBAGY-sMH-RxuR7mUTh-g-1
X-Mimecast-MFC-AGG-ID: OGBAGY-sMH-RxuR7mUTh-g_1760969248
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso51909945e9.2
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 07:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969248; x=1761574048;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDRwF8i9GvZpeQJfAlGt77aYUSNIWfGo/XsoAzNEum0=;
        b=eGahTnmh2M/BWd4Y9StS7GMp9fUaPrcUjZ3FiM8/YHRQxzJb6LrhbewHjwauyVBk6L
         DM891k3WrCWYlReA9fn3O+d3dsVE3ehO+ZG37LN0H2NIdu2YS7wpeZucDGiswDBVNU5u
         I0WvWq/9ZlJi3Kv+lZJv3bCIfWCQk4XToE7cYfhWJYOxsHZ2LYMuq7nx+6wxFsq9O2QE
         qHyUKVhzVSIBd3DtQpZs5XhQIBIdP3/d8EEnO+gHojYA8TSlmUQ5RNO1v4tUFpFZWd4D
         xaXzHNL3IDz7Qx4Ks2huro6Ydp/6Ackzg6D0FnYOlbVsUhOe7exeCOslCxR64Z6+o+8X
         /IzA==
X-Forwarded-Encrypted: i=1; AJvYcCVMyjoHdqKTVzQjShpd77EPRns1DHkgjbEbcwfpmFbR2fCV3sXVI1lxMsp82i0MaycXRhZ/1HM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz95kf/JzamcJL/UkgRZ1BGmOZHv90RO4A8xmnkkTIMGZLefjZE
	tibhH6ZygKByWIlN0fdzDNCcSABdx+1MUnyNEfK+8dRjbOsQGE60/oqzCalxvVDGgARnBGIm2QV
	kwbfeusHSzBp44fga+gN6e95t2sRbSKsKUw/7kMVasDqVe0kj4Plyi0jnFg==
X-Gm-Gg: ASbGnct+9mOgzjOG2fVC1yKMOzCW6zQTeVQwqY0tpUNt8k3fcrYhl/Ma4LyVpVqgQJ7
	tQdDkeEJyGrDKmIExLX2UvAuFiIu8XncICPkFykaPkqfb+wjdpbTclacISsrQEkfkyGKo06/7fw
	DDMYvshL0FmeSYj42wHGbHlGrjmXsCkz84kjwk9Cytoz3s9K+MufBIgrNaQKFxkAzg+g+74Vdjz
	drXUyqoZIrpV9TdG/6N2NdT3T8bSBzeLGtnzg4CqKR+edl8EKv5tI24hpJX6BLMrAUZOnGwa5mP
	OvQN9+uhgRgnWAqW4kQf5qSFFagDeVEaQ16rKriSmyYmMkKdNb6EVQmlOXgY9U8HSc/XvAIGDjk
	W9HcHC+NXURck3P0Z7tvpx35lOeH2lfRxO19TYDOy2XhtPVlu5BuMktOkpOLkhSsaFywTAQI1bM
	EUU2utTi6ENSorbadVxBN/9F6Abqc=
X-Received: by 2002:a05:600c:4fd4:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-4711791c5dfmr110039125e9.30.1760969247934;
        Mon, 20 Oct 2025 07:07:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+BFmRlh4Swqvguf+7z76JRsLA1ogRx9ZpcgLz6sWvvE9fPmA/6t7XAcJOAeAXmY20mtuNzw==
X-Received: by 2002:a05:600c:4fd4:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-4711791c5dfmr110038835e9.30.1760969247508;
        Mon, 20 Oct 2025 07:07:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b55sm151911025e9.6.2025.10.20.07.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:07:27 -0700 (PDT)
Message-ID: <fe3cc258-6039-4061-8509-8e972127c211@redhat.com>
Date: Mon, 20 Oct 2025 16:07:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] Fixing bad pmd due to a race condition between
 change_prot_numa() and THP migration in pre-6.5 kernels.
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, stable@vger.kernel.org
References: <20250921232709.1608699-1-harry.yoo@oracle.com>
 <b41ea29e-6b48-4f64-859c-73be095453ae@redhat.com> <aNKIVVPLlxdX2Slj@hyeyoo>
 <6e4f6a37-2449-4089-8b3d-234ba86878e2@redhat.com> <aNPb3qVCZTf2xMkN@hyeyoo>
 <9b05b974-7478-4c99-9c4f-6593e0fd4f93@redhat.com> <aN6HMzXM4cL6Yf4A@hyeyoo>
 <9f3e4031-9e13-4f8b-a7fb-8db4166c47f0@redhat.com> <aPY4STwIIRxvk3oH@hyeyoo>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <aPY4STwIIRxvk3oH@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>>>>>>> It'd be more robust to do something like:
>>>>>>
>>>>>> That's also what I had in mind. But all this lockless stuff makes me a bit
>>>>>> nervous :)
>>>>>
>>>>> Yeah the code is not very straightforward... :/
>>>>>
>>>>> But technically the diff that I pasted here should be enough to fix
>>>>> this... or do you have any alternative approach in mind?
>>>>
>>>> Hopefully, I'm not convinced this code is not buggy, but at least regarding
>>>> concurrent migration it should be fine with that.
>>>
>>> I've been thinking about this...
>>>
>>> Actually, it'll make more sense to open-code what pte_map_offset_lock()
>>> does in the mainline:
>>>
>>> 1. do not remove the "bad pte" checks, because pte_offset_map() in pre-6.5
>>>      kernels doesn't do the check for us unlike the mainline.
>>> 2. check is_swap_pmd(), pmd_trans_huge(), pmd_devmap() without ptl, but
>>>      atomically.
>>> 3. after acquiring ptl in change_pte_range(), check if pmd has changed
>>>      since step 1 and 2. if yes, retry (like mainline). if no, we're all good.
>>>
>>> What do you think?
> 
> Apologies for late reply...
> 
>> Only for -stable, right?
> 
> Right!
> 
>> Does not sound too wrong for me, but I would have
>> to take a closer look at the end result!
> 
> FYI I'll test these two patches and see if they survive for a week,
> and then submit them to -stable. Thanks.
> 
> The first patch is also going to be backported since change_pte_range()
> cannot return negative values without it.

That sound reasonable to me!

-- 
Cheers

David / dhildenb


