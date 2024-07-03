Return-Path: <stable+bounces-57912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DCB925F96
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 14:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1825A28D717
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 12:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC47417279B;
	Wed,  3 Jul 2024 12:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDm397Hd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F96215D5B3
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720008172; cv=none; b=QkxK98Urb8tN5tbzR5ZIioXmqVCyKa7IfmQ1xbIHoq52Ozq8+cqX9lD+C2sIHm+2omZz/hisAVnQYvufiXUcBQmbv7krIcIkWw0PkeXFXeaMaOVw9f1+8Ic/NvPl9eRQhL93XjgChxc7bArPATJTzJ7kc2vaL+HTwHQsWt6HFik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720008172; c=relaxed/simple;
	bh=HzJV2Q9dt5L705VZ+67SJTWt72pg/Q35YFrw8iMsp2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDoLfGKZz5qqq3HrnvVejyT7/AM0aD8YMccq9FIBwa+BldeiyBKkfDrUUrx65FvxmEUqqm/DfYd57jqDCdr3vUDqcbY41hsYoezXwH+iufI2VPOgVSs9w86JRgAfY652E1U4d2Rw2M6H8NpCt/8prHR6UWUt5nQo3KvpY1RQTC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDm397Hd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720008169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=k0O3LLiHWeyi64UF8oFRUSFib4DeqAEYS++7+s3iLII=;
	b=KDm397HdhUaZ45emHTVQ1VecoXAMdAUC5FPts3olrsL6qR3Dj9IOhxSDVM4MtwRnQ7Nxxj
	FLCN25crbKj+v1kkrBrXC2KTpx6vWS0jypEQL726MSXZYVaHJgxeGRRdz6zGttnGWczUSA
	hevnpmXfFmURH2BeealepMyuD4BrArQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-9Cz5s26AP9GpxWPt0O9LeA-1; Wed, 03 Jul 2024 08:02:46 -0400
X-MC-Unique: 9Cz5s26AP9GpxWPt0O9LeA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4256c2a2e8dso36881715e9.3
        for <stable@vger.kernel.org>; Wed, 03 Jul 2024 05:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720008164; x=1720612964;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k0O3LLiHWeyi64UF8oFRUSFib4DeqAEYS++7+s3iLII=;
        b=CxhaCY9xNiAWZ2R7M0iRbU6FcFauLzrtyTgJFunkMJRndXcYmXbfdR6mSO/AX5MfkN
         7SxlmnlA11zlhWdYUf/ROnQiqJKBF1HtjmCSvJanvV8mHHknWVTgIPCa1goRCNY0sGJf
         LW18WiaHR/t9CRhFruXI386CQvcdpWmg8Os1pGHFZWhnyCmEA8Fc8fvUGYftmwUgEwSz
         19zdXpv/4qHMnsgXJrSMk+MqP47jCGguFgSMbkveZU5WtsoVUJkI0ULfHJYt2UVmJagg
         3WE58nSxwUDd66d8II90vl/VhTorXwaE3R9I76xJbxriW4s9FGRkM4/eFO8QdzrafUge
         Fo1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjpRmX84WUhhe7ydgnAzhZcj9dqvPNJVnXgVYag7rGbJM+H5koWC9xvNbIyDZdR+lUBFdXCejA9eYPk53ia4y3d0TNtGXz
X-Gm-Message-State: AOJu0YwmI9+JGgWp780LU3IZ7CalYQDNubulF3xO/jW2VuRIa0/Y6FIm
	ilj+JazTlbMUhXPrR61wlg+jOq9xk6/nvx7BQr4M4AAtJJwQ3c3ORNhOJTlpcKtgF9SmVJUvm4g
	8mG6cuHBmoT9vqJTh0F0Tp2IJCyiGAQ3NtOyDqB1TMclHMU0g3ZYUSw==
X-Received: by 2002:a05:600c:4f94:b0:425:7c46:d336 with SMTP id 5b1f17b1804b1-4257c46d499mr74109125e9.17.1720008163840;
        Wed, 03 Jul 2024 05:02:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn/QVvbFcA+I7LoV3kE5ke4kUJVVeZKm9LOWGmHEyI5xG3Y2TmAVwIluyY9UJmrOHK0iuNWg==
X-Received: by 2002:a05:600c:4f94:b0:425:7c46:d336 with SMTP id 5b1f17b1804b1-4257c46d499mr74108845e9.17.1720008163388;
        Wed, 03 Jul 2024 05:02:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:3400:5126:3051:d630:92ee? (p200300cbc709340051263051d63092ee.dip0.t-ipconnect.de. [2003:cb:c709:3400:5126:3051:d630:92ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e0661sm15543793f8f.47.2024.07.03.05.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 05:02:42 -0700 (PDT)
Message-ID: <26efe5f2-0cad-404c-82ca-a556469ba9c7@redhat.com>
Date: Wed, 3 Jul 2024 14:02:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: yangge1116@126.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1719038884-1903-1-git-send-email-yangge1116@126.com>
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
In-Reply-To: <1719038884-1903-1-git-send-email-yangge1116@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.06.24 08:48, yangge1116@126.com wrote:
> From: yangge <yangge1116@126.com>
> 
> If a large number of CMA memory are configured in system (for example, the
> CMA memory accounts for 50% of the system memory), starting a virtual
> virtual machine, it will call pin_user_pages_remote(..., FOLL_LONGTERM,
> ...) to pin memory.  Normally if a page is present and in CMA area,
> pin_user_pages_remote() will migrate the page from CMA area to non-CMA
> area because of FOLL_LONGTERM flag. But the current code will cause the
> migration failure due to unexpected page refcounts, and eventually cause
> the virtual machine fail to start.
> 
> If a page is added in LRU batch, its refcount increases one, remove the
> page from LRU batch decreases one. Page migration requires the page is not
> referenced by others except page mapping. Before migrating a page, we
> should try to drain the page from LRU batch in case the page is in it,
> however, folio_test_lru() is not sufficient to tell whether the page is
> in LRU batch or not, if the page is in LRU batch, the migration will fail.
> 
> To solve the problem above, we modify the logic of adding to LRU batch.
> Before adding a page to LRU batch, we clear the LRU flag of the page so
> that we can check whether the page is in LRU batch by folio_test_lru(page).
> Seems making the LRU flag of the page invisible a long time is no problem,
> because a new page is allocated from buddy and added to the lru batch,
> its LRU flag is also not visible for a long time.
> 

I think we need to describe the impact of this change in a better way. 
This example here is certainly interesting, but if pages are new they 
are also not candidate for immediate reclaim (tail of the LRU).

The positive thing is that we can more reliably identify pages that are 
on an LRU batch.

Further, a page can now only be on exactly one LRU batch.

But, as long as a page is on a LRU batch, we cannot isolate it, and we 
cannot check if it's an LRU page. The latter can currently already 
happen for a shorter time when moving LRU pages, and temporarily 
clearing the flag.

I shared some examples where we don't care, because we'd check for 
additional folio references either way (and the one from the LRU batch).

But I think we have to identify if there are any LRU folio/page checks 
that could now be impacted "more". At least we should document it 
properly to better understand the possible impact (do we maybe have to 
flush more often?).

-- 
Cheers,

David / dhildenb


