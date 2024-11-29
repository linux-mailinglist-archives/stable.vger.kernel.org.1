Return-Path: <stable+bounces-94320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 597129D3C3F
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31085B23639
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F4C1AB52E;
	Wed, 20 Nov 2024 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L4lP614V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BBF1991AA;
	Wed, 20 Nov 2024 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107665; cv=none; b=cKIwt4c6+exc1Tcoa9OUPcTUOSmQP5d5EyxEzofF0jy0bO+sathUOVPS2yGNoQZA0FGE7hm1MF/Rqo9mDyyU71Jq7cg2fOgskJyJ4h6wFR65AB/IlKqjK+/4wFLNpIVKiM88NbhAv7knwd/aexhOxir7fpS7Oku/D7EOHcF8570=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107665; c=relaxed/simple;
	bh=IJD9ygsKb350e2s2jY2YAS1QxDNlTJ/nVho9Lcg0KwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6cyNaI8UfjbPINwcQlIrsf6uH2T2vG1l6zoZb7jQI1eGcTZr2CvsrR4tQvnUYCKUEjc3MzgMUhcGf9tE2nV2O9TqkFvU2PQBAgOrRD+nT/mrEzlwQzpyubvvJxyIvG0+6IDIf2G8uidtEACnZbjbNb46YDOyQacp/Z/Zb7faLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L4lP614V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89556C4CECD;
	Wed, 20 Nov 2024 13:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732107665;
	bh=IJD9ygsKb350e2s2jY2YAS1QxDNlTJ/nVho9Lcg0KwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L4lP614VNRoxvarEeqXvQhola2iT7kRK6c9KTLcAG6yiRZqUiDithfBbP2I4EoAR4
	 WFMzRV3/7etgcw+ZpFnLacgHwFyR0x0jSCGWhPqC+8j6Z1yT49BbcJczY7QnjrXLnk
	 0/OBMNSJrJM/GuPSxFJi4H6jmcn2Os3y8Wd07DSk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Bloch <mbloch@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 05/73] net/mlx5: fs, lock FTE when checking if active
Date: Wed, 20 Nov 2024 13:57:51 +0100
Message-ID: <20241120125809.753802185@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120125809.623237564@linuxfoundation.org>
References: <20241120125809.623237564@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Bloch <mbloch@nvidia.com>

[ Upstream commit 9ca314419930f9135727e39d77e66262d5f7bef6 ]

The referenced commits introduced a two-step process for deleting FTEs:

- Lock the FTE, delete it from hardware, set the hardware deletion function
  to NULL and unlock the FTE.
- Lock the parent flow group, delete the software copy of the FTE, and
  remove it from the xarray.

However, this approach encounters a race condition if a rule with the same
match value is added simultaneously. In this scenario, fs_core may set the
hardware deletion function to NULL prematurely, causing a panic during
subsequent rule deletions.

To prevent this, ensure the active flag of the FTE is checked under a lock,
which will prevent the fs_core layer from attaching a new steering rule to
an FTE that is in the process of deletion.

[  438.967589] MOSHE: 2496 mlx5_del_flow_rules del_hw_func
[  438.968205] ------------[ cut here ]------------
[  438.968654] refcount_t: decrement hit 0; leaking memory.
[  438.969249] WARNING: CPU: 0 PID: 8957 at lib/refcount.c:31 refcount_warn_saturate+0xfb/0x110
[  438.970054] Modules linked in: act_mirred cls_flower act_gact sch_ingress openvswitch nsh mlx5_vdpa vringh vhost_iotlb vdpa mlx5_ib mlx5_core xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma rdma_ucm ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm ib_uverbs ib_core zram zsmalloc fuse [last unloaded: cls_flower]
[  438.973288] CPU: 0 UID: 0 PID: 8957 Comm: tc Not tainted 6.12.0-rc1+ #8
[  438.973888] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[  438.974874] RIP: 0010:refcount_warn_saturate+0xfb/0x110
[  438.975363] Code: 40 66 3b 82 c6 05 16 e9 4d 01 01 e8 1f 7c a0 ff 0f 0b c3 cc cc cc cc 48 c7 c7 10 66 3b 82 c6 05 fd e8 4d 01 01 e8 05 7c a0 ff <0f> 0b c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90
[  438.976947] RSP: 0018:ffff888124a53610 EFLAGS: 00010286
[  438.977446] RAX: 0000000000000000 RBX: ffff888119d56de0 RCX: 0000000000000000
[  438.978090] RDX: ffff88852c828700 RSI: ffff88852c81b3c0 RDI: ffff88852c81b3c0
[  438.978721] RBP: ffff888120fa0e88 R08: 0000000000000000 R09: ffff888124a534b0
[  438.979353] R10: 0000000000000001 R11: 0000000000000001 R12: ffff888119d56de0
[  438.979979] R13: ffff888120fa0ec0 R14: ffff888120fa0ee8 R15: ffff888119d56de0
[  438.980607] FS:  00007fe6dcc0f800(0000) GS:ffff88852c800000(0000) knlGS:0000000000000000
[  438.983984] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  438.984544] CR2: 00000000004275e0 CR3: 0000000186982001 CR4: 0000000000372eb0
[  438.985205] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  438.985842] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  438.986507] Call Trace:
[  438.986799]  <TASK>
[  438.987070]  ? __warn+0x7d/0x110
[  438.987426]  ? refcount_warn_saturate+0xfb/0x110
[  438.987877]  ? report_bug+0x17d/0x190
[  438.988261]  ? prb_read_valid+0x17/0x20
[  438.988659]  ? handle_bug+0x53/0x90
[  438.989054]  ? exc_invalid_op+0x14/0x70
[  438.989458]  ? asm_exc_invalid_op+0x16/0x20
[  438.989883]  ? refcount_warn_saturate+0xfb/0x110
[  438.990348]  mlx5_del_flow_rules+0x2f7/0x340 [mlx5_core]
[  438.990932]  __mlx5_eswitch_del_rule+0x49/0x170 [mlx5_core]
[  438.991519]  ? mlx5_lag_is_sriov+0x3c/0x50 [mlx5_core]
[  438.992054]  ? xas_load+0x9/0xb0
[  438.992407]  mlx5e_tc_rule_unoffload+0x45/0xe0 [mlx5_core]
[  438.993037]  mlx5e_tc_del_fdb_flow+0x2a6/0x2e0 [mlx5_core]
[  438.993623]  mlx5e_flow_put+0x29/0x60 [mlx5_core]
[  438.994161]  mlx5e_delete_flower+0x261/0x390 [mlx5_core]
[  438.994728]  tc_setup_cb_destroy+0xb9/0x190
[  438.995150]  fl_hw_destroy_filter+0x94/0xc0 [cls_flower]
[  438.995650]  fl_change+0x11a4/0x13c0 [cls_flower]
[  438.996105]  tc_new_tfilter+0x347/0xbc0
[  438.996503]  ? ___slab_alloc+0x70/0x8c0
[  438.996929]  rtnetlink_rcv_msg+0xf9/0x3e0
[  438.997339]  ? __netlink_sendskb+0x4c/0x70
[  438.997751]  ? netlink_unicast+0x286/0x2d0
[  438.998171]  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
[  438.998625]  netlink_rcv_skb+0x54/0x100
[  438.999020]  netlink_unicast+0x203/0x2d0
[  438.999421]  netlink_sendmsg+0x1e4/0x420
[  438.999820]  __sock_sendmsg+0xa1/0xb0
[  439.000203]  ____sys_sendmsg+0x207/0x2a0
[  439.000600]  ? copy_msghdr_from_user+0x6d/0xa0
[  439.001072]  ___sys_sendmsg+0x80/0xc0
[  439.001459]  ? ___sys_recvmsg+0x8b/0xc0
[  439.001848]  ? generic_update_time+0x4d/0x60
[  439.002282]  __sys_sendmsg+0x51/0x90
[  439.002658]  do_syscall_64+0x50/0x110
[  439.003040]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 718ce4d601db ("net/mlx5: Consolidate update FTE for all removal changes")
Fixes: cefc23554fc2 ("net/mlx5: Fix FTE cleanup")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20241107183527.676877-4-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 164e10b5f9b7f..50fdc3cbb778e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1880,13 +1880,22 @@ lookup_fte_locked(struct mlx5_flow_group *g,
 		fte_tmp = NULL;
 		goto out;
 	}
+
+	nested_down_write_ref_node(&fte_tmp->node, FS_LOCK_CHILD);
+
 	if (!fte_tmp->node.active) {
+		up_write_ref_node(&fte_tmp->node, false);
+
+		if (take_write)
+			up_write_ref_node(&g->node, false);
+		else
+			up_read_ref_node(&g->node);
+
 		tree_put_node(&fte_tmp->node, false);
-		fte_tmp = NULL;
-		goto out;
+
+		return NULL;
 	}
 
-	nested_down_write_ref_node(&fte_tmp->node, FS_LOCK_CHILD);
 out:
 	if (take_write)
 		up_write_ref_node(&g->node, false);
-- 
2.43.0




