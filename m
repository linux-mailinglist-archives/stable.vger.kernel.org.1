Return-Path: <stable+bounces-169854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33990B28C71
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 11:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44661C82133
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 09:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBC6243378;
	Sat, 16 Aug 2025 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7X2e6qe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124CC23F40F;
	Sat, 16 Aug 2025 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755336788; cv=none; b=PrmnRS/JhUc5Ab7tzh6IuSLTzuCMMgWHThvrJHa7zO6n3UVHCx39jvDa8RWmO/KqE4dMkrSWwWr1J2r2t4x1FcV2wVYQiSrMYd7WhSaA9fT/+ybrhx56WxKscIQI85Go/f1+BaPro6OTobGK0fvrFPwFlsZYMw3khQoN6+9VpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755336788; c=relaxed/simple;
	bh=hdiMuqUgn3hq9fvJi99uwhoP1Kg6ZzWdtYhvi9M7LI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5he+/3w7Luo7eHBi3bEHQv/xvElb4sbVPv5ucKoYw83ggbkl3NA5n2R1yUs67u919vdclwk64PYk6bOVFdYS4zW5Hkod/aBNaOVtpHKjcJcD5b6xjNWDrfGF7I9TUMS1gJeDUmbNV71QaD4qZcHBFvyxyrXfYNwRTqWC36s62Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7X2e6qe; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9e4110df6so363682f8f.2;
        Sat, 16 Aug 2025 02:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755336784; x=1755941584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Px5kT9Zj2OEa6lf/DpL6BrsHwqOYEXNq7iLeLvlTsBw=;
        b=J7X2e6qeuP3EHGpkScroL60nUwlACJ5fO71Wn/lCNPMGmuRcSQaHkACdPTh+0uD0sT
         k0nD6yXgGQ7yibWj6ukApzLlBodg8YCt8RmN0GOPbPrMTJvbTuFlORUh21cmtthZIBYQ
         fECEWtGbBZWk5vB4P3C9tg//W+Om/RoAr1UMR+jOCkA48RZvTPQnUzWo4+c7GjQwrsr/
         3YZ54Pb/KBaxr2r74F5oXJoMRtIMIFlp+7HUOHkHURzevdHAk9TPnYYY4frzbnxKfnq5
         aS3qLAT4mjNO8ClmRlIUpihjVMeQz8f6CqPuaeqoDkFhYGUw2mEXCtCoLiPs7weDB3Do
         3kkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755336784; x=1755941584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Px5kT9Zj2OEa6lf/DpL6BrsHwqOYEXNq7iLeLvlTsBw=;
        b=jbQd73CaylP1PSRrLgBWE8XQj49R4wdrvv2fnN27wJFVnQfvVOwmG3dAMZ7Kha9Pru
         F46ZYQO//TG+3FbHRCR8xo7UoztwdKlzVfz7/0FE6gjyUivM5owvjTNtnCAotMGWefVu
         neLsZIWTZNjekqfAW4jobS43xEg1fQOKik3Y7TpuFUZOzt71LXsJJAwe5bOWpD97mqTi
         IjQG9ZBU/+f8MKKoJF8N9FFxvbaHt/NoWXC1Fk1Op8DagHwb8OondtGqwF8FoVzK7ETI
         V7Ou/XZYR3amnBeo6XpbXtvPW3zrTz6n8nLLfjXpQeD4WW8Brc4poTokyh/WWo3m2yZB
         j1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUT51GvoDqTCHtczL9gLsPcDC9KYyp2Jn2sH3BAn2l/tMKbBEmxbtoIZhy0ro7tPRwNG3MktU2h@vger.kernel.org, AJvYcCVU9c3oMKDNlw5agOzs+97O/KSz4bTWywGH37oqmHt30+9qGKpk8BbYfpMAcnB9B9QXFWNwBGHogrcF8Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZDZx+eaM0Ufp2PKpotGxT4rPMZLTFBWk6G5lecZlTh8tuJjA5
	cRseu2hWZKIVaD6wjGnvL32MPa49Am2hrmJb3hkvb2c5GyNQ0ZK6bkUq
X-Gm-Gg: ASbGnct7hC+8bRichG/mG59bofOoJ1jS+wEC+AtW0Xcr4lz+ns8eaJy6okkL6PV3CqR
	i+w6N0AWzNseUj17uHQyZgg/K7VGAaKQfQa7Qg9FUdKq40Ml3FQHF8SiBSkAyH/NoMtLi+V+rdz
	ai2pYL4qOCT6Ew2uMW3mHSePnKq0syhphddEF8TR9VDSeIOvhn7sWgqawd9gK977k0sCLxNNMTZ
	ZfVJT5Oi09lrc5ov4ZIEE293rVxTtfaLaWxPBIT6P2LCTBuVeYuLIg1l0GXUYsvHFTdeI0mFJ5l
	gB+a6RWzFhbxUQ4Pp1ptlNSIWZDEkp4zduSG8P2ba+1tyLWauXaNGhirazXlQM5b2GxcAN3MI4p
	yptEZii8pjSQMmqp07G04HGHYU157fP4d2Smcid14rlNhfrQ/SLRw
X-Google-Smtp-Source: AGHT+IHOKiBGjTArO+Umj5Qhqd1VsyKLXbP72Y00mZJdxOsRmVixr/6cIZOinpjUeu5gz+hEOi9gkA==
X-Received: by 2002:a05:600c:444a:b0:459:d449:a629 with SMTP id 5b1f17b1804b1-45a21895202mr18979955e9.8.1755336783950;
        Sat, 16 Aug 2025 02:33:03 -0700 (PDT)
Received: from [192.168.100.4] ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6475857dsm5171864f8f.2.2025.08.16.02.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 02:33:03 -0700 (PDT)
Message-ID: <eab6a734-b134-41a4-b455-7269eaaf033e@gmail.com>
Date: Sat, 16 Aug 2025 13:33:00 +0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: slub: avoid wake up kswapd in set_track_prepare
To: Harry Yoo <harry.yoo@oracle.com>, yangshiguang1011@163.com
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org,
 rientjes@google.com, roman.gushchin@linux.dev, glittao@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 yangshiguang <yangshiguang@xiaomi.com>
References: <20250814111641.380629-2-yangshiguang1011@163.com>
 <aKBAdUkCd95Rg85A@harry>
Content-Language: en-US
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
In-Reply-To: <aKBAdUkCd95Rg85A@harry>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Rather than masking to GFP_NOWAIT—which still allows kswapd to be 
woken—let’s strip every reclaim bit (`__GFP_RECLAIM` and 
`__GFP_KSWAPD_RECLAIM`) and add `__GFP_NORETRY | __GFP_NOWARN`. That 
guarantees we never enter the slow path that calls `wakeup_kswapd()`, so 
the timer-base lock can’t be re-entered.

On 8/16/2025 12:25 PM, Harry Yoo wrote:
> On Thu, Aug 14, 2025 at 07:16:42PM +0800, yangshiguang1011@163.com wrote:
>> From: yangshiguang <yangshiguang@xiaomi.com>
>>
>> From: yangshiguang <yangshiguang@xiaomi.com>
>>
>> set_track_prepare() can incur lock recursion.
>> The issue is that it is called from hrtimer_start_range_ns
>> holding the per_cpu(hrtimer_bases)[n].lock, but when enabled
>> CONFIG_DEBUG_OBJECTS_TIMERS, may wake up kswapd in set_track_prepare,
>> and try to hold the per_cpu(hrtimer_bases)[n].lock.
>>
>> So avoid waking up kswapd.The oops looks something like:
> 
> Hi yangshiguang,
> 
> In the next revision, could you please elaborate the commit message
> to reflect how this change avoids waking up kswapd?
> 
>> BUG: spinlock recursion on CPU#3, swapper/3/0
>>   lock: 0xffffff8a4bf29c80, .magic: dead4ead, .owner: swapper/3/0, .owner_cpu: 3
>> Hardware name: Qualcomm Technologies, Inc. Popsicle based on SM8850 (DT)
>> Call trace:
>> spin_bug+0x0
>> _raw_spin_lock_irqsave+0x80
>> hrtimer_try_to_cancel+0x94
>> task_contending+0x10c
>> enqueue_dl_entity+0x2a4
>> dl_server_start+0x74
>> enqueue_task_fair+0x568
>> enqueue_task+0xac
>> do_activate_task+0x14c
>> ttwu_do_activate+0xcc
>> try_to_wake_up+0x6c8
>> default_wake_function+0x20
>> autoremove_wake_function+0x1c
>> __wake_up+0xac
>> wakeup_kswapd+0x19c
>> wake_all_kswapds+0x78
>> __alloc_pages_slowpath+0x1ac
>> __alloc_pages_noprof+0x298
>> stack_depot_save_flags+0x6b0
>> stack_depot_save+0x14
>> set_track_prepare+0x5c
>> ___slab_alloc+0xccc
>> __kmalloc_cache_noprof+0x470
>> __set_page_owner+0x2bc
>> post_alloc_hook[jt]+0x1b8
>> prep_new_page+0x28
>> get_page_from_freelist+0x1edc
>> __alloc_pages_noprof+0x13c
>> alloc_slab_page+0x244
>> allocate_slab+0x7c
>> ___slab_alloc+0x8e8
>> kmem_cache_alloc_noprof+0x450
>> debug_objects_fill_pool+0x22c
>> debug_object_activate+0x40
>> enqueue_hrtimer[jt]+0xdc
>> hrtimer_start_range_ns+0x5f8
>> ...
>>
>> Signed-off-by: yangshiguang <yangshiguang@xiaomi.com>
>> Fixes: 5cf909c553e9 ("mm/slub: use stackdepot to save stack trace in objects")
>> ---
>> v1 -> v2:
>>      propagate gfp flags to set_track_prepare()
>>
>> [1] https://lore.kernel.org/all/20250801065121.876793-1-yangshiguang1011@163.com
>> ---
>>   mm/slub.c | 21 +++++++++++----------
>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 30003763d224..dba905bf1e03 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -962,19 +962,20 @@ static struct track *get_track(struct kmem_cache *s, void *object,
>>   }
>>   
>>   #ifdef CONFIG_STACKDEPOT
>> -static noinline depot_stack_handle_t set_track_prepare(void)
>> +static noinline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
>>   {
>>   	depot_stack_handle_t handle;
>>   	unsigned long entries[TRACK_ADDRS_COUNT];
>>   	unsigned int nr_entries;
>> +	gfp_flags &= GFP_NOWAIT;
> 
> Is there any reason to downgrade it to GFP_NOWAIT when the gfp flag allows
> direct reclamation?
> 
>>   	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
>> -	handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
>> +	handle = stack_depot_save(entries, nr_entries, gfp_flags);
>>   
>>   	return handle;
>>   }
>>   #else
>> -static inline depot_stack_handle_t set_track_prepare(void)
>> +static inline depot_stack_handle_t set_track_prepare(gfp_t gfp_flags)
>>   {
>>   	return 0;
>>   }
>> @@ -4422,7 +4423,7 @@ static noinline void free_to_partial_list(
>>   	depot_stack_handle_t handle = 0;
>>   
>>   	if (s->flags & SLAB_STORE_USER)
>> -		handle = set_track_prepare();
>> +		handle = set_track_prepare(GFP_NOWAIT);
> 
> I don't think it is safe to use GFP_NOWAIT during free?
> 
> Let's say fill_pool() -> kmem_alloc_batch() fails to allocate an object
> and then free_object_list() frees allocated objects,
> set_track_prepare(GFP_NOWAIT) may wake up kswapd, and the same deadlock
> you reported will occur.
> 
> So I think it should be __GFP_NOWARN?
> 


