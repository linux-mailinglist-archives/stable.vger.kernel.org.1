Return-Path: <stable+bounces-241649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PCDOIep8GnOWwEAu9opvQ
	(envelope-from <stable+bounces-241649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:35:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F77484E74
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6FCF30071CB
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6153C423144;
	Tue, 28 Apr 2026 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oJqY9FNE"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4208C42B72F;
	Tue, 28 Apr 2026 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777379684; cv=none; b=V8G7GP03/xKxSPHSgE+PbYmz+3FwY6dYQCTYzXmsU18Ex3jYkLfK4YnhyhgiGTl4QQL/svPmCY+D0VXOe2vUsJwsR4p/Qj7Hk4HSNbMHqbfdo0EWaa8jblZBSZvjPr1k5GimmGNfjOl5YESxUBsnMivSWxtzhpoo5Xq6Uiq/udQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777379684; c=relaxed/simple;
	bh=d2Mq+UZRYClXrxCgQULHj/AsUiMRQgk3yEEpegzONLs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=d7b4u6+QJBwwr/Oky/XHWpYxXUVyZFAmXhA6Y84fy5bafqwmRzaiLppH+avhrLDQR1/+f6s1+DCI5P4oIaceG9tZay8/CbqUvLihQqJs0VZau2deDa343tWcGxFA6mMCfp5jqcri6+nO9YCvT5+kJTbazr0zYbSQwQXN61+g+4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oJqY9FNE; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zzMDEYzsulY+KHA1t1QmO1PLem7Ek0Kh2oljY0po6pI=;
	b=oJqY9FNEiXJzrwtJNuU8JXsbp+zDI90/SwPURrnq1/rKozrLjwLmQKIY7Wz6VW9wYu7M+Wyv1
	vHIBWPB1HzZkaR/9xd0tPokQaSrfDFVEwjIM1hReOC+Kk6CzY69vcorMt7+fpJbJXmnVFz+q2KN
	Y2qzhTEPruTUvNcKbzV1s9Y=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4g4fpF67ZfzcZyN;
	Tue, 28 Apr 2026 20:27:33 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id E716140561;
	Tue, 28 Apr 2026 20:34:27 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 20:34:27 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 20:34:26 +0800
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
	<gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20260428085219.1316047-1-songmuchun@bytedance.com>
 <20260428085219.1316047-4-songmuchun@bytedance.com>
 <fae6e568-fbdd-e697-8ea4-b12c73750ec9@huawei.com>
 <68DFF29C-B3CC-4950-8A8E-7D42350939CA@linux.dev>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3697dafa-7ff4-30d9-006b-860299421b63@huawei.com>
Date: Tue, 28 Apr 2026 20:34:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <68DFF29C-B3CC-4950-8A8E-7D42350939CA@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)
X-Rspamd-Queue-Id: 86F77484E74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241649-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c09:e001:a7::12fc:5321:from];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bytedance.com,intel.com,gmail.com,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,suse.de,linuxfoundation.org,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huawei.com:dkim,huawei.com:mid,bytedance.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmiaohe@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,172.19.162.223:received,113.46.200.217:received];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]

On 2026/4/28 19:40, Muchun Song wrote:
> 
> 
>> On Apr 28, 2026, at 19:37, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2026/4/28 16:52, Muchun Song wrote:
>>> memblk_nr_poison_inc() and memblk_nr_poison_sub() call
>>> find_memory_block_by_id(), which requires device_hotplug_lock to
>>> serialize the xarray lookup against memory block removal.
>>>
>>> Take device_hotplug_lock around the lookup and nr_hwpoison update so
>>> the memory block cannot disappear between xa_load() and get_device().
>>>
>>> Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>
>> Thanks for update.
>>
>>> ---
>>> drivers/base/memory.c | 10 ++++++++--
>>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>>> index 6981b55d582a..f76aee29e9a5 100644
>>> --- a/drivers/base/memory.c
>>> +++ b/drivers/base/memory.c
>>> @@ -1228,23 +1228,29 @@ int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
>>> void memblk_nr_poison_inc(unsigned long pfn)
>>> {
>>> 	const unsigned long block_id = pfn_to_block_id(pfn);
>>> - 	struct memory_block *mem = find_memory_block_by_id(block_id);
>>> + 	struct memory_block *mem;
>>>
>>> + 	lock_device_hotplug();
>>
>> memblk_nr_poison_inc() and memblk_nr_poison_sub() are both called from memory_failure() context.
>> I'm afraid if memory_failure() is triggered while lock_device_hotplug is held, it will lead to
>> deadlock. Or am I miss something?
> 
> I am curious is there any place where memory_failure() is called with holding lock_device_hotplug?

Sorry for dumb scenario, I was a bit too presumptuous. But there might be another possible deadlock:

remove_memory
  lock_device_hotplug <-- first called here
  try_remove_memory
    remove_memory_block_devices
      num_poisoned_pages_sub
        memblk_nr_poison_sub
          lock_device_hotplug <-- deadlock here

Hope I'm not mistaken again. :)

Thank.
.

