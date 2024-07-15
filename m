Return-Path: <stable+bounces-59273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B34930DA9
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 07:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4E81F21516
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 05:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD71713B59B;
	Mon, 15 Jul 2024 05:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S09H0GWD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5EA1F94C;
	Mon, 15 Jul 2024 05:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721022311; cv=none; b=Ev9m11kRnfjT/Dmk8gsCAhf3XMUAmH3lg0AiyjzX7TGn9I59TrY4+GtmvtiMwfkxpPuBVxK3Fmo4IDbLM6v3uLahbODtKKe4jI9J/rIs4uJSSQi6MOBNEnEWxcs3uZFYgqmNd9SnIORZz3ouWWpLa3UanpQxDsuXlbeyKBT+TsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721022311; c=relaxed/simple;
	bh=NBoxsThlV5YMJKSVODJO9PEIu4bUXR+/jBPgTxeHo2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvdnGFNB/ofmjgik4foCYk9erjrUgQLYuPbV2lqfQHRCtKdiktp1W/iGwKSgRG7eWqhhBNHUDh3waGJhj0hYDbHCBRia9dJVF8ArRaWQER21own9SaqKZy0GMynXmzElzVyItkKR1I3DKGBZnrV0AsfIQyBJS+UfESFZ/d8ycyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S09H0GWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BFDC4AF0A;
	Mon, 15 Jul 2024 05:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721022310;
	bh=NBoxsThlV5YMJKSVODJO9PEIu4bUXR+/jBPgTxeHo2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S09H0GWDhJjfmBpx+yEvnmibPChqCIv3Wy2DZWKcR+LC3m1lbTB3GQ1WMgy/Q0swj
	 cN34ZtXoFEs4oCT//jhjw68LjZmfG4ixHXVc5t4iqCAHbgEh0r0wzV9IKU4banQnwS
	 qyleiUgWxoS4jKQteTJ9yPhkyOK2i1e9+oKyZO5c=
Date: Mon, 15 Jul 2024 07:45:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: =?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>,
	elatllat@gmail.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, mathias.nyman@linux.intel.com,
	niklas.neronin@linux.intel.com, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
Message-ID: <2024071540-commute-curler-26d3@gregkh>
References: <CA+3zgmsCgQs_LVV6fOwu3v2t_Vd=C3Wrv9QrbNpsmMq4RD=ZoQ@mail.gmail.com>
 <20240714173043.668756e4@foxbook>
 <ZpP3RU-MKb4pMmZH@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZpP3RU-MKb4pMmZH@eldamar.lan>

On Sun, Jul 14, 2024 at 06:05:25PM +0200, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Sun, Jul 14, 2024 at 05:32:39PM +0200, Michał Pecio wrote:
> > This looks like bug 219039, please see if my suggested solution works.
> > 
> > The upstream commit is correct, because the call to inc_deq() has been
> > moved outside handle_tx_event() so there is no longer this critical
> > difference between doing 'goto cleanup' and 'return 0'. The intended
> > change of this commit also makes sense to me.
> > 
> > This refactor is already present in v6.9 so I don't think the commit
> > will have any effect besides fixing the isochronous bug which it is
> > meant to fix.
> > 
> > But it is not present in v6.6 and v6.1, so they break/crash/hang/etc.
> > Symptoms may vary, but I believe the root cause is the same because the
> > code is visibly wrong.
> > 
> > 
> > I would like to use this opportunity to point out that the xhci driver
> > is currenty undergoing (much needed IMO) cleanups and refactors and
> > this is not the first time when a naive, verbatim backport is attempted
> > of a patch which works fine on upstream, but causes problems on earlier
> > kernels. These things need special scrutiny, beyond just "CC:stable".
> 
> For tracking I guess this should go as well to the regressions list?
> 
> #regzbot introduced: 948554f1bb16e15b90006c109c3a558c66d4c4ac
> #regzbot title: freezes on plugging USB connector due to 948554f1bb16 ("usb: xhci: prevent potential failure in handle_tx_event() for Transfer events without TRB")
> #regzbot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=219039
> 
> Thorsten I hope I got the most bits correctly, how would one inform
> regzbot about the regresssion for 6.1.98 and 6.6.39 but not happening
> in the upper versions?

I'll handle this and go release new kernels with just this reverted in
it.  Let my morning coffee kick in first...

thanks,

greg k-h

