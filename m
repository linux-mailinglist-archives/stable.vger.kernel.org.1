Return-Path: <stable+bounces-56613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6013C92453A
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1696628A70F
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98571BE249;
	Tue,  2 Jul 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dsIeRoxE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E6F1BE227;
	Tue,  2 Jul 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940768; cv=none; b=huhvdSnRP+cUdWpw2ETQgVGUKDdNENYkr55wLR8SxuVDn2HnXUX+T6/pXGOE0NU2fzdRZySl4pMZM9MZwJ9EpU0bi56SW/l4z2OF3W95Vc65oPWXbNFp/GYLcxx1JGInU0az20yUW5NL65FqSYnGOeao9wD6wzZdQjH4kGtMomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940768; c=relaxed/simple;
	bh=YKMrbAIwPjrcbLhahcNT6+OdRZbcrWyO7DOTAeFSoj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMSi2Ptd5poQWiKbLdwKJPH8dNvouJIftdmJ0Gz8Ljp5lW7Pj+HvPGs/pMWC0S9of5ycZncLOx8BhxdntDN48G02L/R4+i9SUc1wqAJayF1bS92TKFRZXfkRP3szdpwL5bQtDHlWvPvuaIBOOeALtEVvMrZ1VtcIeAXGR3XfONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dsIeRoxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E47C116B1;
	Tue,  2 Jul 2024 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940768;
	bh=YKMrbAIwPjrcbLhahcNT6+OdRZbcrWyO7DOTAeFSoj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dsIeRoxEfJtTkK6iruF4/a9bd/+KVkuN+5AtSFNYjwlxSpi072vjquFolPcbo3yZX
	 q8UmYqDIMkj6KKR4ItjnGF49iY6G7MHvD4lRSKpEwulJ6se8EcQKRaqASYGaoDKuyl
	 7PztIH5RHYmnZzaE03k6BdOaZ6ng6CzhGcYgDmig=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 030/163] mlxsw: spectrum_buffers: Fix memory corruptions on Spectrum-4 systems
Date: Tue,  2 Jul 2024 19:02:24 +0200
Message-ID: <20240702170234.199608352@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
References: <20240702170233.048122282@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit c28947de2bed40217cf256c5d0d16880054fcf13 ]

The following two shared buffer operations make use of the Shared Buffer
Status Register (SBSR):

 # devlink sb occupancy snapshot pci/0000:01:00.0
 # devlink sb occupancy clearmax pci/0000:01:00.0

The register has two masks of 256 bits to denote on which ingress /
egress ports the register should operate on. Spectrum-4 has more than
256 ports, so the register was extended by cited commit with a new
'port_page' field.

However, when filling the register's payload, the driver specifies the
ports as absolute numbers and not relative to the first port of the port
page, resulting in memory corruptions [1].

Fix by specifying the ports relative to the first port of the port page.

[1]
BUG: KASAN: slab-use-after-free in mlxsw_sp_sb_occ_snapshot+0xb6d/0xbc0
Read of size 1 at addr ffff8881068cb00f by task devlink/1566
[...]
Call Trace:
 <TASK>
 dump_stack_lvl+0xc6/0x120
 print_report+0xce/0x670
 kasan_report+0xd7/0x110
 mlxsw_sp_sb_occ_snapshot+0xb6d/0xbc0
 mlxsw_devlink_sb_occ_snapshot+0x75/0xb0
 devlink_nl_sb_occ_snapshot_doit+0x1f9/0x2a0
 genl_family_rcv_msg_doit+0x20c/0x300
 genl_rcv_msg+0x567/0x800
 netlink_rcv_skb+0x170/0x450
 genl_rcv+0x2d/0x40
 netlink_unicast+0x547/0x830
 netlink_sendmsg+0x8d4/0xdb0
 __sys_sendto+0x49b/0x510
 __x64_sys_sendto+0xe5/0x1c0
 do_syscall_64+0xc1/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
[...]
Allocated by task 1:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x8f/0xa0
 copy_verifier_state+0xbc2/0xfb0
 do_check_common+0x2c51/0xc7e0
 bpf_check+0x5107/0x9960
 bpf_prog_load+0xf0e/0x2690
 __sys_bpf+0x1a61/0x49d0
 __x64_sys_bpf+0x7d/0xc0
 do_syscall_64+0xc1/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 1:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 poison_slab_object+0x109/0x170
 __kasan_slab_free+0x14/0x30
 kfree+0xca/0x2b0
 free_verifier_state+0xce/0x270
 do_check_common+0x4828/0xc7e0
 bpf_check+0x5107/0x9960
 bpf_prog_load+0xf0e/0x2690
 __sys_bpf+0x1a61/0x49d0
 __x64_sys_bpf+0x7d/0xc0
 do_syscall_64+0xc1/0x1d0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: f8538aec88b4 ("mlxsw: Add support for more than 256 ports in SBSR register")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlxsw/spectrum_buffers.c         | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
index c9f1c79f3f9d0..ba090262e27ef 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_buffers.c
@@ -1607,8 +1607,8 @@ static void mlxsw_sp_sb_sr_occ_query_cb(struct mlxsw_core *mlxsw_core,
 int mlxsw_sp_sb_occ_snapshot(struct mlxsw_core *mlxsw_core,
 			     unsigned int sb_index)
 {
+	u16 local_port, local_port_1, first_local_port, last_local_port;
 	struct mlxsw_sp *mlxsw_sp = mlxsw_core_driver_priv(mlxsw_core);
-	u16 local_port, local_port_1, last_local_port;
 	struct mlxsw_sp_sb_sr_occ_query_cb_ctx cb_ctx;
 	u8 masked_count, current_page = 0;
 	unsigned long cb_priv = 0;
@@ -1628,6 +1628,7 @@ int mlxsw_sp_sb_occ_snapshot(struct mlxsw_core *mlxsw_core,
 	masked_count = 0;
 	mlxsw_reg_sbsr_pack(sbsr_pl, false);
 	mlxsw_reg_sbsr_port_page_set(sbsr_pl, current_page);
+	first_local_port = current_page * MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE;
 	last_local_port = current_page * MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE +
 			  MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE - 1;
 
@@ -1645,9 +1646,12 @@ int mlxsw_sp_sb_occ_snapshot(struct mlxsw_core *mlxsw_core,
 		if (local_port != MLXSW_PORT_CPU_PORT) {
 			/* Ingress quotas are not supported for the CPU port */
 			mlxsw_reg_sbsr_ingress_port_mask_set(sbsr_pl,
-							     local_port, 1);
+							     local_port - first_local_port,
+							     1);
 		}
-		mlxsw_reg_sbsr_egress_port_mask_set(sbsr_pl, local_port, 1);
+		mlxsw_reg_sbsr_egress_port_mask_set(sbsr_pl,
+						    local_port - first_local_port,
+						    1);
 		for (i = 0; i < mlxsw_sp->sb_vals->pool_count; i++) {
 			err = mlxsw_sp_sb_pm_occ_query(mlxsw_sp, local_port, i,
 						       &bulk_list);
@@ -1684,7 +1688,7 @@ int mlxsw_sp_sb_occ_max_clear(struct mlxsw_core *mlxsw_core,
 			      unsigned int sb_index)
 {
 	struct mlxsw_sp *mlxsw_sp = mlxsw_core_driver_priv(mlxsw_core);
-	u16 local_port, last_local_port;
+	u16 local_port, first_local_port, last_local_port;
 	LIST_HEAD(bulk_list);
 	unsigned int masked_count;
 	u8 current_page = 0;
@@ -1702,6 +1706,7 @@ int mlxsw_sp_sb_occ_max_clear(struct mlxsw_core *mlxsw_core,
 	masked_count = 0;
 	mlxsw_reg_sbsr_pack(sbsr_pl, true);
 	mlxsw_reg_sbsr_port_page_set(sbsr_pl, current_page);
+	first_local_port = current_page * MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE;
 	last_local_port = current_page * MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE +
 			  MLXSW_REG_SBSR_NUM_PORTS_IN_PAGE - 1;
 
@@ -1719,9 +1724,12 @@ int mlxsw_sp_sb_occ_max_clear(struct mlxsw_core *mlxsw_core,
 		if (local_port != MLXSW_PORT_CPU_PORT) {
 			/* Ingress quotas are not supported for the CPU port */
 			mlxsw_reg_sbsr_ingress_port_mask_set(sbsr_pl,
-							     local_port, 1);
+							     local_port - first_local_port,
+							     1);
 		}
-		mlxsw_reg_sbsr_egress_port_mask_set(sbsr_pl, local_port, 1);
+		mlxsw_reg_sbsr_egress_port_mask_set(sbsr_pl,
+						    local_port - first_local_port,
+						    1);
 		for (i = 0; i < mlxsw_sp->sb_vals->pool_count; i++) {
 			err = mlxsw_sp_sb_pm_occ_clear(mlxsw_sp, local_port, i,
 						       &bulk_list);
-- 
2.43.0




