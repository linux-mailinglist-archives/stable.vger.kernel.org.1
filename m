Return-Path: <stable+bounces-105516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BB89F9AE3
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 21:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59E71678A8
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 20:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1680A157A48;
	Fri, 20 Dec 2024 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyperbeam-com.20230601.gappssmtp.com header.i=@hyperbeam-com.20230601.gappssmtp.com header.b="SF37onJa"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011119C54A
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 20:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724857; cv=none; b=il8hi9nkJ64fozcaEju1/52Cg4m98XmrgtUSiPs312nSToVbC6vBQ11lsWZDKzSRn0f1fwWD2BYDDRBBqZxVwCfuhc62Ds30HAyFZfOD4Ib62m/1uZWiaLGWyHQxRH/KzGXw8XLRwNKhGH36pjWWS0hNv0dzgaR4qi/Uyr6lVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724857; c=relaxed/simple;
	bh=vHQ9MOun9c8j7IMACjEC8awv3eg0zjdQekEg8RSPYIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HB+1+8c1tBft5hyWff/hXQPUY3RqmCu9ncR37deufqLBTynWz7n1e4SH1B4mMbQ5KzzJMEngNVP3C9MyGaUH/IoJiYceAAEmdN/hzEy6hremM6l+8jzrYudzrK/LIjMKNQtiRqNODh0Q9n3mbxW92j6eifeHwDqDWVycvij9gIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hyperbeam.com; spf=pass smtp.mailfrom=hyperbeam.com; dkim=pass (2048-bit key) header.d=hyperbeam-com.20230601.gappssmtp.com header.i=@hyperbeam-com.20230601.gappssmtp.com header.b=SF37onJa; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hyperbeam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyperbeam.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f33ad7d6faso1599491eaf.0
        for <stable@vger.kernel.org>; Fri, 20 Dec 2024 12:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hyperbeam-com.20230601.gappssmtp.com; s=20230601; t=1734724855; x=1735329655; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cWyQyvBS/31pZhfagIYYSYNwUzVM4tOGatv05Sh9AWo=;
        b=SF37onJaHnXAR/B/+d2nqv7B4qguzRWhc0prH//nVsLuMHUz4HIF5mryi1bmYY8p+d
         XNkVCq4P8tihifg2SzUDgEUl9s6/V8tE3TJDevZwYOof/5KVc9wlRMN/NCBK0ibqXY10
         ii2onxadQaExWcW/Z0ngexlxttUBR4Z+X48pHQDkEdY74rEYZcKesyVsDR0H2u6TzXHJ
         N+FQVb1Am95KwjS1EZ3yhvqsRAiH6Z8Lu9Sa0bmUjMHqI4JV3XeKcimpsmgGsXMhduOn
         UbX/bDp7EmNlTOinFkFc0zMNaUMCRNL5tZQaTRqw6us0MnyhDWHoGRrDKS6IV6Hpb8m+
         P9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734724855; x=1735329655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWyQyvBS/31pZhfagIYYSYNwUzVM4tOGatv05Sh9AWo=;
        b=vqJax+O3HHitzFbBVAmN+1oe6oufGW55jbdDVtVnv7ir/4WaalHjB26gY7UHDdWrLR
         oGNf37wUoKde3QyQgAvwHAGOEaNFySLbqU8gwQqTy3LJY5B1ampizJ0L4lfUy6KZYNJl
         +OUdVqXijcIXa8Z/e/FodWW5PHZ03Px7QsN/FreORNZYc2P7CkA5Gg+9t3Sh/ylulY4x
         L8w4zZkTF4rOhGReP3KBuDMdDUC5HPMive2USRiL7dTN0U0bfxQ4sCv7/9kamKGHbLVN
         J1zL252lFCyuz5U6gWkglH++L24wWwSAdMhnSTEnUxTfWquBmZTjhgjh/G7C3VKCYHG6
         i40Q==
X-Gm-Message-State: AOJu0Yx7gJFG+X45GHoMt8LEDqCk7BeV3OR1DxstcYHoZVjK/yEnNHWP
	xw8ac/Z6+4/xM6TlAV8fE5aXYLODMG2XLHBJ/Siu7EYDjH+KrLnQ2RqHIdtMGSc5Q3zJ+3n1ERZ
	v3X/cxkYokDrJwh+DY9T028Dl+SAVrQzx9Y32j2xHtqmr3OOjMdvkfcrb
X-Gm-Gg: ASbGncunCvd+GEe4jsjKn78UtT+8GZD9pddvQPvUYy1ZLAZ9qulOYg7koSLUNLlT7Xg
	gKagKupTSGbcwu8LchUyNI4UVLNkZ9mayZjZ0LSh3TwvTJyKWDA2MgiIM5tAyvXpsoltN
X-Google-Smtp-Source: AGHT+IEeIEon9OZsXMC3D1tFzGDF0ozIN/TNpmhgniTzEKmthZl9Zwap9xzsOKh5OrYVZO5V45ftQxbqmm4ocDG/NU0=
X-Received: by 2002:a4a:ee08:0:b0:5f2:8c8:a977 with SMTP id
 006d021491bc7-5f62e79d1aemr2191582eaf.8.1734724854865; Fri, 20 Dec 2024
 12:00:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFyAQLvdZVRFYW+xbHCu3j354O4=YDVyygXdw3ozEMfFbHkdig@mail.gmail.com>
 <Z2Vyh91HQ7i6O-6R@calendula> <Z2V3fhnOaOMcCtUt@calendula>
In-Reply-To: <Z2V3fhnOaOMcCtUt@calendula>
From: "Amby @ Hyperbeam" <amby@hyperbeam.com>
Date: Fri, 20 Dec 2024 20:00:43 +0000
Message-ID: <CAFyAQLt3i4Q56aCRXjWZkz=A8rotoPtHKcosRXiM+RF7AYBb4w@mail.gmail.com>
Subject: Re: netfilter regression on aarch64 16k page size
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The patch worked, thank you!

On Fri, 20 Dec 2024 at 13:56, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>
> Hi,
>
> Could you give a try to this quick patch?
>
> I will have to add BUILD_BUG_ON() as well to make sure struct
> nft_set_ext is aligned so this atomic operation does not break again.
>
> Thanks.
>
> On Fri, Dec 20, 2024 at 02:35:06PM +0100, Pablo Neira Ayuso wrote:
> > Hi,
> >
> > Thanks for your report, it is an unalign atomic that results from
> > this.
> >
> > I will post a patch asap to address this.
> >
> > On Fri, Dec 20, 2024 at 12:15:36PM +0000, Amby @ Hyperbeam wrote:
> > > Greetings,
> > > We are seeing a regression in 6.6.66 which I have narrowed down to this commit:
> > > stable: 86c27603514cb8ead29857365cdd145404ee9706
> > > upstream: 7ffc7481153bbabf3332c6a19b289730c7e1edf5
> > >
> > > Kernel version: 6.6.66 on aarch64 with 16k page size
> > > Last known good version: 6.6.65
> > >
> > > Steps to repro:
> > > - run a 16k page size kernel (check with getconf PAGESIZE)
> > > - try to load an nftables config file on the problem
> > >
> > > Expected:
> > > - no errors
> > >
> > > Actual:
> > > - system enters a broken state, with the following trace in dmesg:
> > > [   40.939230] Unable to handle kernel paging request at virtual
> > > address ffff00015ad7e4cc
> > > [   40.939841] Mem abort info:
> > > [   40.940079]   ESR = 0x0000000096000021
> > > [   40.940389]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > [   40.940820]   SET = 0, FnV = 0
> > > [   40.941042]   EA = 0, S1PTW = 0
> > > [   40.941289]   FSC = 0x21: alignment fault
> > > [   40.941570] Data abort info:
> > > [   40.941805]   ISV = 0, ISS = 0x00000021, ISS2 = 0x00000000
> > > [   40.942229]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > > [   40.942857]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > > [   40.943313] swapper pgtable: 16k pages, 48-bit VAs, pgdp=00000000474f0000
> > > [   40.943865] [ffff00015ad7e4cc] pgd=180000043f7e8003,
> > > p4d=180000043f7e8003, pud=180000043f7e4003, pmd=180000043f52c003,
> > > pte=006800019ad7cf07
> > > [   40.945664] Internal error: Oops: 0000000096000021 [#1] SMP
> > > [   40.946055] Modules linked in: zstd zram zsmalloc nf_log_syslog
> > > nft_log nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject
> > > nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables
> > > crct10dif_ce polyval_ce polyval_generic ghash_ce tcp_bbr sch_fq fuse
> > > nfnetlink vsock_loopback vmw_vsock_virtio_transport_common
> > > vmw_vsock_vmci_transport vmw_vmci vsock bpf_preload qemu_fw_cfg
> > > ip_tables squashfs virtio_net net_failover virtio_blk gpio_keys
> > > failover virtio_mmio virtio_scsi virtio_console virtio_balloon
> > > virtio_gpu virtio_dma_buf megaraid_sas
> > > [   40.950262] CPU: 7 PID: 116 Comm: kworker/7:1 Not tainted 6.6.67-1-lts #1
> > > [   40.951542] Hardware name: netcup KVM Server, BIOS VPS 2000 ARM G11
> > > 08/07/2024
> > > [   40.952287] Workqueue: events_power_efficient nft_rhash_gc [nf_tables]
> > > [   40.952798] pstate: 20401005 (nzCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
> > > [   40.953401] pc : nft_rhash_gc+0x208/0x2c0 [nf_tables]
> > > [   40.954054] lr : nft_rhash_gc+0x134/0x2c0 [nf_tables]
> > > [   40.954806] sp : ffff800081fb3cf0
> > > [   40.955138] x29: ffff800081fb3d50 x28: 0000000000000000 x27: 0000000000000000
> > > [   40.955974] x26: ffff0000cc760ef0 x25: ffff0000ccba9c80 x24: ffff0000cc758f78
> > > [   40.956750] x23: 0000000000000010 x22: ffff0000ca789000 x21: ffff0000cc760f78
> > > [   40.957455] x20: ffffd62d3ac3be40 x19: ffff00015ad7e4c0 x18: 0000000000000000
> > > [   40.959005] x17: 0000000000000000 x16: ffffd62d37926880 x15: 000000400002fef8
> > > [   40.959614] x14: ffffffffffffffff x13: 0000000000000030 x12: ffff0000cc760ef0
> > > [   40.960197] x11: 0000000000000000 x10: ffff800081fb3d08 x9 : ffff0000cba89fe0
> > > [   40.960739] x8 : 0000000000000003 x7 : 0000000000000000 x6 : 0000000000000000
> > > [   40.961287] x5 : 0000000000000040 x4 : ffff0000cba89ff0 x3 : ffff00015ad7e4c0
> > > [   40.961814] x2 : ffff00015ad7e4cc x1 : ffff00015ad7e4cc x0 : 0000000000000004
> > > [   40.962339] Call trace:
> > > [   40.962531]  nft_rhash_gc+0x208/0x2c0 [nf_tables]
> > > [   40.962911]  process_one_work+0x178/0x3e0
> > > [   40.963710]  worker_thread+0x2ac/0x3e0
> > > [   40.964530]  kthread+0xf0/0x108
> > > [   40.966259]  ret_from_fork+0x10/0x20
> > > [   40.967287] Code: 54fff9a4 d503201f d2800080 91003261 (f820303f)
> > > [   40.968245] ---[ end trace 0000000000000000 ]---
> > >
> > > faddr2line gave me the following:
> > > nft_rhash_gc+0x208/0x2c0:
> > > __lse_atomic64_or at
> > > /root/gg/setup/linux-lts/src/linux-6.6.67/./arch/arm64/include/asm/atomic_lse.h:132
> > > (inlined by) arch_atomic64_or at
> > > /root/gg/setup/linux-lts/src/linux-6.6.67/./arch/arm64/include/asm/atomic.h:65
> > > (inlined by) raw_atomic64_or at
> > > /root/gg/setup/linux-lts/src/linux-6.6.67/./include/linux/atomic/atomic-arch-fallback.h:3771
> > > (inlined by) raw_atomic_long_or at
> > > /root/gg/setup/linux-lts/src/linux-6.6.67/./include/linux/atomic/atomic-long.h:1069
> > > (inlined by) arch_set_bit at
> > > /root/gg/setup/linux-lts/src/linux-6.6.67/./include/asm-generic/bitops/atomic.h:18
> > > (inlined by) set_bit at
> > > /root/gg/setup/linux-lts/src/linux-6.6.67/./include/asm-generic/bitops/instrumented-atomic.h:29
> > > (inlined by) nft_set_elem_dead at
> > > /root/gg/setup/linux-lts/src/linux-6.6.67/./include/net/netfilter/nf_tables.h:1576
> > > (inlined by) nft_rhash_gc at
> > > /root/gg/setup/linux-lts/src/linux-6.6.67/net/netfilter/nft_set_hash.c:375
> > >
> > > By looking at the diff between 6.6.65 and 6.6.66 I was able to narrow
> > > it down to the above commit and I can confirm that reverting it fixes
> > > the issue.
> > >
> > > Best
> > > --
> > > Amby Balaji
> > > Co-founder & CTO
> > > Hyperbeam, Inc.



-- 
Amby Balaji
Co-founder & CTO
Hyperbeam, Inc.

