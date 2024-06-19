Return-Path: <stable+bounces-54096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4089390ECAC
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2AF281171
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C6D13F426;
	Wed, 19 Jun 2024 13:09:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0533E146D49;
	Wed, 19 Jun 2024 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802575; cv=none; b=q9FrXM6+NMJ4VJkttXg8XjHw82imB0m5El/0XlInWH36Is/PEQTUhQOC5L//JRt9NLkhCi+dpN9FEWBaoruZHjaXnRDgjNHWDj+9ziOzX2gJcSUKOtjL9m7CVFsIuqf7A18ArTTC/fyk+0hvaofFlrrXE/+V0H5+bc8fTDyr17g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802575; c=relaxed/simple;
	bh=A47JHpogVS1asWaQwf3YfvAu7CsaAEh2pS5ORet8sv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgdGZdSJKPmhqHSLfGv8F5bVrVN/Wz299mb7T/PP3p7buW5ZejJXbajQa/T1R63NK4l/r8T1kjkt4jBGPQ7ugE+b7JHXHpCQ0B8Rm+dEtAOLbIUBf6M29NxTilpdJFBIFUMkzdaYKoQ8J4sN1ZOqVzv4oJkif9811148fUx1tZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=49664 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sJv43-00F3zX-8K; Wed, 19 Jun 2024 15:09:29 +0200
Date: Wed, 19 Jun 2024 15:09:26 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Lion Ackermann <nnamrec@gmail.com>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 156/267] netfilter: ipset: Fix race between namespace
 cleanup and gc in the list:set type
Message-ID: <ZnLYhm9eGtxOOeoF@calendula>
References: <20240619125606.345939659@linuxfoundation.org>
 <20240619125612.331843461@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240619125612.331843461@linuxfoundation.org>
X-Spam-Score: -1.8 (-)

Hi Greg,

Please, hold on with this one patch for ipset until an incremental fix hits upstream.

On Wed, Jun 19, 2024 at 02:55:07PM +0200, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Jozsef Kadlecsik <kadlec@netfilter.org>
> 
> [ Upstream commit 4e7aaa6b82d63e8ddcbfb56b4fd3d014ca586f10 ]
> 
> Lion Ackermann reported that there is a race condition between namespace cleanup
> in ipset and the garbage collection of the list:set type. The namespace
> cleanup can destroy the list:set type of sets while the gc of the set type is
> waiting to run in rcu cleanup. The latter uses data from the destroyed set which
> thus leads use after free. The patch contains the following parts:
> 
> - When destroying all sets, first remove the garbage collectors, then wait
>   if needed and then destroy the sets.
> - Fix the badly ordered "wait then remove gc" for the destroy a single set
>   case.
> - Fix the missing rcu locking in the list:set type in the userspace test
>   case.
> - Use proper RCU list handlings in the list:set type.
> 
> The patch depends on c1193d9bbbd3 (netfilter: ipset: Add list flush to cancel_gc).
> 
> Fixes: 97f7cf1cd80e (netfilter: ipset: fix performance regression in swap operation)
> Reported-by: Lion Ackermann <nnamrec@gmail.com>
> Tested-by: Lion Ackermann <nnamrec@gmail.com>
> Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/netfilter/ipset/ip_set_core.c     | 81 +++++++++++++++------------
>  net/netfilter/ipset/ip_set_list_set.c | 30 +++++-----
>  2 files changed, 60 insertions(+), 51 deletions(-)
> 
> diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
> index 3184cc6be4c9d..c7ae4d9bf3d24 100644
> --- a/net/netfilter/ipset/ip_set_core.c
> +++ b/net/netfilter/ipset/ip_set_core.c
> @@ -1172,23 +1172,50 @@ ip_set_setname_policy[IPSET_ATTR_CMD_MAX + 1] = {
>  				    .len = IPSET_MAXNAMELEN - 1 },
>  };
>  
> +/* In order to return quickly when destroying a single set, it is split
> + * into two stages:
> + * - Cancel garbage collector
> + * - Destroy the set itself via call_rcu()
> + */
> +
>  static void
> -ip_set_destroy_set(struct ip_set *set)
> +ip_set_destroy_set_rcu(struct rcu_head *head)
>  {
> -	pr_debug("set: %s\n",  set->name);
> +	struct ip_set *set = container_of(head, struct ip_set, rcu);
>  
> -	/* Must call it without holding any lock */
>  	set->variant->destroy(set);
>  	module_put(set->type->me);
>  	kfree(set);
>  }
>  
>  static void
> -ip_set_destroy_set_rcu(struct rcu_head *head)
> +_destroy_all_sets(struct ip_set_net *inst)
>  {
> -	struct ip_set *set = container_of(head, struct ip_set, rcu);
> +	struct ip_set *set;
> +	ip_set_id_t i;
> +	bool need_wait = false;
>  
> -	ip_set_destroy_set(set);
> +	/* First cancel gc's: set:list sets are flushed as well */
> +	for (i = 0; i < inst->ip_set_max; i++) {
> +		set = ip_set(inst, i);
> +		if (set) {
> +			set->variant->cancel_gc(set);
> +			if (set->type->features & IPSET_TYPE_NAME)
> +				need_wait = true;
> +		}
> +	}
> +	/* Must wait for flush to be really finished  */
> +	if (need_wait)
> +		rcu_barrier();
> +	for (i = 0; i < inst->ip_set_max; i++) {
> +		set = ip_set(inst, i);
> +		if (set) {
> +			ip_set(inst, i) = NULL;
> +			set->variant->destroy(set);
> +			module_put(set->type->me);
> +			kfree(set);
> +		}
> +	}
>  }
>  
>  static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
> @@ -1202,11 +1229,10 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
>  	if (unlikely(protocol_min_failed(attr)))
>  		return -IPSET_ERR_PROTOCOL;
>  
> -
>  	/* Commands are serialized and references are
>  	 * protected by the ip_set_ref_lock.
>  	 * External systems (i.e. xt_set) must call
> -	 * ip_set_put|get_nfnl_* functions, that way we
> +	 * ip_set_nfnl_get_* functions, that way we
>  	 * can safely check references here.
>  	 *
>  	 * list:set timer can only decrement the reference
> @@ -1214,8 +1240,6 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
>  	 * without holding the lock.
>  	 */
>  	if (!attr[IPSET_ATTR_SETNAME]) {
> -		/* Must wait for flush to be really finished in list:set */
> -		rcu_barrier();
>  		read_lock_bh(&ip_set_ref_lock);
>  		for (i = 0; i < inst->ip_set_max; i++) {
>  			s = ip_set(inst, i);
> @@ -1226,15 +1250,7 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
>  		}
>  		inst->is_destroyed = true;
>  		read_unlock_bh(&ip_set_ref_lock);
> -		for (i = 0; i < inst->ip_set_max; i++) {
> -			s = ip_set(inst, i);
> -			if (s) {
> -				ip_set(inst, i) = NULL;
> -				/* Must cancel garbage collectors */
> -				s->variant->cancel_gc(s);
> -				ip_set_destroy_set(s);
> -			}
> -		}
> +		_destroy_all_sets(inst);
>  		/* Modified by ip_set_destroy() only, which is serialized */
>  		inst->is_destroyed = false;
>  	} else {
> @@ -1255,12 +1271,12 @@ static int ip_set_destroy(struct sk_buff *skb, const struct nfnl_info *info,
>  		features = s->type->features;
>  		ip_set(inst, i) = NULL;
>  		read_unlock_bh(&ip_set_ref_lock);
> +		/* Must cancel garbage collectors */
> +		s->variant->cancel_gc(s);
>  		if (features & IPSET_TYPE_NAME) {
>  			/* Must wait for flush to be really finished  */
>  			rcu_barrier();
>  		}
> -		/* Must cancel garbage collectors */
> -		s->variant->cancel_gc(s);
>  		call_rcu(&s->rcu, ip_set_destroy_set_rcu);
>  	}
>  	return 0;
> @@ -2365,30 +2381,25 @@ ip_set_net_init(struct net *net)
>  }
>  
>  static void __net_exit
> -ip_set_net_exit(struct net *net)
> +ip_set_net_pre_exit(struct net *net)
>  {
>  	struct ip_set_net *inst = ip_set_pernet(net);
>  
> -	struct ip_set *set = NULL;
> -	ip_set_id_t i;
> -
>  	inst->is_deleted = true; /* flag for ip_set_nfnl_put */
> +}
>  
> -	nfnl_lock(NFNL_SUBSYS_IPSET);
> -	for (i = 0; i < inst->ip_set_max; i++) {
> -		set = ip_set(inst, i);
> -		if (set) {
> -			ip_set(inst, i) = NULL;
> -			set->variant->cancel_gc(set);
> -			ip_set_destroy_set(set);
> -		}
> -	}
> -	nfnl_unlock(NFNL_SUBSYS_IPSET);
> +static void __net_exit
> +ip_set_net_exit(struct net *net)
> +{
> +	struct ip_set_net *inst = ip_set_pernet(net);
> +
> +	_destroy_all_sets(inst);
>  	kvfree(rcu_dereference_protected(inst->ip_set_list, 1));
>  }
>  
>  static struct pernet_operations ip_set_net_ops = {
>  	.init	= ip_set_net_init,
> +	.pre_exit = ip_set_net_pre_exit,
>  	.exit   = ip_set_net_exit,
>  	.id	= &ip_set_net_id,
>  	.size	= sizeof(struct ip_set_net),
> diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
> index 54e2a1dd7f5f5..bfae7066936bb 100644
> --- a/net/netfilter/ipset/ip_set_list_set.c
> +++ b/net/netfilter/ipset/ip_set_list_set.c
> @@ -79,7 +79,7 @@ list_set_kadd(struct ip_set *set, const struct sk_buff *skb,
>  	struct set_elem *e;
>  	int ret;
>  
> -	list_for_each_entry(e, &map->members, list) {
> +	list_for_each_entry_rcu(e, &map->members, list) {
>  		if (SET_WITH_TIMEOUT(set) &&
>  		    ip_set_timeout_expired(ext_timeout(e, set)))
>  			continue;
> @@ -99,7 +99,7 @@ list_set_kdel(struct ip_set *set, const struct sk_buff *skb,
>  	struct set_elem *e;
>  	int ret;
>  
> -	list_for_each_entry(e, &map->members, list) {
> +	list_for_each_entry_rcu(e, &map->members, list) {
>  		if (SET_WITH_TIMEOUT(set) &&
>  		    ip_set_timeout_expired(ext_timeout(e, set)))
>  			continue;
> @@ -188,9 +188,10 @@ list_set_utest(struct ip_set *set, void *value, const struct ip_set_ext *ext,
>  	struct list_set *map = set->data;
>  	struct set_adt_elem *d = value;
>  	struct set_elem *e, *next, *prev = NULL;
> -	int ret;
> +	int ret = 0;
>  
> -	list_for_each_entry(e, &map->members, list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(e, &map->members, list) {
>  		if (SET_WITH_TIMEOUT(set) &&
>  		    ip_set_timeout_expired(ext_timeout(e, set)))
>  			continue;
> @@ -201,6 +202,7 @@ list_set_utest(struct ip_set *set, void *value, const struct ip_set_ext *ext,
>  
>  		if (d->before == 0) {
>  			ret = 1;
> +			goto out;
>  		} else if (d->before > 0) {
>  			next = list_next_entry(e, list);
>  			ret = !list_is_last(&e->list, &map->members) &&
> @@ -208,9 +210,11 @@ list_set_utest(struct ip_set *set, void *value, const struct ip_set_ext *ext,
>  		} else {
>  			ret = prev && prev->id == d->refid;
>  		}
> -		return ret;
> +		goto out;
>  	}
> -	return 0;
> +out:
> +	rcu_read_unlock();
> +	return ret;
>  }
>  
>  static void
> @@ -239,7 +243,7 @@ list_set_uadd(struct ip_set *set, void *value, const struct ip_set_ext *ext,
>  
>  	/* Find where to add the new entry */
>  	n = prev = next = NULL;
> -	list_for_each_entry(e, &map->members, list) {
> +	list_for_each_entry_rcu(e, &map->members, list) {
>  		if (SET_WITH_TIMEOUT(set) &&
>  		    ip_set_timeout_expired(ext_timeout(e, set)))
>  			continue;
> @@ -316,9 +320,9 @@ list_set_udel(struct ip_set *set, void *value, const struct ip_set_ext *ext,
>  {
>  	struct list_set *map = set->data;
>  	struct set_adt_elem *d = value;
> -	struct set_elem *e, *next, *prev = NULL;
> +	struct set_elem *e, *n, *next, *prev = NULL;
>  
> -	list_for_each_entry(e, &map->members, list) {
> +	list_for_each_entry_safe(e, n, &map->members, list) {
>  		if (SET_WITH_TIMEOUT(set) &&
>  		    ip_set_timeout_expired(ext_timeout(e, set)))
>  			continue;
> @@ -424,14 +428,8 @@ static void
>  list_set_destroy(struct ip_set *set)
>  {
>  	struct list_set *map = set->data;
> -	struct set_elem *e, *n;
>  
> -	list_for_each_entry_safe(e, n, &map->members, list) {
> -		list_del(&e->list);
> -		ip_set_put_byindex(map->net, e->id);
> -		ip_set_ext_destroy(set, e);
> -		kfree(e);
> -	}
> +	WARN_ON_ONCE(!list_empty(&map->members));
>  	kfree(map);
>  
>  	set->data = NULL;
> -- 
> 2.43.0
> 
> 
> 

