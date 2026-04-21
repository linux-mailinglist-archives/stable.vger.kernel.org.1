Return-Path: <stable+bounces-240180-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uN01G+uI52kU9wEAu9opvQ
	(envelope-from <stable+bounces-240180-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:25:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1684F43BFBB
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FFC3300D1F7
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4BF3D88E6;
	Tue, 21 Apr 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmlrW0kq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FBF3D8116;
	Tue, 21 Apr 2026 14:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781544; cv=none; b=FMTpLdyehUD6Pq4gbD1UNHzRDgrYppElAyRc4K1W5lBSHWkJDyeoR4QkedmhYjbXOKZzULIlXoI8+TfS4XcM0h8pEbnlTABWcOqUNU0Xu6B2dJ80pDEWRe0Log3qOrhOr4thKxiHqDxABq0Et+9Ro/FETg8P61ac1HzlZ3hfiJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781544; c=relaxed/simple;
	bh=YSxGlcQS3U1Wutb2J/VUv/2OSR9GifsEC+73SgTBQOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuGpHPbNbIGvVRjm/8Tn8gzZ7Z2vmQnUHJZ7/Qf1Q2A6gZUf3NFxu64lvFK1XzgLLGAt3w9DVKE+AnVTLq4tdj/KebJOlOpd51GY5Up+Z/QyvdxNqMG4jUr5No8/cyAT5tgzjHYfoex7K2P+L9HrNr2KkP7xGIcQsHSWgtFBHxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmlrW0kq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE4FC2BCB0;
	Tue, 21 Apr 2026 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776781543;
	bh=YSxGlcQS3U1Wutb2J/VUv/2OSR9GifsEC+73SgTBQOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmlrW0kq2qwKedKZVYa/gk4R47bz9FuApozdzY47ikUR4EG5WBsqR24nn+3QlPz22
	 MYX/GbhHpcG+YBHmFTKqWS6WJJtrcdaEzkJPs8iuZF+Lo+8M/m1UKrv97flgD1CG7g
	 rVb8rrdru4bu50nPP9VcbZ+pIRDwHQX2umDcpn8Sxuk9MSk6pUwSBHMWOpp5GxiHOr
	 FCPiYhUwVHzKTHJ6LGghGgZMwNX/r1XXYxUgeWgqUipoHBHQAgkfFh7StLmmi6gZlj
	 G7CtG8nCmlScNlKdxDodyFPBQKBjUpw71v8nTW+aIm/NuOy/53ZMNuW0CFVgW4ZedC
	 +L9uL7HlJnMxA==
Date: Tue, 21 Apr 2026 15:25:32 +0100
From: Simon Horman <horms@kernel.org>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bigeasy@linutronix.de,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	david.lebrun@uclouvain.be, alex.aring@gmail.com,
	stefano.salsano@uniroma2.it, netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: ipv6: fix NOREF dst use in seg6 and rpl
 lwtunnels
Message-ID: <20260421142532.GD651125@horms.kernel.org>
References: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240180-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,linutronix.de,goodmis.org,uclouvain.be,gmail.com,uniroma2.it,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1684F43BFBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 11:47:35AM +0200, Andrea Mayer wrote:
> seg6_input_core() and rpl_input() call ip6_route_input() which sets a
> NOREF dst on the skb, then pass it to dst_cache_set_ip6() invoking
> dst_hold() unconditionally.
> On PREEMPT_RT, ksoftirqd is preemptible and a higher-priority task can
> release the underlying pcpu_rt between the lookup and the caching
> through a concurrent FIB lookup on a shared nexthop.
> Simplified race sequence:
> 
>   ksoftirqd/X                       higher-prio task (same CPU X)
>   -----------                       --------------------------------
>   seg6_input_core(,skb)/rpl_input(skb)
>     dst_cache_get()
>       -> miss
>     ip6_route_input(skb)
>       -> ip6_pol_route(,skb,flags)
>          [RT6_LOOKUP_F_DST_NOREF in flags]
>         -> FIB lookup resolves fib6_nh
>            [nhid=N route]
>         -> rt6_make_pcpu_route()
>            [creates pcpu_rt, refcount=1]
>              pcpu_rt->sernum = fib6_sernum
>              [fib6_sernum=W]
>            -> cmpxchg(fib6_nh.rt6i_pcpu,
>                       NULL, pcpu_rt)
>               [slot was empty, store succeeds]
>       -> skb_dst_set_noref(skb, dst)
>          [dst is pcpu_rt, refcount still 1]
> 
>                                     rt_genid_bump_ipv6()
>                                       -> bumps fib6_sernum
>                                          [fib6_sernum from W to Z]
>                                     ip6_route_output()
>                                       -> ip6_pol_route()
>                                         -> FIB lookup resolves fib6_nh
>                                            [nhid=N]
>                                         -> rt6_get_pcpu_route()
>                                              pcpu_rt->sernum != fib6_sernum
>                                              [W <> Z, stale]
>                                           -> prev = xchg(rt6i_pcpu, NULL)
>                                           -> dst_release(prev)
>                                              [prev is pcpu_rt,
>                                               refcount 1->0, dead]
> 
>     dst = skb_dst(skb)
>     [dst is the dead pcpu_rt]
>     dst_cache_set_ip6(dst)
>       -> dst_hold() on dead dst
>       -> WARN / use-after-free
> 
> For the race to occur, ksoftirqd must be preemptible (PREEMPT_RT without
> PREEMPT_RT_NEEDS_BH_LOCK) and a concurrent task must be able to release
> the pcpu_rt. Shared nexthop objects provide such a path, as two routes
> pointing to the same nhid share the same fib6_nh and its rt6i_pcpu
> entry.
> 
> Fix seg6_input_core() and rpl_input() by calling skb_dst_force() after
> ip6_route_input() to force the NOREF dst into a refcounted one before
> caching.
> The output path is not affected as ip6_route_output() already returns a
> refcounted dst.
> 
> Fixes: af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
> Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Reviewed-by: Simon Horman <horms@kernel.org>


