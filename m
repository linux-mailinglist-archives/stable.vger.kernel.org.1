Return-Path: <stable+bounces-89871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 096F99BD259
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F431F21E14
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BCE2D7B8;
	Tue,  5 Nov 2024 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAe23Yo4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8231D9350
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824223; cv=none; b=uIJlafoURSeqc/iXPTKCh/UsB7NtL1VSwlRRJesrtxf9b5OMDn8NBEchwuirSCzWEebTBcXRl5juTvTpi2nWmQrjKUDCsaKjgiGy2ZqPEDuIB8ujvgus9tmBensJqZ8LGl1Y/5Lk0e9fL1aDzwo1oQPIayTD2i3W36HH78V/dFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824223; c=relaxed/simple;
	bh=H7qmEk3avcg08zmriG4XbBLbUQh8Am5LlN2ksrBRskk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4ahkeqYHpg3XIcmGtw9HotJdoORAvqELWXvs7DSj0KIkPquFckz5i0E9CDuZN6c68IViSIOBXiv68uHhazGkMCFstpS5qYqzyWT6XJRtdnijepWp5ztma63jM2owNNNbtPGcF3qP9A0/YMxnAL8AXhZlfp7ZFuJaM0RgNW8FoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAe23Yo4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730824220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cmF2F32cQBYdqH1CMO+4/wu9yKevhwL17uZmQcUKwfA=;
	b=eAe23Yo40e3fOxMxplI1YpQPRBl5MbxfZIKI4Kv3x2AlsMIpqkld4lU0TE4hQ1kCh9YQf2
	USUAPBiWVvNwwu8xVaxVdTTRa7yyxTEkyMtIehtDihppubUpfSLl8sQR7zXPWrZ48dshvc
	kkLrdo/cZ5UTmybOCgvOzZaX4lUUzcQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-jMNbUmiPNcW6CEMtKk4ndA-1; Tue, 05 Nov 2024 11:30:19 -0500
X-MC-Unique: jMNbUmiPNcW6CEMtKk4ndA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315c1b5befso35697815e9.1
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 08:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730824218; x=1731429018;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cmF2F32cQBYdqH1CMO+4/wu9yKevhwL17uZmQcUKwfA=;
        b=H3g8YSOAexE4yz7YzLVEvaKc5NYLAyG3jI+xVTvfMx42UPVlMFRZqTpf6ASs7CuBLI
         COcNIRi269d+4vZUCJgUPY2jha8Ru60lYWJaei3YVq7dtn0O7NKdkdLfsgvSMlerP949
         1AClNFOf29WLZlotc+/TBAEXAenQnQllgV/3wOjsm3pe3izdosqraXdb4B11vHG/ypmq
         N8ZTXx2x6vU7Q3CIYmg9AExIagXiIbtP9eikJKz/c4zvlvNDX+shOOyx5YLz1Lmjbwgt
         wou0N31i2XhVWMUP6SlNgs5rqY0BNxhihb8FWZHRvL677TBSpwiL/ay7DQG9ymlMuX4h
         v0sA==
X-Gm-Message-State: AOJu0YwlSzybktMV+Uwq+j5wM9BG0hI6LZPR2PQkAiJHl3OxCkFCrVs3
	5DntfppAEVhnvEzLBJCIPeHKtq16inLW15oOjWXYsvYGP+X/gQxJJ0i8Ujjgmd66NP5KFH2yf5+
	LlbncO/lmaau19/7IPVHVJUWnfp52PO65Akj6vkFUj8PTlEVluXN+IA==
X-Received: by 2002:a05:600c:1c01:b0:431:9a68:ec84 with SMTP id 5b1f17b1804b1-4319ad04780mr290512925e9.23.1730824218181;
        Tue, 05 Nov 2024 08:30:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGT4eVurJ2u6Ud2KN30KWfMRzEmnXSLCa7AMoFtZNl7TnhZK5RjpOXUNiQD/hQhJFV0RLNv5Q==
X-Received: by 2002:a05:600c:1c01:b0:431:9a68:ec84 with SMTP id 5b1f17b1804b1-4319ad04780mr290512625e9.23.1730824217719;
        Tue, 05 Nov 2024 08:30:17 -0800 (PST)
Received: from [192.168.3.141] (p4ff23a40.dip0.t-ipconnect.de. [79.242.58.64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9a9a3bsm221773615e9.36.2024.11.05.08.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 08:30:16 -0800 (PST)
Message-ID: <26be0c08-1c83-451d-902b-a843b9ef4b0e@redhat.com>
Date: Tue, 5 Nov 2024 17:30:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] mm: huge_memory: add vma_thp_disabled() and
 thp_disabled_by_hw()
To: =?UTF-8?Q?Petr_Van=C4=9Bk?= <arkamar@atlas.cz>
Cc: stable@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Leo Fu <bfu@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Hugh Dickins <hughd@google.com>,
 Janosch Frank <frankja@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>
References: <2024101842-empty-espresso-c8a3@gregkh>
 <20241022090755.4097604-1-david@redhat.com>
 <2024115125648-ZyoWEF1F7lBRpXqH-arkamar@atlas.cz>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2024115125648-ZyoWEF1F7lBRpXqH-arkamar@atlas.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.11.24 13:56, Petr Vaněk wrote:
> Hi David,
> 

Hi Petr,

> On Tue, Oct 22, 2024 at 11:07:55AM +0200, David Hildenbrand wrote:
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 9aea11b1477c..dfd6577225d8 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -78,19 +78,8 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
>>   	if (!vma->vm_mm)		/* vdso */
>>   		return false;
>>   
>> -	/*
>> -	 * Explicitly disabled through madvise or prctl, or some
>> -	 * architectures may disable THP for some mappings, for
>> -	 * example, s390 kvm.
>> -	 * */
>> -	if ((vm_flags & VM_NOHUGEPAGE) ||
>> -	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>> -		return false;
>> -	/*
>> -	 * If the hardware/firmware marked hugepage support disabled.
>> -	 */
>> -	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
>> -		return false;
>> +	if (thp_disabled_by_hw() || vma_thp_disabled(vma, vm_flags))
>> +		return 0;
> 
> Shouldn't this return false for consistency with the rest of the
> function?

Yes, that's better. Same applies to the 6.1.y backport of this.

-- 
Cheers,

David / dhildenb


