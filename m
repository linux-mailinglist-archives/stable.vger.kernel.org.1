Return-Path: <stable+bounces-137106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146AFAA0F72
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951C14A3368
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A0221ABD3;
	Tue, 29 Apr 2025 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqQGDr2r"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D41215F6C
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937987; cv=none; b=Vkfq7Kmr4o73scLGCeb7NU3cvxT1ZUm+sQhxTJOlnTFJWkJctKghBEgKys+SioRkV/sk7Hh544SIE1+Qrw9Tq0OGDkoawgEplHezKi65fWTheT+EtEyk0NuI7bXp7YBQQqkX65Xz1rZjhA6Pt6FzSlc5ryYNeuMoRqpYPddqstQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937987; c=relaxed/simple;
	bh=snIS4vhGRssXnoN1pY7HJdNuGFL3by2NCS3TDRu4gFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2N/+g90bo5dYO1+B8BUbXM+UcXYtCiBT5ueXLTtR6hPOxIzufzRqwvwUMFtP8RwVixEid+WUB+o1jEZKd77ZisRRnaSJhNfzjGFlovPbI7tRSLCJaP9T/bieQNnSJaGLUMzTkSnDaw3guPLsrqVy8VvoRynbWvc+J4hScVPZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZqQGDr2r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745937984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=So5S8sD+I2YgOYOjQZKvpf3wIivuDABn+zCCZb8ZZ+4=;
	b=ZqQGDr2r+UfNg5WHljRW4OzzF+D/tZwdgDEsocEaAOjaeKS8DlsHwmKgp4EqXsC8Ei/+Ki
	dpl46BQpA3z9ng2W1VQGT/fAZ0POT2hTSNpLZ38xX3BhTNTS1VfN66RZJJMidg2FWnkzFd
	vOXdJ/0Qr0UQND47+w34ZCOoPEt+6cg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-M1fAHax3MdC3ADkFekwBhg-1; Tue, 29 Apr 2025 10:46:22 -0400
X-MC-Unique: M1fAHax3MdC3ADkFekwBhg-1
X-Mimecast-MFC-AGG-ID: M1fAHax3MdC3ADkFekwBhg_1745937982
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a064c45f03so2702396f8f.0
        for <stable@vger.kernel.org>; Tue, 29 Apr 2025 07:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745937982; x=1746542782;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=So5S8sD+I2YgOYOjQZKvpf3wIivuDABn+zCCZb8ZZ+4=;
        b=I2xpK3JalSGicnJZBWq/9/flfHsH1gemtt1+gBCx1n4VEfh9y2DfkbinffO8xFZWZW
         kJz9lfOCJB4LDYCloZAFkH1Iy1MOcjAebNeIn+CetwVoi+2bfrQcbYri7+Kuqz190qAy
         Vdy1aUS917pqRcz0jFvasS/FNd3IUFO95/So3M0SnMhDetN1pVV5cRqglERGKmy/fN4q
         4VMqSab+4H/gBFlyxWeU7s6mZiJ1jgsTRHoUDk1hk9ctS1MUqdxVtkSwTmnhZQYxz7cw
         fmFECsupVYE/H3dFKi/G4GZe9bc4avxIoBy8f85upyrme2sqeJqUcSjzHRyrP6pEA8pd
         ZNwA==
X-Forwarded-Encrypted: i=1; AJvYcCXcKbubxgBbcha18P+vecL2wnSzeR0+Sgi4mNTl4Xqrt0LTcArrHALkiCla3WVPU9UDhk7uWuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXNFGlUgznvwTZ7MmwUZCQbom8PuEMhMKAYkApDHFepTIAGl8N
	m6XEHodc8JbJ7R+pSRDAR0bZtpj//dvyfFW5YuFSFoEeoZdxmW1wWcUWry4b0DMxb77MlNb7bk7
	aRKD1I+Jmjs6W8SyUjNWWf105FIKKNmz3ZJocm6+ky4Evd9T00cMElQ==
X-Gm-Gg: ASbGncuazBrT9+LDBB0rYSGwRj7Ma9G1rwO/4cvvjjmIPb6xjm+gornzjU2krUnspIa
	xcqOOyocuFG+qCpnnikHsCTXwx0wTuJifBg1SKntYhrV34Ipues3qF3zqE5i10/7wKI7dULNQJn
	5JpS0q4Gxu2hRtJtQq0+sKAUCuF/CtUhUwY9JXpj7DMvWPdRX8FeNKMTt5kh8Wkc/u82qTExdJK
	fi9DoOTd1Nmzvmaj2fH8NehxnL7jfLvzTizmedO+81hT98vqBecOpWAzP/7nRiCm1gQ2DOcVWFH
	UQfq8yQTJ6IZGTWZqLmA38EI5nVlsf/W2W0CcO3KchFdxW64DjNtIKE3gr+9o6eqNASe/GV0hHW
	ra2Tp3matUWpcBnoym3sr1qr7CcVACS3eyJ0saJg=
X-Received: by 2002:a05:6000:2a1:b0:39f:d0a:5b23 with SMTP id ffacd0b85a97d-3a08a51fb97mr2658108f8f.17.1745937981620;
        Tue, 29 Apr 2025 07:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6dsJBdR+bHHaU2+8egweIE2dJ2t0DU4uwXHc22E2qh371BmcqxNVEvlNIK7604ghEWaDtdg==
X-Received: by 2002:a05:6000:2a1:b0:39f:d0a:5b23 with SMTP id ffacd0b85a97d-3a08a51fb97mr2658084f8f.17.1745937981197;
        Tue, 29 Apr 2025 07:46:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73b:fa00:8909:2d07:8909:6a5a? (p200300cbc73bfa0089092d0789096a5a.dip0.t-ipconnect.de. [2003:cb:c73b:fa00:8909:2d07:8909:6a5a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5e345sm14319611f8f.94.2025.04.29.07.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 07:46:20 -0700 (PDT)
Message-ID: <bb24f0d3-cbbf-4323-a9e6-09a627c8559b@redhat.com>
Date: Tue, 29 Apr 2025 16:46:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: Fix folio_pte_batch() overcount with zero PTEs
To: Ryan Roberts <ryan.roberts@arm.com>, =?UTF-8?Q?Petr_Van=C4=9Bk?=
 <arkamar@atlas.cz>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20250429142237.22138-1-arkamar@atlas.cz>
 <20250429142237.22138-2-arkamar@atlas.cz>
 <d53fd549-887f-4220-b0d1-ebc336eecb9f@redhat.com>
 <e9617001-da1d-4c4f-99f4-0e51d51d385e@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e9617001-da1d-4c4f-99f4-0e51d51d385e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.04.25 16:41, Ryan Roberts wrote:
> On 29/04/2025 15:29, David Hildenbrand wrote:
>> On 29.04.25 16:22, Petr Vaněk wrote:
>>> folio_pte_batch() could overcount the number of contiguous PTEs when
>>> pte_advance_pfn() returns a zero-valued PTE and the following PTE in
>>> memory also happens to be zero. The loop doesn't break in such a case
>>> because pte_same() returns true, and the batch size is advanced by one
>>> more than it should be.
>>>
>>> To fix this, bail out early if a non-present PTE is encountered,
>>> preventing the invalid comparison.
>>>
>>> This issue started to appear after commit 10ebac4f95e7 ("mm/memory:
>>> optimize unmap/zap with PTE-mapped THP") and was discovered via git
>>> bisect.
>>>
>>> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
>>> ---
>>>    mm/internal.h | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index e9695baa5922..c181fe2bac9d 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -279,6 +279,8 @@ static inline int folio_pte_batch(struct folio *folio,
>>> unsigned long addr,
>>>                dirty = !!pte_dirty(pte);
>>>            pte = __pte_batch_clear_ignored(pte, flags);
>>>    +        if (!pte_present(pte))
>>> +            break;
>>>            if (!pte_same(pte, expected_pte))
>>>                break;
>>
>> How could pte_same() suddenly match on a present and non-present PTE.
>>
>> Something with XEN is really problematic here.
>>
> 
> We are inside a lazy MMU region (arch_enter_lazy_mmu_mode()) at this point,
> which I believe XEN uses. If a PTE was written then read back while in lazy mode
> you could get a stale value.
> 
> See
> https://lore.kernel.org/all/912c7a32-b39c-494f-a29c-4865cd92aeba@agordeev.local/
> for an example bug.

So if we cannot trust ptep_get() output, then, ... how could we trust 
anything here and ever possibly batch?

-- 
Cheers,

David / dhildenb


