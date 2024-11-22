Return-Path: <stable+bounces-94623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB519D60F6
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 15:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C94B285526
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D13A143736;
	Fri, 22 Nov 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+1YzijC"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB9AD2F
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287485; cv=none; b=f8QuRlD9U7FhYTOTmHhaR/5rP3zUsFtBTjkfOKFvRim9A3PyMOisYJksXfU6SjNkSWHaO/MppIDzFMUBS6MCitq1ud2xvH3RJgvMa+oINruPuB6Pe0/Gou/Of/gbYSNYdRBHVf1dmQcV6vuanZREPLfRH1AdX9zT2WLeH9xmAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287485; c=relaxed/simple;
	bh=0M/ADDHHyY2T9oVCYtwHR4v7w4/H+zOoxEuiahYdyNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CeqZslOCh2hPxn4B6ebnQv70qWfPal4+wcRaMWxqHitjZJYkbRYsU3G0v3AAjNKQIjWl7FzP8H/ecBIjVfwc6B1q3dveFkibq822JtNjNoPyKhABfgjIY7h6aB8mSydvxrv3I6SzXAaPtU/H9wSqfXgb28K+KG7DrS8kZxtxP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+1YzijC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732287482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fybjabzIT5znve07EjSb13H+L13N+BBGf0ILqIbAicM=;
	b=f+1YzijCSM/kpwk+Yi8Lg/+2TwJj/Xge1/WbQC7elEHt18V8ZHWrs52IB9OBHQMWXYivM+
	gyUhPZv40kv9Re/M6tas0AN+zpCzO04rIglizpLa6nfTys41sP1JJBGEvPZ76RPGk7y60P
	A5j+Wd7/aFm1gfrWcy6VFdAF93fXT94=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-_Kw620E3MEW8LWghBSkd5Q-1; Fri, 22 Nov 2024 09:58:01 -0500
X-MC-Unique: _Kw620E3MEW8LWghBSkd5Q-1
X-Mimecast-MFC-AGG-ID: _Kw620E3MEW8LWghBSkd5Q
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43159c07193so19447905e9.0
        for <stable@vger.kernel.org>; Fri, 22 Nov 2024 06:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732287480; x=1732892280;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fybjabzIT5znve07EjSb13H+L13N+BBGf0ILqIbAicM=;
        b=vya2JSzI6r47gIiC1bploXPaNksLW9GodoeZO9+aI4z2sFydAYUKfo6mg6Ko3oM8LG
         NVSkJ2fWFi2hC3bkXqHcwfuD96/YMcc4Gu3lemXGyELEWS/dukqGvPhajoetjmYCpPhA
         0BDRwWf5xocqyaFB7xFR+ob2o2UZ1+4S7oAZO+7w0r0LBrevC0oI0zYhbzI+xGOGmNjm
         SPLXaReTrT/CveWpscrKMycyAqypfRWS3IZH4OK/AwajeLfTpI/PCODrtNhFAEU3tLMV
         uo/FmsVswaq7jlqtx5t15YlU63GeTaSc1unqQ68umClAJjLwJMzpqkJFDBy3wGPc8YlF
         1wRg==
X-Forwarded-Encrypted: i=1; AJvYcCXvwx5qfM5ddQgJonA+BozwX8po6WsrwoLtQ0vMR/n/zNGHfDHq7XbNnKZnbJzzHhSnW2njlno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6CPSR1TsS/i9tR3WHrrvCWwDr6Tq677KzfwERocgSz/QHKIiZ
	BudLYYfFdq5RVcLn4oNrsuxgjEjupX+ipO/7F3XWFgc3csx6HjNXVkDSBo4HHsLZzU1qFOc6oOu
	b7o9YvEJLBsDGpRaeF/wkhe8dQBW89DiDwlYnnejpKj+BVwq4beDahg==
X-Gm-Gg: ASbGncvMVOP7dzCyUy/wyx8rC7SUYziREoJN3lfE2cWcWVFVNR+fhmPZxqg4wpvSc7B
	iHur4JkDjsSuVyBnA+TkDwr6oI+eSjK+b7iwQUMONprX8VQdnqlDK04PQ81cGvKVnDLGyuXoKNM
	y33LK9xGGArwqOfP7QJJ2FKnVtxFIHZAN26BQZP/1ynKrHQacseqs7pRYtKh9uB0VRgThvygQ5X
	9JKJUDrJiReDbzppCQQWwm6yJNnX1EQCa9OhxAx2FFpRTzAtcJKtKzeHA9ELL5KK6nQgxkCBWNS
	TEaxAu7V3o3MrVDfyj8eB8Da3Azz0IXG6/o2suajJ9YvPOrZxfUexuEKJEn+Bk5YSWAz5RRWsrY
	=
X-Received: by 2002:a05:600c:3b86:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-433ce4ab677mr25397425e9.28.1732287480064;
        Fri, 22 Nov 2024 06:58:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8XH1tv/O6C8QyGu25dCaFr3LPIMsxoUYDZtqzOCWi3LAQc9WQ2E2ledRWDkSxdt4HPjW6mg==
X-Received: by 2002:a05:600c:3b86:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-433ce4ab677mr25397295e9.28.1732287479772;
        Fri, 22 Nov 2024 06:57:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8? (p200300cbc70b7a009ccd0493d8e29ac8.dip0.t-ipconnect.de. [2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45d4ce6sm92629955e9.25.2024.11.22.06.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 06:57:59 -0800 (PST)
Message-ID: <7e6c2c57-d633-4052-95a9-31ccc9c66327@redhat.com>
Date: Fri, 22 Nov 2024 15:57:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/mempolicy: fix migrate_to_node() assuming there is
 at least one VMA in a MM
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com,
 stable@vger.kernel.org, Christoph Lameter <cl@linux.com>
References: <20241120201151.9518-1-david@redhat.com>
 <lguepu5d2szipdzjid5ccf5m56tdquuo47bzy7ohrjk7fh53q5@6z73dfwdbn4n>
 <20241121221937.c41ee2b5e8534729e94fc104@linux-foundation.org>
 <608c7f17-037b-401b-9336-c26bd45d3147@redhat.com>
 <m4p5ngz7l4hgavwysczmliqrgumlx6dxg35jjwlpcmqtzrpmsk@q2wwxruumhrl>
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
In-Reply-To: <m4p5ngz7l4hgavwysczmliqrgumlx6dxg35jjwlpcmqtzrpmsk@q2wwxruumhrl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.11.24 15:44, Liam R. Howlett wrote:
> * David Hildenbrand <david@redhat.com> [241122 04:32]:
>> On 22.11.24 07:19, Andrew Morton wrote:
>>> On Wed, 20 Nov 2024 15:27:46 -0500 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
>>>
>>>> I hate the extra check because syzbot can cause this as this should
>>>> basically never happen in real life, but it seems we have to add it.
>>>
>>> So..
>>>
>>> --- a/mm/mempolicy.c~mm-mempolicy-fix-migrate_to_node-assuming-there-is-at-least-one-vma-in-a-mm-fix
>>> +++ a/mm/mempolicy.c
>>> @@ -1080,7 +1080,7 @@ static long migrate_to_node(struct mm_st
>>>    	mmap_read_lock(mm);
>>>    	vma = find_vma(mm, 0);
>>> -	if (!vma) {
>>> +	if (unlikely(!vma)) {
>>>    		mmap_read_unlock(mm);
>>>    		return 0;
>>>    	}
>>> _
>>>
>>> ?
>>
>> Why not, at least for documentation purposes. Because I don't think this is
>> any fast-path we really care about, so expect the runtime effects to be
>> mostly negligible. Thanks!
> 
> The next email we get about this will be a bot with a micro benchmark
> performance drop.

I'll be pleasantly surprised if our migration code is that fast such 
that this here would matter :)

-- 
Cheers,

David / dhildenb


