Return-Path: <stable+bounces-139528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D77AA7E10
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 04:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF53465FA8
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 02:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC35D85270;
	Sat,  3 May 2025 02:36:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out28-57.mail.aliyun.com (out28-57.mail.aliyun.com [115.124.28.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311711624E5
	for <stable@vger.kernel.org>; Sat,  3 May 2025 02:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746239784; cv=none; b=TwTablj7cDPNeZb4n1bCDnHd2tWVoLqApwA2iOnCYQFwcMn8ct3M1K+eMmU5SVhzwfSZa1E1LGdRb0sSjMWqNhL3LRdTo7t0SQlgqOasq8o1qv5LgsjhJwEU4upG90aFi9xAhyLbZnEymatPZtF48SFjJLUL4B9ee3V/0PvVaNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746239784; c=relaxed/simple;
	bh=4SOAc6U+XiTae34/vCIb6xv6u2O9RXkWl+63dIqhVes=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=kqC1kd7t0/kw9OjnRIMX09g48o73xxkbnLzf0hHeH/K/yrFnLINJMPQwFIkPXUI01VwvR5g2H8SuLd82nlkKK25logxwGPJwwEQyCu2QVRJJD0uxLpd86knTyEqmPHOjv/5wZHiL9zH3PZO6gtlraRDUjfj129ojDJCpjerAHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.cdtMfet_1746237927 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 03 May 2025 10:05:28 +0800
Date: Sat, 03 May 2025 10:05:29 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: stable@vger.kernel.org
Subject: Re: [6.12.y] WARNING: CPU: 0 PID: 681 at block/blk-mq-cpumap.c:90 blk_mq_map_hw_queues+0xcf/0xe0
Cc: Wang Yugui <wangyugui@e16-tech.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20250503091422.0389.409509F4@e16-tech.com>
References: <20250503091422.0389.409509F4@e16-tech.com>
Message-Id: <20250503100528.C7F9.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Becky! ver. 2.81.08 [en]

Hi,
Cc: Greg Kroah-Hartman

> Hi,
>=20
> I noticed a WARNING in recent 6.12.y kernel.
>=20
> This WARNING happen on 6.12.26/6.12.25, but not happen on 6.12.20.
>=20
> More bisect job need to be done, but reporti it firstly.
>=20
> [   13.288365] ------------[ cut here ]------------
> [   13.288366] WARNING: CPU: 0 PID: 681 at block/blk-mq-cpumap.c:90 blk_m=
q_map_hw_queues+0xcf/0xe0
> void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
>               struct device *dev, unsigned int offset)
> {
> ...
> ...
> fallback:
> L90=A3=BA    WARN_ON_ONCE(qmap->nr_queues > 1);
>     blk_mq_clear_mq_map(qmap);
> }
>=20

The following patch fixed this WARNING.

=46rom a9ae6fe1c319c4776c2b11e85e15109cd3f04076 Mon Sep 17 00:00:00 2001
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 23 Jan 2025 14:08:29 +0100
Subject: [PATCH] blk-mq: create correct map for fallback case

please pull it to 6.12.y.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/05/03


> [   13.288373] Modules linked in: ahci(+) mlxfw libahci pci_hyperv_intf b=
nx2x(+) i40e(+) mpi3mr(+) psample bnxt_en(+) libata mgag200(+) tls megaraid=
_sas(+) crc32c_intel scsi_transport_sas mdio libie i2c_algo_bit wmi dm_mirr=
or dm_region_hash dm_log dm_mod
> [   13.288386] CPU: 0 UID: 0 PID: 681 Comm: kworker/0:2 Not tainted 6.12.=
26-1.el7.x86_64 #1
> [   13.288388] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.22.=
1 09/12/2024
> [   13.288390] Workqueue: events work_for_cpu_fn
> [   13.288394] RIP: 0010:blk_mq_map_hw_queues+0xcf/0xe0
> [   13.288396] Code: 8b 35 85 e4 9a 02 48 63 d0 48 c7 c7 e0 e5 78 94 e8 2=
6 0b 07 00 39 05 70 e4 9a 02 77 d3 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc <=
0f> 0b eb d2 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
> [   13.288398] RSP: 0018:ffffc0e11b83bd38 EFLAGS: 00010212
> [   13.288400] RAX: 0000000000000000 RBX: ffffa0804ad58000 RCX: 000000000=
0000050
> [   13.288402] RDX: 0000000000000050 RSI: ffffa07f8f24d0c8 RDI: ffffa0804=
ad580e8
> [   13.288403] RBP: ffffa0804ad580e0 R08: 000000000000004f R09: 000000000=
0000000
> [   13.288404] R10: ffffc0e11b83bd78 R11: ffffa07f9039da00 R12: 000000000=
0000000
> [   13.288405] R13: 0000000000000001 R14: ffffa0804ad580e8 R15: 000000000=
0000000
> [   13.288406] FS:  0000000000000000(0000) GS:ffffa0dd3fe00000(0000) knlG=
S:0000000000000000
> [   13.288407] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   13.288408] CR2: 00007f1f3226ba20 CR3: 00000002f9780005 CR4: 000000000=
07706f0
> [   13.288409] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   13.288410] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   13.288411] PKRU: 55555554
> [   13.288412] Call Trace:
> [   13.288413]  <TASK>
> [   13.288415]  megasas_map_queues+0x49/0x90 [megaraid_sas]
> [   13.288431]  blk_mq_alloc_tag_set+0x150/0x3b0
> [   13.288436]  scsi_add_host_with_dma+0xd0/0x350
> [   13.288440]  megasas_io_attach+0x15c/0x220 [megaraid_sas]
> [   13.288456]  megasas_probe_one+0x1cb/0x570 [megaraid_sas]
> [   13.288468]  local_pci_probe+0x47/0xa0
> [   13.288474]  work_for_cpu_fn+0x17/0x30
> [   13.288475]  process_one_work+0x179/0x3a0
> [   13.288480]  worker_thread+0x24b/0x350
> [   13.288483]  ? __pfx_worker_thread+0x10/0x10
> [   13.288485]  kthread+0xde/0x110
> [   13.288489]  ? __pfx_kthread+0x10/0x10
> [   13.288491]  ret_from_fork+0x31/0x50
> [   13.288494]  ? __pfx_kthread+0x10/0x10
> [   13.288496]  ret_from_fork_asm+0x1a/0x30
> [   13.288502]  </TASK>
> [   13.288502] ---[ end trace 0000000000000000 ]---
>=20
>=20
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2025/05/03
>=20



