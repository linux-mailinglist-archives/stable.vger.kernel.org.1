Return-Path: <stable+bounces-91820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CF69C0781
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 14:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457171C227BA
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 13:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52B9212D01;
	Thu,  7 Nov 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T0kNrvQd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829921218E
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986243; cv=none; b=m0VUOBlACtqg2nsF43i7Cy+MRQ8nLZymx/lxuDexZaZrZd6eA+unUWb0m98D7MVKnaF9MibDN14xX2hKWg+KCB+Ah4uteL5A+uZ5BenpVzZaruLddXqQCd4rpUjAmYUI6ZZWE6tkO/uAlbO9gxR/kN2T8izYxhauvwx2RPETR1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986243; c=relaxed/simple;
	bh=E77wMyDqW63P+XFKQ3TQvYxb9vQ4lGABnqBCg3OT0gA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATLq+HTk/zl7TuyzUF4+kc8BxapQtTyxx0fFHXDvzucGQ2wjgJ3+yMXkasDQlxvKfQf5HZEuAb2gj3cb15iPWFnXLzJh+Hjsppcq6sF0Z3aFMMti4dqPO4Nh3Y2+Z1i6Npnvz1r6RGbABxRpCMPQITwzmPpsdk+w8x9XMnxZ+zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T0kNrvQd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730986240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PCN+ExloXIAXcKjChXoBTfCokzR0UPDeZjXHxUwlHj4=;
	b=T0kNrvQdhnRSm7Z6agMpScB2NrQzaCL8F1AsDiPMsWlCAf7IiotjhKdrbWhGX+CdBVJcTr
	+bbPyWlyGFAfSQF8KVmLlSaaEJr82uon8e6sKpaXX7SR0dOCT6qHUeG/cUoFsOMOMUR8VR
	rTk+3PtdSdZpvRjN2MkWXjnj7Za17BA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-gfy3-GzRPYKB5p0qF0qpBw-1; Thu, 07 Nov 2024 08:30:39 -0500
X-MC-Unique: gfy3-GzRPYKB5p0qF0qpBw-1
X-Mimecast-MFC-AGG-ID: gfy3-GzRPYKB5p0qF0qpBw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43163a40ee0so6409065e9.0
        for <stable@vger.kernel.org>; Thu, 07 Nov 2024 05:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986238; x=1731591038;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PCN+ExloXIAXcKjChXoBTfCokzR0UPDeZjXHxUwlHj4=;
        b=dOyre6upxsjhG0f8qk8jYBEA1sf0+Dpj6d+j0+frLVbSB2SFyXvOYjXClHj+lC6kYU
         KwGRhr4QQM6bvf+DGTcu9ibWm5N5HedvX7bxn/WBn9sDqsl7IsV53IJpCBN2bae1EIKR
         +5QE0CQQs0onuKbUdkjtUbKpNbBmuMm58B4Mfy4G/U+shxD8v0WJr26J2R+YG7XZmpIx
         kQ2ukibHTxtgg5HCPaQmq+pwObrvGN5gzZKei3uGVjk4+ja12aaApr/ke6csF4oqrZmq
         VwOsbgKwp8so89zNyelngnvTrYoU1BX1lNSTk9rcI5kmxplcW+eOLAX9R/aJYT3subyG
         ipeg==
X-Forwarded-Encrypted: i=1; AJvYcCU3ioIG7SVnOdTcvvXHvOq3Yy6Re68RnlFdKH9GH0/5JyfWsdsr39SWvPm1bp/G0FXM8LrnuAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhr7lRTaTHmR8C4M7DUrGMjKIBzzyizXWC88GkI5DPSJwP0aPK
	igfEtDJspMAj21HGmUYXAGaNiQniKcFU8Ra16f3RE7vU/AqUukq/HxzhCzakUcbX7JxKYxCY6bL
	ajylyHlF5YZmNyeH9k/7J0MGQwecLkvpUgbgC/vy19I1DMx7CeyXEwg==
X-Received: by 2002:a05:600c:4f4a:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-4319ac70637mr367015915e9.4.1730985891127;
        Thu, 07 Nov 2024 05:24:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNS0ZHdj3v4rgcUtH3LParnJOoo25k5Q1DI6jzvHkwxLvo4duavqNNufMK+dzjLkUoWxHquQ==
X-Received: by 2002:a05:600c:4f4a:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-4319ac70637mr367015675e9.4.1730985890777;
        Thu, 07 Nov 2024 05:24:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:7900:b88e:c72a:abbd:d3d9? (p200300cbc7087900b88ec72aabbdd3d9.dip0.t-ipconnect.de. [2003:cb:c708:7900:b88e:c72a:abbd:d3d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa709ec7sm62306215e9.35.2024.11.07.05.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 05:24:49 -0800 (PST)
Message-ID: <b309a3e5-95b7-4935-bb0d-b83cfb30e988@redhat.com>
Date: Thu, 7 Nov 2024 14:24:47 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fix a possible null pointer dereference in
 setup_zone_pageset()
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org
References: <20241107124116.579108-1-chenqiuji666@gmail.com>
 <00d84e12-4c14-4a6b-a5cd-83d81ac90855@redhat.com>
 <CANgpojUf53ncbYqQRmfMG6R9WYQHSyPGU=LkWVK-MonNDGa8gQ@mail.gmail.com>
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
In-Reply-To: <CANgpojUf53ncbYqQRmfMG6R9WYQHSyPGU=LkWVK-MonNDGa8gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.11.24 14:09, Qiu-ji Chen wrote:
> Hello, the previous patch did not correctly check and release the
> relevant pointers. Version 2 has fixed these issues. Thank you for
> your response.

I'm afraid I'm missing how my review feedback was addresses :/

-- 
Cheers,

David / dhildenb


