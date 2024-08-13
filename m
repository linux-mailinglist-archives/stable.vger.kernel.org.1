Return-Path: <stable+bounces-67435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF595012F
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA01D1F21E3A
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 09:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586E116BE2A;
	Tue, 13 Aug 2024 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSmnlmbu"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038F16D33F
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541280; cv=none; b=gZ0Als6ewnkAQhK1ogU2/HB59NcR32gptIIvRHMvkjq76dxkL68Y+kXiNDycw3jJeIVb6vaUPdCMSbAg5oAUjcUfxHFuW+Xy/lLO/JxGCJATeuuM6zD/9eyOO8BSE939urAdsDFC+r4qABGfGpjyRANq1eOKqzsLWT1h35AYvmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541280; c=relaxed/simple;
	bh=6pCeCYIk2vao5UPJVdUhjSfijenTKq264bviOrajOIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvyKoH/bZVn9DHECsCnP8EquLWjnRwK3Nb9zEcfVn+GObTDWtT2Xy3Fz5A8w+ua6Absq2CCx7xPeYIr+Z6Y9IJJyibs1+P1sJnweyl4RzLDoAjSN/kFEPO7O46LeHneoHv+AqtSlDdd8RyEYsNTjkVnWgUVrSoaT/GmNJvPY/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KSmnlmbu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723541277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MQA5cVwtWToXA0wdI+64PRoVzDTe1GQqMDVZb8yFTdg=;
	b=KSmnlmbuLNcnkOraSmdizMjNT6o0oWc/nfAhNer/bDgV/WtLQJ1TKgzPEjnAUn9woMW0dH
	zZUMKDnM9X/Q6QWVQ0KWT5qFJt8vJ90musJQWTxfskU7cBNfEFbdtHXLQXB9ptqsJn5nCF
	2oc5pDSkTaHKPVOstUcYF4HsIbVds7w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-WyYdpkY7NoeY-L-JNFq9IA-1; Tue, 13 Aug 2024 05:27:55 -0400
X-MC-Unique: WyYdpkY7NoeY-L-JNFq9IA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3685e0df024so3054548f8f.0
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 02:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723541274; x=1724146074;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MQA5cVwtWToXA0wdI+64PRoVzDTe1GQqMDVZb8yFTdg=;
        b=p5FIXC1uSk394057hLSLaQKTfyqmX+GfwDRDetfZond89MqAHBTbbaEUbt/OI8IhT7
         pVslkPfdu4QgXk49ebOPH4bLsdEBxITOVEIOV1w5EuENpAAbLOJl9E9KkhJAtTTP59d3
         Wi4Fn1nP2AVNoek5AKfWOwBbbCoZK2Y5TBbUqksvuS2lRMmO9dC64Cp1Fr4yqXPwFb0g
         oKcxGbZTwVQXJTb/pZG5l7/dRdphvJOxvDImv8muIxFVbbidkiAFS7KSCorY9SeUmMxR
         iZbLR1Uz2uDQmZ7wS7pVjg1k2E9RI6jVvfQjqFB7sxbUvh6XU3wWN/N0gj+VhZssjAU+
         8lwg==
X-Forwarded-Encrypted: i=1; AJvYcCVk/6bZ+CLRlUvUgYNcb9rmF/uIYVV7n+PJ1nAbc7gxEY/rOPEjb+xQSC/k2KbjF1RBE5E1JFCvExDxT7ChC7p6oeEMCv5j
X-Gm-Message-State: AOJu0YzPPyXLg8xDBFivm25NfBbhQ2KC9uG88knKRapYUr2SRdw/9LHA
	fqp0DFewfgIFi8SmzwL1mZLUvgZo1bMMYoH8Q9jvoz4B4xFmSjQIbLb3wSNjmGkJyn2VhZeiBCq
	4T6HVSZ9RGxYw0TCwKysFn3z55f1SonJnI+2XswWr7elikXmVxRyftA==
X-Received: by 2002:adf:8b1e:0:b0:36b:a404:500b with SMTP id ffacd0b85a97d-3716cd25187mr2505273f8f.51.1723541274534;
        Tue, 13 Aug 2024 02:27:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkaiYC4aV7+4PrXE2fyCwg+bp3r/cQMr845MDzOG0bwz6PKEJpViC1cTHDPaNW3mBNCbUvIQ==
X-Received: by 2002:adf:8b1e:0:b0:36b:a404:500b with SMTP id ffacd0b85a97d-3716cd25187mr2505253f8f.51.1723541274021;
        Tue, 13 Aug 2024 02:27:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfee31fsm9640140f8f.47.2024.08.13.02.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 02:27:53 -0700 (PDT)
Message-ID: <5d7059b0-9e2f-4f50-9316-f2cd63d0d909@redhat.com>
Date: Tue, 13 Aug 2024 11:27:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] userfaultfd: Don't BUG_ON() if khugepaged yanks our
 page table
To: Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Pavel Emelyanov <xemul@parallels.com>, Andrea Arcangeli
 <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240812-uffd-thp-flip-fix-v1-0-4fc1db7ccdd0@google.com>
 <20240812-uffd-thp-flip-fix-v1-2-4fc1db7ccdd0@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240812-uffd-thp-flip-fix-v1-2-4fc1db7ccdd0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.24 18:42, Jann Horn wrote:
> Since khugepaged was changed to allow retracting page tables in file
> mappings without holding the mmap lock, these BUG_ON()s are wrong - get rid
> of them.
> 
> We could also remove the preceding "if (unlikely(...))" block, but then
> we could reach pte_offset_map_lock() with transhuge pages not just for file
> mappings but also for anonymous mappings - which would probably be fine but
> I think is not necessarily expected.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>   mm/userfaultfd.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index ec3750467aa5..0dfa97db6feb 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -806,9 +806,10 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>   			err = -EFAULT;
>   			break;
>   		}
> -
> -		BUG_ON(pmd_none(*dst_pmd));
> -		BUG_ON(pmd_trans_huge(*dst_pmd));
> +		/*
> +		 * For shmem mappings, khugepaged is allowed to remove page
> +		 * tables under us; pte_offset_map_lock() will deal with that.
> +		 */
>   
>   		err = mfill_atomic_pte(dst_pmd, dst_vma, dst_addr,
>   				       src_addr, flags, &folio);
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


