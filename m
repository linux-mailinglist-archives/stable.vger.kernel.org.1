Return-Path: <stable+bounces-183239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8413BB752B
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 17:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1A142674F
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 15:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7F828031D;
	Fri,  3 Oct 2025 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaC8rsrj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E31AF0C8
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759505428; cv=none; b=oSsHfRpX3xeJ6KnHmBZ6I4CJ5TYoB5Ai7tWsY57Yk1P2k+3BOOywjK+JN1Cwwajt64ukTUtsdbQcm+1DlNwLeNwAxSiuNob3i6c2Fg33oS2PO1olSuML5Imcy6bUIhbRu+t8Xg/TH4pyU6j6U2JKN1xlbIgMTPfvYZYceeSKDzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759505428; c=relaxed/simple;
	bh=6Gj5Pburfupv4j5dEK3lJoGa65Xi7aVs2ZdYFTTXo8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRf8tuD5P7eOvliEAZslCeRrPDuJFWaN3fCvpPhFxrr8T6Zne0hcZMP353Yi6+BZNA6dewRw56lONBOO/cXX7sYSqJj9UJsky4E22HUT3iQFzrwU7SOAzqG1R+ILDHtjH7I+NzkeFGvgh+YHzOEVivdUQESQMoZt4YJ7OHUQfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaC8rsrj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso14995465e9.2
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 08:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759505425; x=1760110225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ThghlDWAjurOxYC98aHbkMmCDK/KWDP3RpbWxUD1rs=;
        b=OaC8rsrjnm6kGW8e0axxiHyfZYMD/1DQxZpGh2+fYDRI7UkFgchryg8sOGmCCK0x+J
         AF9YlsGCr/47bMmaHceMzoUBYsdvDCvfoTlBbeQZPT1WdBjlMzo13rohfOKJKV7H1V8V
         8Gv6W2654Z9knz7Sn98eSJXwMtEfkstSn9/6z68Nf1LuH/ur8lFoTF4W3g9GkUy+GYv1
         QuOZtTwheB9aycBKOoBskSB00SGsXxDRDFqib1ivv23DShiQDPtBmXQ4SVQuFBEnf+go
         RQNA5CY1KoyqmlPl3Ib6SkeVADmcAbSm8RA4chW5a5ulrCCQz0EYGOhtUbsZEqI+k8n7
         SeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759505425; x=1760110225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ThghlDWAjurOxYC98aHbkMmCDK/KWDP3RpbWxUD1rs=;
        b=ci7CMx8MCwYyHPiK5F8oPld9utq3sJr7BVI174gFNH8k9tUV6o7KXku7DFA3iXTUul
         2HjUbHFEaSaVlxmFQjZ36VM2UyrOKlP+3FotTzjRXCL/QYkhZVD39QADE6vsktmfrW9g
         aotR2pqMYv19oCwQ856hlC/Kzosyt34AibpS+Vxd+XSKEmZPMXKNK+liw6Py2/C4TN9w
         A0OQJ51Kd7tWY40TSA5+tJOD3cEQz5S4iNt0bjPJcEdfbrHhiLKwUCQDK/GCpVn42Rtl
         mv30mFKAHiFQGteMFwRcfUy1ZUJI12wCd+jU6qMVIakIwFrnLS3thfz7yfz9B1jAeHJJ
         dVsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVj2QPpK/hDFPxU+BDjsVoIcf+lpOniU3D8yyKc/p9BWhMuTkRZQMlV4DL/V+eUpEmziST6Ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJreFV8gQZ5ce7xwlfvmCIZKVMyxGdZ6sKbRVbQ2oW/KFN2h+z
	4ekwbNWycw23RATVQAWxHlUgoMpLppa9EXmUk7jJyyQ+js/euF64TRJQ
X-Gm-Gg: ASbGncsWUpfmln4jQs4xYv+TBevCE509fZabV9c9rNXoUffA3py+oIqM3wTjUrx0n2h
	HS3Np9SxUDvLSzxDz2xKrkA0fxHsEQxCvwImnY0xK09tqBQtLSSKH+KEnBEOSVWmo95cDCpvMHt
	0Fznm9y1VQa+tqYpv7GBgIsJTMMdyYIEXIazJeKjXvz+iqQM4D03Thg6LF6mzM4ykDIECjSpY5M
	p/myAOU+RlsTkkHgpxhwEquhv5mFGgIyfWsns3el5KYc5wcX0OYAG32c8uPxN4wmlW4zVOlq3ct
	7l4aCeZ7dOYwdfuJ4AXrP86WMVThjPd7KHZQzi+15uYh71hzqKmglB5LRx2JXVyQN26eZvRHmcr
	f24Xxsyu4DFHRgHI61GPRQmyKyEiABjTIjg88vQZ2CF9diBmzyVRxf8yH8tXO4YvcUM0PmdvlDn
	P7PsmPRWaCqFzXh8SnBL4+5bNgp6MQNka5HQUyVZoImg==
X-Google-Smtp-Source: AGHT+IEREfLt3SJY1BFKHzWytZfJ9g4dT9ZMKAjBYAjJwr5+hXtXNDgkIQf10sLtLNpFjlYZ9kvUEA==
X-Received: by 2002:a05:600c:a319:b0:46e:74cc:42b8 with SMTP id 5b1f17b1804b1-46e74cc4609mr13969235e9.17.1759505424738;
        Fri, 03 Oct 2025 08:30:24 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5? ([2a02:6b6f:e750:1b00:1cfc:9209:4810:3ae5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4abcsm8332891f8f.53.2025.10.03.08.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 08:30:23 -0700 (PDT)
Message-ID: <29ac3e02-fb60-47ed-9834-033604744624@gmail.com>
Date: Fri, 3 Oct 2025 16:30:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] mm/huge_memory: add pmd folio to ds_queue in
 do_huge_zero_wp_pmd()
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, wangkefeng.wang@huawei.com, stable@vger.kernel.org,
 ryan.roberts@arm.com, dev.jain@arm.com, npache@redhat.com,
 baohua@kernel.org, akpm@linux-foundation.org, david@redhat.com
References: <20251002013825.20448-1-richard.weiyang@gmail.com>
 <d8467e83-aa89-4f98-b035-210c966ef263@linux.dev>
 <1286D3DE-8F53-4B64-840F-A598B130DF13@nvidia.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <1286D3DE-8F53-4B64-840F-A598B130DF13@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03/10/2025 15:08, Zi Yan wrote:
> On 3 Oct 2025, at 9:49, Lance Yang wrote:
> 
>> Hey Wei,
>>
>> On 2025/10/2 09:38, Wei Yang wrote:
>>> We add pmd folio into ds_queue on the first page fault in
>>> __do_huge_pmd_anonymous_page(), so that we can split it in case of
>>> memory pressure. This should be the same for a pmd folio during wp
>>> page fault.
>>>
>>> Commit 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault") miss
>>> to add it to ds_queue, which means system may not reclaim enough memory
>>
>> IIRC, it was commit dafff3f4c850 ("mm: split underused THPs") that
>> started unconditionally adding all new anon THPs to _deferred_list :)
>>
>>> in case of memory pressure even the pmd folio is under used.
>>>
>>> Move deferred_split_folio() into map_anon_folio_pmd() to make the pmd
>>> folio installation consistent.
>>>
>>> Fixes: 1ced09e0331f ("mm: allocate THP on hugezeropage wp-fault")
>>
>> Shouldn't this rather be the following?
>>
>> Fixes: dafff3f4c850 ("mm: split underused THPs")
> 
> Yes, I agree. In this case, this patch looks more like an optimization
> for split underused THPs.
> 
> One observation on this change is that right after zero pmd wp, the
> deferred split queue could be scanned, the newly added pmd folio will
> split since it is all zero except one subpage. This means we probably
> should allocate a base folio for zero pmd wp and map the rest to zero
> page at the beginning if split underused THP is enabled to avoid
> this long trip. The downside is that user app cannot get a pmd folio
> if it is intended to write data into the entire folio.
> 
> Usama might be able to give some insight here.
> 

Thanks for CCing me Zi!

hmm I think the downside of not having PMD folio probably outweights the cost of splitting
a zer-filled page?
ofcourse I dont have any numbers to back that up, but that would be my initial guess.

Also:

Acked-by: Usama Arif <usamaarif642@gmail.com>


> 
>>
>> Thanks,
>> Lance
>>
>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Lance Yang <lance.yang@linux.dev>
>>> Cc: Dev Jain <dev.jain@arm.com>
>>> Cc: <stable@vger.kernel.org>
>>>
>>> ---
>>> v2:
>>>    * add fix, cc stable and put description about the flow of current
>>>      code
>>>    * move deferred_split_folio() into map_anon_folio_pmd()
>>> ---
>>>   mm/huge_memory.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 1b81680b4225..f13de93637bf 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -1232,6 +1232,7 @@ static void map_anon_folio_pmd(struct folio *folio, pmd_t *pmd,
>>>   	count_vm_event(THP_FAULT_ALLOC);
>>>   	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
>>>   	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>>> +	deferred_split_folio(folio, false);
>>>   }
>>>    static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>>> @@ -1272,7 +1273,6 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>>>   		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
>>>   		map_anon_folio_pmd(folio, vmf->pmd, vma, haddr);
>>>   		mm_inc_nr_ptes(vma->vm_mm);
>>> -		deferred_split_folio(folio, false);
>>>   		spin_unlock(vmf->ptl);
>>>   	}
>>>
> 
> 
> Best Regards,
> Yan, Zi


