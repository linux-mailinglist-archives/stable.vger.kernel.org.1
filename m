Return-Path: <stable+bounces-150602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8ACACB9A5
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 18:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71500176B35
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08609224AFC;
	Mon,  2 Jun 2025 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPxuf9uU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C685224AE8
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748881745; cv=none; b=NCpvcgmOkTkj5bb/jpmHtLz+BAyK2LGCk5E/0s9Pnu1geLtgheg4glN665qphrjq/f6jqwX0jOrUST7UpFC/zl30K4HrBR3mToQBTaDC1+tf1n7ts9KzF77x2xLGk1+X9ghRvQMvEBZ7fkTCUCAE/5Fg/uTuoFIbVhfdH0BVlgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748881745; c=relaxed/simple;
	bh=Hr7cJ8hbGINJXjU3P0oIQapcqls5Y+aVq92uopVRj50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZSZmxeugyxsJloROLwJ8ocNf0Hdd8nsWNtPVs524vqZQ8l1fnf0A1V7YiE8PRLuE3v1TyO1gkEg2JrKzgfK2VVf/8gBlvBwS1bwPYf/RVt5bt5n5EpbJG8Mqiv/UANc0aM234UnLVi39kNSivV1i8AnNHvG+zeuXfiBCCfg5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPxuf9uU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748881742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ieNSkMEMzT2cBUSDsIkIFZPogjlidcu6cjj3LcjU7B4=;
	b=HPxuf9uU6FjwEXgJZXo6qn6McTmRrMs0KI7FLDISoqBGJEK2Itm3XRsPsmuIDiU1BLROSY
	k2UCSxbdn/OPJZl9uCJwQ/+ZwV//2fdA3PehEAF07OMHW1fV7bMFGAqeY+VjS9X6H7knVq
	Kim3ydyf6JXktk79RkN1bNmUS2x3/ls=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-f_ptWtaMNvO8rlMAOPotsw-1; Mon, 02 Jun 2025 12:29:01 -0400
X-MC-Unique: f_ptWtaMNvO8rlMAOPotsw-1
X-Mimecast-MFC-AGG-ID: f_ptWtaMNvO8rlMAOPotsw_1748881740
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso27874805e9.0
        for <stable@vger.kernel.org>; Mon, 02 Jun 2025 09:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748881740; x=1749486540;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ieNSkMEMzT2cBUSDsIkIFZPogjlidcu6cjj3LcjU7B4=;
        b=D0C8ShVUPgk2ObQE7AdR8w6kqBMm+fwA3reMIKHILzyysA0PE4oNiyx2uzM2ZjCjsX
         uZdgv3MxAkNRUhIAaF+bg9fRQOmKf+Bt35oLcRR4pY7RHd82jAwWlTYXJX64h5wZf+di
         /nP8xbM4RMqmbz2U2m4zpS0C0/kiraCMpWbNmUal/4UHA9s4m9C4vD/sqGhUkey75a7w
         pPPm3PsBxzv8fFK0V/N1M3/ztoKLd23kJryEcvkUZjY9fDa/k8UhSa5t6M+CVmOkMLcp
         ETajhawyvPjwHBvMn7k4EeOMDrP0Q+dr3+eZBLLkh7H6vSn59vnf14KmhSbywrPRzT70
         pNPg==
X-Forwarded-Encrypted: i=1; AJvYcCWmXnqlWlWARro9yye1SUFnNebAKKSGe0puRhLD+wcOdHk+adVNT7uhNMhiMHf2acolHdU7kpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT42xRTUOsS8hCteOjtZ88gG5fWMGBX+L306eDj3lPn5jHIHBT
	NIDY1q19ZRSeZRHrP84VyTWrxEZ6O/wRPN95siQMAM4DubEaSDKYQ3kAEWQe7EUbh258IDMPdUa
	NK5Nydgvb63IljG7Uq33F7CKv52MaVr0QYhBDeiYV7V9FH7L89pYac0S2EA==
X-Gm-Gg: ASbGncv2nomJE9rlHQHvFdEFS8bL/WzIKFF+tvlt1gA+wX1s/hXtwm43OI7hyTD5hSa
	NVNvOqky9qQh2ov9D5EVbKl6i0Yva9otNlVnfvEspNGe6eEfAeS00UZdyUrqX1IzsdwxpGlaFQz
	68E6iPlzl17pZndbrRUFP/Fzxs+eXyMFIOFagRHStVr1Ks4J+pkM66o6GVkMBevB7y4vP8Fm9I+
	1NkxueFb1PYuYyY+JgCESCTnj/PiqtfqxafKsNAQgo3/Q0X0xM2lzcWY9qGdzXqm8t9rNCQWiHd
	2GpvywVYJpbaYYreQaie0wqrLCowbZ0abLv9vgxGH1XG5u0JU5eQ2WtBx967BbozmtP8oaCzO84
	ozMvK+KXEhUpAENSFAN3LekRR+mKF3g7Qa9FtwHo=
X-Received: by 2002:a5d:5f43:0:b0:3a3:7ba5:9618 with SMTP id ffacd0b85a97d-3a4f7a364e1mr10765206f8f.29.1748881740472;
        Mon, 02 Jun 2025 09:29:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuyr73wVGfGNCmZNF9qgRvhzEmYvj6p07InfYNtUHa4yJdwhczPonOBEXQRhDsersMVP4qXQ==
X-Received: by 2002:a5d:5f43:0:b0:3a3:7ba5:9618 with SMTP id ffacd0b85a97d-3a4f7a364e1mr10765189f8f.29.1748881740058;
        Mon, 02 Jun 2025 09:29:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f34:a300:1c2c:f35e:e8e5:488e? (p200300d82f34a3001c2cf35ee8e5488e.dip0.t-ipconnect.de. [2003:d8:2f34:a300:1c2c:f35e:e8e5:488e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b79asm15145126f8f.2.2025.06.02.09.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 09:28:59 -0700 (PDT)
Message-ID: <702d4035-281f-4045-aaa7-3d6c3f7bdb68@redhat.com>
Date: Mon, 2 Jun 2025 18:28:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] mm: Fix uprobe pte be overwritten when expanding
 vma
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, mhiramat@kernel.org, oleg@redhat.com,
 peterz@infradead.org, akpm@linux-foundation.org, Liam.Howlett@oracle.com,
 vbabka@suse.cz, jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, pulehui@huawei.com
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
 <20250529155650.4017699-2-pulehui@huaweicloud.com>
 <962c6be7-e37a-4990-8952-bf8b17f6467d@redhat.com>
 <009fe1d5-9d98-45f1-89f0-04e2ee8f0ade@lucifer.local>
 <6dd3af08-b3be-4a68-af3d-1fc1b79f4279@redhat.com>
 <117e92c1-d514-4661-a04b-abe663a72995@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <117e92c1-d514-4661-a04b-abe663a72995@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.06.25 15:26, Lorenzo Stoakes wrote:
> On Mon, Jun 02, 2025 at 02:26:21PM +0200, David Hildenbrand wrote:
>> On 02.06.25 13:55, Lorenzo Stoakes wrote:
>>> On Fri, May 30, 2025 at 08:51:14PM +0200, David Hildenbrand wrote:
>>>>>     	if (vp->remove) {
>>>>> @@ -1823,6 +1829,14 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>>>>>     		faulted_in_anon_vma = false;
>>>>>     	}
>>>>> +	/*
>>>>> +	 * If the VMA we are copying might contain a uprobe PTE, ensure
>>>>> +	 * that we do not establish one upon merge. Otherwise, when mremap()
>>>>> +	 * moves page tables, it will orphan the newly created PTE.
>>>>> +	 */
>>>>> +	if (vma->vm_file)
>>>>> +		vmg.skip_vma_uprobe = true;
>>>>> +
>>>>
>>>> Assuming we extend the VMA on the way (not merge), would we handle that
>>>> properly?
>>>>
>>>> Or is that not possible on this code path or already broken either way?
>>>
>>> I'm not sure in what context you mean expand, vma_merge_new_range() calls
>>> vma_expand() so we call an expand a merge here, and this flag will be
>>> obeyed.
>>
>> Essentially, an mremap() that grows an existing mapping while moving it.
>>
>> Assume we have
>>
>> [ VMA 0 ] [ VMA X]
>>
>> And want to grow VMA 0 by 1 page.
>>
>> We cannot grow in-place, so we'll have to copy VMA 0 to another VMA, and
>> while at it, expand it by 1 page.
>>
>> expand_vma()->move_vma()->copy_vma_and_data()->copy_vma()
> 
> OK so in that case you'd not have a merge at all, you'd have a new VMA and all
> would be well and beautiful :) or I mean hopefully. Maybe?

I'm really not sure. :)

Could there be some very odd cases like

[VMA 0 ][ VMA 1 ][ VMA X]

and when we mremap() [ VMA 1 ] to grow, we would place it before [VMA 0 
], and just by pure lick end up merging with that if the ranges match?

We're in the corner cases now, ... so this might not be relevant. But I 
hope we can clean up that uprobe mmap call later ...

> 
>>
>>
>> But maybe I'm getting lost in the code. (e.g., expand_vma() vs. vma_expand()
>> ... confusing :) )
> 
> Yeah I think Liam or somebody else called me out for this :P I mean it's
> accurate naming in mremap.c but that's kinda in the context of the mremap.
> 
> For VMA merging vma_expand() is used generally for a new VMA, since you're
> always expanding into the gap, but because we all did terrible things in past
> lives also called by relocate_vma_down() which is a kinda-hack for initial stack
> relocation on initial process setup.
> 
> It maybe needs renaming... But expand kinda accurately describes what's going on
> just semi-overloaded vs. mremap() now :>)
> 
> VMA merge code now at least readable enough that you can pick up on the various
> oddnesses clearly :P

:)

-- 
Cheers,

David / dhildenb


