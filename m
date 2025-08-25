Return-Path: <stable+bounces-172895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55880B34F58
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 00:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C87161D70
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 22:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF8D2D061C;
	Mon, 25 Aug 2025 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZwsOn/3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0317C2C3261;
	Mon, 25 Aug 2025 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162592; cv=none; b=l3UXBOWKsh5iCNUpGi38aXQ1kDQxcum7AmwF79So0nR1mTYWfuvzQa6irb3Yz8ZxABM/fjrd7g5/fe8/RQPx9B/QP+fICOlrk2vD99fg7ijova+nFHsRZ0ahJSBuvdMu8axeWp6pVcUCkGDAAd2YlXt2tGSJO4GZmP4hYvUBbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162592; c=relaxed/simple;
	bh=1EwS02lvQFkf1B1/XBnY3ItiLLai366NbFmVSIdJjyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5+vPN9a/N+/s4/keLYbFIKgYwk8etki7j50wSTHNgttFFw98sb9/NBXVbpwYucSljDFytBjbWFNxWc6MF8IOOcOohbo51ofq3QDJdJ3nEjKlA1qxgTlaxz8NRCLHobxNG+wgI44B/ica/JOTlvbubk4tktRmkRQcxlkij3sZ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZwsOn/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C326C4CEED;
	Mon, 25 Aug 2025 22:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756162591;
	bh=1EwS02lvQFkf1B1/XBnY3ItiLLai366NbFmVSIdJjyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bZwsOn/3Pj9RnVq2HgNIxcs4N8XRlIVgl8jxLTCxR2SJd7TlVMiObIm7soDAO6SLL
	 jqh5hlRJM06cuhDmMs6LtnKsjCu5aZNqzW9TnUfATG8WSYro4hBeWPj+WJWJrGl0G4
	 DljoPOYJjwpkHPWelKoPt1+HmYyulIVqtXIORzjzKt+nq1ffOkMeuOPSW7tBdg8pvD
	 dl/yQzHN65i3hlr8L+gjMcQ38rdeRlzIeBqAsuwxVG6t8hEy/rYC9zV+QK70bISF9e
	 Y/tSBtxFHS5nF9cU2D7QPNvmyznDhd/H0lFaUcLsmq0YeT1rPRoFEMIdIq/f1OIDS+
	 nZb5fyuAbOHLA==
Date: Mon, 25 Aug 2025 15:56:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: bacs@librecast.net, brett@librecast.net, davem@davemloft.net,
 dsahern@kernel.org, netdev@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: ipv4: fix regression in local-broadcast
 routes
Message-ID: <20250825155630.5848c357@kernel.org>
In-Reply-To: <20250825060918.4799-1-oscmaes92@gmail.com>
References: <20250825060229-oscmaes92@gmail.com>
	<20250825060918.4799-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 08:09:17 +0200 Oscar Maes wrote:
> Commit 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
> introduced a regression where local-broadcast packets would have their
> gateway set in __mkroute_output, which was caused by fi = NULL being
> removed.
> 
> Fix this by resetting the fib_info for local-broadcast packets.

Meaning that 9e30ecf23b1b would still change behavior for the subnet
broadcast address?

> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index f639a2ae881a..98d237e3ec04 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -2575,9 +2575,12 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
>  		    !netif_is_l3_master(dev_out))
>  			return ERR_PTR(-EINVAL);
>  
> -	if (ipv4_is_lbcast(fl4->daddr))
> +	if (ipv4_is_lbcast(fl4->daddr)) {
>  		type = RTN_BROADCAST;
> -	else if (ipv4_is_multicast(fl4->daddr))
> +
> +		/* reset fi to prevent gateway resolution */
> +		fi = NULL;
> +	} else if (ipv4_is_multicast(fl4->daddr))
>  		type = RTN_MULTICAST;
>  	else if (ipv4_is_zeronet(fl4->daddr))
>  		return ERR_PTR(-EINVAL);

nit: please add curly braces around all branches of this if / else if /
else ladder, per kernel coding style guide.
-- 
pw-bot: cr

