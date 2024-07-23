Return-Path: <stable+bounces-60804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CF993A50B
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 19:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490A61C22119
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 17:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D7615820C;
	Tue, 23 Jul 2024 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NrDj3dKQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C80156F36
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721756230; cv=none; b=LfBjctwGa0M//M+DeqhotIhXQIZAn8VMcA3MuiXKd3aSsSTJrQsc0xWCmJcPjkMcdAAfyx2oQt8CH9HdcxGRAWv7QIGZfiPkwwu148kPXF0l/Pmk7Wjmgb4pdt+FW5RdrqRpR/cxhVBNGGtv+F3OFDqzLFL2yux5gwYXqkPkmZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721756230; c=relaxed/simple;
	bh=0J3Hj1ylmUyaV1u8t385LGAMrkCKxaGrovQLmzAzL3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwxqWOAf/x6k8f1Mp3XUA6JAbhQODwlnOVTXAp4Gsj36n65E7JG06B75KqSIFNRsQt1x+GjC02qaXTCoj+j/TYcBhbjSkxUuL8h7l0NfbI/Wm3uT40JE/LN+DR2b+9RN263YsT9plqH7T6a0vTlYQWcwr+wCDgBCv4+xHp0vBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NrDj3dKQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721756228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=62hebeWi0ITEck7nxNX/M2FORPR9UwBEqyQOUe6wmiU=;
	b=NrDj3dKQSF+Tr0WbV82GD/lmzR9GYHXtxDZCjz3PdopizOweD89TUrq2XRrRblOpvkS+aV
	1hGMIcD22rBCMYgP3cVuzIyDJssLj+6oAQv8M26qvZ8jsRDJ1c+YbJ3ZUMnVHdtbtyWnJb
	OxyZMFkHVPZmi5Dl9NackVEKPyF0tQM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-vwV7H_u1O8OjErBeKLdaLA-1; Tue, 23 Jul 2024 13:37:06 -0400
X-MC-Unique: vwV7H_u1O8OjErBeKLdaLA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4266945770eso39306935e9.2
        for <stable@vger.kernel.org>; Tue, 23 Jul 2024 10:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721756226; x=1722361026;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=62hebeWi0ITEck7nxNX/M2FORPR9UwBEqyQOUe6wmiU=;
        b=BClNVCbxFIfKVk84x3uAijgWIkf83gBEbhB0BouwqOlCX0VSoNkh1ozSqjjOfaeyG8
         Zbg/Hq5AqEgxmV7gATIOczxuy4Bu242FsrN4VGgOjLCqUZ0sCYuooiqJ9+Mr06/73ylF
         ZrVi/0kjS5++8G1WtcmSdbvo6YUfXkq4q6kRXjdvAViHMOvLGzAihF5nc9URNbl7q17T
         BmHSmEj8TsraIpFoLds4eSXm7jnC7Xh/nEmCaou3ZyRcoMEZubTDIt1RCODIaNPQzqcR
         C2whonjJlJNwTq8ShuGeqIDSgKtiAcUvB613rWnpkq3WcTTiMTvBZ5wj+65htIf4vpOE
         bldQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqm6GfIxEJC1b8Cne7EWcMFGZhs8LbGVRqF9W4KVvmzVIwxRzyYxx/yMRTDQwh1Jf2fR8Og1EjEb1o40y5KnDXpSqPL0UD
X-Gm-Message-State: AOJu0YzRHtmjrcsfOdmM6PojBwyfXYrKKmXpOvKNaqKdoh3VJoCPxT3X
	NOvmmXsnx4QBkhZna9MqWVqAfKm0JtdlrJUOHaXpwxSq2OR5Iu1s3rSLvaZzodhpLCBG66MC5RY
	bNg3bGmatkYUh7Cn848CXXn6utxtFoHTRtqZPxHM3isYA2NiDYnmwMg==
X-Received: by 2002:a05:600c:3ba3:b0:427:9dad:17df with SMTP id 5b1f17b1804b1-427f7ab5942mr1554085e9.12.1721756225623;
        Tue, 23 Jul 2024 10:37:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu4Z9BHtIQnMHKhtfj0ProRXQnQmU+cxSMg3r6++Fh71gX+i4zBosJDVEVYMfLkGee+hT4yw==
X-Received: by 2002:a05:600c:3ba3:b0:427:9dad:17df with SMTP id 5b1f17b1804b1-427f7ab5942mr1553915e9.12.1721756225104;
        Tue, 23 Jul 2024 10:37:05 -0700 (PDT)
Received: from [192.168.3.141] (p5b0c6cd6.dip0.t-ipconnect.de. [91.12.108.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a3c0fasm213872765e9.7.2024.07.23.10.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 10:37:04 -0700 (PDT)
Message-ID: <6be6453a-15ce-4305-9a7c-a66e57564785@redhat.com>
Date: Tue, 23 Jul 2024 19:37:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix maxnode for mbind(), set_mempolicy() and
 migrate_pages()
To: Jerome Glisse <jglisse@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240720173543.897972-1-jglisse@google.com>
 <0c390494-e6ba-4cde-aace-cd726f2409a1@redhat.com>
 <CAPTQFZSgNHEE0Ub17=kfF-W64bbfRc4wYijTkG==+XxfgcocOQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAPTQFZSgNHEE0Ub17=kfF-W64bbfRc4wYijTkG==+XxfgcocOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.07.24 18:33, Jerome Glisse wrote:
> On Mon, 22 Jul 2024 at 06:09, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 20.07.24 19:35, Jerome Glisse wrote:
>>> Because maxnode bug there is no way to bind or migrate_pages to the
>>> last node in multi-node NUMA system unless you lie about maxnodes
>>> when making the mbind, set_mempolicy or migrate_pages syscall.
>>>
>>> Manpage for those syscall describe maxnodes as the number of bits in
>>> the node bitmap ("bit mask of nodes containing up to maxnode bits").
>>> Thus if maxnode is n then we expect to have a n bit(s) bitmap which
>>> means that the mask of valid bits is ((1 << n) - 1). The get_nodes()
>>> decrement lead to the mask being ((1 << (n - 1)) - 1).
>>>
>>> The three syscalls use a common helper get_nodes() and first things
>>> this helper do is decrement maxnode by 1 which leads to using n-1 bits
>>> in the provided mask of nodes (see get_bitmap() an helper function to
>>> get_nodes()).
>>>
>>> The lead to two bugs, either the last node in the bitmap provided will
>>> not be use in either of the three syscalls, or the syscalls will error
>>> out and return EINVAL if the only bit set in the bitmap was the last
>>> bit in the mask of nodes (which is ignored because of the bug and an
>>> empty mask of nodes is an invalid argument).
>>>
>>> I am surprised this bug was never caught ... it has been in the kernel
>>> since forever.
>>
>> Let's look at QEMU: backends/hostmem.c
>>
>>       /*
>>        * We can have up to MAX_NODES nodes, but we need to pass maxnode+1
>>        * as argument to mbind() due to an old Linux bug (feature?) which
>>        * cuts off the last specified node. This means backend->host_nodes
>>        * must have MAX_NODES+1 bits available.
>>        */
>>
>> Which means that it's been known for a long time, and the workaround
>> seems to be pretty easy.
>>
>> So I wonder if we rather want to update the documentation to match reality.
> 
> [Sorry resending as text ... gmail insanity]
> 
> I think it is kind of weird if we ask to supply maxnodes+1 to work
> around the bug. If we apply this patch qemu would continue to work as
> is while fixing users that were not aware of that bug. So I would say
> applying this patch does more good. Long term qemu can drop its
> workaround or keep it for backward compatibility with old kernel.

Not really, unfortunately. The thing is that it requires a lot more 
effort to sense support than simply pass maxnodes+1. So unless you know 
exactly on which minimum kernel version your software runs (barely 
happens), you will simply apply the workaround.

I would assume that each and every sane user out there does that 
already, judging that even that QEMU code is 10 years old (!).

In any case, we have to document that behavior that existed since the 
very beginning. Because it would be even *worse* if someone would 
develop against a new kernel and would get a bunch of bug reports when 
running on literally every old kernel out there :)

So my best guess is that long-term it will create more issues when we 
change the behavior ... but in any case we have to update the man pages.

-- 
Cheers,

David / dhildenb


