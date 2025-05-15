Return-Path: <stable+bounces-144495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE6DAB8158
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 10:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319514A5B8E
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD3D28DF59;
	Thu, 15 May 2025 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bI5Sm1Sq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B81F28AAFE
	for <stable@vger.kernel.org>; Thu, 15 May 2025 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298984; cv=none; b=Bebk9qCBv7LPUUPkoJcEkn6xO+43op0jzuudilXkh9UT8tXF++B3VXMrTrZ5RhZmWlZLs0OdRT7mLsxQ1nhobleysw6WS1ld94prtxrv4SbD/xyErZ9e0B1K7rzNfqicz/E8W+t/HOe8dU05yZT8+9p3GqSitbOMmbPjNEaUBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298984; c=relaxed/simple;
	bh=kVKTp1u2T3K/2CbuM8jvK/+7c7/tfdpkS5Lf9BOkaqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W4Iqoi3GEjaksfnIIFJTCWALaYLwhevAfh1BBkmGhnvESH5MadscXEyZk3tdgjEU3B0nOB18TeFe73HV7fB0ejGDbUVqZNCHuPRXb+C7EYgQ0oe2Grvg4c7QdscILvvyQbYokHm0ALzcAwdRUgVHY40sPOWNT+aLMRdoATGZ4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bI5Sm1Sq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747298981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=numVHUGG76UJqn6luDC1PvM4Gdk34C40sFiPEgPwpO8=;
	b=bI5Sm1SqYSBqofzJdb29qn9AbWLCmyoVkTTjEpNaeoI7eh5pE4obUZaI/AeLkIr3rx40bM
	vC3jhXv0Q8slsFGuWvk+lYVcUbxK9sL852Lqe65aNMFt14pTkdkTKLXMV7cMhcixhzDXJK
	kr7MsKI5dzVhWE91ZFLcJuAJ6L5Qx4M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-JPBR0hcZMkOUJ71M8arg2w-1; Thu, 15 May 2025 04:49:39 -0400
X-MC-Unique: JPBR0hcZMkOUJ71M8arg2w-1
X-Mimecast-MFC-AGG-ID: JPBR0hcZMkOUJ71M8arg2w_1747298979
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so4750195e9.3
        for <stable@vger.kernel.org>; Thu, 15 May 2025 01:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747298978; x=1747903778;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=numVHUGG76UJqn6luDC1PvM4Gdk34C40sFiPEgPwpO8=;
        b=UcjpQkmNwP0mMN4HUZZYshqQ3rdZKkA234kfEaskcGO4jgAifzQ4XrwQyAKa+eZy59
         Df/O0lrGfEf98pwSYLmFbBgNrfm5Pb4GKfj0nVPqu4Oef0iMZPRRlaOgI9ZRjGqWK/wa
         TBBktZQTvGzlofTzrEM10xicv52NhaiB54FKabR+IDOtnRPWuWcoan9oQ5YFA404+PeX
         98Ab8VE23LXmA33W21vDdDvQF/eKgwOdILBdhZvZbbqF+wV65fP1D7NXT+pE/KwP/Gny
         4rnobCoSj5cjRGoZ/JY83VH3YDbIXppzzsILxhd0mBxQFUH4MLq0yF6Am+AVKkeK6uDh
         lKIA==
X-Forwarded-Encrypted: i=1; AJvYcCX95Fgqws09l9wivlEi8zQiRY9GxYbNvvWdJIB8MF/TUy4tPZd4UUTjqP4FIkiVVzvNYNnTFnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjjRemnssb2nLAsrRXxw3u+mtJyCrQSGCPdSxRiX4J4Voa+X8Z
	BU5zHrvgq+odhQCOTZRxB2Qmnv9lixr2UaDiCo2YjBAmEQOVNvZHkZOHCMFLMsmYQvpxssCOnfh
	AIQEo/dw+kTAQTYNXAXiq9R6dJi9s7PhgxJfDV1RG3MkdCMrz4fGLrQ==
X-Gm-Gg: ASbGncuX1Lr3v4CA3+SkjD+S5IgsR5kK0kny7kt6xfZwUi3mAQlBOuFNwMyO9MVtX/4
	A8gmfuTaAgGzBD9rik6D7SHuC/65JnWuFuOLU4sODk3D+2xGMSAaeuR8BhRzzkBDVHxQ18OCEuL
	a1xX1LYhz1M9Szv0jwAVu+L0vDQMRhx40mKqTt0sf3aJ4tA32JN5t6kdpeLIyfubBGBqIRcCfiF
	MR8fenGByyP4vXJupxgkervzBnlRK8LrlCQZ9p3m/bQ/6AVHPVai21eYK2UCiHyJ2Kp7KNbMdHw
	kbkfGkYnnCPCLxjJpAZIzTp/37+5sdGhuS4XEo/rPuy5vZT2ODDrAPPRU9XjjpGW44968tDDJrw
	PUztAefrFA0d/AknsVbQ/QvSFyIvcoW4NfUewDlI=
X-Received: by 2002:a05:600c:818d:b0:442:f8e7:25ef with SMTP id 5b1f17b1804b1-442f96e9395mr13742995e9.11.1747298978519;
        Thu, 15 May 2025 01:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF9Ljyx9InpG9QwACcNHvFcbbyugKq1zXFwEj77RI8E97AvX6NCU5d7dYmk90/DADgbbtlOg==
X-Received: by 2002:a05:600c:818d:b0:442:f8e7:25ef with SMTP id 5b1f17b1804b1-442f96e9395mr13742725e9.11.1747298978121;
        Thu, 15 May 2025 01:49:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4a:8900:884a:b3af:e3c9:ec88? (p200300d82f4a8900884ab3afe3c9ec88.dip0.t-ipconnect.de. [2003:d8:2f4a:8900:884a:b3af:e3c9:ec88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f396c093sm60263885e9.27.2025.05.15.01.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 01:49:37 -0700 (PDT)
Message-ID: <61da67fe-ba7a-4b9c-acb2-f1488f00a804@redhat.com>
Date: Thu, 15 May 2025 10:49:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Check pxd_leaf() instead of !pxd_table() while
 tearing down page tables
To: Dev Jain <dev.jain@arm.com>, catalin.marinas@arm.com, will@kernel.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, mark.rutland@arm.com,
 yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <20250515063450.86629-1-dev.jain@arm.com>
 <332ecda7-14c4-4dc3-aeff-26801b74ca04@redhat.com>
 <4904d02f-6595-4230-a321-23327596e085@arm.com>
 <6fe7848c-485e-4639-b65c-200ed6abe119@redhat.com>
 <73a67d06-b497-40a2-8cb2-3b80c6ba59d1@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <73a67d06-b497-40a2-8cb2-3b80c6ba59d1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.05.25 10:40, Dev Jain wrote:
> 
> 
> On 15/05/25 2:06 pm, David Hildenbrand wrote:
>> On 15.05.25 10:22, Dev Jain wrote:
>>>
>>>
>>> On 15/05/25 1:43 pm, David Hildenbrand wrote:
>>>> On 15.05.25 08:34, Dev Jain wrote:
>>>>> Commit 9c006972c3fe removes the pxd_present() checks because the caller
>>>>> checks pxd_present(). But, in case of vmap_try_huge_pud(), the caller
>>>>> only
>>>>> checks pud_present(); pud_free_pmd_page() recurses on each pmd through
>>>>> pmd_free_pte_page(), wherein the pmd may be none.
>>>> The commit states: "The core code already has a check for pXd_none()",
>>>> so I assume that assumption was not true in all cases?
>>>>
>>>> Should that one problematic caller then check for pmd_none() instead?
>>>
>>>    From what I could gather of Will's commit message, my interpretation is
>>> that the concerned callers are vmap_try_huge_pud and vmap_try_huge_pmd.
>>> These individually check for pxd_present():
>>>
>>> if (pmd_present(*pmd) && !pmd_free_pte_page(pmd, addr))
>>>      return 0;
>>>
>>> The problem is that vmap_try_huge_pud will also iterate on pte entries.
>>> So if the pud is present, then pud_free_pmd_page -> pmd_free_pte_page
>>> may encounter a none pmd and trigger a WARN.
>>
>> Yeah, pud_free_pmd_page()->pmd_free_pte_page() looks shaky.
>>
>> I assume we should either have an explicit pmd_none() check in
>> pud_free_pmd_page() before calling pmd_free_pte_page(), or one in
>> pmd_free_pte_page().
>>
>> With your patch, we'd be calling pte_free_kernel() on a NULL pointer,
>> which sounds wrong -- unless I am missing something important.
>>
>>>
>>>>
>>>> If you were able to trigger this WARN, it's always a good idea to
>>>> include the splat in the commit.
>>>
>>> I wasn't able to, it is just an observation from code inspection.
>>
>> That better be included in the patch description :)
> 
> I did, actually. My bad for not putting in spaces, I notice now that the
> description looks horrible to the eye :)

Ahh, there it is. Sorry :) Yeah, some empty lines won't hurt!

-- 
Cheers,

David / dhildenb


