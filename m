Return-Path: <stable+bounces-267906-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W+1dAvlOOmoH5wcAu9opvQ
	(envelope-from <stable+bounces-267906-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:16:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFBA6B5B15
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:16:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=LObtBUp1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267906-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267906-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F28D30700C9
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 09:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89B430B508;
	Tue, 23 Jun 2026 09:15:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B626F356772
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 09:15:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206130; cv=none; b=ZbMFfY8UtxIqaO5hI0+oK6VJYhOFDLTM8vPgYa8Iimr3NM6N6296kvOJ/gQIdAh98RhGrHVirwxHTCnGrgWbBmHkm1ybnrdQUBThhDEscE1uc6u1ZLiii+9gOYWnVZGOyjWViccY1uCynKY3hx+6mpuhQ1NnvgxTvAcLcHkY0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206130; c=relaxed/simple;
	bh=Uq4tl0f4UDZHBwV8ZukWALN7IdFSZ1aFxZ6bvjKfVe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBW2UJjj59h91ta7rb1KioEXmuCF+eEu/YiiWDvmTLBUQ6beGNXTyxVWMcTaLLTOlgfsSaB5U0v8EjnZqTM6mc5r6CtWMhxfY9sPgx7I3mD2v6KQkrpSaX+JmKioxPySQr8z5XzScJgBcO431yTyaVZMNWkhqZHriXhvk3XOSQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LObtBUp1; arc=none smtp.client-ip=95.215.58.172
Message-ID: <7946da94-dc1d-4cf2-986e-466c378665b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782206124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tpZginHVqkNU49eIJBOmNB7unJDksJ/MhSRIVKp8tno=;
	b=LObtBUp15MZd/tRyF7vr3WJJOlnw8HBAHu6hLIba57mzs7Zah7zHFXPQeIrqlzSiWm2SPx
	cRxNmiT21o/E/q/mMWXss0B5GOBio155kO+Qie4Ve7AXwTvhf7RPepF5ZGbFjhtkDD/LSQ
	W+oRfd2s5LCelV8dP+jrElKGpU8Tx4U=
Date: Tue, 23 Jun 2026 17:14:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Harry Yoo <harry@kernel.org>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20260623024237.45990-1-qi.zheng@linux.dev>
 <e74b0808-3bcc-414d-a037-41e479210cc0@kernel.org>
 <d97128c0-7d89-4b5c-b891-84f9af702fee@linux.dev>
 <8a76aefd-629c-41f3-b365-aefd4cc1411e@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <8a76aefd-629c-41f3-b365-aefd4cc1411e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:hannes@cmpxchg.org,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-267906-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,bytedance.com:email,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BFBA6B5B15

Hi Harry,

On 6/23/26 4:18 PM, Harry Yoo wrote:
> 
> 
> On 6/23/26 4:16 PM, Qi Zheng wrote:
>> Hi Harry,
> 
> Hi Qi!
> 
>> On 6/23/26 2:17 PM, Harry Yoo wrote:
>>> On 6/23/26 11:42 AM, Qi Zheng wrote:
>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>
>>>> The mglru page table walker batches per-generation size deltas in
>>>> walk->nr_pages while walking page tables without holding the lruvec
>>>> lock.
>>>> The reset_batch_size() later folds those deltas into walk->lruvec under
>>>> the lruvec lock.
>>>
>>> Ouch.
>>>
>>> IIRC the user-visible impact of underestimated nr_pages in MGLRU
>>> was premature OOMs because MGLRU does not try to reclaim memory when
>>> nr_pages reaches zero, but there are still more pages.
>>>
>>> Perhaps worth mentioning in the changelog?
>>
>> Maybe this should be placed before "To fix it...".
> 
> Thanks!
> 
>>>> The page table walker can run concurrently with the memcg reparenting
>>>> path
>>>> as follows:
>>>>
>>>> CPU0                           CPU1
>>>> ====                           ====
>>>>
>>>> walk_mm
>>>> --> walk_page_range
>>>>       --> update_batch_size
>>>>           --> walk->nr_pages += delta
>>>>
>>>>                                 mem_cgroup_css_offline
>>>>                                 --> memcg_reparent_objcgs
>>>>                                     --> lock lruvec
>>>>                                         lru_gen_reparent_memcg
>>>>                                         --> reparent child folios to
>>>> parent
>>>>                                         unlock lruvec
>>>>
>>>>       lock lruvec
>>>>       reset_batch_size
>>>>       --> child lrugen->nr_pages += delta
>>>
>>> The problem here is that, while grabbing a reference to memcg
>>> (via mem_cgroup_iter(), for example) makes sure that the memcg is not
>>> freed, it does not prevent offlining happening, and reset_batch_size()
>>> doesn't check whether the lruvec has been reparented, or the lruvec
>>> is going to be reparented.
>>>
>>>> This will trigger the following warning in lru_gen_exit_memcg():
>>>>
>>>>      VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
>>>>                     sizeof(lruvec->lrugen.nr_pages)));
>>>>
>>>> To fix it, add lrugen->reparented to remember the new owner of a
>>>> reparented lruvec, and make reset_batch_size() charge pending deltas to
>>>> that owner.
>>>
>>> Could you please explain why it is unavoidable to introduce the new
>>> field and why checking whether the cgroup is dying (and charging deltas
>>> to non-dying parent) doesn't work?
>>
>> Peiyang tried doing this [1], but it doesn't work because
>> ss->css_offline() is called before clearing the CSS_ONLINE flag.
> 
> Right.
> 
>> I also considered using mem_cgroup_tryget_online(), but that only prevent
>> the memcg from being freed. It's doesn't prevent the offlining.
> 
> Right.
> 
> I think checking CSS_DYING under RCU and grabbing the lruvec
> of the first non-dying memcg should work (this pattern is already
> used where we use RCU to guarantee memcgs are not freed).
> 
> If we do not observe CSS_DYING flag, it is safe to charge deltas
> to the lruvec because RCU guarantees that reparenting cannot happen
> under us.
> 
> If we do observe CSS_DYING, we can walk up the hierarchy and charge
> deltas to the first non-dying memcg.

Checking CSS_DYING looks feasible, but the rcu lock alone cannot prevent
reparenting. We should recheck CSS_DYING after acquiring the lruvec
lock, otherwise we might run into the following race:

   CPU0 reset_batch_size              CPU1 memcg teardown
   =====================              ==================

   read !CSS_DYING

                                      set CSS_DYING
                                      memcg_reparent_objcgs()
                                      lock child lruvec
                                      move child to parent
                                      zero child nr_pages
                                      unlock child lruvec

   lock child lruvec
   charge stale delta to child

So it seems lock_batch_lruvec() should be implemented like this:

static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
{
	struct mem_cgroup *memcg = lruvec_memcg(lruvec);

	rcu_read_lock();
retry:
	while (memcg && css_is_dying(&memcg->css))
		memcg = parent_mem_cgroup(memcg);

	lruvec = mem_cgroup_lruvec(memcg, pgdat);
	spin_lock_irq(&lruvec->lru_lock);
	if (memcg && unlikely(css_is_dying(&memcg->css))) {
		spin_unlock_irq(&lruvec->lru_lock);
		goto retry;
	}

	rcu_read_unlock();

	return lruvec;
}

This way, there is no need to add lrugen->reparented, right?

Thanks,
Qi


