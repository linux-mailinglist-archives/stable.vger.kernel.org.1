Return-Path: <stable+bounces-144496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F107AAB81A5
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 10:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B006866FC9
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D6C28C013;
	Thu, 15 May 2025 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fw0bV684"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBEE29345D
	for <stable@vger.kernel.org>; Thu, 15 May 2025 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747299211; cv=none; b=X81YEguo4/z6vBMn+Z5x3paMQIZO0XYifHM54hjO7k5ZLRSLwAFmhqB5TepljlZxUnRmWBUqBTwZQSTH1TBx0HKJoxpAdsGMTECRGqKGmIaB0+c+X6UQhsWc37lOZ99o5Qj+84JLT9XJ0uNVoAc6vcRHCdLOh3zDdtj5HcB+TUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747299211; c=relaxed/simple;
	bh=gP5bYnarlJgPCAcYhBxdJqiGMfS3ZlaEJF4D8OrewcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKl/ra6DiNpXDrnJDbuHIEYlPD6X463ONqh/IljU2ox8evddBWnayx+Xrohh8de7RynagAEDwPhD6mVMj3VMzh6vwteDISjpwTQVie0a7sQKuJHZvdlynEOBgyT5zOI7+d4EIpAT8bwhAWGWXpf0WY77QMSGtgU7Z6fDN/fb6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fw0bV684; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747299208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mxFMYaptLLUT//IK4P864ymdu1SsueZ98Tp1MNq3RV4=;
	b=Fw0bV684IX7idkVlpRr0+x2vcnBQC3K1w2+2OLIs5k0D/0tLNDIw4QGm5w2jt4796Tm8z2
	zH2krEuFNBopjNGpaFdQFd6udHXKKb0IA3eS3VWvibUwQdhFB1cOr86J59E9rWluVQXnjQ
	813c9z9shbvPBTYR7oUkMi9bq9n7kaQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-JHzmWDc-OeuQ0J4hF_92ww-1; Thu, 15 May 2025 04:53:27 -0400
X-MC-Unique: JHzmWDc-OeuQ0J4hF_92ww-1
X-Mimecast-MFC-AGG-ID: JHzmWDc-OeuQ0J4hF_92ww_1747299206
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a206f05150so456207f8f.0
        for <stable@vger.kernel.org>; Thu, 15 May 2025 01:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747299206; x=1747904006;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mxFMYaptLLUT//IK4P864ymdu1SsueZ98Tp1MNq3RV4=;
        b=Gii/HSCLBuvV3upk1x1l9d+gkIxSwUWp8YEiuPzkuofejPJG02PZAck/YtYN2vjVRk
         k5RVKCZPKl8HZA3ZLHmI9Z8HMXpNRb+Gp4rOBcdattJKNbwWot2sUlBuGaDkZveclKgL
         YqTSIleuzDn3FvWGmvS8RtxzeX/aLn/KVNv83+O+o3mAhIj9doVrKMhmHYfT/jZwnc9r
         g8XGZkkieSt2cn+fvMOO6clhWSBn2cF6hY0qccYy6PpXX0gxZwtOQjIZ32+RtnjaA0Nm
         0eC96zdDC/ortp9Kg2ElXRnJp0I/X9XYwxw/fhFOFvkAHLAwfGxBAJikzU74nY9oQP1I
         DtDA==
X-Forwarded-Encrypted: i=1; AJvYcCXfFKSzTbgQK+r9gQcO7gKjZ6PPloAEsCOaFJ0SQg5fil/3jex9lvpCv/1YiGKG/ceVb1rH+dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05EMo4UsbigQIwv8NwPn5HzKGxie9NM7FV+nYMM8RPph45xsX
	S+oLvqwL9RnFG4iMnSv1lMSSc2wv6EFTS4edVW39Z7M4jfJLqeE8O/klW8LxmmCqyH9lLYMRWvl
	RN+/x6s83QcyFZP7uSni1WhHhRe6pffuWub3oOFnnAGMGSsvwb+qhUrEjRZMnlPG5
X-Gm-Gg: ASbGnctI2CtVfNDcldgPMb1qfKDE/nVEQDozyorbkiqG9zBm6XbkcfbwaQOiaGZWf3n
	WyJN+Pu6TudJheU/ONP0FnV+OnmEbytWrhAItwXqdj6Ia762lUA9P52G1aBj3PBSaCkMTr1S6iY
	4uQK2U9qyC0uvuGS56IMDVBkxD4XLuxPnq4v1I3u0FLwnsZF4XeCOjAI1Z34VXgVa34bWEx9pDn
	nl/mMEHrrOrvIccUEPA2170f18v6gZNeZCbRE1W0YGldz95obiORcFul1Htx1wHIpw6TmGEmwD4
	WNSZ68RwP/VKpI3Yz/KrqYkP1QZcXkboKLZHiBzdiHqU/96WxOpi8xSb43CE35DcL04wpYjNVq8
	2I5DrNe2TaxsDeBwJPEWwu7LYcgsbi7G0rF7fxks=
X-Received: by 2002:a5d:588b:0:b0:3a0:b635:ea43 with SMTP id ffacd0b85a97d-3a35374176dmr1365850f8f.33.1747299206226;
        Thu, 15 May 2025 01:53:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEsJz5zNV7+Zfbrzpouk886RkGlZnICJAg6K6r7C6mHK9QfUY97jHM/U62zf/Yv0DULdBX7w==
X-Received: by 2002:a5d:588b:0:b0:3a0:b635:ea43 with SMTP id ffacd0b85a97d-3a35374176dmr1365828f8f.33.1747299205872;
        Thu, 15 May 2025 01:53:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4a:8900:884a:b3af:e3c9:ec88? (p200300d82f4a8900884ab3afe3c9ec88.dip0.t-ipconnect.de. [2003:d8:2f4a:8900:884a:b3af:e3c9:ec88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c599sm22499647f8f.94.2025.05.15.01.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 01:53:25 -0700 (PDT)
Message-ID: <c06930f0-f98c-4089-aa33-6789b95fd08f@redhat.com>
Date: Thu, 15 May 2025 10:53:24 +0200
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
 <35ef7691-7eac-4efa-838d-c504c88c042b@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <35ef7691-7eac-4efa-838d-c504c88c042b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.05.25 10:47, Dev Jain wrote:
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
> 
> Ah thanks, you seem to be right. We will be extracting table from a none
> pmd. Perhaps we should still bail out for !pxd_present() but without the
> warning, which the fix commit used to do.

Right. We just make sure that all callers of pmd_free_pte_page() already check for it.

I'd just do something like:

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8fcf59ba39db7..e98dd7af147d5 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1274,10 +1274,8 @@ int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
  
         pmd = READ_ONCE(*pmdp);
  
-       if (!pmd_table(pmd)) {
-               VM_WARN_ON(1);
-               return 1;
-       }
+       VM_WARN_ON(!pmd_present(pmd));
+       VM_WARN_ON(!pmd_table(pmd));
  
         table = pte_offset_kernel(pmdp, addr);
         pmd_clear(pmdp);
@@ -1305,7 +1303,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
         next = addr;
         end = addr + PUD_SIZE;
         do {
-               pmd_free_pte_page(pmdp, next);
+               if (pmd_present(*pmdp))
+                       pmd_free_pte_page(pmdp, next);
         } while (pmdp++, next += PMD_SIZE, next != end);
  
         pud_clear(pudp);


-- 
Cheers,

David / dhildenb


