Return-Path: <stable+bounces-240214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDVgDV6252mu/wEAu9opvQ
	(envelope-from <stable+bounces-240214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 19:39:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CBF43E136
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 19:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 062123016EF3
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2A731AF2D;
	Tue, 21 Apr 2026 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbmcYJb8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BD42236E3
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792818; cv=none; b=KyXzGKqzJJElvfRgNxajILvWnIUVrQeG++hp2g6nH/jpBz6S3AozyME2ok5lQELCJv0sdKfmshm9gA34KUy0FOBqFzlfzJKZ5QBfClNY4GrAQ+SeOq6WdfOVEApKyRu+AKq6uAj22nJZW4MbrUaNUwSRV0wV0zEz5aSp1x1s5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792818; c=relaxed/simple;
	bh=/scXEeQaRN4B/NeF1PUsl2czhaClwcX6Cf0nOChKG7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rsQ7m2EExC41gbGf+vyBg10tMnG3nq4VBNEe0ldsXgPAMoK3BHA8QFPRENqoLLIGMieLf05BAt5qRztOAKBdF53O6tn3prN6MrzkND8H2XfpCszQUTMLyFkYKEoawaw56VZBlRCh+xyqE1znfuBK8ihp8d88pcWviSJY2zC1Nsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbmcYJb8; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ba922426c5cso286041866b.3
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 10:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776792815; x=1777397615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DoCWrohdiik85XEdHlXUw0nj/jBXY1QzvkY+M7xyZZ4=;
        b=DbmcYJb8H7k+fsq8ScvYfPAIn69IO2kaxdhnOqw8CtGjvewOR3pEAVd14DYY4rYnPg
         2fWbGVLFu0wPXftCrPMXII+KsvOLDNI3siMK7l3FRhozP8pc06+LHD0pBH9Z2CUrzsNe
         a0Ie/zDXKXZaJnJO4gwaiG2zFJ7+k3MK/bYwO9qR40UTk9Q+bCf0Gk0pfUSITjtLGZvv
         5+/N3DDHupTOApEqOiq874Ke3CpQ7VCEw1SNEUUAQeqQOBwWpEp0JAqXd4Hgwix12CFN
         Zj/CZ1gqr5SsTacJxlCMq/4xhAWI4Fud0bYyqs4m1SKAxJLk1YH+Yie6v2oGZ1taU8t/
         lNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776792815; x=1777397615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DoCWrohdiik85XEdHlXUw0nj/jBXY1QzvkY+M7xyZZ4=;
        b=XYDZvz0KVnDW1Cgp2yJ9D6ufgNoiRMJKBWz3tJHsIkIz+UaGdPP1LaTAyNshqVX52U
         PUy/dJKXvTesrweGG99jDUk8ADx8PjA6DsinCtSzF6W7p/ejwRJ8TE9VeeWo+CsC5+G5
         6iSOMrW09b8sJgYUOVOeyeeh2nS3iWVPlJbeKIc4M40SZQOnB38mBB5UJvnDSsKDgbpj
         qTcP5NyXHxOQUWxS1gQQDtDRGg6ePRa7R96tHkLFXipDVyqp7XzbJ/eHon6PIEB0tvLY
         ZT1UYKCUfyncUXoCucgM2WrG+WSGe8RLGVPdH9DDPexml3XgFDypCqf/GMXpEOzidvRq
         K7IA==
X-Forwarded-Encrypted: i=1; AFNElJ/WXhXlhYAFHjveUF7Nbk/qplNA6UVMlYrqCAK2SVsXueEu+fN5N8L//b1n4KHzuJBhJXik0IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyirewgrlebmUhl0Fi1Pw7xOeh3txmTITLEswTyXvy58wHHFmYk
	nhzwoF51T48+gB29nuhvSJeQPRcZsYx07DiwWEv6HHvDdRHNI9lnZOwx
X-Gm-Gg: AeBDietIh8Wx8H/VBDJmOBaV2anmVGH1tNVnHuzeDjkEwBPpNbuCQqz4JlA4PsCWZv2
	onsHx/yP0a3ef0SfhDPUH/5ftVxI350yxUrTSsen9dQWkKjJUeLKCTUiNXhv9G4xPk4b0HRx/6r
	8lcZMLN8siZeGv5qMbkQ+M5nHCDjE42pqJPi10v90w/5CZR2yXpu4vtXSUm/zjhoyNysnFYTBFX
	DCWMtv4ivnodXdF56KEUZluvXK67yJt7eyRqps9LWkX108+nJs37L3HKg7ht9EYvg/QNhC29C2L
	ze0lH3yFfxaWZJQxYfEd8MBBc2D+69pw4cNJOOIIYYwmB8otifRn0h7YI7MT7H1ZF9WnUp9usY/
	+XIGIEMxAi2/GVpo1nJam/PENigVrpz43UCStVI/05Q4ZEAtIwrQtvWDUqgllMFPXnVrhPzX/Db
	t79rQy82USZQGV6+bemWTmE1Ebbm3NUz8EWu9dY+kQtPuQKeWRgoIQDjujhX4hpMZ+SrikPYlQe
	t4XihWuG2wD+yIDgyZndY78394=
X-Received: by 2002:a17:907:ea6:b0:b96:f6f1:e7af with SMTP id a640c23a62f3a-ba41916eb4dmr907537666b.9.1776792814542;
        Tue, 21 Apr 2026 10:33:34 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:7546:18b7:2c8c:e879? ([2a02:a03f:a75e:9a00:7546:18b7:2c8c:e879])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4519ee4adsm469401966b.19.2026.04.21.10.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 10:33:34 -0700 (PDT)
Message-ID: <8ce64ee4-dce1-4052-9558-61c97121cc37@gmail.com>
Date: Tue, 21 Apr 2026 19:33:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ipv6: fix NOREF dst use in seg6 and rpl
 lwtunnels
To: Andrea Mayer <andrea.mayer@uniroma2.it>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 david.lebrun@uclouvain.be, alex.aring@gmail.com,
 stefano.salsano@uniroma2.it, netdev@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260421094735.20997-1-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240214-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,kernel.org,goodmis.org,uclouvain.be,gmail.com,uniroma2.it,vger.kernel.org,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniroma2.it:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87CBF43E136
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 11:47, Andrea Mayer wrote:
> seg6_input_core() and rpl_input() call ip6_route_input() which sets a
> NOREF dst on the skb, then pass it to dst_cache_set_ip6() invoking
> dst_hold() unconditionally.
> On PREEMPT_RT, ksoftirqd is preemptible and a higher-priority task can
> release the underlying pcpu_rt between the lookup and the caching
> through a concurrent FIB lookup on a shared nexthop.
> Simplified race sequence:
> 
>    ksoftirqd/X                       higher-prio task (same CPU X)
>    -----------                       --------------------------------
>    seg6_input_core(,skb)/rpl_input(skb)
>      dst_cache_get()
>        -> miss
>      ip6_route_input(skb)
>        -> ip6_pol_route(,skb,flags)
>           [RT6_LOOKUP_F_DST_NOREF in flags]
>          -> FIB lookup resolves fib6_nh
>             [nhid=N route]
>          -> rt6_make_pcpu_route()
>             [creates pcpu_rt, refcount=1]
>               pcpu_rt->sernum = fib6_sernum
>               [fib6_sernum=W]
>             -> cmpxchg(fib6_nh.rt6i_pcpu,
>                        NULL, pcpu_rt)
>                [slot was empty, store succeeds]
>        -> skb_dst_set_noref(skb, dst)
>           [dst is pcpu_rt, refcount still 1]
> 
>                                      rt_genid_bump_ipv6()
>                                        -> bumps fib6_sernum
>                                           [fib6_sernum from W to Z]
>                                      ip6_route_output()
>                                        -> ip6_pol_route()
>                                          -> FIB lookup resolves fib6_nh
>                                             [nhid=N]
>                                          -> rt6_get_pcpu_route()
>                                               pcpu_rt->sernum != fib6_sernum
>                                               [W <> Z, stale]
>                                            -> prev = xchg(rt6i_pcpu, NULL)
>                                            -> dst_release(prev)
>                                               [prev is pcpu_rt,
>                                                refcount 1->0, dead]
> 
>      dst = skb_dst(skb)
>      [dst is the dead pcpu_rt]
>      dst_cache_set_ip6(dst)
>        -> dst_hold() on dead dst
>        -> WARN / use-after-free
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
> ---
>   net/ipv6/rpl_iptunnel.c  | 9 +++++++++
>   net/ipv6/seg6_iptunnel.c | 9 +++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
> index c7942cf65567..4e10adcd70e8 100644
> --- a/net/ipv6/rpl_iptunnel.c
> +++ b/net/ipv6/rpl_iptunnel.c
> @@ -287,7 +287,16 @@ static int rpl_input(struct sk_buff *skb)
>   
>   	if (!dst) {
>   		ip6_route_input(skb);
> +
> +		/* ip6_route_input() sets a NOREF dst; force a refcount on it
> +		 * before caching or further use.
> +		 */
> +		skb_dst_force(skb);
>   		dst = skb_dst(skb);
> +		if (unlikely(!dst)) {
> +			err = -ENETUNREACH;
> +			goto drop;
> +		}
>   
>   		/* cache only if we don't create a dst reference loop */
>   		if (!dst->error && lwtst != dst->lwtstate) {
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 97b50d9b1365..94284b483be0 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -515,7 +515,16 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>   
>   	if (!dst) {
>   		ip6_route_input(skb);
> +
> +		/* ip6_route_input() sets a NOREF dst; force a refcount on it
> +		 * before caching or further use.
> +		 */
> +		skb_dst_force(skb);
>   		dst = skb_dst(skb);
> +		if (unlikely(!dst)) {
> +			err = -ENETUNREACH;
> +			goto drop;
> +		}
>   
>   		/* cache only if we don't create a dst reference loop */
>   		if (!dst->error && lwtst != dst->lwtstate) {

Thanks for taking care of this, Andrea! LGTM.

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

