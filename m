Return-Path: <stable+bounces-114188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C13CA2B6A7
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 00:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F8A17A371C
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 23:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A129226541;
	Thu,  6 Feb 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD8Peldp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8472417EF;
	Thu,  6 Feb 2025 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738885193; cv=none; b=VWRDVjzW3oo0Q9Iq/s7/Fp3Xr4Jdm65lnSL4tHkUB97mPC/F1KG4DJ80HW4iE8JU2nJZLCzeMdH/HDgct0D1xJhRY79mjby2rBz4YrxudUhfkXzp7KpXur7xiUSkcRg1deURUnYAVQIMU5CfStKRuIjngHk/EtlzKYetNUevSPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738885193; c=relaxed/simple;
	bh=p0DLFVOiELhPDzFWd2fbfQXfQiU4pRtGR9G1jmfaePQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3PL/CB6y3fDPFwI2zSXzNTHtaUD7jBoXML4uSyOndgCi6Mgc+vV2b0CaVQE4FHvS4oorIiq8RR4HBCBAb9xzpUKV2FAudnZq6iahi1bgQqQ1Lx83nv2io4pOy3ifWbXV7wz+R/5vNw3o5UIawVIsaTymogf7Ldhkr4g5gFPwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cD8Peldp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A01C4CEDD;
	Thu,  6 Feb 2025 23:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738885192;
	bh=p0DLFVOiELhPDzFWd2fbfQXfQiU4pRtGR9G1jmfaePQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cD8PeldpAgOrn7XgIMI4wrG50qQ3MU5MzZkhafVPUo/d7HLwCcxrjSkniinpVXooK
	 sN9LZjjoaLlAzCbEEYqf3WpZxH9jvi6fFzsyup8k7mErggbGx8X9f09fftDtJoacbm
	 epNVN7QiEbhWb8sKZvH16vG28zqhFSs+3VnD/OUkNIpNUH8yChTpx92noz1e9rjS+c
	 dTix9pxuf7V36J4c1oEFCImQfTSSz/ahxFHCL9cfUh8o73nmpr/2WzBUVyU+x4Q7VI
	 QJaPfdJ5vRxnV2HofXYjb4pSA+EFfGTPVPHOOKZruY5ciQQ4tb+sxYSXX38V7NpllR
	 20gdyEKRr7OJg==
Date: Thu, 6 Feb 2025 15:39:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: advertise 'netns local' property via
 netlink
Message-ID: <20250206153951.41fbcb84@kernel.org>
In-Reply-To: <20250206165132.2898347-2-nicolas.dichtel@6wind.com>
References: <20250206165132.2898347-1-nicolas.dichtel@6wind.com>
	<20250206165132.2898347-2-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 17:50:26 +0100 Nicolas Dichtel wrote:
> Since the below commit, there is no way to see if the netns_local property
> is set on a device. Let's add a netlink attribute to advertise it.

I think the motivation for the change may be worth elaborating on.
It's a bit unclear to me what user space would care about this
information, a bit of a "story" on how you hit the issue could
be useful perhaps? The uAPI is new but the stable tag indicates
regression..

> @@ -2041,6 +2042,7 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
>  		       netif_running(dev) ? READ_ONCE(dev->operstate) :
>  					    IF_OPER_DOWN) ||
>  	    nla_put_u8(skb, IFLA_LINKMODE, READ_ONCE(dev->link_mode)) ||
> +	    nla_put_u8(skb, IFLA_NETNS_LOCAL, dev->netns_local) ||

Maybe nla_put_flag() ? Or do you really care about false being there?
The 3 bytes wasted on padding always makes me question when people pick
NLA_u8.

>  	    nla_put_u32(skb, IFLA_MTU, READ_ONCE(dev->mtu)) ||
>  	    nla_put_u32(skb, IFLA_MIN_MTU, READ_ONCE(dev->min_mtu)) ||
>  	    nla_put_u32(skb, IFLA_MAX_MTU, READ_ONCE(dev->max_mtu)) ||

