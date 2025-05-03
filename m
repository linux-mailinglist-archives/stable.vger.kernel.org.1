Return-Path: <stable+bounces-139527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C29AA7DF5
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 03:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933571BC4645
	for <lists+stable@lfdr.de>; Sat,  3 May 2025 01:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11DADDD2;
	Sat,  3 May 2025 01:45:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out198-178.us.a.mail.aliyun.com (out198-178.us.a.mail.aliyun.com [47.90.198.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8FF17F7
	for <stable@vger.kernel.org>; Sat,  3 May 2025 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746236731; cv=none; b=cbIkSwLksKXzP6f3yZqFcjSiFLnIgjFulNDSIfU/pbJTRosKjKC/nplHBKXWsDjGyH6h5/xCYrpfBVUOGG6nHLKnqlNoFrdUN6Dii+BthVIKUZxclGjcb6YpHOaBqvwVfinUXEIlDnBIkIkBhsxDqFApGa7fO9+qYue1DRprOHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746236731; c=relaxed/simple;
	bh=Kx1m9Tp7xhVKtfMUWKdDE/ADKbXckzwW2Rlr1z/C2mY=;
	h=Date:From:To:Subject:Cc:Message-Id:MIME-Version:Content-Type; b=GFW1CWL+xtNNxKa5lsS+SNj76v4dZ34qpHgNuNQRpRrzfVHAl0vjg6tZAXsr1pShOnvhWgp1t+RgIPeYq5r+l/5tFjlAnXWhDZ4visAVnwHcgxkHmNTFtZ3RADZAo6jZYKQz7qEgtNEye5M6lL6xhV7nrR826TqbACaD1euwZdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.cdqyPLw_1746234861 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 03 May 2025 09:14:21 +0800
Date: Sat, 03 May 2025 09:14:23 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: stable@vger.kernel.org
Subject: [6.12.y] WARNING: CPU: 0 PID: 681 at block/blk-mq-cpumap.c:90 blk_mq_map_hw_queues+0xcf/0xe0
Cc: wangyugui@e16-tech.com
Message-Id: <20250503091422.0389.409509F4@e16-tech.com>
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

I noticed a WARNING in recent 6.12.y kernel.

This WARNING happen on 6.12.26/6.12.25, but not happen on 6.12.20.

More bisect job need to be done, but reporti it firstly.

[   13.288365] ------------[ cut here ]------------
[   13.288366] WARNING: CPU: 0 PID: 681 at block/blk-mq-cpumap.c:90 blk_mq_=
map_hw_queues+0xcf/0xe0
void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
              struct device *dev, unsigned int offset)
{
=2E..
=2E..
fallback:
L90=A3=BA    WARN_ON_ONCE(qmap->nr_queues > 1);
    blk_mq_clear_mq_map(qmap);
}

[   13.288373] Modules linked in: ahci(+) mlxfw libahci pci_hyperv_intf bnx=
2x(+) i40e(+) mpi3mr(+) psample bnxt_en(+) libata mgag200(+) tls megaraid_s=
as(+) crc32c_intel scsi_transport_sas mdio libie i2c_algo_bit wmi dm_mirror=
 dm_region_hash dm_log dm_mod
[   13.288386] CPU: 0 UID: 0 PID: 681 Comm: kworker/0:2 Not tainted 6.12.26=
-1.el7.x86_64 #1
[   13.288388] Hardware name: Dell Inc. PowerEdge T640/0TWW5Y, BIOS 2.22.1 =
09/12/2024
[   13.288390] Workqueue: events work_for_cpu_fn
[   13.288394] RIP: 0010:blk_mq_map_hw_queues+0xcf/0xe0
[   13.288396] Code: 8b 35 85 e4 9a 02 48 63 d0 48 c7 c7 e0 e5 78 94 e8 26 =
0b 07 00 39 05 70 e4 9a 02 77 d3 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc <0f=
> 0b eb d2 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
[   13.288398] RSP: 0018:ffffc0e11b83bd38 EFLAGS: 00010212
[   13.288400] RAX: 0000000000000000 RBX: ffffa0804ad58000 RCX: 00000000000=
00050
[   13.288402] RDX: 0000000000000050 RSI: ffffa07f8f24d0c8 RDI: ffffa0804ad=
580e8
[   13.288403] RBP: ffffa0804ad580e0 R08: 000000000000004f R09: 00000000000=
00000
[   13.288404] R10: ffffc0e11b83bd78 R11: ffffa07f9039da00 R12: 00000000000=
00000
[   13.288405] R13: 0000000000000001 R14: ffffa0804ad580e8 R15: 00000000000=
00000
[   13.288406] FS:  0000000000000000(0000) GS:ffffa0dd3fe00000(0000) knlGS:=
0000000000000000
[   13.288407] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.288408] CR2: 00007f1f3226ba20 CR3: 00000002f9780005 CR4: 00000000007=
706f0
[   13.288409] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   13.288410] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   13.288411] PKRU: 55555554
[   13.288412] Call Trace:
[   13.288413]  <TASK>
[   13.288415]  megasas_map_queues+0x49/0x90 [megaraid_sas]
[   13.288431]  blk_mq_alloc_tag_set+0x150/0x3b0
[   13.288436]  scsi_add_host_with_dma+0xd0/0x350
[   13.288440]  megasas_io_attach+0x15c/0x220 [megaraid_sas]
[   13.288456]  megasas_probe_one+0x1cb/0x570 [megaraid_sas]
[   13.288468]  local_pci_probe+0x47/0xa0
[   13.288474]  work_for_cpu_fn+0x17/0x30
[   13.288475]  process_one_work+0x179/0x3a0
[   13.288480]  worker_thread+0x24b/0x350
[   13.288483]  ? __pfx_worker_thread+0x10/0x10
[   13.288485]  kthread+0xde/0x110
[   13.288489]  ? __pfx_kthread+0x10/0x10
[   13.288491]  ret_from_fork+0x31/0x50
[   13.288494]  ? __pfx_kthread+0x10/0x10
[   13.288496]  ret_from_fork_asm+0x1a/0x30
[   13.288502]  </TASK>
[   13.288502] ---[ end trace 0000000000000000 ]---


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/05/03



