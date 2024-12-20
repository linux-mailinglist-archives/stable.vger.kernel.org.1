Return-Path: <stable+bounces-105423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C12B9F93E5
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 15:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3CF189BD78
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 13:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012C1217F21;
	Fri, 20 Dec 2024 13:56:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEF9215791
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702980; cv=none; b=ZXRDY80/LyrrmDTkoMd3HbR735rmW2pmi/Xo22xDG/quhezEK3bcWKe5zgDmHpoIB5lqjnm7/bEgCIbq9a6wZljK+ryVChPOIAbnOLDvQ+eET0cNliEHJBtLNXmnLB3ik+s0wrGGGcUQ1rtJhhQGAf41lTOp63UXNx99RikHb1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702980; c=relaxed/simple;
	bh=3hGqrhKFcrKkvRe+G8Rh20cZ/+99HqJNywEtAksexLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/x4JjTrq2iJ1IG82bCIOY9Llj/gF05G53BEZOQhPFUF8t7rzXKpxpCBQ4sNP45Hmf7MV7YGAQCpzO8Ug+uH619pfB3flJaTHCA504pZ9B8JX1c7I0tE1P59ZAlXhNiauoArIZAP7Cg9FoEw4p6WVbY8Q1uNQ5U8ovq9xPjksDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Fri, 20 Dec 2024 14:56:14 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: "Amby @ Hyperbeam" <amby@hyperbeam.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: netfilter regression on aarch64 16k page size
Message-ID: <Z2V3fhnOaOMcCtUt@calendula>
References: <CAFyAQLvdZVRFYW+xbHCu3j354O4=YDVyygXdw3ozEMfFbHkdig@mail.gmail.com>
 <Z2Vyh91HQ7i6O-6R@calendula>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Ab6WoS8MlxnOlWYE"
Content-Disposition: inline
In-Reply-To: <Z2Vyh91HQ7i6O-6R@calendula>


--Ab6WoS8MlxnOlWYE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

Could you give a try to this quick patch?

I will have to add BUILD_BUG_ON() as well to make sure struct
nft_set_ext is aligned so this atomic operation does not break again.

Thanks.

On Fri, Dec 20, 2024 at 02:35:06PM +0100, Pablo Neira Ayuso wrote:
> Hi,
> 
> Thanks for your report, it is an unalign atomic that results from
> this.
> 
> I will post a patch asap to address this.
> 
> On Fri, Dec 20, 2024 at 12:15:36PM +0000, Amby @ Hyperbeam wrote:
> > Greetings,
> > We are seeing a regression in 6.6.66 which I have narrowed down to this commit:
> > stable: 86c27603514cb8ead29857365cdd145404ee9706
> > upstream: 7ffc7481153bbabf3332c6a19b289730c7e1edf5
> > 
> > Kernel version: 6.6.66 on aarch64 with 16k page size
> > Last known good version: 6.6.65
> > 
> > Steps to repro:
> > - run a 16k page size kernel (check with getconf PAGESIZE)
> > - try to load an nftables config file on the problem
> > 
> > Expected:
> > - no errors
> > 
> > Actual:
> > - system enters a broken state, with the following trace in dmesg:
> > [   40.939230] Unable to handle kernel paging request at virtual
> > address ffff00015ad7e4cc
> > [   40.939841] Mem abort info:
> > [   40.940079]   ESR = 0x0000000096000021
> > [   40.940389]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [   40.940820]   SET = 0, FnV = 0
> > [   40.941042]   EA = 0, S1PTW = 0
> > [   40.941289]   FSC = 0x21: alignment fault
> > [   40.941570] Data abort info:
> > [   40.941805]   ISV = 0, ISS = 0x00000021, ISS2 = 0x00000000
> > [   40.942229]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> > [   40.942857]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [   40.943313] swapper pgtable: 16k pages, 48-bit VAs, pgdp=00000000474f0000
> > [   40.943865] [ffff00015ad7e4cc] pgd=180000043f7e8003,
> > p4d=180000043f7e8003, pud=180000043f7e4003, pmd=180000043f52c003,
> > pte=006800019ad7cf07
> > [   40.945664] Internal error: Oops: 0000000096000021 [#1] SMP
> > [   40.946055] Modules linked in: zstd zram zsmalloc nf_log_syslog
> > nft_log nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject
> > nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables
> > crct10dif_ce polyval_ce polyval_generic ghash_ce tcp_bbr sch_fq fuse
> > nfnetlink vsock_loopback vmw_vsock_virtio_transport_common
> > vmw_vsock_vmci_transport vmw_vmci vsock bpf_preload qemu_fw_cfg
> > ip_tables squashfs virtio_net net_failover virtio_blk gpio_keys
> > failover virtio_mmio virtio_scsi virtio_console virtio_balloon
> > virtio_gpu virtio_dma_buf megaraid_sas
> > [   40.950262] CPU: 7 PID: 116 Comm: kworker/7:1 Not tainted 6.6.67-1-lts #1
> > [   40.951542] Hardware name: netcup KVM Server, BIOS VPS 2000 ARM G11
> > 08/07/2024
> > [   40.952287] Workqueue: events_power_efficient nft_rhash_gc [nf_tables]
> > [   40.952798] pstate: 20401005 (nzCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
> > [   40.953401] pc : nft_rhash_gc+0x208/0x2c0 [nf_tables]
> > [   40.954054] lr : nft_rhash_gc+0x134/0x2c0 [nf_tables]
> > [   40.954806] sp : ffff800081fb3cf0
> > [   40.955138] x29: ffff800081fb3d50 x28: 0000000000000000 x27: 0000000000000000
> > [   40.955974] x26: ffff0000cc760ef0 x25: ffff0000ccba9c80 x24: ffff0000cc758f78
> > [   40.956750] x23: 0000000000000010 x22: ffff0000ca789000 x21: ffff0000cc760f78
> > [   40.957455] x20: ffffd62d3ac3be40 x19: ffff00015ad7e4c0 x18: 0000000000000000
> > [   40.959005] x17: 0000000000000000 x16: ffffd62d37926880 x15: 000000400002fef8
> > [   40.959614] x14: ffffffffffffffff x13: 0000000000000030 x12: ffff0000cc760ef0
> > [   40.960197] x11: 0000000000000000 x10: ffff800081fb3d08 x9 : ffff0000cba89fe0
> > [   40.960739] x8 : 0000000000000003 x7 : 0000000000000000 x6 : 0000000000000000
> > [   40.961287] x5 : 0000000000000040 x4 : ffff0000cba89ff0 x3 : ffff00015ad7e4c0
> > [   40.961814] x2 : ffff00015ad7e4cc x1 : ffff00015ad7e4cc x0 : 0000000000000004
> > [   40.962339] Call trace:
> > [   40.962531]  nft_rhash_gc+0x208/0x2c0 [nf_tables]
> > [   40.962911]  process_one_work+0x178/0x3e0
> > [   40.963710]  worker_thread+0x2ac/0x3e0
> > [   40.964530]  kthread+0xf0/0x108
> > [   40.966259]  ret_from_fork+0x10/0x20
> > [   40.967287] Code: 54fff9a4 d503201f d2800080 91003261 (f820303f)
> > [   40.968245] ---[ end trace 0000000000000000 ]---
> > 
> > faddr2line gave me the following:
> > nft_rhash_gc+0x208/0x2c0:
> > __lse_atomic64_or at
> > /root/gg/setup/linux-lts/src/linux-6.6.67/./arch/arm64/include/asm/atomic_lse.h:132
> > (inlined by) arch_atomic64_or at
> > /root/gg/setup/linux-lts/src/linux-6.6.67/./arch/arm64/include/asm/atomic.h:65
> > (inlined by) raw_atomic64_or at
> > /root/gg/setup/linux-lts/src/linux-6.6.67/./include/linux/atomic/atomic-arch-fallback.h:3771
> > (inlined by) raw_atomic_long_or at
> > /root/gg/setup/linux-lts/src/linux-6.6.67/./include/linux/atomic/atomic-long.h:1069
> > (inlined by) arch_set_bit at
> > /root/gg/setup/linux-lts/src/linux-6.6.67/./include/asm-generic/bitops/atomic.h:18
> > (inlined by) set_bit at
> > /root/gg/setup/linux-lts/src/linux-6.6.67/./include/asm-generic/bitops/instrumented-atomic.h:29
> > (inlined by) nft_set_elem_dead at
> > /root/gg/setup/linux-lts/src/linux-6.6.67/./include/net/netfilter/nf_tables.h:1576
> > (inlined by) nft_rhash_gc at
> > /root/gg/setup/linux-lts/src/linux-6.6.67/net/netfilter/nft_set_hash.c:375
> > 
> > By looking at the diff between 6.6.65 and 6.6.66 I was able to narrow
> > it down to the above commit and I can confirm that reverting it fixes
> > the issue.
> > 
> > Best
> > -- 
> > Amby Balaji
> > Co-founder & CTO
> > Hyperbeam, Inc.

--Ab6WoS8MlxnOlWYE
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="x.patch"

diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 8bfac4185ac7..614caac77d74 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -31,7 +31,7 @@ struct nft_rhash_elem {
 	struct nft_elem_priv		priv;
 	struct rhash_head		node;
 	u32				wq_gc_seq;
-	struct nft_set_ext		ext;
+	struct nft_set_ext		ext __aligned(BITS_PER_LONG/8);
 };
 
 struct nft_rhash_cmp_arg {

--Ab6WoS8MlxnOlWYE--

