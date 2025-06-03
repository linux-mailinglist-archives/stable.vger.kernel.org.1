Return-Path: <stable+bounces-150748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 891EEACCD18
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944537A511F
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B6024C67A;
	Tue,  3 Jun 2025 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2GyJCtx"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5066723BCE2
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975614; cv=none; b=qOEbazxXu4byFSuxvhpjhdJPu5jok9d96X84+lbCKreDUaQ/QSRIHPC3tgrJsROk4pKGJMzziPgWW7tuvI3sT4X2OKJ6D2jB2R/z/Ie2nw0qpyl0ioGf9sza1Fd4eSsTn8XHsaBdAsYRYC2fs722yEfIfws97Gov20HCOHzU/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975614; c=relaxed/simple;
	bh=wIm+hDtp2W7YmFrQLEcLFeDFGVJ0j9AutM/kiw828ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivsCWeCVtlfpfoVn8G1TOwHTx135iWhht/WLgBHixAN+maa6obsVPCiURT1lxELVwTS3TYxr1nlg9ZVv5tU4QQ5Qva5VsNeqefX0qLE0SUAsdiJs96XTWNKzbGcmxC0CUcKxw3bgcwTGfpNTLHfEXzW530/iHksN5tFv4zogHWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2GyJCtx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748975611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PNZ0o97LOFUx59kTjPtSNbAB77tQUnMQ3HnF8L8iiYE=;
	b=Q2GyJCtxVnXB7Gxabj76RbUJA1F6uH88G2ASGkbvM6Z+QZ9JxdsXBsDnU8Ih8SIAv0l42h
	3kp9vSO+RhjlA4FSM8y3MN7tpj7mHNeE4PO7wgD3L+Cw5+tVw0t5MRASYK6QcGqey33H6n
	rIBE8cvHQNH98lQxCneWCpw5oLNWJvA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-EYCjGjZqOVet45YfivMA2g-1; Tue, 03 Jun 2025 14:33:30 -0400
X-MC-Unique: EYCjGjZqOVet45YfivMA2g-1
X-Mimecast-MFC-AGG-ID: EYCjGjZqOVet45YfivMA2g_1748975609
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4e9252ba0so3564375f8f.0
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 11:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748975609; x=1749580409;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PNZ0o97LOFUx59kTjPtSNbAB77tQUnMQ3HnF8L8iiYE=;
        b=NyXGhmkFJK4EC1+M0LMhks69Hj0XpJWo8+Ni93KO4sUfARVWYUma1KLruQJbr7tKZD
         E5o52AYq2IFtepAIuNklUHe5KyRZce7yvgbjyyGcDR40Y9XaeS15vLpUjWUhCvPISZLv
         vUB2MeWARhJEAZ8tGrpf9iBTMGn9iqwfv+kyTsyg/1fGuu1f/+5joJLHcwj4M6fENNGh
         eSJjvM3j0hbGz5DIKnQnv2Ror+av4gwYwLOumtoQIOn6Odf7xwJ/jkUURnxy2p+HmXwl
         jCQPGpxDYBR9IGsWnUc6zt7qrYDE892RJW1sNcjG0A6fUcGwBOoW1ITXCYdWmhFldN7N
         Z7Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUo3MbQFiiQhrBw9tM3ZVCAIBGGL1wAPWbl8jbLmialeqimM/Yr/mmVs0sbB1gbpVddXTq6ZW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9R4p+++PXNdji9FoL9i0AWjCPuHAZ7/v8vpAY5SessLuBwUtx
	15OEQ7Qj13cjjsSfq2AGp+7F407LKm7iweZUzcNbbipQZBd2V8vDnwgS7Mzxf7rhqBdGKE3ryps
	rBZZmj+OQN/6jpS3yzaGIMkzsXASog11AoYvieak9zXbR3ObCf/K79PkcoQ==
X-Gm-Gg: ASbGncuoLSVA6c0C68OJNVq5Um5TKZgPEIgooxfMQc02J1bSvolywnz+LKSp6IrSICE
	CaGH7d/N5djdGs5pjnGju3/FC4X7WXw0g6kThTUfX8ERogRzZZHmTWT1FqD/3lmr/me4zX9fv9w
	CBQ8rRm59VEcGHB8gyyLV7DSQ5HTh/rjxrz+Lhu6TwBw7r0wKn14TxkF+YTPxzN8lBMdvGU0mUh
	AtMwr/qCkJs7JGo+DWswMqoUtsOa82vytJjM3gHeYoCY7ZkKoy8ZdD0f6+wmeMCSKtj2nL82cw7
	fzMjG6Lg+IQ1c5apwiunC+UMx1LVlr3kOmsRyI9ojhBZwqv0KmhZEVdhGmJmXmz1+w3aWKvQfWL
	MrJMsgdlU9qHqrHZzhhC445qV8mAiZvWfc+zUtxc=
X-Received: by 2002:a05:6000:4010:b0:3a4:eb7a:2cda with SMTP id ffacd0b85a97d-3a4f89cd20emr12493826f8f.30.1748975608776;
        Tue, 03 Jun 2025 11:33:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9KD9hWCR7oU9bBLRs1WfzBb+VHuOSgcxTY1ZxhBCs9hGUg0ZNTDdICeezsbGXvuvzehW8lA==
X-Received: by 2002:a05:6000:4010:b0:3a4:eb7a:2cda with SMTP id ffacd0b85a97d-3a4f89cd20emr12493804f8f.30.1748975608318;
        Tue, 03 Jun 2025 11:33:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:f000:eec9:2b8d:4913:f32a? (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de. [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8ed32sm168983085e9.1.2025.06.03.11.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 11:33:27 -0700 (PDT)
Message-ID: <ba334288-298d-43fb-93ba-c159de3cee32@redhat.com>
Date: Tue, 3 Jun 2025 20:33:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/memory: ensure fork child sees coherent memory
 snapshot
To: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org
Cc: Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250603-fork-tearing-v1-0-a7f64b7cfc96@google.com>
 <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250603-fork-tearing-v1-1-a7f64b7cfc96@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.25 20:21, Jann Horn wrote:
> When fork() encounters possibly-pinned pages, those pages are immediately
> copied instead of just marking PTEs to make CoW happen later. If the parent
> is multithreaded, this can cause the child to see memory contents that are
> inconsistent in multiple ways:
> 
> 1. We are copying the contents of a page with a memcpy() while userspace
>     may be writing to it. This can cause the resulting data in the child to
>     be inconsistent.
 > 2. After we've copied this page, future writes to other pages may> 
  continue to be visible to the child while future writes to this page are
>     no longer visible to the child.
 > > This means the child could theoretically see incoherent states where
> allocator freelists point to objects that are actually in use or stuff like
> that. A mitigating factor is that, unless userspace already has a deadlock
> bug, userspace can pretty much only observe such issues when fancy lockless
> data structures are used (because if another thread was in the middle of
> mutating data during fork() and the post-fork child tried to take the mutex
> protecting that data, it might wait forever).
> 

Hmm, interesting.

> On top of that, this issue is only observable when pages are either
> DMA-pinned or appear false-positive-DMA-pinned due to a page having >=1024
> references and the parent process having used DMA-pinning at least once
> before.

Right.

> 
> Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>   mm/memory.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 49199410805c..b406dfda976b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -917,7 +917,25 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>   	/*
>   	 * We have a prealloc page, all good!  Take it
>   	 * over and copy the page & arm it.
> +	 *
> +	 * One nasty aspect is that we could be in a multithreaded process or
> +	 * such, where another thread is in the middle of writing to memory
> +	 * while this thread is forking. As long as we're just marking PTEs as
> +	 * read-only to make copy-on-write happen *later*, that's easy; we just
> +	 * need to do a single TLB flush before dropping the mmap/VMA locks, and
> +	 * that's enough to guarantee that the child gets a coherent snapshot of
> +	 * memory.
> +	 * But here, where we're doing an immediate copy, we must ensure that
> +	 * threads in the parent process can no longer write into the page being
> +	 * copied until we're done forking.
> +	 * This means that we still need to mark the source PTE as read-only,
> +	 * with an immediate TLB flush.
> +	 * (To make the source PTE writable again after fork() is done, we can
> +	 * rely on the page fault handler to do that lazily, thanks to
> +	 * PageAnonExclusive().)
>   	 */
> +	ptep_set_wrprotect(src_vma->vm_mm, addr, src_pte);
> +	flush_tlb_page(src_vma, addr);

Would we need something similar for hugetlb, or is that already handled?

-- 
Cheers,

David / dhildenb


