Return-Path: <stable+bounces-137104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6054AA0EC2
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877DD1BA0700
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AFE2D3A76;
	Tue, 29 Apr 2025 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LW8QMV1l"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1B1297A54
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936978; cv=none; b=btPMYrWXVFMmp/L3npjVin5Y8CnIxlMGaC+GVNnIKRw6dLQEm4FD55dmLYeUwyFs3XyCU5TKOW05DndFAs+N/OqpgrLONTacADgB9/QrZ0p9JAxlBq+HQTAKveYqO0vqw+0Lj1IZFUXu6eoXgreYiaJQr2lE0vQVZQXOmTC2IUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936978; c=relaxed/simple;
	bh=bYjpzpGSgh7iX9YT8QAXY52bhzEV2a6Zasad9r4XzJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdSBfdhyV5/Qrtx0TpZD/HT6wIWil9pbW2Lkpp0uttrwYfKTul0taIcakRwp2oucevafMrrV5XXpZ7O1jvLTHyxZFTEesr7R4ljSzxJReMQm7BJ6GqtzwDEUcqBjS9ypXDBW+1dNwuaO+F8SepEfFTGGxa4jh6CX/E2bak4Tj8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LW8QMV1l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745936975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B8z4L48QRFqaAiHx6Eu9Jlazl0ASK2/Rc8vCLhZ6yKk=;
	b=LW8QMV1lZm1lgAJrRTjbNi/0T1BmWF67ClnrKi25TxAQ2+MIDrxGjE6i3NYVHedOBxMJCL
	ENDdluzAwJcXetXDShGvwRPVThIfWow0EaTgqeTw1lQtGMbx492LYisgihvJMrYDH2sVzm
	B5qdcs3atjX5bysklz/Trato+M9hbRg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-JERU-GLvMPuJ6CbFHo1ptA-1; Tue, 29 Apr 2025 10:29:33 -0400
X-MC-Unique: JERU-GLvMPuJ6CbFHo1ptA-1
X-Mimecast-MFC-AGG-ID: JERU-GLvMPuJ6CbFHo1ptA_1745936972
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so33138505e9.0
        for <stable@vger.kernel.org>; Tue, 29 Apr 2025 07:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745936971; x=1746541771;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B8z4L48QRFqaAiHx6Eu9Jlazl0ASK2/Rc8vCLhZ6yKk=;
        b=RInPM/HCgFRzLKlfNFXt1T3mLv76FwFOtXTIvZYF5zCHFCOXYtKENzHdUA1mzb74JD
         8OzrUk2soWVrQfToO5v/H7ZGXDEJg8uwi2zg2QQbbv+4NLW1XVbyVn5++2VxLD4a6etf
         YGIWgauA1m34qyUkNeAM3opeYbWXKE4zGQRlGZGKSFDf4Thpplp7Y7IwSWcUDYAlOKaM
         vkdYhTnkirEnlXPlZnmzs4sBfM3pvqaTVOU/qyKAjct+4aCMZ/+rgS59N1nP5esLL8E2
         XfC3avRXY5ogQnklnKZmWVzphB9TK9H1UT6tO/P230I/Im8KbAy4mlk2WNGqRoB0M5mb
         NBeA==
X-Forwarded-Encrypted: i=1; AJvYcCX3rqO5JjCeG7V6B1ycoEnNDdbe8BWKUvNHa0vgFPZw1s8SbPTUt38ZadEYIcmvCnNS3kMQZGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCVfzrBvkQqSgrb+4GQ1rkwLbToF5EpqhAaQor5t2HKCV9KHym
	Q5RiEzae8xlhNRjWrAikf1bnXakc8m3mxIv8bfyIbMZ4hPrjd5nhQ4vNSOC36Wo00ysvly4tnvH
	XGcPpF1OCZdsscKkJIGtKjjBbE28oRGjzhZUTircWLZpjDQ0elJIMog==
X-Gm-Gg: ASbGncuIkQsbvQu9/gPWQ2F2QFkYufu/Xmnk8ZntMMN94asfiVR1ujiietmromgMsn4
	g7e3RBaoNCAtDYg/5sIavBurJQ4xN+fDsKS0QoBmaJkFZKsSlotLIwpcEimkIE06iS8H7lrg0VZ
	F3oLK7720ISKuUXK28FuUlZVITUmifxru1JVAxJEBAHj2ek6Y/o643wE7ULIsjgJWAfkVWPulHI
	jwI+/2+mURiOTaMw5L9x1rwXdGjX3L+qFguljGMkLXfocHnTjLZoj88JGnuqAlNYQ0a3gh4qDFP
	1xpjgyBcHVksmDhP6I6wZajTJ+PnTs+6iMwOSFrlAK7y50WaXfk8yclp+ic+5n0YFKvUQHjXMZI
	6xOcXHEA9PVy25tAHWbdaViSR2KR9+B7IBCOwwhM=
X-Received: by 2002:a05:600c:19ca:b0:43e:afca:808f with SMTP id 5b1f17b1804b1-441ac89402cmr44083405e9.31.1745936971629;
        Tue, 29 Apr 2025 07:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWw90S1zebk8hR0LoN8radWJeQ4KbTeon6aL+rNQwWEM+bJ+J1s62JnaaDq1lhhWG2TgevIA==
X-Received: by 2002:a05:600c:19ca:b0:43e:afca:808f with SMTP id 5b1f17b1804b1-441ac89402cmr44083095e9.31.1745936971269;
        Tue, 29 Apr 2025 07:29:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73b:fa00:8909:2d07:8909:6a5a? (p200300cbc73bfa0089092d0789096a5a.dip0.t-ipconnect.de. [2003:cb:c73b:fa00:8909:2d07:8909:6a5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a538f691sm161011585e9.37.2025.04.29.07.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 07:29:30 -0700 (PDT)
Message-ID: <d53fd549-887f-4220-b0d1-ebc336eecb9f@redhat.com>
Date: Tue, 29 Apr 2025 16:29:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: Fix folio_pte_batch() overcount with zero PTEs
To: =?UTF-8?Q?Petr_Van=C4=9Bk?= <arkamar@atlas.cz>,
 linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20250429142237.22138-1-arkamar@atlas.cz>
 <20250429142237.22138-2-arkamar@atlas.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250429142237.22138-2-arkamar@atlas.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.04.25 16:22, Petr Vaněk wrote:
> folio_pte_batch() could overcount the number of contiguous PTEs when
> pte_advance_pfn() returns a zero-valued PTE and the following PTE in
> memory also happens to be zero. The loop doesn't break in such a case
> because pte_same() returns true, and the batch size is advanced by one
> more than it should be.
> 
> To fix this, bail out early if a non-present PTE is encountered,
> preventing the invalid comparison.
> 
> This issue started to appear after commit 10ebac4f95e7 ("mm/memory:
> optimize unmap/zap with PTE-mapped THP") and was discovered via git
> bisect.
> 
> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
> ---
>   mm/internal.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index e9695baa5922..c181fe2bac9d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -279,6 +279,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>   			dirty = !!pte_dirty(pte);
>   		pte = __pte_batch_clear_ignored(pte, flags);
>   
> +		if (!pte_present(pte))
> +			break;
>   		if (!pte_same(pte, expected_pte))
>   			break;

How could pte_same() suddenly match on a present and non-present PTE.

Something with XEN is really problematic here.

-- 
Cheers,

David / dhildenb


