Return-Path: <stable+bounces-227876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oL6dHIahwGmLJQQAu9opvQ
	(envelope-from <stable+bounces-227876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 03:12:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CEA2EBDFB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 03:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B6143006B55
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 02:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EE71EDA0F;
	Mon, 23 Mar 2026 02:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jX4e9TlB"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430302BD11
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774231938; cv=none; b=ljBRu9sbsI1bTTv3tq/hpcy1MA3qpsv2zQP3tOvFo6bcz8GSE4aVIRn/voRIUr8/pT1i5iST6gPMzDP1mWgTJZk1RmHkuVxPjaHG7Xt6MrY+kxlp3HJxS7VH/PtTU8z4PkG9O9actJ9ZIDGSHxQhVff3jkCreuEqVdZaqfYgYRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774231938; c=relaxed/simple;
	bh=r6at4SgkmZdNH8kd903Yyjgxb4jv3rcOAS54r37TeVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caBODTxDn7FigZCN/YvLb5BJEF9/Yej80BMZFNDcUbCqi/VWOQ6hRwHquHU+4sr1ufJFCsE0EEvvE+C7tdvDHdugVo8UTdvCwTUWI7ohuW5YeitvfWSQexLQ/G6YgCZ4H2LjCqAVAEg1QXBGN/JHxqx/PMCqd5JfFFGHvySy7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jX4e9TlB; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <db5ac1d4-9d07-4fdf-8127-b4e5d1a5df1c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774231935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7fP+Lbq2mzGcFGL6RZjQPbF6+oL36HH3daBGTHIiwlI=;
	b=jX4e9TlBHFivYzXhtQeiqJ6WURnOVA+1u2ohki/UxH3ZMJZExRqRLN7BhPgdnOj+C6BT/k
	rbOjjISEO7C59LHl6ktsv8kcVUnD7UIFppBch1S9/3lMJLOy2IYQxtwm69ofZwBWb3YhXo
	69b5Z0tKw4I/ydVGFd5TRGn9JMhv4iM=
Date: Mon, 23 Mar 2026 10:12:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/memcontrol: fix obj_cgroup leak in
 mem_cgroup_css_online() error path
To: David Carlier <devnexen@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, stable@vger.kernel.org
References: <20260322080142.5834-1-devnexen@gmail.com>
 <20260322193631.45457-1-devnexen@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260322193631.45457-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-227876-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: C9CEA2EBDFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/26 3:36 AM, David Carlier wrote:
> When obj_cgroup_alloc() fails partway through the NUMA node loop in
> mem_cgroup_css_online(), the free_objcg error path drops the extra
> reference held by pn->orig_objcg but never kills the initial percpu_ref
> from obj_cgroup_alloc() stored in pn->objcg.
> 
> Since css_offline is never called when css_online fails,
> memcg_reparent_objcgs() never runs, so the percpu_ref_kill() that
> normally drops this initial reference never executes. The obj_cgroup and
> its per-cpu ref allocations are leaked.
> 
> Clear pn->objcg via rcu_replace_pointer() and add the missing
> percpu_ref_kill() in the error path, matching the normal teardown
> sequence in memcg_reparent_objcgs().
> 
> Also add a NULL check for pn in __mem_cgroup_free() to prevent a NULL
> pointer dereference when alloc_mem_cgroup_per_node_info() fails partway
> through the node loop in mem_cgroup_alloc().
> 
> Fixes: 098fad3e1621 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>   mm/memcontrol.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a47fb68dd65f..00b3bb81aee4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3936,6 +3936,8 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
>   
>   	for_each_node(node) {
>   		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
> +		if (!pn)
> +			continue;
>   
>   		obj_cgroup_put(pn->orig_objcg);
>   		free_mem_cgroup_per_node_info(pn);
> @@ -4137,8 +4139,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>   free_objcg:
>   	for_each_node(nid) {
>   		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];

Nit: A newline character is needed here, otherwise the checkpatch might
complain.

> +		objcg = rcu_replace_pointer(pn->objcg, NULL, true);
> +		if (objcg)
> +			percpu_ref_kill(&objcg->refcnt);
>   
> -		if (pn && pn->orig_objcg) {
> +		if (pn->orig_objcg) {
>   			obj_cgroup_put(pn->orig_objcg);
>   			/*
>   			 * Reset pn->orig_objcg to NULL to prevent

Make sense, thanks!

Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>





