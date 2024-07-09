Return-Path: <stable+bounces-58260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F244F92AE74
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 05:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999131F21D65
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 03:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D6A433BE;
	Tue,  9 Jul 2024 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0hRwOzU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152EA4084C;
	Tue,  9 Jul 2024 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720494575; cv=none; b=K1ZR/LQjuG7F7KyzL9J7mql1Ji3rGSzs0ANAfRS2A9dJxdzkzgq2LbAQ4w/1f2arVJBlLCLlvx2AjP7Nzk9Tt7jZfk7KGfi9HqKl3eoFM0SNTUZApUvplxiaPgRujoARnqZZ/EuBvKKKyYTSpPSlD1focrMbBCs2RSNTsMEP88M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720494575; c=relaxed/simple;
	bh=ZyKuM0C9MOQg74AvBjQ2+mhDbPz1ZKUgo05wSnuD/LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmPXqEF8rp9SEbOOUhao8ucMMdwFXngEcnUPcEoMrnnA5XZYbah1lYL7FkDw6QHT3czx9f5CyftNg+38GTawR+Zmt5NRKLDwviVuXGZyxRNuIEwHf1un9LBAN9HUjbE/IwMDWcMPpCP9aS0hQ0KaMN96Ql3EMuNp7++mj6B/s0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0hRwOzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90095C116B1;
	Tue,  9 Jul 2024 03:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720494574;
	bh=ZyKuM0C9MOQg74AvBjQ2+mhDbPz1ZKUgo05wSnuD/LI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S0hRwOzUYfv/be/DGlfHdnzQcsoGcg3JpfU1CnljOuwAHF4dpvFCBneTEiwFgTRwt
	 YnlJGppqSgD/vhJuAkVLGMy/akpv+HfvDqoHQK3leTUEG0PsXZ/CNx31liJPiRqi6u
	 Mz0GaBdZImpVlltTzQfFU5bs+UF1/gYq2ykio9EArdcWrUFUM4xb5HbsV/okLWzDqY
	 dmX+mHP3jonXLNcaUP5H69WT6tDjjJDcOqRHuJSrMEVrt6wvtmBGhnFURyV1imyyMh
	 hjJpGoNzbiaS8T2FnJyuRHkQ776CQNDoDWURv3M9Z+/DeEJwKfYRpPyauPIyl+ULBt
	 adrTCqb9KwS3Q==
Message-ID: <ae54143a-a990-4e7e-90fd-1940cadec4c7@kernel.org>
Date: Mon, 8 Jul 2024 21:09:33 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/4] ipv6: fix source address selection with route
 leak
Content-Language: en-US
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20240708181554.4134673-1-nicolas.dichtel@6wind.com>
 <20240708181554.4134673-3-nicolas.dichtel@6wind.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240708181554.4134673-3-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/24 12:15 PM, Nicolas Dichtel wrote:
> By default, an address assigned to the output interface is selected when
> the source address is not specified. This is problematic when a route,
> configured in a vrf, uses an interface from another vrf (aka route leak).
> The original vrf does not own the selected source address.
> 
> Let's add a check against the output interface and call the appropriate
> function to select the source address.
> 
> CC: stable@vger.kernel.org
> Fixes: 0d240e7811c4 ("net: vrf: Implement get_saddr for IPv6")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  include/net/ip6_route.h | 21 ++++++++++++++-------
>  net/ipv6/ip6_output.c   |  1 +
>  net/ipv6/route.c        |  2 +-
>  3 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> index a18ed24fed94..667f0a517fd0 100644
> --- a/include/net/ip6_route.h
> +++ b/include/net/ip6_route.h
> @@ -127,18 +127,25 @@ void rt6_age_exceptions(struct fib6_info *f6i, struct fib6_gc_args *gc_args,
>  
>  static inline int ip6_route_get_saddr(struct net *net, struct fib6_info *f6i,
>  				      const struct in6_addr *daddr,
> -				      unsigned int prefs,
> +				      unsigned int prefs, int l3mdev_index,
>  				      struct in6_addr *saddr)
>  {
> +	struct net_device *l3mdev;
> +	struct net_device *dev;
> +	bool same_vrf;
>  	int err = 0;
>  
> -	if (f6i && f6i->fib6_prefsrc.plen) {
> -		*saddr = f6i->fib6_prefsrc.addr;
> -	} else {
> -		struct net_device *dev = f6i ? fib6_info_nh_dev(f6i) : NULL;
> +	rcu_read_lock();
>  
> -		err = ipv6_dev_get_saddr(net, dev, daddr, prefs, saddr);
> -	}
> +	l3mdev = dev_get_by_index_rcu(net, l3mdev_index);
> +	dev = f6i ? fib6_info_nh_dev(f6i) : NULL;

dev is only needed in the branch and you are now setting all the time.

> +	same_vrf = !l3mdev || l3mdev_master_dev_rcu(dev) == l3mdev;
> +	if (f6i && f6i->fib6_prefsrc.plen && same_vrf)
> +		*saddr = f6i->fib6_prefsrc.addr;
> +	else
> +		err = ipv6_dev_get_saddr(net, same_vrf ? dev : l3mdev, daddr, prefs, saddr);
> +
> +	rcu_read_unlock();
>  
>  	return err;
>  }

Reviewed-by: David Ahern <dsahern@kernel.org>



