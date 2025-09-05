Return-Path: <stable+bounces-177822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B32B45A71
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 16:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 372F37B6845
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 14:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6133336CDFA;
	Fri,  5 Sep 2025 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4BSXoeu"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A30D36CDF2;
	Fri,  5 Sep 2025 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082342; cv=none; b=AGkD6M3GPp0PmNdImH9S10Hkkc1ssVGZRicCdLes90gkg4JHwOe4Pr9rsXsAbNqRDLLg/EEOeEwcqjSGTOrXiUfBxxgWtYUWAZ5dRXQRDAfOzXe8LaXw6s6IwAezuTOiVXQfx3LQt7dnjEv+sZoYZ4uUWCyut19Q13RKdnBA1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082342; c=relaxed/simple;
	bh=TNbHWEgYuW64ur9eiUhEZ/i4hYkt7scM/tDIM9pbTJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDJhYr8Ip6vTnMZAc38vCezxPR7QR5iHotMQ53s0UTEninw2vPB97YQe1j06z0T0VBUsFneZJWaoS8+dA/qXZsLQsa9AQ4GNiluiQWbr22+y6WWZqAzh+S21xv1n0eseds7RmTVviuFlPZZFWq2p7oGuu2f+Lv1Gcnb3mTLnY9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4BSXoeu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-56097de96fcso178658e87.3;
        Fri, 05 Sep 2025 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757082338; x=1757687138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t49T5ieWmqvjuwDEwWCSzOWxn76CDIcibE8FOXUbAwE=;
        b=c4BSXoeuE7IeFlfQe2V18VKIb5SWH2THmLgTulIzYDFgHMst2kAqUIyqA0s2dhNIYN
         eqfJULy5uoo6be6MipJP3JL5JC9vyhHVAyCs5/YjWioX1zKyfx+r0RE+4uz0gKtzYGpj
         dKz8OPAFEM+42ha6tYZXR2BaiPCoVCi2L0nGiYfLNEmh9H3ORtKQ6WVqPm1Jz8awnGla
         FQY4BS2alLIkhDSthoSkUe8o84vpJwKTry15ps3OxrfP/hBK5yd/ipywOncfNUCH97xE
         YRTTsUVyM5VEFJvo2U0gip0yxIOGtlTxQ/CbHaC71RQ0lSXejRGkYlCv9Hrlt6AvFFkD
         lWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757082338; x=1757687138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t49T5ieWmqvjuwDEwWCSzOWxn76CDIcibE8FOXUbAwE=;
        b=LJgFpuEiQFa+oaGJKQrHFuwcD6TT3Z156RMhOi8jQlAOP5hoRgxLIfuZofjCQTLtTZ
         LPYCXL3Am/oAtNup0voHflxn5aYVlT2OAiF925vpw8XWlYY6EPzFEHutUsPZ4EXVrjqO
         A/20udgAglbobIeOkfE7ldY71a7nRvWEoeb/L1n690/3Y/cFbFcPVAAv2WORLutakV37
         dktwx040Fa9kRJx5eNT4fLRmq9LO41QLylNnIGldZmBvXuzxoB9OhP7vS5AVOsvRaGyx
         qZ3KhVvl4nbA9dy9mILFADyWa/ojWH593KQw6kLvX7LG28aKVXZIbjzuexGroeRk6CN2
         d59g==
X-Forwarded-Encrypted: i=1; AJvYcCUbDEwZ2QRFj32H+ewj6shaiYW8MQ3sjbrj4o/pHkde5Jsby3R+RSiyqSJznASulz0P0Idc5VQ9llsbnls=@vger.kernel.org, AJvYcCXPJrQJjHhf8XBLO/KLt0lxWEIUP2tkhTdnX9Ba8qm4GcWSfISFJ7SM0vjrYscKPU6Ufec8JoGH@vger.kernel.org
X-Gm-Message-State: AOJu0YwRva3JE25vU71GZUPOfGaCKopXT/A4wr9ipH2ZsaFIlh3lvxe9
	OgEqcK4tzGyl/exSvm2H8QUC9S7dduwX0KaQKO8pPRw1V52lBJIBjT+X
X-Gm-Gg: ASbGncvlGM8DM4Vacs4ar66fdqm0/+FvBoqJpXG6MNTEcZGZvgJB74fHpOShFqgtbWY
	eLsaYzZb4rX33qJ9iOx/s1T1yeJ2FAwTZLZY1WyCapsEW6PDOaLdGKAFA1Y79bNNYtuLGJM3MBU
	4DM618uBlgykDc4DTWfPIIkqBNJHYA07dok+K6pYOjYabChSEzBzqiqHe4PfmHYcRsT+kxW7sEw
	1B4Umrfj3b+w3G7UBRGAZcnwv2UNd+6XbqWbCFGp5E1qoxA7dW3AQB9vjkZ5cHqdnmdQfTrh7wJ
	djWbKRDZfO2Nq04yblWpzjoi6haSz0e/4d72ta9xYU63J0zae71tGNXDmp+Q41KdiPsqTzrAPyX
	F1u/3UKSZLE9guTbT1WnIvJMIqyB4
X-Google-Smtp-Source: AGHT+IFCdyxxpgiXvUfdPu0jSkipTrD4cYHne5e/pQOWtiT7Jg2VilLFWXWjFeMaxSOCIlf6n/Wo6g==
X-Received: by 2002:a05:6512:3e1a:b0:55e:a69:f4a3 with SMTP id 2adb3069b0e04-55f6b19a1a4mr3693761e87.6.1757082338231;
        Fri, 05 Sep 2025 07:25:38 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ace81a7sm1775871e87.74.2025.09.05.07.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:25:37 -0700 (PDT)
Message-ID: <732359e4-8b8b-4925-8d66-2531e7a22b73@gmail.com>
Date: Fri, 5 Sep 2025 16:25:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmalloc, mm/kasan: respect gfp mask in
 kasan_populate_vmalloc()
To: Uladzislau Rezki <urezki@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
 Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
References: <20250831121058.92971-1-urezki@gmail.com>
 <20250831122410.fa3dcddb4a11757ebb16b376@linux-foundation.org>
 <aLVuw2UkYUcL_Oi0@pc638.lan>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <aLVuw2UkYUcL_Oi0@pc638.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/1/25 12:00 PM, Uladzislau Rezki wrote:
> On Sun, Aug 31, 2025 at 12:24:10PM -0700, Andrew Morton wrote:
>> On Sun, 31 Aug 2025 14:10:58 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:
>>
>>> kasan_populate_vmalloc() and its helpers ignore the caller's gfp_mask
>>> and always allocate memory using the hardcoded GFP_KERNEL flag. This
>>> makes them inconsistent with vmalloc(), which was recently extended to
>>> support GFP_NOFS and GFP_NOIO allocations.
>>>
>>> Page table allocations performed during shadow population also ignore
>>> the external gfp_mask. To preserve the intended semantics of GFP_NOFS
>>> and GFP_NOIO, wrap the apply_to_page_range() calls into the appropriate
>>> memalloc scope.
>>>
>>> This patch:
>>>  - Extends kasan_populate_vmalloc() and helpers to take gfp_mask;
>>>  - Passes gfp_mask down to alloc_pages_bulk() and __get_free_page();
>>>  - Enforces GFP_NOFS/NOIO semantics with memalloc_*_save()/restore()
>>>    around apply_to_page_range();
>>>  - Updates vmalloc.c and percpu allocator call sites accordingly.
>>>
>>> To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
>>> Cc: <stable@vger.kernel.org>
>>> Fixes: 451769ebb7e7 ("mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc")
>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>
>> Why cc:stable?
>>
>> To justify this we'll need a description of the userspace visible
>> effects of the bug please.  We should always provide this information
>> when fixing something.  Or when adding something.  Basically, all the
>> time ;)
>>
> Yes, i am not aware about any report. I was thinking more about that
> "mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc" was incomplete and thus
> is a good candidate for stable.
> 
> We can drop it for the stable until there are some reports from people.
> If there are :)
> 

xfs calls vmalloc with GFP_NOFS, so this bug could lead to deadlock and worth
the stable tag.

There was a report here https://lkml.kernel.org/r/686ea951.050a0220.385921.0016.GAE@google.com


> Thanks!
> 
> --
> Uladzislau Rezki
> 


