Return-Path: <stable+bounces-270205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L1iZK3I5RWpf8woAu9opvQ
	(envelope-from <stable+bounces-270205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 17:59:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 498776EF704
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 17:59:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b=chCZt+ry;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270205-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-270205-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82BD73038A2C
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 15:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9130E492197;
	Wed,  1 Jul 2026 15:59:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B5B492525
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 15:59:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921564; cv=none; b=S5Fi6kkLbivjWRp4iD/j2gypZsG1KBQyXZ+8TGAKhHKcbxFR5Oc4IIymAKBsjd+IkhR0nyucgKQRBT59jrsC0ynh+m80/rme9RI9r+i3wSukxKRehG+Ajq/IJKLm/y4IaMehFPx3dLjeKGMkA6dpD8ZcIVDAZF3fBb7nEYTfUBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921564; c=relaxed/simple;
	bh=5T4/pKY0LtS/6S8SyWxnzU3YlBIM3TDxZgiVRrQ4OUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d251g+zk1RMRiUFTHuHBaw/vgR4Wnrh0hLnCGIhfD+Z8//DRHhM1+tf3kiV7h3BMZKYioHgxt2xWm/9NPUQH3YO/VGOQXeTzUptVLxSEWazkgTJsGueKEdbKeFWOgSKsNBSIuUkkKNWYzhJM83rtxuifVkRFOO7CUgycI6eT6nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=chCZt+ry; arc=none smtp.client-ip=209.85.160.174
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c2a76536bso3481151cf.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 08:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1782921560; x=1783526360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vW5yMQMtKuZNWOL3QxEXaq9d8mHdlESmK4dMn+saK1g=;
        b=chCZt+ryIq+cSxRLWU7NCKDYWdueyreLVfatEdImJdAT6omN3uB5LDp+g2EerWVyYt
         3vVAH7DqbWnGAyRbFhXlWPv+UWg68hvudUJ5OM6e1u1ykjAIDlmjEQGBVKHWcz6R/C0c
         HwHon7NQ7F40Ja0b/HNHK9iuOFBkc5l3u14WjPtVLcrR39ytBIEHsT2x/3DsremNnIQK
         H8/tSdw3j8Yjek4WfENop+Qmd6XHUywcJgze5QnB7Kgv4x2b1mHkHu5PVzuzc9KwwNw3
         wgnP8gIU/JROKW9q9vDHeJMs1bn5nrx6Rj/wAPAzk0d1FZbyd+/otWWRZ4FkMh2WEMgd
         Fz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921560; x=1783526360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vW5yMQMtKuZNWOL3QxEXaq9d8mHdlESmK4dMn+saK1g=;
        b=K7+LmKIwOSiX5IieGjUwyqBqDcSf8xyzybeYnDgakGEE5MgJWUjy1d++y4xSn06oYl
         w80/Fjw4TKJFfqUqqtMacR36Oxu+iEOeKdj4eKrjDEG4o0niUt/NxO1OoZkAlsM6MP8k
         w0X4BvJXT6ZEagk3X3XQ1AvXAge492Gp2yMgNFk/TaheElqo1Htx8kd8xd/EBTREFZDR
         eLkJHeFnPwdRfq9shsolxVJgnN4H3xg1ODFKsiRBrq6X5201CxFecEmX7ZSUlfCAH3a1
         o3CarXWD6hpo23ip0aTSHrmpbckA/xdn5fSNCPpAQwtGz/FYmc8NlZhsAjKq2cRvVJ7b
         FhTg==
X-Forwarded-Encrypted: i=1; AFNElJ+0GschKmKQTESUS6eH8xEi2nJi8Ne/i7Onsl8dHzSOSuT5P1exSBqZoMQ3ksNNel4EDpEvI+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlftEf/JZLVjA5S4gVVadBCOen3HhHVVP3Vk3+tbI9zzyyjAEj
	89hz7XP7XrBtQcQi/bSQDKlUcxoJes82KLPaJVN5NxFUnmJOthcUepslxpTbtI7rfcM=
X-Gm-Gg: AfdE7cl6ZXYwccvt1rtLlPCdajNVSMgOPgIbJirD+a3iSgWhZ7QGS58KQA/bpJ++B+Q
	sJfZnk0iIOb3AnCCooYy3RiY/2U31+JQ32PssOlrvAfHgx6zqJzaolpQsvuoBYWIsFbX1EIhxJC
	so6JjocqeK8i+V8CxdgIrL269YZt+N39sqw9yfDZDpvtKUmCy9tB+ulzTtVQN0DAEpmBFwqX7Kv
	dDfd/6HLSpfjwMf/rK8/b0mDABOd4Mo8DU21UthDBjg1LMkLl+utj9YzxsX6lfaLgyOwkRs6pu3
	7SP9C+emFE0Gve1Ftv2USncHnvfvJhXeFSYhFeLGzJOMXRvG7q0WeNmwPeVSk9GxKqpLT1b2k0K
	yl7PNOwa1kcDrbpklTVs0roPVJ0Qu7EAjkDt2iUwHv43HCBioab4tR44ChvIcViYHYsdqBJQ3FO
	l80QvtopVVKa8=
X-Received: by 2002:a05:622a:4088:b0:517:6804:3732 with SMTP id d75a77b69052e-51c26b0fceemr29104571cf.55.1782921559721;
        Wed, 01 Jul 2026 08:59:19 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c10a37dc5sm49375091cf.31.2026.07.01.08.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 08:59:18 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:59:17 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Harry Yoo <harry@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
	akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
	shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, muchun.song@linux.dev,
	peiyang_he@smail.nju.edu.cn, mhocko@kernel.org,
	roman.gushchin@linux.dev, ljs@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] mm: mglru: fix stale batch updates after memcg
 reparenting
Message-ID: <akU5VdOBkLGInh_t@cmpxchg.org>
References: <20260701145736.3785016-1-usama.arif@linux.dev>
 <2fb5ce53-666b-4b0a-a4ad-2b3a28c54768@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fb5ce53-666b-4b0a-a4ad-2b3a28c54768@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270205-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:harry@kernel.org,m:usama.arif@linux.dev,m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,cmpxchg.org:dkim,cmpxchg.org:mid,cmpxchg.org:from_mime,nju.edu.cn:email,vger.kernel.org:from_smtp,bytedance.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 498776EF704

On Thu, Jul 02, 2026 at 12:36:42AM +0900, Harry Yoo wrote:
> 
> 
> On 7/1/26 11:57 PM, Usama Arif wrote:
> > On Wed,  1 Jul 2026 15:52:51 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> > 
> >> From: Qi Zheng <zhengqi.arch@bytedance.com>
> >>
> >> The mglru page table walker batches per-generation size deltas in
> >> walk->nr_pages while walking page tables without holding the lruvec lock.
> >> The reset_batch_size() later folds those deltas into walk->lruvec under
> >> the lruvec lock.
> >>
> >> The page table walker can run concurrently with the memcg reparenting path
> >> as follows:
> >>
> >> CPU0                           CPU1
> >> ====                           ====
> >>
> >> walk_mm
> >> --> walk_page_range
> >>     --> update_batch_size
> >>         --> walk->nr_pages += delta
> >>
> >>                               mem_cgroup_css_offline
> >>                               --> memcg_reparent_objcgs
> >>                                   --> lock lruvec
> >>                                       lru_gen_reparent_memcg
> >>                                       --> reparent child folios to parent
> >>                                       unlock lruvec
> >>
> >>     lock lruvec
> >>     reset_batch_size
> >>     --> child lrugen->nr_pages += delta
> >>
> >> This will trigger the following warning in lru_gen_exit_memcg():
> >>
> >> 	VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
> >> 				   sizeof(lruvec->lrugen.nr_pages)));
> >>
> >> And the user-visible impact of underestimated nr_pages in MGLRU was
> >> premature OOMs because MGLRU does not try to reclaim memory when nr_pages
> >> reaches zero, but there are still more pages.
> >>
> >> To fix it, make reset_batch_size() check CSS_DYING under RCU before
> >> flushing the pending batch. A non-dying memcg keeps the original lruvec
> >> stable against RCU-delayed offlining; a dying memcg redirects the deltas
> >> to the first non-dying ancestor.
> >>
> >> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> >> Closes: https://lore.kernel.org/all/5A9E929D82717101+12fcf643-efb8-4b9a-a53a-1e28cc894f0b@smail.nju.edu.cn
> >> Fixes: f304652609ea ("mm: vmscan: prepare for reparenting MGLRU folios")
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> >> Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
> >> ---
> >> Changes in v4:
> >>  - re-implement lock_batch_lruvec() in a simpler way
> >>    (suggested by Johannes and Harry)
> >>  - collect Reviewed-by
> >>  - rebase onto the next-20260630
> >>
> >> Changes in v3:
> >>  - re-implement lock_batch_lruvec() by checking CSS_DYING under the RCU lock
> >>    (suggested by Harry)
> >>  - update the commit message (suggested by Harry)
> >>  - temporarily drop the previous Reviewed-by tags
> >>    (since the sync method has changed)
> >>  - rebase onto the next-20260624
> >>
> >> Changes in v2:
> >>  - update the commit message (pointed by Barry)
> >>  - collect Reviewed-by
> >>
> >>  mm/vmscan.c | 41 ++++++++++++++++++++++++++++++++++-------
> >>  1 file changed, 34 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 35c3bb15ae96..ca1e2a870d51 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -3262,10 +3262,40 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
> >>  	walk->nr_pages[new_gen][type][zone] += delta;
> >>  }
> >>  
> >> +#ifdef CONFIG_MEMCG
> >> +static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
> >> +{
> >> +	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
> >> +	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> >> +
> >> +	rcu_read_lock();
> >> +
> >> +	/*
> >> +	 * The memcg can be NULL when the memory controller is disabled.
> >> +	 * Otherwise, the caller keeps the memcg owning @lruvec alive.
> >> +	 */
> >> +	while (unlikely(memcg && css_is_dying(&memcg->css))) {
> >> +		memcg = parent_mem_cgroup(memcg);
> >> +		lruvec = mem_cgroup_lruvec(memcg, pgdat);
> >> +	}
> >> +
> >> +	spin_lock_irq(&lruvec->lru_lock);
> > 
> > Do we need an rcu_read_unlock() here?
> 
> lruvec_unlock_irq() does that.

Yeah, that tripped me up too. And it makes me think Shakeel was right
after all: this should live next to the other lruvec_lock() primitives.

Sure, MGLRU is the only user, but it's still much easier to understand
this if the code sits next to the rest of the API (and the unlock!).

lruvec_live_lock_irq()?

