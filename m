Return-Path: <stable+bounces-69958-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B52B95CBB0
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 13:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8515FB21049
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB5C185E7B;
	Fri, 23 Aug 2024 11:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="RNSy7WV6"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7757CBE;
	Fri, 23 Aug 2024 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724413907; cv=none; b=QktmhyhvvGIR/VY707jHM/EMYvgNtDBAFATfChELOz+v+7IEVh9p5CyOCd9G8fAla3nw4L5hV+JDysD9djOJgczSvWvAtPD+swi8T2RzoLnjp3Rw2o4X1YKLDz5Az4F6cf3zSaL51jOEz5S8cq+Fc1XeBxlJw7uPnx1JSVtpQOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724413907; c=relaxed/simple;
	bh=s6bRMv6KihSM7lTYtMOoiv3SqT+Ou0FbDI8Dd1ffzS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=CG5txhSQAGfmDSWL8LtqTTkVarHXwXXHSGnGZnN/yyzsMDxibeA4wqIdk80z9AGdf+GM53pU2IL8D6H2286BtBurDzcFMsT7CfaBVJy32vLIIgKNjiBCxF0KdfeF+aBdmAwx3BoCFIs2u7QphkgvTNWP/7AmKpU/HUxcKI+Ohdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=RNSy7WV6; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Cc:From:References:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=qtY9Fwsx9il0x0MVyAF1bPnbIMdVjSsAm1koONSHlVY=;
	t=1724413904; x=1724845904; b=RNSy7WV6QIAFZZtPXEQ4DdvA6+PmlNmzsfSay/sl9LPq9W0
	OPzw2OtBDPfmastyYMdVztYPv7MvpqBXSYU/OxaK5R9wrwazKf2dz05jd/R8eKZAA+DbmM9P/GECA
	XY3mvJVYE4hQcoMCpEncqrpF05+8fwuQwgNTo4pOHyU2tO/o4B+0shH6VzhL42fss0M8FTV5/vWpk
	BWncy/hlfv457paHnIehmNQIlIqX55GA6sRiWsK90KRov5SEyHzVzQGPNhvUcGLlDbuIdij36IFYn
	7PoAtEzMDU62SqLyPYPlvmPWh2oq3gUiq6xxDRiXcskaXscbYKoO0SU7KhiLvkdg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1shSpS-0007Jj-AV; Fri, 23 Aug 2024 13:51:42 +0200
Message-ID: <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
Date: Fri, 23 Aug 2024 13:51:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>, Linux-MM <linux-mm@kvack.org>
In-Reply-To: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1724413904;e790a080;
X-HE-SMSGID: 1shSpS-0007Jj-AV

[to the next one replying: please drop stable@vger.kernel.org from the
CC, this is just noise there, as this is most likely a mainline regressio=
n]

[thread starts here:
https://lore.kernel.org/all/BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.co=
m/
]

On 23.08.24 13:21, Piotr Oniszczuk wrote:
>=20
> In my development i=E2=80=99m using ryzen9 based builder machine.
> OS is ArchLinux.
> It worked perfectly stable with 6.8.2 kernel.
>=20
> Recently I updated to 6.10.6  kernel and=E2=80=A6.started to have regul=
ar oops at heavy compilations (12c/24t loaded 8..12h constantly compiling=
)
>=20
> Only single change is kernel: 6.8.2->6.10.6
> 6.10.6 is vanilla mainline (no any ArchLinux patches)
>=20
> When i have ooops - dmesg is like below.
>=20
> For me this looks like regression...

Many thx for the report. And yes, it looks like one. I CCed the zswap
and the mm folks, which a bit of luck they might have an idea. But this
sort of error sometimes is caused by changes in other areas of the
kernel and they just manifest in zswap. If that is the case nobody might
look into this unless you are able to provide more details, like the
result of a bisction
(https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.h=
tml
) -- that's just how it is...

Ciao, Thorsten


> [75864.693223] br0: port 1(enp5s0) entered blocking state
> [75864.693226] br0: port 1(enp5s0) entered forwarding state
> [86041.349844] ------------[ cut here ]------------
> [86041.349850] kernel BUG at mm/zswap.c:1005!
> [86041.349862] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [86041.349867] CPU: 5 PID: 2798071 Comm: llvm-tblgen Not tainted 6.10.6=
-12 #1 349ceb515693b41153483eac7819a5fb2832d2bf
> [86041.349872] Hardware name: To Be Filled By O.E.M. B450M Pro4-F R2.0/=
B450M Pro4-F R2.0, BIOS P10.08 01/19/2024
> [86041.349876] RIP: 0010:zswap_decompress+0x1ef/0x200
> [86041.349884] Code: ef e8 95 2a ce ff 84 c0 0f 85 1f ff ff ff e9 fb fe=
 ff ff 0f 0b 48 8d 7b 10 e8 0d a9 a4 00 c7 43 10 00 00 00 00 8b 43 30 eb =
86 <0f> 0b 0f 0b e8 f8 9b a3 00 0f 1f 84 00 00 00 00 00 90 90 90 90 90
> [86041.349889] RSP: 0000:ffffb98f823ebb90 EFLAGS: 00010282
> [86041.349892] RAX: 00000000ffffffea RBX: ffff9bf22e8c1e08 RCX: ffff9be=
f137774ba
> [86041.349894] RDX: 0000000000000002 RSI: 0000000000000438 RDI: ffff9bf=
22e8b2af0
> [86041.349897] RBP: ffff9bef58cd2b98 R08: ffff9bee8baf07e0 R09: ffff9be=
f13777080
> [86041.349899] R10: 0000000000000022 R11: ffff9bee8baf1000 R12: fffff78=
2422ebc00
> [86041.349902] R13: ffff9bef13777080 R14: ffff9bef01e3d6e0 R15: ffff9bf=
22e8c1e48
> [86041.349904] FS:  00007f4bda31d280(0000) GS:ffff9bf22e880000(0000) kn=
lGS:0000000000000000
> [86041.349908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [86041.349910] CR2: 000000001665d010 CR3: 0000000191a2c000 CR4: 0000000=
000350ef0
> [86041.349914] Call Trace:
> [86041.349918]  <TASK>
> [86041.349920]  ? die+0x36/0x90
> [86041.349925]  ? do_trap+0xdd/0x100
> [86041.349929]  ? zswap_decompress+0x1ef/0x200
> [86041.349932]  ? do_error_trap+0x6a/0x90
> [86041.349935]  ? zswap_decompress+0x1ef/0x200
> [86041.349938]  ? exc_invalid_op+0x50/0x70
> [86041.349943]  ? zswap_decompress+0x1ef/0x200
> [86041.349946]  ? asm_exc_invalid_op+0x1a/0x20
> [86041.349951]  ? zswap_decompress+0x1ef/0x200
> [86041.349955]  zswap_load+0x109/0x120
> [86041.349958]  swap_read_folio+0x64/0x450
> [86041.349963]  swapin_readahead+0x463/0x4e0
> [86041.349967]  do_swap_page+0x436/0xd70
> [86041.349972]  ? __pte_offset_map+0x1b/0x180
> [86041.349976]  __handle_mm_fault+0x85d/0x1070
> [86041.349979]  ? sched_tick+0xee/0x2f0
> [86041.349985]  handle_mm_fault+0x18d/0x320
> [86041.349988]  do_user_addr_fault+0x177/0x6a0
> [86041.349993]  exc_page_fault+0x7e/0x180
> [86041.349996]  asm_exc_page_fault+0x26/0x30
> [86041.350000] RIP: 0033:0x7453b9
> [86041.350019] Code: 00 48 8d 0c 49 4c 8d 04 ca 48 8b 0f 4c 39 c2 75 19=
 e9 7f 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 48 83 c2 18 49 39 d0 74 =
6b <48> 39 0a 75 f2 48 89 84 24 90 00 00 00 4c 39 73 10 0f 84 2f 02 00
> [86041.350024] RSP: 002b:00007ffe67b93c80 EFLAGS: 00010206
> [86041.350027] RAX: 0000000016659250 RBX: 00007ffe67b93db0 RCX: 0000000=
00f1aad40
> [86041.350030] RDX: 000000001665d010 RSI: 00007ffe67b93cd8 RDI: 00007ff=
e67b93cd0
> [86041.350032] RBP: 0000000000000001 R08: 000000001665d088 R09: 0000000=
000000000
> [86041.350035] R10: 00007f4bda030610 R11: 00007f4bda0d6200 R12: 0000000=
016661210
> [86041.350038] R13: 00007ffe67b94a58 R14: 000000000ba280a8 R15: 0000000=
000000006
> [86041.350041]  </TASK>
> [86041.350043] Modules linked in: tls rpcsec_gss_krb5 nfsv4 dns_resolve=
r nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core br_netfilter iptable_filt=
er xt_physdev tun bridge stp llc ext4 crc16 mbcache jbd2 amd_atl intel_ra=
pl_msr intel_rapl_common cfg80211 edac_mce_amd kvm_amd rfkill kvm crct10d=
if_pclmul crc32_pclmul polyval_clmulni r8169 polyval_generic gf128mul gha=
sh_clmulni_intel sha512_ssse3 realtek sha256_ssse3 sha1_ssse3 aesni_intel=
 mdio_devres crypto_simd sp5100_tco k10temp gpio_amdpt cryptd wmi_bmof pc=
spkr ccp libphy i2c_piix4 acpi_cpufreq rapl zenpower ryzen_smu gpio_gener=
ic mac_hid nfsd auth_rpcgss nfs_acl lockd grace nct6775 nct6775_core hwmo=
n_vid sg sunrpc crypto_user fuse dm_mod loop nfnetlink bpf_preload ip_tab=
les x_tables xfs libcrc32c crc32c_generic drm_ttm_helper ttm video gpu_sc=
hed i2c_algo_bit drm_gpuvm drm_exec mxm_wmi nvme crc32c_intel drm_display=
_helper xhci_pci nvme_core xhci_pci_renesas wmi virtio_net net_failover f=
ailover dimlib virtio_blk virtio_pci virtio_pci_legacy_dev virtio_pci_mod=
ern_dev
> [86041.350106]  [last unloaded: nouveau]
> [86041.350125] ---[ end trace 0000000000000000 ]---
> [86041.350128] RIP: 0010:zswap_decompress+0x1ef/0x200
> [86041.350131] Code: ef e8 95 2a ce ff 84 c0 0f 85 1f ff ff ff e9 fb fe=
 ff ff 0f 0b 48 8d 7b 10 e8 0d a9 a4 00 c7 43 10 00 00 00 00 8b 43 30 eb =
86 <0f> 0b 0f 0b e8 f8 9b a3 00 0f 1f 84 00 00 00 00 00 90 90 90 90 90
> [86041.350137] RSP: 0000:ffffb98f823ebb90 EFLAGS: 00010282
> [86041.350139] RAX: 00000000ffffffea RBX: ffff9bf22e8c1e08 RCX: ffff9be=
f137774ba
> [86041.350142] RDX: 0000000000000002 RSI: 0000000000000438 RDI: ffff9bf=
22e8b2af0
> [86041.350145] RBP: ffff9bef58cd2b98 R08: ffff9bee8baf07e0 R09: ffff9be=
f13777080
> [86041.350147] R10: 0000000000000022 R11: ffff9bee8baf1000 R12: fffff78=
2422ebc00
> [86041.350150] R13: ffff9bef13777080 R14: ffff9bef01e3d6e0 R15: ffff9bf=
22e8c1e48
> [86041.350152] FS:  00007f4bda31d280(0000) GS:ffff9bf22e880000(0000) kn=
lGS:0000000000000000
> [86041.350156] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [86041.350158] CR2: 000000001665d010 CR3: 0000000191a2c000 CR4: 0000000=
000350ef0
> [86041.350162] ------------[ cut here ]------------
> [86041.350164] WARNING: CPU: 5 PID: 2798071 at kernel/exit.c:825 do_exi=
t+0x88b/0xac0
> [86041.350170] Modules linked in: tls rpcsec_gss_krb5 nfsv4 dns_resolve=
r nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core br_netfilter iptable_filt=
er xt_physdev tun bridge stp llc ext4 crc16 mbcache jbd2 amd_atl intel_ra=
pl_msr intel_rapl_common cfg80211 edac_mce_amd kvm_amd rfkill kvm crct10d=
if_pclmul crc32_pclmul polyval_clmulni r8169 polyval_generic gf128mul gha=
sh_clmulni_intel sha512_ssse3 realtek sha256_ssse3 sha1_ssse3 aesni_intel=
 mdio_devres crypto_simd sp5100_tco k10temp gpio_amdpt cryptd wmi_bmof pc=
spkr ccp libphy i2c_piix4 acpi_cpufreq rapl zenpower ryzen_smu gpio_gener=
ic mac_hid nfsd auth_rpcgss nfs_acl lockd grace nct6775 nct6775_core hwmo=
n_vid sg sunrpc crypto_user fuse dm_mod loop nfnetlink bpf_preload ip_tab=
les x_tables xfs libcrc32c crc32c_generic drm_ttm_helper ttm video gpu_sc=
hed i2c_algo_bit drm_gpuvm drm_exec mxm_wmi nvme crc32c_intel drm_display=
_helper xhci_pci nvme_core xhci_pci_renesas wmi virtio_net net_failover f=
ailover dimlib virtio_blk virtio_pci virtio_pci_legacy_dev virtio_pci_mod=
ern_dev
> [86041.350211]  [last unloaded: nouveau]
> [86041.350231] CPU: 5 PID: 2798071 Comm: llvm-tblgen Tainted: G      D =
           6.10.6-12 #1 349ceb515693b41153483eac7819a5fb2832d2bf
> [86041.350236] Hardware name: To Be Filled By O.E.M. B450M Pro4-F R2.0/=
B450M Pro4-F R2.0, BIOS P10.08 01/19/2024
> [86041.350239] RIP: 0010:do_exit+0x88b/0xac0
> [86041.350242] Code: 89 a3 48 06 00 00 48 89 6c 24 10 48 8b 83 68 08 00=
 00 e9 ff fd ff ff 48 8b bb 28 06 00 00 31 f6 e8 da e1 ff ff e9 a1 fd ff =
ff <0f> 0b e9 eb f7 ff ff 4c 89 e6 bf 05 06 00 00 e8 c1 2b 01 00 e9 66
> [86041.350248] RSP: 0000:ffffb98f823ebed8 EFLAGS: 00010282
> [86041.350250] RAX: 0000000400000000 RBX: ffff9bf042adc100 RCX: 0000000=
000000000
> [86041.350252] RDX: 0000000000000001 RSI: 0000000000002710 RDI: ffff9be=
f09907380
> [86041.350255] RBP: ffff9bef81c55580 R08: 0000000000000000 R09: 0000000=
000000003
> [86041.350258] R10: ffffb98f823eb850 R11: ffff9bf23f2ad7a8 R12: 0000000=
00000000b
> [86041.350261] R13: ffff9bef09907380 R14: ffffffffa65fa463 R15: ffffb98=
f823ebae8
> [86041.350263] FS:  00007f4bda31d280(0000) GS:ffff9bf22e880000(0000) kn=
lGS:0000000000000000
> [86041.350267] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [86041.350269] CR2: 000000001665d010 CR3: 0000000191a2c000 CR4: 0000000=
000350ef0
> [86041.350272] Call Trace:
> [86041.350274]  <TASK>
> [86041.350276]  ? __warn+0x80/0x120
> [86041.350280]  ? do_exit+0x88b/0xac0
> [86041.350283]  ? report_bug+0x164/0x190
> [86041.350288]  ? handle_bug+0x3c/0x80
> [86041.350291]  ? exc_invalid_op+0x17/0x70
> [86041.350294]  ? asm_exc_invalid_op+0x1a/0x20
> [86041.350297]  ? do_exit+0x88b/0xac0
> [86041.350300]  ? do_exit+0x6f/0xac0
> [86041.350303]  ? do_user_addr_fault+0x177/0x6a0
> [86041.350307]  make_task_dead+0x81/0x170
> [86041.350310]  rewind_stack_and_make_dead+0x16/0x20
> [86041.350314] RIP: 0033:0x7453b9
> [86041.350319] Code: 00 48 8d 0c 49 4c 8d 04 ca 48 8b 0f 4c 39 c2 75 19=
 e9 7f 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 48 83 c2 18 49 39 d0 74 =
6b <48> 39 0a 75 f2 48 89 84 24 90 00 00 00 4c 39 73 10 0f 84 2f 02 00
> [86041.350324] RSP: 002b:00007ffe67b93c80 EFLAGS: 00010206
> [86041.350327] RAX: 0000000016659250 RBX: 00007ffe67b93db0 RCX: 0000000=
00f1aad40
> [86041.350330] RDX: 000000001665d010 RSI: 00007ffe67b93cd8 RDI: 00007ff=
e67b93cd0
> [86041.350332] RBP: 0000000000000001 R08: 000000001665d088 R09: 0000000=
000000000
> [86041.350335] R10: 00007f4bda030610 R11: 00007f4bda0d6200 R12: 0000000=
016661210
> [86041.350337] R13: 00007ffe67b94a58 R14: 000000000ba280a8 R15: 0000000=
000000006
> [86041.350341]  </TASK>
> [86041.350342] ---[ end trace 0000000000000000 ]---
> [86041.579617] BUG: kernel NULL pointer dereference, address: 000000000=
0000008
> [86041.579627] #PF: supervisor write access in kernel mode
> [86041.579630] #PF: error_code(0x0002) - not-present page
> [86041.579632] PGD 0 P4D 0
> [86041.579636] Oops: Oops: 0002 [#2] PREEMPT SMP NOPTI
> [86041.579640] CPU: 5 PID: 2798071 Comm: llvm-tblgen Tainted: G      D =
W          6.10.6-12 #1 349ceb515693b41153483eac7819a5fb2832d2bf
> [86041.579645] Hardware name: To Be Filled By O.E.M. B450M Pro4-F R2.0/=
B450M Pro4-F R2.0, BIOS P10.08 01/19/2024
> [86041.579649] RIP: 0010:__blk_flush_plug+0x89/0x150
> [86041.579655] Code: de 48 89 5c 24 08 48 89 5c 24 10 48 39 c1 74 7c 49=
 8b 46 20 48 8b 34 24 48 39 c6 74 5b 49 8b 4e 20 49 8b 56 28 48 8b 44 24 =
08 <48> 89 59 08 48 89 4c 24 08 48 89 02 48 89 50 08 49 89 76 20 49 89
> [86041.579660] RSP: 0018:ffffb98f823ebc30 EFLAGS: 00010286
> [86041.579662] RAX: ffffb98f823ebc38 RBX: ffffb98f823ebc38 RCX: 0000000=
000000000
> [86041.579665] RDX: 0000000101887e59 RSI: ffffb98f823ebce8 RDI: ffffb98=
f823ebcc8
> [86041.579667] RBP: 0000000000000001 R08: ffff9bef14e7c248 R09: 0000000=
000000050
> [86041.579669] R10: 0000000000400023 R11: 0000000000000001 R12: dead000=
000000122
> [86041.579672] R13: dead000000000100 R14: ffffb98f823ebcc8 R15: 0000000=
000000000
> [86041.579674] FS:  0000000000000000(0000) GS:ffff9bf22e880000(0000) kn=
lGS:0000000000000000
> [86041.579677] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [86041.579679] CR2: 0000000000000008 CR3: 0000000103bfe000 CR4: 0000000=
000350ef0
> [86041.579682] Call Trace:
> [86041.579685]  <TASK>
> [86041.579689]  ? __die+0x23/0x70
> [86041.579694]  ? page_fault_oops+0x173/0x5a0
> [86041.579698]  ? exc_page_fault+0x7e/0x180
> [86041.579702]  ? asm_exc_page_fault+0x26/0x30
> [86041.579706]  ? __blk_flush_plug+0x89/0x150
> [86041.579709]  schedule+0x99/0xf0
> [86041.579714]  schedule_preempt_disabled+0x15/0x30
> [86041.579716]  rwsem_down_write_slowpath+0x1eb/0x640
> [86041.579720]  down_write+0x5a/0x60
> [86041.579723]  free_pgtables+0xc6/0x1e0
> [86041.579728]  exit_mmap+0x16b/0x3a0
> [86041.579733]  __mmput+0x3e/0x130
> [86041.579736]  do_exit+0x2ac/0xac0
> [86041.579741]  ? do_user_addr_fault+0x177/0x6a0
> [86041.579743]  make_task_dead+0x81/0x170
> [86041.579746]  rewind_stack_and_make_dead+0x16/0x20
> [86041.579750] RIP: 0033:0x7453b9
> [86041.579768] Code: Unable to access opcode bytes at 0x74538f.
> [86041.579770] RSP: 002b:00007ffe67b93c80 EFLAGS: 00010206
> [86041.579772] RAX: 0000000016659250 RBX: 00007ffe67b93db0 RCX: 0000000=
00f1aad40
> [86041.579774] RDX: 000000001665d010 RSI: 00007ffe67b93cd8 RDI: 00007ff=
e67b93cd0
> [86041.579776] RBP: 0000000000000001 R08: 000000001665d088 R09: 0000000=
000000000
> [86041.579778] R10: 00007f4bda030610 R11: 00007f4bda0d6200 R12: 0000000=
016661210
> [86041.579781] R13: 00007ffe67b94a58 R14: 000000000ba280a8 R15: 0000000=
000000006
> [86041.579784]  </TASK>
> [86041.579785] Modules linked in: tls rpcsec_gss_krb5 nfsv4 dns_resolve=
r nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core br_netfilter iptable_filt=
er xt_physdev tun bridge stp llc ext4 crc16 mbcache jbd2 amd_atl intel_ra=
pl_msr intel_rapl_common cfg80211 edac_mce_amd kvm_amd rfkill kvm crct10d=
if_pclmul crc32_pclmul polyval_clmulni r8169 polyval_generic gf128mul gha=
sh_clmulni_intel sha512_ssse3 realtek sha256_ssse3 sha1_ssse3 aesni_intel=
 mdio_devres crypto_simd sp5100_tco k10temp gpio_amdpt cryptd wmi_bmof pc=
spkr ccp libphy i2c_piix4 acpi_cpufreq rapl zenpower ryzen_smu gpio_gener=
ic mac_hid nfsd auth_rpcgss nfs_acl lockd grace nct6775 nct6775_core hwmo=
n_vid sg sunrpc crypto_user fuse dm_mod loop nfnetlink bpf_preload ip_tab=
les x_tables xfs libcrc32c crc32c_generic drm_ttm_helper ttm video gpu_sc=
hed i2c_algo_bit drm_gpuvm drm_exec mxm_wmi nvme crc32c_intel drm_display=
_helper xhci_pci nvme_core xhci_pci_renesas wmi virtio_net net_failover f=
ailover dimlib virtio_blk virtio_pci virtio_pci_legacy_dev virtio_pci_mod=
ern_dev
> [86041.579842]  [last unloaded: nouveau]
> [86041.579858] CR2: 0000000000000008
> [86041.579861] ---[ end trace 0000000000000000 ]---
> [86041.579863] RIP: 0010:zswap_decompress+0x1ef/0x200
> [86041.579867] Code: ef e8 95 2a ce ff 84 c0 0f 85 1f ff ff ff e9 fb fe=
 ff ff 0f 0b 48 8d 7b 10 e8 0d a9 a4 00 c7 43 10 00 00 00 00 8b 43 30 eb =
86 <0f> 0b 0f 0b e8 f8 9b a3 00 0f 1f 84 00 00 00 00 00 90 90 90 90 90
> [86041.579872] RSP: 0000:ffffb98f823ebb90 EFLAGS: 00010282
> [86041.579875] RAX: 00000000ffffffea RBX: ffff9bf22e8c1e08 RCX: ffff9be=
f137774ba
> [86041.579877] RDX: 0000000000000002 RSI: 0000000000000438 RDI: ffff9bf=
22e8b2af0
> [86041.579880] RBP: ffff9bef58cd2b98 R08: ffff9bee8baf07e0 R09: ffff9be=
f13777080
> [86041.579882] R10: 0000000000000022 R11: ffff9bee8baf1000 R12: fffff78=
2422ebc00
> [86041.579884] R13: ffff9bef13777080 R14: ffff9bef01e3d6e0 R15: ffff9bf=
22e8c1e48
> [86041.579886] FS:  0000000000000000(0000) GS:ffff9bf22e880000(0000) kn=
lGS:0000000000000000
> [86041.579889] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [86041.579891] CR2: 0000000000000008 CR3: 0000000103bfe000 CR4: 0000000=
000350ef0
> [86041.579893] note: llvm-tblgen[2798071] exited with irqs disabled
> [86041.579895] Fixing recursive fault but reboot is needed!
> [86041.579897] BUG: scheduling while atomic: llvm-tblgen/2798071/0x0000=
0000
> [86041.579899] Modules linked in: tls rpcsec_gss_krb5 nfsv4 dns_resolve=
r nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core br_netfilter iptable_filt=
er xt_physdev tun bridge stp llc ext4 crc16 mbcache jbd2 amd_atl intel_ra=
pl_msr intel_rapl_common cfg80211 edac_mce_amd kvm_amd rfkill kvm crct10d=
if_pclmul crc32_pclmul polyval_clmulni r8169 polyval_generic gf128mul gha=
sh_clmulni_intel sha512_ssse3 realtek sha256_ssse3 sha1_ssse3 aesni_intel=
 mdio_devres crypto_simd sp5100_tco k10temp gpio_amdpt cryptd wmi_bmof pc=
spkr ccp libphy i2c_piix4 acpi_cpufreq rapl zenpower ryzen_smu gpio_gener=
ic mac_hid nfsd auth_rpcgss nfs_acl lockd grace nct6775 nct6775_core hwmo=
n_vid sg sunrpc crypto_user fuse dm_mod loop nfnetlink bpf_preload ip_tab=
les x_tables xfs libcrc32c crc32c_generic drm_ttm_helper ttm video gpu_sc=
hed i2c_algo_bit drm_gpuvm drm_exec mxm_wmi nvme crc32c_intel drm_display=
_helper xhci_pci nvme_core xhci_pci_renesas wmi virtio_net net_failover f=
ailover dimlib virtio_blk virtio_pci virtio_pci_legacy_dev virtio_pci_mod=
ern_dev
> [86041.579933]  [last unloaded: nouveau]
> [86041.579950] CPU: 5 PID: 2798071 Comm: llvm-tblgen Tainted: G      D =
W          6.10.6-12 #1 349ceb515693b41153483eac7819a5fb2832d2bf
> [86041.579954] Hardware name: To Be Filled By O.E.M. B450M Pro4-F R2.0/=
B450M Pro4-F R2.0, BIOS P10.08 01/19/2024
> [86041.579957] Call Trace:
> [86041.579959]  <TASK>
> [86041.579960]  dump_stack_lvl+0x64/0x80
> [86041.579965]  __schedule_bug+0x56/0x70
> [86041.579970]  __schedule+0x10d1/0x1520
> [86041.579973]  ? __wake_up_klogd.part.0+0x3c/0x60
> [86041.579978]  ? vprintk_emit+0x176/0x2a0
> [86041.579981]  ? _printk+0x64/0x80
> [86041.579984]  do_task_dead+0x42/0x50
> [86041.579988]  make_task_dead+0x149/0x170
> [86041.579991]  rewind_stack_and_make_dead+0x16/0x20
> [86041.579994] RIP: 0033:0x7453b9
> [86041.579997] Code: Unable to access opcode bytes at 0x74538f.
> [86041.579999] RSP: 002b:00007ffe67b93c80 EFLAGS: 00010206
> [86041.580002] RAX: 0000000016659250 RBX: 00007ffe67b93db0 RCX: 0000000=
00f1aad40
> [86041.580004] RDX: 000000001665d010 RSI: 00007ffe67b93cd8 RDI: 00007ff=
e67b93cd0
> [86041.580006] RBP: 0000000000000001 R08: 000000001665d088 R09: 0000000=
000000000
> [86041.580008] R10: 00007f4bda030610 R11: 00007f4bda0d6200 R12: 0000000=
016661210
> [86041.580011] R13: 00007ffe67b94a58 R14: 000000000ba280a8 R15: 0000000=
000000006
> [86041.580014]  </TASK>
> [86260.530317] systemd[1]: systemd-journald.service: State 'stop-watchd=
og' timed out. Killing.
> [86260.530377] systemd[1]: systemd-journald.service: Killing process 48=
3 (systemd-journal) with signal SIGKILL.
> [86350.780590] systemd[1]: systemd-journald.service: Processes still ar=
ound after SIGKILL. Ignoring.
> [86441.030515] systemd[1]: systemd-journald.service: State 'final-sigte=
rm' timed out. Killing.
> [86441.030574] systemd[1]: systemd-journald.service: Killing process 48=
3 (systemd-journal) with signal SIGKILL.
> [86531.280569] systemd[1]: systemd-journald.service: Processes still ar=
ound after final SIGKILL. Entering failed mode.
> [86531.280585] systemd[1]: systemd-journald.service: Failed with result=
 'watchdog'.
> [86531.280685] systemd[1]: systemd-journald.service: Unit process 483 (=
systemd-journal) remains running after unit stopped.
> [86531.289108] systemd[1]: systemd-journald.service: Scheduled restart =
job, restart counter is at 1.
> [86531.289280] systemd[1]: systemd-journald.service: Found left-over pr=
ocess 483 (systemd-journal) in control group while starting unit. Ignorin=
g.
> [86531.289285] systemd[1]: systemd-journald.service: This usually indic=
ates unclean termination of a previous run, or service implementation def=
iciencies.
> [86531.323344] systemd[1]: Starting Journal Service...
> [86531.330820] systemd-journald[2799374]: Collecting audit messages is =
disabled.
> [86531.331902] systemd-journald[2799374]: File /var/log/journal/1a15c5c=
01ee34ffb8beb42df7c18ff94/system.journal corrupted or uncleanly shut down=
, renaming and replacing.
> [86531.338702] systemd[1]: Started Journal Service.
> [root@minimyth2-x8664 piotro]#


