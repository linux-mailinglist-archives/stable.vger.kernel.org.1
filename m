Return-Path: <stable+bounces-76916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230B397EE99
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 17:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0652819F3
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 15:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE2919C56B;
	Mon, 23 Sep 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jn7UhH/M"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF3E1993B9
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 15:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107009; cv=none; b=HhTRs6By501Bz+fmIsuU8FhdMORm4v9YVA1SaVnuRR20gvEDkX/vL5FhKBJWKS/hKEATzptcVrFB/tBWcbHcRVUNf68hj5A0t13hYzfyhbJZqpmQoSMXSi2Dyrffk5Hx0bn+dfzK5pOixL8v19+3PQxUuHWKCWdCMHFQFicm/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107009; c=relaxed/simple;
	bh=Sfcv3UiGe4fFEkLKPP5hazoawbszqENOM95UKgdF2ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxKrefAUT+YLp8kWG8wp+P9i/n3/A8ptvmDirh3ArgFJy6cqVoaxwXvbJPIfYqBWYAxejeiOuAJ4RMdN3/6oKv0HTe+RW3HAND03tOTnsh2EhZ22wk06GJfAUJcNXR7NUUa6hBWz48Icgv8DL/FlujSf+RjMkkWdeHzvzLMseIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jn7UhH/M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727107006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iP3SkhF549Gc6brUSlweb2Vjw8EwOroSOBVuS2ghez0=;
	b=Jn7UhH/MlntZDpZClW3vDKkBJEVARFUsi3lYSB/q5yiRw9gQ5nus0KfVo3k20EDBkC5Uwe
	4N7Gvks8WnYshQtd3CL9uZBNr2rDiY2g6zklZkkuYL0+puR7MQS74bgNTnuUEisL+biLY/
	NAAAerrFsKQo6MI+4EaIeE2CVhhpqFI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-KwGkv85bPFaEP7PwZpjB_g-1; Mon, 23 Sep 2024 11:56:45 -0400
X-MC-Unique: KwGkv85bPFaEP7PwZpjB_g-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f7538dc9d7so28084571fa.1
        for <stable@vger.kernel.org>; Mon, 23 Sep 2024 08:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727107004; x=1727711804;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iP3SkhF549Gc6brUSlweb2Vjw8EwOroSOBVuS2ghez0=;
        b=JGRrh5JkakegmOFdkYRVuFCISY3nv0Aj1LQwBEpRxcsePC2N+GLKOXqTWhWFjeGCW/
         ycFXfGk1UKcSDnZvisaFBukDOA/OqBy021KbLssfesa1GknBz0qMaP8SsqKhkewGmwuV
         roCNnJd3yZh4+Cn5A4VahGnc6WnKpHdZubTobpZmlcT3rLIsnQ5thVwNHMAKRz8w+uuO
         sciBClsaaaIri7W47/cXgAma+xSuBZfkhXf+SAI88ygsCsKiLR9jyNPa9O//U78f3T5M
         v0KocTtFF2MdcCH1bIX/IX6FG0UqciY/dAQr2X2j1GV2rk8CtvKq3TKOnCd3rogDiPmA
         FuhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNn9v1fzAwoXmbEwPbAnp2Kylsd+qG0QX6sVoDt22P5xRxv/vu3elo8BFt759oDiDCbUZwLtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlbzQbsu0gzx4JgAqslfC/lrpTsfh10qU3RQnuvB2ojArZbMlP
	uROeffRbg2xLdEWe3wChz/lR85Lir4A8H9HNwFADUe5yOU81+ZT7qvEriA5IKiAzwl2p06kbVl3
	Z0p9JxqKzzeFLCXLQ8dypQrGySW21Pt2xIbYcaLOQM+KYC5Cth6gwKg==
X-Received: by 2002:a2e:809:0:b0:2f7:4c9d:7a83 with SMTP id 38308e7fff4ca-2f7cc5baef2mr48377121fa.40.1727107004076;
        Mon, 23 Sep 2024 08:56:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM0cX/xCUpbnPcURk/407mJfEncclVpDoCWCgm3Go/koit2Hybq9kArBgHN3IpRpvUi0ILDg==
X-Received: by 2002:a2e:809:0:b0:2f7:4c9d:7a83 with SMTP id 38308e7fff4ca-2f7cc5baef2mr48376981fa.40.1727107003532;
        Mon, 23 Sep 2024 08:56:43 -0700 (PDT)
Received: from [10.5.48.152] (90-181-218-29.rco.o2.cz. [90.181.218.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5f4f1sm10472622a12.53.2024.09.23.08.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 08:56:42 -0700 (PDT)
Message-ID: <31e90b74-8bd1-4bfe-9384-8d479735d2be@redhat.com>
Date: Mon, 23 Sep 2024 17:56:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: migrate: fix data-race in migrate_folio_unmap()
To: Jeongjun Park <aha310510@gmail.com>, akpm@linux-foundation.org
Cc: wangkefeng.wang@huawei.com, ziy@nvidia.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot <syzkaller@googlegroups.com>
References: <20240922151708.33949-1-aha310510@gmail.com>
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
In-Reply-To: <20240922151708.33949-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.09.24 17:17, Jeongjun Park wrote:
> I found a report from syzbot [1]
> 
> When __folio_test_movable() is called in migrate_folio_unmap() to read
> folio->mapping, a data race occurs because the folio is read without
> protecting it with folio_lock.
> 
> This can cause unintended behavior because folio->mapping is initialized
> to a NULL value. Therefore, I think it is appropriate to call
> __folio_test_movable() under the protection of folio_lock to prevent
> data-race.
> 

We hold a folio reference, would we really see PAGE_MAPPING_MOVABLE 
flip? Hmm

Even a racing __ClearPageMovable() would still leave 
PAGE_MAPPING_MOVABLE set.

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

Note that this doesn't flip PAGE_MAPPING_MOVABLE, just some unrelated bits.

> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Cc: stable@vger.kernel.org
> Fixes: 7e2a5e5ab217 ("mm: migrate: use __folio_test_movable()")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>   mm/migrate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 923ea80ba744..e62dac12406b 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1118,7 +1118,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>   	int rc = -EAGAIN;
>   	int old_page_state = 0;
>   	struct anon_vma *anon_vma = NULL;
> -	bool is_lru = !__folio_test_movable(src);
> +	bool is_lru;
>   	bool locked = false;
>   	bool dst_locked = false;
>   
> @@ -1172,6 +1172,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>   	locked = true;
>   	if (folio_test_mlocked(src))
>   		old_page_state |= PAGE_WAS_MLOCKED;
> +	is_lru = !__folio_test_movable(src);


Looks straight forward, though

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb


