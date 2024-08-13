Return-Path: <stable+bounces-67548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DFA950E02
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 22:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BE4AB22607
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 20:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CE71A4F37;
	Tue, 13 Aug 2024 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXQoPi66"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B753C1A3BD7
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723581453; cv=none; b=MJ6bMdd6efRZpkfPkyBCQbId93u8G0G10PXjQTHUsTjcXB3IG8Kk0S/9Pxn61MJLc6PFz3pmsTd367b33ZvS+nWTbCszFP94nq1iBrgb916R+0Zo3yV4sNNjoM/QWUjDGfIeNyFjSoDWxLBCNzlXeICoYKt/VQXHNKuJYU7rSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723581453; c=relaxed/simple;
	bh=ssoUrR2MUenVnn0G0oWygFv6uWNnhpSr7dhSarQrh/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMbMcqwlEFo+IiMsWUMAvnR33nUEnODQZXmfuQFYWv2XWWdyjAUyotmHGSztpq41Z5PKrQQk1mAPEXB9Ypmi2odF6YM824DUk5q7VbZhM8BrLHfU2jDOhxPhhY/hmKzbeSJrIdrj6REpzt+HGa61x9usWxFLA8JS4Gy4zhZgk6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iXQoPi66; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723581449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=De9NMJzxGYMXCFYYNuYNKYWMOUUelr8gYoH0sgIr7zY=;
	b=iXQoPi66yMydtLvrZ4SRjoBN73biEFC7kU2L2Ea61imu1lOczDz4PYDzr1gS1g/6LGwXkR
	oMSBjaoh6dNJHzwpdqLCO+dP/AiOF4pItQIDDGvRmmCn4B2eU5NSddsK0iDMiGnOj+tMgb
	TveEt75fes02rohyuhfb01ciJMdBx1Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-5RWLEod_M22O0-pllqhc4Q-1; Tue, 13 Aug 2024 16:37:28 -0400
X-MC-Unique: 5RWLEod_M22O0-pllqhc4Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-368665a3fdfso3138986f8f.1
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 13:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723581447; x=1724186247;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=De9NMJzxGYMXCFYYNuYNKYWMOUUelr8gYoH0sgIr7zY=;
        b=NTRbpdDheF3w/6eM2kAXsLOmq2ekImTNcHsW323sBLDQLZlgTJhKn9zc4vq+Y70dsT
         EeUjbl+8+KNfQVOSPy7k5Zr3X/N7UWT5xSOPWQDDM2TF9QzAYC0IacVpzakrA6SfXfS7
         nDEc/zJbpULkzb3MDHBsplhiRsEesg89mYajKhqaTdhml76rUHWN5VVA3bd10j4Me+rW
         bd/Ri97kJHUnOP3+zP8A3WGlqCTVOXEWssAr6MabKCPSRHo8Bb2GY8WnsVJ3Ki2DPYp1
         c1Hhf/iJz4pTvVscl7ZzvEClO1F5FmTqHfPSHkc4iwaRWT/dmyG8i3puiP8DUQq1ErMu
         D1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTbvyJKbABZHp8t7t+n084uR77Gie2ILIskmUl6DEKEDNkgxpK7Tv2fDdWgDuP8Nsp28nb/qBtjTkI8Fb2FLWBFGRYhzUh
X-Gm-Message-State: AOJu0YzKKWULz0QqInO/yOX+E+/7KIzHMoQdbhRYxYtyRyw/Sm8xWIUC
	fK8QQWMnc7/irUKbl8E6HWHoNqWMKImtJ55eys9Cm7XV4bJ83ZGIbFNJXKKharQ5MneAVOfcqp9
	vI3RBpLLNn5OryAWhyMNB+pCQQ/b++Udb5BCllJZ9v0yc09B+n7Zecw==
X-Received: by 2002:a5d:6284:0:b0:368:74c0:6721 with SMTP id ffacd0b85a97d-3717780facbmr453742f8f.38.1723581446890;
        Tue, 13 Aug 2024 13:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcugufgzUZYf2EvsRoYFlOyZPm5fd34FmAlCTu8To2eSYdt0fLONv0y0UWPb/BR0XnGBGBJw==
X-Received: by 2002:a5d:6284:0:b0:368:74c0:6721 with SMTP id ffacd0b85a97d-3717780facbmr453719f8f.38.1723581446384;
        Tue, 13 Aug 2024 13:37:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd30f5sm11201902f8f.92.2024.08.13.13.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 13:37:26 -0700 (PDT)
Message-ID: <2e14537b-cf91-479d-a665-c3e174cf2c66@redhat.com>
Date: Tue, 13 Aug 2024 22:37:24 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] userfaultfd: Fix checks for huge PMDs
To: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Pavel Emelianov <xemul@virtuozzo.com>, Andrea Arcangeli
 <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20240813-uffd-thp-flip-fix-v2-0-5efa61078a41@google.com>
 <20240813-uffd-thp-flip-fix-v2-1-5efa61078a41@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240813-uffd-thp-flip-fix-v2-1-5efa61078a41@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.08.24 22:25, Jann Horn wrote:
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

Likely in the future we should turn the latter part into a "pmd_leaf()" 
check.

> +			err = -EEXIST;
> +			break;
> +		}
> +		if (unlikely(pmd_bad(dst_pmdval))) {
>   			err = -EFAULT;
>   			break;
>   		}
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


