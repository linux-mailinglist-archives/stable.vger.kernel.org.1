Return-Path: <stable+bounces-165744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7B9B18374
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 16:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B997565340
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C3626B759;
	Fri,  1 Aug 2025 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OO/u4c1/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16AC26C3A2
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057624; cv=none; b=qnnl6vELfy3hmtuMe4HHe5YQ/V82MaEiT9DglYGp7I3TMaanpGD8p4ueucSWfqDQWa3mUsgpyp77a+q3VJ7LLiMTxdpnKvg486Ql3O3FayvbCWTEcsy3yhLinqkckzG8Zw2ViMDqVOsLTg8lgKYrVHmJVE38N15N1tQCAjENjDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057624; c=relaxed/simple;
	bh=kvbVEF7c9SDapc6JykRKt8pOB7KOFmfvV7rTwygDQAI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DOc3uDWpVli/Fz4gKvZKFsJ3NDb5+g9T86Ek7EbqtniChLja5AKVP7ebYvrYlzMgj9io0uxlCxYbjNDEhlh4YRk5ycqAND7RePT8QlZf3Yx6mimh6PKDPWjYUecPaENQt2GJuEUbmo9o2GJZpgFH3tqOampJ0BniOsSqOak7Aio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OO/u4c1/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754057621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EbFv2TD7NDloKozndUcyagdfd/67A0nNkTyyQSYo1J8=;
	b=OO/u4c1/RIzkLtmdXN0ce4l3cJ06MNu20FIjmDV6+ceDyWVWlVndOy9e3eL7HoRPRylDDo
	FHpjdAqod+jWy++LNbshv0eydf8Uoic7cHnDUw7slTnpOxvJTvowD26BryiSC7hiibZnbV
	mEdlt2zchqhIBb05XGnKK/7SrmDXXRQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-S6BIC-FxPdyVIFc0KLE-DQ-1; Fri, 01 Aug 2025 10:13:40 -0400
X-MC-Unique: S6BIC-FxPdyVIFc0KLE-DQ-1
X-Mimecast-MFC-AGG-ID: S6BIC-FxPdyVIFc0KLE-DQ_1754057619
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b78a034d25so1666221f8f.0
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 07:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754057619; x=1754662419;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EbFv2TD7NDloKozndUcyagdfd/67A0nNkTyyQSYo1J8=;
        b=mI639GFFk6SgyQlQrVQQagULmASvvCSVRtt6y7lmpy1nxKmezJ/E+9UUr7/wm+KHko
         w1H8YS8miRJP6BxESPxD5rXQ4dPt5jeaM5SZw+suf63TRkLlspgqVp1RzB7+RiiqziOx
         BARh8mL46YPJaT/lTKjrKds1pzQ0fZdnXxzXWktxE9aH49aL7GdL/bTmeXoxkRBlSfI6
         tJUXiJk91idwKT1qmMG0GdueNyc22hP3ebvX4DCozxGVfgh0tb/vVDPyYhWiC9ywSsDi
         XhLVuc9RIamCtrE4adAGBZxDiWh/sL1K4wQWhO+DO2XPsq7JNrZ9RgA5WmIjSQIXhIYf
         XsXg==
X-Forwarded-Encrypted: i=1; AJvYcCUxmUYDUpGd9/SMgGjpktXaFEHxCEbmjpt5rlX33F4GRSMbrdEtSHXDuGbpB4MFNqbQQBw9yjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5/LFy+vcxQ+IGQPoMu1irnkvm43tBDzNAIH9XwCwkqwVI9i6
	S4ZhCMw4jET4bCoxH5mD558nK0JH5ymiOJuycBpNqcoiAiS7ErweP3znIVuSflRg1y2fejPee5S
	sk5HIGw/fNOaKd9xwmtsLLE7ywuox4u0C//Y6O9+zHEFGLvenevUKQw6N5Q==
X-Gm-Gg: ASbGncsG59nIUXYNxfedveFD3a7kzo86KczhlDuZ3qtb0wuwzXKmw9C9R53ao4o+CZB
	KNbobloRNwDuel3fCRNU8ER1+Z1+nrSmoIwnpdi6nvX3FQSQRV3S7UzroxxfQQNsVSF8JYsLr2L
	nNJ20IEKa2estoryNJ9U0YYc25Gg08tGPuJb6hpZBDyVL0J6gFMHDbYYQdbe0E68wMgn8YRQ1b6
	T24vHgLUUl832TZCK/rDfmOf/bJaNYmKUhLphkuFRk0XQG/Z/CFzVrqiiNIT0XFdZCpybFynfHw
	7cn9maqTips+/CKv7X9lY7JPAPIFydEsqXCfz2xax72K5GYNj/RoPDVR8ujtOVlDHUnjhH20kO2
	7eEMbXYgrP2CFrRrvE86i4dEWoThTi+PcnTtxYkDdTRVECJphYZm4mqon3PjVKBr8
X-Received: by 2002:a05:6000:401f:b0:3b7:76e8:ba1e with SMTP id ffacd0b85a97d-3b794fe4fe6mr9647138f8f.11.1754057618875;
        Fri, 01 Aug 2025 07:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJTKNrIL7Q9PR+TZ1c1/4AnaNhnzCQk8bo5y4cNtdcfLm5Ah+gjARoH1ht5K9SxH9oWHUnAg==
X-Received: by 2002:a05:6000:401f:b0:3b7:76e8:ba1e with SMTP id ffacd0b85a97d-3b794fe4fe6mr9647105f8f.11.1754057618361;
        Fri, 01 Aug 2025 07:13:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:7500:5f99:9633:990e:138? (p200300d82f2075005f999633990e0138.dip0.t-ipconnect.de. [2003:d8:2f20:7500:5f99:9633:990e:138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee628fcsm66571965e9.31.2025.08.01.07.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 07:13:37 -0700 (PDT)
Message-ID: <286466e3-9d1c-40a0-a467-a48cb2b657b4@redhat.com>
Date: Fri, 1 Aug 2025 16:13:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/userfaultfd: fix missing PTE unmap for non-migration
 entries
From: David Hildenbrand <david@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
 aarcange@redhat.com, surenb@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250630031958.1225651-1-sashal@kernel.org>
 <20250630175746.e52af129fd2d88deecc25169@linux-foundation.org>
 <a4d8b292-154a-4d14-90e4-6c822acf1cfb@redhat.com> <aG06QBVeBJgluSqP@lappy>
 <a8f863b1-ea06-4396-b4da-4dca41e3d9a5@redhat.com> <aItjffoR7molh3QF@lappy>
 <214e78a0-7774-4b1e-8d85-9a66d2384744@redhat.com> <aIzAj9xUOPCsmZEG@lappy>
 <593b222e-1a62-475c-9502-76e128d3625d@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <593b222e-1a62-475c-9502-76e128d3625d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.25 16:06, David Hildenbrand wrote:
> On 01.08.25 15:26, Sasha Levin wrote:
>> On Thu, Jul 31, 2025 at 02:56:25PM +0200, David Hildenbrand wrote:
>>> On 31.07.25 14:37, Sasha Levin wrote:
>>>> On Tue, Jul 08, 2025 at 05:42:16PM +0200, David Hildenbrand wrote:
>>>>> On 08.07.25 17:33, Sasha Levin wrote:
>>>>>> On Tue, Jul 08, 2025 at 05:10:44PM +0200, David Hildenbrand wrote:
>>>>>>> On 01.07.25 02:57, Andrew Morton wrote:
>>>>>>>> On Sun, 29 Jun 2025 23:19:58 -0400 Sasha Levin <sashal@kernel.org> wrote:
>>>>>>>>
>>>>>>>>> When handling non-swap entries in move_pages_pte(), the error handling
>>>>>>>>> for entries that are NOT migration entries fails to unmap the page table
>>>>>>>>> entries before jumping to the error handling label.
>>>>>>>>>
>>>>>>>>> This results in a kmap/kunmap imbalance which on CONFIG_HIGHPTE systems
>>>>>>>>> triggers a WARNING in kunmap_local_indexed() because the kmap stack is
>>>>>>>>> corrupted.
>>>>>>>>>
>>>>>>>>> Example call trace on ARM32 (CONFIG_HIGHPTE enabled):
>>>>>>>>>     WARNING: CPU: 1 PID: 633 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
>>>>>>>>>     Call trace:
>>>>>>>>>       kunmap_local_indexed from move_pages+0x964/0x19f4
>>>>>>>>>       move_pages from userfaultfd_ioctl+0x129c/0x2144
>>>>>>>>>       userfaultfd_ioctl from sys_ioctl+0x558/0xd24
>>>>>>>>>
>>>>>>>>> The issue was introduced with the UFFDIO_MOVE feature but became more
>>>>>>>>> frequent with the addition of guard pages (commit 7c53dfbdb024 ("mm: add
>>>>>>>>> PTE_MARKER_GUARD PTE marker")) which made the non-migration entry code
>>>>>>>>> path more commonly executed during userfaultfd operations.
>>>>>>>>>
>>>>>>>>> Fix this by ensuring PTEs are properly unmapped in all non-swap entry
>>>>>>>>> paths before jumping to the error handling label, not just for migration
>>>>>>>>> entries.
>>>>>>>>
>>>>>>>> I don't get it.
>>>>>>>>
>>>>>>>>> --- a/mm/userfaultfd.c
>>>>>>>>> +++ b/mm/userfaultfd.c
>>>>>>>>> @@ -1384,14 +1384,15 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>>>>>>>>>    		entry = pte_to_swp_entry(orig_src_pte);
>>>>>>>>>    		if (non_swap_entry(entry)) {
>>>>>>>>> +			pte_unmap(src_pte);
>>>>>>>>> +			pte_unmap(dst_pte);
>>>>>>>>> +			src_pte = dst_pte = NULL;
>>>>>>>>>    			if (is_migration_entry(entry)) {
>>>>>>>>> -				pte_unmap(src_pte);
>>>>>>>>> -				pte_unmap(dst_pte);
>>>>>>>>> -				src_pte = dst_pte = NULL;
>>>>>>>>>    				migration_entry_wait(mm, src_pmd, src_addr);
>>>>>>>>>    				err = -EAGAIN;
>>>>>>>>> -			} else
>>>>>>>>> +			} else {
>>>>>>>>>    				err = -EFAULT;
>>>>>>>>> +			}
>>>>>>>>>    			goto out;
>>>>>>>>
>>>>>>>> where we have
>>>>>>>>
>>>>>>>> out:
>>>>>>>> 	...
>>>>>>>> 	if (dst_pte)
>>>>>>>> 		pte_unmap(dst_pte);
>>>>>>>> 	if (src_pte)
>>>>>>>> 		pte_unmap(src_pte);
>>>>>>>
>>>>>>> AI slop?
>>>>>>
>>>>>> Nah, this one is sadly all me :(
>>>>>
>>>>> Haha, sorry :P
>>>>
>>>> So as I was getting nowhere with this, I asked AI to help me :)
>>>>
>>>> If you're not interested in reading LLM generated code, feel free to
>>>> stop reading now...
>>>>
>>>> After it went over the logs, and a few prompts to point it the right
>>>> way, it ended up generating a patch (below) that made sense, and fixed
>>>> the warning that LKFT was being able to trigger.
>>>>
>>>> If anyone who's more familiar with the code than me (and the AI) agrees
>>>> with the patch and ways to throw their Reviewed-by, I'll send out the
>>>> patch.
>>>
>>> Seems to check out for me. In particular, out pte_unmap() everywhere
>>> else in that function (and mremap.c:move_ptes) are ordered properly.
>>>
>>> Even if it would not fix the issue, it would be a cleanup :)
>>>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>
>> David, I ended up LLM generating a .cocci script to detect this type of
>> issues, and it ended up detecting a similar issue in
>> arch/loongarch/mm/init.c.
> 
> Does loongarch have these kmap_local restrictions?

loongarch doesn't use HIGHMEM, so it probably doesn't matter. Could be 
considered a cleanup, though.

-- 
Cheers,

David / dhildenb


