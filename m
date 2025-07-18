Return-Path: <stable+bounces-163408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D80B0AC81
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 01:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33031C27E18
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 23:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4134B222597;
	Fri, 18 Jul 2025 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elM+aYqs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE805A923;
	Fri, 18 Jul 2025 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752880707; cv=none; b=ljwXV9OL95oHxWLFcbazlA1mKgjG3yu9vpO+GYR4AxeCE17oeBD36c9auohYUSE1r5UHKKx6+1Rdr1tyVImyfDN3lJolCgfXv0XFZupmcHvacaDCi8tisA5Bpm1GuEo/iMujS+pkNu8AYrZJEQuYpwcV94SyS1N0PHE6UBmglPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752880707; c=relaxed/simple;
	bh=CZTZ9oUZTzhOy7CxW12Mv61GrBq1wGI/F8Msa4fG+HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZxlQr3Zuu6RRWF4Ww3WIGhQyDQhw+NRiH9ix9BNe9CXUpEaAkkp4eIBlGorfbFizPu2nqc8X/rF0i0AIwJL2/TVt6bYPcRN0lDDLB4UXDw8N3w2U/xKVdojiu6KW9cpXXudcjIEsJWOoEvzLpT5Tg90f3My4CzmnEGh1r6QRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elM+aYqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1088CC4CEEB;
	Fri, 18 Jul 2025 23:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752880706;
	bh=CZTZ9oUZTzhOy7CxW12Mv61GrBq1wGI/F8Msa4fG+HQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=elM+aYqs9RSlCedFnBwaJyWquK+vFNZkIbVf2sd3KVRV+DKy3Huj9k4EQPP89AjRm
	 1IUaSBELre8rOu8SpL3hD4Bq9Ja7pEqEkr+Oj9BfxWhy5RXLEKv3HuJg2Nz9F26JQj
	 IgkW3x8BaM5uyBUPKiJ2HUHadjopPKat/cur32TIL5k0ipEteAGbTGp3jkqteBL+km
	 eQ8fEjuEElCqWZdx9xS9GYhqS4hJk8AmtkGSDUe4xHfA550ya+URIMcPRiePeIA723
	 uXXhwYB4OKLmtyCxzjOCgpsR760xHdhg/2REs0KNfozNSnrqfuuMmIJqn9ZKfUA3ZC
	 ZgHFRmFh9oLmw==
Date: Fri, 18 Jul 2025 16:18:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Ernberg <john.ernberg@actia.se>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ming Lei
 <ming.lei@canonical.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH] net: usbnet: Avoid potential RCU stall on LINK_CHANGE
 event
Message-ID: <20250718161825.65912e37@kernel.org>
In-Reply-To: <55147f36-822b-4026-a091-33b909d1eea8@actia.se>
References: <20250710085028.1070922-1-john.ernberg@actia.se>
	<20250714163505.44876e62@kernel.org>
	<74a87648-bc02-4edb-9e6a-102cb6621547@actia.se>
	<20250715065403.641e4bd7@kernel.org>
	<fbd03180-cca0-4a0f-8fd9-4daf5ff28ff5@actia.se>
	<20250716143959.683df283@kernel.org>
	<55147f36-822b-4026-a091-33b909d1eea8@actia.se>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 09:07:26 +0000 John Ernberg wrote:
> > Thanks for the analysis, I think I may have misread the code.
> > What I was saying is that we are restoring the carrier while
> > we are still processing the previous carrier off event in
> > the workqueue. My thinking was that if we deferred the
> > netif_carrier_on() to the workqueue this race couldn't happen.
> > 
> > usbnet_bh() already checks netif_carrier_ok() - we're kinda duplicating
> > the carrier state with this RX_PAUSED workaround.
> > 
> > I don't feel strongly about this, but deferring the carrier_on()
> > the the workqueue would be a cleaner solution IMO.
> >   
> 
> I've been thinking about this idea, but I'm concerned for the opposite 
> direction. I cannot think of a way to fully guarantee that the carrier 
> isn't turned on again incorrectly if an off gets queued.
> 
> The most I came up with was adding an extra flag bit to set carrier on, 
> and then test_and_clear_bit() it in the __handle_link_change() function.
> And also clear_bit() in the usbnet_link_change() function if an off 
> arrives. I cannot convince myself that there isn't a way for that to go 
> sideways. But perhaps that would be robust enough?

I think it should be robust enough.. Unless my grep skills are failing
me - no drivers which call usbnet_link_change() twiddle the link state
directly.

Give it a go, if you think your initial patch is cleaner -- it's fine.

> I've also considered the possibility of just not re-submitting the INTR 
> poll URB until the last one was fully processed when handling a link 
> change. But that might cause havoc with ASIX and Sierra devices as they 
> are calling usbnet_link_change() in other ways than through the 
> .status-callback. I don't have any of these devices so I cannot test 
> them for regressions. So this path feels quite dangerous.
> With a sub-driver property to enable this behavior it might work out?

Yeah, that seems more involved.

