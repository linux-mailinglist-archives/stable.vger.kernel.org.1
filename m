Return-Path: <stable+bounces-96177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C249E0FB3
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 01:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5614616516B
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 00:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEE72500D9;
	Tue,  3 Dec 2024 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSnk8Vo6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D542500C4;
	Tue,  3 Dec 2024 00:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185615; cv=none; b=AZgeMPzBHgiys+fm8r0Og4A0fGo9SLnFjut3NVu/mCp3OVCKv0LbOUsZUYAEO301xwiFuoUmQrEXozm0HSRhglohgEXvf6wcxqvAjx/4riR3KsSGxvF9VBaX3xOEHkhg15vKlM2fhS9RItwAcHnzLcNgE7ZzsRPBj+73IrK8Ewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185615; c=relaxed/simple;
	bh=qnvfK4tL9vbeAxCoO63Od4BOIO9mCY3QsSroY8yLfOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcM+7pPpA3SFR20i7DPOSm9XW2d9npU+7ZIjfBUDSPzgXL22kjoRHp53kEC5xY99G5iS9Anf391nUazZ8aNJ90r22zcuWlBHKEIe4UMPkDCZjchrCBxcUofrj7r3aPBo/GKvPi5x8GK1urDaTs2ijwlwqzMe/Sm9pGSv3mIPXYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSnk8Vo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3F9C4CED2;
	Tue,  3 Dec 2024 00:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733185615;
	bh=qnvfK4tL9vbeAxCoO63Od4BOIO9mCY3QsSroY8yLfOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VSnk8Vo6fzOol2IlHcrLLoaZORxtKLxx6ddh0/MNjuiWgbx8dGBBt1Uav/qfzZu/T
	 r4CrcZSfiaYPPt6C3a865Vx/tR6NWd/U4aZMAhT6fk49WkQFpWZptklFWMJzWNrpSE
	 57Ko9x3olH7m9OFcTgIqmcjcq84mrx80Q8zPwOhOGANA1LdTdqD6V/hGr+EI+tmYDy
	 rV0Jj7SS4YKz4Bdt1s6c2lJQ3kFaw0Gj+xF5+ITfyuIhaF05bM1pnJkTtg3p9PtsgA
	 Kp4D0QaRgtfE5ly2rLlVKQlA26jcQlu4Ud8shESq54h+VVD5ye38ZviFU+oudJsXVS
	 qty3tOT94HGSw==
Date: Mon, 2 Dec 2024 16:26:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: 'Dominique MARTINET' <dominique.martinet@atmark-techno.com>
Cc: David Laight <David.Laight@aculab.com>, Oliver Neukum
 <oneukum@suse.com>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Greg Thelen <gthelen@google.com>, John Sperbeck
 <jsperbeck@google.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net] net: usb: usbnet: fix name regression
Message-ID: <20241202162653.62e420c5@kernel.org>
In-Reply-To: <Z05FQ-Z6yv16lSnY@atmark-techno.com>
References: <20241017071849.389636-1-oneukum@suse.com>
	<Z00udyMgW6XnAw6h@atmark-techno.com>
	<e53631b5108b4d0fb796da2a56bc137f@AcuMS.aculab.com>
	<Z01xo_7lbjTVkLRt@atmark-techno.com>
	<20241202065600.4d98a3fe@kernel.org>
	<Z05FQ-Z6yv16lSnY@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 08:39:47 +0900 'Dominique MARTINET' wrote:
> > > If that is what was intended, I am fine with this, but I think these
> > > local ppp usb interfaces are rather common in the cheap modem world.  
> > 
> > Which will work, as long as they are marked appropriately; that is
> > marked with FLAG_POINTTOPOINT.  
> 
> Hmm, but the check here was either FLAG_POINTTOPOINT being unset or not
> locally administered address, so to keep the usb0 name we need both?
> 
> >             if ((dev->driver_info->flags & FLAG_ETHER) != 0 &&
> >                 ((dev->driver_info->flags & FLAG_POINTTOPOINT) == 0 ||
> > -                (net->dev_addr [0] & 0x02) == 0))
> > +                /* somebody touched it*/
> > +                !is_zero_ether_addr(net->dev_addr)))
> >                       strscpy(net->name, "eth%d", sizeof(net->name));  
> 
> i.e., something that didn't have FLAG_POINTTOPOINT in the first place
> would not get into this mac consideration, so it must be set.

Right! I missed the && plus ||

> My problematic device here has FLAG_POINTTOPOINT and a (locally
> admistered) mac address set, so it was not renamed up till now,
> but the new check makes the locally admistered mac address being set
> mean that it is no longer eligible to keep the usbX name.

Ideally, udev would be the best option, like Greg said.
This driver is already a fragile pile of workarounds.

If you really really want the old behavior tho, let's convert 
the zero check to  !is_zero_ether_addr() && !is_local_ether_addr().
Maybe factor out the P2P + address validation to a helper because
the && vs || is getting complicated.

