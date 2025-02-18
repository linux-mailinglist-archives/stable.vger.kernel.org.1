Return-Path: <stable+bounces-116745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21E1A39B53
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287D43B44F3
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54D9240613;
	Tue, 18 Feb 2025 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4LNcoui"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F129522D4C3
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879136; cv=none; b=UYIjOsCePIuDR4+JyE1IrbF1gjV2S1T8hp/2JUGe0IwcwuzL6omQXOy9Y3cLSRoX7Lkk+Gzp3yWRumM9jAlZaKugJJv44ZH3PTMjQAFXTWmnUkxfojYBpe8hNesbgTfgXXp7IFWqUz74DKF5VYmjNnJ14X90Mq9N7ibXgy1COmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879136; c=relaxed/simple;
	bh=5wZBwJF3DURRLD3pbvA28Ji9opCVMP2md2RtY1Dj+Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxTTHvW3YeQ1O0+SX8/DBtZAXwkdXjEAoRvRUeegwRwK0OvR/quQtef0rdT7FIWj4IwIS8XbnHZeOu6LYqSH6FUsahh9q8LQJIiyo4BLvyaPD8Rc1hZdbbZVIYdW+tH8VHHwcoFK0b8QAfELfHoTTLDG7oO7+A7sjpmysiGSEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4LNcoui; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739879132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jHCRDL3N6ULifpYh9V9jXw9NcsVelDBQD1Fd1IVvKV4=;
	b=S4LNcoui5gnTODS4ayE7Ox8UA21PeQoklUjgwyc3BgZ9nhVJQ4DMBivreZ8OHHCybFHq1E
	Xl/u8NqJpxn+3mKrsBJpoLWh1tLPArnqCMidMZQ2psRBtM1iwNDTnZgv1FB9QnafxCEzac
	axdwQvceK84LpH83OrtnILeIHEonSGE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-UYa9rpk2MHeTZx9lWQAUDg-1; Tue, 18 Feb 2025 06:45:25 -0500
X-MC-Unique: UYa9rpk2MHeTZx9lWQAUDg-1
X-Mimecast-MFC-AGG-ID: UYa9rpk2MHeTZx9lWQAUDg_1739879125
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f4156f3daso1518339f8f.2
        for <stable@vger.kernel.org>; Tue, 18 Feb 2025 03:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739879124; x=1740483924;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jHCRDL3N6ULifpYh9V9jXw9NcsVelDBQD1Fd1IVvKV4=;
        b=b6mAn57MCbpS6dfjy+G9mQ+9sLO4s4SJZKUI4OAUKTxdw6t+nsd6orNkVwM6qs2RjR
         FLVzBJJqGCSwhXaVe0oEXNEE1gLO8YCUnIx9BnZk0ZJeiIVmorfXHzMvZl/LaX8onuzf
         SoLvCp/sPMmjCLB9SoFlKbPjaRBL2NGoYWB1zJ/+5kW2MNQj4lGx2zGK1+wNKAcSuMEP
         qgqBjGq+ClTXw58+zbq3AGA4baqUwpndrZtyJ92DVUVrU3TnObGY7CvCnGuomz3USMBb
         Z703iReGNl8F2ZzCoQuj3mkKS0xe+GJIoOkiKuiq2GCK1Iq1v2eQNQT0LoQTeLdiajEW
         Wbcw==
X-Forwarded-Encrypted: i=1; AJvYcCWieNi5saWuOWyOc/rzCtC0sSMrkR7Cfn7O7o4fxrjqrYgoISoTxnK6pOrlK9+cSRRnWMB8R4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmKtLwXeXuUr3d4uVKLcD424T0G4IMwiWda1MVaKTH3Hlf074b
	1rlMuiT4G54OO0b2kEaSp/fcuK2Gp0/UleuATJdZTB1l908mfO9aiKLfG8hDCqLSSC4Xun5Bmv/
	A6dbX/Yhctr5Heb58zdVoNLMgmb3EWtVZHbbf3hnvzyM3xK+aqtIp8Q==
X-Gm-Gg: ASbGnct0mtvEq3Yd1g8Nr8lmzrxgLHZZJgPYMh+kmt16VYB3CWNAVJEVHoNdhZfGGTM
	moW6WgxFxykopCgnAxHiIq7Yw5f3dvSClvHuZiUEIJmIi8iUk3j3EATNhkt8vc7/Fnpqqsg7ttH
	ksHks1MQ7qwbIiNcKESqIj2OA1oT9GHZWMdcfd+8h1MTITC6xPbNNMDvOkwfQ9kk8Q625H50UIN
	qgX2a9tLSm8cYF429rcF/qTGek92BK86syZ2+XJufQ0bzHvors/6ulXX3bQmwXQQVgLRqxY3W80
	bDKFLGG8OylDXcRvkoQ5cBs4MV/hEV9RBDdmigHtrYppM0RXy6s2jIKji+H27D6PZggXBeQ53Nu
	Fd3KCpQ8gA1g1mAFv8tJwx5aUUop+jdDY
X-Received: by 2002:a5d:64cc:0:b0:38f:4fcf:d295 with SMTP id ffacd0b85a97d-38f4fcfd742mr3662920f8f.29.1739879124697;
        Tue, 18 Feb 2025 03:45:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEsFXXMwCROy1d+x8L7bQgHNOWiWB5gC6PdvAD/2PVCCKaRqrUGaEoHc5Js+VvCyBvaSCkafA==
X-Received: by 2002:a5d:64cc:0:b0:38f:4fcf:d295 with SMTP id ffacd0b85a97d-38f4fcfd742mr3662893f8f.29.1739879124157;
        Tue, 18 Feb 2025 03:45:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395cf084d5sm123622275e9.1.2025.02.18.03.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 03:45:23 -0800 (PST)
Message-ID: <f5c31616-41e8-464b-84ec-8aa0cedfa556@redhat.com>
Date: Tue, 18 Feb 2025 12:45:21 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] mm/hugetlb: wait for hugetlb folios to be freed
To: yangge1116@126.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com, muchun.song@linux.dev,
 osalvador@suse.de, liuzixing@hygon.cn
References: <1739878828-9960-1-git-send-email-yangge1116@126.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1739878828-9960-1-git-send-email-yangge1116@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.02.25 12:40, yangge1116@126.com wrote:
> From: Ge Yang <yangge1116@126.com>
> 
> Since the introduction of commit c77c0a8ac4c52 ("mm/hugetlb: defer freeing
> of huge pages if in non-task context"), which supports deferring the
> freeing of hugetlb pages, the allocation of contiguous memory through
> cma_alloc() may fail probabilistically.
> 
> In the CMA allocation process, if it is found that the CMA area is occupied
> by in-use hugetlb folios, these in-use hugetlb folios need to be migrated
> to another location. When there are no available hugetlb folios in the
> free hugetlb pool during the migration of in-use hugetlb folios, new folios
> are allocated from the buddy system. A temporary state is set on the newly
> allocated folio. Upon completion of the hugetlb folio migration, the
> temporary state is transferred from the new folios to the old folios.
> Normally, when the old folios with the temporary state are freed, it is
> directly released back to the buddy system. However, due to the deferred
> freeing of hugetlb pages, the PageBuddy() check fails, ultimately leading
> to the failure of cma_alloc().
> 
> Here is a simplified call trace illustrating the process:
> cma_alloc()
>      ->__alloc_contig_migrate_range() // Migrate in-use hugetlb folios
>          ->unmap_and_move_huge_page()
>              ->folio_putback_hugetlb() // Free old folios
>      ->test_pages_isolated()
>          ->__test_page_isolated_in_pageblock()
>               ->PageBuddy(page) // Check if the page is in buddy
> 
> To resolve this issue, we have implemented a function named
> wait_for_freed_hugetlb_folios(). This function ensures that the hugetlb
> folios are properly released back to the buddy system after their migration
> is completed. By invoking wait_for_freed_hugetlb_folios() before calling
> PageBuddy(), we ensure that PageBuddy() will succeed.
> 
> Fixes: c77c0a8ac4c52 ("mm/hugetlb: defer freeing of huge pages if in non-task context")
> Signed-off-by: Ge Yang <yangge1116@126.com>
> Cc: <stable@vger.kernel.org>



Acked-by: David Hildenbrand <david@redhat.com>
>   
> +void wait_for_freed_hugetlb_folios(void)
> +{
> +	flush_work(&free_hpage_work);

BTW, I was wondering if we could optimize out some calls here by sensing 
if there is actually work.

In most cases, we'll never ever have to actually wait here, especially 
on systems without any configured hugetlb pages etc ...

It's rather a corner case that we have to wait here on most systems.

-- 
Cheers,

David / dhildenb


