Return-Path: <stable+bounces-107903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF22A04B46
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 21:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E050C166568
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 20:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4BA95C;
	Tue,  7 Jan 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kvanals.org header.i=@kvanals.org header.b="HEduFwiC";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="VXPQrKxH"
X-Original-To: stable@vger.kernel.org
Received: from a48-90.smtp-out.amazonses.com (a48-90.smtp-out.amazonses.com [54.240.48.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2D78F3E
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.48.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736283585; cv=none; b=uFImCagEtaCX7GuDn7Jr5YLhXgTzveKqRIsye6McxzfvGkYe+IfNjkq8VITdbuEY32QV4tYIpVfoXAmsjWEuVEt2OXTvGmqxdsbstB+HY6do4cR05C+tLBCPLZe3IvnUlX5SnAN73B208aqzG/P3LvmtHrPCbeJPX7O4DP0lfzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736283585; c=relaxed/simple;
	bh=TwTFWwsVlKFP5nPmkCJlXqkN0OyIfBTB089s5AsH4rI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-ID:References:To; b=rLypk1IKj0hWTafrtS4Bx8wsumZC45iF2jYJbyHPJ9/LFTRWTZnLlfedZmFMRe3ZituZPOqOrrjSwwUlqKjWQSdMEe9P1R7VSeOkfykdxDK6T5MnCuJ/tLLuI1I7ytZIpDngiV8WMQ4Rh1VBNWkekYrTaUVkjhGya1TKZZEc3/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kvanals.org; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (2048-bit key) header.d=kvanals.org header.i=@kvanals.org header.b=HEduFwiC; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=VXPQrKxH; arc=none smtp.client-ip=54.240.48.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kvanals.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=dbnse6tb2bgtv6t3hhj6fd6thaqrrmwh; d=kvanals.org; t=1736283582;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:To;
	bh=TwTFWwsVlKFP5nPmkCJlXqkN0OyIfBTB089s5AsH4rI=;
	b=HEduFwiCicV495N9yolTNQZeROWh552YGeTzeAZbk1HlyF9H+bPtAVHOf3tzDG/c
	rAPHFYEH3T6JlqM010VaHCNIx/PBdbUBy02nwA6R1e2o2vb3tCrQz4ArgECLGOXk+0h
	qKf7rRUt9MOmwOF2Cxl/ST1EZqq9HATM/lAcJGrVByvNS5RtAJY0JmIHmzqKWMufiGS
	KOeDAYUqxLmqGAsCdJMiKHR9ijFuhBGy7OO7Ygkby14mUenNs28KXdaZBTo4EDZCC00
	qPm8XHqfUP5cRvdBA68a2WRYhGLK4yiqSEQE546bMjG3mK1uWhVRkkI01tk4h25UgCh
	zhyEWjlttQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1736283582;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:To:Feedback-ID;
	bh=TwTFWwsVlKFP5nPmkCJlXqkN0OyIfBTB089s5AsH4rI=;
	b=VXPQrKxH3RAmLWe7B/0sT1JKxP+kgIJr64khNZJ7MMkAp3YPGQoQJaW9bKFO+3Zw
	uxg47eHvvH3ujp1H9wZ8JND21zCm7Di3ofXRXpIV01Zdw0WLVkvMJco5VdR0qHcbhPx
	VStx8gUjxayM8UFXMzh/6VgEelAqEXH6BdnoQKng=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.300.87.4.3\))
Subject: Re: zram: Regression in at least linux-6.1.y tree
From: Kenneth Van Alstyne <kvanals@kvanals.org>
In-Reply-To: <F217F800-B66B-4D81-A319-0B7050ED14F9@kvanals.org>
Date: Tue, 7 Jan 2025 20:59:42 +0000
Cc: regressions@lists.linux.dev, senozhatsky@chromium.org, 
	minchan@kernel.org, ngupta@vflare.org
Content-Transfer-Encoding: quoted-printable
Message-ID: <010001944290f008-0b2c0e8d-47ae-48b7-a482-ac4da91fcdb3-000000@email.amazonses.com>
References: <F217F800-B66B-4D81-A319-0B7050ED14F9@kvanals.org>
To: stable@vger.kernel.org
X-Mailer: Apple Mail (2.3826.300.87.4.3)
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (olympus.kvanals.org [IPv6:2600:1f18:42d5:300:0:0:0:ffff]); Tue, 07 Jan 2025 20:59:42 +0000 (UTC)
Feedback-ID: ::1.us-east-1.5jHMwTu/Jzmoolk7Ak3w+RKcSxXCCShHRX8XGxXgrSs=:AmazonSES
X-SES-Outgoing: 2025.01.07-54.240.48.90

Somehow I missed this on my first search through lore.kernel.org, but =
this appears to be the same issue:
	=
https://lore.kernel.org/stable/Z3ytcILx4S1v_ueJ@codewreck.org/T/#u

Thanks,

--
Kenneth Van Alstyne, Jr.

> On Jan 7, 2025, at 15:48, Kenneth Van Alstyne <kvanals@kvanals.org> =
wrote:
>=20
> Greetings and apologies if this isn't the proper process for reporting =
an issue in a LTS kernel per =
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html. =
 Happy to follow another process if more appropriate.
>=20
> Kernel 6.1.122 introduced a regression via commit =
ac3b5366b9b7c9d97b606532ceab43d2329a22f3 (backport of upstream commit =
74363ec674cb172d8856de25776c8f3103f05e2f) in =
drivers/block/zram/zram_drv.c where attempting to set the size of =
/dev/zram0 after loading the zram kernel module results in a kernel NULL =
pointer dereference.
>=20
> That patch removed the following block from zram_reset_device():
> - if (!init_done(zram)) {
> - up_write(&zram->init_lock);
> - return;
> - }
>=20
> However, without that, zram_reset_device subsequently calls =
zcomp_destroy on a device that has not been initialized, leading to the =
OOPS.  Adding that block back does resolve the issue.  In addition, the =
latest mainline kernel does not appear to exhibit these symptoms, but =
zram_drv.c seems to have been changed fairly substantially since kernel =
6.1.
>=20
> Steps to reproduce:
>=20
> modprobe zram
> zramctl /dev/zram0 --algorithm zstd --size 83886080k
>=20
> Kernel log:
>=20
> [  184.410082] BUG: kernel NULL pointer dereference, address: =
0000000000000000
> [  184.416305] #PF: supervisor read access in kernel mode
> [  184.418201] #PF: error_code(0x0000) - not-present page
> [  184.418201] PGD 170d0b067 P4D 170d0b067 PUD 1718af067 PMD 0=20
> [  184.418201] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  184.418201] CPU: 2 PID: 3584 Comm: zramctl Tainted: G           O  =
K    6.1.122 #1
> [  184.418201] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS rel-1.11.1-0-g0551a4be2c-prebuilt.qemu-project.org 04/01/2014
> [  184.418201] RIP: 0010:zcomp_cpu_dead+0x7/0x30 [zram]
> [  184.418201] Code: c7 d8 56 a9 c0 e8 63 f3 92 ed b8 f4 ff ff ff 5b =
e9 fe 10 d7 ed 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00 =
89 ff <48> 8b 46 f0 48 03 04 fd c0 47 e7 ae 48 89 c7 48 8d 70 08 e8 11 =
fd
> [  184.418201] RSP: 0018:ffffaf9400a5fd28 EFLAGS: 00010246
> [  184.418201] RAX: ffffffffc0a912d0 RBX: ffff89adefa1b2e0 RCX: =
0000000000000010
> [  184.418201] RDX: 0000000000000000 RSI: 0000000000000010 RDI: =
0000000000000000
> [  184.418201] RBP: 0000000000000000 R08: 0000000000000000 R09: =
0000000000000001
> [  184.418201] R10: 000000000000000a R11: f000000000000000 R12: =
0000000000000aa0
> [  184.418201] R13: 0000000000000000 R14: 0000000000000010 R15: =
ffff89aac0cb2e20
> [  184.418201] FS:  00007fa6d240d740(0000) GS:ffff89adefa80000(0000) =
knlGS:0000000000000000
> [  184.418201] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  184.418201] CR2: 0000000000000000 CR3: 0000000171fd4000 CR4: =
00000000003506e0
> [  184.418201] Call Trace:
> [  184.418201]  <TASK>
> [  184.418201]  ? __die_body+0x1a/0x60
> [  184.418201]  ? page_fault_oops+0xae/0x260
> [  184.418201]  ? exc_page_fault+0x67/0x140
> [  184.418201]  ? asm_exc_page_fault+0x22/0x30
> [  184.418201]  ? zcomp_cpu_up_prepare+0x90/0x90 [zram]
> [  184.418201]  ? zcomp_cpu_dead+0x7/0x30 [zram]
> [  184.418201]  ? zcomp_cpu_up_prepare+0x90/0x90 [zram]
> [  184.418201]  cpuhp_invoke_callback+0xb4/0x4c0
> [  184.418201]  ? zcomp_cpu_up_prepare+0x90/0x90 [zram]
> [  184.418201]  cpuhp_issue_call+0xeb/0x140
> [  184.418201]  __cpuhp_state_remove_instance+0xdb/0x1a0
> [  184.418201]  zcomp_destroy+0x1c/0x30 [zram]
> [  184.418201]  zram_reset_device+0xf3/0x120 [zram]
> [  184.418201]  reset_store+0x9d/0x100 [zram]
> [  184.418201]  kernfs_fop_write_iter+0x11e/0x1b0
> [  184.418201]  vfs_write+0x2ae/0x3c0
> [  184.418201]  ksys_write+0x5c/0xe0
> [  184.418201]  do_syscall_64+0x32/0x80
> [  184.552119] python3 (3612) used greatest stack depth: 11736 bytes =
left
> [  184.418201]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  184.418201] RIP: 0033:0x7fa6d2506d00
> [  184.418201] Code: 40 00 48 8b 15 29 91 0d 00 f7 d8 64 89 02 48 c7 =
c0 ff ff ff ff eb af 0f 1f 00 80 3d e1 18 0e 00 00 74 17 b8 01 00 00 00 =
0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 =
55
> [  184.418201] RSP: 002b:00007ffec8315ec8 EFLAGS: 00000202 ORIG_RAX: =
0000000000000001
> [  184.418201] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: =
00007fa6d2506d00
> [  184.418201] RDX: 0000000000000001 RSI: 00007ffec8315ee0 RDI: =
0000000000000003
> [  184.418201] RBP: 0000000000000001 R08: 0000000000000000 R09: =
0000000000000001
> [  184.418201] R10: 0000000000000004 R11: 0000000000000202 R12: =
00007fa6d240d6c0
> [  184.418201] R13: 00007ffec8315ee0 R14: 0000000000000003 R15: =
00007ffec8315ed0
> [  184.418201]  </TASK>
> [  184.418201] Modules linked in: zram zsmalloc bcache crc64 =
ip6table_filter ip6_tables iptable_filter xt_conntrack iptable_mangle =
xt_connmark nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_tables =
x_tables vfat fat btrfs blake2b_generic xor raid6_pq libcrc32c =
dm_multipath dm_mod bridge stp llc bonding nfs lockd grace sunrpc =
fscache torch(O) ipmi_devintf ipmi_msghandler sr_mod kvm_amd mousedev =
cdrom virtio_blk kvm ata_generic pata_acpi irqbypass crc32c_intel =
aesni_intel ata_piix crypto_simd virtio_pci virtio_pci_legacy_dev =
psmouse virtio_pci_modern_dev i6300esb e1000 libata cryptd i2c_piix4 =
evdev procmemro(OK) noptrace(OK)
> [  184.418201] CR2: 0000000000000000
> [  184.418201] ---[ end trace 0000000000000000 ]---
> [  184.418201] RIP: 0010:zcomp_cpu_dead+0x7/0x30 [zram]
> [  184.418201] Code: c7 d8 56 a9 c0 e8 63 f3 92 ed b8 f4 ff ff ff 5b =
e9 fe 10 d7 ed 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00 =
89 ff <48> 8b 46 f0 48 03 04 fd c0 47 e7 ae 48 89 c7 48 8d 70 08 e8 11 =
fd
> [  184.418201] RSP: 0018:ffffaf9400a5fd28 EFLAGS: 00010246
> [  184.418201] RAX: ffffffffc0a912d0 RBX: ffff89adefa1b2e0 RCX: =
0000000000000010
> [  184.418201] RDX: 0000000000000000 RSI: 0000000000000010 RDI: =
0000000000000000
> [  184.418201] RBP: 0000000000000000 R08: 0000000000000000 R09: =
0000000000000001
> [  184.418201] R10: 000000000000000a R11: f000000000000000 R12: =
0000000000000aa0
> [  184.418201] R13: 0000000000000000 R14: 0000000000000010 R15: =
ffff89aac0cb2e20
> [  184.418201] FS:  00007fa6d240d740(0000) GS:ffff89adefa80000(0000) =
knlGS:0000000000000000
> [  184.418201] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  184.418201] CR2: 0000000000000000 CR3: 0000000171fd4000 CR4: =
00000000003506e0
> [  184.418201] Kernel panic - not syncing: Fatal exception
> [  184.418201] Kernel Offset: 0x2c800000 from 0xffffffff81000000 =
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [  184.418201] Rebooting in 120 seconds..
>=20
> Thanks,
>=20
> --
> Kenneth Van Alstyne, Jr.


