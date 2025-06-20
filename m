Return-Path: <stable+bounces-154843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11963AE1085
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 02:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8F2189A3EF
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 00:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E861914AA9;
	Fri, 20 Jun 2025 00:57:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F923CE;
	Fri, 20 Jun 2025 00:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750381030; cv=none; b=atXGAPfBHFqYE36dqYvTlaBw7/FCdlf5Dg5Cif4N48ydle5rO38cKfxQVMKbgDG261Dg4r8iPb5YisJJmwPJuxESU1iUjKTUGLo6GtCRgczhdYCj/tCG7/lbxG7hL79WKjML+XUcuCNpQbJk3h2qi3qRIqMo8MguJR+MDhagLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750381030; c=relaxed/simple;
	bh=0GdIMsc/rycX23sODQ5b6m5mighTJfoLkV8/L6IEDN0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P1tUVazNp2B8L6ePpl/S7LKcP9SqC368fm2bIMevqX+Br0X66uzXbQLzd23V4JQgn+AJ3iOJ1S0+Igc+l1h2vHZn0YjgmvjLSLnpVXkoBB9GUR7sR+pJ+ybxDfLsott+mEfniCX2apz7UoPtaqa5dDHNbGvCz+eGrwcCY/NtE5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 92FA792009C; Fri, 20 Jun 2025 02:57:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 8586A92009B;
	Fri, 20 Jun 2025 01:57:05 +0100 (BST)
Date: Fri, 20 Jun 2025 01:57:05 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Greg Chandler <chandleg@wizardsworks.org>
cc: Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org, 
    netdev@vger.kernel.org
Subject: Re: Tulip 21142 panic on physical link disconnect
In-Reply-To: <5a21c21844beadb68ead00cb401ca1c0@wizardsworks.org>
Message-ID: <alpine.DEB.2.21.2506200144030.37405@angie.orcam.me.uk>
References: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org> <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com> <385f2469f504dd293775d3c39affa979@wizardsworks.org> <fba6a52c-bedf-4d06-814f-eb78257e4cb3@gmail.com> <6a079cd0233b33c6faf6af6a1da9661f@wizardsworks.org>
 <9292e561-09bf-4d70-bcb7-f90f9cfbae7b@gmail.com> <a3d8ee993b73b826b537f374d78084ad@wizardsworks.org> <12ccf3e4c24e8db2545f6ccaba8ce273@wizardsworks.org> <8c06f8969e726912b46ef941d36571ad@wizardsworks.org> <alpine.DEB.2.21.2506192007440.37405@angie.orcam.me.uk>
 <52564e1f-ab05-4347-bd64-b38a69180499@gmail.com> <alpine.DEB.2.21.2506192238280.37405@angie.orcam.me.uk> <5a21c21844beadb68ead00cb401ca1c0@wizardsworks.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 19 Jun 2025, Greg Chandler wrote:

> > > I am still not sure why I could not see that warning on by Cobalt Qube2
> > > trying
> > > to reproduce Greg's original issue, that is with an IP assigned on the
> > > interface yanking the cable did not trigger a timer warning. It could be
> > > that
> > > machine is orders of magnitude slower and has a different CONFIG_HZ value
> > > that
> > > just made it less likely to be seen?
> > 
> >  Can it have a different PHY attached?  There's this code:
> > 
> > 	if (tp->chip_id == PNIC2)
> > 		tp->link_change = pnic2_lnk_change;
> > 	else if (tp->flags & HAS_NWAY)
> > 		tp->link_change = t21142_lnk_change;
> > 	else if (tp->flags & HAS_PNICNWAY)
> > 		tp->link_change = pnic_lnk_change;
> 
> I'm not sure which of us that was directed at, but for my onboard tulips:

 It was for Florian, as obviously your system does trigger the issue.

> I found a link to the datasheet (If needed), but have had mixed luck with
> alldatasheets:
> https://www.alldatasheet.com/datasheet-pdf/pdf/75840/MICRO-LINEAR/ML6698CH.html

 There's no need to chase hw documentation as the issue isn't directly 
related to it.

 As I noted in the earlier e-mail it seems a regression in the handling of 
`del_timer_sync', perhaps deliberate, introduced sometime between 5.18 and 
6.4.  I suggest that you try 5.18 (or 5.17 as it was 5.18.0-rc2 actually 
here that worked correctly) and see if it still triggers the problem and 
if it does not then bisect it (perhaps limiting the upper bound to 6.4 if 
it does trigger it for you, to save an iteration or a couple).  Once you 
know the offender you'll likely know the solution.  Or you can come back 
with results and ask for one if unsure.

 HTH,

  Maciej

