Return-Path: <stable+bounces-144710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9B1ABAE8C
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 09:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314411899BC7
	for <lists+stable@lfdr.de>; Sun, 18 May 2025 07:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B97205E02;
	Sun, 18 May 2025 07:56:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out198-157.us.a.mail.aliyun.com (out198-157.us.a.mail.aliyun.com [47.90.198.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AFFB663
	for <stable@vger.kernel.org>; Sun, 18 May 2025 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747554983; cv=none; b=aYZZUQ160n3bzaIiTYuQlu2Pmt4N91H7BNKv9M/ru/kNKBzd9iTLPrD7R21yTKkWaEbU6rIlUEhK90EoBdiwG72IcYcuQCP728HOvhH4pt39QN1tZHk9+RhdUYAedKo0hnQ4CONjFurOXM7ed48Rd4XdsU8dNjdqF4K0OW1JIFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747554983; c=relaxed/simple;
	bh=Cf/CSPFrMR/Ftk8uqS0mdBevtriqfL1Dk09w7zxchsw=;
	h=Date:From:To:Subject:Cc:Message-Id:MIME-Version:Content-Type; b=hKHYctY6ROso9MbbfWnEqgF0Q886NitWpL44CZR6/sqTkg2a+AfSkr9j5+HAohyBGxwqokhgOU5/XocDuCBproq6uKfSUEU1ygvC7riSnernZ6xJ9WlHcQheXzNHrD1BUJKScFy9lN/DZrquGFVoaKebQSbWlX+LlscqYN69HJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.ctPRZ1K_1747551293 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 18 May 2025 14:54:54 +0800
Date: Sun, 18 May 2025 14:54:54 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: stable@vger.kernel.org
Subject: iommu crash when boot kernel 5.15.179 on DELL R7715/AMD 9015
Cc: Sairaj Kodilkar <sarunkod@amd.com>,
 wangyugui@e16-tech.com
Message-Id: <20250518145453.EF51.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.08 [en]

Hi,

iommu crash when kernel 5.15.179 boot on DELL R7715/AMD 9015.
but kernel 6.1.133/6.6.86 boot well.

It is the first time  to boot kernel 5.15.y on  DELL R7715/AMD 9015, so yet no
more info about  other 5.15.y kernel version.

It seems iommu related, but  seems no relationship to 
5.15.181
iommu-amd-return-an-error-if-vcpu-affinity-is-set-fo.patch
5.15.182
iommu-amd-fix-potential-buffer-overflow-in-parse_ivrs_acpihid.patch

dmesg output:
[    4.658313] Trying to unpack rootfs image as initramfs...
[    4.663349] BUG: kernel NULL pointer dereference, address: 0000000000000030
[    4.664346] #PF: supervisor read access in kernel mode
[    4.664346] #PF: error_code(0x0000) - not-present page
[    4.664346] PGD 0
[    4.664346] Oops: 0000 [#1] SMP NOPTI
[    4.664346] CPU: 8 PID: 1 Comm: swapper/0 Not tainted 5.15.179-1.el9.x86_64 #1
[    4.664346] Hardware name: Dell Inc. PowerEdge R7715/0KRFPX, BIOS 1.1.2 02/20/2025
[    4.664346] RIP: 0010:sysfs_add_link_to_group+0x12/0x60
[    4.664346] Code: cb ff ff 48 89 ef 5d 41 5c e9 ca b4 ff ff 5d 41 5c c3 cc cc cc cc 66 90 0f 1f 44 00 00 41 55 49 89 cd 41 54 49 89 d4 31 d2 55 <48> 8b 7f 30 e8 a5 b2 ff ff 48 85 c0 74 29 48 89 c5 4c 89 e6 48 89
[    4.664346] RSP: 0018:ff3f20b800047c28 EFLAGS: 00010246
[    4.664346] RAX: 0000000000000001 RBX: ff25a0fc800530a8 RCX: ff25a0fc82cdb410
[    4.664346] RDX: 0000000000000000 RSI: ffffffff904726e7 RDI: 0000000000000000
[    4.664346] RBP: ff25a0fc801320d0 R08: ff3f20b800047d00 R09: ff3f20b800047d00
[    4.664346] R10: 0720072007200720 R11: 0720072007200720 R12: ff25a0fc801320d0
[    4.664346] R13: ff25a0fc82cdb410 R14: ff3f20b800047d00 R15: 0000000000000000
[    4.664346] FS:  0000000000000000(0000) GS:ff25a10c1d400000(0000) knlGS:0000000000000000
[    4.664346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.664346] CR2: 0000000000000030 CR3: 0000001036a10001 CR4: 0000000000771ee0
[    4.664346] PKRU: 55555554
[    4.664346] Call Trace:
[    4.664346]  <TASK>
[    4.664346]  ? show_trace_log_lvl+0x1c1/0x2d9
[    4.664346]  ? show_trace_log_lvl+0x1c1/0x2d9
[    4.664346]  ? iommu_device_link+0x3f/0xb0
[    4.664346]  ? __die_body.cold+0x8/0xd
[    4.664346]  ? page_fault_oops+0xac/0x140
[    4.664346]  ? exc_page_fault+0x62/0x130
[    4.664346]  ? asm_exc_page_fault+0x22/0x30
[    4.664346]  ? sysfs_add_link_to_group+0x12/0x60
[    4.664346]  iommu_device_link+0x3f/0xb0
[    4.664346]  __iommu_probe_device+0x188/0x260
[    4.664346]  ? __iommu_probe_device+0x260/0x260
[    4.664346]  probe_iommu_group+0x31/0x40
[    4.664346]  bus_for_each_dev+0x75/0xc0
[    4.664346]  bus_iommu_probe+0x48/0x2c0
[    4.664346]  ? kmem_cache_alloc_trace+0x165/0x290
[    4.664346]  ? __cond_resched+0x16/0x50
[    4.664346]  bus_set_iommu+0x8c/0xe0
[    4.664346]  amd_iommu_init_api+0x18/0x34
[    4.664346]  amd_iommu_init_pci+0x56/0x21c
[    4.664346]  ? e820__memblock_setup+0x7d/0x7d
[    4.664346]  state_next+0x19a/0x2d4
[    4.664346]  ? blake2s_update+0x48/0xc0
[    4.664346]  ? e820__memblock_setup+0x7d/0x7d
[    4.664346]  iommu_go_to_state+0x24/0x2c
[    4.664346]  amd_iommu_init+0xf/0x29
[    4.664346]  pci_iommu_init+0x16/0x43
[    4.664346]  do_one_initcall+0x41/0x1d0
[    4.664346]  do_initcalls+0xc6/0xdf
[    4.664346]  kernel_init_freeable+0x14e/0x19d
[    4.664346]  ? rest_init+0xc0/0xc0
[    4.664346]  kernel_init+0x16/0x130
[    4.664346]  ret_from_fork+0x1f/0x30
[    4.664346]  </TASK>
[    4.664346] Modules linked in:
[    4.664346] CR2: 0000000000000030
[    4.664346] ---[ end trace 9672514da279163d ]---
[    4.664346] RIP: 0010:sysfs_add_link_to_group+0x12/0x60
[    4.664346] Code: cb ff ff 48 89 ef 5d 41 5c e9 ca b4 ff ff 5d 41 5c c3 cc cc cc cc 66 90 0f 1f 44 00 00 41 55 49 89 cd 41 54 49 89 d4 31 d2 55 <48> 8b 7f 30 e8 a5 b2 ff ff 48 85 c0 74 29 48 89 c5 4c 89 e6 48 89
[    4.664346] RSP: 0018:ff3f20b800047c28 EFLAGS: 00010246
[    4.664346] RAX: 0000000000000001 RBX: ff25a0fc800530a8 RCX: ff25a0fc82cdb410
[    4.664346] RDX: 0000000000000000 RSI: ffffffff904726e7 RDI: 0000000000000000
[    4.664346] RBP: ff25a0fc801320d0 R08: ff3f20b800047d00 R09: ff3f20b800047d00
[    4.664346] R10: 0720072007200720 R11: 0720072007200720 R12: ff25a0fc801320d0
[    4.664346] R13: ff25a0fc82cdb410 R14: ff3f20b800047d00 R15: 0000000000000000
[    4.664346] FS:  0000000000000000(0000) GS:ff25a10c1d400000(0000) knlGS:0000000000000000
[    4.664346] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.664346] CR2: 0000000000000030 CR3: 0000001036a10001 CR4: 0000000000771ee0
[    4.664346] PKRU: 55555554
[    4.664346] Kernel panic - not syncing: Fatal exception
[    4.664346] Rebooting in 15 seconds..


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/05/18



