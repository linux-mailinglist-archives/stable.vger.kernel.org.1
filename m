Return-Path: <stable+bounces-54153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 135F290ECF0
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8AE1282DE3
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E28B145354;
	Wed, 19 Jun 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QdqvaK8N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C8143C4E;
	Wed, 19 Jun 2024 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802742; cv=none; b=XjSe/lwsW3SScEAx5SrXVU1W67Z0RlgBG+KOtlsq3H6oW/++3aGpK/SntkGG6AeDyNBHfFLiqTZWmZwmTq0iVUY3vaonZNlrXlYn9+6olrJeK2LB6ufs4YzrCos0HRltJq4pPiSPhPi9oARjYjNsEH+pLcsbFMBLslHxhUv5w1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802742; c=relaxed/simple;
	bh=Dq2axEkYOL3F05HazyEo4fifgS3g12QaiT1cnbKX0Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rV5bEYilE9dygEl9nWfWzjhKZ5Y6/QQmofP9Bifj7hPDEkozqFMnxodsW0eY4NEyXfxOBv3OG2Xrvj2coHCmmHSmxUKr/DYVW9S9SEVhUmISU6twN7gtKuD4nfCfUH2oG/R2vQMrigdtc0Ovy1HWap/UIccWUdI3K3TGAPWi1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QdqvaK8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D84C2BBFC;
	Wed, 19 Jun 2024 13:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718802741;
	bh=Dq2axEkYOL3F05HazyEo4fifgS3g12QaiT1cnbKX0Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QdqvaK8NrEXHr/XyRxvMWuwvqYv+y8ymCCf5djUvpkHOmzkpufFvokRIvBH5nU+Fp
	 ij7s9u58UPmBbjWvclgAHBqjG6ymmjgotnRk4QtSxnIAHYxR7cLAdCM7G+WRtgjBZ0
	 cEiKy46S9n/1oTdDOZcfOfglMxTAWD6pqpUQADGQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthias Stocker <mstocker@barracuda.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Ronak Doshi <ronak.doshi@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 031/281] vmxnet3: disable rx data ring on dma allocation failure
Date: Wed, 19 Jun 2024 14:53:10 +0200
Message-ID: <20240619125611.047614505@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Stocker <mstocker@barracuda.com>

[ Upstream commit ffbe335b8d471f79b259e950cb20999700670456 ]

When vmxnet3_rq_create() fails to allocate memory for rq->data_ring.base,
the subsequent call to vmxnet3_rq_destroy_all_rxdataring does not reset
rq->data_ring.desc_size for the data ring that failed, which presumably
causes the hypervisor to reference it on packet reception.

To fix this bug, rq->data_ring.desc_size needs to be set to 0 to tell
the hypervisor to disable this feature.

[   95.436876] kernel BUG at net/core/skbuff.c:207!
[   95.439074] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   95.440411] CPU: 7 PID: 0 Comm: swapper/7 Not tainted 6.9.3-dirty #1
[   95.441558] Hardware name: VMware, Inc. VMware Virtual
Platform/440BX Desktop Reference Platform, BIOS 6.00 12/12/2018
[   95.443481] RIP: 0010:skb_panic+0x4d/0x4f
[   95.444404] Code: 4f 70 50 8b 87 c0 00 00 00 50 8b 87 bc 00 00 00 50
ff b7 d0 00 00 00 4c 8b 8f c8 00 00 00 48 c7 c7 68 e8 be 9f e8 63 58 f9
ff <0f> 0b 48 8b 14 24 48 c7 c1 d0 73 65 9f e8 a1 ff ff ff 48 8b 14 24
[   95.447684] RSP: 0018:ffffa13340274dd0 EFLAGS: 00010246
[   95.448762] RAX: 0000000000000089 RBX: ffff8fbbc72b02d0 RCX: 000000000000083f
[   95.450148] RDX: 0000000000000000 RSI: 00000000000000f6 RDI: 000000000000083f
[   95.451520] RBP: 000000000000002d R08: 0000000000000000 R09: ffffa13340274c60
[   95.452886] R10: ffffffffa04ed468 R11: 0000000000000002 R12: 0000000000000000
[   95.454293] R13: ffff8fbbdab3c2d0 R14: ffff8fbbdbd829e0 R15: ffff8fbbdbd809e0
[   95.455682] FS:  0000000000000000(0000) GS:ffff8fbeefd80000(0000) knlGS:0000000000000000
[   95.457178] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   95.458340] CR2: 00007fd0d1f650c8 CR3: 0000000115f28000 CR4: 00000000000406f0
[   95.459791] Call Trace:
[   95.460515]  <IRQ>
[   95.461180]  ? __die_body.cold+0x19/0x27
[   95.462150]  ? die+0x2e/0x50
[   95.462976]  ? do_trap+0xca/0x110
[   95.463973]  ? do_error_trap+0x6a/0x90
[   95.464966]  ? skb_panic+0x4d/0x4f
[   95.465901]  ? exc_invalid_op+0x50/0x70
[   95.466849]  ? skb_panic+0x4d/0x4f
[   95.467718]  ? asm_exc_invalid_op+0x1a/0x20
[   95.468758]  ? skb_panic+0x4d/0x4f
[   95.469655]  skb_put.cold+0x10/0x10
[   95.470573]  vmxnet3_rq_rx_complete+0x862/0x11e0 [vmxnet3]
[   95.471853]  vmxnet3_poll_rx_only+0x36/0xb0 [vmxnet3]
[   95.473185]  __napi_poll+0x2b/0x160
[   95.474145]  net_rx_action+0x2c6/0x3b0
[   95.475115]  handle_softirqs+0xe7/0x2a0
[   95.476122]  __irq_exit_rcu+0x97/0xb0
[   95.477109]  common_interrupt+0x85/0xa0
[   95.478102]  </IRQ>
[   95.478846]  <TASK>
[   95.479603]  asm_common_interrupt+0x26/0x40
[   95.480657] RIP: 0010:pv_native_safe_halt+0xf/0x20
[   95.481801] Code: 22 d7 e9 54 87 01 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa eb 07 0f 00 2d 93 ba 3b 00 fb f4 <e9> 2c 87 01 00 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90
[   95.485563] RSP: 0018:ffffa133400ffe58 EFLAGS: 00000246
[   95.486882] RAX: 0000000000004000 RBX: ffff8fbbc1d14064 RCX: 0000000000000000
[   95.488477] RDX: ffff8fbeefd80000 RSI: ffff8fbbc1d14000 RDI: 0000000000000001
[   95.490067] RBP: ffff8fbbc1d14064 R08: ffffffffa0652260 R09: 00000000000010d3
[   95.491683] R10: 0000000000000018 R11: ffff8fbeefdb4764 R12: ffffffffa0652260
[   95.493389] R13: ffffffffa06522e0 R14: 0000000000000001 R15: 0000000000000000
[   95.495035]  acpi_safe_halt+0x14/0x20
[   95.496127]  acpi_idle_do_entry+0x2f/0x50
[   95.497221]  acpi_idle_enter+0x7f/0xd0
[   95.498272]  cpuidle_enter_state+0x81/0x420
[   95.499375]  cpuidle_enter+0x2d/0x40
[   95.500400]  do_idle+0x1e5/0x240
[   95.501385]  cpu_startup_entry+0x29/0x30
[   95.502422]  start_secondary+0x11c/0x140
[   95.503454]  common_startup_64+0x13e/0x141
[   95.504466]  </TASK>
[   95.505197] Modules linked in: nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 rfkill ip_set nf_tables vsock_loopback
vmw_vsock_virtio_transport_common qrtr vmw_vsock_vmci_transport vsock
sunrpc binfmt_misc pktcdvd vmw_balloon pcspkr vmw_vmci i2c_piix4 joydev
loop dm_multipath nfnetlink zram crct10dif_pclmul crc32_pclmul vmwgfx
crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel
sha512_ssse3 sha256_ssse3 vmxnet3 sha1_ssse3 drm_ttm_helper vmw_pvscsi
ttm ata_generic pata_acpi serio_raw scsi_dh_rdac scsi_dh_emc
scsi_dh_alua ip6_tables ip_tables fuse
[   95.516536] ---[ end trace 0000000000000000 ]---

Fixes: 6f4833383e85 ("net: vmxnet3: Fix NULL pointer dereference in vmxnet3_rq_rx_complete()")
Signed-off-by: Matthias Stocker <mstocker@barracuda.com>
Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
Reviewed-by: Ronak Doshi <ronak.doshi@broadcom.com>
Link: https://lore.kernel.org/r/20240531103711.101961-1-mstocker@barracuda.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 0578864792b60..beebe09eb88ff 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -2034,8 +2034,8 @@ vmxnet3_rq_destroy_all_rxdataring(struct vmxnet3_adapter *adapter)
 					  rq->data_ring.base,
 					  rq->data_ring.basePA);
 			rq->data_ring.base = NULL;
-			rq->data_ring.desc_size = 0;
 		}
+		rq->data_ring.desc_size = 0;
 	}
 }
 
-- 
2.43.0




