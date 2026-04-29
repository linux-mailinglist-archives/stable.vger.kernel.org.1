Return-Path: <stable+bounces-241806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FRQGVR28WkxhAEAu9opvQ
	(envelope-from <stable+bounces-241806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 05:09:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2769748E901
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 05:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 800AE301A768
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 03:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6335537EFF4;
	Wed, 29 Apr 2026 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wRZEtqG1"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674963822B9;
	Wed, 29 Apr 2026 03:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777432138; cv=none; b=XEzjiepV13dEfdha6yrD0btKRfr3Ac9JuOxnOB7Q9IIDRY4ZdpmB3NaLWSBft62nXhweAc2Fw7nglGKcwIK0A0cj4jaoauFoTHMmbfM549B6pwP35awnIU2skVlcvrykhAH78mBV+SYwEy7c2rkFx6IJ00i9e1oR4maudFla9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777432138; c=relaxed/simple;
	bh=7+yC5hMF0qdU1S40QGVDkFTwKdacY27SAFDKbirVewQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Nl0/RIKDWsC6wOggpLf1xwyN8Fkqxdl3s3GSbIFG8hMRZTL+uQk/oB8Y27a1MBomMhQEXqhU+cTerHnr8EJ6rLvDwA2HSxuHWCRyRacJHlPDdFd84nH4JcP7TcFpIYOB7wPv4bjTljbclQ/pqCbaVxjKJR/c6h89lfYBc0El4dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wRZEtqG1; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xX0viIPInKzZ41oL478Oobdtorp+A0qdchKgB4MiC+Q=;
	b=wRZEtqG1ojzHisLsXlxwRdn5+Jd5rHXE0MjAblypteB/4bP6N7dY8K21sfS5P7ly81FOyw/br
	+XvZYTvTsjMIkOWPKa2WMJGGARA4Rrs1RTZvJr0EnSiuUngmfpopv1U5etxTXFX5Ufm5QwPFXdA
	iwWjvTtUImaOvMTxi+2vwng=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4g52C92vVHzcZxk;
	Wed, 29 Apr 2026 11:01:57 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 95FDD4048F;
	Wed, 29 Apr 2026 11:08:52 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Apr 2026 11:08:52 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Apr 2026 11:08:51 +0800
Subject: Re: [PATCH v2 3/3] drivers/base/memory: fix locking for poison
 accounting lookup
To: Muchun Song <muchun.song@linux.dev>
CC: Muchun Song <songmuchun@bytedance.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ying Huang <huang.ying.caritas@gmail.com>, "Dan
 Williams" <djbw@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
	<linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
	<driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, David Hildenbrand <david@kernel.org>, "Oscar
 Salvador" <osalvador@suse.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Rafael J Wysocki <rafael@kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <94F5B89A-008A-4EDB-920F-31B4895C2699@linux.dev>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c6e1df1e-be5e-2468-d46e-453985ba1e79@huawei.com>
Date: Wed, 29 Apr 2026 11:08:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <94F5B89A-008A-4EDB-920F-31B4895C2699@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)
X-Rspamd-Queue-Id: 2769748E901
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[bytedance.com,intel.com,gmail.com,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,suse.de,linuxfoundation.org,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-241806-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmiaohe@huawei.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

On 2026/4/28 21:52, Muchun Song wrote:
> 
> 
> 
>> On Apr 28, 2026, at 20:34, Miaohe Lin <linmiaohe@huawei.com> wrote:
>> ﻿On 2026/4/28 19:40, Muchun Song wrote:
>>>
>>>
>>>> On Apr 28, 2026, at 19:37, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>> On 2026/4/28 16:52, Muchun Song wrote:
>>>>> memblk_nr_poison_inc() and memblk_nr_poison_sub() call
>>>>> find_memory_block_by_id(), which requires device_hotplug_lock to
>>>>> serialize the xarray lookup against memory block removal.
>>>>> Take device_hotplug_lock around the lookup and nr_hwpoison update so
>>>>> the memory block cannot disappear between xa_load() and get_device().
>>>>> Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>> Thanks for update.
>>>>> ---
>>>>> drivers/base/memory.c | 10 ++++++++--
>>>>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>>>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>>>>> index 6981b55d582a..f76aee29e9a5 100644
>>>>> --- a/drivers/base/memory.c
>>>>> +++ b/drivers/base/memory.c
>>>>> @@ -1228,23 +1228,29 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>>>>> void memblk_nr_poison_inc(unsigned long pfn)
>>>>> {
>>>>>    const unsigned long block_id = pfn_to_block_id(pfn);
>>>>> -    struct memory_block *mem = find_memory_block_by_id(block_id);
>>>>> +    struct memory_block *mem;
>>>>> +    lock_device_hotplug();
>>>> memblk_nr_poison_inc() and memblk_nr_poison_sub() are both called from memory_failure() context.
>>>> I'm afraid if memory_failure() is triggered while lock_device_hotplug is held, it will lead to
>>>> deadlock. Or am I miss something?
>>>
>>> I am curious is there any place where memory_failure() is called with holding lock_device_hotplug?
>>
>> Sorry for dumb scenario, I was a bit too presumptuous. But there might be another possible deadlock:
>>
>> remove_memory
>>  lock_device_hotplug <-- first called here
>>  try_remove_memory
>>    remove_memory_block_devices
>>      num_poisoned_pages_sub
> 
> Passing pfn = -1 here.
> 
>>        memblk_nr_poison_sub
>>          lock_device_hotplug <-- deadlock here
> 
> No. Can’t reach here. No deadlock.

Right, I missed that. Thanks. But I'm still worried that there might be potential issues.
For example, this function could be called while lock_page is held. Acquiring lock_device_hotplug
while already holding lock_page might cause problems, though I haven't seen any specific issues yet.
Also there might be some other potential scenarios that haven't been considered. Hope I'm just
overthinking it. :)

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

