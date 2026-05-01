Return-Path: <stable+bounces-242440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E8qHGC09Gk4DwIAu9opvQ
	(envelope-from <stable+bounces-242440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:10:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D6B4AD1E2
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 16:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8A913014C3A
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD5E3C061A;
	Fri,  1 May 2026 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owYELWbU"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DDB1C84AB
	for <stable@vger.kernel.org>; Fri,  1 May 2026 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644588; cv=none; b=N2LHS+MvCxWoY+WLzn1YrA7xAroy+NpnAeTX30kbd331CAoxYGvPyisqKB+tJ+qetbPQR59AfAa67BuqlYRgpdfhDJY8bPYnkHA4iS3fwuvSHs/++Msw21LQVvqKxmGJqF7LvrjoDnU+i+258qfQzLzilC0WHoc+G51z1WTnK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644588; c=relaxed/simple;
	bh=/OrMxPCyOD1rXzCRz26nrqaa980nwBJdGqPGFsI+8QM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Kxr4OEX8SeOwmyAOwYEpmXf//dRtNlhAYKfSm3yFNOPYN4Sm5tWtV6ttyFmB1nKmF+LB4jkbDRulAAdqdsPYMawW7hVlfdzHld7lFtcnecSvVHdhQgJt7telZfm+r8di1kMwu1dOZpC/9IqImWmpNsGvjwZAq00Kh138dACAIHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=owYELWbU; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bd5c773ef3so19799397b3.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777644586; x=1778249386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naG0VHj9sEI1e5yJEOv+qDodVUJyEMefzNkfvw511o4=;
        b=owYELWbUIrKAHlwp1w9zk8iHwUYljTakDCjYxNb2xE4/Lw2jYrQt0qRNrkDc24hfOk
         xpN4+JSMnpmxmFF529+Okyg2ieSjCwr14x8W0yEuGTT6EpjUQlNZsRk4rSXDOZmlqDxB
         8Fk95F/YSoPRVx+TxSrLThpT/sBQZvMfIh/t8+dawuuDUhKhPQ4lst02N4k8gubFcFjS
         ezl+Uzr1OkmPFIIIZsAn2X0v/7Gn27qFEmcF+6ziHyEH3ZDgndYpKdW2x1ORyxQrcbqg
         WOECJJfUy8d+cQOQ/yvEhFVDCfliWpeVcBQyTLOjwuE+j7icLfnT/2gnVSlOmofiXD+m
         5cXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777644586; x=1778249386;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=naG0VHj9sEI1e5yJEOv+qDodVUJyEMefzNkfvw511o4=;
        b=plMJUvaw9eKqN8fIMHOitC4TmaD1V1e6/h5bvEZ1xYk5GnRWUvzQZmWnW7LXLSd0Y1
         yZqCJ20kTIn0oLPUjnKf1vcqJ+gos2Svdmv0bVmlc/FJNRwDWrhkmCE7qZeBSSNejvcC
         JNr6Kso7eTifEGUknbNcO+3GaU16V2CNJjWnrI7I0/u+wzlwbd0iZEWVxINhA8qdZC2X
         fdK2anVaTJNtJ/WHMRifr3eAfmQJ3SqspOtdIsr/dphhoqUKJG5hRVHb9isZvU1Pr3Td
         048WnQLhpxONsfKBqSw/zLKuDGqQDnx2czARI4C1vY4Y3Y8r6DIPryup728ENdI9Ndk/
         BVxA==
X-Forwarded-Encrypted: i=1; AFNElJ/vNiH9r4/pVPzbRtGwCdZZfJ6tEE9BqqbnEg7czedzDNwyisRhLXt4q9SCigNskE+cOl7f4Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfX4XjjVOai/xa5mz3pdZS+PvwF/IKyIzUtN+bZYjkVY6fvfps
	22uwh7vbfYdbqm2ff8bDCGSjJcLh0BR5WdyfGcD9dTGz7W7tpv/zyqu6
X-Gm-Gg: AeBDiethXJ8hDlGmQKEsUOAUpluZrD4zQNBC5rYjN31M/LXg/WHZquuiTtBK+gSLMFr
	vUgXiWpWCC1IaqfImmue2GtXcYxkgbMUYsVvv81SmNl4mLwRJNsWnn56AHv7wmjRZ5rY3i6fZwZ
	6uU9/Jjb3ZMAs/ib8rnvhP6SfrAylhrpPvjIX4SV4l30hSV7fkl82r6P7U2tktYGzhb5sxkuJQZ
	ICXcIMNnWtojytEJI0SzAgnQ54txy9YJcnjwSbcANFQ82xxt317dXkyTIdhfs77+0kQJUErUirt
	F743iONYty5oYRx+Ksxo8+mT3+5rFFFJWZn4IVKFXyID5DNF7FKHUmXR2t364P5vcSTMmuEi4Ew
	D6A0HScb0WS5ioMON1ZWmGJ+FEQkPgiM5RwQMkcp4ylxk45vuW3c/7qydOdsGVmufivBKPbHVSI
	yBzkJERRxRMYnGdGXp57ltdfsQTrFBj1AnsAjVbqKHZqQoygsznFH8tBBUURkS53BkmvHOi/csS
	cBh/crMvhNfAgY=
X-Received: by 2002:a05:690c:c4fa:b0:7ac:24ba:3e61 with SMTP id 00721157ae682-7bd5286ece5mr73018947b3.19.1777644586387;
        Fri, 01 May 2026 07:09:46 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66888cc7sm10973117b3.44.2026.05.01.07.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 07:09:45 -0700 (PDT)
Date: Fri, 01 May 2026 10:09:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 kuba@kernel.org, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 kuznet@ms2.inr.ac.ru, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.36531f369af83@gmail.com>
In-Reply-To: <20260501074130.3532402-1-maoyi.xie@ntu.edu.sg>
References: <20260501074130.3532402-1-maoyi.xie@ntu.edu.sg>
Subject: Re: [PATCH net v4] ipv6: flowlabel: enforce per-netns limit for
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
X-Rspamd-Queue-Id: 12D6B4AD1E2
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
	TAGGED_FROM(0.00)[bounces-242440-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,kernel.org,davemloft.net,ms2.inr.ac.ru,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ntu.edu.sg:email]

Maoyi Xie wrote:
> fl_size, fl_ht and ip6_fl_lock in net/ipv6/ip6_flowlabel.c are file
> scope and shared across netns. mem_check() reads fl_size to decide
> whether to deny non-CAP_NET_ADMIN callers; capable() runs against
> init_user_ns, so an unprivileged user in any non-init userns can
> push fl_size past FL_MAX_SIZE - FL_MAX_SIZE/4 and starve every
> other unprivileged userns on the host.

So previously a single unprivileged user could get 4K - 1K == 3K
entries.

Now it can only get 1K entries even after doubling FL_MAX_SIZE.
The goal of doubling that was to avoid reducing the per-user
limit.

With the expanded limit, unprivileged users collectively can fill 6K
entries. Should the check become that each individual user can only
fill half of this. Keeping the original limit:

const int unpriv_total_limit = FL_MAX_SIZE - (FL_MAX_SIZE / 4);
const int unpriv_user_limit = unpriv_total_limit / 2;

   	if (room <= 0 ||
   	    ((count >= FL_MAX_PER_SOCK ||
  -	      (count > 0 && room < FL_MAX_SIZE/2) || room < FL_MAX_SIZE/4) &&
  +	      (count > 0 && room < FL_MAX_SIZE/2) ||
  +	      room < FL_MAX_SIZE/4 ||
  +	      atomic_read(&net->ipv6.flowlabel_count) >= unpriv_user_limit) &&
   	     !capable(CAP_NET_ADMIN)))

Sorry for not catching this sooner.

> 
> Add struct netns_ipv6::flowlabel_count, bumped and decremented next
> to fl_size in fl_intern, ip6_fl_gc and ip6_fl_purge. The new field
> is placed in the existing 4-byte hole after ipmr_seq, so struct
> netns_ipv6 stays the same size on 64-bit builds.
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
> v4 (this submission, addressing v3 review by Willem):
>     - rephrased the flowlabel_count placement note: dropped the
>       flowlabel_has_excl cacheline argument; replaced with the
>       simpler "fills the existing 4-byte hole after ipmr_seq" fact.
>     - reordered atomic_dec(&...flowlabel_count) to sit immediately
>       after atomic_dec(&fl_size) in ip6_fl_gc and ip6_fl_purge so
>       the pairing is visually obvious. Both decs now happen before
>       fl_free(fl) since fl_free invalidates fl->fl_net. fl_intern
>       was already in this order.
> v3: addressed Willem's review on the private security@ thread;
>     merged FL_MAX_SIZE doubling, dropped test data, moved
>     flowlabel_count near ipmr_seq, inlined fl->fl_net in ip6_fl_gc.
> v2: per-netns counter + cap, sent to security@ as a 2-patch series.
> v1: fix-shape sketch in original disclosure.
> 
>  include/net/netns/ipv6.h |  1 +
>  net/ipv6/ip6_flowlabel.c | 14 ++++++++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
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
> index c92f98c6f..360109cad 100644
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
> @@ -162,8 +162,9 @@ static void ip6_fl_gc(struct timer_list *unused)
>  				ttd = fl->expires;
>  				if (time_after_eq(now, ttd)) {
>  					*flp = fl->next;
> -					fl_free(fl);
>  					atomic_dec(&fl_size);
> +					atomic_dec(&fl->fl_net->ipv6.flowlabel_count);
> +					fl_free(fl);
>  					continue;
>  				}
>  				if (!sched || time_before(ttd, sched))
> @@ -195,8 +196,9 @@ static void __net_exit ip6_fl_purge(struct net *net)
>  			if (net_eq(fl->fl_net, net) &&
>  			    atomic_read(&fl->users) == 0) {
>  				*flp = fl->next;
> -				fl_free(fl);
>  				atomic_dec(&fl_size);
> +				atomic_dec(&net->ipv6.flowlabel_count);
> +				fl_free(fl);
>  				continue;
>  			}
>  			flp = &fl->next;
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



