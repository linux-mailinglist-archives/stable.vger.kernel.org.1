Return-Path: <stable+bounces-128892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA24A7FB14
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955FF44277E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AAB266B41;
	Tue,  8 Apr 2025 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNbVwEiD"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B8227EBD
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106690; cv=none; b=QKbvNJmRF7kw1wKcidOAhQnyZtWmf4y4PoK0L+I9FWqxC3bdDhHrX+yQ4pCHJYKV43bhie4X3JfAWSerYEFmz5sKFD35L2ftfQLndiyKNhhFNyMrT18gpz6DL45po8Qv6skjTcbgi3DtMsRCGwTD/c63zGnDMBLsFeCUwncxZ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106690; c=relaxed/simple;
	bh=yXKLy+hizWzMHv8Eo640Ct3UbydnC2sK4MJcnsrE4wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EsFz3lk5qwfp5XZX6YF202BxNs6oNqtLVzYbPkQIQOrkbZa128tFRNTtGZ8T/7/qr1BrO0Ye74NO2JhKKiwmtWho3t+DykPY4d8eqHsig84EZHpt7uC+wYGqLP/RF23WqrRe3t6CINKs0TIqyDvY/LmCRdu5rS3pZwkmEhEborA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNbVwEiD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744106687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kj1LAjzVLrycOoC92xaMDx/uyEW4UgKap5c8EqUs4Pg=;
	b=YNbVwEiDAJ3WE+G9QHHeqIBL05Q9MbzpamCiC2frZNdpOG/Tp/8gHJPWTq9keZ3JsJwxIm
	Yrqkqk165JVXyBVtpqA7vmFJ7oWm3PifutEh38Zl0UNsJEOkGhVpvT1KlUbOLfT5D/g5UU
	Qt5tTVEh1saocenQBSLCqafw1MAnMMY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-PH9qZ3MiMB-AcgCEQlaYHw-1; Tue, 08 Apr 2025 06:04:46 -0400
X-MC-Unique: PH9qZ3MiMB-AcgCEQlaYHw-1
X-Mimecast-MFC-AGG-ID: PH9qZ3MiMB-AcgCEQlaYHw_1744106685
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912539665cso3294791f8f.1
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 03:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744106685; x=1744711485;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kj1LAjzVLrycOoC92xaMDx/uyEW4UgKap5c8EqUs4Pg=;
        b=EhRRzz+0VV/xDd1+Vgn3KXMI2zpc68HYMmQAo+V0Uz0spF0sQJdeWXyOIELn8tqH4I
         e5Ww/vPOINvj6NbCFqxjWhCZRJ9dxTotXDuCv/1dMP/6j0RF89kbFq/zT4cvl/kDmoLf
         yADeYtTJMD5I4KMk3JrujjY20LUFaFjrC4e2Q4UzCxX8oAe9CDVbhJik+pk82buyYU6x
         8ID1w+i2X/cCI8bZaeeikn/Si8Mmq/pDtqnrchQ6Py8jPJ2kzN8q2M2Kb5jyM6Eeqw+S
         X319LInbtuxWZKF2gcWSTVjsqRCHuuxCNl2Ohj9Ls7jlvk3s22k8r6W2tWWBgy//vpQp
         MapQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8zUx0MH2ktR2sOghXS58zy6GHvUGwPrLrn2XEQM4agSYpLMl2Tp092cCLJDU4Am1OelzFt74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6VWLK4xnWy4Z+PyFNTj4gaKdde/VKUurxt7Vl7XLBtxHX4T+J
	GPwzOwkgk2rW28kpwqSrbtpCSLLUs4cMr2FJvXhW+XbBmL05jPtWL4duPqaMNHfAV89+j5e5Pnh
	qnsBts/pVegxn8NjcPJBjn63VeCwNMl8hM2CzN5K9ZYs6hr2cMM0qfQ==
X-Gm-Gg: ASbGncvdvKNnfIX5kNh8KyPX9etBeu5lmM2/CDmxeTLpW30N3mp3MRz+0KZTXsgCd5f
	HEm4i6N6puqmkCIgqpvs20czYJCyV+DmvWUsZLBWdSM7NTchuJ3jpJ3X6WWAJiZWo4R8vXMZCwR
	sT2y/M2o/5HHa920MrcX0C4pyxGAf0oG7kzyOeBBLBwsV2d7lWb4zqP/wtSlkcHMLw47DjJSGaI
	LAMA4CVjaxLJ13vrAJPkeQfvzEY8DJ1BlQNejn9Z5xHvrpK/2ZRlJ1tv5dAJxbuTtfRr7ilK/Cd
	cwq4SaLmFlJZAnzYNgz6/YuVnr15Ep8tBpyORPK/Tb7zcQmZ0ZwC6jCZtiaWQTQxpv7yPXSw099
	YoQ8hVGKKiqA4mU6IdyTn5BQNMskH24+j34FIUOjc
X-Received: by 2002:a05:6000:4616:b0:39c:30d8:32a4 with SMTP id ffacd0b85a97d-39d821109camr2198607f8f.26.1744106684881;
        Tue, 08 Apr 2025 03:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBbDqmluBm4vHlC2XKeU/Gul9tTFQfBTDzznL84w+H3lL7envcP2yxtl0rC8qwLRu7o+ptLw==
X-Received: by 2002:a05:6000:4616:b0:39c:30d8:32a4 with SMTP id ffacd0b85a97d-39d821109camr2198579f8f.26.1744106684496;
        Tue, 08 Apr 2025 03:04:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:4f00:a44a:5ad6:765a:635? (p200300cbc7074f00a44a5ad6765a0635.dip0.t-ipconnect.de. [2003:cb:c707:4f00:a44a:5ad6:765a:635])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eda4662a0sm117984415e9.36.2025.04.08.03.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 03:04:43 -0700 (PDT)
Message-ID: <207a00a2-0895-4086-97ae-d31ead423cf8@redhat.com>
Date: Tue, 8 Apr 2025 12:04:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: Jinjiang Tu <tujinjiang@huawei.com>, yangge1116@126.com,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 21cnbao@gmail.com, baolin.wang@linux.alibaba.com,
 aneesh.kumar@linux.ibm.com, liuzixing@hygon.cn,
 Kefeng Wang <wangkefeng.wang@huawei.com>
References: <1720075944-27201-1-git-send-email-yangge1116@126.com>
 <4119c1d0-5010-b2e7-3f1c-edd37f16f1f2@huawei.com>
 <91ac638d-b2d6-4683-ab29-fb647f58af63@redhat.com>
 <076babae-9fc6-13f5-36a3-95dde0115f77@huawei.com>
 <26870d6f-8bb9-44de-9d1f-dcb1b5a93eae@redhat.com>
 <5d0cb178-6436-d98b-3abf-3bcf8710eb6f@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5d0cb178-6436-d98b-3abf-3bcf8710eb6f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.04.25 10:47, Jinjiang Tu wrote:
> 
> 在 2025/4/1 22:33, David Hildenbrand 写道:
>> On 27.03.25 12:16, Jinjiang Tu wrote:
>>>
>>> 在 2025/3/26 20:46, David Hildenbrand 写道:
>>>> On 26.03.25 13:42, Jinjiang Tu wrote:
>>>>> Hi,
>>>>>
>>>>
>>>> Hi!
>>>>
>>>>> We notiched a 12.3% performance regression for LibMicro pwrite
>>>>> testcase due to
>>>>> commit 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before
>>>>> adding to LRU batch").
>>>>>
>>>>> The testcase is executed as follows, and the file is tmpfs file.
>>>>>        pwrite -E -C 200 -L -S -W -N "pwrite_t1k" -s 1k -I 500 -f $TFILE
>>>>
>>>> Do we know how much that reflects real workloads? (IOW, how much
>>>> should we care)
>>>
>>> No, it's hard to say.
>>>
>>>>
>>>>>
>>>>> this testcase writes 1KB (only one page) to the tmpfs and repeats
>>>>> this step for many times. The Flame
>>>>> graph shows the performance regression comes from
>>>>> folio_mark_accessed() and workingset_activation().
>>>>>
>>>>> folio_mark_accessed() is called for the same page for many times.
>>>>> Before this patch, each call will
>>>>> add the page to cpu_fbatches.activate. When the fbatch is full, the
>>>>> fbatch is drained and the page
>>>>> is promoted to active list. And then, folio_mark_accessed() does
>>>>> nothing in later calls.
>>>>>
>>>>> But after this patch, the folio clear lru flags after it is added to
>>>>> cpu_fbatches.activate. After then,
>>>>> folio_mark_accessed will never call folio_activate() again due to the
>>>>> page is without lru flag, and
>>>>> the fbatch will not be full and the folio will not be marked active,
>>>>> later folio_mark_accessed()
>>>>> calls will always call workingset_activation(), leading to
>>>>> performance regression.
>>>>
>>>> Would there be a good place to drain the LRU to effectively get that
>>>> processed? (we can always try draining if the LRU flag is not set)
>>>
>>> Maybe we could drain the search the cpu_fbatches.activate of the
>>> local cpu in __lru_cache_activate_folio()? Drain other fbatches is
>>> meaningless .
>>
>> So the current behavior is that folio_mark_accessed() will end up
>> calling folio_activate()
>> once, and then __lru_cache_activate_folio() until the LRU was drained
>> (which can
>> take a looong time).
>>
>> The old behavior was that folio_mark_accessed() would keep calling
>> folio_activate() until
>> the LRU was drained simply because it was full of "all the same pages"
>> ?. Only *after*
>> the LRU was drained, folio_mark_accessed() would actually not do
>> anything (desired behavior).
>>
>> So the overhead comes primarily from __lru_cache_activate_folio()
>> searching through
>> the list "more" repeatedly because the LRU does get drained less
>> frequently; and
>> it would never find it in there in this case.
>>
>> So ... it used to be suboptimal before, now it's more suboptimal I
>> guess?! :)
>>
>> We'd need a way to better identify "this folio is already queued for
>> activation". Searching
>> that list as well would be one option, but the hole "search the list"
>> is nasty.
>>
>> Maybe we can simply set the folio as active when staging it for
>> activation, after having
>> cleared the LRU flag? We already do that during folio_add.
>>
>> As the LRU flag was cleared, nobody should be messing with that folio
>> until the cache was
>> drained and the move was successful.
>>
>>
>> Pretty sure this doesn't work, but just to throw out an idea:
>>
>>  From c26e1c0ceda6c818826e5b89dc7c7c9279138f80 Mon Sep 17 00:00:00 2001
>> From: David Hildenbrand <david@redhat.com>
>> Date: Tue, 1 Apr 2025 16:31:56 +0200
>> Subject: [PATCH] test
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/swap.c | 21 ++++++++++++++++-----
>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/swap.c b/mm/swap.c
>> index fc8281ef42415..bbf9aa76db87f 100644
>> --- a/mm/swap.c
>> +++ b/mm/swap.c
>> @@ -175,6 +175,8 @@ static void folio_batch_move_lru(struct
>> folio_batch *fbatch, move_fn_t move_fn)
>>       folios_put(fbatch);
>>   }
>>
>> +static void lru_activate(struct lruvec *lruvec, struct folio *folio);
>> +
>>   static void __folio_batch_add_and_move(struct folio_batch __percpu
>> *fbatch,
>>           struct folio *folio, move_fn_t move_fn,
>>           bool on_lru, bool disable_irq)
>> @@ -191,6 +193,10 @@ static void __folio_batch_add_and_move(struct
>> folio_batch __percpu *fbatch,
>>       else
>>           local_lock(&cpu_fbatches.lock);
>>
>> +    /* We'll only perform the actual list move deferred. */
>> +    if (move_fn == lru_activate)
>> +        folio_set_active(folio);
>> +
>>       if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
>> folio_test_large(folio) ||
>>           lru_cache_disabled())
>>           folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
>> @@ -299,12 +305,14 @@ static void lru_activate(struct lruvec *lruvec,
>> struct folio *folio)
>>   {
>>       long nr_pages = folio_nr_pages(folio);
>>
>> -    if (folio_test_active(folio) || folio_test_unevictable(folio))
>> -        return;
>> -
>> +    /*
>> +     * We set the folio active after clearing the LRU flag, and set the
>> +     * LRU flag only after moving it to the right list.
>> +     */
>> +    VM_WARN_ON_ONCE(!folio_test_active(folio));
>> +    VM_WARN_ON_ONCE(folio_test_unevictable(folio));
>>
>>       lruvec_del_folio(lruvec, folio);
>> -    folio_set_active(folio);
>>       lruvec_add_folio(lruvec, folio);
>>       trace_mm_lru_activate(folio);
>>
>> @@ -342,7 +350,10 @@ void folio_activate(struct folio *folio)
>>           return;
>>
>>       lruvec = folio_lruvec_lock_irq(folio);
>> -    lru_activate(lruvec, folio);
>> +    if (!folio_test_unevictable(folio)) {
>> +        folio_set_active(folio);
>> +        lru_activate(lruvec, folio);
>> +    }
>>       unlock_page_lruvec_irq(lruvec);
>>       folio_set_lru(folio);
>>   }
> 
> I test with the patch, and the performance regression disappears.
> 
> By the way, I find folio_test_unevictable() is called in lru_deactivate, lru_lazyfree, etc.
> unevictable flag is set when the caller clears lru flag. IIUC, since commit 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before
> adding to LRU batch"), folios in fbatch can't be set unevictable flag, so there is no need to check unevictable flag in lru_deactivate, lru_lazyfree, etc?

I was asking myself the exact same question when crafting this patch. 
Sounds like a cleanup worth investigating! :)

Do you have capacity to look into that, and to turn my proposal into a 
proper patch? It might take me a bit until I get to it.

-- 
Cheers,

David / dhildenb


