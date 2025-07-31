Return-Path: <stable+bounces-165664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB652B1719E
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 14:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E32BA82E2B
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2062C1591;
	Thu, 31 Jul 2025 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNLDZmrR"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DB2239E89
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966594; cv=none; b=f8kBAuMJrRihiHUPE8dl8OBS6SHTDeP3UFEarAPIOYzY1sMn2wgOo7EAmDDT9ViG4JXDZCAMQCWv/lpGZEqMuivDQf4mGR03tq8+i6weJN78umQaTDfrEkSkRrF1nR+lTCTYOaSf9q2uGJ6NkjnW9wU5g6mPhYr7hHGlZ6EI/h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966594; c=relaxed/simple;
	bh=RXeuAfQ4YDNnIha6BAWXMlvxcMYbfJ3/NcxuDcOMFgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bh+szUMKfTXpza86D/pYjQHMKBX5crvgdrnIucF9erFP2kJXBo44PWWZRozbLYTks36bG/EkhwuR+5MDVsxilIaseLAIDXe0LvcEz7+eqCy05HkvkdZs+Q0SQbUpSK4SKE1a96jIjod1g+nBtLCSXCZZbBdL9qCTb4uVnfXx36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNLDZmrR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753966592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UcOt3lDwl5HSBcRvfgdcxrISNXFWOJA2vLtr2p4qtLk=;
	b=RNLDZmrR0+oUXhTnZ7Q+/1LEvDGBAef9MHRl11+RncZtRpqLP+7YrOUCdzuST+mLBGhmFm
	nDlpur+YnkkaaMzRm8fDOOR8Z80gMQsVkvXvpnMp/leFpbBPJp7Nzw5v/ruORImharHgBE
	0xVjQBUjttDyTyd2MeiIqHO/GvJIEZc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-oFdc029wN5evDd67pr4yKA-1; Thu, 31 Jul 2025 08:56:28 -0400
X-MC-Unique: oFdc029wN5evDd67pr4yKA-1
X-Mimecast-MFC-AGG-ID: oFdc029wN5evDd67pr4yKA_1753966588
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7865dc367so290528f8f.2
        for <stable@vger.kernel.org>; Thu, 31 Jul 2025 05:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753966588; x=1754571388;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UcOt3lDwl5HSBcRvfgdcxrISNXFWOJA2vLtr2p4qtLk=;
        b=NzaAZBi8BGj4LD2gfbh89ucnhdKvUSEYVCE+f2XPWFfRNJgWRm+4FhZJRi7Nds0Tjb
         ArOwaZrFJ5UzVEs4tOJ8f6kByvS2yrX8qt3s1QVvjQpg1QizRbSIxjuJTPlkRQoxoISl
         JvlUBactbuuIfxYem1eYytkBHsw+hbdGyXJWhe3w6aJ8Wm1VDkh6R6ivMi6bVSma1RdG
         E9SwpvGb5Ftqud5AMyEe0qNy7+E716L2nkd4pTHhHhV+FJcE6fws8dcfhKXHHTLnJq7V
         REFYo+QxR0nqopgnrrxKcgTZv9HnORQ25WCInFMnM4xnS1O+/XF5aOz9VybfpEhchOfK
         9vmg==
X-Forwarded-Encrypted: i=1; AJvYcCXIoxOmlIn33npN/zQZd9vnlauW4H+YdkldmsbTxWqG1Q1NE059F6cY7p8ut13Anvf0D2q1T04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw90r9QIarXXAcBq/9DnZoahsFS3Bs+EM1nGKZm95mnag/RcMHB
	DCd7Uv+ppfx1Jwoh+4MmJaslv6rec4ahwWHbBvHpC7jqfKZ8lrdmypmF+d5ZSGHZxqQ3hhvG+py
	tFVEux9xkjJKzc5fUKGmAsvGde0R7QeF20ufIRMKOO4Iic5Tj5PpwKEfPqw==
X-Gm-Gg: ASbGnctNR/VmWxUWJYWj/s5YfPoob3BtrXWFGhPnf1ne5BVL+NrlsIBIOhcwzYfQntf
	0xesuYQJ636GFcDPT5jTOyz50LYyUZqt0yip1UVl6R0yr1Xge84V7nxpkaY/kjQaGuagm5XXkbU
	AnnjaNn3fXWdar2BjCZG6CcTBKauft1PAdT9KR9edBl1nq/kINwDsJIYf+NsyNSjNt+uEOVuVSt
	DiSWJRyTo3r0IGkT4EoPPCIEtbnNkWS/pqbENEb+BsCaQOTzQD0QV1xdQFHJ22xhInkrmtD2o1B
	LfMDTcilLC5Q66ag7tSV3//apRyxHTexuo5fXkdpRTYMFdSDT/h+65QAxcNIoDOlipk6LjDfG5O
	MU0UN/wdE+P9RtghfVNWQ2X1G5rMpZEAcAr2EKmBC3ZEdv9t2sjMxdtGP9OcW85wUHj0=
X-Received: by 2002:a05:6000:2911:b0:3b7:9917:8b57 with SMTP id ffacd0b85a97d-3b799178f06mr4399061f8f.56.1753966587601;
        Thu, 31 Jul 2025 05:56:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEUGKyzKSROBWxRnVn35DU5KVo0FuypEf8UC38ej6rUCj170PDhpYsaBjudCBG7WOmh6rwMQ==
X-Received: by 2002:a05:6000:2911:b0:3b7:9917:8b57 with SMTP id ffacd0b85a97d-3b799178f06mr4399028f8f.56.1753966587144;
        Thu, 31 Jul 2025 05:56:27 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f44:3700:be07:9a67:67f7:24e6? (p200300d82f443700be079a6767f724e6.dip0.t-ipconnect.de. [2003:d8:2f44:3700:be07:9a67:67f7:24e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a2f03sm2278296f8f.72.2025.07.31.05.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 05:56:26 -0700 (PDT)
Message-ID: <214e78a0-7774-4b1e-8d85-9a66d2384744@redhat.com>
Date: Thu, 31 Jul 2025 14:56:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration
 entries
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
 aarcange@redhat.com, surenb@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250630031958.1225651-1-sashal@kernel.org>
 <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com> <aG06QBVeBJgluSqP@lappy>
 <a8f863b1-ea06-4396-b4da-4dca41e3d9a5@redhat.com> <aItjffoR7molh3QF@lappy>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aItjffoR7molh3QF@lappy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.07.25 14:37, Sasha Levin wrote:
> On Tue, Jul 08, 2025 at 05:42:16PM +0200, David Hildenbrand wrote:
>> On 08.07.25 17:33, Sasha Levin wrote:
>>> On Tue, Jul 08, 2025 at 05:10:44PM +0200, David Hildenbrand wrote:
>>>> On 01.07.25 02:57, Andrew Morton wrote:
>>>>> On Sun, 29 Jun 2025 23:19:58 -0400 Sasha Levin <sashal@kernel.org> wrote:
>>>>>
>>>>>> When handling non-swap entries in move_pages_pte(), the error handling
>>>>>> for entries that are NOT migration entries fails to unmap the page table
>>>>>> entries before jumping to the error handling label.
>>>>>>
>>>>>> This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE systems
>>>>>> triggers a WARNING in kunmap_local_indexed() because the kmap stack is
>>>>>> corrupted.
>>>>>>
>>>>>> Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
>>>>>>    WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
>>>>>>    Call trace:
>>>>>>      kunmap_local_indexed from move_pages+0x964/0x19f4
>>>>>>      move_pages from userfaultfd_ioctl+0x129c/0x2144
>>>>>>      userfaultfd_ioctl from sys_ioctl+0x558/0xd24
>>>>>>
>>>>>> The issue was introduced with the UFFDIO_MOVE feature but became more
>>>>>> frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm: add
>>>>>> PTE_MARKER_GUARD PTE marker")) which made the non-migration entry code
>>>>>> path more commonly executed during userfaultfd operations.
>>>>>>
>>>>>> Fix this by ensuring PTEs are properly unmapped in all non-swap entry
>>>>>> paths before jumping to the error handling label, not just for migration
>>>>>> entries.
>>>>>
>>>>> I don't get it.
>>>>>
>>>>>> --- a/mm/userfaultfd.c
>>>>>> +++ b/mm/userfaultfd.c
>>>>>> @@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>>>>>>   		entry = pte_to_swp_entry(orig_src_pte);
>>>>>>   		if (non_swap_entry(entry)) {
>>>>>> +			pte_unmap(src_pte);
>>>>>> +			pte_unmap(dst_pte);
>>>>>> +			src_pte = dst_pte = NULL;
>>>>>>   			if (is_migration_entry(entry)) {
>>>>>> -				pte_unmap(src_pte);
>>>>>> -				pte_unmap(dst_pte);
>>>>>> -				src_pte = dst_pte = NULL;
>>>>>>   				migration_entry_wait(mm, src_pmd, src_addr);
>>>>>>   				err = -EAGAIN;
>>>>>> -			} else
>>>>>> +			} else {
>>>>>>   				err = -EFAULT;
>>>>>> +			}
>>>>>>   			goto out;
>>>>>
>>>>> where we have
>>>>>
>>>>> out:
>>>>> 	...
>>>>> 	if (dst_pte)
>>>>> 		pte_unmap(dst_pte);
>>>>> 	if (src_pte)
>>>>> 		pte_unmap(src_pte);
>>>>
>>>> AI slop?
>>>
>>> Nah, this one is sadly all me :(
>>
>> Haha, sorry :P
> 
> So as I was getting nowhere with this, I asked AI to help me :)
> 
> If you're not interested in reading LLM generated code, feel free to
> stop reading now...
> 
> After it went over the logs, and a few prompts to point it the right
> way, it ended up generating a patch (below) that made sense, and fixed
> the warning that LKFT was being able to trigger.
> 
> If anyone who's more familiar with the code than me (and the AI) agrees
> with the patch and ways to throw their Reviewed-by, I'll send out the
> patch.

Seems to check out for me. In particular, out pte_unmap() everywhere 
else in that function (and mremap.c:move_ptes) are ordered properly.

Even if it would not fix the issue, it would be a cleanup :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


