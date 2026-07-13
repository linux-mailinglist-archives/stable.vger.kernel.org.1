Return-Path: <stable+bounces-273633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DfSyMFm9VGqaqQMAu9opvQ
	(envelope-from <stable+bounces-273633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 12:26:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C3749C7F
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 12:26:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=h9p5lrWo;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273633-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273633-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2E1230488C5
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 10:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7628B3D9533;
	Mon, 13 Jul 2026 10:22:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19913624C2;
	Mon, 13 Jul 2026 10:22:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783938173; cv=none; b=aa/woqKdBQLdJOfUhhODaitJh4zWZAf1uh3u8zjTz9Lt5JeBHaI5s+qjBJLzM/wjmvkIISmQyuHsOqc/GBB/EfEChdjrszBJuQHmXtU5rzWoazqR2CvKE2twMoFLUTQLM9JbPlu2uIbBbQ2XmNY+9vMA2/wiscU61o/7V3OiRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783938173; c=relaxed/simple;
	bh=VX4g3z4Wikmxzsaw+/m6jdJkTveTTJM1UMis/os1+EE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KcdvapyEBHHJXy5fTz8NhXVids92SMoRNy9kMvco3CsoqpjFKDgWfw75l/rFzJ0Q+mlkWFoxwJiNbZ1b+qtag+5il369gerwmffu1/FIYwdYlZ1GXPixrahcvjlsnYw/Lhldm3vlGvUhazy1yqsqCO1+ktmZhsKbnsXMyrM2/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h9p5lrWo; arc=none smtp.client-ip=95.215.58.174
Message-ID: <99977527-c2d7-4c70-8d92-03c306d3ec36@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783938158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hRcZAfhs+kHcVySJuPzxTTfP2MnAcNBGTb9R86cF3qs=;
	b=h9p5lrWoV13zy8DGeLR6b7gi3acso++iVPQs8D7wNMi/Ih6KYYfFJUmgfgkfEv8+XFNcc1
	OZcCWSmr4yLy1eth1NIjkqg0xOwrOFEP2ALqZBlkt2ef+WIhGVktu0vDSCRWZIfGJhWt9F
	7txsaIItmeJFSUeYUgQWdBIa6aEa09k=
Date: Mon, 13 Jul 2026 18:22:28 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@kernel.org>,
 Alexandre Ghiti <alex@ghiti.fr>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] mm: memcontrol: update state_local when flushing NMI
 stats
To: Guopeng Zhang <guopeng.zhang@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>
References: <20260713085053.2916813-1-guopeng.zhang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260713085053.2916813-1-guopeng.zhang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:vbabka@kernel.org,m:alex@ghiti.fr,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:zhangguopeng@kylinos.cn,m:guopeng.zhang@linux.dev,m:akpm@linux-foundation.org,m:shakeel.butt@linux.dev,m:hannes@cmpxchg.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-273633-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A3C3749C7F



在 2026/7/13 16:50, Guopeng Zhang 写道:
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> flush_nmi_stats() updates state[] for kmem and slab counters but leaves
> the corresponding state_local[] counters unchanged. Local kmem and
> slab statistics therefore miss updates collected through the NMI-safe
> atomic path.
> 
> Update state_local[] together with state[].
> 
> Fixes: 940b01fc8dc1 ("memcg: nmi safe memcg stats for specific archs")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>  mm/memcontrol.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 22f55aeb94f3..02599b8b6bd5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4443,6 +4443,7 @@ static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
>  		int index = memcg_stats_index(MEMCG_KMEM);
>  
>  		memcg->vmstats->state[index] += kmem;
> +		memcg->vmstats->state_local[index] += kmem;
>  		if (parent)
>  			parent->vmstats->state_pending[index] += kmem;
>  	}
> @@ -4460,9 +4461,11 @@ static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
>  			int index = memcg_stats_index(NR_SLAB_RECLAIMABLE_B);
>  
>  			lstats->state[index] += slab;
> +			lstats->state_local[index] += slab;
>  			if (plstats)
>  				plstats->state_pending[index] += slab;
>  			memcg->vmstats->state[index] += slab;
> +			memcg->vmstats->state_local[index] += slab;
>  			if (parent)
>  				parent->vmstats->state_pending[index] += slab;
>  		}
> @@ -4471,9 +4474,11 @@ static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
>  			int index = memcg_stats_index(NR_SLAB_UNRECLAIMABLE_B);
>  
>  			lstats->state[index] += slab;
> +			lstats->state_local[index] += slab;
>  			if (plstats)
>  				plstats->state_pending[index] += slab;
>  			memcg->vmstats->state[index] += slab;
> +			memcg->vmstats->state_local[index] += slab;
>  			if (parent)
>  				parent->vmstats->state_pending[index] += slab;
>  		}

Looks correct — state_local[] mirrors state[] for this cgroup's own NMI-accounted kmem/slab charges, and pending→local is properly left untouched.

Acked-by: Tao Cui <cuitao@kylinos.cn>

