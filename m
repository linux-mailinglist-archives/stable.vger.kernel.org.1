Return-Path: <stable+bounces-104581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D5C9F51F2
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C2316640E
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD6A1F7562;
	Tue, 17 Dec 2024 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V/ak1hlo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B41F543C;
	Tue, 17 Dec 2024 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455485; cv=none; b=nKBxD4FII5psl++ktoOd5NHx+OA0ScjJyZj3AJDq1BqhNpxQ7fSkseprwaOGCnBKHiBbAPBzi8PBJYXWyc1HKA90mRhYZ+J1zNvnwevQ7FqnsppslMyE+tJ3PAu3MZAhTVbfZo0l2UrN9sWigT6ORvzz/Op/9Lk2w+ejMa4sU/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455485; c=relaxed/simple;
	bh=O1FaPsNRx/dyP+F8D2LXUch60FeQXLrGo6TzFiUTlsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8LfFna0RxUqnpOCsbC8O6uQldwSUAb5tVQudrKuWXC0iKGRXhLKXrbQMygLvGgCowFyFsj8Va7yS/EfTrN4xjFp7wYMnQ1LCPu/lRQXqdtK9ZcU9W1ZjA306/OXgf8EHSQ3iYvJmOnVPn+HDmlpEfEdpDzKWt6I5aIykx0aXD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V/ak1hlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E6FC4CED3;
	Tue, 17 Dec 2024 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734455485;
	bh=O1FaPsNRx/dyP+F8D2LXUch60FeQXLrGo6TzFiUTlsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V/ak1hloIc4JNFe/7HxE8sTrQQeJH+86ROS/NWYFgchXF5hUdI0VFQEhSSJqzo5/1
	 sYYIWeELvotuQdghGjzRzWwMtnC1NTNXbMtyVp0YsEYCk97kk7HAGtuMen4ioh7+eF
	 lSQppW1Xr8pWCOzQilcTshRPZzH3Gckn6eL1vK9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 26/43] bonding: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL
Date: Tue, 17 Dec 2024 18:07:17 +0100
Message-ID: <20241217170521.508020266@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170520.459491270@linuxfoundation.org>
References: <20241217170520.459491270@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 77b11c8bf3a228d1c63464534c2dcc8d9c8bf7ff ]

Drivers like mlx5 expose NIC's vlan_features such as
NETIF_F_GSO_UDP_TUNNEL & NETIF_F_GSO_UDP_TUNNEL_CSUM which are
later not propagated when the underlying devices are bonded and
a vlan device created on top of the bond.

Right now, the more cumbersome workaround for this is to create
the vlan on top of the mlx5 and then enslave the vlan devices
to a bond.

To fix this, add NETIF_F_GSO_ENCAP_ALL to BOND_VLAN_FEATURES
such that bond_compute_features() can probe and propagate the
vlan_features from the slave devices up to the vlan device.

Given the following bond:

  # ethtool -i enp2s0f{0,1}np{0,1}
  driver: mlx5_core
  [...]

  # ethtool -k enp2s0f0np0 | grep udp
  tx-udp_tnl-segmentation: on
  tx-udp_tnl-csum-segmentation: on
  tx-udp-segmentation: on
  rx-udp_tunnel-port-offload: on
  rx-udp-gro-forwarding: off

  # ethtool -k enp2s0f1np1 | grep udp
  tx-udp_tnl-segmentation: on
  tx-udp_tnl-csum-segmentation: on
  tx-udp-segmentation: on
  rx-udp_tunnel-port-offload: on
  rx-udp-gro-forwarding: off

  # ethtool -k bond0 | grep udp
  tx-udp_tnl-segmentation: on
  tx-udp_tnl-csum-segmentation: on
  tx-udp-segmentation: on
  rx-udp_tunnel-port-offload: off [fixed]
  rx-udp-gro-forwarding: off

Before:

  # ethtool -k bond0.100 | grep udp
  tx-udp_tnl-segmentation: off [requested on]
  tx-udp_tnl-csum-segmentation: off [requested on]
  tx-udp-segmentation: on
  rx-udp_tunnel-port-offload: off [fixed]
  rx-udp-gro-forwarding: off

After:

  # ethtool -k bond0.100 | grep udp
  tx-udp_tnl-segmentation: on
  tx-udp_tnl-csum-segmentation: on
  tx-udp-segmentation: on
  rx-udp_tunnel-port-offload: off [fixed]
  rx-udp-gro-forwarding: off

Various users have run into this reporting performance issues when
configuring Cilium in vxlan tunneling mode and having the combination
of bond & vlan for the core devices connecting the Kubernetes cluster
to the outside world.

Fixes: a9b3ace44c7d ("bonding: fix vlan_features computing")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@idosch.org>
Cc: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20241210141245.327886-3-daniel@iogearbox.net
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/bonding/bond_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 88d031b0ec14..7caaf5b49c7b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1343,6 +1343,7 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 
 #define BOND_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
+				 NETIF_F_GSO_ENCAP_ALL | \
 				 NETIF_F_HIGHDMA | NETIF_F_LRO)
 
 #define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-- 
2.39.5




