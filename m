Return-Path: <stable+bounces-274555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wXQJJuqWVmry+QAAu9opvQ
	(envelope-from <stable+bounces-274555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:07:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E711E7589F4
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:07:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="nASgY/cP";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274555-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274555-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D77223145884
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CFE435502;
	Tue, 14 Jul 2026 20:05:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A1412BED
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:05:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059533; cv=none; b=Bpgxs1B1WCF7dvYAPf+EoaQKseUe2AxFjNyJn+FqBh8hLeM+79Cpo98vSLaS6s5bO8rO8khVCiyyPfk+12UsEPL40NLjb5l3l26zeXR6Dm2WNq7lmN78Jqy8Dx0j7K8bDRp+clVgN60IprDRdJM3YhSp41utPNJVqxfn+cA0U9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059533; c=relaxed/simple;
	bh=N75yYzsLi76+4XbivVftPrDGrOyxJD1mSoPJE0IsWPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/N06deps/3O/ysjzgSHdgaC8wFBEbh3oCrVIL3RlX5FGKkhGZf18Nm37RJEqUQPjxzuDpUsPcxlRVl9I9a31fSuRxShSkzOoP7F+vYoMTsJJHJNGenMbh3TsJcnfRhNUB5igWBsMAFsFNUXdSd+kSU9/mruU72eMs8OIf1ho2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nASgY/cP; arc=none smtp.client-ip=95.215.58.180
Date: Tue, 14 Jul 2026 13:05:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784059528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BLqLKH5IvfKdelylXtTpwefx4KsBR33CINxbQ5x0Fqk=;
	b=nASgY/cPDPiWt21ZZyKIcwGLYVyGB4ufGOPaFxRr5hd6gHTbtV8ySF1XScNfYac7cwG9pg
	QeQlV4JxgsYquQV9RNtt34ZrStlkQWSaagjaMGCvZawUrfC+veAPNpWRV3spiCK62S1xJ+
	HdM9i+zJep7TuSY+/PyleCqGIiIoqv0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com, 
	baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	hannes@cmpxchg.org, harry@kernel.org, muchun.song@linux.dev, 
	peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev, ljs@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5] mm: mglru: fix stale batch updates after memcg
 reparenting
Message-ID: <alaWT_sKn7V9zoOr@linux.dev>
References: <20260710154318.75388-1-qi.zheng@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710154318.75388-1-qi.zheng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:kasong@tencent.com,m:baohua@kernel.org,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:hannes@cmpxchg.org,m:harry@kernel.org,m:muchun.song@linux.dev,m:peiyang_he@smail.nju.edu.cn,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:ljs@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhengqi.arch@bytedance.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[shakeel.butt@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-274555-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:mid,linux.dev:email,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E711E7589F4

On Fri, Jul 10, 2026 at 11:43:18PM +0800, Qi Zheng wrote:
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

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

