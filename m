Return-Path: <stable+bounces-94532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A1E9D4F61
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 16:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBF21F24005
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A901DC734;
	Thu, 21 Nov 2024 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQwl+4SB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7A1DBB36
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201486; cv=none; b=SNUlzEVQj80aUQC+fl8phLxnOwbvmQCM2Cl5z8TzLNRGipDQwFnoEzoJNbPT91LuCcYTGMPgczB/gVlbV07CkbHxBlf9POxkicXIBp8ZvZtqJdsjbcE28ngxpaFMqJM8BbyjdN+w6Fvvd3ws1sGphiHSfRE0DWpt/6bdYSF2PBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201486; c=relaxed/simple;
	bh=Hc4o4tFcNVn7jqfs9MJy4/6SXEgHVb5psHg4B5qW/m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhoVqQdQCba+RZhC4O4EXymyv6uvAi7dK+GPILVBtA8StHTQq/yN7vPr+yFq1xYBqfgc88v9PmOojS4eJffAcSDR9cHs8zfjT5Pjhhtl7LOyUoGbXRiidFMcAsfRu5R8beNdJ3hewanRNS57IMPWLzwwf32JwG4JyFPwGANjas0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YQwl+4SB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732201483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3Nq1kII2UB+9ENt//6WMlEnfZsLsEAnBwTFsduCKCB8=;
	b=YQwl+4SBhWCVXIQuVcWS2G0DY7O9KHr5Ftq/57dKOOT+ptKxOVk4Z0g1axamjv3CLgM02G
	vCoyMLii5HljxrR8bXPYNLrTzNyJQ/lhFFzXyMG9JiX2LgPaRvY7K9T9dbBKvYLSsYy3af
	9hQbOwWvTH4f8j2WDfbbe9XrtzeLqh0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-_bV2DZn_MTCqka6op_Uuxg-1; Thu, 21 Nov 2024 10:04:40 -0500
X-MC-Unique: _bV2DZn_MTCqka6op_Uuxg-1
X-Mimecast-MFC-AGG-ID: _bV2DZn_MTCqka6op_Uuxg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4317391101aso7300715e9.2
        for <stable@vger.kernel.org>; Thu, 21 Nov 2024 07:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732201476; x=1732806276;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Nq1kII2UB+9ENt//6WMlEnfZsLsEAnBwTFsduCKCB8=;
        b=kDB0qWFzjGXkFv4VvGuO72uar3UggDtSztQdiyTVVANOMrIhtXSvwqV9UGcywc1FYY
         fh3iLtPywSPChl4NNPyyW1u1udM0gYQ2Q3N5fCip5AjQGtuVULpFNDN9NdCYrYtgyftf
         b86LqVz93GKdIoapzuEgZRAD7/o1h44giE7n5FTYZhTzwI10Y0lF1DeEeI1K0gTYz/iX
         WpGt6M915ao6a/wrxsfogMrXZfSWkWWHod9V1S4gLWCCePLRCoAFg8HDRmumiwifPcvB
         wXWhCE/MiyFAWtFvl+lWN6+C6On2r3JgYga5oW3MQMUfg6yzmuG8iClG7WEMOlmEZu+L
         FD+w==
X-Forwarded-Encrypted: i=1; AJvYcCWuLdCYJZFyR5bZYIWPBlK7RbnCpxVhGgyRMOkFABSA2F/3SfMEWvT9YzavyMNq1cX2dtytiOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqufU+OVSeTi0WfOKzwBqRpoPpt6I89Kg5xY6Kd0+9cDe9v+3
	DMQEplMrVWTONA4qu9zlu8hYkDLvYNqdtvnWE/G3hEbHGPXjHf7mkW3pnsMimyjjfqFPVa/5us4
	Seh0JA/TIVKxmbIS9xZp8KuVA2Ubqk7aN91NxCXzRirACCQ0SI76UQA==
X-Gm-Gg: ASbGncuD20Lo3xMLn6H+MHWoQrwZeyF51kRBD/kSOf26ZFHOQUGma3qdRZjhLwSHuuY
	1OApYuxUgzIA//v8/3VklwIfwKfu93ENDTdauwSRPWXCcLG8Qz888f9lCvEZIupEHVfShTceySF
	fEr0B7JjDI5znuN8v7sp4UgJAapzIOhtdYsEojCYRvri+DPBhM+38yQjAMgccJYpHmuIV8TDSvi
	IJrJ8cWL5eo+7bMY0rrnJC4RFM1jA13MUuRUDae8IsWvnn7j/ZKmIRjxKe6Oqic0FGLEHuXkMIt
	1JsN3MMiiON6wN5LeRSCKS7wtZHnHcs7ARSOeVIl8InCEAIm6mHhrktKwujvwWkLwMj3PY8g7t8
	=
X-Received: by 2002:a05:600c:3b8d:b0:42c:c401:6d8b with SMTP id 5b1f17b1804b1-4334899712dmr59724125e9.7.1732201476198;
        Thu, 21 Nov 2024 07:04:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvdmgV40iceBFhDPE6uUMsEeLIuOuf5e3raKKjMPeU6dfpAjM249m4BWtVHDX7rkMEbjfpXA==
X-Received: by 2002:a05:600c:3b8d:b0:42c:c401:6d8b with SMTP id 5b1f17b1804b1-4334899712dmr59723405e9.7.1732201475521;
        Thu, 21 Nov 2024 07:04:35 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:de00:1200:8636:b63b:f43? (p200300cbc70cde0012008636b63b0f43.dip0.t-ipconnect.de. [2003:cb:c70c:de00:1200:8636:b63b:f43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e1046sm61538025e9.4.2024.11.21.07.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 07:04:35 -0800 (PST)
Message-ID: <3affa5da-469e-4a25-8c75-dfc783ed2919@redhat.com>
Date: Thu, 21 Nov 2024 16:04:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: Fix to make vma_adjust_trans_huge() use
 find_vma() correctly
To: Jeongjun Park <aha310510@gmail.com>
Cc: akpm@linux-foundation.org, dave@stgolabs.net, willy@infradead.org,
 Liam.Howlett@oracle.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <20241121124113.66166-1-aha310510@gmail.com>
 <26b82074-891f-4e26-b0a7-328ee2fa08d3@redhat.com>
 <25ead85f-2716-4362-8fb5-3422699e308c@redhat.com>
 <CAO9qdTE8WO100AJo_bgM+J5yCpTtv=tRniNV2Rq3YAwQjx3JrA@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAO9qdTE8WO100AJo_bgM+J5yCpTtv=tRniNV2Rq3YAwQjx3JrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.11.24 15:18, Jeongjun Park wrote:
> David Hildenbrand <david@redhat.com> wrote:
>>
>> On 21.11.24 14:44, David Hildenbrand wrote:
>>> On 21.11.24 13:41, Jeongjun Park wrote:
>>>> vma_adjust_trans_huge() uses find_vma() to get the VMA, but find_vma() uses
>>>> the returned pointer without any verification, even though it may return NULL.
>>>> In this case, NULL pointer dereference may occur, so to prevent this,
>>>> vma_adjust_trans_huge() should be fix to verify the return value of find_vma().
>>>>
>>>> Cc: <stable@vger.kernel.org>
>>>> Fixes: 685405020b9f ("mm/khugepaged: stop using vma linked list")
>>>
>>> If that's an issue, wouldn't it have predated that commit?
>>>
>>> struct vm_area_struct *next = vma->vm_next;
>>> unsigned long nstart = next->vm_start;
>>>
>>> Would have also assumed that there is a next VMA that can be
>>> dereferenced, no?
>>>
>>
>> And looking into the details, we only assume that there is a next VMA if
>> we are explicitly told to by the caller of vma_adjust_trans_huge() using
>> "adjust_next".
>>
>> There is only one such caller,
>> vma_merge_existing_range()->commit_merge() where we set adj_start ->
>> "adjust_next" where we seem to have a guarantee that there is a next VMA.
> 
> I also thought that it would not be a problem in general cases, but I think
> that there may be a special case (for example, a race condition...?) that can
> occur in certain conditions, although I have not found it yet.

If we're working on VMAs in that way (merging!) we need the mmap lock in 
write mode, so no races are possible.

> 
> In addition, most functions except this one unconditionally check the return
> value of find_vma(), so I think it would be better to handle the return value
> of find_vma() consistently in this function as well, rather than taking the
> risk and leaving it alone just because it seems to be okay.

Your patch is silently hiding something that should never happen such 
that we wouldn't handle our operation as intended. So no, that's even worse.

-- 
Cheers,

David / dhildenb


