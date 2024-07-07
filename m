Return-Path: <stable+bounces-58177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A42929709
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 10:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E96281630
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 08:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597B9E541;
	Sun,  7 Jul 2024 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B16m1xkE"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB508F6D
	for <stable@vger.kernel.org>; Sun,  7 Jul 2024 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720339914; cv=none; b=pU6AYl0ybr+2EAEGo6SbAI3YShphCwJPlu5an5UT4BCyB/ZwKAOVJ9eM8kIolnnCa5xwUyLmhbqu4hknYEC9opqOkiMkrEl+lvQuwLo8yyDvc1ITS7Ppmlh2VvTd50OgabQmprbdRumqiSN0jgMuolr79LpUCP1RAnZFaXttsd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720339914; c=relaxed/simple;
	bh=97bqdBTrNtC8IwMLKbe736CxgV5zMMtcEBNYRacAEeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKHtQLclSH+oolILdtsRUBLzXJa8dPDkSwjtIR7D29/Q/mYaufsNeaMPs50ovmO+z/zBxmYFn590aJs08WJ5r2XCv09oVonmfWSpynrhd8mSs6taJK4Nyn4RI/uK5LIMPQr4wLdj7PTPWVcb7UAs/JfrmUi+gm36NLyDmdS/d/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B16m1xkE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720339911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0FC4NvfoAJx1Y/gu3Ro2ey/6zbMrWE94iatb1WkAmOQ=;
	b=B16m1xkErtbQ12YMYNsPJ5EU1IKFBicK8o4O3AC4TJ3xoXqBdQsuVJouYW6bwgFSOq9c3v
	eiaoLQaC0X6Zj65xwB+daRBxFsjp+onWvJgaDoIIuyDjN+B8LFPBVNerK615btKkBKrqB4
	yjUHqc0LumPKesvoUQJYqOCWE8lL/IM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-K6eq9m4uNmqYkn7ARF9x9w-1; Sun, 07 Jul 2024 04:11:49 -0400
X-MC-Unique: K6eq9m4uNmqYkn7ARF9x9w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42668796662so577875e9.2
        for <stable@vger.kernel.org>; Sun, 07 Jul 2024 01:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720339908; x=1720944708;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0FC4NvfoAJx1Y/gu3Ro2ey/6zbMrWE94iatb1WkAmOQ=;
        b=fARi/TUJyo9RqES4ZKOcZQZe38YQpWG11M/fI36rDLIkUBl2qRCxgH6jfUn/9neiC0
         LVVWeQqFe7nYixkRxJSOLpU/SpGe/kLo3Gqoelw7Q2zyFMudRTTK/TerfN8iiNMysnC2
         wvUIlaV4RA624Yr1ehXTZ+X6aJOLH7YLEDw/3c0Rhx89boeAaymXTJwrxgV/4MjIVGws
         p9JdF9V3PL867GwvsgC4Gp8z8uP6yrQ0Av46MhPFypRLYppamzgbcIMxDIWXIuNEe8Nt
         456ulGT951aSWD+ccYl9334KSybYlxh4fByrydbHmQeZPuLNVgCY1fwdof/QPG+nCMlG
         M89Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDI4Hw5Z2NCoX0FzuoE6nXEvBCVc4eeiEir8xzj9k8LOWeDD7EKdm09eHDHwhYnOe2cblrpJ+HLmZiH8n2w3F6tktUlE8G
X-Gm-Message-State: AOJu0Yw5H+19zSavZ5HEmr7SjTbQ1wysa5a8Hvk9vobqKRyoanHmBIFa
	w6/E6rL2LbDsKowGqNnDSW5TRg5sDPeMUhVcJsHpTZFFgdiR8HW4GG8awMRc3eG344QaWM9Aepn
	JKWWpq/ENJYT7KHNisWTHJaaIK74xNbEo3Z2pWEPThR0kawsU5+U8pw==
X-Received: by 2002:a05:600c:4787:b0:426:63f1:9a1b with SMTP id 5b1f17b1804b1-42663f19bddmr9560865e9.33.1720339908780;
        Sun, 07 Jul 2024 01:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEafKI8YyHtgDom4e/eOXaAlEzV1pgl+1foShbkE7WKPQAePKR7zrXbwxom2eBgKuJXJMW1w==
X-Received: by 2002:a05:600c:4787:b0:426:63f1:9a1b with SMTP id 5b1f17b1804b1-42663f19bddmr9560695e9.33.1720339908392;
        Sun, 07 Jul 2024 01:11:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:c00:10f0:d1a8:c206:17ac? (p200300cbc72f0c0010f0d1a8c20617ac.dip0.t-ipconnect.de. [2003:cb:c72f:c00:10f0:d1a8:c206:17ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2519a4sm119123635e9.35.2024.07.07.01.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 01:11:47 -0700 (PDT)
Message-ID: <d1686beb-aff7-4ead-bb6d-53f2b1603f46@redhat.com>
Date: Sun, 7 Jul 2024 10:11:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: Fix khugepaged activation policy
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Barry Song <baohua@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lance Yang <ioworker0@gmail.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240705102849.2479686-1-ryan.roberts@arm.com>
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
In-Reply-To: <20240705102849.2479686-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.07.24 12:28, Ryan Roberts wrote:
> Since the introduction of mTHP, the docuementation has stated that
> khugepaged would be enabled when any mTHP size is enabled, and disabled
> when all mTHP sizes are disabled. There are 2 problems with this; 1.
> this is not what was implemented by the code and 2. this is not the
> desirable behavior.
> 
> Desirable behavior is for khugepaged to be enabled when any PMD-sized
> THP is enabled, anon or file. (Note that file THP is still controlled by
> the top-level control so we must always consider that, as well as the
> PMD-size mTHP control for anon). khugepaged only supports collapsing to
> PMD-sized THP so there is no value in enabling it when PMD-sized THP is
> disabled. So let's change the code and documentation to reflect this
> policy.
> 
> Further, per-size enabled control modification events were not
> previously forwarded to khugepaged to give it an opportunity to start or
> stop. Consequently the following was resulting in khugepaged eroneously
> not being activated:
> 
>    echo never > /sys/kernel/mm/transparent_hugepage/enabled
>    echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
> Closes: https://lore.kernel.org/linux-mm/7a0bbe69-1e3d-4263-b206-da007791a5c4@redhat.com/
> Cc: stable@vger.kernel.org
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


