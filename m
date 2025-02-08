Return-Path: <stable+bounces-114375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38091A2D4F0
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 09:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A786116A495
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 08:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A791A2C11;
	Sat,  8 Feb 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="b2xwJPoO"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6001A0BF3;
	Sat,  8 Feb 2025 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739004732; cv=none; b=Cx4HzUEqea5ZJ1fSixiuXXUk1XVlzTeWqGhRYFS5cFLeNkED1SJnMYIyrhYhm24y0LLsPQzT26g9CCDen8Swj1LxsO5lhIwR9Mq6Xk3WUnw25lpOwciAdH6WZnFdnrH7cdAlnR3U6SrmzHhhP9CKR7zFnp+bngAD9rlRmnE4Vwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739004732; c=relaxed/simple;
	bh=AZoMrwCMIpKGPHiKvFbL1EkmEsTsjgKEnMYG1p45oV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dksOleNrjjKc3TbISKrSaKxuSp497GGeKAn9MPjVG4qZLopDMGX+U9u+x3aqKgwn6lt9uhDbjfY6MopLeffJU6U6xY22R1S4/7mjt+qKsEIKrPTNvJsJH+obdME5qCLiyUfq88f9JPekV1otnXy+mtAMIffi0SDY9sayv2V9FUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=b2xwJPoO; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=Wp52D9fpjdxEowIxQTuIVRiH+cfHPxfJV9jwR5WSAfM=;
	b=b2xwJPoOQBDC2eqY8yzPGC4e5KHs0I4LoGjLCbe18y8xdNlJAWhr9ulXCaNxWs
	S4gjDWE8sh/xJuECf5wVSq1bbbD5jna11J7tvgARUdmI/tqdw/MlXbrKvcYNLfeu
	xUXMsKYa/WRm7+dsnRPZ6O7d/jf4oBS+jJN4AftnJpLCM=
Received: from [172.19.20.199] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD35zHmGqdnQ8XpAg--.51012S2;
	Sat, 08 Feb 2025 16:50:46 +0800 (CST)
Message-ID: <28edc5df-eed5-45b8-ab6d-76e63ef635a9@126.com>
Date: Sat, 8 Feb 2025 16:50:46 +0800
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
From: Ge Yang <yangge1116@126.com>
In-Reply-To: <CAGsJ_4y2zjCzRUgxkx2GpspFBD9Yon=R3SLaGezk9drQz+ikrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD35zHmGqdnQ8XpAg--.51012S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF4kJr18ZFWkCw47Zw1DJrb_yoWrWryDpF
	W8G3WYk345XrnrZ392qw4093ZIg397CF4UGFyagas7ZF9xtr12gr1UKw15ur98ArWkWF1I
	vF4jq34a93WUZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbPEfUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbifhntG2enCquwowAAsj



在 2025/1/28 17:58, Barry Song 写道:
> On Sat, Jan 25, 2025 at 12:21 AM <yangge1116@126.com> wrote:
>>
>> From: yangge <yangge1116@126.com>
>>
>> Commit 60a60e32cf91 ("Revert "mm/cma.c: remove redundant cma_mutex lock"")
>> simply reverts to the original method of using the cma_mutex to ensure
>> that alloc_contig_range() runs sequentially. This change was made to avoid
>> concurrency allocation failures. However, it can negatively impact
>> performance when concurrent allocation of CMA memory is required.
> 
> Do we have some data?
Yes, I will add it in the next version, thanks.
> 
>>
>> To address this issue, we could introduce an API for concurrency settings,
>> allowing users to decide whether their CMA can perform concurrent memory
>> allocations or not.
> 
> Who is the intended user of cma_set_concurrency? 
We have some drivers that use cma_set_concurrency(), but they have not 
yet been merged into the mainline. The cma_alloc_mem() function in the 
mainline also supports concurrent allocation of CMA memory. By applying 
this patch, we can also achieve significant performance improvements in 
certain scenarios. I will provide performance data in the next version.
I also feel it is somewhat
> unsafe since cma->concurr_alloc is not protected by any locks.
Ok, thanks.
> 
> Will a user setting cma->concurr_alloc = 1 encounter the original issue that
> commit 60a60e32cf91 was attempting to fix?
> 
Yes, if a user encounters the issue described in commit 60a60e32cf91, 
they will not be able to set cma->concurr_alloc to 1.
>>
>> Fixes: 60a60e32cf91 ("Revert "mm/cma.c: remove redundant cma_mutex lock"")
>> Signed-off-by: yangge <yangge1116@126.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>   include/linux/cma.h |  2 ++
>>   mm/cma.c            | 22 ++++++++++++++++++++--
>>   mm/cma.h            |  1 +
>>   3 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/cma.h b/include/linux/cma.h
>> index d15b64f..2384624 100644
>> --- a/include/linux/cma.h
>> +++ b/include/linux/cma.h
>> @@ -53,6 +53,8 @@ extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
>>
>>   extern void cma_reserve_pages_on_error(struct cma *cma);
>>
>> +extern bool cma_set_concurrency(struct cma *cma, bool concurrency);
>> +
>>   #ifdef CONFIG_CMA
>>   struct folio *cma_alloc_folio(struct cma *cma, int order, gfp_t gfp);
>>   bool cma_free_folio(struct cma *cma, const struct folio *folio);
>> diff --git a/mm/cma.c b/mm/cma.c
>> index de5bc0c..49a7186 100644
>> --- a/mm/cma.c
>> +++ b/mm/cma.c
>> @@ -460,9 +460,17 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
>>                  spin_unlock_irq(&cma->lock);
>>
>>                  pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
>> -               mutex_lock(&cma_mutex);
>> +
>> +               /*
>> +                * If the user sets the concurr_alloc of CMA to true, concurrent
>> +                * memory allocation is allowed. If the user sets it to false or
>> +                * does not set it, concurrent memory allocation is not allowed.
>> +                */
>> +               if (!cma->concurr_alloc)
>> +                       mutex_lock(&cma_mutex);
>>                  ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA, gfp);
>> -               mutex_unlock(&cma_mutex);
>> +               if (!cma->concurr_alloc)
>> +                       mutex_unlock(&cma_mutex);
>>                  if (ret == 0) {
>>                          page = pfn_to_page(pfn);
>>                          break;
>> @@ -610,3 +618,13 @@ int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
>>
>>          return 0;
>>   }
>> +
>> +bool cma_set_concurrency(struct cma *cma, bool concurrency)
>> +{
>> +       if (!cma)
>> +               return false;
>> +
>> +       cma->concurr_alloc = concurrency;
>> +
>> +       return true;
>> +}
>> diff --git a/mm/cma.h b/mm/cma.h
>> index 8485ef8..30f489d 100644
>> --- a/mm/cma.h
>> +++ b/mm/cma.h
>> @@ -16,6 +16,7 @@ struct cma {
>>          unsigned long   *bitmap;
>>          unsigned int order_per_bit; /* Order of pages represented by one bit */
>>          spinlock_t      lock;
>> +       bool concurr_alloc;
>>   #ifdef CONFIG_CMA_DEBUGFS
>>          struct hlist_head mem_head;
>>          spinlock_t mem_head_lock;
>> --
>> 2.7.4
>>
>>
> 
> Thanks
> Barry


