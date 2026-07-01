Return-Path: <stable+bounces-270191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yIm/EW4sRWrh8AoAu9opvQ
	(envelope-from <stable+bounces-270191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 17:04:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9334B6EF186
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 17:04:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="u/xNL6ff";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270191-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270191-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C77C630B22FE
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE27235F5F3;
	Wed,  1 Jul 2026 14:57:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6837223E320
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 14:57:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917876; cv=none; b=I+CCKjwqiG2BA2ejjr0Y9uBxCDlr5C7TjWhiWI0R1qzoruBGlRGpPqhyBahtGNVOvn3HuB4Wgyhm/9Nf4wwsYCWNLqXY9UsghU76Ksig4mt7+s/q4FCbfAK9KgVcoMd2GzIeEn19wOyEw17JrUSHtlkeesBApe3nXiDnO8Bvd00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917876; c=relaxed/simple;
	bh=vGLL9VM7Nd6jgMhorxhyV71SGtCxHnTJ0VvqtfPeljM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWO5qUTPBvgumlfZKLh2GUoDu6byHzFYhpHGstqTdjTAFhyR7L1ZVfOYuIAF8cCszHhRngplJy17AholzDKB2ExRSerdZuGcCuMuZUZIMZ+2S0zX9Tp/+ec+adw2RTgDWDmIidNIYXJFlY2uxZjRaNDPDin/qRScVAwOsArV+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u/xNL6ff; arc=none smtp.client-ip=91.218.175.189
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782917861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZxZYzr7s/jUyGjUJHT8GX3O2MqALroysxUHX5OVR6I=;
	b=u/xNL6ffTYYFG6/pQpvgb7+IDpimCtA2nrVpoyuJXSR+7kaiiIrfULdup+UpIRI/qtrg7V
	GgzR0/hCpJhwoWWcGngrI4zLqG283UAA2LBp8soStkA1DrGZXKPunOUidLsR+PQee3cP6B
	RhE8vD7Y1go18ShEHgOu6+YT2Wtt24c=
From: Usama Arif <usama.arif@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Usama Arif <usama.arif@linux.dev>,
	akpm@linux-foundation.org,
	david@kernel.org,
	kasong@tencent.com,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	hannes@cmpxchg.org,
	harry@kernel.org,
	muchun.song@linux.dev,
	peiyang_he@smail.nju.edu.cn,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	ljs@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] mm: mglru: fix stale batch updates after memcg reparenting
Date: Wed,  1 Jul 2026 07:57:35 -0700
Message-ID: <20260701145736.3785016-1-usama.arif@linux.dev>
In-Reply-To: <20260701075251.56413-1-qi.zheng@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270191-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:qi.zheng@linux.dev,m:usama.arif@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:hannes@cmpxchg.org,m:harry@kernel.org,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nju.edu.cn:email,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,bytedance.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9334B6EF186

On Wed,  1 Jul 2026 15:52:51 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:

> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> The mglru page table walker batches per-generation size deltas in
> walk->nr_pages while walking page tables without holding the lruvec lock.
> The reset_batch_size() later folds those deltas into walk->lruvec under
> the lruvec lock.
> 
> The page table walker can run concurrently with the memcg reparenting path
> as follows:
> 
> CPU0                           CPU1
> ====                           ====
> 
> walk_mm
> --> walk_page_range
>     --> update_batch_size
>         --> walk->nr_pages += delta
> 
>                               mem_cgroup_css_offline
>                               --> memcg_reparent_objcgs
>                                   --> lock lruvec
>                                       lru_gen_reparent_memcg
>                                       --> reparent child folios to parent
>                                       unlock lruvec
> 
>     lock lruvec
>     reset_batch_size
>     --> child lrugen->nr_pages += delta
> 
> This will trigger the following warning in lru_gen_exit_memcg():
> 
> 	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
> 				   sizeof(lruvec->lrugen.nr_pages)));
> 
> And the user-visible impact of underestimated nr_pages in MGLRU was
> premature OOMs because MGLRU does not try to reclaim memory when nr_pages
> reaches zero, but there are still more pages.
> 
> To fix it, make reset_batch_size() check CSS_DYING under RCU before
> flushing the pending batch. A non-dying memcg keeps the original lruvec
> stable against RCU-delayed offlining; a dying memcg redirects the deltas
> to the first non-dying ancestor.
> 
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
> ---
> Changes in v4:
>  - re-implement lock_batch_lruvec() in a simpler way
>    (suggested by Johannes and Harry)
>  - collect Reviewed-by
>  - rebase onto the next-20260630
> 
> Changes in v3:
>  - re-implement lock_batch_lruvec() by checking CSS_DYING under the RCU lock
>    (suggested by Harry)
>  - update the commit message (suggested by Harry)
>  - temporarily drop the previous Reviewed-by tags
>    (since the sync method has changed)
>  - rebase onto the next-20260624
> 
> Changes in v2:
>  - update the commit message (pointed by Barry)
>  - collect Reviewed-by
> 
>  mm/vmscan.c | 41 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 35c3bb15ae96..ca1e2a870d51 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3262,10 +3262,40 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
>  	walk->nr_pages[new_gen][type][zone] += delta;
>  }
>  
> +#ifdef CONFIG_MEMCG
> +static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
> +{
> +	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> +
> +	rcu_read_lock();
> +
> +	/*
> +	 * The memcg can be NULL when the memory controller is disabled.
> +	 * Otherwise, the caller keeps the memcg owning @lruvec alive.
> +	 */
> +	while (unlikely(memcg && css_is_dying(&memcg->css))) {
> +		memcg = parent_mem_cgroup(memcg);
> +		lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +	}
> +
> +	spin_lock_irq(&lruvec->lru_lock);

Do we need an rcu_read_unlock() here?

> +
> +	return lruvec;
> +}
> +#else
> +static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
> +{
> +	lruvec_lock_irq(lruvec);
> +
> +	return lruvec;
> +}
> +#endif
> +
>  static void reset_batch_size(struct lru_gen_mm_walk *walk)
>  {
>  	int gen, type, zone;
> -	struct lruvec *lruvec = walk->lruvec;
> +	struct lruvec *lruvec = lock_batch_lruvec(walk->lruvec);
>  	struct lru_gen_folio *lrugen = &lruvec->lrugen;
>  
>  	walk->batched = 0;
> @@ -3285,6 +3315,8 @@ static void reset_batch_size(struct lru_gen_mm_walk *walk)
>  			lru += LRU_ACTIVE;
>  		__update_lru_size(lruvec, lru, zone, delta);
>  	}
> +
> +	lruvec_unlock_irq(lruvec);
>  }
>  
>  static int should_skip_vma(unsigned long start, unsigned long end, struct mm_walk *args)
> @@ -3779,11 +3811,8 @@ static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
>  			mmap_read_unlock(mm);
>  		}
>  
> -		if (walk->batched) {
> -			lruvec_lock_irq(lruvec);
> +		if (walk->batched)
>  			reset_batch_size(walk);
> -			lruvec_unlock_irq(lruvec);
> -		}
>  
>  		cond_resched();
>  	} while (err == -EAGAIN);
> @@ -4867,9 +4896,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	walk = current->reclaim_state->mm_walk;
>  	if (walk && walk->batched) {
>  		walk->lruvec = lruvec;
> -		lruvec_lock_irq(lruvec);
>  		reset_batch_size(walk);
> -		lruvec_unlock_irq(lruvec);
>  	}
>  
>  	mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),
> -- 
> 2.54.0
> 
> 

