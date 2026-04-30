Return-Path: <stable+bounces-242111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHIyEqpd82lT1wEAu9opvQ
	(envelope-from <stable+bounces-242111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:48:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C944A3A7F
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE53830A0484
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0429428485;
	Thu, 30 Apr 2026 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1nzT3m1"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09156428461
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556556; cv=none; b=mWPHgT40R60RCNthMHBhT/LPXjGHgyN/e52hpV+wJ+g//GA37gk581rNTg9CxHhdVyYRMDHU8O6ph3lxrpXeHakb7JOqK7RQQx1ltoIpIkQwsIC8aZc1SOz3CtM5PVxf2Qr9fneQGiMq3bVxh+lEqUvK1uNvrXkxaCqe3cuQhNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556556; c=relaxed/simple;
	bh=p+0xVnC70FkHlSWh+TSyInhUCXNzmzpj2WMvVbWW9WY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kL3gf6liumz+oeO/usHYwEg8Zp+AVGC3pFImMThQUBEQxX5MRIMvi9RvAotvfTp8pO80Di294n779Gff/MhbUrz9fRQlIq53EIrFsY0kqxtPRzrUWR0zksxUqYtrHOn3Yewvb1F8cRFc8ip5XoIWuNx3CxRaXhvIdWNNVCj1y/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1nzT3m1; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7a4f9cf2b4eso7762737b3.3
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 06:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777556554; x=1778161354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbVC2sKNQ4Hzomby+VyJRtT5pGp6CiD57qLKajPfvaM=;
        b=b1nzT3m1I/obximYmcU/LCB6u2Q38lY8wr23A5nfAA1tEFgGEFlD3pQzkZ42s0lGWo
         FUHKaaR9/LMhUbr+8RtJFBsqu+qmyE/5bvV49Ul2lBxGJIdWDPtkIHsAgQ1JBab4DFiH
         BpSr5FJn/7W9iSqgm0LqGHxPwRHp34VJgIkwCHunlov/x6JrU3eI9wxm9nToRC8yAoZU
         IsBCszg6CcPSKrO9ebNxrQ3CNWHJB9WKBrvD9tRFrOQr84KaoOVJ+j5zASp8ns3ClnRu
         ptmDnEc/DnsB8D+Y+OopEiz2HcKz2/+H+rB9tmNCvHXcc/UkuOdt0eUzTuh4UD8m7HBk
         497g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777556554; x=1778161354;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbVC2sKNQ4Hzomby+VyJRtT5pGp6CiD57qLKajPfvaM=;
        b=mdZVqw85qkSrRyzbPhIrdsxMPxIluED2TsTUjSd+XX4slZvqqVhJsIPTej+Bgs2nIE
         UaH0qXCArNCLGz3PBr+v0B6RSVr9i9HAQKBXgtcIi8w4tEnRHXFWA2bU8wJLdyLnx6j/
         opIeXPj9p85BQJMRnpDQok/Lfq0jvcrTpHCOowKA+nEEtbcX+G9Mbdah9YkWuPxuAddi
         UPP3Kf+XRKzubf5lBPZfiJZCZUUDBV5EmFQiheNliJ1VymwJl2NaI2yQs/TGGdgLn3O9
         JXInYp4AJGf2JcjZ81NbNt9tFBsyTE1+tokhHjcv91v+22CtKf0bG0gXVtsMUkyhEjuj
         124A==
X-Forwarded-Encrypted: i=1; AFNElJ8AJ13sH00G61TgaOYFrlYXwu1BY+MBE3Juz46j4FV+FJ/aQXUXbY0d/bkf1ak7FwtXT4WpCe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzon7xS681IrNNWtNLrpx1T39Q8mESdBtbwNMvYgQjkKirTDF8Z
	FS7ePtHcD1tnICiD82tMnnedWeIN3SIgSYV3ZL5BEXkUm/EzplyDqy5p
X-Gm-Gg: AeBDietFretB0E8CKTVOo8NbhQ/LOj4z8E19AjmTVLUlV1P5lh9RSU/TRrOBVx5ySNu
	8KuiYp0ZApLWH1scy2lir/ckIS5lqyZNOd2F8Rps5ExoC0TAKbM0bOr1IYGrnj0ceQLWv27HUxB
	hVHMPikuVsx+o1SI/sGQIf7dc+AD7c4RLmRa0JuY2y1ZRqnIQsNID4urouMr1+/TWt/XB+NUtqU
	XdYvmPylCmMhzZ7BH9DchBYNCut8vJiAPv4q38jqhAh+4y76C5AwfoeYJFtJnKiIzv5rhT0Issk
	feGySZ3iB61NYASflZs7YX7d4QOswKYLVoToMIScB9l9levLb+vUf2GTylHw22oj7B1ElJu77fC
	qWLlAenD4BVHGsh8msAo29f6jGAfjPiah+xuvdJ3FegU+4Al20l3eLqxrRnf0VjgrpxGvTj8u8y
	IagfRLzSDucVpPEdlXIKNkvJnIe4otMbtkEgWInrO8jaYfKwT8qeixW0Pc5seLOhPeQHI/bGulh
	IbO4nlAEA/IahQ=
X-Received: by 2002:a05:690c:6501:b0:7ba:ded4:df58 with SMTP id 00721157ae682-7bd52ac73eemr28499937b3.49.1777556553877;
        Thu, 30 Apr 2026 06:42:33 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd54b332fcsm8737207b3.16.2026.04.30.06.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 06:42:33 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:42:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemb@google.com, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 kuba@kernel.org, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 kuznet@ms2.inr.ac.ru, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 security@kernel.org
Message-ID: <willemdebruijn.kernel.2674e48b8c343@gmail.com>
In-Reply-To: <20260430081608.3137365-1-maoyixie.tju@gmail.com>
References: <20260430081608.3137365-1-maoyixie.tju@gmail.com>
Subject: Re: [PATCH net v3] ipv6: flowlabel: enforce per-netns limit for
 unprivileged callers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D2C944A3A7F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242111-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:email]

Maoyi Xie wrote:
> From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> 
> fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are file
> scope and shared across netns. mem_check() reads fl_size to decide
> whether to deny non-CAP_NET_ADMIN callers; capable() runs against
> init_user_ns, so an unprivileged user in any non-init userns can
> push fl_size past FL_MAX_SIZE - FL_MAX_SIZE/4 and starve every
> other unprivileged userns on the host.
> 
> Add struct netns_ipv6::flowlabel_count, bumped and decremented next
> to fl_size in fl_intern, ip6_fl_gc and ip6_fl_purge. Place it near
> ipmr_seq rather than next to flowlabel_has_excl: flowlabel_has_excl
> is read on every flowlabel lookup, and a counter written on every
> alloc would dirty its cacheline.

The cacheline point is more about truly ipv6 hot path fields. This
entire explicit flowlabel mgmt is not that.

Did this new location fill a 4B hole? (on 64b builds)

> 
> mem_check() folds an extra FL_MAX_SIZE/8 ceiling into the existing
> non-CAP_NET_ADMIN conditional.
> 
> Bump FL_MAX_SIZE from 4096 to 8192. It has been 4096 since the file
> was added; machines and connection counts have grown. The new
> per-netns ceiling is then 1024 flowlabels, half of FL_MAX_SIZE/4.
> 
> CAP_NET_ADMIN against init_user_ns still bypasses both caps.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Suggested-by: Willem de Bruijn <willemb@google.com>
> Cc: stable@vger.kernel.org # v5.15+
> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> ---
> v3 (this submission, netdev): addressed Willem's review on the
>     private security@ thread:
>     - merged the FL_MAX_SIZE doubling into this patch
>     - dropped the test data block from the commit body
>     - moved flowlabel_count to a 4-byte hole next to ipmr_seq, off
>       the flowlabel_has_excl cacheline
>     - inlined fl->fl_net in ip6_fl_gc (no local var)
> v2: per-netns counter + cap, sent to security@ as a 2-patch series
> v1: fix-shape sketch in original disclosure
> 
>  include/net/netns/ipv6.h |  1 +
>  net/ipv6/ip6_flowlabel.c | 10 ++++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
> index 34bdb1308..329482373 100644
> --- a/include/net/netns/ipv6.h
> +++ b/include/net/netns/ipv6.h
> @@ -119,6 +119,7 @@ struct netns_ipv6 {
>  	struct fib_notifier_ops	*notifier_ops;
>  	struct fib_notifier_ops	*ip6mr_notifier_ops;
>  	unsigned int ipmr_seq; /* protected by rtnl_mutex */
> +	atomic_t		flowlabel_count;
>  	struct {
>  		struct hlist_head head;
>  		spinlock_t	lock;
> diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
> index c92f98c6f..4a5219356 100644
> --- a/net/ipv6/ip6_flowlabel.c
> +++ b/net/ipv6/ip6_flowlabel.c
> @@ -36,7 +36,7 @@
>  /* FL hash table */
>  
>  #define FL_MAX_PER_SOCK	32
> -#define FL_MAX_SIZE	4096
> +#define FL_MAX_SIZE	8192
>  #define FL_HASH_MASK	255
>  #define FL_HASH(l)	(ntohl(l)&FL_HASH_MASK)
>  
> @@ -162,6 +162,7 @@ static void ip6_fl_gc(struct timer_list *unused)
>  				ttd = fl->expires;
>  				if (time_after_eq(now, ttd)) {
>  					*flp = fl->next;
> +					atomic_dec(&fl->fl_net->ipv6.flowlabel_count);
>  					fl_free(fl);
>  					atomic_dec(&fl_size);

nit: can you place these consistently immediately after the fl_size
operations, to make clear that they are paired.

>  					continue;
> @@ -195,6 +196,7 @@ static void __net_exit ip6_fl_purge(struct net *net)
>  			if (net_eq(fl->fl_net, net) &&
>  			    atomic_read(&fl->users) == 0) {
>  				*flp = fl->next;
> +				atomic_dec(&net->ipv6.flowlabel_count);
>  				fl_free(fl);
>  				atomic_dec(&fl_size);
>  				continue;
> @@ -245,6 +247,7 @@ static struct ip6_flowlabel *fl_intern(struct net *net,
>  	fl->next = fl_ht[FL_HASH(fl->label)];
>  	rcu_assign_pointer(fl_ht[FL_HASH(fl->label)], fl);
>  	atomic_inc(&fl_size);
> +	atomic_inc(&net->ipv6.flowlabel_count);
>  	spin_unlock_bh(&ip6_fl_lock);
>  	rcu_read_unlock();
>  	return NULL;
> @@ -464,6 +467,7 @@ fl_create(struct net *net, struct sock *sk, struct in6_flowlabel_req *freq,
>  
>  static int mem_check(struct sock *sk)
>  {
> +	struct net *net = sock_net(sk);
>  	int room = FL_MAX_SIZE - atomic_read(&fl_size);
>  	struct ipv6_fl_socklist *sfl;
>  	int count = 0;
> @@ -478,7 +482,9 @@ static int mem_check(struct sock *sk)
>  
>  	if (room <= 0 ||
>  	    ((count >= FL_MAX_PER_SOCK ||
> -	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
> +	      (count > 0 && room < FL_MAX_SIZE/2) ||
> +	      room < FL_MAX_SIZE/4 ||
> +	      atomic_read(&net->ipv6.flowlabel_count) >= FL_MAX_SIZE/8) &&
>  	     !capable(CAP_NET_ADMIN)))
>  		return -ENOBUFS;
>  
> -- 
> 2.34.1
> 



