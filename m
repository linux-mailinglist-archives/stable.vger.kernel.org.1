Return-Path: <stable+bounces-104987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EBA9F5475
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 737F216E639
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446CA1FC11F;
	Tue, 17 Dec 2024 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XDc8llaS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F316F1F8F0C;
	Tue, 17 Dec 2024 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456728; cv=none; b=poiGGKwCQxgcZA82T13tdqV/59Kot8MSxIM7yaLiIVGVImArOujbi6ZLY36w/lHUK103VkZUTlbN+9rkg8HL6HZEJd7m7Um7I+mAbGQ6SoXfMJlFKYW9hd/7dVLQU5fCwc/0NwVsrP00qNkl/CTqBY/R5jFY8PEuoLwNfP2l9dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456728; c=relaxed/simple;
	bh=XMgx/Ga+ivC7bhYF2eVO6LMViIKLIFDGprLp1moXitI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktwu1tFOQQIYzE2JqzWxtCjwZqwa2hK9F13ECO3qwR0IZyEfOVB7S2Pp1UmlW7gOYKzLBGbkvOqHUJVrYMPzuAbVRwsT78yPnjkFS/zX3F+d65mlHQ3Gl2yoOnwCFzJw9tAjYhDlbZxSUl1l581HQMTaajx+eO+Z5syKWOqxIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XDc8llaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788ADC4CEF4;
	Tue, 17 Dec 2024 17:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456727;
	bh=XMgx/Ga+ivC7bhYF2eVO6LMViIKLIFDGprLp1moXitI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XDc8llaS0dQ03e/wc4ojZzjVQd03BtoXd8RILZrGtoTVuO368N+3+lJ/kf1wMf2mw
	 uEKZig5ZlnxXBlBz3vsBKdunMPlsRg+JEvD02/Wiqwzm7VUmuLz4vmWUGFdIMKRfmw
	 vP2fTtGD8bBm2lS9RPpMp+viGKI0lKGmuq8WaEMs=
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
Subject: [PATCH 6.12 142/172] bonding: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL
Date: Tue, 17 Dec 2024 18:08:18 +0100
Message-ID: <20241217170552.225423484@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
References: <20241217170546.209657098@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index dfad7b6f9f35..4d73abae503d 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1534,6 +1534,7 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
 
 #define BOND_VLAN_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
 				 NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
+				 NETIF_F_GSO_ENCAP_ALL | \
 				 NETIF_F_HIGHDMA | NETIF_F_LRO)
 
 #define BOND_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
-- 
2.39.5




