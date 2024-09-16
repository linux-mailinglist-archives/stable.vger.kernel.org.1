Return-Path: <stable+bounces-76524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB87997A7A2
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 21:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55B71C22272
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 19:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F9615B130;
	Mon, 16 Sep 2024 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEAKII6m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3CE14600F;
	Mon, 16 Sep 2024 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726513462; cv=none; b=N/6ZC26LvhrfFh4FLtyCDWK5DfDmhNt0O4NQx0QLagCryOf+nN9X5tSXJ2VSM2n9T9D6Rbi4zLu8T0AbMD3bW5MwqVEt5yc27zXGIPyI3ApTcQGCWJ2qt/bufIZUHjFzKsNV443NisN8DGr7POovk+v6xWmt7xvzqgFZsPahgNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726513462; c=relaxed/simple;
	bh=O9AJWie2aCk2DlOqpJyIGdB3XgFmL6LjKz91fjoqbrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWC3rgLDOqPoNUGhg/9eYScbir2D15u2nlcOHO4NCkWmVtiEteukvonuAbekAJDv0kberChakjZF7DkW3eyGHvF6fTdRv4b7L78D0vOaZP6kmTFNgVgmcPvs0isSTb8ZQ5LMgeGtXSkoE2NZabDmhuRsK+UIGELDWfNnmeytVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEAKII6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DECDC4CEC4;
	Mon, 16 Sep 2024 19:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726513461;
	bh=O9AJWie2aCk2DlOqpJyIGdB3XgFmL6LjKz91fjoqbrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEAKII6mtiK6hKDRci5khWga69u+GrIwF7FhVwHEOetu0zGb84bKIlGPfbqXtNHr/
	 qsOplDGGsnRs7rDYjoJxw+uyaWhEY6XZau6Y06ZUVqhj18ItKVW7gwDpZ3B9C4hMLo
	 Iy99TiWuj3ZeOP4DnvUq7ZcMb4K7oQqMLjGNLwL0SnRdMOhuBOq07SJfdUgZQus/nc
	 LqUbm0LXPCtGBRrTajsOqNh0KDqbLjt0L76+GfLvQF0LXJIhBFKtTErRX6vonp++Vg
	 cdcU4C6KWnX/2lo75jyZHGCbvYOpZO1mWTyHd8kgMrlMCcO/JCM+1Px8cHXDyWH5T7
	 8067WrF7r1qXw==
Date: Mon, 16 Sep 2024 20:04:16 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Aring <alex.aring@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: ipv6: select DST_CACHE from IPV6_RPL_LWTUNNEL
Message-ID: <20240916190416.GE396300@kernel.org>
References: <20240916-ipv6_rpl_lwtunnel-dst_cache-v1-1-c34d5d7ba7f3@linutronix.de>
 <20240916184443.GC396300@kernel.org>
 <20240916184851.GD396300@kernel.org>
 <20240916205246-5df7e565-6950-4503-ac4d-741c37b1afda@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240916205246-5df7e565-6950-4503-ac4d-741c37b1afda@linutronix.de>

On Mon, Sep 16, 2024 at 08:54:21PM +0200, Thomas Weißschuh wrote:
> On Mon, Sep 16, 2024 at 07:48:51PM GMT, Simon Horman wrote:
> > On Mon, Sep 16, 2024 at 07:44:43PM +0100, Simon Horman wrote:
> > > On Mon, Sep 16, 2024 at 06:53:15PM +0200, Thomas Weißschuh wrote:
> > > > The rpl sr tunnel code contains calls to dst_cache_*() which are
> > > > only present when the dst cache is built.
> > > > Select DST_CACHE to build the dst cache, similar to other kconfig
> > > > options in the same file.
> > > > 
> > > > Fixes: a7a29f9c361f ("net: ipv6: add rpl sr tunnel")
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > > 
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > > Tested-by: Simon Horman <horms@kernel.org> # build-tested
> > 
> > Sorry Thomas, I missed one important thing:
> > 
> > Your Signed-off-by line needs to go above the scissors ('---')
> > because when git applies your patch nothing below the scissors
> > is included in the patch description.
> 
> Welp, this seems to be due to a combination of me forgetting to add it,
> b4 adding it below the scissors automatically and then failing to warn
> about the missing sign-off.
> 
> I'll resend v2 with your tags. And will also remove the Cc: stable as
> per net rules.

Thanks. Please be aware of the 24h rule.

https://docs.kernel.org/process/maintainer-netdev.html

