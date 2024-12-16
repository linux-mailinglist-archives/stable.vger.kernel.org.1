Return-Path: <stable+bounces-104344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A948D9F3172
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 14:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E801887C3B
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDC4205ABA;
	Mon, 16 Dec 2024 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PBSXqYms"
X-Original-To: stable@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517C420550B;
	Mon, 16 Dec 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734355494; cv=none; b=QCwJgK0lkJeyk2Ork7WwvJiGaCFjaHFMy79ms48bjVAP9iB3W3n4DRVhSYQdsCr3Nqp/K6z/klqBNZGtuxu8evHFT9qh2i/lpnReRCC381QqhPoyJS+L6uqx7pqjvhSHZyHhVafx4BBB6aNMIe/azKVZ9cZH8Vsi05I5abf4eWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734355494; c=relaxed/simple;
	bh=1BG2R38CHTGMQTxvV1ksPFE3kT2GHnsfhJlefq33L/g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdCa/EDIt4OqMRggTSbgonqYIYhubktCRy5/6kR4COePNhWaysCDVEg2TKn38tc3f+KGFH+qezAJCFgto/x+YpHMXdkJ4zMBpJPWPRYbEHQxIVg+L1zVa+oz9qlL+Hu+CJ8W31ZJjJiy+bKgKAqnZEB/PurIEHRUgsJIWlS+pC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PBSXqYms; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734355492; x=1765891492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1BG2R38CHTGMQTxvV1ksPFE3kT2GHnsfhJlefq33L/g=;
  b=PBSXqYmsJ3sOJMAtZ2Hx82WPmPsIrmNHM6pMXgEqA7axw9ct5/wzLRW2
   5vQtAD/z4wQbD9+f4TPfnaYfM9KlvhQMegGzTkhoeS3ey2laf/2okh2fC
   qPvEISAtA5sswF34s9H1j0XiLF+WwVjasV8fbDm+YFCc6zJpCG5WfXdcS
   ILpOcNu1n3ZaMbk+gg1LXG9u1t8Dha4boaN7Ht8WTTxHg7pw/7N6JvWc9
   jc00+z9sZzJ+kZ9LGRFsgOHd+IHnD6TPaGImIJyupDS+/CF6oQHNwc8Ou
   q1YWBXjMWGe5g0g9yUqaGbh5huHOPfKIwyQeUa7FlqBTBc9twrlC4mJ5d
   Q==;
X-CSE-ConnectionGUID: svcZb2o5RoiaLtrIn94HtA==
X-CSE-MsgGUID: ZojOdQ4wRxW+2Ve9w0tkPA==
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="asc'?scan'208";a="35582583"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Dec 2024 06:24:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Dec 2024 06:24:47 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 16 Dec 2024 06:24:46 -0700
Date: Mon, 16 Dec 2024 13:24:14 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<torvalds@linux-foundation.org>, <stable@vger.kernel.org>, <lwn@lwn.net>,
	<jslaby@suse.cz>, Xiangyu Chen <xiangyu.chen@windriver.com>, Zqiang
	<qiang.zhang1211@gmail.com>
Subject: Re: Linux 6.1.120
Message-ID: <20241216-comic-handling-3bcf108cc465@wendy>
References: <2024121411-multiple-activist-51a1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qYEnv7TJdfBvOmAb"
Content-Disposition: inline
In-Reply-To: <2024121411-multiple-activist-51a1@gregkh>

--qYEnv7TJdfBvOmAb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 09:53:13PM +0100, Greg Kroah-Hartman wrote:
> I'm announcing the release of the 6.1.120 kernel.
>=20
> All users of the 6.1 kernel series must upgrade.
>=20
> The updated 6.1.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git li=
nux-6.1.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=
=3Dsummary
>=20
> thanks,
>=20
> greg k-h
>=20
> ------------

> Zqiang (1):
>       rcu-tasks: Fix access non-existent percpu rtpcp variable in rcu_tas=
ks_need_gpcb()

I was AFK last week so I missed reporting this, but on riscv this patch
causes:
[    0.145463] BUG: sleeping function called from invalid context at includ=
e/linux/sched/mm.h:274
[    0.155273] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, na=
me: swapper/0
[    0.164160] preempt_count: 1, expected: 0
[    0.168716] RCU nest depth: 0, expected: 0
[    0.173370] 1 lock held by swapper/0/1:
[    0.177726]  #0: ffffffff81494d78 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, =
at: cblist_init_generic+0x2e/0x374
[    0.188768] irq event stamp: 718
[    0.192439] hardirqs last  enabled at (717): [<ffffffff8098df90>] _raw_s=
pin_unlock_irqrestore+0x34/0x5e
[    0.203098] hardirqs last disabled at (718): [<ffffffff8098de32>] _raw_s=
pin_lock_irqsave+0x24/0x60
[    0.213254] softirqs last  enabled at (0): [<ffffffff800105d2>] copy_pro=
cess+0x50c/0xdac
[    0.222445] softirqs last disabled at (0): [<0000000000000000>] 0x0
[    0.229551] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.119-00350-g224=
fd631c41b #1
[    0.238330] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
[    0.245329] Call Trace:
[    0.248113] [<ffffffff8000678c>] show_stack+0x2c/0x38
[    0.253868] [<ffffffff80984e66>] dump_stack_lvl+0x5e/0x80
[    0.260022] [<ffffffff80984e9c>] dump_stack+0x14/0x20
[    0.265768] [<ffffffff800499b0>] __might_resched+0x200/0x20a
[    0.272217] [<ffffffff80049784>] __might_sleep+0x3c/0x68
[    0.278258] [<ffffffff802022aa>] __kmem_cache_alloc_node+0x64/0x240
[    0.285385] [<ffffffff801b1760>] __kmalloc+0xc0/0x180
[    0.291140] [<ffffffff8008c752>] cblist_init_generic+0x84/0x374
[    0.297857] [<ffffffff80a0b212>] rcu_spawn_tasks_kthread+0x1c/0x72
[    0.304888] [<ffffffff80a0b0e8>] rcu_init_tasks_generic+0x20/0x12e
[    0.311902] [<ffffffff80a00eb8>] kernel_init_freeable+0x56/0xa8
[    0.318638] [<ffffffff80985c10>] kernel_init+0x1a/0x18e
[    0.324574] [<ffffffff80004124>] ret_from_exception+0x0/0x1a

Reverting it fixed the problem.

Cheers,
Conor.

--qYEnv7TJdfBvOmAb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2Ap+gAKCRB4tDGHoIJi
0hqZAP9vytzuouW03UAW50wsdUiu7UWmL0iZGfczix8VqRfDnwD9F1Pp3Bt39Wpb
baXVGpu/yk67xIFig53m9w561Z6qqwI=
=U7cW
-----END PGP SIGNATURE-----

--qYEnv7TJdfBvOmAb--

