Return-Path: <stable+bounces-162892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D1AB06063
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852CE5A147A
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 14:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0C82ECEA4;
	Tue, 15 Jul 2025 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nJkZfMCB"
X-Original-To: stable@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AECC2DAFBD
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587751; cv=none; b=acPg44DQyY/TAPA6uc6rGUl2WjU9YEVY7DSJchXA+0Fn/upd/mV3C+ODBr2vXy/EBKqA4SW0MAVSs0bPwz4SNW4fsz/oNScwvKDJTOxRLJqtvz+eQX02PwLFumrf3OlWuWdEZuJkuwtviF+CuVFypm6IvrSVMEn4trK2qiadJCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587751; c=relaxed/simple;
	bh=0ZGa4VrK7JwleI3z6tggY8q+fkAuoZesS9q1fcOHrgY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZoK1PsymO8Ya4R2esSTF0f1vq5L8SgEAtHmsDHG5C/Xtu7lf+92pAFqvhysqloZdsS2dkyLY9R89h/AmjSkCztgAbopuFZ3cIUxbWxIGsGxJS91R5aRVYRh6w/1Dx47beqmuOxISNWKC6GgAwtGmLVlZeza6mWc0JIGDbm1nrdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nJkZfMCB; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752587744; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=kDfo4xpkFnWxeujQRlmt8WT3jp3fZxR8x4qasshkBb8=;
	b=nJkZfMCBuNkj6gTEkr2U8oKDpE8s6WGOdlB+i6iEdLSpqAXd5PSzI4vGbu5JZwG7sF/8bUZPZB3D+FSN+GvZYuJ6YRJ6dVsI6qHfDuEXWtcdpLRRqVCCqIadwwaZT0F3Q38B+eF3pqEbfYHDWbjxxw8tSkFAH8uYCaWARdk1BsQ=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj0hrf._1752587743 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Jul 2025 21:55:44 +0800
Message-ID: <743300c9-1694-4bf8-adad-dd4d943e3413@linux.alibaba.com>
Date: Tue, 15 Jul 2025 21:55:43 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 119/163] erofs: free pclusters if no cached folio is
 attached
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Chunhai Guo <guochunhai@vivo.com>,
 Sasha Levin <sashal@kernel.org>
References: <20250715130808.777350091@linuxfoundation.org>
 <20250715130813.625545173@linuxfoundation.org>
 <e77b99b1-5716-4e51-b636-cc8bef67c5d4@linux.alibaba.com>
In-Reply-To: <e77b99b1-5716-4e51-b636-cc8bef67c5d4@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/15 21:51, Gao Xiang wrote:
> Hi Greg,
> 
> On 2025/7/15 21:13, Greg Kroah-Hartman wrote:
>> 6.12-stable review patch.  If anyone has any objections, please let me know.
> 
> Can we drop this patch?
> 
> Since it's a new feature and lack of another fix backport:
> commit b10a1e5643e5 ("erofs: fix rare pcluster memory leak after unmounting")

Oh, that fix is included, very sorry about that.

I can live with that then.

Thanks,
Gao Xiang

> 
> It's not worth to backport those commits in order to backport
> a simple tracepoint fix.
> 
> Thanks,
> Gao Xiang
> 
>>
>> ------------------
>>
>> From: Chunhai Guo <guochunhai@vivo.com>
>>
>> [ Upstream commit f5ad9f9a603f829d11ca31a0a4049e16091e8c13 ]
>>
>> Once a pcluster is fully decompressed and there are no attached cached
>> folios, its corresponding `struct z_erofs_pcluster` will be freed. This
>> will significantly reduce the frequency of calls to erofs_shrink_scan()
>> and the memory allocated for `struct z_erofs_pcluster`.
>>
>> The tables below show approximately a 96% reduction in the calls to
>> erofs_shrink_scan() and in the memory allocated for `struct
>> z_erofs_pcluster` after applying this patch. The results were obtained
>> by performing a test to copy a 4.1GB partition on ARM64 Android devices
>> running the 6.6 kernel with an 8-core CPU and 12GB of memory.
>>
>> 1. The reduction in calls to erofs_shrink_scan():
>> +-----------------+-----------+----------+---------+
>> |                 | w/o patch | w/ patch |  diff   |
>> +-----------------+-----------+----------+---------+
>> | Average (times) |   11390   |   390    | -96.57% |
>> +-----------------+-----------+----------+---------+
>>
>> 2. The reduction in memory released by erofs_shrink_scan():
>> +-----------------+-----------+----------+---------+
>> |                 | w/o patch | w/ patch |  diff   |
>> +-----------------+-----------+----------+---------+
>> | Average (Byte)  | 133612656 | 4434552  | -96.68% |
>> +-----------------+-----------+----------+---------+
>>
>> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Link: https://lore.kernel.org/r/20241112043235.546164-1-guochunhai@vivo.com
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> Stable-dep-of: d53238b614e0 ("erofs: fix to add missing tracepoint in erofs_readahead()")
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>   fs/erofs/zdata.c | 57 ++++++++++++++++++++++++++++++++----------------
>>   1 file changed, 38 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
>> index 6b1d19d1d2f0c..4d5a1fbd7e0ad 100644
>> --- a/fs/erofs/zdata.c
>> +++ b/fs/erofs/zdata.c
>> @@ -882,14 +882,11 @@ static void z_erofs_rcu_callback(struct rcu_head *head)
>>               struct z_erofs_pcluster, rcu));
>>   }
>> -static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
>> +static bool __erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
>>                         struct z_erofs_pcluster *pcl)
>>   {
>> -    int free = false;
>> -
>> -    spin_lock(&pcl->lockref.lock);
>>       if (pcl->lockref.count)
>> -        goto out;
>> +        return false;
>>       /*
>>        * Note that all cached folios should be detached before deleted from
>> @@ -897,7 +894,7 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
>>        * orphan old pcluster when the new one is available in the tree.
>>        */
>>       if (erofs_try_to_free_all_cached_folios(sbi, pcl))
>> -        goto out;
>> +        return false;
>>       /*
>>        * It's impossible to fail after the pcluster is freezed, but in order
>> @@ -906,8 +903,16 @@ static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
>>       DBG_BUGON(__xa_erase(&sbi->managed_pslots, pcl->index) != pcl);
>>       lockref_mark_dead(&pcl->lockref);
>> -    free = true;
>> -out:
>> +    return true;
>> +}
>> +
>> +static bool erofs_try_to_release_pcluster(struct erofs_sb_info *sbi,
>> +                      struct z_erofs_pcluster *pcl)
>> +{
>> +    bool free;
>> +
>> +    spin_lock(&pcl->lockref.lock);
>> +    free = __erofs_try_to_release_pcluster(sbi, pcl);
>>       spin_unlock(&pcl->lockref.lock);
>>       if (free) {
>>           atomic_long_dec(&erofs_global_shrink_cnt);
>> @@ -938,16 +943,25 @@ unsigned long z_erofs_shrink_scan(struct erofs_sb_info *sbi,
>>       return freed;
>>   }
>> -static void z_erofs_put_pcluster(struct z_erofs_pcluster *pcl)
>> +static void z_erofs_put_pcluster(struct erofs_sb_info *sbi,
>> +        struct z_erofs_pcluster *pcl, bool try_free)
>>   {
>> +    bool free = false;
>> +
>>       if (lockref_put_or_lock(&pcl->lockref))
>>           return;
>>       DBG_BUGON(__lockref_is_dead(&pcl->lockref));
>> -    if (pcl->lockref.count == 1)
>> -        atomic_long_inc(&erofs_global_shrink_cnt);
>> -    --pcl->lockref.count;
>> +    if (!--pcl->lockref.count) {
>> +        if (try_free && xa_trylock(&sbi->managed_pslots)) {
>> +            free = __erofs_try_to_release_pcluster(sbi, pcl);
>> +            xa_unlock(&sbi->managed_pslots);
>> +        }
>> +        atomic_long_add(!free, &erofs_global_shrink_cnt);
>> +    }
>>       spin_unlock(&pcl->lockref.lock);
>> +    if (free)
>> +        call_rcu(&pcl->rcu, z_erofs_rcu_callback);
>>   }
>>   static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
>> @@ -968,7 +982,7 @@ static void z_erofs_pcluster_end(struct z_erofs_decompress_frontend *fe)
>>        * any longer if the pcluster isn't hosted by ourselves.
>>        */
>>       if (fe->mode < Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE)
>> -        z_erofs_put_pcluster(pcl);
>> +        z_erofs_put_pcluster(EROFS_I_SB(fe->inode), pcl, false);
>>       fe->pcl = NULL;
>>   }
>> @@ -1271,6 +1285,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>>       int i, j, jtop, err2;
>>       struct page *page;
>>       bool overlapped;
>> +    bool try_free = true;
>>       mutex_lock(&pcl->lock);
>>       be->nr_pages = PAGE_ALIGN(pcl->length + pcl->pageofs_out) >> PAGE_SHIFT;
>> @@ -1328,9 +1343,12 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>>           /* managed folios are still left in compressed_bvecs[] */
>>           for (i = 0; i < pclusterpages; ++i) {
>>               page = be->compressed_pages[i];
>> -            if (!page ||
>> -                erofs_folio_is_managed(sbi, page_folio(page)))
>> +            if (!page)
>>                   continue;
>> +            if (erofs_folio_is_managed(sbi, page_folio(page))) {
>> +                try_free = false;
>> +                continue;
>> +            }
>>               (void)z_erofs_put_shortlivedpage(be->pagepool, page);
>>               WRITE_ONCE(pcl->compressed_bvecs[i].page, NULL);
>>           }
>> @@ -1375,6 +1393,11 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
>>       /* pcluster lock MUST be taken before the following line */
>>       WRITE_ONCE(pcl->next, Z_EROFS_PCLUSTER_NIL);
>>       mutex_unlock(&pcl->lock);
>> +
>> +    if (z_erofs_is_inline_pcluster(pcl))
>> +        z_erofs_free_pcluster(pcl);
>> +    else
>> +        z_erofs_put_pcluster(sbi, pcl, try_free);
>>       return err;
>>   }
>> @@ -1397,10 +1420,6 @@ static int z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
>>           owned = READ_ONCE(be.pcl->next);
>>           err = z_erofs_decompress_pcluster(&be, err) ?: err;
>> -        if (z_erofs_is_inline_pcluster(be.pcl))
>> -            z_erofs_free_pcluster(be.pcl);
>> -        else
>> -            z_erofs_put_pcluster(be.pcl);
>>       }
>>       return err;
>>   }
> 


