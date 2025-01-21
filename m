Return-Path: <stable+bounces-109650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722CAA1833D
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D941697AD
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 17:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218B41F543D;
	Tue, 21 Jan 2025 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BVXSZcCV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD93E1E9B38;
	Tue, 21 Jan 2025 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482037; cv=none; b=Arw4kQ43Q8nDk4ynvYOqcaCYTnoTawgu3upA3udyoKmzbLM2vGgE4GaEZouJW/rerGYI7uj8QURrr3dc4aV14haYTwzOw4db3JfbmElBvtbGimMQ7aa2MG0Yy7mnha2qKv3ULG6TJskjmKQ2DlQjWL7PzziGmVk6QagUSVMAhec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482037; c=relaxed/simple;
	bh=DZ8Y5rIPOBGC02MR6eMg30oMWS/yPSG9hxZFf7E2ncc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPyfQSEYk2wF2gEibf3jFcCYQnz1SIHv9Hds8B8zrRoP+bzoMe/5PIPJecPO2IXrSoi5/JRVuhk2y18jOcbkaS4gcJOxKzNVUPXNWGDF4JAyhEYqh8VT8eKmtlF8/JMkT6VkV9gIZ4ZqFNmxtG6ARkT1EgimhZqr2Soyk2D+vHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BVXSZcCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1248C4CEDF;
	Tue, 21 Jan 2025 17:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482037;
	bh=DZ8Y5rIPOBGC02MR6eMg30oMWS/yPSG9hxZFf7E2ncc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BVXSZcCV5jpDiAwIBKq7oNYsLHcbBM97e8uyD6L2ZdOQlLE11HsszP+JfhDo5GR8G
	 cVL6fvFWzcpAxZ6nc46BqsNlwEITBSKyarmCdvanX3M3RzibyWPs04PBXodDEPLpTC
	 SKaaNWGdkbNkPm3tI9BrnrzkvDiXSq+4+FSwcHWc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Zhang <markzhang@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 13/72] net/mlx5: Clear port select structure when fail to create
Date: Tue, 21 Jan 2025 18:51:39 +0100
Message-ID: <20250121174523.939031209@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174523.429119852@linuxfoundation.org>
References: <20250121174523.429119852@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Mark Zhang <markzhang@nvidia.com>

[ Upstream commit 5641e82cb55b4ecbc6366a499300917d2f3e6790 ]

Clear the port select structure on error so no stale values left after
definers are destroyed. That's because the mlx5_lag_destroy_definers()
always try to destroy all lag definers in the tt_map, so in the flow
below lag definers get double-destroyed and cause kernel crash:

  mlx5_lag_port_sel_create()
    mlx5_lag_create_definers()
      mlx5_lag_create_definer()     <- Failed on tt 1
        mlx5_lag_destroy_definers() <- definers[tt=0] gets destroyed
  mlx5_lag_port_sel_create()
    mlx5_lag_create_definers()
      mlx5_lag_create_definer()     <- Failed on tt 0
        mlx5_lag_destroy_definers() <- definers[tt=0] gets double-destroyed

 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
 Mem abort info:
   ESR = 0x0000000096000005
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x05: level 1 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
 user pgtable: 64k pages, 48-bit VAs, pgdp=0000000112ce2e00
 [0000000000000008] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
 Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
 Modules linked in: iptable_raw bonding ip_gre ip6_gre gre ip6_tunnel tunnel6 geneve ip6_udp_tunnel udp_tunnel ipip tunnel4 ip_tunnel rdma_ucm(OE) rdma_cm(OE) iw_cm(OE) ib_ipoib(OE) ib_cm(OE) ib_umad(OE) mlx5_ib(OE) ib_uverbs(OE) mlx5_fwctl(OE) fwctl(OE) mlx5_core(OE) mlxdevm(OE) ib_core(OE) mlxfw(OE) memtrack(OE) mlx_compat(OE) openvswitch nsh nf_conncount psample xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter bridge stp llc netconsole overlay efi_pstore sch_fq_codel zram ip_tables crct10dif_ce qemu_fw_cfg fuse ipv6 crc_ccitt [last unloaded: mlx_compat(OE)]
  CPU: 3 UID: 0 PID: 217 Comm: kworker/u53:2 Tainted: G           OE      6.11.0+ #2
  Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
  Workqueue: mlx5_lag mlx5_do_bond_work [mlx5_core]
  pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : mlx5_del_flow_rules+0x24/0x2c0 [mlx5_core]
  lr : mlx5_lag_destroy_definer+0x54/0x100 [mlx5_core]
  sp : ffff800085fafb00
  x29: ffff800085fafb00 x28: ffff0000da0c8000 x27: 0000000000000000
  x26: ffff0000da0c8000 x25: ffff0000da0c8000 x24: ffff0000da0c8000
  x23: ffff0000c31f81a0 x22: 0400000000000000 x21: ffff0000da0c8000
  x20: 0000000000000000 x19: 0000000000000001 x18: 0000000000000000
  x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffff8b0c9350
  x14: 0000000000000000 x13: ffff800081390d18 x12: ffff800081dc3cc0
  x11: 0000000000000001 x10: 0000000000000b10 x9 : ffff80007ab7304c
  x8 : ffff0000d00711f0 x7 : 0000000000000004 x6 : 0000000000000190
  x5 : ffff00027edb3010 x4 : 0000000000000000 x3 : 0000000000000000
  x2 : ffff0000d39b8000 x1 : ffff0000d39b8000 x0 : 0400000000000000
  Call trace:
   mlx5_del_flow_rules+0x24/0x2c0 [mlx5_core]
   mlx5_lag_destroy_definer+0x54/0x100 [mlx5_core]
   mlx5_lag_destroy_definers+0xa0/0x108 [mlx5_core]
   mlx5_lag_port_sel_create+0x2d4/0x6f8 [mlx5_core]
   mlx5_activate_lag+0x60c/0x6f8 [mlx5_core]
   mlx5_do_bond_work+0x284/0x5c8 [mlx5_core]
   process_one_work+0x170/0x3e0
   worker_thread+0x2d8/0x3e0
   kthread+0x11c/0x128
   ret_from_fork+0x10/0x20
  Code: a9025bf5 aa0003f6 a90363f7 f90023f9 (f9400400)
  ---[ end trace 0000000000000000 ]---

Fixes: dc48516ec7d3 ("net/mlx5: Lag, add support to create definers for LAG")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index 005661248c7e9..9faa9ef863a1b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -540,7 +540,7 @@ int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
 	set_tt_map(port_sel, hash_type);
 	err = mlx5_lag_create_definers(ldev, hash_type, ports);
 	if (err)
-		return err;
+		goto clear_port_sel;
 
 	if (port_sel->tunnel) {
 		err = mlx5_lag_create_inner_ttc_table(ldev);
@@ -559,6 +559,8 @@ int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
 		mlx5_destroy_ttc_table(port_sel->inner.ttc);
 destroy_definers:
 	mlx5_lag_destroy_definers(ldev);
+clear_port_sel:
+	memset(port_sel, 0, sizeof(*port_sel));
 	return err;
 }
 
-- 
2.39.5




