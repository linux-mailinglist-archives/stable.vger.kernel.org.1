Return-Path: <stable+bounces-114430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D43F3A2DCA4
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 11:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B60C164299
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 10:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E181C1598F4;
	Sun,  9 Feb 2025 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="FYQ6biCv"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD6814A619;
	Sun,  9 Feb 2025 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739098293; cv=none; b=Yz9zSaLeQ3CBich/8DPmIrvffmqnq+AT41o2eVTFggHyHKG+wJBbxXnEGo6ds/YprhMWCI+NdohrkW2XArkTJFba08dLowpzxkvV/GRS/bEHxWKEu6m6v5t9VIunyCxjp+Gp7bFRe4/uDO1JW5SUwRr44K0hjFsgT+C+p0kh8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739098293; c=relaxed/simple;
	bh=sHaB9f2fr1jzeJrGdv574DKDrbs9J4UBBMJBCFOdRGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAxqdb5tCYjqfe8M4vjiUn2A5mY21dhmRnUMSu6l5uXeWi++mGWaUkdGF/zSlXiAZzOgzOjMYr/wVPAjtnqAmbqmOhKQUIBwpIQOyvgcfw01vkJ911KyrMQUZlXFAzSzpPItcEyPqTNsNWt2KpAP1LcQxE725zyj/I3RD6L0NKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=FYQ6biCv; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=akvxBzNGg7jDeoykg2ST3OpylLpsQxNNSX0ReAXujes=;
	b=FYQ6biCvxdySKjzXgIZwyQsBaY28b+vOe5YL3TVg7Ow11vsPtg3ZmlcMV3lk5c
	ta8JHicIVelQzwbDMHBRl+VA30KSUxEM6atk9FqIT6TLKxO+P+pI+DBtODh5tyWP
	q6ufXdqNDP7pPaMUDErKQfBJbE5ZxJuM2ON/PCfSjezuU=
Received: from [172.19.20.199] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDH_3griKhnXq5iAw--.62977S2;
	Sun, 09 Feb 2025 18:49:16 +0800 (CST)
Message-ID: <20a21d17-77d8-4120-8643-c575304c39f2@126.com>
Date: Sun, 9 Feb 2025 18:49:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: add an API to enable/disable concurrent memory
 allocation for the CMA
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, aisheng.dong@nxp.com, liuzixing@hygon.cn
References: <1737717687-16744-1-git-send-email-yangge1116@126.com>
 <CAGsJ_4y2zjCzRUgxkx2GpspFBD9Yon=R3SLaGezk9drQz+ikrQ@mail.gmail.com>
 <28edc5df-eed5-45b8-ab6d-76e63ef635a9@126.com>
 <CAGsJ_4yC=950MCeLDc-8inT52zH6GSEGBBfk+A0dwWEDE5_CMg@mail.gmail.com>
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <CAGsJ_4yC=950MCeLDc-8inT52zH6GSEGBBfk+A0dwWEDE5_CMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH_3griKhnXq5iAw--.62977S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFyftF4kJw1rJrykWrW5Awb_yoW7Gw4xpa
	y8G3WYk3yrJrnrA3s2qw4093ZIq397GF4UWry7K3s7Zr98tFnFgr1UKw15urykArWkWF1I
	vr4jq3ya9F15Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbHUDUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOh7uG2eoaOjRcAAAs-



在 2025/2/9 5:34, Barry Song 写道:
> On Sat, Feb 8, 2025 at 9:50 PM Ge Yang <yangge1116@126.com> wrote:
>>
>>
>>
>> 在 2025/1/28 17:58, Barry Song 写道:
>>> On Sat, Jan 25, 2025 at 12:21 AM <yangge1116@126.com> wrote:
>>>>
>>>> From: yangge <yangge1116@126.com>
>>>>
>>>> Commit 60a60e32cf91 ("Revert "mm/cma.c: remove redundant cma_mutex lock"")
>>>> simply reverts to the original method of using the cma_mutex to ensure
>>>> that alloc_contig_range() runs sequentially. This change was made to avoid
>>>> concurrency allocation failures. However, it can negatively impact
>>>> performance when concurrent allocation of CMA memory is required.
>>>
>>> Do we have some data?
>> Yes, I will add it in the next version, thanks.
>>>
>>>>
>>>> To address this issue, we could introduce an API for concurrency settings,
>>>> allowing users to decide whether their CMA can perform concurrent memory
>>>> allocations or not.
>>>
>>> Who is the intended user of cma_set_concurrency?
>> We have some drivers that use cma_set_concurrency(), but they have not
>> yet been merged into the mainline. The cma_alloc_mem() function in the
>> mainline also supports concurrent allocation of CMA memory. By applying
>> this patch, we can also achieve significant performance improvements in
>> certain scenarios. I will provide performance data in the next version.
>> I also feel it is somewhat
>>> unsafe since cma->concurr_alloc is not protected by any locks.
>> Ok, thanks.
>>>
>>> Will a user setting cma->concurr_alloc = 1 encounter the original issue that
>>> commit 60a60e32cf91 was attempting to fix?
>>>
>> Yes, if a user encounters the issue described in commit 60a60e32cf91,
>> they will not be able to set cma->concurr_alloc to 1.
> 
> A user who hasn't encountered a problem yet doesn't mean they won't
> encounter it; it most likely just means the testing time hasn't been long
> enough.
> 
> Is it possible to implement a per-CMA lock or range lock that simultaneously
> improves performance and prevents the original issue that commit
> 60a60e32cf91 aimed to fix?
> 
Using per-CMA locks can improve performance and prevent the original 
issue. I am currently preparing the patch. Thanks.
> I strongly believe that cma->concurr_alloc is not the right approach. Let's
> not waste our time on this kind of hack or workaround.  Instead, we should
> find a proper fix that remains transparent to users.
> 
>>>>
>>>> Fixes: 60a60e32cf91 ("Revert "mm/cma.c: remove redundant cma_mutex lock"")
>>>> Signed-off-by: yangge <yangge1116@126.com>
>>>> Cc: <stable@vger.kernel.org>
>>>> ---
>>>>    include/linux/cma.h |  2 ++
>>>>    mm/cma.c            | 22 ++++++++++++++++++++--
>>>>    mm/cma.h            |  1 +
>>>>    3 files changed, 23 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/include/linux/cma.h b/include/linux/cma.h
>>>> index d15b64f..2384624 100644
>>>> --- a/include/linux/cma.h
>>>> +++ b/include/linux/cma.h
>>>> @@ -53,6 +53,8 @@ extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
>>>>
>>>>    extern void cma_reserve_pages_on_error(struct cma *cma);
>>>>
>>>> +extern bool cma_set_concurrency(struct cma *cma, bool concurrency);
>>>> +
>>>>    #ifdef CONFIG_CMA
>>>>    struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp);
>>>>    bool cma_free_folio(struct cma *cma, const struct folio *folio);
>>>> diff --git a/mm/cma.c b/mm/cma.c
>>>> index de5bc0c..49a7186 100644
>>>> --- a/mm/cma.c
>>>> +++ b/mm/cma.c
>>>> @@ -460,9 +460,17 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
>>>>                   spin_unlock_irq(&cma->lock);
>>>>
>>>>                   pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
>>>> -               mutex_lock(&cma_mutex);
>>>> +
>>>> +               /*
>>>> +                * If the user sets the concurr_alloc of CMA to true, concurrent
>>>> +                * memory allocation is allowed. If the user sets it to false or
>>>> +                * does not set it, concurrent memory allocation is not allowed.
>>>> +                */
>>>> +               if (!cma->concurr_alloc)
>>>> +                       mutex_lock(&cma_mutex);
>>>>                   ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA, gfp);
>>>> -               mutex_unlock(&cma_mutex);
>>>> +               if (!cma->concurr_alloc)
>>>> +                       mutex_unlock(&cma_mutex);
>>>>                   if (ret == 0) {
>>>>                           page = pfn_to_page(pfn);
>>>>                           break;
>>>> @@ -610,3 +618,13 @@ int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
>>>>
>>>>           return 0;
>>>>    }
>>>> +
>>>> +bool cma_set_concurrency(struct cma *cma, bool concurrency)
>>>> +{
>>>> +       if (!cma)
>>>> +               return false;
>>>> +
>>>> +       cma->concurr_alloc = concurrency;
>>>> +
>>>> +       return true;
>>>> +}
>>>> diff --git a/mm/cma.h b/mm/cma.h
>>>> index 8485ef8..30f489d 100644
>>>> --- a/mm/cma.h
>>>> +++ b/mm/cma.h
>>>> @@ -16,6 +16,7 @@ struct cma {
>>>>           unsigned long   *bitmap;
>>>>           unsigned int order_per_bit; /* Order of pages represented by one bit */
>>>>           spinlock_t      lock;
>>>> +       bool concurr_alloc;
>>>>    #ifdef CONFIG_CMA_DEBUGFS
>>>>           struct hlist_head mem_head;
>>>>           spinlock_t mem_head_lock;
>>>> --
>>>> 2.7.4
>>>>
>>>>
>>>
> 
> Thanks
> Barry


