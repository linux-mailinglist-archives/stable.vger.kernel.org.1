Return-Path: <stable+bounces-240438-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF66JurS6Wm9kgIAu9opvQ
	(envelope-from <stable+bounces-240438-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 10:06:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 047C744E502
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 10:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C09C430A34AA
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D47363C7F;
	Thu, 23 Apr 2026 08:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X/1/pHnX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="70mgCanu"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15040363086;
	Thu, 23 Apr 2026 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776931262; cv=none; b=tq62n3E3QQVwmTXzfVEAJwDFYj1eTkQ+JdnMf46cK8Kp+ogafSnKpRh4s3YyjDcGyC9Ou/BJ6H9c4mWHoO3BixjJbkSUzI+7WadbX0iqv6j4ToD1lrS/DN1Cn7Asek17aIOZQ5D8Ud4U+vNTq0+XWquGCpyuXr0J6MAaxm7MRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776931262; c=relaxed/simple;
	bh=3MoVpFbFeUx8s90sN+67YWz0tzIK1QHfqyZdBkPkkto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQhuao+TQKZ5GPdw5oWBUsmf7oFq0bSc2IF5j/t4JXvw6C2eokb17YLFUer++XYh/EKpuc+KE+kIuaHjnZNhn3r9DbuwIdd22wD5bJwt2BintgUuYPPE4H08QcxxFvOPyO0sN8aE6Ep0uOsAzuIGXH1b8RzLWsdgX7EyFb0958g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X/1/pHnX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=70mgCanu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 23 Apr 2026 10:00:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776931257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1QHhz/9T/OJSzUNvcLNt2BPNKqEWvsL+RnuXLOFLmCg=;
	b=X/1/pHnXryTqG5+FU0N+R447V7bgASn55vlxf48vrunygSA5uPaMl11d0FTcJ5/sVJnKoD
	OCorivR7WWpp7Ia2LkqWs075NQ8YkTtZClZiiNVrRSPLnzdmD6Lr9U4pjbZTYcDgWpY2NG
	6+x8P5rERTgrnGFJukgOodPhyMK7V0agMjNoF5B0bARB3JwAupKaT21t1l/bIsyMipOqXU
	V5+sfT7jbPh+zn/De6Fjs5U0eMGqTPfxCT1NdVNAAFa8PFZKqlQiI6gr5C5YijOnqCBB/n
	QIUyP5Tdgd/p7QSjLIEXJzhJSWLwu49YlWXNGMBkeLLisTOMDIZu+6pVTqz7rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776931257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1QHhz/9T/OJSzUNvcLNt2BPNKqEWvsL+RnuXLOFLmCg=;
	b=70mgCanuAzHj1pzUlzuHVlkQewHCk9OddT90UEm7SFq30YCG2riQapHkjjTWyAHGKAp+hr
	yB8IHHvIee8twdDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	david.lebrun@uclouvain.be, alex.aring@gmail.com,
	stefano.salsano@uniroma2.it, netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: ipv6: fix NOREF dst use in seg6 and rpl
 lwtunnels
Message-ID: <20260423080056.KgHlh9Oa@linutronix.de>
References: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240438-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,goodmis.org,uclouvain.be,gmail.com,uniroma2.it,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniroma2.it:email,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 047C744E502
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-21 11:47:35 [+0200], Andrea Mayer wrote:
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

So the dst passed to skb_dst_set_noref() has no reference count. The fix
is to use skb_dst_force() to increment the refcount on it. But this
requires that we are in the same RCU section. And I guess we are since
none of the warnings are visible.

Doesn't this make ip6_route_input() on RT fragile in general due to the
RT6_LOOKUP_F_DST_NOREF usage or here something special about the two
files that are patched?
Based on your explanation it all makes sense, I am just not sure if this
race is limited to those two are if there is more to it.

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

If having PREEMPT_RT_NEEDS_BH_LOCK unset is the requirement then the
right fixes: would be
Fixes: 3253cb49cbad4 ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")

as prior this commit the race is not possible, right?

Does this mean that rpl_input() does a local_bh_disable() while
obtaining the dst but it never runs outside of bh-disabled section?
Because if it can run in preemptible context then it would not be to
PREEMPT_RT at which point the Fixes: tags from above would make sense
again.

> Cc: stable@vger.kernel.org
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>

Sebastian

