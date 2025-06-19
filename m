Return-Path: <stable+bounces-154835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F661AE0F21
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 23:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8734A36FB
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 21:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321C92459F9;
	Thu, 19 Jun 2025 21:53:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE54322154B;
	Thu, 19 Jun 2025 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370037; cv=none; b=Ds2p7DOmORBB/zN9Pph1mrrR4LgL8CZftkKjnRxrB6nw1sej6PVL+UkJ97Fv3AjWLtmDeFJ3qIdpiPiqCpiEu+z+Fbw3LTTJnHG3IJrYreFHVxtbit+sNPr2/s44ciWE5Ip8m3owDw0TxRd+fgp1AvCUOaaiQtgkalOv9295L78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370037; c=relaxed/simple;
	bh=wBXVrcgEC2fkjBWN2RM0IOuo0AC5FTziHXKGjW72xZg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oheZr17XvVo2I4ULNtxkAuEHeONwCei9KZv+fiuNvJ9L6EIsU68IkvTNYNpqCeBxjMw0J6hlTwOOKH/dTBfUEiLD3iMA1aySG8vVnmjlNg9LqRD9V57zDJlus9Y3ScuIaj6I6gL/g1pt1VQn39wYPneHhfT4sCMDMNiVqh5VBNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9159D92009C; Thu, 19 Jun 2025 23:53:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8A2BB92009B;
	Thu, 19 Jun 2025 22:53:51 +0100 (BST)
Date: Thu, 19 Jun 2025 22:53:51 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Florian Fainelli <f.fainelli@gmail.com>
cc: Greg Chandler <chandleg@wizardsworks.org>, stable@vger.kernel.org, 
    netdev@vger.kernel.org
Subject: Re: Tulip 21142 panic on physical link disconnect
In-Reply-To: <52564e1f-ab05-4347-bd64-b38a69180499@gmail.com>
Message-ID: <alpine.DEB.2.21.2506192238280.37405@angie.orcam.me.uk>
References: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org> <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com> <385f2469f504dd293775d3c39affa979@wizardsworks.org> <fba6a52c-bedf-4d06-814f-eb78257e4cb3@gmail.com> <6a079cd0233b33c6faf6af6a1da9661f@wizardsworks.org>
 <9292e561-09bf-4d70-bcb7-f90f9cfbae7b@gmail.com> <a3d8ee993b73b826b537f374d78084ad@wizardsworks.org> <12ccf3e4c24e8db2545f6ccaba8ce273@wizardsworks.org> <8c06f8969e726912b46ef941d36571ad@wizardsworks.org> <alpine.DEB.2.21.2506192007440.37405@angie.orcam.me.uk>
 <52564e1f-ab05-4347-bd64-b38a69180499@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 19 Jun 2025, Florian Fainelli wrote:

> >   Maybe it'll ring someone's bell and they'll chime in or otherwise I'll
> > bisect it... sometime.  Or feel free to start yourself with 5.18, as it's
> > not terribly old, only a bit and certainly not so as 2.6 is.
> 
> I am still not sure why I could not see that warning on by Cobalt Qube2 trying
> to reproduce Greg's original issue, that is with an IP assigned on the
> interface yanking the cable did not trigger a timer warning. It could be that
> machine is orders of magnitude slower and has a different CONFIG_HZ value that
> just made it less likely to be seen?

 Can it have a different PHY attached?  There's this code:

	if (tp->chip_id == PNIC2)
		tp->link_change = pnic2_lnk_change;
	else if (tp->flags & HAS_NWAY)
		tp->link_change = t21142_lnk_change;
	else if (tp->flags & HAS_PNICNWAY)
		tp->link_change = pnic_lnk_change;

in `tulip_init_one' and `pnic_lnk_change' won't ever trigger this, but the 
other two can; apparently the corresponding comment in `tulip_interrupt':
                        
/*                        
 * NB: t21142_lnk_change() does a del_timer_sync(), so be careful if this
 * call is ever done under the spinlock
 */

hasn't been updated when `pnic2_lnk_change' was added.  Also ISTM no link 
change handler is a valid option too, in which case `del_timer_sync' won't 
be called either.  This is from a cursory glance only, so please take with 
a pinch of salt.

  Maciej

