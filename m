Return-Path: <stable+bounces-91020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613FF9BEC12
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BC91C231BC
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186531F131D;
	Wed,  6 Nov 2024 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zmZob4fc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE81EF955;
	Wed,  6 Nov 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897503; cv=none; b=bXEz/5JT56XilRt5KT8XdOxvXGxWYmlEUZnOPX89A8UcASkPK/TSguphxgvs1GJtz9pqq1ayvvCmsq2EZ36tkvjB1uqAWHNhj2tpi4h3lRFHL7JDqGoSJzKZRUF0fphr5AJqktB1SLEBanrFrWc4hT0iPd5vc308Fy5L/RdJXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897503; c=relaxed/simple;
	bh=JMdrOyWsucr2n7t+goqgZIbacI7RqYIA3Wxm9iRK7f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVyL22Ek2mXDsm/Yy09Z+o3cevnO4WOIkA3MLxHA36pZKe2YZ0pLXWF6Z2IdkUTT8pvbotQqsNIi9i9tFjwIH4aZQJ+rDcggimiShdArtmnxPGSQTSeVlXWshSmLGbv0qabA2mb4hnTUnUfnJk4h2Phl6D0ysFm61/D+gaT5L+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zmZob4fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D25C4CECD;
	Wed,  6 Nov 2024 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897503;
	bh=JMdrOyWsucr2n7t+goqgZIbacI7RqYIA3Wxm9iRK7f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zmZob4fcBBo9PqHAuBBfCLYTQF3AmC/PdVCkUy3bOPrjXQMVBSw8HUsZedL5SPqVs
	 Dk/hihdMRmrFOx/45xeSTVptle9f6+Xs0CUAPx5cflIGSs3GZ329iIiFjGHQQ9au6W
	 UHSoyH/UmpKM/jxL7/MPedPFaQONOtXJe2jzWC7g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maksym Yaremchuk <maksymy@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 038/151] mlxsw: spectrum_ipip: Fix memory leak when changing remote IPv6 address
Date: Wed,  6 Nov 2024 13:03:46 +0100
Message-ID: <20241106120309.880914307@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
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

[ Upstream commit 12ae97c531fcd3bfd774d4dfeaeac23eafe24280 ]

The device stores IPv6 addresses that are used for encapsulation in
linear memory that is managed by the driver.

Changing the remote address of an ip6gre net device never worked
properly, but since cited commit the following reproducer [1] would
result in a warning [2] and a memory leak [3]. The problem is that the
new remote address is never added by the driver to its hash table (and
therefore the device) and the old address is never removed from it.

Fix by programming the new address when the configuration of the ip6gre
net device changes and removing the old one. If the address did not
change, then the above would result in increasing the reference count of
the address and then decreasing it.

[1]
 # ip link add name bla up type ip6gre local 2001:db8:1::1 remote 2001:db8:2::1 tos inherit ttl inherit
 # ip link set dev bla type ip6gre remote 2001:db8:3::1
 # ip link del dev bla
 # devlink dev reload pci/0000:01:00.0

[2]
WARNING: CPU: 0 PID: 1682 at drivers/net/ethernet/mellanox/mlxsw/spectrum.c:3002 mlxsw_sp_ipv6_addr_put+0x140/0x1d0
Modules linked in:
CPU: 0 UID: 0 PID: 1682 Comm: ip Not tainted 6.12.0-rc3-custom-g86b5b55bc835 #151
Hardware name: Nvidia SN5600/VMOD0013, BIOS 5.13 05/31/2023
RIP: 0010:mlxsw_sp_ipv6_addr_put+0x140/0x1d0
[...]
Call Trace:
 <TASK>
 mlxsw_sp_router_netdevice_event+0x55f/0x1240
 notifier_call_chain+0x5a/0xd0
 call_netdevice_notifiers_info+0x39/0x90
 unregister_netdevice_many_notify+0x63e/0x9d0
 rtnl_dellink+0x16b/0x3a0
 rtnetlink_rcv_msg+0x142/0x3f0
 netlink_rcv_skb+0x50/0x100
 netlink_unicast+0x242/0x390
 netlink_sendmsg+0x1de/0x420
 ____sys_sendmsg+0x2bd/0x320
 ___sys_sendmsg+0x9a/0xe0
 __sys_sendmsg+0x7a/0xd0
 do_syscall_64+0x9e/0x1a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

[3]
unreferenced object 0xffff898081f597a0 (size 32):
  comm "ip", pid 1626, jiffies 4294719324
  hex dump (first 32 bytes):
    20 01 0d b8 00 02 00 00 00 00 00 00 00 00 00 01   ...............
    21 49 61 83 80 89 ff ff 00 00 00 00 01 00 00 00  !Ia.............
  backtrace (crc fd9be911):
    [<00000000df89c55d>] __kmalloc_cache_noprof+0x1da/0x260
    [<00000000ff2a1ddb>] mlxsw_sp_ipv6_addr_kvdl_index_get+0x281/0x340
    [<000000009ddd445d>] mlxsw_sp_router_netdevice_event+0x47b/0x1240
    [<00000000743e7757>] notifier_call_chain+0x5a/0xd0
    [<000000007c7b9e13>] call_netdevice_notifiers_info+0x39/0x90
    [<000000002509645d>] register_netdevice+0x5f7/0x7a0
    [<00000000c2e7d2a9>] ip6gre_newlink_common.isra.0+0x65/0x130
    [<0000000087cd6d8d>] ip6gre_newlink+0x72/0x120
    [<000000004df7c7cc>] rtnl_newlink+0x471/0xa20
    [<0000000057ed632a>] rtnetlink_rcv_msg+0x142/0x3f0
    [<0000000032e0d5b5>] netlink_rcv_skb+0x50/0x100
    [<00000000908bca63>] netlink_unicast+0x242/0x390
    [<00000000cdbe1c87>] netlink_sendmsg+0x1de/0x420
    [<0000000011db153e>] ____sys_sendmsg+0x2bd/0x320
    [<000000003b6d53eb>] ___sys_sendmsg+0x9a/0xe0
    [<00000000cae27c62>] __sys_sendmsg+0x7a/0xd0

Fixes: cf42911523e0 ("mlxsw: spectrum_ipip: Use common hash table for IPv6 address mapping")
Reported-by: Maksym Yaremchuk <maksymy@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Link: https://patch.msgid.link/e91012edc5a6cb9df37b78fd377f669381facfcb.1729866134.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/mellanox/mlxsw/spectrum_ipip.c   | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
index 3340b4a694c3e..cbded3ed64505 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
@@ -471,11 +471,33 @@ mlxsw_sp_ipip_ol_netdev_change_gre6(struct mlxsw_sp *mlxsw_sp,
 				    struct mlxsw_sp_ipip_entry *ipip_entry,
 				    struct netlink_ext_ack *extack)
 {
+	u32 new_kvdl_index, old_kvdl_index = ipip_entry->dip_kvdl_index;
+	struct in6_addr old_addr6 = ipip_entry->parms.daddr.addr6;
 	struct mlxsw_sp_ipip_parms new_parms;
+	int err;
 
 	new_parms = mlxsw_sp_ipip_netdev_parms_init_gre6(ipip_entry->ol_dev);
-	return mlxsw_sp_ipip_ol_netdev_change_gre(mlxsw_sp, ipip_entry,
-						  &new_parms, extack);
+
+	err = mlxsw_sp_ipv6_addr_kvdl_index_get(mlxsw_sp,
+						&new_parms.daddr.addr6,
+						&new_kvdl_index);
+	if (err)
+		return err;
+	ipip_entry->dip_kvdl_index = new_kvdl_index;
+
+	err = mlxsw_sp_ipip_ol_netdev_change_gre(mlxsw_sp, ipip_entry,
+						 &new_parms, extack);
+	if (err)
+		goto err_change_gre;
+
+	mlxsw_sp_ipv6_addr_put(mlxsw_sp, &old_addr6);
+
+	return 0;
+
+err_change_gre:
+	ipip_entry->dip_kvdl_index = old_kvdl_index;
+	mlxsw_sp_ipv6_addr_put(mlxsw_sp, &new_parms.daddr.addr6);
+	return err;
 }
 
 static int
-- 
2.43.0




