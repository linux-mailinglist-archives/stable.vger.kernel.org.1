Return-Path: <stable+bounces-154824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E765AAE0E12
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 21:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D3D1BC847E
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30012242D7D;
	Thu, 19 Jun 2025 19:36:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BE130E82B;
	Thu, 19 Jun 2025 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750361810; cv=none; b=AoLTPLIt+LlIDQyOryV1P6vgj1xP3Spjj2DgOKsgxgNCfch3WP5wbjilSTHkRGnkbZQUpsm9Dbbep6Tb0odXj3O6QYR2YncUb70U4voohRE84MErf/Vt1328WK3pDw0SgL47LXGtJd5rzWFlQR8+D2CitsOIkPGwgECxYmQAUMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750361810; c=relaxed/simple;
	bh=0va0Ka/IZtI0QKqeoxQgsQhzUmGLi6WCkSlL0TAYbJc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kOZR0EopyT5+t/7++tzfAp1sCxC0QTHgc2jfBdEJ3wJlXCi8i3mMT80dEVDWCBVbXX8l0nvyqFaub0MpPp0TTTQJRNF42bdGV3GF7HYelYHg6cyeX0BnpKFjT+QP1poCx9qhHi2JStHC+EVCep+aOf92OVfZTNrVnX/NC0VvGXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 34AA292009C; Thu, 19 Jun 2025 21:36:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 2DC4C92009B;
	Thu, 19 Jun 2025 20:36:44 +0100 (BST)
Date: Thu, 19 Jun 2025 20:36:44 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Greg Chandler <chandleg@wizardsworks.org>
cc: Florian Fainelli <f.fainelli@gmail.com>, stable@vger.kernel.org, 
    netdev@vger.kernel.org
Subject: Re: Tulip 21142 panic on physical link disconnect
In-Reply-To: <8c06f8969e726912b46ef941d36571ad@wizardsworks.org>
Message-ID: <alpine.DEB.2.21.2506192007440.37405@angie.orcam.me.uk>
References: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org> <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com> <385f2469f504dd293775d3c39affa979@wizardsworks.org> <fba6a52c-bedf-4d06-814f-eb78257e4cb3@gmail.com> <6a079cd0233b33c6faf6af6a1da9661f@wizardsworks.org>
 <9292e561-09bf-4d70-bcb7-f90f9cfbae7b@gmail.com> <a3d8ee993b73b826b537f374d78084ad@wizardsworks.org> <12ccf3e4c24e8db2545f6ccaba8ce273@wizardsworks.org> <8c06f8969e726912b46ef941d36571ad@wizardsworks.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 19 Jun 2025, Greg Chandler wrote:

> So what I know for sure is this:
> The tulip driver on alpha (generic and DP264) oops/panic on physical
> disconnect, but only when an IP address is bound.
> It does not panic when no address is bound to the interface.
> It does not matter if the driver is compiled in, or if it is compiled as a
> module.
> It does not matter if all of the options are set for tulip or if none of them
> are:
>     New bus configuration
>     Use PCI shared mem for NIC registers
>     Use RX polling (NAPI)
>     Use Interrupt Mitigation
> The physical link does not auto-negotiate, and mii-tool does not seem to be
> able to force it with -F or -A like you would expect it to.
> The kernel does not drop the "Link is Up/Link is Down" messages when the PHY
> "links"
> The switch and interface both show LEDs as if linked at 10-Half-Duplex, and
> the lights turn off when the link is broken.
> Subsequently they do relink at 10-Half again if plugged back in.
> I did also attempt to test the kernel level stack for nfsroot, just to see if
> it worked prior to init launching everything else, and it did not.
> I used the same IP configuration for that test as all of the tests in these
> emails.
> All of the oops/panics seem to happen at:
>     kernel/time/timer.c:1657 __timer_delete_sync+0x10c/0x150

 FYI something's changed a while ago in how `del_timer_sync' is handled 
and I can see a similar warning nowadays with another network driver with 
the MIPS platform.

 Since I'm the maintainer of said driver I mean to bisect it and figure 
out what's going here, but haven't found time so far owing to other 
commitments (and the driver otherwise works just fine regardless, so it's 
minor annoyance).  If you beat me to it, then I'll gladly accept it, but 
otherwise I'm just letting you know you're not alone with this issue and 
that it's not specific to the DEC Tulip driver on your system.

 For the record:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/time/timer.c:1563 __timer_delete_sync+0x110/0x118
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Tainted: G        W          6.4.0-rc3-00030-gae62c49c0cef #21
Stack : 807a0000 80095a8c 00000000 00000004 806a0000 00000009 80c09dac 807d0000
        807a0000 807056ec 80769fac 807a13f3 807d30c4 1000ec00 80c09d58 80787a18
        00000000 00000000 807056ec 00000000 00000001 80c09c94 00000077 34633236
        20202020 00000000 807d7311 20202020 807056ec 1000ec00 00000000 00000000
        806fcb60 806fcb38 807a0000 00000001 00000000 fffffffe 00000000 807d0000
        ...
Call Trace:
[<80048ecc>] show_stack+0x2c/0xf8
[<80645c88>] dump_stack_lvl+0x34/0x4c
[<80641d00>] __warn+0xb4/0xe8
[<80641d84>] warn_slowpath_fmt+0x50/0x88
[<800b177c>] __timer_delete_sync+0x110/0x118
[<8040f4b0>] fza_interrupt+0x904/0x1004
[<80098d7c>] __handle_irq_event_percpu+0x84/0x188
[<80098f1c>] handle_irq_event+0x38/0xbc
[<8009d4e4>] handle_level_irq+0xc8/0x208
[<80098110>] generic_handle_irq+0x44/0x5c
[<8064f450>] do_IRQ+0x1c/0x28
[<80041cf0>] dec_irq_dispatch+0x10/0x20
[<80043754>] handle_int+0x14c/0x158
[<8008bf64>] do_idle+0x5c/0x15c
[<8008c368>] cpu_startup_entry+0x20/0x28
[<8064657c>] kernel_init+0x0/0x114

---[ end trace 0000000000000000 ]---

-- the arrival of this particular device state change interrupt means the 
timer set up just in case the device gets stuck can be deleted, so I'm not 
sure why calling `del_timer_sync' to discard the timer has become a no-no 
now; this code is 20+ years old now, though I sat on it for a while and 
then it took some time and effort to get it upstream too.  The issue has 
started sometime between 5.18 (clean boot) and 6.4 (quoted above).

 Maybe it'll ring someone's bell and they'll chime in or otherwise I'll 
bisect it... sometime.  Or feel free to start yourself with 5.18, as it's 
not terribly old, only a bit and certainly not so as 2.6 is.

  Maciej

