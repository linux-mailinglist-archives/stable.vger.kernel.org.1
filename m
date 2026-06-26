Return-Path: <stable+bounces-268709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z2ToNOjjPWq77ggAu9opvQ
	(envelope-from <stable+bounces-268709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 04:28:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C71F6C9C27
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 04:28:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=dvmQTEAx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268709-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268709-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51624303FB86
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 02:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05306303A0D;
	Fri, 26 Jun 2026 02:27:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD722FD1B5
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 02:27:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782440874; cv=none; b=MVIO2QieUazzI2SWiL7C0d2jbxHzcWIYCtxva6aZZPKT7HikH++FpZoI6FX6/PTzQ2+ZCeQ+h0Z4uwbRIte7625un3W0/eTwOixJLT/BaPsHTIvSnr2jvG+VcnBjUyfX58ZoLPDc7WJ5/QUXq5VKqokCB+DJCtyV7Zac9FBfAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782440874; c=relaxed/simple;
	bh=BPtwj9Nq/fn+q0eghUUBQ4zTBLtIhafU+HsvhuDE1js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3y43ZjHTfQNgrdPmDdMlI6yw8JKVYAMzu9sEnZKc0Hd3QhLZp3vrG4jqRes1L4uwEGmZowpg29YM7u9r56Jt9lGPVBlevtRpCt9znpDT0xfg3vpywV5RK4f/unhtvWivY7Kvk4jIHyNz8CAZlvtbqIFU3Z7gQnVGE05BjmIEyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dvmQTEAx; arc=none smtp.client-ip=95.215.58.178
Message-ID: <4c7b0c46-14f0-4a62-893e-e50714e09b74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782440870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h48iMyZJeOBo8mJP1NqWzlLxC6G6uq5RUz9cl4e400U=;
	b=dvmQTEAxG5XVvmLYAb9HPsG9G5ggSSpuxSDd7nJhF49Q3rVYDso9H+zUiwWAzS6atUFeTa
	qZuLIm3ICeB8mEy2FSb0+fsLykYl2eJo+gz4kNIXZ+dkof0bMk05AS39jZVd0ZHrPMV5tr
	T2tb07g13wox1UbYqeJLskElVUNfOFs=
Date: Fri, 26 Jun 2026 10:27:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, harry@kernel.org,
 muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn, mhocko@kernel.org,
 roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
 stable@vger.kernel.org
References: <20260625151554.55105-1-qi.zheng@linux.dev>
 <aj12aVq3he6q7b2C@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aj12aVq3he6q7b2C@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:harry@kernel.org,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-268709-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C71F6C9C27

Hi Johannes,

On 6/26/26 2:41 AM, Johannes Weiner wrote:
> On Thu, Jun 25, 2026 at 11:15:54PM +0800, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> The mglru page table walker batches per-generation size deltas in
>> walk->nr_pages while walking page tables without holding the lruvec lock.
>> The reset_batch_size() later folds those deltas into walk->lruvec under
>> the lruvec lock.
>>
>> The page table walker can run concurrently with the memcg reparenting path
>> as follows:
>>
>> CPU0                           CPU1
>> ====                           ====
>>
>> walk_mm
>> --> walk_page_range
>>      --> update_batch_size
>>          --> walk->nr_pages += delta
>>
>>                                mem_cgroup_css_offline
>>                                --> memcg_reparent_objcgs
>>                                    --> lock lruvec
>>                                        lru_gen_reparent_memcg
>>                                        --> reparent child folios to parent
>>                                        unlock lruvec
>>
>>      lock lruvec
>>      reset_batch_size
>>      --> child lrugen->nr_pages += delta
>>
>> This will trigger the following warning in lru_gen_exit_memcg():
>>
>> 	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
>> 				   sizeof(lruvec->lrugen.nr_pages)));
>>
>> And the user-visible impact of underestimated nr_pages in MGLRU was
>> premature OOMs because MGLRU does not try to reclaim memory when nr_pages
>> reaches zero, but there are still more pages.
>>
>> To fix it, make reset_batch_size() check CSS_DYING under RCU before
>> flushing the pending batch. A non-dying memcg keeps the original lruvec
>> stable against RCU-delayed offlining; a dying memcg redirects the deltas
>> to the first non-dying ancestor.
>>
>> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
>> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
>> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>> Changes in v3:
>>   - re-implement lock_batch_lruvec() by checking CSS_DYING under the RCU lock
>>     (suggested by Harry)
>>   - update the commit message (suggested by Harry)
>>   - temporarily drop the previous Reviewed-by tags
>>     (since the sync method has changed)
>>   - rebase onto the next-20260624
>>
>> Changes in v2:
>>   - update the commit message (pointed by Barry)
>>   - collect Reviewed-by
>>
>>   mm/vmscan.c | 45 ++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 38 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 35c3bb15ae96..1ec8c23c72b9 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -3262,10 +3262,44 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
>>   	walk->nr_pages[new_gen][type][zone] += delta;
>>   }
>>   
>> +#ifdef CONFIG_MEMCG
>> +static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>> +{
>> +	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>> +
>> +	rcu_read_lock();
> 
> Where is this unlocked?

The lruvec_unlock_irq() in reset_batch_size() will handle the unlocking.

> 
>> +	/*
>> +	 * The memcg can be NULL when the memory controller is disabled.
>> +	 * Otherwise, the caller keeps the memcg owning @lruvec alive.
>> +	 */
>> +	if (!memcg || !css_is_dying(&memcg->css))
>> +		goto lock;
>> +
>> +	do {
>> +		memcg = parent_mem_cgroup(memcg);
>> +	} while (memcg && css_is_dying(&memcg->css));
>> +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> 
> 	while (unlikely(memcg && css_is_dying(&memcg->css))) {
> 		memcg = parent_mem_cgroup(memcg);
> 		lruvec = mem_cgroup_lruvec(memcg, pgdat);

There is no need to acquire the lruvec before finding the first
non-dying memcg.

Thanks,
Qi

> 	}


