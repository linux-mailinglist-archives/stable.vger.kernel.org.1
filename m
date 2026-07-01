Return-Path: <stable+bounces-270201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T0J4H1I1RWq38goAu9opvQ
	(envelope-from <stable+bounces-270201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 17:42:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D49536EF563
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 17:42:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=haHWV0Ul;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270201-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270201-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD21E30BF9F1
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 15:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F76735E1C0;
	Wed,  1 Jul 2026 15:36:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B840245008;
	Wed,  1 Jul 2026 15:36:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920210; cv=none; b=tU6FQfwGqARCdqZpA8zxy38wDplm9pyb3YQf069tch5GuDP+M+jWQH8fCeJiIjw/SeDas+UNDbrpyDGlVmxHxEC/Vq/2IsXCFiEtDUG0rYkK2s9QhB6+K4cNvTogN50HI0bJxtqhNfAWxvPctiyvFQg2BrhYeXelg4nG6owh7m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920210; c=relaxed/simple;
	bh=Jj8RwJGsh68t6Q7Bpd3C3QxzgSE/g/sizzaOjDmksEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZayKZGTwOCGCu+8B8Ka0RmlcHmsj+ixsb23mR9asXdpMBkmAL6NPPE4NZnAAyqTarjnt4D/YAWJJjN9gwssNqsWchbiPCmzbuDJc0wp3sunhLzG+OpO7TpjInjSWH0npYCOw14JYXmgCc7vrSLr6OBuc1k8th7un5M5Jc5DaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haHWV0Ul; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CE01F000E9;
	Wed,  1 Jul 2026 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782920208;
	bh=2ufqJUnCyvc+hknRtS5Siyc2qfmJS++aIpAUseDEK30=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=haHWV0UlWNsepxaEgoprUycVKUGfqF+k2KN2GFRSdpl7iWO34OFCmMQ+ZfZ5FjqM1
	 7zK7OYNRO/7CL+M7SYNokSmxdSFLdQ1DF+effczbWaWx+0QrOQkssBOIVBp/4m6FrN
	 KUzjkt/gcrjQ8c7XSTlhKl/03Md167sdSVLDbvaGBW2HePO3IlXxTYd2WHwZBN3hcI
	 iemgqXDYHxNDCmGDTzbS1B4uOOK6HHFk4h8CP1HD+2UXkOwAbUwC7SWHpPxjkFoUmm
	 fiH9ucvCNzXD7N8P/xkaTE63ncimR5RCAPlH46Eo+YPIvB7a362fwZrBulhfvMyWby
	 44VKltThKbhUA==
Message-ID: <2fb5ce53-666b-4b0a-a4ad-2b3a28c54768@kernel.org>
Date: Thu, 2 Jul 2026 00:36:42 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Usama Arif <usama.arif@linux.dev>, Qi Zheng <qi.zheng@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org,
 muchun.song@linux.dev, peiyang_he@smail.nju.edu.cn, mhocko@kernel.org,
 roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
 stable@vger.kernel.org
References: <20260701145736.3785016-1-usama.arif@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <20260701145736.3785016-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:usama.arif@linux.dev,m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:hannes@cmpxchg.org,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[harry@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-270201-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bytedance.com:email,vger.kernel.org:from_smtp,nju.edu.cn:email,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D49536EF563



On 7/1/26 11:57 PM, Usama Arif wrote:
> On Wed,  1 Jul 2026 15:52:51 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> 
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
>>     --> update_batch_size
>>         --> walk->nr_pages += delta
>>
>>                               mem_cgroup_css_offline
>>                               --> memcg_reparent_objcgs
>>                                   --> lock lruvec
>>                                       lru_gen_reparent_memcg
>>                                       --> reparent child folios to parent
>>                                       unlock lruvec
>>
>>     lock lruvec
>>     reset_batch_size
>>     --> child lrugen->nr_pages += delta
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
>> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
>> ---
>> Changes in v4:
>>  - re-implement lock_batch_lruvec() in a simpler way
>>    (suggested by Johannes and Harry)
>>  - collect Reviewed-by
>>  - rebase onto the next-20260630
>>
>> Changes in v3:
>>  - re-implement lock_batch_lruvec() by checking CSS_DYING under the RCU lock
>>    (suggested by Harry)
>>  - update the commit message (suggested by Harry)
>>  - temporarily drop the previous Reviewed-by tags
>>    (since the sync method has changed)
>>  - rebase onto the next-20260624
>>
>> Changes in v2:
>>  - update the commit message (pointed by Barry)
>>  - collect Reviewed-by
>>
>>  mm/vmscan.c | 41 ++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 34 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 35c3bb15ae96..ca1e2a870d51 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -3262,10 +3262,40 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
>>  	walk->nr_pages[new_gen][type][zone] += delta;
>>  }
>>  
>> +#ifdef CONFIG_MEMCG
>> +static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>> +{
>> +	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>> +
>> +	rcu_read_lock();
>> +
>> +	/*
>> +	 * The memcg can be NULL when the memory controller is disabled.
>> +	 * Otherwise, the caller keeps the memcg owning @lruvec alive.
>> +	 */
>> +	while (unlikely(memcg && css_is_dying(&memcg->css))) {
>> +		memcg = parent_mem_cgroup(memcg);
>> +		lruvec = mem_cgroup_lruvec(memcg, pgdat);
>> +	}
>> +
>> +	spin_lock_irq(&lruvec->lru_lock);
> 
> Do we need an rcu_read_unlock() here?

lruvec_unlock_irq() does that.

-- 
Cheers,
Harry / Hyeonggon


