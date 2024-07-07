Return-Path: <stable+bounces-58186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13341929908
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 18:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434BE1C20D4D
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 16:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF86A332;
	Sun,  7 Jul 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2Bozkz0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEDA61FF6;
	Sun,  7 Jul 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371529; cv=none; b=PRGiWD7mfNj/lfLf0EFzixQR/rujmvA/M0+oxOOLwTLj3mLvgoJaT+tOP2p6Rx3hA6pFfxqwiP8MPbJhe6RPZ8cqDB4JUpXvqfTG2tiXBDVtCBYWQWNnFu0H7fu7bgMWrixqQs+0pkspEWmtmk08SmDQQfUTN7aIa9ePYqxofI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371529; c=relaxed/simple;
	bh=bFOfg9DCQRNJqgkYrAa01kEpXfWJpHqF/D86SoHqwOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQ+8wW71uWaUPyGVHJWzJnG0Pwa/2hC5cW+UO66fu++6JRk2ZPJBbu1Mh78f35hu8oPsxOjcDw5IRFFcDCuCg1rNtE/4K0HLnCTAE01ntPsJoBVyDI9IXgDw0oHFnQDeDS8nn4W910F5vOgVMHJ69RDEOd0g7DlxspFy0c2bz+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2Bozkz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E93DC3277B;
	Sun,  7 Jul 2024 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720371529;
	bh=bFOfg9DCQRNJqgkYrAa01kEpXfWJpHqF/D86SoHqwOg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=u2Bozkz03mxeSBvm8SF3gYpvOyyBkLxEcZXvh3f5Vvio/ed6pvkpIuxAas38fnECk
	 weV3GMW5SoZLbVZlwqPui/ie5pQfyZWhWJeoLlnA8wmqApY7mpjIbi6fGRW5LLTmka
	 UeqrM3IWYLV724rvNhNfb7WjwffePIUChOlmh0XK6VszmWYliMhmH7bn1Crik9x/dS
	 pF2HiN/bcq8N5BZF+ezqul87C8jb+euB9knGiixaj62ML+uFaE8A3i3JYJKghXS5xe
	 o8/2r+AMeqgEsZD6zUaSnxvbyL3Zim2Om7hW+Ra8lwmPbLwQVKATjf/Ioho9JndIfD
	 TOYAony20If8g==
Message-ID: <35638894-254f-4e30-98ee-5a3d6886d87a@kernel.org>
Date: Sun, 7 Jul 2024 10:58:49 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/4] ipv6: fix source address selection with route
 leak
Content-Language: en-US
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
 <20240705145302.1717632-3-nicolas.dichtel@6wind.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240705145302.1717632-3-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/5/24 8:52 AM, Nicolas Dichtel wrote:
> diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
> index a18ed24fed94..a7c27f0c6bce 100644
> --- a/include/net/ip6_route.h
> +++ b/include/net/ip6_route.h
> @@ -127,18 +127,23 @@ void rt6_age_exceptions(struct fib6_info *f6i, struct fib6_gc_args *gc_args,
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
> +	rcu_read_lock();
> +	l3mdev = dev_get_by_index_rcu(net, l3mdev_index);
> +	dev = f6i ? fib6_info_nh_dev(f6i) : NULL;
> +	same_vrf = l3mdev == NULL || l3mdev_master_dev_rcu(dev) == l3mdev;

!l3mdev; checkpatch should complain

> +	if (f6i && f6i->fib6_prefsrc.plen && same_vrf)
>  		*saddr = f6i->fib6_prefsrc.addr;
> -	} else {
> -		struct net_device *dev = f6i ? fib6_info_nh_dev(f6i) : NULL;
> -
> -		err = ipv6_dev_get_saddr(net, dev, daddr, prefs, saddr);
> -	}
> +	else
> +		err = ipv6_dev_get_saddr(net, same_vrf ? dev : l3mdev, daddr, prefs, saddr);
> +	rcu_read_unlock();
>  
>  	return err;
>  }

lot of logic lines jammed together. put a new line after the read_lock()
and before the unlock().



