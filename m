Return-Path: <stable+bounces-145045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0073ABD2D3
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 11:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8731BA224E
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE24266EE7;
	Tue, 20 May 2025 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWaut7Km"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBCA264621
	for <stable@vger.kernel.org>; Tue, 20 May 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732212; cv=none; b=hfhXR4k2cI3G8RPYjiFt5a58QBucQMEtSqxVJAWOT6IkjdMOI0Ub1ZlArp0q8r9UcLCpNAdlYzFktCyZz7J12r976CvI+gsaus/JM0k/NRvt1ZIwVa3/fkCYFw5lcCvGgfct0dKoOTElHHSqFc8Dqka5o4H7/SPnaALfi43vsYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732212; c=relaxed/simple;
	bh=QRmAV0gSmSUP0f7c6LscqVGt+B1LZxtU9Yvv7ylAOYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6k6h14Q33dKpFrD3SwPDZ0MKUdqpSXsAHP0kdSlZ3OQe/Ofnvdkpnaqm88wlT75sISo3+4RgWLYxay76ZtMP7E6SbVNqfyJ5LlptPq33vz7vstOUBpc2XfpeVen+0C6L3iV8cetgRVi/7ARZQdr36eGN5A7n8JKdo30QolhaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWaut7Km; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747732209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PSR1/u0V+jGJxOjEFN3NNH+g3uaL+3CXLAVsxo/mjXA=;
	b=MWaut7KmQaUQ7nv0dMcSF76eNavtfO5yKmb9en361b7EneTtUa7hoCUd63qGIuq2VXanIt
	D2tVgTSkrR2ZkWoxrNdH/IUWVtPYZST7LAjUKvGmhD0yOSGKBsHIa2keT22M2FpdQbMcrL
	VDuaxO2rgZo9Zx9jYx8KcKXUmbnkmuY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-vzK5UUYHMx28Y0J6_Bxt0g-1; Tue, 20 May 2025 05:10:07 -0400
X-MC-Unique: vzK5UUYHMx28Y0J6_Bxt0g-1
X-Mimecast-MFC-AGG-ID: vzK5UUYHMx28Y0J6_Bxt0g_1747732206
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf446681cso32964225e9.1
        for <stable@vger.kernel.org>; Tue, 20 May 2025 02:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747732206; x=1748337006;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PSR1/u0V+jGJxOjEFN3NNH+g3uaL+3CXLAVsxo/mjXA=;
        b=RO9hWDcmFCJrbgFUh72bka/70TmOmJlxbuNOfy9pV8wTxcF/3vChhRqmTl9xChr92t
         tWogmAY7k2R6ShxyD/mxOP88VgHPLFsj4UfzCbs0UTSSVEBGtEfntQ09aJE+4IcQDXKh
         TmBwRnjU8EYDupyojAzAFT6VaN1IC/BzITNhuk1w0FB85bBwxApsBs3Z/T4Z56/U0TlM
         nHuysF8h/BPNsO+TgpxIMybQUfVmsM2HvndyDYzAJQnCPK+gxQaJ7bWpA59JnW4huv9a
         4Z6WJsRv8tWMik5gqxP7Cy2+67XOEqQxgM6eZGw6L+wbNDlmVJPWZpvVpKfAgmV7Hs5w
         7DrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvu7FczN51zFBcHFN2omXl1VonZmHm0lrxH00iWVIieIX7Iz14rhfQtDovHv35GDCxGn+IvGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL58H5JRCz5cPoq4qwzKXKnIVa309guG6iX3QJ+eYthbSPSrAx
	blp+IZo/ELHZJd10Wf1etvixsqoJCAuxehL0D+wRgOJn06IsJxugdS/tKjbfoLIO4vSjwmWAnLg
	zIx3qwYHYpRN2rkH/JZssENZdhL8b1nuVgdUb9H7eFfTBY7F/glrPAiFimQ==
X-Gm-Gg: ASbGncuNG2JE5yLEL3pHoCPozuIDrA52SgpL1X7A8iqp690GmEma9WiejtwK3lB8vYW
	7g8U9bAnufLF0onFUMY4fELsok17YnGignDeb7MEdIWvspRc5jSSY4vMWg3i1jC5KoTe1T+Zf+b
	B/xNiAIF/vWL9sN+lQdIxuOtJXnbJS2VTZKzBWVkUHSF9/qy3w5jI0bpCoidl276DyKn1HOiPzL
	0vH49j23fI89EJhsA84HVwCVymgbIM/FSBx5Z9s25A3PIvR3+OCIK4hVZaIrADsLbRYBJFG6bSH
	QuZZel/cKeevwp99Q1n42+sYBearhx8lDwSz3/JX5QXfJLmo5BaNRXLyselq6miuz0DH8BeQb0g
	nyFXb2HS0lWvX98V+WeBimF03rEOVdN6k1m83eVY=
X-Received: by 2002:a05:600c:5008:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-442fd622da0mr155950795e9.8.1747732206182;
        Tue, 20 May 2025 02:10:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg+fp/L4WVymGk9SPSBtpbctVG+Z2wbaOjNHfL4pL3y/IW6svbACJGKerPgXy0imMXlFDQmw==
X-Received: by 2002:a05:600c:5008:b0:442:f482:c429 with SMTP id 5b1f17b1804b1-442fd622da0mr155950525e9.8.1747732205777;
        Tue, 20 May 2025 02:10:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f16:e400:525a:df91:1f90:a6a8? (p200300d82f16e400525adf911f90a6a8.dip0.t-ipconnect.de. [2003:d8:2f16:e400:525a:df91:1f90:a6a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1825457sm24064175e9.1.2025.05.20.02.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 02:10:05 -0700 (PDT)
Message-ID: <021dfe38-f786-46d0-a43f-769aff07b3f0@redhat.com>
Date: Tue, 20 May 2025 11:10:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: Restrict pagetable teardown to avoid false
 warning
To: Dev Jain <dev.jain@arm.com>, ryan.roberts@arm.com
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, stable@vger.kernel.org, will@kernel.org,
 yang@os.amperecomputing.com
References: <df7eb016-bea4-489d-aecb-1a47eb5e33b2@arm.com>
 <20250520090501.27273-1-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250520090501.27273-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.05.25 11:05, Dev Jain wrote:
> On 19/05/2025 13:16, David Hildenbrand wrote:
>> On 19.05.25 11:08, Ryan Roberts wrote:
>>> On 18/05/2025 10:54, Dev Jain wrote:
>>>> Commit 9c006972c3fe removes the pxd_present() checks because the caller
>>>
>>> nit: please use the standard format for describing commits: Commit 9c006972c3fe
>>> ("arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table()")
>>>
>>>> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller only
>>>> checks pud_present(); pud_free_pmd_page() recurses on each pmd through
>>>> pmd_free_pte_page(), wherein the pmd may be none. Thus it is possible to
>>>> hit a warning in the latter, since pmd_none => !pmd_table(). Thus, add
>>>> a pmd_present() check in pud_free_pmd_page().
>>>>
>>>> This problem was found by code inspection.
>>>>
>>>> This patch is based on 6.15-rc6.
>>>
>>> nit: please remove this to below the "---", its not part of the commit log.
>>>
>>>>
>>>> Fixes: 9c006972c3fe (arm64: mmu: drop pXd_present() checks from
>>>> pXd_free_pYd_table())
>>>>
>>>
>>> nit: remove empty line; the tags should all be in a single block with no empty
>>> lines.
>>>
>>>> Cc: <stable@vger.kernel.org>
>>>> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>> ---
>>>> v1->v2:
>>>>    - Enforce check in caller
>>>>
>>>>    arch/arm64/mm/mmu.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index ea6695d53fb9..5b1f4cd238ca 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -1286,7 +1286,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>>>        next = addr;
>>>>        end = addr + PUD_SIZE;
>>>>        do {
>>>> -        pmd_free_pte_page(pmdp, next);
>>>> +        if (pmd_present(*pmdp))
>>>
>>> pmd_free_pte_page() is using READ_ONCE() to access the *pmdp to ensure it can't
>>> be torn. I suspect we don't technically need that in these functions because
>>> there can be no race with a writer.
>>
>> Yeah, if there is no proper locking in place the function would already
>> seriously mess up (double freeing etc).
> 
> Indeed; there is no locking, but this portion of the vmalloc VA space has been
> allocated to us exclusively, so we know there can be no one else racing.
> 
>>
>>> But the arm64 arch code always uses
>>> READ_ONCE() for dereferencing pgtable entries for safely. Perhaps we should be
>>> consistent here?
>>
>> mm/vmalloc.c:   if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
> 
> Yes, I saw that. I know that we don't technically need READ_ONCE(). I'm just
> proposng that for arm64 code we should be consistent with what it already does.
> See Commit 20a004e7b017 ("arm64: mm: Use READ_ONCE/WRITE_ONCE when accessing
> page tables")
> 
> So I'll just use pmdp_get()?

Maybe that's the cleanest approach. Likely also common code should use 
that at some point @Ryan?

-- 
Cheers,

David / dhildenb


