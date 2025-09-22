Return-Path: <stable+bounces-181101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 500F0B92D97
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFACC1906A96
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559772F0C45;
	Mon, 22 Sep 2025 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ClZ4VCFr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1334CC8E6;
	Mon, 22 Sep 2025 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569691; cv=none; b=gWw7KWsV3yLK1tHufHC0ibyhouZJ6W3BFPB8tT0oV02w0q/SwKQf8mrBHPE8ec0xNyonQ/8wndTctrwdgIAr/f2PTnW/vuvpBHie5ENYGoHIM6plKk7bmYzSXPSZ0KJubPtjpixPSemtjoDSKYbMVPfrAQ8kaOBPiV/Q3D9J8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569691; c=relaxed/simple;
	bh=D6eGF0bIrlP0Js8LzDoqK3dORKNAYqFRvl9SzQey1ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEoL1RT65oW4j0FHkxnxQaQ6V6DpP0r7DTYbAfHhE4ct+Y5cd9Ij/TwStkd5Ry2mJi31MHgRXa6589jVLA/fez7keS2/YRUDLnWVSokEsJf0CKKrd1uiRJhmjZ2eZlOIpf0Pnzz81L3zi1WiwQOS0OIRhgVYckbSjl2vhOk5t2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ClZ4VCFr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F475C4CEF0;
	Mon, 22 Sep 2025 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758569690;
	bh=D6eGF0bIrlP0Js8LzDoqK3dORKNAYqFRvl9SzQey1ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ClZ4VCFrhgO4Mq8+YcH2OriQVQHgvYlHN9N/WLyK0+5N4TsEKcv7MYbOdpV4+kg0D
	 RyemaDG9A95b7Bl/DN070dWS2eUV4QzfNMxG2Y9uD1eFaGgdRkjTJPyzhm6DIDhPRd
	 maAQAB9o0RzfM5ArSV7s3muEDRtwdRSKveSxHCxo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jianbo Liu <jianbol@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 18/70] net/mlx5e: Harden uplink netdev access against device unbind
Date: Mon, 22 Sep 2025 21:29:18 +0200
Message-ID: <20250922192405.041512794@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192404.455120315@linuxfoundation.org>
References: <20250922192404.455120315@linuxfoundation.org>
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

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit 6b4be64fd9fec16418f365c2d8e47a7566e9eba5 ]

The function mlx5_uplink_netdev_get() gets the uplink netdevice
pointer from mdev->mlx5e_res.uplink_netdev. However, the netdevice can
be removed and its pointer cleared when unbound from the mlx5_core.eth
driver. This results in a NULL pointer, causing a kernel panic.

 BUG: unable to handle page fault for address: 0000000000001300
 at RIP: 0010:mlx5e_vport_rep_load+0x22a/0x270 [mlx5_core]
 Call Trace:
  <TASK>
  mlx5_esw_offloads_rep_load+0x68/0xe0 [mlx5_core]
  esw_offloads_enable+0x593/0x910 [mlx5_core]
  mlx5_eswitch_enable_locked+0x341/0x420 [mlx5_core]
  mlx5_devlink_eswitch_mode_set+0x17e/0x3a0 [mlx5_core]
  devlink_nl_eswitch_set_doit+0x60/0xd0
  genl_family_rcv_msg_doit+0xe0/0x130
  genl_rcv_msg+0x183/0x290
  netlink_rcv_skb+0x4b/0xf0
  genl_rcv+0x24/0x40
  netlink_unicast+0x255/0x380
  netlink_sendmsg+0x1f3/0x420
  __sock_sendmsg+0x38/0x60
  __sys_sendto+0x119/0x180
  do_syscall_64+0x53/0x1d0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

Ensure the pointer is valid before use by checking it for NULL. If it
is valid, immediately call netdev_hold() to take a reference, and
preventing the netdevice from being freed while it is in use.

Fixes: 7a9fb35e8c3a ("net/mlx5e: Do not reload ethernet ports when changing eswitch mode")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/1757939074-617281-2-git-send-email-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 27 +++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c |  1 +
 .../ethernet/mellanox/mlx5/core/lib/mlx5.h    | 15 ++++++++++-
 include/linux/mlx5/driver.h                   |  1 +
 4 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 851c499faa795..656a7b65f4c7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1448,12 +1448,21 @@ static const struct mlx5e_profile mlx5e_uplink_rep_profile = {
 static int
 mlx5e_vport_uplink_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 {
-	struct mlx5e_priv *priv = netdev_priv(mlx5_uplink_netdev_get(dev));
 	struct mlx5e_rep_priv *rpriv = mlx5e_rep_to_rep_priv(rep);
+	struct net_device *netdev;
+	struct mlx5e_priv *priv;
+	int err;
+
+	netdev = mlx5_uplink_netdev_get(dev);
+	if (!netdev)
+		return 0;
 
+	priv = netdev_priv(netdev);
 	rpriv->netdev = priv->netdev;
-	return mlx5e_netdev_change_profile(priv, &mlx5e_uplink_rep_profile,
-					   rpriv);
+	err = mlx5e_netdev_change_profile(priv, &mlx5e_uplink_rep_profile,
+					  rpriv);
+	mlx5_uplink_netdev_put(dev, netdev);
+	return err;
 }
 
 static void
@@ -1565,8 +1574,16 @@ mlx5e_vport_rep_unload(struct mlx5_eswitch_rep *rep)
 {
 	struct mlx5e_rep_priv *rpriv = mlx5e_rep_to_rep_priv(rep);
 	struct net_device *netdev = rpriv->netdev;
-	struct mlx5e_priv *priv = netdev_priv(netdev);
-	void *ppriv = priv->ppriv;
+	struct mlx5e_priv *priv;
+	void *ppriv;
+
+	if (!netdev) {
+		ppriv = rpriv;
+		goto free_ppriv;
+	}
+
+	priv = netdev_priv(netdev);
+	ppriv = priv->ppriv;
 
 	if (rep->vport == MLX5_VPORT_UPLINK) {
 		mlx5e_vport_uplink_rep_unload(rpriv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 34f7d814859db..05fbd2098b268 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -733,6 +733,7 @@ static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
 		speed = lksettings.base.speed;
 
 out:
+	mlx5_uplink_netdev_put(mdev, slave);
 	return speed;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
index 2b5826a785c4f..adcc2bc9c8c87 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
@@ -52,6 +52,19 @@ static inline struct net *mlx5_core_net(struct mlx5_core_dev *dev)
 
 static inline struct net_device *mlx5_uplink_netdev_get(struct mlx5_core_dev *mdev)
 {
-	return mdev->mlx5e_res.uplink_netdev;
+	struct mlx5e_resources *mlx5e_res = &mdev->mlx5e_res;
+	struct net_device *netdev;
+
+	mutex_lock(&mlx5e_res->uplink_netdev_lock);
+	netdev = mlx5e_res->uplink_netdev;
+	netdev_hold(netdev, &mlx5e_res->tracker, GFP_KERNEL);
+	mutex_unlock(&mlx5e_res->uplink_netdev_lock);
+	return netdev;
+}
+
+static inline void mlx5_uplink_netdev_put(struct mlx5_core_dev *mdev,
+					  struct net_device *netdev)
+{
+	netdev_put(netdev, &mdev->mlx5e_res.tracker);
 }
 #endif
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 696a2227869fb..c0e0468b25a18 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -677,6 +677,7 @@ struct mlx5e_resources {
 		struct mlx5_sq_bfreg       bfreg;
 	} hw_objs;
 	struct net_device *uplink_netdev;
+	netdevice_tracker tracker;
 	struct mutex uplink_netdev_lock;
 	struct mlx5_crypto_dek_priv *dek_priv;
 };
-- 
2.51.0




