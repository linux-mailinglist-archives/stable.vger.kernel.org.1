Return-Path: <stable+bounces-89714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 631DC9BB934
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 16:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF77B23709
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F2A1BF804;
	Mon,  4 Nov 2024 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fgiwbrpg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D951BF81B
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734930; cv=none; b=uMlBc6aX1GV47R21u8mjmKHn7LULSDTgDFHWzsbkvTrw3UZrRw85PQYrXa8Rcd+Fun8U15g1sBsff4HUIfBF2SBXIDh/R1mbWG8Vij2eDa5cepakvmFKhtm8fVck3VRMCq5S3XB8QMaxi6s0mOH1sAusQL9dbC0Bz/jIFn7nFiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734930; c=relaxed/simple;
	bh=bIH098YsMBdaowd9d01WNDbF0uwTPu4KB66QbbQtD3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyO3Ncfv+Fh27B9TdYLQNzPT+uQM5l98DaD7fxxi2Dv6PNrtZl+UbQoZmLgqzXAgH74S8QTmIhP9B91dhjapHTgC444ow/Jywvz4+PD4iHR1fRlACtPcXKtafaowLhcTZdyJHzkv0ZjrfzrqqjODX4RhB77HtFq1zmMdQSt/RxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fgiwbrpg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730734927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dmLegGizt/84R+PLLKjjl/45WGBvm2sV2L0gRIZ3+3I=;
	b=Fgiwbrpgmohsr3vaLF5V4MMWWYwuCrZTch3In0j7hRPBE7yAh5CasP9Mg01TbMLWo7ctYt
	ZG096YVPdTygBCwCPCEj4RAf+3mldH8oyPTqHqfSL0BAk5cwpnqYk4dupsWnX/lZl4KnHX
	g24dUQ9vC6dDfGiTEUfusD9zBHL6wRM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-OpnyRjdhNkumeTpr0SyDSw-1; Mon, 04 Nov 2024 10:42:06 -0500
X-MC-Unique: OpnyRjdhNkumeTpr0SyDSw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-431673032e6so26483985e9.0
        for <stable@vger.kernel.org>; Mon, 04 Nov 2024 07:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730734925; x=1731339725;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dmLegGizt/84R+PLLKjjl/45WGBvm2sV2L0gRIZ3+3I=;
        b=jemt2YCK69eqrQ91EmnUW9HOOgAL0iOAe9mz/eX+xEMpxM2ewHYadEtWTJZ9rzPGU/
         flWIJWLrHw3KV/XN2UDRqn+FixbRNjTOa5dC7AicYybWNDvIAMfpex5B+QuBuBWAWJGi
         Rr0I4798jHGSNDtqf+zeudk7p+uXQh8z0y96fUOp3JggG7H4GAG4vfKh6/x8SDf17j/h
         FYEJBMILqWkAffrqzKds8eaulBxaZ4VOWjJfV5xfdoCbUVPnlvv/YJooMxOJLKJhmhuk
         VmlE8R8dr8AnXNVqlIIBLaGIHMp+4eJUZOFWszQrIm+1xZu8n8hADvbU6OpMW2Rn2BG6
         fcoQ==
X-Gm-Message-State: AOJu0Yygvm/3XQxbYCDreeQqMxTMnqUtuhmdrqJ5NowSV1MYHpNS3BNw
	WlQ3C97YT7U2KbvEIEOdo4ZWnIT14PS1jrJ/zqQc5BGTb8f8U6mqrw3pyR17nxa5S8990yy8+PH
	Rt5vDh/WFo8HNCLrcb5+5+4voDAm8kVHnvNOcPGS4y5jvGwP1Qtx0r6d9JJhTIqiWd728iECuxI
	TS+xa1RUuTGQsbCeR+fr5jI4pLE9+VZiwzomCo
X-Received: by 2002:a05:600c:458f:b0:431:5ed4:7e7d with SMTP id 5b1f17b1804b1-4327a82f755mr164738585e9.18.1730734924992;
        Mon, 04 Nov 2024 07:42:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5i9TvBLV1uI2Udtc0CcceejgcZjNq3+tSBwVrOAfSDxYy6+5wmBLLMPTfyn+R+p719JUZ1A==
X-Received: by 2002:a05:600c:458f:b0:431:5ed4:7e7d with SMTP id 5b1f17b1804b1-4327a82f755mr164738215e9.18.1730734924482;
        Mon, 04 Nov 2024 07:42:04 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8549sm190894735e9.10.2024.11.04.07.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 07:42:03 -0800 (PST)
Message-ID: <0f306d3d-38e3-4ce3-a161-7695ea9392cd@redhat.com>
Date: Mon, 4 Nov 2024 16:42:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] mm: don't install PMD mappings when THPs are
 disabled by the hw/process/vma
To: stable@vger.kernel.org
Cc: Leo Fu <bfu@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Hugh Dickins <hughd@google.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Greg KH <gregkh@linuxfoundation.org>
References: <2024101842-empty-espresso-c8a3@gregkh>
 <20241022090952.4101444-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241022090952.4101444-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Gentle ping, XEN PV users reported an issue fixed by this fix upstream.

On 22.10.24 11:09, David Hildenbrand wrote:
> We (or rather, readahead logic :) ) might be allocating a THP in the
> pagecache and then try mapping it into a process that explicitly disabled
> THP: we might end up installing PMD mappings.
> 
> This is a problem for s390x KVM, which explicitly remaps all PMD-mapped
> THPs to be PTE-mapped in s390_enable_sie()->thp_split_mm(), before
> starting the VM.
> 
> For example, starting a VM backed on a file system with large folios
> supported makes the VM crash when the VM tries accessing such a mapping
> using KVM.
> 
> Is it also a problem when the HW disabled THP using
> TRANSPARENT_HUGEPAGE_UNSUPPORTED?  At least on x86 this would be the case
> without X86_FEATURE_PSE.
> 
> In the future, we might be able to do better on s390x and only disallow
> PMD mappings -- what s390x and likely TRANSPARENT_HUGEPAGE_UNSUPPORTED
> really wants.  For now, fix it by essentially performing the same check as
> would be done in __thp_vma_allowable_orders() or in shmem code, where this
> works as expected, and disallow PMD mappings, making us fallback to PTE
> mappings.
> 
> Link: https://lkml.kernel.org/r/20241011102445.934409-3-david@redhat.com
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reported-by: Leo Fu <bfu@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 2b0f922323ccfa76219bcaacd35cd50aeaa13592)
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Minor contextual difference.
> 
> Note that the backport of 963756aac1f011d904ddd9548ae82286d3a91f96 is
> required (send separately as reply to the "FAILED:" mail).
> 
> ---
>   mm/memory.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index b6ddfe22c5d5..742c2f65c2c8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4293,6 +4293,15 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>   	pmd_t entry;
>   	vm_fault_t ret = VM_FAULT_FALLBACK;
>   
> +	/*
> +	 * It is too late to allocate a small folio, we already have a large
> +	 * folio in the pagecache: especially s390 KVM cannot tolerate any
> +	 * PMD mappings, but PTE-mapped THP are fine. So let's simply refuse any
> +	 * PMD mappings if THPs are disabled.
> +	 */
> +	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vma->vm_flags))
> +		return ret;
> +
>   	if (!transhuge_vma_suitable(vma, haddr))
>   		return ret;
>   


-- 
Cheers,

David / dhildenb


