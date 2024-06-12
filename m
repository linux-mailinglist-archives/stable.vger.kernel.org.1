Return-Path: <stable+bounces-50266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B969054A3
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DBAEB21314
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6271417F37F;
	Wed, 12 Jun 2024 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KgGObPDa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA517F37C;
	Wed, 12 Jun 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200723; cv=none; b=Mf7l5Gc4nnhEjpodano8t66zmQ9uBafh/Lwj0UQfn1w5+pfYQ/dyQEOpWfbuaR4izr+1tkDxnm8RR7Tw2D081XftUZOFzo11jp8pp4MFkVh2dDSsgfxdcG1GkJXbE3vMs4oThsICsHIIqe4iU4O4gebZypFx4EW8wEv+Q5bdUsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200723; c=relaxed/simple;
	bh=B3wMkmZ7OrCEXcqJWumgkuWRETuK/7tmpwj6d2FUnJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyTVNO1+9BIud1RbRWSGw6qZzDkUMDf563VbV7Z09daNiFRdWb7BwPcBphKNS5jyEpw4PD62qsBeTxx1VrlSEH0FLcCwOMMm6AfnSISnNc6wVupRDCbiF0le8vS3mN450Txslfx/FgmyAnD0oEQt1cDKD/F6sk+iGAbfmpK1pTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KgGObPDa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA31C116B1;
	Wed, 12 Jun 2024 13:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718200722;
	bh=B3wMkmZ7OrCEXcqJWumgkuWRETuK/7tmpwj6d2FUnJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KgGObPDaAXLSFFl5LJohXuwg2syT6p7JwTpXyKC2dODCSbhI6y90/NWk04DQ0Fcxs
	 yasLlQSJ1ZJJPnfEdhP0ucBMrYsvYak+2HfQpeMVWJCPjvUdW3NQauWM0xlKtqvF6j
	 1Tr7jqst4yXBgyTWIGXjgUDK19CYXmgNTJvmd6Dc=
Date: Wed, 12 Jun 2024 15:58:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH stable-5.15.y 0/2] Fix PTP received on wrong port with
 bridged SJA1105 DSA
Message-ID: <2024061227-agony-washable-111e@gregkh>
References: <20240531165016.3021154-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531165016.3021154-1-vladimir.oltean@nxp.com>

On Fri, May 31, 2024 at 07:50:14PM +0300, Vladimir Oltean wrote:
> It has been brought to my attention that what had been fixed 1 year ago
> here for kernels 5.18 and later:
> https://lore.kernel.org/netdev/20230626155112.3155993-1-vladimir.oltean@nxp.com/
> 
> is still broken on linux-5.15.y. Short summary: PTP boundary clock is
> broken for ports under a VLAN-aware bridge.
> 
> The reason is that the Fixes: tags in those patches were wrong. The
> issue originated from earlier, but the changes from 5.18 (blamed there),
> aka DSA FDB isolation, masked that.
> 
> A straightforward cherry-pick was not possible, due to the conflict with
> the aforementioned DSA FDB isolation work from 5.18. So I redid patch
> 2/2 and marked what I had to adapt.
> 
> Tested on the NXP LS1021A-TSN board.
> 
> Vladimir Oltean (2):
>   net: dsa: sja1105: always enable the INCL_SRCPT option
>   net: dsa: tag_sja1105: always prefer source port information from
>     INCL_SRCPT
> 
>  drivers/net/dsa/sja1105/sja1105_main.c |  9 ++-----
>  net/dsa/tag_sja1105.c                  | 34 ++++++++++++++++++++------
>  2 files changed, 28 insertions(+), 15 deletions(-)
> ---
> 
> I'm sorry for the people who will want to backport DSA FDB isolation to
> linux-5.15.y :(

Now queued up, thanks.

greg k-h

