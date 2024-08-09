Return-Path: <stable+bounces-66283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2F194D37C
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 17:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD791F23BF4
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 15:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9A0198E60;
	Fri,  9 Aug 2024 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WM8s0Apg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1609198842
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217369; cv=none; b=teJsKlTclBtJJIWaVV7dvOYdEmyCKNbzv6PATUwJYjelaML71pY2qice1+Kozg1juOOfazMQHXr2pcF/VkQQMJcEs+RAgvrlnVzlDRA0f5tddMByMqJDDWgZ5bsHwWELX0o0UXg+5LZs94V4y4U6n1be9BQR3wtxwTIhAkDUNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217369; c=relaxed/simple;
	bh=98E3TuM3TQmqoSqfPWEv3I8pWRbRVWWV8quLbdF4slk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NY+MesQV6NXuYqcyQUwNSSKBAs3lUVnj1J1rXNtWfRT11aqbY0h30t7iaSStZgSeeH48Z1nWfIIdsrbTzJTGE6E7sUQVPazlBcIm5vowegdW4GH6Xi+xI6kdd2RX8eEaNUVT3QbUJWDeqJYqmrv960waIs0trWM0yuMtiwPg/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WM8s0Apg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723217365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IkaFtYOglx3SERuq0AG1B8o+eSlXUn20hFBeWUD5Y4o=;
	b=WM8s0Apg+nptOhMneZfSAjBrCEw2aPcqy2n02Tc4ONG/fC2CkCrxI50r7b6ckD/P8bbMcc
	9gxdzm2hUXmXbKYYvyOfDhdl3zgDdf4vaP/fnG/pO4CDbZGO/oWpyhPvxY/UeWTLJzjeu0
	mHvJi0U0jO2MwmCFAhBQXMO1Ba4fRtQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404--p4ISoAqNI22A3NmwcGqmg-1; Fri, 09 Aug 2024 11:29:23 -0400
X-MC-Unique: -p4ISoAqNI22A3NmwcGqmg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42808efc688so15492325e9.0
        for <stable@vger.kernel.org>; Fri, 09 Aug 2024 08:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723217362; x=1723822162;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IkaFtYOglx3SERuq0AG1B8o+eSlXUn20hFBeWUD5Y4o=;
        b=wS/g2Jq9yr9Zykqna3+ZHAjPpA77vBNFOvIGcvzscmbedwoEQbfn7kVwBPjdVxJ4o3
         R35hjC+ernaoB4tZJkvivepn7hJumjbAkiTJ0fQe6kiJwMJNluMmt4rYesw9f02TamuL
         0qg8dX4rSmmCgBtQYTVC4QHC/lLtidduq1G5QXZ1i3D1kMZmoo27Du/px6v95+a4c4ob
         YEIbISmNC5jWeETW+mXeK1VMSU/2GkYRHkD6lEJGdT03JCG5kKX7cMTND498DFPR5C5W
         rPNk9oQWNF2ZxeeRKyxpeJj1yOVdDykS7UHK+CK9fVBhsAWaADx8NRM1cbXPh6Jje1Du
         MUbw==
X-Forwarded-Encrypted: i=1; AJvYcCXGtl/Fd/u7sCUjk31Tif+lcIfjkQpHrabETSoR+hGINpmS41oEJ7b3Ax7z/KkrEz/eXue3fmxsVODY2E8xGQDc2cPO1rGA
X-Gm-Message-State: AOJu0YwBAbSCGTBVci3bQmVV6VABnkTntHObq5ZPHwr7W5J6rSY5C8kQ
	ZO6gsuCcASll7CfsiPdTrkz68Pjd3d+GLr0jyxeHG8EgNx7U6mCQcviEGCUXBDPUTc7LuZNP5ll
	FnyUphO0jtIv6GXjF081Eu+CI0PtudgaMuJNmqACIviTN49wl3DR0HQ==
X-Received: by 2002:a05:600c:46ce:b0:426:5ddf:fd22 with SMTP id 5b1f17b1804b1-429c3a17f1bmr13036385e9.6.1723217362433;
        Fri, 09 Aug 2024 08:29:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9g/HImcMSBHo0q13rPpw/b1gOqisdmkCTPdK/rjlFupPIN6Eqj9sBoWS7cZ0WsvzucC7hMw==
X-Received: by 2002:a05:600c:46ce:b0:426:5ddf:fd22 with SMTP id 5b1f17b1804b1-429c3a17f1bmr13036185e9.6.1723217361886;
        Fri, 09 Aug 2024 08:29:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059713adsm133237355e9.11.2024.08.09.08.29.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 08:29:21 -0700 (PDT)
Message-ID: <2cdc6d9a-0855-4209-9745-0ae15c4498a8@redhat.com>
Date: Fri, 9 Aug 2024 17:29:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] mm/numa: no task_numa_fault() call if PTE is
 changed
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Huang, Ying" <ying.huang@intel.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yang Shi <shy828301@gmail.com>,
 Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240809145906.1513458-1-ziy@nvidia.com>
 <20240809145906.1513458-2-ziy@nvidia.com>
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
In-Reply-To: <20240809145906.1513458-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.08.24 16:59, Zi Yan wrote:
> When handling a numa page fault, task_numa_fault() should be called by a
> process that restores the page table of the faulted folio to avoid
> duplicated stats counting. Commit b99a342d4f11 ("NUMA balancing: reduce
> TLB flush via delaying mapping on hint page fault") restructured
> do_numa_page() and did not avoid task_numa_fault() call in the second page
> table check after a numa migration failure. Fix it by making all
> !pte_same() return immediately.
> 
> This issue can cause task_numa_fault() being called more than necessary
> and lead to unexpected numa balancing results (It is hard to tell whether
> the issue will cause positive or negative performance impact due to
> duplicated numa fault counting).
> 
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Closes: https://lore.kernel.org/linux-mm/87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com/
> Fixes: b99a342d4f11 ("NUMA balancing: reduce TLB flush via delaying mapping on hint page fault")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


