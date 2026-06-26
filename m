Return-Path: <stable+bounces-268732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tVozBUkAPmo2+QgAu9opvQ
	(envelope-from <stable+bounces-268732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:30:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 639C56CA1B9
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 06:30:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=smail.nju.edu.cn header.s=iohv2404 header.b=k9G2D2+W;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268732-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268732-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=smail.nju.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3839E3040D93
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 04:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E005534DCCD;
	Fri, 26 Jun 2026 04:29:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A26346E40;
	Fri, 26 Jun 2026 04:29:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782448197; cv=none; b=Fq2Yyu230fAcgdtxlMidOpWQifve3kyYvO3QW7Yt+D9p+mMbyl/5BWbAFzoK1a1RJ7OdB5j0S08pZrZIYjIr2yi88ucnSb7wF8Kq4h5eDI5jHF4aencGVrSz9r6eZaVA8SYeobuwgJ2sORkeA5hAzJydooirkcJr3D1Y9rHZ7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782448197; c=relaxed/simple;
	bh=8VGqffH5OJuO/gbo8LE6XEjeariA7FOPq8NBT8kX9Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qx60eGqchAkkqWGv/7ajp0evJVHS5RU4fu4qglYrIFl0mtEFY+IPqFIfNP3UGBhTK2A9edf4tTyF0z0STMKo1UzW41fh0WrybaBORpaI0DUMoatY9swZ7VeLaOhzWZ+gjLxYcf6l7xG+strU6RB0VAfxwmsicQoVSfJGJv3H5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=k9G2D2+W; arc=none smtp.client-ip=54.254.200.92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1782448172;
	bh=RH0r+gJK/hrMReWaxOhejWDetrJqcWbDHN59/lZ4GMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=k9G2D2+WPvL+KNAOJIRzohA4swFy3dTwjH190RnQkc1d7ouhKLJCGWwtxYVK5SK1/
	 GAa/laxz6sK604w057TvxhEwiNzvSEtVaGRXzOYnFIRXM1dFyBzRmfIsAl7PKGrDuM
	 QpzgaZjmm1YIyhp3/O4o8yAoIo5eStcTkFYxEyPc=
X-QQ-mid: esmtpsz18t1782448164t05174eef
X-QQ-Originating-IP: 3vmW18UC5VRy9qFdv+3iD2vOii7CqpvCeFhM/CgLWYA=
Received: from [172.27.139.54] ( [153.3.21.155])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jun 2026 12:29:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16061476251147071744
Message-ID: <0559695533E1C70F+31684237-e405-48da-ad8f-4ba7ff4ddb38@smail.nju.edu.cn>
Date: Fri, 26 Jun 2026 12:29:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Qi Zheng <qi.zheng@linux.dev>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, harry@kernel.org,
 muchun.song@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20260625151554.55105-1-qi.zheng@linux.dev>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <20260625151554.55105-1-qi.zheng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NjLFCirn8u0PVmuOSW5WU0oeFBF7uMcJEHfGLYmk2nN0wiIH3t+RXYDe
	vAEUw/yIcCOS6IpV5B5SGpeRJbnc6j4lXk0IqScfhB98qGC6nqqQyF9JkHTalcXRuTAYJuh
	F3MiewO5pSSs6kJUMl8XiLX1Pf/L4RXCvloWhcCXxzs8BiZbkXTx2yc8QCFDtOSq5DzI7I4
	vkWtY92r4ajxrdhBJUbrRn2oHDn5OubfM2cQFG/3u26mJ/UorVlBCs89uygCeNjmDZ/zfuO
	YyPIoven4BolKA70ob4ZRDp7F4cdXIttuy1Bv48aJ6/nqmAro35f0rdeeTo+I47Z0aoo0+t
	SAehgOC0n8ZuET53ADBN3rlaxEv7b3kv+ckh29xTZwblkNBrozAiHuqKN39AagJHt/AuhmH
	9U0/jwab7BQnFux+WD8rbTGPn9NpY/YceEUOxaxw0AbdLyY6gUTyqt5beT6UmkY//GykGor
	ThW6Ljh3KyJcrrIRTbEKKeO2CetvBLyhY+ucYvga151ucN2Q+2twluT+l0Z025mXriMxpd5
	NnCAeYZA9hJ65Hq4tKJnsqgfPaseAhrOjWIQXrdctynG3oGhjcYVSgQAvC586Co18BefvID
	AzJzZTbsP0en0HJvO6vgZAbT/K2DAiA5vg6pHE6T1NehoVnI3zVhdZ6ecvlv8nhfjRJZ1Ar
	H/yKh6zrl8E44AVAS0Oqx4XmoiwdrLaelmuXShOZPTMWHMnSayWk7WuZSU2NHaY6EETlt8G
	8p/vvAocJUUCsow0NQlFic8Bkxl0NUk/R5VJ986IlcjtseYvEA0sCoSE/LXtojC8oUQ91eb
	3fNHgYz3P6WmfzgEn7Z3wYlfHMbVT29gWCbVyQIckWxycfEC1Xw6VFJIAaZCzcHNFBacqAE
	UgklicpNc1Em6ZSWQL3qxsG+vXCfgsAKjDPx5uJVLKKf7wQt8EFk+A1on9tQbf4lmdtip0h
	A+0amQUAPqmLddQNV/nXeGRXoFklWPwdIXaZEWKpXSqSwKUmItO+wba9oGmMMvWk/mOGd3B
	RJ+yY3UpljnqCDalaql/zgSxGDh+dZZ7EgMoTJ/uHVdf/yKyV5mVsm/jtkcJaINWkJQ3/dk
	vR5qc7Ss9rzVSBb8lWJcL3/qs+8QSpgFy/4WfQhT1dfZD7wxy9rFN2TnmukvD+GNcFz5hQ1
	mnD6
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[smail.nju.edu.cn,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[smail.nju.edu.cn:s=iohv2404];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[peiyang_he@smail.nju.edu.cn,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268732-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:hannes@cmpxchg.org,m:harry@kernel.org,m:muchun.song@linux.dev,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_MUA_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[smail.nju.edu.cn:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peiyang_he@smail.nju.edu.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nju.edu.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 639C56CA1B9

Hi Qi,

I have applied this patch and tested it against the PoC, the warning is not observed anymore in the kernel log.
Thanks for your nice work!

Best,
Peiyang

On 2026/6/25 23:15, Qi Zheng wrote:
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
> ---
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
>  mm/vmscan.c | 45 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 35c3bb15ae96..1ec8c23c72b9 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3262,10 +3262,44 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
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
> +	if (!memcg || !css_is_dying(&memcg->css))
> +		goto lock;
> +
> +	do {
> +		memcg = parent_mem_cgroup(memcg);
> +	} while (memcg && css_is_dying(&memcg->css));
> +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +
> +lock:
> +	spin_lock_irq(&lruvec->lru_lock);
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
> @@ -3285,6 +3319,8 @@ static void reset_batch_size(struct lru_gen_mm_walk *walk)
>  			lru += LRU_ACTIVE;
>  		__update_lru_size(lruvec, lru, zone, delta);
>  	}
> +
> +	lruvec_unlock_irq(lruvec);
>  }
>  
>  static int should_skip_vma(unsigned long start, unsigned long end, struct mm_walk *args)
> @@ -3779,11 +3815,8 @@ static void walk_mm(struct mm_struct *mm, struct lru_gen_mm_walk *walk)
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
> @@ -4867,9 +4900,7 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	walk = current->reclaim_state->mm_walk;
>  	if (walk && walk->batched) {
>  		walk->lruvec = lruvec;
> -		lruvec_lock_irq(lruvec);
>  		reset_batch_size(walk);
> -		lruvec_unlock_irq(lruvec);
>  	}
>  
>  	mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(sc),


