Return-Path: <stable+bounces-54961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF017913EA6
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 23:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27721C20BE5
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 21:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB8B185090;
	Sun, 23 Jun 2024 21:56:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263EF2F24
	for <stable@vger.kernel.org>; Sun, 23 Jun 2024 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719179784; cv=none; b=ItAzceh9ZzM7Fupu2iBXQoMqvQGS/ELe6N0fI9BnyC1F6CsCUFzgdbYRJQ7g20cbaGJ6TWJay6PiRCEb8n8zLNSpZsAX8uCu6aO9wbrxUhktRXgI4rb+0wyk0G35N5+okP4A+joH159fiTgbWkcKHbVhRoSx5cRItY3IG5pZHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719179784; c=relaxed/simple;
	bh=0SofmzLA8abpPlU2xRUR1GKD2TI5OBacnt5Afe9NDwA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWL+TKP6cDDYvLzAccUT9q9FIpccW0bPvOXNfe6Ng6R5fQ1iVXMnJqQW98hJdeai1c3knh1KS1PtHwsjpAQqHR1htqmlbHODBnbXrwoJKLBdR7El+DsaIeOfPgn78jo5KpM391qtMER8SbziB9iCXYqs99a3+9ka9gPNzQVWnS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=44500 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sLVBw-003vvR-Ug
	for stable@vger.kernel.org; Sun, 23 Jun 2024 23:56:11 +0200
Date: Sun, 23 Jun 2024 23:56:08 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: stable@vger.kernel.org
Subject: Re: Patch "netfilter: ipset: Fix suspicious
 rcu_dereference_protected()" has been added to the 6.9-stable tree
Message-ID: <ZniZ-PxADNomK8E4@calendula>
References: <20240622234125.195700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240622234125.195700-1-sashal@kernel.org>
X-Spam-Score: -1.8 (-)

Hi

Side note: This fix requires

        4e7aaa6b82d6 ("netfilter: ipset: Fix race between namespace cleanup and gc in the list:set type"

in first place, as a dependency.

Thanks

On Sat, Jun 22, 2024 at 07:41:24PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     netfilter: ipset: Fix suspicious rcu_dereference_protected()
> 
> to the 6.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      netfilter-ipset-fix-suspicious-rcu_dereference_prote.patch
> and it can be found in the queue-6.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 0226dfa53edc90463c1b0d50167da948c88025ef
> Author: Jozsef Kadlecsik <kadlec@netfilter.org>
> Date:   Mon Jun 17 11:18:15 2024 +0200
> 
>     netfilter: ipset: Fix suspicious rcu_dereference_protected()
>     
>     [ Upstream commit 8ecd06277a7664f4ef018abae3abd3451d64e7a6 ]
>     
>     When destroying all sets, we are either in pernet exit phase or
>     are executing a "destroy all sets command" from userspace. The latter
>     was taken into account in ip_set_dereference() (nfnetlink mutex is held),
>     but the former was not. The patch adds the required check to
>     rcu_dereference_protected() in ip_set_dereference().
>     
>     Fixes: 4e7aaa6b82d6 ("netfilter: ipset: Fix race between namespace cleanup and gc in the list:set type")
>     Reported-by: syzbot+b62c37cdd58103293a5a@syzkaller.appspotmail.com
>     Reported-by: syzbot+cfbe1da5fdfc39efc293@syzkaller.appspotmail.com
>     Reported-by: kernel test robot <oliver.sang@intel.com>
>     Closes: https://lore.kernel.org/oe-lkp/202406141556.e0b6f17e-lkp@intel.com
>     Signed-off-by: Jozsef Kadlecsik <kadlec@netfilter.org>
>     Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
> index c7ae4d9bf3d24..61431690cbd5f 100644
> --- a/net/netfilter/ipset/ip_set_core.c
> +++ b/net/netfilter/ipset/ip_set_core.c
> @@ -53,12 +53,13 @@ MODULE_DESCRIPTION("core IP set support");
>  MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_IPSET);
>  
>  /* When the nfnl mutex or ip_set_ref_lock is held: */
> -#define ip_set_dereference(p)		\
> -	rcu_dereference_protected(p,	\
> +#define ip_set_dereference(inst)	\
> +	rcu_dereference_protected((inst)->ip_set_list,	\
>  		lockdep_nfnl_is_held(NFNL_SUBSYS_IPSET) || \
> -		lockdep_is_held(&ip_set_ref_lock))
> +		lockdep_is_held(&ip_set_ref_lock) || \
> +		(inst)->is_deleted)
>  #define ip_set(inst, id)		\
> -	ip_set_dereference((inst)->ip_set_list)[id]
> +	ip_set_dereference(inst)[id]
>  #define ip_set_ref_netlink(inst,id)	\
>  	rcu_dereference_raw((inst)->ip_set_list)[id]
>  #define ip_set_dereference_nfnl(p)	\
> @@ -1133,7 +1134,7 @@ static int ip_set_create(struct sk_buff *skb, const struct nfnl_info *info,
>  		if (!list)
>  			goto cleanup;
>  		/* nfnl mutex is held, both lists are valid */
> -		tmp = ip_set_dereference(inst->ip_set_list);
> +		tmp = ip_set_dereference(inst);
>  		memcpy(list, tmp, sizeof(struct ip_set *) * inst->ip_set_max);
>  		rcu_assign_pointer(inst->ip_set_list, list);
>  		/* Make sure all current packets have passed through */

