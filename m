Return-Path: <stable+bounces-144791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F636ABBD86
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27CF317CEA7
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDF2274FFF;
	Mon, 19 May 2025 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkqRmcMl"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C312777E2
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657007; cv=none; b=r+Ls8/fiqv//hzJmMAKGSl8djkDDmXPKN5v8RxA863VTaRScFZmGoJ8/UZUxkZzeM+G01fvt9LoqO9LKAVhAd92Qo7wofyFT+nbgOC1HypuS1tqCnsSqGiCRVeigHVEPrI2M0DZeFOPuPC+iF2UvFgWoBrCHkJBAue3jDUJwAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657007; c=relaxed/simple;
	bh=YTEyE+Z/n8g7VJ4pj6iT+p6JYblxSGebhTD2MzLjg6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEntsiymQSjNfjm98NxJD1ACjUnY3ZSHJYQ8CZuT1Y9nFoXeuiKBVuNH+PMD//JgWjTyHa5d6NHc2SjgZ0oUpWduTg11Yl+o85t13MMA9xiCd9AwcCdGXo1WWvLDk9Cn7T6o6hV3Fi6lKzwiP2U1mFvONwO34bNHouhpZHPUQx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkqRmcMl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747657003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6cs79gj78E9HuZD7B3shEcJkEEWJc3uKfsWCTOqjuuE=;
	b=dkqRmcMlJIqAEdy55OsZFLlY8KQ2nnWR25ndTTaSPPQGBpoB8aLYoxEJn0AztHugK7mXXl
	9wKMW6Y7ht3cO/myZ3Sb3n2M03IWq8COp/UOWEzJqPjWczywEXWvtJYDr2TLckBCHCx/8/
	GNuSo6r5FcVYqjzyBV7mENXVDxIMYM0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-FF06mbSjMvurOwmN0TLPJA-1; Mon, 19 May 2025 08:16:39 -0400
X-MC-Unique: FF06mbSjMvurOwmN0TLPJA-1
X-Mimecast-MFC-AGG-ID: FF06mbSjMvurOwmN0TLPJA_1747656997
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so30821945e9.2
        for <stable@vger.kernel.org>; Mon, 19 May 2025 05:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747656997; x=1748261797;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6cs79gj78E9HuZD7B3shEcJkEEWJc3uKfsWCTOqjuuE=;
        b=SoklQCnayXPjjm9w/VoX8BQdZGastZDqNj0Q97NMYHYIU5fY9sKWFqm+GkBj4fHzMx
         RYIxXdL9PUb4FtaI6AG6RPjwUrV5Xcke53SYQy+eBiKSFA+KCs8SGipFRVUlMznn3JbH
         1z5R/9/R06x6DJhBuWa9HMg/JwrVuu6PVldSjgznaVfZHiJ93P/TbPc/7MmW0BLgNxf+
         qbBcuC5EzaqRsWofVxEvEfkGouUP1It+UlwN+UX9Wz9Utnx5E3rf9qlCJ3DfYW8thxQD
         /QI+slu4QEVLOxgUsh5Uc+cwUHRC/4V1Ye04HKl9Gv8x8OCROc0do+/LVedt5HPEbLIw
         +pKw==
X-Forwarded-Encrypted: i=1; AJvYcCX73HkKk4IhbxjcWVmEa85iR/7uf9mjJ0yObdXqUU3+PKBdaibomDqYUPgXEf/+3gWOXwRV4ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1To7jzyzRpBDrOcypUHnqaOVqx3t+VV/YGeI92PcPx4wKir60
	2lxdyrUT1Tg2gs/gNwEaW9MNYq4gHLzbgMVXi/OURiQEa9Iv5pS5Gjez3PnsrIzAsT2fWge0YMm
	QWSfnHOAqWecfdjj0IaRFfplcXh/lOlQgh3AChbHkPp+/PcXqk1JuW8oy1w==
X-Gm-Gg: ASbGnct6W0gA4+mL4OA5MIh+yEaJ45VlgwTcxY2pC6tE4yDWmJH86kUG/nHF4lLjFrE
	UnloVOeaG04rvPlBMHn9NhNKEy8AmCHBWH0aKB8dXmukHhC4tdDCUBHXPQj2gIc9ZhuRHPIoBhg
	e23lEARS/UeHsmXOuCziRNThUetNX04nlq6iYD1gw21I61VNsHnqCwCX3tL5vLy6/6kg0v5N3Ku
	UQ8jA5DIvDDz/Hh9cXaYmInj5C8rVnDNi1aLkxBD5eD2b4WOJyNRtNEHDJTopslM1xW9MD3YAeT
	ICtJtvb+FiBz7dugtWJSCOoHY4KOmOqUQh6FMH6b1vtHV8j8eXgSUGR2Q1UmeKsEKxLTgxW4i/4
	UoFgNC7JVqvhZje2Mi7sMnPMP4izJ6NHf+udb+Bc=
X-Received: by 2002:a05:600c:3e0e:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-442fd60a57cmr117473285e9.7.1747656997390;
        Mon, 19 May 2025 05:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkKYlzylFbF8WGsH6/sBuxt2KOCymDwHJRO+HoxFkF/kgAYd5xsYsKZ6encVzGoEsD7qznFw==
X-Received: by 2002:a05:600c:3e0e:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-442fd60a57cmr117473015e9.7.1747656997038;
        Mon, 19 May 2025 05:16:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f9053b4dsm165353875e9.4.2025.05.19.05.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 05:16:36 -0700 (PDT)
Message-ID: <7680e775-d277-45ea-9b6c-1f16b8b55a3f@redhat.com>
Date: Mon, 19 May 2025 14:16:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: Restrict pagetable teardown to avoid false
 warning
To: Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 catalin.marinas@arm.com, will@kernel.org
Cc: anshuman.khandual@arm.com, mark.rutland@arm.com,
 yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20250518095445.31044-1-dev.jain@arm.com>
 <5763d921-f8a8-4ca6-b5b5-ad96eb5cda11@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5763d921-f8a8-4ca6-b5b5-ad96eb5cda11@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.05.25 11:08, Ryan Roberts wrote:
> On 18/05/2025 10:54, Dev Jain wrote:
>> Commit 9c006972c3fe removes the pxd_present() checks because the caller
> 
> nit: please use the standard format for describing commits: Commit 9c006972c3fe
> ("arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table()")
> 
>> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller only
>> checks pud_present(); pud_free_pmd_page() recurses on each pmd through
>> pmd_free_pte_page(), wherein the pmd may be none. Thus it is possible to
>> hit a warning in the latter, since pmd_none => !pmd_table(). Thus, add
>> a pmd_present() check in pud_free_pmd_page().
>>
>> This problem was found by code inspection.
>>
>> This patch is based on 6.15-rc6.
> 
> nit: please remove this to below the "---", its not part of the commit log.
> 
>>
>> Fixes: 9c006972c3fe (arm64: mmu: drop pXd_present() checks from pXd_free_pYd_table())
>>
> 
> nit: remove empty line; the tags should all be in a single block with no empty
> lines.
> 
>> Cc: <stable@vger.kernel.org>
>> Reported-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>> v1->v2:
>>   - Enforce check in caller
>>
>>   arch/arm64/mm/mmu.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index ea6695d53fb9..5b1f4cd238ca 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1286,7 +1286,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>>   	next = addr;
>>   	end = addr + PUD_SIZE;
>>   	do {
>> -		pmd_free_pte_page(pmdp, next);
>> +		if (pmd_present(*pmdp))
> 
> pmd_free_pte_page() is using READ_ONCE() to access the *pmdp to ensure it can't
> be torn. I suspect we don't technically need that in these functions because
> there can be no race with a writer.

Yeah, if there is no proper locking in place the function would already 
seriously mess up (double freeing etc).

> But the arm64 arch code always uses
> READ_ONCE() for dereferencing pgtable entries for safely. Perhaps we should be
> consistent here?

mm/vmalloc.c:   if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))


:)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


