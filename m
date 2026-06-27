Return-Path: <stable+bounces-269422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mnuENVdYQGr5ewkAu9opvQ
	(envelope-from <stable+bounces-269422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 01:10:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE156D2CED
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 01:10:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=XPjgvX6y;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269422-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269422-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33A7B3019532
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 23:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ACB334681;
	Sat, 27 Jun 2026 23:10:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D6D81ACD;
	Sat, 27 Jun 2026 23:10:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782601809; cv=none; b=WwSZhQTe1QfxGSt1QUPhokb6aECcAgNyYnGjX9ArrFmiar7JCtgoi8d3NkLN3wpnkR3/2vjo3Mo+wLuo59/hXowTl1mmNOwL1eTwm+EVRXdi0kTC6O9r2TapZ7fGpLiCOXzPp5cndPBSG+lYNnjPQg/OGxBRXshFcUvwN9LfB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782601809; c=relaxed/simple;
	bh=WdwYo/UyB+hRWCV4QsPYStri1u0uQFQDmrNTN1mznEI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KEO1EcgmIUe0e1TkjWkz9z8tCybIaBmyMyYWfmbNRwmJGmUK+YqMPI2JeMy9+rtooA1DvNaaP+9Brede7+AAhynOGpm/6ErmfbblSs5maYyT+fySHMiEUuCKrlYVyvW0FgC0rYhulX/gyHEaZ4EPRAm5IGlFW9uJ/QbwTcuZFEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XPjgvX6y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABA91F000E9;
	Sat, 27 Jun 2026 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782601808;
	bh=5D6v0GXcAFL77pAcQTrYWtPV+T9YBufpS6c20apcpxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XPjgvX6ycSUd9Pjzv07W94UUP0I2rXBsMn1XGQ1TtVVprC6RaHbLLOlm8YRdyA82Y
	 gjAuEtnZwvYXdnZ2FS0zk9vkPz9y4ULh4V4ZNZ2hhggC1WwyU+AJXPnrrYwlTlN2Vc
	 ntMsz8r1/oJhB4GpC55pla69W3RJZN1NpPWFYtwk=
Date: Sat, 27 Jun 2026 16:10:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 rppt@kernel.org, vbabka@kernel.org, mgorman@techsingularity.net,
 hannes@cmpxchg.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmstat: fold stranded per-cpu node stats when a
 node comes online
Message-Id: <20260627161007.81e4533ce561c2951a69f927@linux-foundation.org>
In-Reply-To: <20260627202243.758289-1-gourry@gourry.net>
References: <20260627202243.758289-1-gourry@gourry.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gourry@gourry.net,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:rppt@kernel.org,m:vbabka@kernel.org,m:mgorman@techsingularity.net,m:hannes@cmpxchg.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269422-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BE156D2CED

On Sat, 27 Jun 2026 16:22:43 -0400 Gregory Price <gourry@gourry.net> wrote:

> A per-node vmstat counter is pgdat->vm_stat[] plus per-cpu deltas.
> A balanced counter can sit split as global=+N / per-cpu=-N.
> 
> The folds reconciling the split only walk online nodes, so when
> try_offline_node() marks a node offline the per-cpu deltas are stranded.
> 
> A subsequent online resets the per-cpu area but not pgdat->vm_stat[],
> orphaning the +N permanently.  All NR_VM_NODE_STAT_ITEMS are affected.

Geeze, simple mistake, been there ten years...

> The existing code zeroes the per-cpu counters and causes a permanent
> skew. Fold the stranded deltas instead, before the node rejoins the
> online set. The node is not online yet and the hotplug lock is held,
> so the remote access to per-cpu values is safe.

Oh.  Shouldn't we be doing this during offlining?

> Discovered when node compaction hung for a nearly empty node, as the
> math to determine throttling broke.  Reproduced by repeated memory
> hotplug/unplug cycles on a node under pressure: NR_ISOLATED_ANON
> ratchets up and never returns to zero.
> 
> ...
>
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1536,7 +1536,7 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
>  {
>  	int nid = pgdat->node_id;
>  	enum zone_type z;
> -	int cpu;
> +	int cpu, i;
>  
>  	pgdat_init_internals(pgdat);
>  
> @@ -1554,10 +1554,17 @@ void __ref free_area_init_core_hotplug(struct pglist_data *pgdat)
>  	pgdat->node_start_pfn = 0;
>  	pgdat->node_present_pages = 0;
>  
> -	for_each_online_cpu(cpu) {
> -		struct per_cpu_nodestat *p;
> +	/*
> +	 * Hot-unplug can leave per-cpu vmstat deltas unfolded (folders skip
> +	 * offline nodes) - reconcile this at online. Foreign access to counters
> +	 * is safe: the node is not online yet and we hold the hotplug lock.
> +	 */
> +	for_each_possible_cpu(cpu) {

That's a lot of CPUs

> +		struct per_cpu_nodestat *p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
>  
> -		p = per_cpu_ptr(pgdat->per_cpu_nodestats, cpu);
> +		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)

and that's a lot of items.

I guess the overall loop count won't be large enough to cause issues,
but it's large!

Perhaps there's some simple test we can do on the per_cpu_nodestat to
avoid the inner loop?  Perhaps might need to add a field for this?

btw, "for(int i..." is allowed nowadays.  It'll make this code nicer, IMO.

And... Sashiko seems to have found a pre-existing issue:
	https://sashiko.dev/#/patchset/20260627202243.758289-1-gourry@gourry.net

> +			if (p->vm_node_stat_diff[i])
> +				node_page_state_add(p->vm_node_stat_diff[i], pgdat, i);
>  		memset(p, 0, sizeof(*p));
>  	}


