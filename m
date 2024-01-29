Return-Path: <stable+bounces-16616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC2B840DB5
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936221C23549
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59B0158D9C;
	Mon, 29 Jan 2024 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0TI5v3XM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A8158D96;
	Mon, 29 Jan 2024 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548151; cv=none; b=m07WI2UaK1lpSl69rYp22thjNLbOEWKnyzg2PJYeadykA8AKkyncWZK6r4VMoyddFTTKDyiFbX5TTxatxbLtzlmBJ87aBrHiwbJumyCB9w9xv5HpFd2wr3FR5LJXFdhod2shMMHAzEEieJWBDZffjJ2vJKaCOjkKuJVvovG+64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548151; c=relaxed/simple;
	bh=y1k0HCN5Gp4urLt42KvAu1VEIhS57J7aVrI8d9TALp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBGH8jtgyAhL4gkiCtpaDb+TWrv6brw7RY04SQ+/vFmX7+XfptlIx8o4T8T3f6XfIxCGZiauNCUVtXetyoGBcus4X+C8f1e1xaXul0xwmUwv/E9HySnv7QYRT9IIc+toilCwjYoJs6dwCwClywe+5wot4Iy0iSBhzI1w+tggcaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0TI5v3XM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D371C43399;
	Mon, 29 Jan 2024 17:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548151;
	bh=y1k0HCN5Gp4urLt42KvAu1VEIhS57J7aVrI8d9TALp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0TI5v3XM9Y4TF6XMeC5V4Vm8eNbfkvkQtrb9wyIR3zJrCWPH9aJFg+oJt7mIIbQat
	 +v0qRkbEGwPXNq8vL+wqIborKST++ftoUgThCQbr1viAEdeEMQbJk6LfWC2XWQrxtq
	 /dHjaF0K/6DnImxp3y/iSAJqB6u3apWQKCnn8wXk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yishai Hadas <yishaih@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 189/346] net/mlx5: Fix a WARN upon a callback command failure
Date: Mon, 29 Jan 2024 09:03:40 -0800
Message-ID: <20240129170021.960346018@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yishai Hadas <yishaih@nvidia.com>

[ Upstream commit cc8091587779cfaddb6b29c9e9edb9079a282cad ]

The below WARN [1] is reported once a callback command failed.

As a callback runs under an interrupt context, needs to use the IRQ
save/restore variant.

[1]
DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
WARNING: CPU: 15 PID: 0 at kernel/locking/lockdep.c:4353
              lockdep_hardirqs_on_prepare+0x11b/0x180
Modules linked in: vhost_net vhost tap mlx5_vfio_pci
vfio_pci vfio_pci_core vfio_iommu_type1 vfio mlx5_vdpa vringh
vhost_iotlb vdpa nfnetlink_cttimeout openvswitch nsh ip6table_mangle
ip6table_nat ip6table_filter ip6_tables iptable_mangle
xt_conntrackxt_MASQUERADE nf_conntrack_netlink nfnetlink
xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5
auth_rpcgss oid_registry overlay rpcrdma rdma_ucm ib_iser libiscsi
scsi_transport_iscsi rdma_cm iw_cm ib_umad ib_ipoib ib_cm
mlx5_ib ib_uverbs ib_core fuse mlx5_core
CPU: 15 PID: 0 Comm: swapper/15 Tainted: G        W 6.7.0-rc4+ #1587
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:lockdep_hardirqs_on_prepare+0x11b/0x180
Code: 00 5b c3 c3 e8 e6 0d 58 00 85 c0 74 d6 8b 15 f0 c3
      76 01 85 d2 75 cc 48 c7 c6 04 a5 3b 82 48 c7 c7 f1
      e9 39 82 e8 95 12 f9 ff <0f> 0b 5b c3 e8 bc 0d 58 00
      85 c0 74 ac 8b 3d c6 c3 76 01 85 ff 75
RSP: 0018:ffffc900003ecd18 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000027
RDX: 0000000000000000 RSI: ffff88885fbdb880 RDI: ffff88885fbdb888
RBP: 00000000ffffff87 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 284e4f5f4e524157 R12: 00000000002c9aa1
R13: ffff88810aace980 R14: ffff88810aace9b8 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff88885fbc0000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f731436f4c8 CR3: 000000010aae6001 CR4: 0000000000372eb0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
? __warn+0x81/0x170
? lockdep_hardirqs_on_prepare+0x11b/0x180
? report_bug+0xf8/0x1c0
? handle_bug+0x3f/0x70
? exc_invalid_op+0x13/0x60
? asm_exc_invalid_op+0x16/0x20
? lockdep_hardirqs_on_prepare+0x11b/0x180
? lockdep_hardirqs_on_prepare+0x11b/0x180
trace_hardirqs_on+0x4a/0xa0
raw_spin_unlock_irq+0x24/0x30
cmd_status_err+0xc0/0x1a0 [mlx5_core]
cmd_status_err+0x1a0/0x1a0 [mlx5_core]
mlx5_cmd_exec_cb_handler+0x24/0x40 [mlx5_core]
mlx5_cmd_comp_handler+0x129/0x4b0 [mlx5_core]
cmd_comp_notifier+0x1a/0x20 [mlx5_core]
notifier_call_chain+0x3e/0xe0
atomic_notifier_call_chain+0x5f/0x130
mlx5_eq_async_int+0xe7/0x200 [mlx5_core]
notifier_call_chain+0x3e/0xe0
atomic_notifier_call_chain+0x5f/0x130
irq_int_handler+0x11/0x20 [mlx5_core]
__handle_irq_event_percpu+0x99/0x220
? tick_irq_enter+0x5d/0x80
handle_irq_event_percpu+0xf/0x40
handle_irq_event+0x3a/0x60
handle_edge_irq+0xa2/0x1c0
__common_interrupt+0x55/0x140
common_interrupt+0x7d/0xa0
</IRQ>
<TASK>
asm_common_interrupt+0x22/0x40
RIP: 0010:default_idle+0x13/0x20
Code: c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 72 ff
ff ff cc cc cc cc 8b 05 ea 08 25 01 85 c0 7e 07 0f 00 2d 7f b0 26 00 fb
f4 <fa> c3 90 66 2e 0f 1f 84 00 00 00 00 00 65 48 8b 04 25 80 d0 02 00
RSP: 0018:ffffc9000010fec8 EFLAGS: 00000242
RAX: 0000000000000001 RBX: 000000000000000f RCX: 4000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff811c410c
RBP: ffffffff829478c0 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
? do_idle+0x1ec/0x210
default_idle_call+0x6c/0x90
do_idle+0x1ec/0x210
cpu_startup_entry+0x26/0x30
start_secondary+0x11b/0x150
secondary_startup_64_no_verify+0x165/0x16b
</TASK>
irq event stamp: 833284
hardirqs last  enabled at (833283): [<ffffffff811c410c>]
do_idle+0x1ec/0x210
hardirqs last disabled at (833284): [<ffffffff81daf9ef>]
common_interrupt+0xf/0xa0
softirqs last  enabled at (833224): [<ffffffff81dc199f>]
__do_softirq+0x2bf/0x40e
softirqs last disabled at (833177): [<ffffffff81178ddf>]
irq_exit_rcu+0x7f/0xa0

Fixes: 34f46ae0d4b3 ("net/mlx5: Add command failures data to debugfs")
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index a7b1f9686c09..4957412ff1f6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1923,6 +1923,7 @@ static void cmd_status_log(struct mlx5_core_dev *dev, u16 opcode, u8 status,
 {
 	const char *namep = mlx5_command_str(opcode);
 	struct mlx5_cmd_stats *stats;
+	unsigned long flags;
 
 	if (!err || !(strcmp(namep, "unknown command opcode")))
 		return;
@@ -1930,7 +1931,7 @@ static void cmd_status_log(struct mlx5_core_dev *dev, u16 opcode, u8 status,
 	stats = xa_load(&dev->cmd.stats, opcode);
 	if (!stats)
 		return;
-	spin_lock_irq(&stats->lock);
+	spin_lock_irqsave(&stats->lock, flags);
 	stats->failed++;
 	if (err < 0)
 		stats->last_failed_errno = -err;
@@ -1939,7 +1940,7 @@ static void cmd_status_log(struct mlx5_core_dev *dev, u16 opcode, u8 status,
 		stats->last_failed_mbox_status = status;
 		stats->last_failed_syndrome = syndrome;
 	}
-	spin_unlock_irq(&stats->lock);
+	spin_unlock_irqrestore(&stats->lock, flags);
 }
 
 /* preserve -EREMOTEIO for outbox.status != OK, otherwise return err as is */
-- 
2.43.0




