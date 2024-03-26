Return-Path: <stable+bounces-32368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2562E88CBBD
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 19:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931AD1F85494
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 18:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404E08664F;
	Tue, 26 Mar 2024 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZLGSiVm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317F91CAA6
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476680; cv=none; b=ulClSCNobGHSnrBc0kfaZG4H4Q6ZygpjR0yPGrpKhVXx8lIISV+zsB9ayd7TaqwYroCvuQwN9x80Cl4iJxxg6utIg/N5e+n5QH155blyGkx7h8t1TCirJc+8lxRKM93WbQq5JjmdReYHNwEcp8dW8+W6EPO7NlzeU3wyaQq9MhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476680; c=relaxed/simple;
	bh=3mVijn5dSHROtsdHZoN/rYxZON3OKlP40rEV0ddg3DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Hqt3q9Tn7qEgGo/L4uuZONt/9vYYk6jC2Y94xNKVZp5pliCwwGNeKsBmPKkfKzULIMbg2lDTXwerlNX9IhnAUMxHciv5wcm+1NBbpBZNJu88sqim0L/qJk/t281gu8xyHlWHVI18PxwXdppQQ1q7w+crw8L6R9HzS233v6NKOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZLGSiVm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711476678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TXAIJv9nAl74kU55mYeOMp2Ok3/4sY0r1ywNXMqvguo=;
	b=YZLGSiVmAb9oFZbXGrcCU8ZsGfQ1D/x3Xnsb5WXJCFM2AcrI8xngpYti8fmY3xC8rNDdQ4
	s5CJeic0/kiYjy85G92qLDlSY2OPy6p/Z7CrBlXjwOEfNvzCvHL/uVwscN0EAC+h5zeEra
	WYAVOpkajGXz5Cz6pIF3Vnd6jNSHtc0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-B3HvE3YTN7Cpr8nrKNzrbQ-1; Tue, 26 Mar 2024 14:11:15 -0400
X-MC-Unique: B3HvE3YTN7Cpr8nrKNzrbQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33eca7270ccso28760f8f.1
        for <stable@vger.kernel.org>; Tue, 26 Mar 2024 11:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711476675; x=1712081475;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXAIJv9nAl74kU55mYeOMp2Ok3/4sY0r1ywNXMqvguo=;
        b=eCUUDnAXk1bPbA7S3Fq8d2YxFJUqZvqTUDcegE25mUkZrU28Nvf6zkWhgxBNhodreJ
         la5LUOCqT1r5nMxyjLd6qK4xwa7spufYvrqlxN6pOP4SjTLDdaKVO8eQfrk10TbV68MF
         AwtC2PFY3/UM4Ljk35mscv8D5rHxq/twromHMUTbjguD7gUzaS6WGFuok3Ga32sR88G2
         77EQRdAVdCoybrLFKtNwLkdhTG3ROnKlyS4HLGyIyOoip/heZspmuhiFSnOEnBzpx8+Q
         IoDooC27o3DPRlL40BlDgmeglddBlCILkNDx1/IpIoZyZsoOhiklZNSaH1u/08aNI42k
         XrPw==
X-Forwarded-Encrypted: i=1; AJvYcCX+qf2yOIVJPdpyHGAcFdDpSGxS+mQse3YaJYW1d6vP2dYH3SAaB7xiBx0YtYEtBcaK8Gk0ibITCSJkanRSdnY8p0WF97xG
X-Gm-Message-State: AOJu0YwpBjcGY4oJnXKx4lo3Bkj7rvx4nee1fW+y4zcfgVKA4ucNvyeo
	bJj5lEYLk1tG7mxQWalfVn+B1buE6/FwBbvRFTrenNIoCMW7+nkrAb9EBWXpTpbW9Oe9GTJNWRd
	0m6HzkFSjw5x59d6Py3HdlEnRixyt1+0hzN8lfDi5Eg7SVI3neGs+Uw==
X-Received: by 2002:adf:e2c4:0:b0:33d:7e9:9543 with SMTP id d4-20020adfe2c4000000b0033d07e99543mr1971438wrj.32.1711476674790;
        Tue, 26 Mar 2024 11:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYVGiSSOiyeqSQtOzZRq9B0JuObQm7Kc94Eg0TF3ptGNq3roaO1WUP51o8blzyw0Tqp3knjw==
X-Received: by 2002:adf:e2c4:0:b0:33d:7e9:9543 with SMTP id d4-20020adfe2c4000000b0033d07e99543mr1971419wrj.32.1711476674422;
        Tue, 26 Mar 2024 11:11:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c741:c700:3db9:94c9:28b0:34f2? (p200300cbc741c7003db994c928b034f2.dip0.t-ipconnect.de. [2003:cb:c741:c700:3db9:94c9:28b0:34f2])
        by smtp.gmail.com with ESMTPSA id ez19-20020a056000251300b00341c88ab493sm7842972wrb.10.2024.03.26.11.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 11:11:13 -0700 (PDT)
Message-ID: <8a4c167f-6dcc-4fe2-9edc-a722badd4df9@redhat.com>
Date: Tue, 26 Mar 2024 19:11:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [merged mm-hotfixes-stable]
 mm-secretmem-fix-gup-fast-succeeding-on-secretmem-folios.patch removed from
 -mm tree
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>, mm-commits@vger.kernel.org,
 xrivendell7@gmail.com, stable@vger.kernel.org, samsun1006219@gmail.com,
 rppt@kernel.org, mszeredi@redhat.com, miklos@szeredi.hu, lstoakes@gmail.com
References: <20240326180828.AC6E1C433F1@smtp.kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240326180828.AC6E1C433F1@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.03.24 19:08, Andrew Morton wrote:
> 
> The quilt patch titled
>       Subject: mm/secretmem: fix GUP-fast succeeding on secretmem folios
> has been removed from the -mm tree.  Its filename was
>       mm-secretmem-fix-gup-fast-succeeding-on-secretmem-folios.patch
> 
> This patch was dropped because it was merged into the mm-hotfixes-stable branch
> of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> 

I sent an updated patch that removes the LRU check completely. Still 
time to fix that? :)

> ------------------------------------------------------
> From: David Hildenbrand <david@redhat.com>
> Subject: mm/secretmem: fix GUP-fast succeeding on secretmem folios
> Date: Mon, 25 Mar 2024 14:41:12 +0100
> 
> folio_is_secretmem() states that secretmem folios cannot be LRU folios: so
> we may only exit early if we find an LRU folio.  Yet, we exit early if we
> find a folio that is not a secretmem folio.
> 
> Consequently, folio_is_secretmem() fails to detect secretmem folios and,
> therefore, we can succeed in grabbing a secretmem folio during GUP-fast,
> crashing the kernel when we later try reading/writing to the folio,
> because the folio has been unmapped from the directmap.
> 
> Link: https://lkml.kernel.org/r/20240325134114.257544-2-david@redhat.com
> Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Reported-by: xingwei lee <xrivendell7@gmail.com>
> Reported-by: yue sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/lkml/CABOYnLyevJeravW=QrH0JUPYEcDN160aZFb7kwndm-J2rmz0HQ@mail.gmail.com/
> Debugged-by: Miklos Szeredi <miklos@szeredi.hu>
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Tested-by: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>   include/linux/secretmem.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/include/linux/secretmem.h~mm-secretmem-fix-gup-fast-succeeding-on-secretmem-folios
> +++ a/include/linux/secretmem.h
> @@ -16,7 +16,7 @@ static inline bool folio_is_secretmem(st
>   	 * We know that secretmem pages are not compound and LRU so we can
>   	 * save a couple of cycles here.
>   	 */
> -	if (folio_test_large(folio) || !folio_test_lru(folio))
> +	if (folio_test_large(folio) || folio_test_lru(folio))
>   		return false;
>   
>   	mapping = (struct address_space *)
> _
> 
> Patches currently in -mm which might be from david@redhat.com are
> 
> mm-madvise-make-madv_populate_readwrite-handle-vm_fault_retry-properly.patch
> mm-madvise-dont-perform-madvise-vma-walk-for-madv_populate_readwrite.patch
> mm-userfaultfd-dont-place-zeropages-when-zeropages-are-disallowed.patch
> s390-mm-re-enable-the-shared-zeropage-for-pv-and-skeys-kvm-guests.patch
> mm-convert-folio_estimated_sharers-to-folio_likely_mapped_shared.patch
> mm-convert-folio_estimated_sharers-to-folio_likely_mapped_shared-fix.patch
> selftests-memfd_secret-add-vmsplice-test.patch
> mm-merge-folio_is_secretmem-into-folio_fast_pin_allowed.patch
> 

-- 
Cheers,

David / dhildenb


