Return-Path: <stable+bounces-92939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E98BF9C7931
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 17:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5851F24C42
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF388143744;
	Wed, 13 Nov 2024 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZDB4qxW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C191494CC
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516351; cv=none; b=n5HUviTODLpE2xo8SX8BIHW58iKDpS8fNed695A8quTg0dJSO2SvzGN0886pgD1c4Ja7M1Wkjg8zqplKB855hMmjr/K9oNdnpUB04e6+zEuUmbwbYtRvR8TEjWhW2Pc1ffuiIYj7+mf50mXVQg/hK82I+mkYrMVZLQgtsdA/kD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516351; c=relaxed/simple;
	bh=1cT0a3fYIB4F8EUoBxLT/a2UofAfFLR9YGC6zdfYZhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+1VrfcAex39uPONf8QHXuKL5VdoFj9SkDvprsrvYPXNTHQNNFv7/FiUKOHJ2CCzPrMBmey6TyMob091zPeNL62Z+v8z6hyPLLyTop8Z/mFztnu6m0BTp5s0RUH63ECa3QeCDJSdu4yijcZhliYsYpqGJkL5C55ipmICtoOFxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZDB4qxW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731516348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hAA2SfNoY9B9a1rdOczzjgyueHML7v1XEvtHzVMFlxw=;
	b=XZDB4qxWlcp0KX0UFdbDttMIvzo0MxuArNSFUTyvX6iD/+C9SJAJkp15d/3gUpffwJT3Js
	qPcjXvjB2raxV+3ytMUvWeDEUs9VZYuu5HOtNX3Th95OR9ltlPwsBjHmkq1nP97iA5ITWJ
	P/DicidVKqhWgEMlt77dDAv4S7RgIqM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-9pUvKjuxPtGBHG807O95LA-1; Wed, 13 Nov 2024 11:45:47 -0500
X-MC-Unique: 9pUvKjuxPtGBHG807O95LA-1
X-Mimecast-MFC-AGG-ID: 9pUvKjuxPtGBHG807O95LA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-431518e6d8fso50544725e9.0
        for <stable@vger.kernel.org>; Wed, 13 Nov 2024 08:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516346; x=1732121146;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hAA2SfNoY9B9a1rdOczzjgyueHML7v1XEvtHzVMFlxw=;
        b=qEBh2JsVwb9CF0MlL78LCh4aO6KD3JJl24DDEeC8+jRvL2et8tZ8z71m505O3HKFzY
         PeZaSJ0JYU2kH4rz4j3DapJ4jy1Hbb606oQAcwQiu3EXipEjZli/pMGIdNwcCOZ7Y9OK
         0yyMJxf2/dCDppfVSkq6c8RHzbHtJB6uWPWyAROfjHPZlGg/RmlGoxzg5VULK7/T0KOR
         HFsIFjlm73EkZBcp3POpNIpJyqzQE/FhCy+IPCTJ7lQQzDr2y8EWtYyJZIOmAb86PyYO
         0osRwzNcSWeMLIjJBSKw9LM2hKI9dWPlmtIi5fYm4NvG4IAp6XDp0iClMV/CwYr0SSy2
         EutA==
X-Forwarded-Encrypted: i=1; AJvYcCVca2Ok85fVsSO3nt4UfrQpnVDffaQbCOx+92AtDNR3qeAaIAQbvND8Pfy/FbvLh4QaAZwmScs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvNFVcQ2jui/rwzq0PQAOVuySRkPuahYIVlUEQ6zxiqTNdUEGP
	srK3aGgirgk9nPqMlVTPhwV8UK6J3RaYzLOO04cthWcADvwqYx3j5LN46UyxEbkZabTlb0jfsUu
	OJ5+GP5kyfuDKzrrVNQ3PsWUYaVtFq0YxmfXTDyOx+nAjeOn2VXt8OA==
X-Received: by 2002:a05:6000:2aa:b0:381:eba9:fa75 with SMTP id ffacd0b85a97d-381f1866fc7mr17014770f8f.20.1731516345825;
        Wed, 13 Nov 2024 08:45:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3wKscRZB7+dDFrK1+k2j5JnhVEHi5wqZvf2Pz5qQD4XcG7A9n+nEFt9Y8bLS+HvGxwAYfbQ==
X-Received: by 2002:a05:6000:2aa:b0:381:eba9:fa75 with SMTP id ffacd0b85a97d-381f1866fc7mr17014736f8f.20.1731516345284;
        Wed, 13 Nov 2024 08:45:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:1500:d584:7ad8:d3f7:5539? (p200300cbc7081500d5847ad8d3f75539.dip0.t-ipconnect.de. [2003:cb:c708:1500:d584:7ad8:d3f7:5539])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970729sm18722503f8f.15.2024.11.13.08.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:45:44 -0800 (PST)
Message-ID: <99a77c9a-68ca-4445-bcbf-4681ca20a482@redhat.com>
Date: Wed, 13 Nov 2024 17:45:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 5.15] mm/memory: add non-anonymous page check in
 the copy_present_page()
To: Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
Cc: Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 Yuanzheng Song <songyuanzheng@huawei.com>
References: <20241113163118.54834-2-vbabka@suse.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241113163118.54834-2-vbabka@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.11.24 17:31, Vlastimil Babka wrote:
> From: Yuanzheng Song <songyuanzheng@huawei.com>
> 
> The vma->anon_vma of the child process may be NULL because
> the entire vma does not contain anonymous pages. In this
> case, a BUG will occur when the copy_present_page() passes
> a copy of a non-anonymous page of that vma to the
> page_add_new_anon_rmap() to set up new anonymous rmap.
> 
> ------------[ cut here ]------------
> kernel BUG at mm/rmap.c:1052!
> Internal error: Oops - BUG: 0 [#1] SMP
> Modules linked in:
> CPU: 4 PID: 4652 Comm: test Not tainted 5.15.75 #1
> Hardware name: linux,dummy-virt (DT)
> pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __page_set_anon_rmap+0xc0/0xe8
> lr : __page_set_anon_rmap+0xc0/0xe8
> sp : ffff80000e773860
> x29: ffff80000e773860 x28: fffffc13cf006ec0 x27: ffff04f3ccd68000
> x26: ffff04f3c5c33248 x25: 0000000010100073 x24: ffff04f3c53c0a80
> x23: 0000000020000000 x22: 0000000000000001 x21: 0000000020000000
> x20: fffffc13cf006ec0 x19: 0000000000000000 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : ffffdddc5581377c
> x8 : 0000000000000000 x7 : 0000000000000011 x6 : ffff2717a8433000
> x5 : ffff80000e773810 x4 : ffffdddc55400000 x3 : 0000000000000000
> x2 : ffffdddc56b20000 x1 : ffff04f3c9a48040 x0 : 0000000000000000
> Call trace:
>   __page_set_anon_rmap+0xc0/0xe8
>   page_add_new_anon_rmap+0x13c/0x200
>   copy_pte_range+0x6b8/0x1018
>   copy_page_range+0x3a8/0x5e0
>   dup_mmap+0x3a0/0x6e8
>   dup_mm+0x78/0x140
>   copy_process+0x1528/0x1b08
>   kernel_clone+0xac/0x610
>   __do_sys_clone+0x78/0xb0
>   __arm64_sys_clone+0x30/0x40
>   invoke_syscall+0x68/0x170
>   el0_svc_common.constprop.0+0x80/0x250
>   do_el0_svc+0x48/0xb8
>   el0_svc+0x48/0x1a8
>   el0t_64_sync_handler+0xb0/0xb8
>   el0t_64_sync+0x1a0/0x1a4
> Code: 97f899f4 f9400273 17ffffeb 97f899f1 (d4210000)
> ---[ end trace dc65e5edd0f362fa ]---
> Kernel panic - not syncing: Oops - BUG: Fatal exception
> SMP: stopping secondary CPUs
> Kernel Offset: 0x5ddc4d400000 from 0xffff800008000000
> PHYS_OFFSET: 0xfffffb0c80000000
> CPU features: 0x44000cf1,00000806
> Memory Limit: none
> ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---
> 
> This problem has been fixed by the commit <fb3d824d1a46>
> ("mm/rmap: split page_dup_rmap() into page_dup_file_rmap()
> and page_try_dup_anon_rmap()"), but still exists in the
> linux-5.15.y branch.
> 
> This patch is not applicable to this version because
> of the large version differences. Therefore, fix it by
> adding non-anonymous page check in the copy_present_page().
> 
> Cc: stable@vger.kernel.org
> Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
> Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Hi, this was posted in [1] but seems stable@ was not actually included
> in the recipients.
> The 5.10 version [2] was applied as 935a8b62021 but 5.15 is missing.
> 
> [1] https://lore.kernel.org/all/20221028075244.3112566-1-songyuanzheng@huawei.com/T/#u
> [2] https://lore.kernel.org/all/20221028030705.2840539-1-songyuanzheng@huawei.com/
> 
> 
>   mm/memory.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 6d058973a97e..4785aecca9a8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -903,6 +903,17 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>   	if (likely(!page_needs_cow_for_dma(src_vma, page)))
>   		return 1;
>   
> +	/*
> +	 * The vma->anon_vma of the child process may be NULL
> +	 * because the entire vma does not contain anonymous pages.
> +	 * A BUG will occur when the copy_present_page() passes
> +	 * a copy of a non-anonymous page of that vma to the
> +	 * page_add_new_anon_rmap() to set up new anonymous rmap.
> +	 * Return 1 if the page is not an anonymous page.
> +	 */
> +	if (!PageAnon(page))
> +		return 1;
> +
>   	new_page = *prealloc;
>   	if (!new_page)
>   		return -EAGAIN;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


