Return-Path: <stable+bounces-139195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B0AAA50ED
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 17:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6802E9C262F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11BD2609CA;
	Wed, 30 Apr 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pA3uuqIQ"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512132609E7;
	Wed, 30 Apr 2025 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746028543; cv=none; b=gRQkLfD5dHgqvwA9OsyL9eK0pLJ2nIBPik11NFUPkdlfCeRQmpuI7miTZzMHz6wIVtDTuDkmdvSG1BJKvHwkLWqa+bjRfm0nbZeCnYDkoYxBKMcIJ9GEkNR7oneLIlOuQzZuZ6AV+pHdDqJIGJuuhTPMSgYLpH7+IrUg4Xw691k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746028543; c=relaxed/simple;
	bh=+JXoaVoHenjG954ba5dKyZPYNK27ST3kxl9wXSkAN1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsI/ICKgW46tnc0h2uVzSC84CFmu3Rus2L5obphiyg+qrMlTTk+lQa6KdYA56AqH+h7VMa+c9L5QmOnjez06Gv3Q0AaueexGhv83p4t1DpTIIGn4OFAq+jZyQ3hypRn2TLlLoyuWtV+CPQZzmilPVJ5xLEzIPoq/ykqplg8GvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pA3uuqIQ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=I73XHLNQTp7Wr64bs/mquN9tVIb/sMfP5hdchGohZks=; b=pA3uuqIQkBFb0qhweTymlq0SUc
	pBxbk6sk/b25JvzcPpL8aNrqFSvgDKWSANOMUo3C2IF+HLKofBlF4ocgV8eiPnn8K6mqrQq5mQEyU
	DLTlJ3vyTYcqy1AayAqzTdsb2Rc+BAbbWJW5denkIcONl9durgFDjaXdQnZXb1jtbLhZqKTYOJNFG
	EbiK4nm1liGHbO9G7KkD0yiYZs8rNWdgGyRIcR4zyul5Va92fWFb6at5/d9U0aESZFQY4QAie9RC+
	+rarvkQx6KdFB93EK3b9SpfEahr71CwL6k0xjJs3OVOs8omZR21fHnmQAm2qIY6kD6UoNxKXAfZiA
	qmHHdQlQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1uA9mM-00GUQz-OM; Wed, 30 Apr 2025 15:55:23 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 8A7C7BE2DE0; Wed, 30 Apr 2025 17:55:20 +0200 (CEST)
Date: Wed, 30 Apr 2025 17:55:20 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Melvin Vermeeren <vermeeren@vermwa.re>, Yu Kuai <yukuai3@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: 1104460@bugs.debian.org, Coly Li <colyli@kernel.org>,
	Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
	regressions@lists.linux.dev
Subject: [regression 6.1.y] discard/TRIM through RAID10 blocking (was: Re:
 Bug#1104460: linux-image-6.1.0-34-powerpc64le: Discard broken) with RAID10:
 BUG: kernel tried to execute user page (0) - exploit attempt?
Message-ID: <aBJH6Nsh-7Zj55nN@eldamar.lan>
References: <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <174602441004.174814.6400502946223473449.reportbug@talos.vermwa.re>
X-Debian-User: carnil

Hi

We got a regression report in Debian after the update from 6.1.133 to
6.1.135. Melvin is reporting that discard/trimm trhough a RAID10 array
stalls idefintively. The full report is inlined below and originates
=66rom https://bugs.debian.org/1104460 .

On Wed, Apr 30, 2025 at 04:46:50PM +0200, Melvin Vermeeren wrote:
> Package: src:linux
> Version: 6.1.135-1
> Severity: important
> Tags: upstream
> X-Debbugs-Cc: vermeeren@vermwa.re
>=20
> Dear Maintainer,
>=20
> Upgrading from linux-image-6.1.0-33-powerpc64le (6.1.133-1) to
> linux-image-6.1.0-34-powerpc64le (6.1.135-1) it appears there is a
> serious regression bug related to discard/TRIM through a RAID10 array.
> This only affects RAID10, RAID1 array on the same SSD device is not
> affected. Array in question is a fairly standard RAID10 in 2far layout.
>=20
> md127 : active raid10 dm-1[2] dm-0[0]
>       1872188416 blocks super 1.2 512K chunks 2 far-copies [2/2] [UU]
>       bitmap: 1/1 pages [64KB], 65536KB chunk
>=20
> Any discard operation will result in quite a long kernel error. The
> calling process will either segfault (swapon) or, more likely, be stuck
> forever (Qemu, fstrim) in the D state per htop. The iostat utility
> reports a %util of 100% for any device on top of (directly or
> indirectly) of the RAID10 device, despite there being no read or write
> requests to the devices or any other acitivty.
>=20
> Stuck processes cannot be terminated or killed. Attempting to reboot
> normally will result in a stuck machine on shutdown, so only a
> REISUB-style reboot will work via procfs sysrq.
>=20
> I have briefly diffed and inspected commits between the two kernel
> versions and I suspect the commit below may be at fault. Do keep in mind
> I have not verified this in any way, so I may be wrong.
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
id=3D4a05f7ae33716d996c5ce56478a36a3ede1d76f2
>=20
> Considering this is shipped as part of a stable security update I
> consider it quite a serious bug. Affected hosts will not boot up
> cleanly, may not have swap, processes will freeze upon discard and clean
> reboot it also not possible.
>=20
> More logs available upon request.
>=20
> Many thanks,
>=20
> Melvin Vermeeren.
>=20
> -- Package-specific info:
> ** Version:
> Linux version 6.1.0-34-powerpc64le (debian-kernel@lists.debian.org) (gcc-=
12 (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP=
 Debian 6.1.135-1 (2025-04-25)
>=20
> ** Command line:
> root=3D/dev/mapper/...-root ro quiet
>=20
> ** Not tainted
>=20
> ** Kernel log:
> # /etc/fstab entry
> /dev/.../swap none swap sw,discard=3Donce 0 0
>=20
> ~# swapon -va
> swapon: /dev/mapper/...-swap: found signature [pagesize=3D65536, signatur=
e=3Dswap]
> swapon: /dev/mapper/...-swap: pagesize=3D65536, swapsize=3D17179869184, d=
evsize=3D17179869184
> swapon /dev/mapper/...-swap
> Segmentation fault
>=20
> ~# dmesg
> ...
> [  223.017257] kernel tried to execute user page (0) - exploit attempt? (=
uid: 0)
> [  223.017287] BUG: Unable to handle kernel instruction fetch (NULL point=
er?)
> [  223.017301] Faulting instruction address: 0x00000000
> [  223.017326] Oops: Kernel access of bad area, sig: 11 [#1]
> [  223.017338] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA Pow=
erNV
> [  223.017365] Modules linked in: bridge stp llc binfmt_misc nft_connlimi=
t nf_conncount ast drm_vram_helper drm_ttm_helper ofpart ipmi_powernv ttm i=
pmi_devintf powernv_flash at24 mtd ipmi_msghandler opal_prd regmap_i2c drm_=
kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops i2c_algo_bit sg nf=
t_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fi=
b nf_tables nfnetlink drm loop fuse drm_panel_orientation_quirks configfs i=
p_tables x_tables autofs4 ext4 crc16 mbcache jbd2 dm_crypt dm_integrity dm_=
bufio dm_mod macvlan raid10 raid456 async_raid6_recov async_memcpy async_pq=
 async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 multi=
path linear md_mod sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc_=
t10dif crct10dif_generic crc64 crct10dif_common xhci_pci xts ecb xhci_hcd c=
tr vmx_crypto gf128mul crc32c_vpmsum tg3 mpt3sas usbcore raid_class libphy =
scsi_transport_sas usb_common
> [  223.017812] CPU: 8 PID: 10609 Comm: swapon Not tainted 6.1.0-34-powerp=
c64le #1  Debian 6.1.135-1
> [  223.017844] Hardware name: T2P9D01 REV 1.01 POWER9 0x4e1202 opal:skibo=
ot-bc106a0 PowerNV
> [  223.017879] NIP:  0000000000000000 LR: c0000000003efe70 CTR: 000000000=
0000000
> [  223.017926] REGS: c0000000276cf200 TRAP: 0400   Not tainted  (6.1.0-34=
-powerpc64le Debian 6.1.135-1)
> [  223.017979] MSR:  900000004280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE=
>  CR: 24004480  XER: 00000004
> [  223.018060] CFAR: c0000000003efe6c IRQMASK: 0
>                GPR00: c0000000003efec4 c0000000276cf4a0 c000000001148100 =
0000000000092800
>                GPR04: 0000000000000000 0000000000000003 0000000000000c00 =
c00000000296e700
>                GPR08: c00000000c0e9700 00000c0000090800 0000000000000000 =
0000000000002000
>                GPR12: 0000000000000000 c000001ffffd9800 c0000000446b8c00 =
0000000000000000
>                GPR16: 0000000000000400 0000000000000000 0000000000000001 =
000000000000c812
>                GPR20: 000000000000c911 c0000000170c5700 c00000000296e718 =
c00000000296e3f0
>                GPR24: 0000000000000000 00000000000003ff 0000000000000000 =
0000000000000c00
>                GPR28: c000200009e2dd00 c00000000296e718 00000c0000092800 =
0000000000092c00
> [  223.018372] NIP [0000000000000000] 0x0
> [  223.018397] LR [c0000000003efe70] mempool_alloc+0xa0/0x210
> [  223.018435] Call Trace:
> [  223.018453] [c0000000276cf4a0] [c0000000003efec4] mempool_alloc+0xf4/0=
x210 (unreliable)
> [  223.018507] [c0000000276cf520] [c000000000743bf8] bio_alloc_bioset+0x3=
68/0x510
> [  223.018552] [c0000000276cf5a0] [c000000000743e74] bio_alloc_clone+0x44=
/0xa0
> [  223.018601] [c0000000276cf5e0] [c008000015793adc] md_account_bio+0x54/=
0xb0 [md_mod]
> [  223.018655] [c0000000276cf610] [c00800001567778c] raid10_make_request+=
0xc54/0x1040 [raid10]
> [  223.018687] [c0000000276cf770] [c00800001579a290] md_handle_request+0x=
198/0x380 [md_mod]
> [  223.018735] [c0000000276cf800] [c00000000074c32c] __submit_bio+0x9c/0x=
250
> [  223.018773] [c0000000276cf840] [c00000000074ca88] submit_bio_noacct_no=
check+0x178/0x3f0
> [  223.018825] [c0000000276cf8b0] [c000000000743e08] blk_next_bio+0x68/0x=
90
> [  223.018863] [c0000000276cf8e0] [c000000000758c60] __blkdev_issue_disca=
rd+0x180/0x280
> [  223.018898] [c0000000276cf980] [c000000000758de8] blkdev_issue_discard=
+0x88/0x120
> [  223.018927] [c0000000276cfa00] [c0000000004a9e8c] sys_swapon+0x11dc/0x=
18a0
> [  223.018971] [c0000000276cfb50] [c00000000002b038] system_call_exceptio=
n+0x138/0x260
> [  223.019015] [c0000000276cfe10] [c00000000000c0f0] system_call_vectored=
_common+0xf0/0x280
> [  223.019058] --- interrupt: 3000 at 0x7fff95146770
> [  223.019095] NIP:  00007fff95146770 LR: 00007fff95146770 CTR: 000000000=
0000000
> [  223.019132] REGS: c0000000276cfe80 TRAP: 3000   Not tainted  (6.1.0-34=
-powerpc64le Debian 6.1.135-1)
> [  223.019182] MSR:  900000000280f033 <SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI=
,LE>  CR: 48002481  XER: 00000000
> [  223.019267] IRQMASK: 0
>                GPR00: 0000000000000057 00007fffdca2ace0 00007fff95256f00 =
00000001220a1c20
>                GPR04: 0000000000030000 000000000000001e 000000000000000a =
000000000000000a
>                GPR08: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000
>                GPR12: 0000000000000000 00007fff955dcbc0 0000000000000000 =
0000000000000000
>                GPR16: 0000000000000000 00000001104066b0 00007fffdca2afc8 =
000000011040cbd0
>                GPR20: 000000011040cbd8 0000000000000000 0000000000010000 =
00007fffdca2aff0
>                GPR24: 00007fffdca2afd0 0000000000000003 0000000000030000 =
0000000400000000
>                GPR28: 00000001220a1c20 000000000000fff6 00000001220a30a0 =
0000000000100000
> [  223.019542] NIP [00007fff95146770] 0x7fff95146770
> [  223.019568] LR [00007fff95146770] 0x7fff95146770
> [  223.019595] --- interrupt: 3000
> [  223.019604] Instruction dump:
> [  223.019626] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXX=
XXXX XXXXXXXX
> [  223.019665] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXX=
XXXX XXXXXXXX
> [  223.019712] ---[ end trace 0000000000000000 ]---
>=20
> [  224.623456] note: swapon[10609] exited with irqs disabled
> [  224.623483] ------------[ cut here ]------------
> [  224.623502] WARNING: CPU: 8 PID: 10609 at kernel/exit.c:816 do_exit+0x=
94/0xbc0
> [  224.623516] Modules linked in: bridge stp llc binfmt_misc nft_connlimi=
t nf_conncount ast drm_vram_helper drm_ttm_helper ofpart ipmi_powernv ttm i=
pmi_devintf powernv_flash at24 mtd ipmi_msghandler opal_prd regmap_i2c drm_=
kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops i2c_algo_bit sg nf=
t_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fi=
b nf_tables nfnetlink drm loop fuse drm_panel_orientation_quirks configfs i=
p_tables x_tables autofs4 ext4 crc16 mbcache jbd2 dm_crypt dm_integrity dm_=
bufio dm_mod macvlan raid10 raid456 async_raid6_recov async_memcpy async_pq=
 async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 multi=
path linear md_mod sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc_=
t10dif crct10dif_generic crc64 crct10dif_common xhci_pci xts ecb xhci_hcd c=
tr vmx_crypto gf128mul crc32c_vpmsum tg3 mpt3sas usbcore raid_class libphy =
scsi_transport_sas usb_common
> [  224.623825] CPU: 8 PID: 10609 Comm: swapon Tainted: G      D          =
  6.1.0-34-powerpc64le #1  Debian 6.1.135-1
> [  224.623860] Hardware name: T2P9D01 REV 1.01 POWER9 0x4e1202 opal:skibo=
ot-bc106a0 PowerNV
> [  224.623892] NIP:  c000000000140fa4 LR: c000000000140fa0 CTR: 000000000=
0000000
> [  224.623935] REGS: c0000000276cecb0 TRAP: 0700   Tainted: G      D     =
        (6.1.0-34-powerpc64le Debian 6.1.135-1)
> [  224.623969] MSR:  9000000002029033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: =
24004222  XER: 00000004
> [  224.624012] CFAR: c00000000013ea68 IRQMASK: 0
>                GPR00: c000000000140fa0 c0000000276cef50 c000000001148100 =
0000000000000000
>                GPR04: 0000000000000000 c0000000276cee20 c0000000276cee18 =
0000001ffb000000
>                GPR08: 0000000000000027 c0000000276cf9b0 0000000000000000 =
0000000000004000
>                GPR12: 0000000031c40000 c000001ffffd9800 c0000000446b8c00 =
0000000000000000
>                GPR16: 0000000000000400 0000000000000000 0000000000000001 =
000000000000c812
>                GPR20: 000000000000c911 c0000000170c5700 c00000000296e718 =
c00000000296e3f0
>                GPR24: 0000000000000000 00000000000003ff 0000000000000000 =
0000000000000c00
>                GPR28: 000000000000000b c00000001ce25d80 c000000078409c00 =
c000000026529d80
> [  224.624208] NIP [c000000000140fa4] do_exit+0x94/0xbc0
> [  224.624239] LR [c000000000140fa0] do_exit+0x90/0xbc0
> [  224.624269] Call Trace:
> [  224.624274] [c0000000276cef50] [c000000000140fa0] do_exit+0x90/0xbc0 (=
unreliable)
> [  224.624308] [c0000000276cf020] [c000000000141b80] make_task_dead+0xb0/=
0x1f0
> [  224.624320] [c0000000276cf0a0] [c000000000025718] oops_end+0x188/0x1c0
> [  224.624341] [c0000000276cf120] [c00000000007f72c] __bad_page_fault+0x1=
8c/0x1b0
> [  224.624375] [c0000000276cf190] [c000000000008cd4] instruction_access_c=
ommon_virt+0x194/0x1a0
> [  224.624421] --- interrupt: 400 at 0x0
> [  224.624438] NIP:  0000000000000000 LR: c0000000003efe70 CTR: 000000000=
0000000
> [  224.624471] REGS: c0000000276cf200 TRAP: 0400   Tainted: G      D     =
        (6.1.0-34-powerpc64le Debian 6.1.135-1)
> [  224.624507] MSR:  900000004280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE=
>  CR: 24004480  XER: 00000004
> [  224.624544] CFAR: c0000000003efe6c IRQMASK: 0
>                GPR00: c0000000003efec4 c0000000276cf4a0 c000000001148100 =
0000000000092800
>                GPR04: 0000000000000000 0000000000000003 0000000000000c00 =
c00000000296e700
>                GPR08: c00000000c0e9700 00000c0000090800 0000000000000000 =
0000000000002000
>                GPR12: 0000000000000000 c000001ffffd9800 c0000000446b8c00 =
0000000000000000
>                GPR16: 0000000000000400 0000000000000000 0000000000000001 =
000000000000c812
>                GPR20: 000000000000c911 c0000000170c5700 c00000000296e718 =
c00000000296e3f0
>                GPR24: 0000000000000000 00000000000003ff 0000000000000000 =
0000000000000c00
>                GPR28: c000200009e2dd00 c00000000296e718 00000c0000092800 =
0000000000092c00
> [  224.624732] NIP [0000000000000000] 0x0
> [  224.624749] LR [c0000000003efe70] mempool_alloc+0xa0/0x210
> [  224.624771] --- interrupt: 400
> [  224.624789] [c0000000276cf4a0] [c0000000003efec4] mempool_alloc+0xf4/0=
x210 (unreliable)
> [  224.624823] [c0000000276cf520] [c000000000743bf8] bio_alloc_bioset+0x3=
68/0x510
> [  224.624859] [c0000000276cf5a0] [c000000000743e74] bio_alloc_clone+0x44=
/0xa0
> [  224.624892] [c0000000276cf5e0] [c008000015793adc] md_account_bio+0x54/=
0xb0 [md_mod]
> [  224.624930] [c0000000276cf610] [c00800001567778c] raid10_make_request+=
0xc54/0x1040 [raid10]
> [  224.624964] [c0000000276cf770] [c00800001579a290] md_handle_request+0x=
198/0x380 [md_mod]
> [  224.624997] [c0000000276cf800] [c00000000074c32c] __submit_bio+0x9c/0x=
250
> [  224.625018] [c0000000276cf840] [c00000000074ca88] submit_bio_noacct_no=
check+0x178/0x3f0
> [  224.625043] [c0000000276cf8b0] [c000000000743e08] blk_next_bio+0x68/0x=
90
> [  224.625066] [c0000000276cf8e0] [c000000000758c60] __blkdev_issue_disca=
rd+0x180/0x280
> [  224.625091] [c0000000276cf980] [c000000000758de8] blkdev_issue_discard=
+0x88/0x120
> [  224.625115] [c0000000276cfa00] [c0000000004a9e8c] sys_swapon+0x11dc/0x=
18a0
> [  224.625139] [c0000000276cfb50] [c00000000002b038] system_call_exceptio=
n+0x138/0x260
> [  224.625164] [c0000000276cfe10] [c00000000000c0f0] system_call_vectored=
_common+0xf0/0x280
> [  224.625201] --- interrupt: 3000 at 0x7fff95146770
> [  224.625270] NIP:  00007fff95146770 LR: 00007fff95146770 CTR: 000000000=
0000000
> [  224.625367] REGS: c0000000276cfe80 TRAP: 3000   Tainted: G      D     =
        (6.1.0-34-powerpc64le Debian 6.1.135-1)
> [  224.625458] MSR:  900000000000f033 <SF,HV,EE,PR,FP,ME,IR,DR,RI,LE>  CR=
: 48002481  XER: 00000000
> [  224.625570] IRQMASK: 0
>                GPR00: 0000000000000057 00007fffdca2ace0 00007fff95256f00 =
00000001220a1c20
>                GPR04: 0000000000030000 000000000000001e 000000000000000a =
000000000000000a
>                GPR08: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000
>                GPR12: 0000000000000000 00007fff955dcbc0 0000000000000000 =
0000000000000000
>                GPR16: 0000000000000000 00000001104066b0 00007fffdca2afc8 =
000000011040cbd0
>                GPR20: 000000011040cbd8 0000000000000000 0000000000010000 =
00007fffdca2aff0
>                GPR24: 00007fffdca2afd0 0000000000000003 0000000000030000 =
0000000400000000
>                GPR28: 00000001220a1c20 000000000000fff6 00000001220a30a0 =
0000000000100000
> [  224.626325] NIP [00007fff95146770] 0x7fff95146770
> [  224.626388] LR [00007fff95146770] 0x7fff95146770
> [  224.626522] --- interrupt: 3000
> [  224.626568] Instruction dump:
> [  224.626587] 60000000 813f000c 3929ffff 2c090000 913f000c 40820010 813f=
0074 71290004
> [  224.626680] 4182074c 7fa3eb78 4bffda7d e93e0b10 <0b090000> e87e0a48 48=
c7dd0d 60000000
> [  224.626786] ---[ end trace 0000000000000000 ]---

Does this ring a bell?

Melvin, the same change went as well in other stable series, 6.6.88,
6.12.25, 6.14.4, can you test e.g. 6.12.25-1 in Debian as well from
unstable to see if the regression is there as well?

Might you be able to bisect the upstream stable series between 6.1.133
to 6.1.135 to really confirm the mentioned commit is the one breaking?

Regards,
Salvatore

