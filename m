Return-Path: <stable+bounces-241864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE96JhPm8WlZlAEAu9opvQ
	(envelope-from <stable+bounces-241864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:05:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD52493531
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAC213043FB4
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 11:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB45437CD2E;
	Wed, 29 Apr 2026 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fovEaSBg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="szoRSUeP"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0BF37B41E;
	Wed, 29 Apr 2026 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777460631; cv=none; b=Jr1qmR64pqKRrZblTGBGJXUDH11MSQJpzMPXD+W8pQaHa6VUrSOIsss1duk9rQ9wSUCQBGeoD2w3yc4r8gNegpaseNdrFRSzWCANkOpYLd/VdCaMsqGcoYnJeijH27olgEzXoXizBdcA04Ux0x62pJ8qaobvBbM77S8FPvR1xow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777460631; c=relaxed/simple;
	bh=cZm9nR+23JyzHvmYbF8V/WFjTR5KWk6Lw1WGUxgsGiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bz/8GIvjyvQYLVzjM4KY2YRG8AIDTz1DCyJl0JT/ac+b5Muye3NUUjvy7Jedhs1U89sJ7jTaWidvOB78xIABXxSaf+7FLoeA7LgG5gFFVtKLTE7fgqOWcrff6A/aWrxO9xUMCuTCH2LI2Ff7vSlKPKPFH0wk+CxQdRot0uKlQ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fovEaSBg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=szoRSUeP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Apr 2026 13:03:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777460623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/UriPQL6XaAfr9C928OrjNsarnff/ygNYveY3BfmJUU=;
	b=fovEaSBgw8CLKbrAl+inoruy1DmI0GtoxZZT07CGZS8c6l+X3UuNBxBofjtAEDabweP2/y
	KjQjdR89BDFFPytegFrnuzVtF8Lxq8SPgiMVikEGlDpqE0g79C2/aW58pVx8vzh7wMr10/
	8kcsJNOGbnTyujniIES4YF+YyxPCHHib/01nYXrSPaD4HEWuR5kCAPvuYFI/dsi4PWuMTr
	mUup+Y+N1YrK/biA199fVQy61WYVwQAjzjvZMGnz5zYH0tZ1VYl2/uoB32IpXsPiciPeh4
	fVt+P/Xx76wUH7EPvMu9nXUSbiziF3yKLISFb+b8PhukfTiw7ghvuNrUsJF59w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777460623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/UriPQL6XaAfr9C928OrjNsarnff/ygNYveY3BfmJUU=;
	b=szoRSUeP3wad7j4LOuG6BB4KMNAoF9FUlCkFLnljETLfmh8pQbGxYTXkWzSXvmiUNdqLQW
	uEm+jE0JqhPLOtCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	clrkwllms@kernel.org, rostedt@goodmis.org,
	david.lebrun@uclouvain.be, alex.aring@gmail.com,
	Justin Iurman <justin.iurman@gmail.com>,
	stefano.salsano@uniroma2.it, netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: ipv6: fix NOREF dst use in seg6 and rpl
 lwtunnels
Message-ID: <20260429110341.ipXGaamM@linutronix.de>
References: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
 <20260423080056.KgHlh9Oa@linutronix.de>
 <20260425160856.8cebade5eae1dcaec7af8bfe@uniroma2.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260425160856.8cebade5eae1dcaec7af8bfe@uniroma2.it>
X-Rspamd-Queue-Id: 0CD52493531
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241864-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,goodmis.org,uclouvain.be,gmail.com,uniroma2.it,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email,linutronix.de:dkim,linutronix.de:mid]

On 2026-04-25 16:08:56 [+0200], Andrea Mayer wrote:
> On Thu, 23 Apr 2026 10:00:56 +0200
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> Hi Sebastian,

Hi Andrea,

> > Doesn't this make ip6_route_input() on RT fragile in general due to the
> > RT6_LOOKUP_F_DST_NOREF usage or here something special about the two
> > files that are patched?
> > Based on your explanation it all makes sense, I am just not sure if this
> > race is limited to those two are if there is more to it.
> 
> seg6_input_core() and rpl_input() cache the dst via dst_cache_set_ip6(), which
> invokes dst_hold(). The dst_hold() calls rcuref_get(), failing on a zero
> refcount and triggering a WARN, but the pointer is still stored in the cache.
> After the RCU grace period completes the dst is freed, and a subsequent
> dst_cache_get() returns a dangling pointer.
>  
> The other callers of ip6_route_input() (e.g., ipv6_srh_rcv, ipv6_rpl_srh_rcv,
> ip6_rcv_finish_core) consume the NOREF dst without caching it. Even if the
> pcpu_rt's refcount is concurrently dropped to zero, the dst memory remains
> valid because dst_release() defers the actual free via call_rcu_hurry() and the
> caller is still inside the RCU read-side critical section.

Ah, okay. Thank you for clearing that up.

> > > [snip]
> > >
> > > Fixes: af4a2209b134 ("ipv6: sr: use dst_cache in seg6_input")
> > > Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> > 
> > If having PREEMPT_RT_NEEDS_BH_LOCK unset is the requirement then the
> > right fixes: would be
> > Fixes: 3253cb49cbad4 ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")
> > 
> > as prior this commit the race is not possible, right?
> 
> I built and tested kernels at 3253cb49cbad and its parent fd4e876f59b7 (both
> CONFIG_PREEMPT_RT=y, without the fix): no issues at fd4e876f59b7.
> At 3253cb49cbad, a pcpu_rt cmpxchg contention in rt6_make_pcpu_route() shows
> up, which was addressed in 1adaea51c61b. I also tested at 1adaea51c61b, and at
> that point the dst_hold() race described in this patch appears.
>  
> The seg6/rpl code obtains a NOREF dst from ip6_route_input(), does not promote
> it via skb_dst_force(), and passes it to dst_cache_set_ip6() which calls
> dst_hold(). This pattern has been present since af4a2209b134 and a7a29f9c361f,
> and the current Fixes: tags point to the commits where it was introduced.
> Does that seem reasonable?

Yes. So based on that the regression was introduced in 3253cb49cbad.
Before that, the lock guarded everything. That means also that
rpl_input() and seg6_input_core() is invoked a BH disabled section which
is what makes it for !RT work.

> > Does this mean that rpl_input() does a local_bh_disable() while
> > obtaining the dst but it never runs outside of bh-disabled section?
> > Because if it can run in preemptible context then it would not be to
> > PREEMPT_RT at which point the Fixes: tags from above would make sense
> > again.
> > 
> 
> rpl_input() and seg6_input_core() run in softirq context via lwtunnel_input().
> They do local_bh_disable() around dst_cache_get() and dst_cache_set_ip6(), but
> not around ip6_route_input(). The race window is between ip6_route_input()
> returning and dst_cache_set_ip6().

My point was that the Fixes: tag could be updated to 3253cb49cbad
instead. Since everything runs in softirq context, the
local_bh_disable() within that functions is not needed. Otherwise, if
this would not be invoked softirq then preemption would also be possible
on !RT.
Anyway, now it has been merged.

> 
> Ciao,
> Andrea

Sebastian

