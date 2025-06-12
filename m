Return-Path: <stable+bounces-152535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81856AD6825
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 08:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED5037AB491
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 06:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6A81A5B92;
	Thu, 12 Jun 2025 06:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGhQFlgX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C281DDC37
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 06:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749710787; cv=none; b=YSn5vZX4Wsig3SUtAloU0P1G31KCsTbAYUpe2dlqYol8axhScdUICpCduEoqSXTe8UnQMX/jjG7mekx6J5bvePqycdMGTHQu42DYdyAenN1pAz6b1P88RKFefldPCQFRUHFzlLkszUxS4c7rOtTA4yCOfnW23gyPzVhJ7ECBTWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749710787; c=relaxed/simple;
	bh=IipZv141DufKgYkSUWXgjF9SSwNa9LoPKUeg2jWaMFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FxO1l2JMZfnr9XNw7czqGe1BIYr6b8O+jyDHlMBZffUf4ylos/EuIm3zGzmMbyi97q0HOqjDKdeofzpBqgfjb3vXYCziuQ+smmnn7TcncNCc1MrgHstbBk5prOH5ARjGkyS5HuJDZpt+fRt8m7l5bGFcttb+uTN09Ffcg21PaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZGhQFlgX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749710784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iIzkhRpa1dZPuoK2BlfsPGBgeWv5TwKlqrn2D99cAqA=;
	b=ZGhQFlgXwdh4Cpi8++UtbFqJ2KRa4dZ/5EUmRp+7RsRWVK3wpKtqM+bAgwb59j4sf/Ba9Z
	Bo0WVeixZA7THh828ROLNYrPaqcPiJ06qel1Z4CZTkVv1+Ip5EWCiwOB3745Us2bBOrWqi
	MF/NLWQzPx283xCJGR5rwi5cLYfdr5k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-Lrpp7bdONEaWe3B9R2QDIA-1; Thu, 12 Jun 2025 02:46:23 -0400
X-MC-Unique: Lrpp7bdONEaWe3B9R2QDIA-1
X-Mimecast-MFC-AGG-ID: Lrpp7bdONEaWe3B9R2QDIA_1749710782
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43eed325461so2887495e9.3
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 23:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749710782; x=1750315582;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iIzkhRpa1dZPuoK2BlfsPGBgeWv5TwKlqrn2D99cAqA=;
        b=GBITS/R/ZZ8ZH1obCycnD1TEE9p25cxyIVuDaY3PwySppzQYMD+KxZDITa41cCbqQb
         cHVxHxM7eoRemtii0cv2JN8XrEbRbZYO04sNk9sFibywxJcaa77jV1czcxWdqLata3qh
         kJNxjyKn7iDynVm8fqoxkIw3Fu9pl0VHFWU5Yie5mKoyfd8K+KxyLSHeWFZ4bp4yK9ef
         wDt86836yyWPn57UUpUW0AlTRtIMy/d1TGeMqOFG64ef4xKHSPTn13fNQfHNf0+/iN3w
         OzKGJ/qe4MrexQaFWJT7wB7Wc4tIV7wlUYyjO8SqKlJx/UrvDHSRCryaWv1iiuxnNLad
         6naA==
X-Forwarded-Encrypted: i=1; AJvYcCVNlGpT6uIisJC8boHGt8jK+EdRw/z0QXwTO8ODSU3EsATl9ddBhsUrsSn8ZrtkBuiMFXGPjmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLadx+q/p9H6R7GBXWNVbn/JN/GBm3NTy4bhbJpNTc8o0Uyosh
	fd+yuR3PtjboN8fv5hAV9ahn6cqAaApAb9c3loaXSBKN86D6IW9X3kRtXO5FtWCzV0SeLjMC16Q
	jdjj1YqwZ7vNjNU0MEyjuV/VCe4JTuh71iGzj9mxBZ/f6cYXQ9sAxAu5SzA==
X-Gm-Gg: ASbGncvJX14slW2esSp4iMw/BQVLKMpprkIx+ld3hNKj+SuOSQeN+YlFsF31PWFS0NB
	NgvbDSHAL9DUK/BINRZyveoSk5bb6okBj5X2ZKlzQqn+Kd+XygXhrAZSpSu+GAxM+FLCpw54GUG
	HODHqkxaCVa0WgN1uEoeCoujtw33P4otmliWNQGFC4m2D/2eG+64ppsvTacn82QPg7YBWd5OTVz
	atuOq2o+/FbqjBu9wUEGyU0qj/5slZYCUDRQiF/6BAJfcbHjebJIjVJE6/2UUSJ9kKUNhReHhDj
	C7Vvq3+YjM7VBmH6Qg8xwnLyyWBS+OenYUMJhRvHLwyjZStIi/AsEEactl8p2AqYZyw1BdkKAlk
	NtoDiRRiiHtaEBMnUfTbNTqyLwrVf1AQirhLtOeKYn8csuss5AQ==
X-Received: by 2002:a05:600c:1c9e:b0:450:d012:df85 with SMTP id 5b1f17b1804b1-4532b915f4cmr27084575e9.18.1749710781962;
        Wed, 11 Jun 2025 23:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9CX26GoEV2BCNczSNv1t4oY27XPzEIg8IbOmnXnRc1IGtfEL5drtXFBMEzg5dY7jqMLb1YA==
X-Received: by 2002:a05:600c:1c9e:b0:450:d012:df85 with SMTP id 5b1f17b1804b1-4532b915f4cmr27084335e9.18.1749710781510;
        Wed, 11 Jun 2025 23:46:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:1e00:1e1e:7a32:e798:6457? (p200300d82f2c1e001e1e7a32e7986457.dip0.t-ipconnect.de. [2003:d8:2f2c:1e00:1e1e:7a32:e798:6457])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e2446b0sm10338425e9.21.2025.06.11.23.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 23:46:21 -0700 (PDT)
Message-ID: <fa65d0ed-ccd0-4cca-9ac4-fad423e498b6@redhat.com>
Date: Thu, 12 Jun 2025 08:46:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm/huge_memory: don't ignore queried cachemode in
 vmf_insert_pfn_pud()
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Oscar Salvador <osalvador@suse.de>,
 stable@vger.kernel.org
References: <20250611120654.545963-1-david@redhat.com>
 <20250611120654.545963-2-david@redhat.com>
 <684a58bf34666_2491100d7@dwillia2-xfh.jf.intel.com.notmuch>
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
In-Reply-To: <684a58bf34666_2491100d7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.06.25 06:34, Dan Williams wrote:
> David Hildenbrand wrote:
>> We setup the cache mode but ... don't forward the updated pgprot to
>> insert_pfn_pud().
>>
>> Only a problem on x86-64 PAT when mapping PFNs using PUDs that
>> require a special cachemode.
> 
> This is only a problem if the kernel mapped the pud in advance of userspace
> mapping it, right?

Good question, PAT code is confusing.

What I understood is that drivers like vfio will register the range with 
the expected cachemode, and then rely on vm_insert_* to fill out the 
cachemode for them.

Peter explained it in the dicussion here [1] how e.g., vfio triggers 
that early registration.

Regarding vfio, I can see that we do in vfio_pci_core_mmap() 
unconditionally:

vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);

and probably rely on us querying the actual cachemode to be used later.

vfio can map all kinds of different memory types ...

[1] https://lkml.kernel.org/r/aBDXr-Qp4z0tS50P@x1.local

> 
> The change looks good.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...but I am struggling with the scenario where this causes problems in
> practice, where vm_page_prot is the wrong cachemode.

Yeah, it's all confusing.

But as long as we don't conclude that pfnmap_setup_cachemode_pfn() can 
be removed entirely (esp. also from pte / pmd case), this seems to be 
the right thing to do and was accidental change in the introducing commit.

Is it actually stable material? I don't know, but possibly getting 
cachemodes wrongs sounds ... bad?

-- 
Cheers,

David / dhildenb


