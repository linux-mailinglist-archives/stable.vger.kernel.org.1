Return-Path: <stable+bounces-105180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A45089F6B28
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 17:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B2718976F2
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE791F4E58;
	Wed, 18 Dec 2024 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HseMFRq7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574394690;
	Wed, 18 Dec 2024 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734539376; cv=none; b=ng/cUbsDYrMgGl+xAgumOMa2h+fmJ9l7l959uUuhk3emkc0IO4hBz9K+jzHp9vK/uT28pN7L9fPWX+6ho/vVbfcRknLh/YGPpnhSB6nYe+AkNUVAlWY9mvC6Zj2oPvztggUDnNGT4UEPdJ4YApuoiKXpLDEmL3brKXhPDPsi1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734539376; c=relaxed/simple;
	bh=we+bkn3th2/V0frqnUXAEvGi2TCPWGTfiOOLirLF3cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asWgSKYe5YIXf5Cb8tAfVXDc5FaLkc6f+jhkpkrtACSEhq8lEpBWKqEJcxQdCcw5xKQv0JC3mlauU1aNsTxKCU15G2hLpE3zS193LOAy3XcjeizckfaKpwLHYVmTnw+BZhMLRHzISitgqQ32GhrKbkHII1Udq1tCTtRNfi7Ib8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HseMFRq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19261C4CECD;
	Wed, 18 Dec 2024 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734539376;
	bh=we+bkn3th2/V0frqnUXAEvGi2TCPWGTfiOOLirLF3cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HseMFRq7WsXYKZtjqjD8Er3HvWAKv9pWsEAuYd8TFVzPS8wp7bTd8b9IJIlmdK31h
	 SVh7vehr45+EDuCUgreBjSqvXrET6WHgqc9Nv5LklBJ79SmNdI8V1NmJGI0P4CXMJs
	 kpHnLjENGjxbaobrbkA3QJTqsz3PUiSO208O6C/UjZH+oZvFRcPYeZaYDDYSPD1xRa
	 NR0JdozDcYbrtRxCaLpKVJBvT3ip02sG8BcYJzG3mGPyQv8pvb2wkAN6X5UCgXz1X1
	 +acaezp91W2Upm56nWLlK4QXTf5ysJs7aNTCTApQ0r9/Bko1BWbbxEh7H9iyRA0vHw
	 UAbqFCTeq6Wvw==
Date: Wed, 18 Dec 2024 16:29:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Z qiang <qiang.zhang1211@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Xiangyu Chen <xiangyu.chen@windriver.com>,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz, rcu <rcu@vger.kernel.org>
Subject: Re: Linux 6.1.120
Message-ID: <20241218-erupt-gratitude-1718d36bd1ac@spud>
References: <2024121411-multiple-activist-51a1@gregkh>
 <20241216-comic-handling-3bcf108cc465@wendy>
 <CALm+0cVd=yhCTXm4j+OcqiBQwwC=bf2ja7iQ87ypBb7KD2qbjA@mail.gmail.com>
 <2024121703-bobbed-paced-99a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YCh2qtl9xQ1a9WEY"
Content-Disposition: inline
In-Reply-To: <2024121703-bobbed-paced-99a5@gregkh>


--YCh2qtl9xQ1a9WEY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 09:28:18AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Dec 17, 2024 at 04:11:21PM +0800, Z qiang wrote:
> > >
> > > On Sat, Dec 14, 2024 at 09:53:13PM +0100, Greg Kroah-Hartman wrote:
> > > > I'm announcing the release of the 6.1.120 kernel.
> > > >
> > > > All users of the 6.1 kernel series must upgrade.
> > > >
> > > > The updated 6.1.y git tree can be found at:
> > > >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git linux-6.1.y
> > > > and can be browsed at the normal kernel.org git web browser:
> > > >       https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-sta=
ble.git;a=3Dsummary
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > >
> > > > ------------
> > >
> > > > Zqiang (1):
> > > >       rcu-tasks: Fix access non-existent percpu rtpcp variable in r=
cu_tasks_need_gpcb()
> > >
> > > I was AFK last week so I missed reporting this, but on riscv this pat=
ch
> > > causes:
> > > [    0.145463] BUG: sleeping function called from invalid context at =
include/linux/sched/mm.h:274
> > > [    0.155273] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid:=
 1, name: swapper/0
> > > [    0.164160] preempt_count: 1, expected: 0
> > > [    0.168716] RCU nest depth: 0, expected: 0
> > > [    0.173370] 1 lock held by swapper/0/1:
> > > [    0.177726]  #0: ffffffff81494d78 (rcu_tasks.cbs_gbl_lock){....}-{=
2:2}, at: cblist_init_generic+0x2e/0x374
> > > [    0.188768] irq event stamp: 718
> > > [    0.192439] hardirqs last  enabled at (717): [<ffffffff8098df90>] =
_raw_spin_unlock_irqrestore+0x34/0x5e
> > > [    0.203098] hardirqs last disabled at (718): [<ffffffff8098de32>] =
_raw_spin_lock_irqsave+0x24/0x60
> > > [    0.213254] softirqs last  enabled at (0): [<ffffffff800105d2>] co=
py_process+0x50c/0xdac
> > > [    0.222445] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > > [    0.229551] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.119-0035=
0-g224fd631c41b #1
> > > [    0.238330] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
> > > [    0.245329] Call Trace:
> > > [    0.248113] [<ffffffff8000678c>] show_stack+0x2c/0x38
> > > [    0.253868] [<ffffffff80984e66>] dump_stack_lvl+0x5e/0x80
> > > [    0.260022] [<ffffffff80984e9c>] dump_stack+0x14/0x20
> > > [    0.265768] [<ffffffff800499b0>] __might_resched+0x200/0x20a
> > > [    0.272217] [<ffffffff80049784>] __might_sleep+0x3c/0x68
> > > [    0.278258] [<ffffffff802022aa>] __kmem_cache_alloc_node+0x64/0x240
> > > [    0.285385] [<ffffffff801b1760>] __kmalloc+0xc0/0x180
> > > [    0.291140] [<ffffffff8008c752>] cblist_init_generic+0x84/0x374
> > > [    0.297857] [<ffffffff80a0b212>] rcu_spawn_tasks_kthread+0x1c/0x72
> > > [    0.304888] [<ffffffff80a0b0e8>] rcu_init_tasks_generic+0x20/0x12e
> > > [    0.311902] [<ffffffff80a00eb8>] kernel_init_freeable+0x56/0xa8
> > > [    0.318638] [<ffffffff80985c10>] kernel_init+0x1a/0x18e
> > > [    0.324574] [<ffffffff80004124>] ret_from_exception+0x0/0x1a
> > >
> >=20
> > Hello, Xiangyu
> >=20
> > For v6.1.x kernels, the cblist_init_generic() is invoke in init task co=
ntext,
> > rtp->rtpcp_array is allocated use GFP_KERENL and in the critical section
> > holding rcu_tasks.cbs_gbl_lock spinlock.  so might_resched() trigger wa=
rnings.
> > You should perform the operation of allocating rtpcp_array memory outsi=
de
> > the spinlock.
> > Are you willing to resend the patch?
>=20
> So should I revert this, or do you have a fixup patch somewhere?

Is it too soon to push for a revert? It's interfering with my CIs
attempts to test the 121-rc.

Cheers,
Conor.

--YCh2qtl9xQ1a9WEY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2L4awAKCRB4tDGHoIJi
0j0YAPkBcWLo4gBdt4T7avkEGOLjDEepAsi2RpNtdHc4u+zMbAEA+4x9kKVhSGqd
zadQyxYcPQaIr6Z24dyXOJWML1CGoAM=
=+Abg
-----END PGP SIGNATURE-----

--YCh2qtl9xQ1a9WEY--

