Return-Path: <stable+bounces-153731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29087ADD627
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DE13B117C
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3528E2EF292;
	Tue, 17 Jun 2025 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="02YeJ7OZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E482D235067;
	Tue, 17 Jun 2025 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176909; cv=none; b=DpnK+iFxCSizWnCjHnK8TyozPo2q8x+O0Mx9ePWYs6Em/t2ejdpQxd6PK4ExCpuwP3AzkKHzp6C9oFzmoy2wU0wjQv2pMzdvS37OzQCGDNb87kRinyjagJgejVz7oWBopql2N5jDxOR7APsmLVlp573wlBS9aPHWWp/1/Z1hCz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176909; c=relaxed/simple;
	bh=iHjF5fwIQgqU3yg7fROVpp3bOKSOfG2JtcUxj/akvqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVQcKRSm4Kl17ktZeLb8D3imwLNs9LgfMd8JFJjz/Gsb4IbCcX40UpO30NTdAF1mroiibSuOlel/l92sjRcrx4CU1S1XHCaK96fWs04sHvNw5FIrofrfbZD7WvbAOtjWkrrAswK9OASHK9IwbJaEKTQbW6iIrGU+vK7Lk1QcGNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=02YeJ7OZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2CAC4CEE3;
	Tue, 17 Jun 2025 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176908;
	bh=iHjF5fwIQgqU3yg7fROVpp3bOKSOfG2JtcUxj/akvqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=02YeJ7OZnPYIr9c0f40pr5UJNgF58DJ+6LaQvv2e7/j7feL7YAzJLnBP+T99IJ/xn
	 OoBEQGeIc7akBtLFMYCfT8faLwKdi2LX453dnS1wtVkivgoOmB/KNXBKqjs1HH+pyh
	 gdb3PBAe4QFlgwST8wem4KzZsICwiz73mhvvq28c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Jurgens <danielj@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Amir Tzin <amirtz@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 324/356] net/mlx5: Fix ECVF vports unload on shutdown flow
Date: Tue, 17 Jun 2025 17:27:19 +0200
Message-ID: <20250617152351.191968200@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152338.212798615@linuxfoundation.org>
References: <20250617152338.212798615@linuxfoundation.org>
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

From: Amir Tzin <amirtz@nvidia.com>

[ Upstream commit 687560d8a9a2d654829ad0da1ec24242f1de711d ]

Fix shutdown flow UAF when a virtual function is created on the embedded
chip (ECVF) of a BlueField device. In such case the vport acl ingress
table is not properly destroyed.

ECVF functionality is independent of ecpf_vport_exists capability and
thus functions mlx5_eswitch_(enable|disable)_pf_vf_vports() should not
test it when enabling/disabling ECVF vports.

kernel log:
[] refcount_t: underflow; use-after-free.
[] WARNING: CPU: 3 PID: 1 at lib/refcount.c:28
   refcount_warn_saturate+0x124/0x220
----------------
[] Call trace:
[] refcount_warn_saturate+0x124/0x220
[] tree_put_node+0x164/0x1e0 [mlx5_core]
[] mlx5_destroy_flow_table+0x98/0x2c0 [mlx5_core]
[] esw_acl_ingress_table_destroy+0x28/0x40 [mlx5_core]
[] esw_acl_ingress_lgcy_cleanup+0x80/0xf4 [mlx5_core]
[] esw_legacy_vport_acl_cleanup+0x44/0x60 [mlx5_core]
[] esw_vport_cleanup+0x64/0x90 [mlx5_core]
[] mlx5_esw_vport_disable+0xc0/0x1d0 [mlx5_core]
[] mlx5_eswitch_unload_ec_vf_vports+0xcc/0x150 [mlx5_core]
[] mlx5_eswitch_disable_sriov+0x198/0x2a0 [mlx5_core]
[] mlx5_device_disable_sriov+0xb8/0x1e0 [mlx5_core]
[] mlx5_sriov_detach+0x40/0x50 [mlx5_core]
[] mlx5_unload+0x40/0xc4 [mlx5_core]
[] mlx5_unload_one_devl_locked+0x6c/0xe4 [mlx5_core]
[] mlx5_unload_one+0x3c/0x60 [mlx5_core]
[] shutdown+0x7c/0xa4 [mlx5_core]
[] pci_device_shutdown+0x3c/0xa0
[] device_shutdown+0x170/0x340
[] __do_sys_reboot+0x1f4/0x2a0
[] __arm64_sys_reboot+0x2c/0x40
[] invoke_syscall+0x78/0x100
[] el0_svc_common.constprop.0+0x54/0x184
[] do_el0_svc+0x30/0xac
[] el0_svc+0x48/0x160
[] el0t_64_sync_handler+0xa4/0x12c
[] el0t_64_sync+0x1a4/0x1a8
[] --[ end trace 9c4601d68c70030e ]---

Fixes: a7719b29a821 ("net/mlx5: Add management of EC VF vports")
Reviewed-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Link: https://patch.msgid.link/20250610151514.1094735-3-mbloch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index f6022c135ec02..914b380fd3eeb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1295,12 +1295,15 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 		ret = mlx5_eswitch_load_pf_vf_vport(esw, MLX5_VPORT_ECPF, enabled_events);
 		if (ret)
 			goto ecpf_err;
-		if (mlx5_core_ec_sriov_enabled(esw->dev)) {
-			ret = mlx5_eswitch_load_ec_vf_vports(esw, esw->esw_funcs.num_ec_vfs,
-							     enabled_events);
-			if (ret)
-				goto ec_vf_err;
-		}
+	}
+
+	/* Enable ECVF vports */
+	if (mlx5_core_ec_sriov_enabled(esw->dev)) {
+		ret = mlx5_eswitch_load_ec_vf_vports(esw,
+						     esw->esw_funcs.num_ec_vfs,
+						     enabled_events);
+		if (ret)
+			goto ec_vf_err;
 	}
 
 	/* Enable VF vports */
@@ -1331,9 +1334,11 @@ void mlx5_eswitch_disable_pf_vf_vports(struct mlx5_eswitch *esw)
 {
 	mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
 
+	if (mlx5_core_ec_sriov_enabled(esw->dev))
+		mlx5_eswitch_unload_ec_vf_vports(esw,
+						 esw->esw_funcs.num_ec_vfs);
+
 	if (mlx5_ecpf_vport_exists(esw->dev)) {
-		if (mlx5_core_ec_sriov_enabled(esw->dev))
-			mlx5_eswitch_unload_ec_vf_vports(esw, esw->esw_funcs.num_vfs);
 		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_ECPF);
 	}
 
-- 
2.39.5




