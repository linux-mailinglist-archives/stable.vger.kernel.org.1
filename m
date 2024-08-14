Return-Path: <stable+bounces-67601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C3B951257
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 04:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C141C218AE
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 02:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739A51BF53;
	Wed, 14 Aug 2024 02:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Jm8+mVyo"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB56517C66
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 02:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602355; cv=none; b=JUaJIPY7Rdhv4zR03bQuC+BFfQwrymAY3K5DUsd9aNImNdZPedTgZixO9XZ8rLT4+pvZ7yY9RXuJYhvhX4f+1OQr6th9PDeXJ4wK/bigPRBtCJC9wlw5TbE1P8aa4g9l+/OeuS+MzDMQesncFMssaOe3q2vmpXyvjcegsnBeBRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602355; c=relaxed/simple;
	bh=2V9ePT8qFQLfcn3Al53k6b66Jf9bRTh5dFrcVZ4ehNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IdRD4UtmbzI8Bzfk+kpAT5ufUwL+imYqRhLbuWo+M4nT5EJ0I/YF+ASBNhZp1IyJzVFoz5qkAcJ96zZXsIkSqasDF/uh2jP7u9+R4vuUcr8twET6hTnLSgSNmQIn1LoSpKJlv4onCUesAEM7cs2EHo8Po003ctTH7xG6K2urvFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Jm8+mVyo; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39b37b63810so3218755ab.3
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 19:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723602352; x=1724207152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h6LNGe/J5ub4oSc4wEcWX9/lvXmZbxXATcRN21QG/c4=;
        b=Jm8+mVyoArP0ifQn1Bn16/qrNrDzFXhzWtYz/iVPT4y2mrS2U8vzXhlYjbwWDm6LzL
         lzDA11RsATJgya26/jgZo5s6OrlhD/ojx5eixhgeYh+qP7G33xEwOIt9HMKPDLfGvhzG
         pmSRas8eu/kiJvUMQkspbfo4XxqvWiOtbxB27AYwBwmbf/PY6UYDLPVuMK6Pdg8we1z0
         XRIJfYbLMpAwjcIflkh8Ur6RLUxO9bu+o+lJU1T6zPfLWbD7pH9q3bHm25gaNEdxn0In
         2ZdU8TR+wlNTvV48yM7RYo+kHzVv+42W/okJj8RaQoNtqSqdcATf4qat3nn+oGQI5ef3
         hH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723602352; x=1724207152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6LNGe/J5ub4oSc4wEcWX9/lvXmZbxXATcRN21QG/c4=;
        b=tbdBRJhsto8CyTNMxgEenlV+KPPQh93+9NmSpPZdTxBW7a9vD8Kmv/a8N9VXAbAqdz
         rnSgc1MSsJ2eAjidvoV2miZe8zMXwCr0kZtp5Dl+JYNRdA7116Sv95Yz/QyFOuqxN7qO
         iqQ9ZFexji0vobowQ258M4Sdxo2kmYoO8g31wOvFabhqAkO5+M7o7lE3iZJBj9eZJqaU
         3VyiiIJXABL0OybQZVvlJac1G0mgcK/oZ/Q+bgNHUxdSByx+1+vk7g685g1fpSa0y0v4
         7XMA7OT1VkOw7qVvVm4Yebb11piGZOYl4OxQsMbIPVRkbmcR7hkIKKgMcHcxYZ/E00KE
         zBoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcOiNq90Iub6ZuKOMb2UcFA5RUYggZOjqXM53Luom9e27ek4JHdnhN7RF1XOH7E3wJulxyFYtInR0uSYVySKECcbmF3e3H
X-Gm-Message-State: AOJu0Yz6XMOS7UAMfA//svWdy9HCX/h7xUArnNQhjb7QfGNn1sMjR7GD
	I6mxw77Qo/h0X/Y8KpAwOeF8+H1XlZDo08wFS7u/x4SZ5YezDDxH8FNiHOkqXbY=
X-Google-Smtp-Source: AGHT+IEn4p4u+nmkKxqQbRWPDC6r2DEt5JWPBdmKEfZqfN+TfyQpUSmW5aIcJHJ7gF6pbgyQMbYzzg==
X-Received: by 2002:a05:6e02:1d81:b0:39c:2cf0:42f2 with SMTP id e9e14a558f8ab-39d124f2f2dmr10090755ab.4.1723602351912;
        Tue, 13 Aug 2024 19:25:51 -0700 (PDT)
Received: from [10.4.217.215] ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6979ebfaesm2154264a12.24.2024.08.13.19.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 19:25:51 -0700 (PDT)
Message-ID: <382ae7b5-9ccd-4202-a02d-be5d453f7c43@bytedance.com>
Date: Wed, 14 Aug 2024 10:25:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] userfaultfd: Fix checks for huge PMDs
Content-Language: en-US
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Pavel Emelianov <xemul@virtuozzo.com>, Andrea Arcangeli
 <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 stable@vger.kernel.org
References: <20240813-uffd-thp-flip-fix-v2-0-5efa61078a41@google.com>
 <20240813-uffd-thp-flip-fix-v2-1-5efa61078a41@google.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20240813-uffd-thp-flip-fix-v2-1-5efa61078a41@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/14 04:25, Jann Horn wrote:
> This fixes two issues.
> 
> I discovered that the following race can occur:
> 
>    mfill_atomic                other thread
>    ============                ============
>                                <zap PMD>
>    pmdp_get_lockless() [reads none pmd]
>    <bail if trans_huge>
>    <if none:>
>                                <pagefault creates transhuge zeropage>
>      __pte_alloc [no-op]
>                                <zap PMD>
>    <bail if pmd_trans_huge(*dst_pmd)>
>    BUG_ON(pmd_none(*dst_pmd))
> 
> I have experimentally verified this in a kernel with extra mdelay() calls;
> the BUG_ON(pmd_none(*dst_pmd)) triggers.
> 
> On kernels newer than commit 0d940a9b270b ("mm/pgtable: allow
> pte_offset_map[_lock]() to fail"), this can't lead to anything worse than
> a BUG_ON(), since the page table access helpers are actually designed to
> deal with page tables concurrently disappearing; but on older kernels
> (<=6.4), I think we could probably theoretically race past the two BUG_ON()
> checks and end up treating a hugepage as a page table.
> 
> The second issue is that, as Qi Zheng pointed out, there are other types of
> huge PMDs that pmd_trans_huge() can't catch: devmap PMDs and swap PMDs
> (in particular, migration PMDs).
> On <=6.4, this is worse than the first issue: If mfill_atomic() runs on a
> PMD that contains a migration entry (which just requires winning a single,
> fairly wide race), it will pass the PMD to pte_offset_map_lock(), which
> assumes that the PMD points to a page table.
> Breakage follows: First, the kernel tries to take the PTE lock (which will
> crash or maybe worse if there is no "struct page" for the address bits in
> the migration entry PMD - I think at least on X86 there usually is no
> corresponding "struct page" thanks to the PTE inversion mitigation, amd64
> looks different).
> If that didn't crash, the kernel would next try to write a PTE into what it
> wrongly thinks is a page table.
> 
> As part of fixing these issues, get rid of the check for pmd_trans_huge()
> before __pte_alloc() - that's redundant, we're going to have to check for
> that after the __pte_alloc() anyway.
> 
> Backport note: pmdp_get_lockless() is pmd_read_atomic() in older
> kernels.
> 
> Reported-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Closes: https://lore.kernel.org/r/59bf3c2e-d58b-41af-ab10-3e631d802229@bytedance.com

Ah, the issue fixed by this patch was not reported by me, so
I think that this Reported-by does not need to be added. ;)

> Cc: stable@vger.kernel.org
> Fixes: c1a4de99fada ("userfaultfd: mcopy_atomic|mfill_zeropage: UFFDIO_COPY|UFFDIO_ZEROPAGE preparation")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>   mm/userfaultfd.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index e54e5c8907fa..290b2a0d84ac 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -787,21 +787,23 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>   		}
>   
>   		dst_pmdval = pmdp_get_lockless(dst_pmd);
> -		/*
> -		 * If the dst_pmd is mapped as THP don't
> -		 * override it and just be strict.
> -		 */
> -		if (unlikely(pmd_trans_huge(dst_pmdval))) {
> -			err = -EEXIST;
> -			break;
> -		}
>   		if (unlikely(pmd_none(dst_pmdval)) &&
>   		    unlikely(__pte_alloc(dst_mm, dst_pmd))) {
>   			err = -ENOMEM;
>   			break;
>   		}
> -		/* If an huge pmd materialized from under us fail */
> -		if (unlikely(pmd_trans_huge(*dst_pmd))) {
> +		dst_pmdval = pmdp_get_lockless(dst_pmd);
> +		/*
> +		 * If the dst_pmd is THP don't override it and just be strict.
> +		 * (This includes the case where the PMD used to be THP and
> +		 * changed back to none after __pte_alloc().)
> +		 */
> +		if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval) ||
> +			     pmd_devmap(dst_pmdval))) {
> +			err = -EEXIST;
> +			break;
> +		}
> +		if (unlikely(pmd_bad(dst_pmdval))) {
>   			err = -EFAULT;
>   			break;
>   		}

Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>

> 

