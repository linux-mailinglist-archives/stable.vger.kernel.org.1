Return-Path: <stable+bounces-128844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9020DA7F850
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F8017A687C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 08:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD32265CD7;
	Tue,  8 Apr 2025 08:47:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EF0264A85;
	Tue,  8 Apr 2025 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102057; cv=none; b=R1epomcCRQ45UUeKqZkNGoVUiTLHCf8J+uV1ezg9nlI53+qkd4/mGr1GKlCGFyJUCN74odm6lGtgRPYFL1wHL99bvFKY6X9d9kyIohfH808307DxLGckZ90UGJ/Qk6CTSEj32axHJyYnWZVUqPvXDZm5tm0TIxAvc3RK3YPZbCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102057; c=relaxed/simple;
	bh=df96zuAXy/qaM6HEmIGFHZF4fh0ThTfIJDQVWvT/Rfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IlT5CXsVR46n4ATUPJos9YDQc8PqYp99XXJcapKl8L4SagNmH9E3l25/PIPZWdFz4+xKv1uT7f/5CImlPouZjMQ2RJd9hwBsxslNng5Q4LWC7t33MPuLGnilaNA/zjJaN9MXwcD1MLjhW/UabDk9M597oN1QrB2GwS3K7IohhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZX06H4M88ztRKt;
	Tue,  8 Apr 2025 16:45:59 +0800 (CST)
Received: from kwepemo200002.china.huawei.com (unknown [7.202.195.209])
	by mail.maildlp.com (Postfix) with ESMTPS id 921071402CD;
	Tue,  8 Apr 2025 16:47:23 +0800 (CST)
Received: from [10.174.179.13] (10.174.179.13) by
 kwepemo200002.china.huawei.com (7.202.195.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 16:47:22 +0800
Message-ID: <5d0cb178-6436-d98b-3abf-3bcf8710eb6f@huawei.com>
Date: Tue, 8 Apr 2025 16:47:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V4] mm/gup: Clear the LRU flag of a page before adding to
 LRU batch
To: David Hildenbrand <david@redhat.com>, <yangge1116@126.com>,
	<akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <21cnbao@gmail.com>,
	<baolin.wang@linux.alibaba.com>, <aneesh.kumar@linux.ibm.com>,
	<liuzixing@hygon.cn>, Kefeng Wang <wangkefeng.wang@huawei.com>
References: <1720075944-27201-1-git-send-email-yangge1116@126.com>
 <4119c1d0-5010-b2e7-3f1c-edd37f16f1f2@huawei.com>
 <91ac638d-b2d6-4683-ab29-fb647f58af63@redhat.com>
 <076babae-9fc6-13f5-36a3-95dde0115f77@huawei.com>
 <26870d6f-8bb9-44de-9d1f-dcb1b5a93eae@redhat.com>
From: Jinjiang Tu <tujinjiang@huawei.com>
In-Reply-To: <26870d6f-8bb9-44de-9d1f-dcb1b5a93eae@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemo200002.china.huawei.com (7.202.195.209)


在 2025/4/1 22:33, David Hildenbrand 写道:
> On 27.03.25 12:16, Jinjiang Tu wrote:
>>
>> 在 2025/3/26 20:46, David Hildenbrand 写道:
>>> On 26.03.25 13:42, Jinjiang Tu wrote:
>>>> Hi,
>>>>
>>>
>>> Hi!
>>>
>>>> We notiched a 12.3% performance regression for LibMicro pwrite
>>>> testcase due to
>>>> commit 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before
>>>> adding to LRU batch").
>>>>
>>>> The testcase is executed as follows, and the file is tmpfs file.
>>>>       pwrite -E -C 200 -L -S -W -N "pwrite_t1k" -s 1k -I 500 -f $TFILE
>>>
>>> Do we know how much that reflects real workloads? (IOW, how much
>>> should we care)
>>
>> No, it's hard to say.
>>
>>>
>>>>
>>>> this testcase writes 1KB (only one page) to the tmpfs and repeats
>>>> this step for many times. The Flame
>>>> graph shows the performance regression comes from
>>>> folio_mark_accessed() and workingset_activation().
>>>>
>>>> folio_mark_accessed() is called for the same page for many times.
>>>> Before this patch, each call will
>>>> add the page to cpu_fbatches.activate. When the fbatch is full, the
>>>> fbatch is drained and the page
>>>> is promoted to active list. And then, folio_mark_accessed() does
>>>> nothing in later calls.
>>>>
>>>> But after this patch, the folio clear lru flags after it is added to
>>>> cpu_fbatches.activate. After then,
>>>> folio_mark_accessed will never call folio_activate() again due to the
>>>> page is without lru flag, and
>>>> the fbatch will not be full and the folio will not be marked active,
>>>> later folio_mark_accessed()
>>>> calls will always call workingset_activation(), leading to
>>>> performance regression.
>>>
>>> Would there be a good place to drain the LRU to effectively get that
>>> processed? (we can always try draining if the LRU flag is not set)
>>
>> Maybe we could drain the search the cpu_fbatches.activate of the 
>> local cpu in __lru_cache_activate_folio()? Drain other fbatches is 
>> meaningless .
>
> So the current behavior is that folio_mark_accessed() will end up 
> calling folio_activate()
> once, and then __lru_cache_activate_folio() until the LRU was drained 
> (which can
> take a looong time).
>
> The old behavior was that folio_mark_accessed() would keep calling 
> folio_activate() until
> the LRU was drained simply because it was full of "all the same pages" 
> ?. Only *after*
> the LRU was drained, folio_mark_accessed() would actually not do 
> anything (desired behavior).
>
> So the overhead comes primarily from __lru_cache_activate_folio() 
> searching through
> the list "more" repeatedly because the LRU does get drained less 
> frequently; and
> it would never find it in there in this case.
>
> So ... it used to be suboptimal before, now it's more suboptimal I 
> guess?! :)
>
> We'd need a way to better identify "this folio is already queued for 
> activation". Searching
> that list as well would be one option, but the hole "search the list" 
> is nasty.
>
> Maybe we can simply set the folio as active when staging it for 
> activation, after having
> cleared the LRU flag? We already do that during folio_add.
>
> As the LRU flag was cleared, nobody should be messing with that folio 
> until the cache was
> drained and the move was successful.
>
>
> Pretty sure this doesn't work, but just to throw out an idea:
>
> From c26e1c0ceda6c818826e5b89dc7c7c9279138f80 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Tue, 1 Apr 2025 16:31:56 +0200
> Subject: [PATCH] test
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/swap.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index fc8281ef42415..bbf9aa76db87f 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -175,6 +175,8 @@ static void folio_batch_move_lru(struct 
> folio_batch *fbatch, move_fn_t move_fn)
>      folios_put(fbatch);
>  }
>
> +static void lru_activate(struct lruvec *lruvec, struct folio *folio);
> +
>  static void __folio_batch_add_and_move(struct folio_batch __percpu 
> *fbatch,
>          struct folio *folio, move_fn_t move_fn,
>          bool on_lru, bool disable_irq)
> @@ -191,6 +193,10 @@ static void __folio_batch_add_and_move(struct 
> folio_batch __percpu *fbatch,
>      else
>          local_lock(&cpu_fbatches.lock);
>
> +    /* We'll only perform the actual list move deferred. */
> +    if (move_fn == lru_activate)
> +        folio_set_active(folio);
> +
>      if (!folio_batch_add(this_cpu_ptr(fbatch), folio) || 
> folio_test_large(folio) ||
>          lru_cache_disabled())
>          folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
> @@ -299,12 +305,14 @@ static void lru_activate(struct lruvec *lruvec, 
> struct folio *folio)
>  {
>      long nr_pages = folio_nr_pages(folio);
>
> -    if (folio_test_active(folio) || folio_test_unevictable(folio))
> -        return;
> -
> +    /*
> +     * We set the folio active after clearing the LRU flag, and set the
> +     * LRU flag only after moving it to the right list.
> +     */
> +    VM_WARN_ON_ONCE(!folio_test_active(folio));
> +    VM_WARN_ON_ONCE(folio_test_unevictable(folio));
>
>      lruvec_del_folio(lruvec, folio);
> -    folio_set_active(folio);
>      lruvec_add_folio(lruvec, folio);
>      trace_mm_lru_activate(folio);
>
> @@ -342,7 +350,10 @@ void folio_activate(struct folio *folio)
>          return;
>
>      lruvec = folio_lruvec_lock_irq(folio);
> -    lru_activate(lruvec, folio);
> +    if (!folio_test_unevictable(folio)) {
> +        folio_set_active(folio);
> +        lru_activate(lruvec, folio);
> +    }
>      unlock_page_lruvec_irq(lruvec);
>      folio_set_lru(folio);
>  }

I test with the patch, and the performance regression disappears.

By the way, I find folio_test_unevictable() is called in lru_deactivate, lru_lazyfree, etc.
unevictable flag is set when the caller clears lru flag. IIUC, since commit 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before
adding to LRU batch"), folios in fbatch can't be set unevictable flag, so there is no need to check unevictable flag in lru_deactivate, lru_lazyfree, etc?


