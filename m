Return-Path: <stable+bounces-177584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42431B4189E
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 10:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FAFC1B23D3B
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 08:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D7A2EBDD0;
	Wed,  3 Sep 2025 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HM3AEqPL"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F13A2DCF5B
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 08:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888317; cv=none; b=VFCTtCIohvgML+NdGS+DycYLqPw6x1mtihAj1CtmwhXAcyH5Vzk+LLRgHW14FcAQqXUOpDFoFb0gfBsWn3oR/wri1+M/1Hb5Zv1VQWjJ5A3FV9cieTqtlcajf6UTxLQzop5QJiz+bIzwneXrT3RzJUHPy1a2VEf1lkfNWk3toVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888317; c=relaxed/simple;
	bh=rhXvD3KWayrlEl0fdGvhwxdc9nwnQ6jf9Ssj0Chvgf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=QQsEwvSxuaMp/yiLk1MVYgbU29WC5TbiNIymF8WpGxd4U9wOAx+ECLdc5kS5wTsIkTsf5uUomzmHgY+okexm/mRswCSJCP3eBHxkeoO/L6L4Fy4ZOLDi7DEQo9HxSyTnooNbDE7fPnh4qgndz1EP2TqNswVXo/pHkUl4koVlmSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HM3AEqPL; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250903083151epoutp0211149bf88e9d1059713be7a73fc5d3b4~huJxMpsFL3153131531epoutp02s
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 08:31:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250903083151epoutp0211149bf88e9d1059713be7a73fc5d3b4~huJxMpsFL3153131531epoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756888311;
	bh=7anlYS6ZCv1KNUBiSIKIMN7LBfAkpJAy4Hhld9VjUrA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=HM3AEqPLVn0TkzLwQ+1fX0HZccPsacEiCILmXeS17J84ObLYBrqIYWkqxALbAfQQK
	 vzpUacEdWnZTzggnR3ltFPq0IbmEMM3XUt22T2hqvcK+MtyzIieSKj4GlDzXX1APxd
	 GRMKn26TzbF8WmytV3Fl+IbTjElXGhdsa+SrV4Zc=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250903083150epcas5p10ed8f77f8338443af4f813fcf6099327~huJwsygHa2127521275epcas5p1B;
	Wed,  3 Sep 2025 08:31:50 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.91]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cGwnd5m6dz3hhT4; Wed,  3 Sep
	2025 08:31:49 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250903083149epcas5p1884b6d9c28fe1bf0ea03aead58b1a8dc~huJvZfwrI0969309693epcas5p1H;
	Wed,  3 Sep 2025 08:31:49 +0000 (GMT)
Received: from [107.122.3.212] (unknown [107.122.3.212]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250903083147epsmtip206222dad44fe83a8b56dcc9c48dee038~huJt3Kbmo2816928169epsmtip2I;
	Wed,  3 Sep 2025 08:31:47 +0000 (GMT)
Message-ID: <49611228-50a8-416b-ac3d-d8b2869c2fe1@samsung.com>
Date: Wed, 3 Sep 2025 14:01:46 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: quota: create dedicated workqueue for
 quota_release_work
To: Jan Kara <jack@suse.cz>
Cc: jack@suse.com, linux-kernel@vger.kernel.org, shadakshar.i@samsung.com,
	thiagu.r@samsung.com, hy50.seo@samsung.com, kwangwon.min@samsung.com,
	alim.akhtar@samsung.com, h10.kim@samsung.com, kwmad.kim@samsung.com,
	selvarasu.g@samsung.com, stable@vger.kernel.org
Content-Language: en-US
From: Shashank A P <shashank.ap@samsung.com>
In-Reply-To: <ufb72d6p54cxyzcy5glrfzaz7xm3inzp44k6rdff5on3daua4s@u2rf7xt4hdie>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250903083149epcas5p1884b6d9c28fe1bf0ea03aead58b1a8dc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250901092950epcas5p35accdcb60fe3ba58772289058a12f8a1
References: <CGME20250901092950epcas5p35accdcb60fe3ba58772289058a12f8a1@epcas5p3.samsung.com>
	<20250901092905.2115-1-shashank.ap@samsung.com>
	<ufb72d6p54cxyzcy5glrfzaz7xm3inzp44k6rdff5on3daua4s@u2rf7xt4hdie>


On 9/2/2025 7:17 PM, Jan Kara wrote:
> On Mon 01-09-25 14:59:00, Shashank A P wrote:
>> There is a kernel panic due to WARN_ONCE when panic_on_warn is set.
>>
>> This issue occurs when writeback is triggered due to sync call for an
>> opened file(ie, writeback reason is WB_REASON_SYNC). When f2fs balance
>> is needed at sync path, flush for quota_release_work is triggered.
>> By default quota_release_work is queued to "events_unbound" queue which
>> does not have WQ_MEM_RECLAIM flag. During f2fs balance "writeback"
>> workqueue tries to flush quota_release_work causing kernel panic due to
>> MEM_RECLAIM flag mismatch errors.
>>
>> This patch creates dedicated workqueue with WQ_MEM_RECLAIM flag
>> for work quota_release_work.
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 4 PID: 14867 at kernel/workqueue.c:3721 check_flush_dependency+0x13c/0x148
>> Call trace:
>>   check_flush_dependency+0x13c/0x148
>>   __flush_work+0xd0/0x398
>>   flush_delayed_work+0x44/0x5c
>>   dquot_writeback_dquots+0x54/0x318
>>   f2fs_do_quota_sync+0xb8/0x1a8
>>   f2fs_write_checkpoint+0x3cc/0x99c
>>   f2fs_gc+0x190/0x750
>>   f2fs_balance_fs+0x110/0x168
>>   f2fs_write_single_data_page+0x474/0x7dc
>>   f2fs_write_data_pages+0x7d0/0xd0c
>>   do_writepages+0xe0/0x2f4
>>   __writeback_single_inode+0x44/0x4ac
>>   writeback_sb_inodes+0x30c/0x538
>>   wb_writeback+0xf4/0x440
>>   wb_workfn+0x128/0x5d4
>>   process_scheduled_works+0x1c4/0x45c
>>   worker_thread+0x32c/0x3e8
>>   kthread+0x11c/0x1b0
>>   ret_from_fork+0x10/0x20
>> Kernel panic - not syncing: kernel: panic_on_warn set ...
>>
>> Fixes: ac6f420291b3 ("quota: flush quota_release_work upon quota writeback")
>> CC: stable@vger.kernel.org
>> Signed-off-by: Shashank A P <shashank.ap@samsung.com>
> Thanks. It seems a bit unfortunate that we have to create a separate
> workqueue just for this but I don't see a different easy solution. So I've
> added your patch to my tree.
>
> 								Honza

Hi Jan Kara,
Thanks for your comments.

We've got a below kernel warning from kernel test 
robot(lkp@intel.com)that related to the changes, and we need your 
suggestions to resolve this warning as its merged already in your tree.

Should we post a new patch version to fix this warning, or can you 
please incorporate the fix while applying it to linux-next?


sparse warnings: (new ones prefixed by >>)
 >> fs/quota/dquot.c:166:25: sparse: sparse: symbol 'quota_unbound_wq' 
was not declared. Should it be static?

https://lore.kernel.org/all/202509031153.0ACADDn6-lkp@intel.com/

Thanks,
Shashank

>
>> ---
>>   fs/quota/dquot.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
>> index df4a9b348769..d0f83a0c42df 100644
>> --- a/fs/quota/dquot.c
>> +++ b/fs/quota/dquot.c
>> @@ -162,6 +162,9 @@ static struct quota_module_name module_names[] = INIT_QUOTA_MODULE_NAMES;
>>   /* SLAB cache for dquot structures */
>>   static struct kmem_cache *dquot_cachep;
>>   
>> +/* workqueue for work quota_release_work*/
>> +struct workqueue_struct *quota_unbound_wq;
>> +
>>   void register_quota_format(struct quota_format_type *fmt)
>>   {
>>   	spin_lock(&dq_list_lock);
>> @@ -881,7 +884,7 @@ void dqput(struct dquot *dquot)
>>   	put_releasing_dquots(dquot);
>>   	atomic_dec(&dquot->dq_count);
>>   	spin_unlock(&dq_list_lock);
>> -	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
>> +	queue_delayed_work(quota_unbound_wq, &quota_release_work, 1);
>>   }
>>   EXPORT_SYMBOL(dqput);
>>   
>> @@ -3041,6 +3044,11 @@ static int __init dquot_init(void)
>>   
>>   	shrinker_register(dqcache_shrinker);
>>   
>> +	quota_unbound_wq = alloc_workqueue("quota_events_unbound",
>> +					   WQ_UNBOUND | WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
>> +	if (!quota_unbound_wq)
>> +		panic("Cannot create quota_unbound_wq\n");
>> +
>>   	return 0;
>>   }
>>   fs_initcall(dquot_init);
>> -- 
>> 2.34.1
>>

