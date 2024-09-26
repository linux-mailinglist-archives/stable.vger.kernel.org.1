Return-Path: <stable+bounces-77778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64EF9872B8
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 13:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D863B29A09
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 11:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9CF15884D;
	Thu, 26 Sep 2024 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cY5jHOrw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1C418C90A
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727349528; cv=none; b=kHSEEwrxKBiR/aGnQlkwJzox+fUoB1MtM3nl4Nm4gJCGpoVUvf9IvKOwZEfCXa2q32Ix83dXMyS6pBRLsqdPZcaOjzDXTl6VJjCJBwWLMZA2c+pxpu6V3xvTAZxyPDulQEYSdLJB1uZ+UgqebPRI6RhDOOBcdUxtkjFVVYZhtNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727349528; c=relaxed/simple;
	bh=y7v1uzI8DNYSaj9CNPwAFayQIaeASIUKegOl84PWcPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyXadQ/3EqbtQqIwY15eopmQMEfCJx1uvws0YmyE1R/+30uQT5KpGrjQWu7N9fGNYvIuKUSl9CzYXK0TmtRXQq62YCsTC6rNdhn/zkx9Syk/70Hx4mrcIHsoDrfNOMomC+z9hCS90YBdkIdTgTcmrnVYwtFAkKNtFTv6oID/cDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cY5jHOrw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727349525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2MtDhDnhijbrjDYpjKVDoJwPwAmM392gFwthG6+A0BU=;
	b=cY5jHOrwWh+ji+tnthOzoWlDaFs7UH4LOQQhzE6AB3ghWT5llN7WZwQv7ioi0+f5oLpbxP
	qbZMGuI3TawMCL1BLDBJt6Pt9OWuTV9BdFrvWvo5VtygOp5Iw0tEdk3KJGxUXZrYO1wXQS
	CtGmj4dj01C1etX8B03XzNyMgIWgQ+Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-3TFylwp7N_WOqvM1CAmHdQ-1; Thu, 26 Sep 2024 07:18:44 -0400
X-MC-Unique: 3TFylwp7N_WOqvM1CAmHdQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37ccbace251so426472f8f.3
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 04:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727349523; x=1727954323;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MtDhDnhijbrjDYpjKVDoJwPwAmM392gFwthG6+A0BU=;
        b=aCMRjcJ4FKN6WoSzEshaM1RC9q4ThQyxHBWrouF1ZRiQyZpJ13PJMHmH28LoXv6ZX2
         nl5JYg8m3bnDjKPAWGfqcgofYOCsMJSqHkIcRHvZGNKksLP3I6EITqqFeV5C/evFLX7G
         l9tXY7WmiTXdZR8Grj7Z6MISmsCY7/r/n9v2XNC/58mQSyLM13+m7qzbb7+kyZGqY5Nw
         FW0yZ+Z4N3nrFa2gUKZy350d6gJ+ICGesHdgazbhQnDEvXiDjNOdrtzZ9ek8wcjwamyM
         8tnXz49TDxDGLXXtJt0kSR4gtW3ksUJTNJnTmUQT3ClVjKtcUu+zTNKkciFi/HJSo+ak
         nc+g==
X-Forwarded-Encrypted: i=1; AJvYcCXwbPqhohctXD7Z9Tz6gjBv/xaxg4lxrd0+TN/4JQTq682lolJeCfVVjkUy6dzq8zHyZfA/dn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xTtWWOJGb7oMKlEzv26nDWXONWAdsftoEp03BzS6x4imLq7P
	JPHUp2u7ZNU5nL4ufK5dCyOb6Fy3TzbyLJmeV7PIR0200gt3/0FC1voJTBgns8rKHM4kapVvSiX
	Yq5pRy6ILxiLwV5GM6gTQfsVitOBSHFJD7Z+VZR9Hffuf/OiqKlQxiA==
X-Received: by 2002:a5d:5244:0:b0:374:c90c:226 with SMTP id ffacd0b85a97d-37cc245aec3mr3500459f8f.9.1727349523061;
        Thu, 26 Sep 2024 04:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtyHOQYW8XPXNu09FJ1U9vvMp2FaPjMpKPAvATaIwNI4Fiyr79bWf+gP5/vTE2Vd5teJwrAA==
X-Received: by 2002:a5d:5244:0:b0:374:c90c:226 with SMTP id ffacd0b85a97d-37cc245aec3mr3500437f8f.9.1727349522541;
        Thu, 26 Sep 2024 04:18:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c744:ac00:ef5c:b66d:1075:254a? (p200300cbc744ac00ef5cb66d1075254a.dip0.t-ipconnect.de. [2003:cb:c744:ac00:ef5c:b66d:1075:254a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a08da2sm44257595e9.24.2024.09.26.04.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 04:18:42 -0700 (PDT)
Message-ID: <b036d16a-8af8-44b1-b4cb-5ca10a51728b@redhat.com>
Date: Thu, 26 Sep 2024 13:18:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: migrate: annotate data-race in migrate_folio_unmap()
To: Jeongjun Park <aha310510@gmail.com>, akpm@linux-foundation.org,
 willy@infradead.org
Cc: wangkefeng.wang@huawei.com, ziy@nvidia.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
 stable@vger.kernel.org
References: <20240924130053.107490-1-aha310510@gmail.com>
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
In-Reply-To: <20240924130053.107490-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.24 15:00, Jeongjun Park wrote:
> I found a report from syzbot [1]
> 
> This report shows that the value can be changed, but in reality, the
> value of __folio_set_movable() cannot be changed because it holds the
> folio refcount.
> 
> Therefore, it is appropriate to add an annotate to make KCSAN
> ignore that data-race.
> 
> [1]
> 
> ==================================================================
> BUG: KCSAN: data-race in __filemap_remove_folio / migrate_pages_batch
> 
> write to 0xffffea0004b81dd8 of 8 bytes by task 6348 on cpu 0:
>   page_cache_delete mm/filemap.c:153 [inline]
>   __filemap_remove_folio+0x1ac/0x2c0 mm/filemap.c:233
>   filemap_remove_folio+0x6b/0x1f0 mm/filemap.c:265
>   truncate_inode_folio+0x42/0x50 mm/truncate.c:178
>   shmem_undo_range+0x25b/0xa70 mm/shmem.c:1028
>   shmem_truncate_range mm/shmem.c:1144 [inline]
>   shmem_evict_inode+0x14d/0x530 mm/shmem.c:1272
>   evict+0x2f0/0x580 fs/inode.c:731
>   iput_final fs/inode.c:1883 [inline]
>   iput+0x42a/0x5b0 fs/inode.c:1909
>   dentry_unlink_inode+0x24f/0x260 fs/dcache.c:412
>   __dentry_kill+0x18b/0x4c0 fs/dcache.c:615
>   dput+0x5c/0xd0 fs/dcache.c:857
>   __fput+0x3fb/0x6d0 fs/file_table.c:439
>   ____fput+0x1c/0x30 fs/file_table.c:459
>   task_work_run+0x13a/0x1a0 kernel/task_work.c:228
>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>   exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>   syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
>   do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> read to 0xffffea0004b81dd8 of 8 bytes by task 6342 on cpu 1:
>   __folio_test_movable include/linux/page-flags.h:699 [inline]
>   migrate_folio_unmap mm/migrate.c:1199 [inline]
>   migrate_pages_batch+0x24c/0x1940 mm/migrate.c:1797
>   migrate_pages_sync mm/migrate.c:1963 [inline]
>   migrate_pages+0xff1/0x1820 mm/migrate.c:2072
>   do_mbind mm/mempolicy.c:1390 [inline]
>   kernel_mbind mm/mempolicy.c:1533 [inline]
>   __do_sys_mbind mm/mempolicy.c:1607 [inline]
>   __se_sys_mbind+0xf76/0x1160 mm/mempolicy.c:1603
>   __x64_sys_mbind+0x78/0x90 mm/mempolicy.c:1603
>   x64_sys_call+0x2b4d/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:238
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> value changed: 0xffff888127601078 -> 0x0000000000000000
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Cc: stable@vger.kernel.org

Hmm, why stable?

> Fixes: 7e2a5e5ab217 ("mm: migrate: use __folio_test_movable()")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


