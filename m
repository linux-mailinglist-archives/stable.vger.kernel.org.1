Return-Path: <stable+bounces-58185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AC7929902
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 18:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B17B21008
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35059524C4;
	Sun,  7 Jul 2024 16:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHu9orTj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B392A1B2;
	Sun,  7 Jul 2024 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371526; cv=none; b=VbCLxsUo7yP5sT9cT2vP7hdWzoDV3SXMGgDHRkW/b7jmpburru38xDBcFF4ifZKqo6flmD89Cn6sbOs+B0vEqdIZHXmXPdRx1KLvrO5nwZhCz/hhtqyOdCDkA/RxaFxzl1kdgvIkyHXXmy6wJYSx/ezQ/a7nCjfw3EFJDsgXe5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371526; c=relaxed/simple;
	bh=ek8/PkDSfiE6Y3MGzufPXapUFp3Uy2m2SAILQOHoRg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NY/Po+hx97jK4/rnPiq4LDM2rQls4QlUx7Ia5P8y+b+aGDqvds1OIwZ4d8h2IKjiovnEA1YL3eMwm3hvRk7j/bvHWaL+B8bylkWxaRjI3R9MNV5Ojs820NHuB0MSw9FG57gIx3UCFHcyRcAULnpmhywgaNY2we6E15ZdMH12tww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHu9orTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF59C32781;
	Sun,  7 Jul 2024 16:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720371525;
	bh=ek8/PkDSfiE6Y3MGzufPXapUFp3Uy2m2SAILQOHoRg0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PHu9orTjPzajx5QmAgUfMKlcPNKQ/fY4i+EgLvcmhesCuOR5EM0zkdlMRnu38MAjq
	 xP/PNX9dHamBimYyBR3Ok4tneMkfgu+w5jH2SFl417cPZ5ucEgP2VPuQqtlsiOydzc
	 Mrb84b/8nRBLNcFWhdKM5gGypmcQbhyUolBpem9lhwhfEZ6bYrebQZ7JcggoO2AFR4
	 9M98BRy/nvhbeOICaIzes/vcOTwQFZxk+3CCPVLIzvJXUr20RGKK5FWEZC/NTNYIvi
	 ueBCqtk4HH7uBRvhVGvmbvIvHaOezS5omhmmQoGwuBCmTqHGveBipn/DKHrH2tns/U
	 FB2qLzAyhioQQ==
Message-ID: <339873c4-1c6c-4d9c-873c-75a007d4b162@kernel.org>
Date: Sun, 7 Jul 2024 10:58:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/4] ipv4: fix source address selection with route
 leak
Content-Language: en-US
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
 <20240705145302.1717632-2-nicolas.dichtel@6wind.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240705145302.1717632-2-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/5/24 8:52 AM, Nicolas Dichtel wrote:
> By default, an address assigned to the output interface is selected when
> the source address is not specified. This is problematic when a route,
> configured in a vrf, uses an interface from another vrf (aka route leak).
> The original vrf does not own the selected source address.
> 
> Let's add a check against the output interface and call the appropriate
> function to select the source address.
> 
> CC: stable@vger.kernel.org
> Fixes: 8cbb512c923d ("net: Add source address lookup op for VRF")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  net/ipv4/fib_semantics.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index f669da98d11d..459082f4936d 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -2270,6 +2270,13 @@ void fib_select_path(struct net *net, struct fib_result *res,
>  		fib_select_default(fl4, res);
>  
>  check_saddr:
> -	if (!fl4->saddr)
> -		fl4->saddr = fib_result_prefsrc(net, res);
> +	if (!fl4->saddr) {
> +		struct net_device *l3mdev = dev_get_by_index_rcu(net, fl4->flowi4_l3mdev);

long line length. separate setting the value:

		struct net_device *l3mdev;

		l3mdev = dev_get_by_index_rcu(net, fl4->flowi4_l3mdev);

> +
> +		if (!l3mdev ||
> +		    l3mdev_master_dev_rcu(FIB_RES_DEV(*res)) == l3mdev)
> +			fl4->saddr = fib_result_prefsrc(net, res);
> +		else
> +			fl4->saddr = inet_select_addr(l3mdev, 0, RT_SCOPE_LINK);
> +	}
>  }


