Return-Path: <stable+bounces-105416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4389F91FD
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 13:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17A5188CF2B
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 12:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770A31C5F14;
	Fri, 20 Dec 2024 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyperbeam-com.20230601.gappssmtp.com header.i=@hyperbeam-com.20230601.gappssmtp.com header.b="go2rczo4"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B1F1C4A1C
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734696951; cv=none; b=LHwUx3aUTt6UnZnwO+4/j6WErTMmQFYwT6ZuhKRVkMaKPXQ9QtbPec2FWT8YUHqwU3xauZ6JvXQMLd7ZR9wAGlEnNHkWmkcLtwO+/7MpVF6A3/NzvLBpL6b4Dos+rapVrMLWDRgBxooLMx1CD+sH7efBPCA7EruYtqlWMYB2YWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734696951; c=relaxed/simple;
	bh=1FfFAy6dqhyPeiJL2W7VmhgU8cgOK5qtgPPuAHaz88E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qlN8zmu/NcxNtr3QzatJHUqm82RF4KF0aLzk1mRpHJS0mrTafMguD0bVhqFRHmP6+UyPF3ZO2QrOAZ/au0anHU0FufTYzLOSn9ns8Zdi+xsh5AvwI/gE3Y90RwxlwnfRUgIK+dQ89LYobl1sXDihdSuYv86773VhKLBYySuKZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hyperbeam.com; spf=pass smtp.mailfrom=hyperbeam.com; dkim=pass (2048-bit key) header.d=hyperbeam-com.20230601.gappssmtp.com header.i=@hyperbeam-com.20230601.gappssmtp.com header.b=go2rczo4; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hyperbeam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyperbeam.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f2e370bb3aso482321eaf.0
        for <stable@vger.kernel.org>; Fri, 20 Dec 2024 04:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hyperbeam-com.20230601.gappssmtp.com; s=20230601; t=1734696947; x=1735301747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NdpCDurukw6jqUijSW3kFmnh8o3vQPLCGbMsoFLI7qs=;
        b=go2rczo4FaugrfGXUBebyPQgwSxiGq7BVy116Ge31YKpIMb4b8HVvB70299B6Ujg22
         xYghyvuXfdaAW2QDoYiSMaSAD7piMoAdpY8s4wgwuCqoA7SsoCOzDtE8h8vlqqP/GfPx
         gQ5EIqjWYD0aYa0OVP6iINQFtGR2usV9DnsgMB/i/2lHt96fe+qpyEdXEruyvTxf1fqk
         DcKAOtvl0q+kPpsyoQAqNeBYFIf9Y3E4z0wGZ8tWD6DDpgS7bD/egy4Y7DDXkdFPe4wZ
         ZQhptMrQjw44q8EpJo+ZzdLhDQ6XDV5tCSKBu0PKt2k2U1forNPpP5x/xlb7GmNHIsAu
         LkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734696947; x=1735301747;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NdpCDurukw6jqUijSW3kFmnh8o3vQPLCGbMsoFLI7qs=;
        b=bNl83HnjIxuZUDe1M8Xoqbjmrj/8s8hY2NNuT65SUT/9wtNrtvu3TsNCdzSa8e5MH2
         hS9hU4pNK7b0Of8yxKy5TbwHT9kMI5ngLbihJGRUROaodpO8EZ7/ehHtQHpor3+57ppy
         bFkgiMmiM5e28ltMupChNl1UDl8B1xSjTLYYBunWarqaS33Ly8UGzU33YhU2xL7Up9XL
         zs2HS1dd+I/4fq7qVXsFRZ92beIoelO3CEedDMdYtz4uC88Ubq8FZLT2vr6D0PGOOEY7
         XWHmux9JqQrwkaN3wlBhCJXFuX8FWYZzH1yfHeCWXga9yOppxjy5pmMdGssAnDaRHPCi
         h4pA==
X-Gm-Message-State: AOJu0YyIe72GtfhTMUPUKKxbF5iTljyjEBRgb8fQFfu8RIPg78dlMTAA
	eFXllbiCXCI+ilGgXrQwLeWWaWFEjTNnP1Lzfc7faBO3Ii/sv/Z2HbkwiOHeUCOZgEfFVVNliZn
	+O/YAM1eH3YljDexpKvo+YalR1ktrIVyRyCfb2l7s6kZNd9lIoY2DVpyq
X-Gm-Gg: ASbGncuhjMH5ygzLqt9D6Ge3l30JDukphwC0YyOF0KQGFHfT7bwsYvk+7IwEqIz68B7
	75XdjvnMX0pxI68YwehwRCe0x23hjthhG5PRmX7riYjFs3FpQx9m9rgGJD2yjbBenVMtL
X-Google-Smtp-Source: AGHT+IHBm+h34Iyifc5RhtxtU/PklG1tn/zIhV+W/kyF4TCUigoyIsLVIH5PX8uPvbtzTrsBD2ftS8V8zwthhFP36Sk=
X-Received: by 2002:a05:6870:2a41:b0:29e:5de2:cffb with SMTP id
 586e51a60fabf-2a7fb0bf91fmr1174528fac.17.1734696947496; Fri, 20 Dec 2024
 04:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Amby @ Hyperbeam" <amby@hyperbeam.com>
Date: Fri, 20 Dec 2024 12:15:36 +0000
Message-ID: <CAFyAQLvdZVRFYW+xbHCu3j354O4=YDVyygXdw3ozEMfFbHkdig@mail.gmail.com>
Subject: netfilter regression on aarch64 16k page size
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, pablo@netfilter.org
Content-Type: text/plain; charset="UTF-8"

Greetings,
We are seeing a regression in 6.6.66 which I have narrowed down to this commit:
stable: 86c27603514cb8ead29857365cdd145404ee9706
upstream: 7ffc7481153bbabf3332c6a19b289730c7e1edf5

Kernel version: 6.6.66 on aarch64 with 16k page size
Last known good version: 6.6.65

Steps to repro:
- run a 16k page size kernel (check with getconf PAGESIZE)
- try to load an nftables config file on the problem

Expected:
- no errors

Actual:
- system enters a broken state, with the following trace in dmesg:
[   40.939230] Unable to handle kernel paging request at virtual
address ffff00015ad7e4cc
[   40.939841] Mem abort info:
[   40.940079]   ESR = 0x0000000096000021
[   40.940389]   EC = 0x25: DABT (current EL), IL = 32 bits
[   40.940820]   SET = 0, FnV = 0
[   40.941042]   EA = 0, S1PTW = 0
[   40.941289]   FSC = 0x21: alignment fault
[   40.941570] Data abort info:
[   40.941805]   ISV = 0, ISS = 0x00000021, ISS2 = 0x00000000
[   40.942229]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   40.942857]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   40.943313] swapper pgtable: 16k pages, 48-bit VAs, pgdp=00000000474f0000
[   40.943865] [ffff00015ad7e4cc] pgd=180000043f7e8003,
p4d=180000043f7e8003, pud=180000043f7e4003, pmd=180000043f52c003,
pte=006800019ad7cf07
[   40.945664] Internal error: Oops: 0000000096000021 [#1] SMP
[   40.946055] Modules linked in: zstd zram zsmalloc nf_log_syslog
nft_log nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject
nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables
crct10dif_ce polyval_ce polyval_generic ghash_ce tcp_bbr sch_fq fuse
nfnetlink vsock_loopback vmw_vsock_virtio_transport_common
vmw_vsock_vmci_transport vmw_vmci vsock bpf_preload qemu_fw_cfg
ip_tables squashfs virtio_net net_failover virtio_blk gpio_keys
failover virtio_mmio virtio_scsi virtio_console virtio_balloon
virtio_gpu virtio_dma_buf megaraid_sas
[   40.950262] CPU: 7 PID: 116 Comm: kworker/7:1 Not tainted 6.6.67-1-lts #1
[   40.951542] Hardware name: netcup KVM Server, BIOS VPS 2000 ARM G11
08/07/2024
[   40.952287] Workqueue: events_power_efficient nft_rhash_gc [nf_tables]
[   40.952798] pstate: 20401005 (nzCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
[   40.953401] pc : nft_rhash_gc+0x208/0x2c0 [nf_tables]
[   40.954054] lr : nft_rhash_gc+0x134/0x2c0 [nf_tables]
[   40.954806] sp : ffff800081fb3cf0
[   40.955138] x29: ffff800081fb3d50 x28: 0000000000000000 x27: 0000000000000000
[   40.955974] x26: ffff0000cc760ef0 x25: ffff0000ccba9c80 x24: ffff0000cc758f78
[   40.956750] x23: 0000000000000010 x22: ffff0000ca789000 x21: ffff0000cc760f78
[   40.957455] x20: ffffd62d3ac3be40 x19: ffff00015ad7e4c0 x18: 0000000000000000
[   40.959005] x17: 0000000000000000 x16: ffffd62d37926880 x15: 000000400002fef8
[   40.959614] x14: ffffffffffffffff x13: 0000000000000030 x12: ffff0000cc760ef0
[   40.960197] x11: 0000000000000000 x10: ffff800081fb3d08 x9 : ffff0000cba89fe0
[   40.960739] x8 : 0000000000000003 x7 : 0000000000000000 x6 : 0000000000000000
[   40.961287] x5 : 0000000000000040 x4 : ffff0000cba89ff0 x3 : ffff00015ad7e4c0
[   40.961814] x2 : ffff00015ad7e4cc x1 : ffff00015ad7e4cc x0 : 0000000000000004
[   40.962339] Call trace:
[   40.962531]  nft_rhash_gc+0x208/0x2c0 [nf_tables]
[   40.962911]  process_one_work+0x178/0x3e0
[   40.963710]  worker_thread+0x2ac/0x3e0
[   40.964530]  kthread+0xf0/0x108
[   40.966259]  ret_from_fork+0x10/0x20
[   40.967287] Code: 54fff9a4 d503201f d2800080 91003261 (f820303f)
[   40.968245] ---[ end trace 0000000000000000 ]---

faddr2line gave me the following:
nft_rhash_gc+0x208/0x2c0:
__lse_atomic64_or at
/root/gg/setup/linux-lts/src/linux-6.6.67/./arch/arm64/include/asm/atomic_lse.h:132
(inlined by) arch_atomic64_or at
/root/gg/setup/linux-lts/src/linux-6.6.67/./arch/arm64/include/asm/atomic.h:65
(inlined by) raw_atomic64_or at
/root/gg/setup/linux-lts/src/linux-6.6.67/./include/linux/atomic/atomic-arch-fallback.h:3771
(inlined by) raw_atomic_long_or at
/root/gg/setup/linux-lts/src/linux-6.6.67/./include/linux/atomic/atomic-long.h:1069
(inlined by) arch_set_bit at
/root/gg/setup/linux-lts/src/linux-6.6.67/./include/asm-generic/bitops/atomic.h:18
(inlined by) set_bit at
/root/gg/setup/linux-lts/src/linux-6.6.67/./include/asm-generic/bitops/instrumented-atomic.h:29
(inlined by) nft_set_elem_dead at
/root/gg/setup/linux-lts/src/linux-6.6.67/./include/net/netfilter/nf_tables.h:1576
(inlined by) nft_rhash_gc at
/root/gg/setup/linux-lts/src/linux-6.6.67/net/netfilter/nft_set_hash.c:375

By looking at the diff between 6.6.65 and 6.6.66 I was able to narrow
it down to the above commit and I can confirm that reverting it fixes
the issue.

Best
-- 
Amby Balaji
Co-founder & CTO
Hyperbeam, Inc.

