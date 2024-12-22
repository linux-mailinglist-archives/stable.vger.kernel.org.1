Return-Path: <stable+bounces-105563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EFC9FA852
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 22:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118B01886722
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6A7190471;
	Sun, 22 Dec 2024 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyperbeam-com.20230601.gappssmtp.com header.i=@hyperbeam-com.20230601.gappssmtp.com header.b="eBf19n0P"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B71B2941C
	for <stable@vger.kernel.org>; Sun, 22 Dec 2024 21:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734903543; cv=none; b=DvKiXD2vhnmxP/rPwPo8bPmnB8FcSjvFBbbyE+ZIDv45H5rM5nFaeakpAjUu8R+6k5mEnQ87zsUMi7C5Y0OXWmtZuXfAZGjntWBwvccpgmgTfdHhbZpqPvHZkPSAbxv4Vi9rEGlVWQPG2OAbdR6EaEgbo8aQUBpoZg7SmWsih4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734903543; c=relaxed/simple;
	bh=zMot9bOlkKVW2dVkPszCD+yWeb6v8YR8HtcyWdqZWGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9dEvhIklOuOhwtJQVwiFRFl4tH2kG3WzAe6XYRgt8k+iQYpwBIBSmP/9M4WN83Ve08Oia7q8XVahJTXz57LDfesbx1VW+jRU8XKrjjNJ0xl3SbnTMPaULEPjiHyrsvrLqC9zo4/wXzZRhlg/3IdorYia3yPP3jWSRA2gu0pvEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hyperbeam.com; spf=pass smtp.mailfrom=hyperbeam.com; dkim=pass (2048-bit key) header.d=hyperbeam-com.20230601.gappssmtp.com header.i=@hyperbeam-com.20230601.gappssmtp.com header.b=eBf19n0P; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hyperbeam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyperbeam.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-29fb532b668so988525fac.0
        for <stable@vger.kernel.org>; Sun, 22 Dec 2024 13:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hyperbeam-com.20230601.gappssmtp.com; s=20230601; t=1734903540; x=1735508340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DKGqThtPvCObYLRSiCusoHuc+WO5JOWiJwHmBwj4Noc=;
        b=eBf19n0PTIuCYkyldeC7fu0Q6oiFEdyC7imlFfU1k2O6p1Bky003/ZA/7EofE/4E7K
         +BIlLzrljDwxMAV+UDU/Ki8jiGlTT2ealP0o+yg1EKL/W+RJutzxYwahKgYLxSuvyX6S
         ciAaTTIAHq6GAuWDl/sUW3ntErs+wM4nHKir+IsTuInhrldj9eFbkhKYInOG9rVlhaGC
         e6/OC/qJYAplOdLX9kBC+FhfobGTE/us+5sX1DF/3gEww3kLsoX0G0edWhPIwtCGPPTF
         +zjakMFt5OL2t1vGLW+EzzIw5/vefO5dZL+uNNz4FXRXlb8J3jOcecjo2q8lPjN81j5y
         yrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734903540; x=1735508340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKGqThtPvCObYLRSiCusoHuc+WO5JOWiJwHmBwj4Noc=;
        b=c1xQcn1JxSjQz26RsuJvB+nhPHRXuU2b+ERIMaCQ7/ju099DdBeWYluzoFo2kiaDTL
         z7pgjs6QmSbC/mU/Wtj8qKy1gn9wl1tHLBoaFmif7K0DsdSQGtZjsvjKOFASNRF19IAi
         28amJeAZUhdmAzgXp+krjFO5V2z59+vtOoxopGrWJRwxp6LdZxDJy+2eyIe6WMEsLV6o
         VtpVue2K3ooG/wyH6dFXg/w/QAPsOaaEM6OwyArNc5rkro3/dgLjFgrVc0u5xen2GFuj
         0UcQuXCqhmVaFldafwiyC6kTfi/X+I2pMCqWhyeIMqIYOcLhD+sAteRZPiCU3gajfypO
         Y/2g==
X-Gm-Message-State: AOJu0YwOJXiBfai8rICKytdDf6mnuIvWOSWjEX0KAHT+uMn2PWo9QFt4
	SCt/S7YreU9+S3i8+I7BtgAV+oQXDhys3tkFvdCiELPjmwzn6FZPkk4vN3W71Ihl8Gbhrq8QYj8
	xiYSD+NLt6ZWmWkRJ2rH66YMMsKJlxjgpgZDBupfkRA3y5AHZDde/5ooD
X-Gm-Gg: ASbGncvqSZomJu/UJ24wU9zfbVoJ4mHZCkW6ovVjkS7ex9TTH7xS6gbKhnrXOL9ROkW
	zbJVFvScb9v0z0NJKdhzEMOEMEEPSqTOLYrs0M21xga6FOtZGVVmr1n/O3wVl2J6/RCdu
X-Google-Smtp-Source: AGHT+IHekh+ftIf2tzdHtH0LxGVmid/lAS/slmlSIxoJUPPs13YnMxudnri5gABPKQ3mIFEKwhJCEh7UryccrUeYFk8=
X-Received: by 2002:a05:6871:6503:b0:297:23a8:1e0 with SMTP id
 586e51a60fabf-2a7faa8a66cmr5935156fac.0.1734903540285; Sun, 22 Dec 2024
 13:39:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFyAQLvdZVRFYW+xbHCu3j354O4=YDVyygXdw3ozEMfFbHkdig@mail.gmail.com>
 <Z2Vyh91HQ7i6O-6R@calendula> <Z2V3fhnOaOMcCtUt@calendula> <CAFyAQLt3i4Q56aCRXjWZkz=A8rotoPtHKcosRXiM+RF7AYBb4w@mail.gmail.com>
 <Z2fkSV6624wnlTjb@calendula>
In-Reply-To: <Z2fkSV6624wnlTjb@calendula>
From: "Amby @ Hyperbeam" <amby@hyperbeam.com>
Date: Sun, 22 Dec 2024 21:38:49 +0000
Message-ID: <CAFyAQLugB7ELuVZn2tNvKxyNwObU50+61W93e10uAKuF-KEJ+A@mail.gmail.com>
Subject: Re: netfilter regression on aarch64 16k page size
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This also works

On Sun, 22 Dec 2024 at 10:05, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>
> Hi again,
>
> I posted this alternative fix:
>
> https://patchwork.ozlabs.org/project/netfilter-devel/patch/20241222100239.336289-1-pablo@netfilter.org/
>
> in case you have a chance to test it too.
>
> Thanks.
>
> On Fri, Dec 20, 2024 at 08:00:43PM +0000, Amby @ Hyperbeam wrote:
> > The patch worked, thank you!
> >
> > On Fri, 20 Dec 2024 at 13:56, Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > >
> > > Hi,
> > >
> > > Could you give a try to this quick patch?
> > >
> > > I will have to add BUILD_BUG_ON() as well to make sure struct
> > > nft_set_ext is aligned so this atomic operation does not break again.
> > >
> > > Thanks.
> > >
> > > On Fri, Dec 20, 2024 at 02:35:06PM +0100, Pablo Neira Ayuso wrote:
> > > > Hi,
> > > >
> > > > Thanks for your report, it is an unalign atomic that results from
> > > > this.
> > > >
> > > > I will post a patch asap to address this.
> > > >
> > > > On Fri, Dec 20, 2024 at 12:15:36PM +0000, Amby @ Hyperbeam wrote:
> > > > > Greetings,
> > > > > We are seeing a regression in 6.6.66 which I have narrowed down to this commit:
> > > > > stable: 86c27603514cb8ead29857365cdd145404ee9706
> > > > > upstream: 7ffc7481153bbabf3332c6a19b289730c7e1edf5
> > > > >
> > > > > Kernel version: 6.6.66 on aarch64 with 16k page size
> > > > > Last known good version: 6.6.65
> > > > >
> > > > > Steps to repro:
> > > > > - run a 16k page size kernel (check with getconf PAGESIZE)
> > > > > - try to load an nftables config file on the problem
> > > > >
> > > > > Expected:
> > > > > - no errors
> > > > >
> > > > > Actual:
> > > > > - system enters a broken state, with the following trace in dmesg:
> > > > > [   40.939230] Unable to handle kernel paging request at virtual
> > > > > address ffff00015ad7e4cc
> > > > > [   40.939841] Mem abort info:
> > > > > [   40.940079]   ESR = 0x0000000096000021
> > > > > [   40.940389]   EC = 0x25: DABT (current EL), IL = 32 bits
> > > > > [   40.940820]   SET = 0, FnV = 0
> > > > > [   40.941042]   EA = 0, S1PTW = 0
> > > > > [   40.941289]   FSC = 0x21: alignment fault
> > > > > [   40.941570] Data abort info:
> > > > > [   40.941805]   ISV = 0, ISS = 0x00000021, ISS2 = 0x00000000
> > > > > [   40.942229]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > > > > [   40.942857]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > > > > [   40.943313] swapper pgtable: 16k pages, 48-bit VAs, pgdp=00000000474f0000
> > > > > [   40.943865] [ffff00015ad7e4cc] pgd=180000043f7e8003,
> > > > > p4d=180000043f7e8003, pud=180000043f7e4003, pmd=180000043f52c003,
> > > > > pte=006800019ad7cf07
> > > > > [   40.945664] Internal error: Oops: 0000000096000021 [#1] SMP
> > > > > [   40.946055] Modules linked in: zstd zram zsmalloc nf_log_syslog
> > > > > nft_log nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject
> > > > > nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables
> > > > > crct10dif_ce polyval_ce polyval_generic ghash_ce tcp_bbr sch_fq fuse
> > > > > nfnetlink vsock_loopback vmw_vsock_virtio_transport_common
> > > > > vmw_vsock_vmci_transport vmw_vmci vsock bpf_preload qemu_fw_cfg
> > > > > ip_tables squashfs virtio_net net_failover virtio_blk gpio_keys
> > > > > failover virtio_mmio virtio_scsi virtio_console virtio_balloon
> > > > > virtio_gpu virtio_dma_buf megaraid_sas
> > > > > [   40.950262] CPU: 7 PID: 116 Comm: kworker/7:1 Not tainted 6.6.67-1-lts #1
> > > > > [   40.951542] Hardware name: netcup KVM Server, BIOS VPS 2000 ARM G11
> > > > > 08/07/2024
> > > > > [   40.952287] Workqueue: events_power_efficient nft_rhash_gc [nf_tables]
> > > > > [   40.952798] pstate: 20401005 (nzCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
> > > > > [   40.953401] pc : nft_rhash_gc+0x208/0x2c0 [nf_tables]
> > > > > [   40.954054] lr : nft_rhash_gc+0x134/0x2c0 [nf_tables]
> > > > > [   40.954806] sp : ffff800081fb3cf0
> > > > > [   40.955138] x29: ffff800081fb3d50 x28: 0000000000000000 x27: 0000000000000000
> > > > > [   40.955974] x26: ffff0000cc760ef0 x25: ffff0000ccba9c80 x24: ffff0000cc758f78
> > > > > [   40.956750] x23: 0000000000000010 x22: ffff0000ca789000 x21: ffff0000cc760f78
> > > > > [   40.957455] x20: ffffd62d3ac3be40 x19: ffff00015ad7e4c0 x18: 0000000000000000
> > > > > [   40.959005] x17: 0000000000000000 x16: ffffd62d37926880 x15: 000000400002fef8
> > > > > [   40.959614] x14: ffffffffffffffff x13: 0000000000000030 x12: ffff0000cc760ef0
> > > > > [   40.960197] x11: 0000000000000000 x10: ffff800081fb3d08 x9 : ffff0000cba89fe0
> > > > > [   40.960739] x8 : 0000000000000003 x7 : 0000000000000000 x6 : 0000000000000000
> > > > > [   40.961287] x5 : 0000000000000040 x4 : ffff0000cba89ff0 x3 : ffff00015ad7e4c0
> > > > > [   40.961814] x2 : ffff00015ad7e4cc x1 : ffff00015ad7e4cc x0 : 0000000000000004
> > > > > [   40.962339] Call trace:
> > > > > [   40.962531]  nft_rhash_gc+0x208/0x2c0 [nf_tables]
> > > > > [   40.962911]  process_one_work+0x178/0x3e0
> > > > > [   40.963710]  worker_thread+0x2ac/0x3e0
> > > > > [   40.964530]  kthread+0xf0/0x108
> > > > > [   40.966259]  ret_from_fork+0x10/0x20
> > > > > [   40.967287] Code: 54fff9a4 d503201f d2800080 91003261 (f820303f)
> > > > > [   40.968245] ---[ end trace 0000000000000000 ]---
> > > > >
> > > > > faddr2line gave me the following:
> > > > > nft_rhash_gc+0x208/0x2c0:
> > > > > __lse_atomic64_or at
> > > > > /root/gg/setup/linux-lts/src/linux-6.6.67/./arch/arm64/include/asm/atomic_lse.h:132
> > > > > (inlined by) arch_atomic64_or at
> > > > > /root/gg/setup/linux-lts/src/linux-6.6.67/./arch/arm64/include/asm/atomic.h:65
> > > > > (inlined by) raw_atomic64_or at
> > > > > /root/gg/setup/linux-lts/src/linux-6.6.67/./include/linux/atomic/atomic-arch-fallback.h:3771
> > > > > (inlined by) raw_atomic_long_or at
> > > > > /root/gg/setup/linux-lts/src/linux-6.6.67/./include/linux/atomic/atomic-long.h:1069
> > > > > (inlined by) arch_set_bit at
> > > > > /root/gg/setup/linux-lts/src/linux-6.6.67/./include/asm-generic/bitops/atomic.h:18
> > > > > (inlined by) set_bit at
> > > > > /root/gg/setup/linux-lts/src/linux-6.6.67/./include/asm-generic/bitops/instrumented-atomic.h:29
> > > > > (inlined by) nft_set_elem_dead at
> > > > > /root/gg/setup/linux-lts/src/linux-6.6.67/./include/net/netfilter/nf_tables.h:1576
> > > > > (inlined by) nft_rhash_gc at
> > > > > /root/gg/setup/linux-lts/src/linux-6.6.67/net/netfilter/nft_set_hash.c:375
> > > > >
> > > > > By looking at the diff between 6.6.65 and 6.6.66 I was able to narrow
> > > > > it down to the above commit and I can confirm that reverting it fixes
> > > > > the issue.
> > > > >
> > > > > Best
> > > > > --
> > > > > Amby Balaji
> > > > > Co-founder & CTO
> > > > > Hyperbeam, Inc.
> >
> >
> >
> > --
> > Amby Balaji
> > Co-founder & CTO
> > Hyperbeam, Inc.



-- 
Amby Balaji
Co-founder & CTO
Hyperbeam, Inc.

