Return-Path: <stable+bounces-178002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A63AB47729
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 22:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083203BD7EC
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 20:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715FD1C860C;
	Sat,  6 Sep 2025 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AEIBUQvf"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42B315D45
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757191558; cv=none; b=RnI92cNewEPxh//t1/k2vRHhfcTNpFbJd0PUeb+AfacBXbxbgL+YmyBP2Az/uclYJ4fhBP+BFI3Np5QsPRXx/xq2erXfV0AAQwh53mQZwC+tUW2L9hlqpITQ6cMiHhjg1Jb0gQzXj/98iD6rodHTTayDnMQciRwwp4mGESqEgoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757191558; c=relaxed/simple;
	bh=672IcDWWemiIo9nlP91aQmvcpHf2rOtReBL6Xz54e00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFMHU8vIDoElky89dxb+bBcYkyG3GsNwI/ENzm55/BC67qIrvEOFkDmtjgMO3+4rWnNABJ/kliHalXqbErY8/LGWrrcIwofNkdPyxuAH4nSLwMN1W0xLPN0hdOgHnbu0+RVcMPB8tXKpSR+TjEEkCk3jc98vvNXcWo5JfTVb3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AEIBUQvf; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6045eb3848eso396257d50.0
        for <stable@vger.kernel.org>; Sat, 06 Sep 2025 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757191553; x=1757796353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ocxYFzGZV459vpWHgj6rZ5VrAzTr3y6YSuaxEcNoAN4=;
        b=AEIBUQvfdBn5gt9YeVjmAv7TjI37407Wq6krFBjGBU2+B6D03DaocwhQzFAQuqm27R
         JCsaCIvsit6AUpKXKxanlglLL/sUn8i8PKv3BRLk/DbbkGVKxSN/rHKTj+Doy+/9TKqr
         H+jkSAdZ4Lmvudl8Qlk9gLVqhzhNd9j9UAEbhJEhUVV83Yy+KipW+XHt0lITYP5ZpsaQ
         aDJ7awBivWAqdzEkG7Fzwtn/9+d8/l8wYvPJxMCQOFqQCLpEJcnMRLoKMnfj2zw3TQHi
         87sqMZd/S4gk8n0QNZJ7hrgJkEUeDZmYj0JxEbklsa699vdyUkW/hOGhBo7hcM5LJXfG
         y7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757191553; x=1757796353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocxYFzGZV459vpWHgj6rZ5VrAzTr3y6YSuaxEcNoAN4=;
        b=HYTOljKLm6nLehcAKDF5xTUK50r1mDiepw5b8s1AG9pNYRpfETR8RQXg7ICQmPeJ5w
         G7qHvNbcYSIQgmfmyakE3S75eTCHf6cVZIZpbWv07KAN1EsTQclUzrK7SqeX89OrBNDE
         tS1zmvffF3XtOLZgZvsK5RgzN8nGCtKCLPpslfCWUT71zAOY3RKXLT0ryVUswpaO4GYF
         R5tg6jgD7Py55Y6KMy6iquyJfI3i8Lm854b+tXkAlesWaSKLHK2/F4hu0v7GcWLMCDIK
         9eHhPydpjLqnXl3bQrnCbna+FNaKxQDyU/tXcc0QBgQQW1tcR9rMmWPAANnGIqP84fzm
         6XRQ==
X-Gm-Message-State: AOJu0Ywx/cqFr+txcrl67vOYIHw+a7Eu423a6Eh8LurEgM6FNHEHz1uT
	eCycrmXpc7u72NfLhHkmaz/P3TPsWxZSPJcsymPynpoa35UdWFYGcdtep7ZmM8ZfGqw=
X-Gm-Gg: ASbGncuoDBKl7k/MV01CvUEAlRtaxPuWtaAQI6xGI8485atkx6WZQ9lkI5fFkUrKekS
	afuVJkF+i1ugiLKS6CGXI/9G0Wd+eifDGtRqkXIWDXSLEH2pakfInLgP4XZdGGHdDy9lUQT8Abx
	M/9v1rlpAYe3csuWwQM5yJz4H3q78Y9HkBE76IwcmiaQz50eFW5rB5dAmOWMIWIsIHqSmJd91PF
	aHFqS+WVz16e4RiTe3zvMI2/XJXyk9tRmQrdWXNvPBrXMMA5Zuy3ApL+EAWJ8kYjC9uBo9mSeFA
	PJZjaGlJJ6tNCk8wn6UhYdJrc6Fda0UvFKa/+jkAHyM2AjgMswqcW/RxSFtGgMaePVPqEqSk4ze
	oCZThhE8XLmUU/doTYxQ=
X-Google-Smtp-Source: AGHT+IGfBJYC8qkVDQEdGfNnlFBVbpbAqWBpEfE1et8mJ7oqr1fIHwFeUlFa7nnU9DjeFI7p73GPzg==
X-Received: by 2002:a53:b11b:0:b0:600:df03:32d2 with SMTP id 956f58d0204a3-610274a3ea0mr1856332d50.24.1757191553082;
        Sat, 06 Sep 2025 13:45:53 -0700 (PDT)
Received: from [172.17.0.109] ([50.168.186.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8502874sm38901207b3.36.2025.09.06.13.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 13:45:52 -0700 (PDT)
Message-ID: <f0ddd3e3-9f7d-4d28-8fb2-7c3495fc1221@kernel.dk>
Date: Sat, 6 Sep 2025 14:45:52 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 11/15] io_uring/msg_ring: ensure io_kiocb freeing
 is deferred for RCU
To: Greg KH <greg@kroah.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, vegard.nossum@oracle.com,
 syzbot+54cbbfb4db9145d26fc2@syzkaller.appspotmail.com
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
 <20250905110406.3021567-12-harshit.m.mogalapalli@oracle.com>
 <f43fe976-4ef5-4dea-a2d0-336456a4deae@kernel.dk>
 <8a53f86b-9d5a-47f9-a4f0-74a9c5c0fc78@oracle.com>
 <2025090604-sectional-preheated-e5c7@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025090604-sectional-preheated-e5c7@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/25 12:37 PM, Greg KH wrote:
> On Sat, Sep 06, 2025 at 07:47:00AM +0530, Harshit Mogalapalli wrote:
>> Hi Jens,
>>
>>
>> On 06/09/25 01:28, Jens Axboe wrote:
>>> On 9/5/25 5:04 AM, Harshit Mogalapalli wrote:
>>>> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
>>>> index 5ce332fc6ff5..3b27d9bcf298 100644
>>>> --- a/include/linux/io_uring_types.h
>>>> +++ b/include/linux/io_uring_types.h
>>>> @@ -648,6 +648,8 @@ struct io_kiocb {
>>>>   	struct io_task_work		io_task_work;
>>>>   	/* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll */
>>>>   	struct hlist_node		hash_node;
>>>> +	/* for private io_kiocb freeing */
>>>> +	struct rcu_head		rcu_head;
>>>>   	/* internal polling, see IORING_FEAT_FAST_POLL */
>>>>   	struct async_poll		*apoll;
>>>>   	/* opcode allocated if it needs to store data for async defer */
>>>
>>
>> Thanks a lot for looking into this one.
>>
>>> This should go into a union with hash_node, rather than bloat the
>>> struct. That's how it was done upstream, not sure why this one is
>>> different?
>>>
>>
>> We don't have commit: 01ee194d1aba ("io_uring: add support for hybrid
>> IOPOLL") which moves hlist_node	to a union along with iopoll_start,
>>
>>         struct io_task_work             io_task_work;
>> -       /* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll
>> */
>> -       struct hlist_node               hash_node;
>> +       union {
>> +               /*
>> +                * for polled requests, i.e. IORING_OP_POLL_ADD and async
>> armed
>> +                * poll
>> +                */
>> +               struct hlist_node       hash_node;
>> +               /* For IOPOLL setup queues, with hybrid polling */
>> +               u64                     iopoll_start;
>> +       };
>>
>>
>> given that we don't need the above commit, and partly because I didn't
>> realize about the bloat benefit we would get I added rcu_head without a
>> union. Thanks a lot for correctly. I will check the size bloat next time
>> when I run into this situation.
>>
>> Thank you very much for correcting this and providing a backport.
>>
>> Greg/Sasha: Should I send a v2 of this series with my backport swapped with
>> the one from Jens ?
> 
> I just took Jens's patch.  So I'll drop your patch from this series too.

Thanks! For the record, when I wrote "test patch" I really meant "tested
patch" as I did run it through the testing.

-- 
Jens Axboe

