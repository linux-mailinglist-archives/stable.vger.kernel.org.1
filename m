Return-Path: <stable+bounces-196872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC80C83D90
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 09:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4C23A8EBC
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 08:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818E41E25F9;
	Tue, 25 Nov 2025 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MJa74FVh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0512B93;
	Tue, 25 Nov 2025 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057657; cv=none; b=XCqQZAhNNs22a/G8Mars4/sLRQ6CP7mnYyeU/o18Gmgu7SHnAwe/ssHuUDeRbYgOsjJ33sAJ6Kqy+RV+L6P1IC2JViQt/ZG3Bw1C8S6maGYhtBN4KLYy85s3MNBEhb9JlJfljdARNs6Neni9bvcHiwuTjklXSnN6kYpOHYdlTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057657; c=relaxed/simple;
	bh=OxbewM4M4hNyqnNDwphIcD3MEd7zb0TYBcX8Oviud3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKnnphhmz24lYN+ASuhi/sgfx5zUINHcXcOQP0ns4Afk34BM+GcNVMnLypEuWzPp3uqTAkQC7ZGjwsNm/cdhcTubkApTukxwZL2k42U5pbWuvn9MIabdaxTj3INTLu1KI2g1cdnOLKsTbXITUTec5f79K69nRMQVxnuICPkLQa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MJa74FVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF90C4CEF1;
	Tue, 25 Nov 2025 08:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764057656;
	bh=OxbewM4M4hNyqnNDwphIcD3MEd7zb0TYBcX8Oviud3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJa74FVhwYIE/MpHxDH1z98n6sVIfWBlCetG7qMiHW56ivcx0eDZHt2J+fSz3tMsM
	 cJWkWDutNEcNQ4w5U6Q/tfVtfU9nEwaq4hvdoykXNm92/MNjxbc9H5WYzEbVR3JcrN
	 P5I84Ik+hvUldIbbn6YFqq2QY+nuTkMeeUpvDbVw=
Date: Tue, 25 Nov 2025 09:00:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] xhci: dbgtty: fix device unregister
Message-ID: <2025112537-purgatory-delegator-41fb@gregkh>
References: <20251119212910.1245694-1-ukaszb@google.com>
 <2f05eedd-f152-4a4a-bf6c-09ca1ab7da40@kernel.org>
 <6171754f-1b84-47e0-a4da-0d045ea7546e@linux.intel.com>
 <e7ebc1da-1a94-4465-bc79-de9ad8ba1cb6@kernel.org>
 <CALwA+NakWZSY-NOebF9E+gGPf2p0Y5FLOZcpLfSbt5zkNm_qxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALwA+NakWZSY-NOebF9E+gGPf2p0Y5FLOZcpLfSbt5zkNm_qxQ@mail.gmail.com>

On Tue, Nov 25, 2025 at 08:53:17AM +0100, Łukasz Bartosik wrote:
> On Mon, Nov 24, 2025 at 10:11 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> > On 24. 11. 25, 8:48, Mathias Nyman wrote:
> > > On 11/24/25 08:42, Jiri Slaby wrote:
> > >> Hmm, CCing TTY MAINTAINERS entry would not hurt.
> > >>
> 
> Fair point. I will keep it in mind in the future.
> 
> > >> On 19. 11. 25, 22:29, Łukasz Bartosik wrote:
> > >>> From: Łukasz Bartosik <ukaszb@chromium.org>
> > >>>
> > >>> When DbC is disconnected then xhci_dbc_tty_unregister_device()
> > >>> is called. However if there is any user space process blocked
> > >>> on write to DbC terminal device then it will never be signalled
> > >>> and thus stay blocked indifinitely.
> > >>
> > >> indefinitely
> > >>
> 
> Thanks for spotting this.
> 
> > >>> This fix adds a tty_vhangup() call in xhci_dbc_tty_unregister_device().
> > >>> The tty_vhangup() wakes up any blocked writers and causes subsequent
> > >>> write attempts to DbC terminal device to fail.
> > >>>
> > >>> Cc: stable@vger.kernel.org
> > >>> Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
> > >>> Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
> > >>> ---
> > >>> Changes in v2:
> > >>> - Replaced tty_hangup() with tty_vhangup()
> > >>
> > >> Why exactly?
> > >
> > > I recommended using tty_vhangup(), well actually tty_port_tty_vhangup()
> > > to solve
> > > issue '2' you pointed out.
> > > To me it looks like tty_vhangup() is synchronous so it won't schedule
> > > hangup work
> > > and should be safe to call right before we destroy the port.
> >
> > Oops, right, my cscope DB was old and lead me to tty_hangup() instead
> > (that schedules).
> >
> > >> 2) you schedule a tty hangup work and destroy the port right after:
> > >>>       tty_unregister_device(dbc_tty_driver, port->minor);
> > >>>       xhci_dbc_tty_exit_port(port);
> > >>>       port->registered = false;
> > >> You should to elaborate how this is supposed to work?
> > >
> > > Does tty_port_tty_vhangup() work here? it
> > > 1. checks if tty is NULL
> > > 2. is synchronous and should be safe to call before tty_unregister_device()
> >
> > Yes, this works for me.
> >
> 
> Greg should I send v3 with typo fix  indifinitely -> indefinitely and
> elaborate on
> the tty_hangup() -> tty_vhangup() replacement in changes ?

As this is already in my tree, a fixup on top of that would be good.

thanks,

greg k-h

