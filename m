Return-Path: <stable+bounces-145579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F0ABDC9A
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96023B8367
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCEF248F5A;
	Tue, 20 May 2025 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KRE3r2PW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABB61CD3F;
	Tue, 20 May 2025 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750585; cv=none; b=W6lQRp/Clt889QpWwKkV6RBv74xomoZZuuYqTtJELERD72dWlsfc9kXw5cu+MqJP8uQtHrOWKVT1uVNtyyp31IKHVT4N4tgS3+AbU2YxBoetlH4gmwh1JARb19JYZTSw/AoWRIoTAld5tNF7pWtWw1ZlCLUxqJIO35ykTLdu3jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750585; c=relaxed/simple;
	bh=x9CSq66Q2Aj2K6lScyF0B1zGPtVOqmhanOxDhk7RJ98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MM7pjntNwEuZDV5rDyPnJ+0dUP9l7VL1LxEsyKVvWGsBl0+sJSVf5e9307Pi7IC/kDVhdPVPPGz9IcW/xUyx2NcpsWBvecFFCvSQGEL9HfLqtgsHozlHRYdFjJd5rF2A2a/bAZQprbN/OF+WwhokV9t7HilDaZldjNlxSXquVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KRE3r2PW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB42C4CEE9;
	Tue, 20 May 2025 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747750585;
	bh=x9CSq66Q2Aj2K6lScyF0B1zGPtVOqmhanOxDhk7RJ98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRE3r2PWvOQQvez8iDqovv3kLZaNQDwOdVhrTncitFnjyNwUnVK0ZW2ZtVN4TDCL/
	 lOKimEvFqLIQNk8D8EUHT2a4ZpWSjmrVJCS+8Ir1eZs9roDaK5XrJhZK1cg7jJUhqc
	 10kGh1CbC45Qs0YyBRkKpacZ7cXx2qiib+oe3qZ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 057/145] mlxsw: spectrum_router: Fix use-after-free when deleting GRE net devices
Date: Tue, 20 May 2025 15:50:27 +0200
Message-ID: <20250520125812.813190278@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125810.535475500@linuxfoundation.org>
References: <20250520125810.535475500@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 92ec4855034b2c4d13f117558dc73d20581fa9ff ]

The driver only offloads neighbors that are constructed on top of net
devices registered by it or their uppers (which are all Ethernet). The
device supports GRE encapsulation and decapsulation of forwarded
traffic, but the driver will not offload dummy neighbors constructed on
top of GRE net devices as they are not uppers of its net devices:

 # ip link add name gre1 up type gre tos inherit local 192.0.2.1 remote 198.51.100.1
 # ip neigh add 0.0.0.0 lladdr 0.0.0.0 nud noarp dev gre1
 $ ip neigh show dev gre1 nud noarp
 0.0.0.0 lladdr 0.0.0.0 NOARP

(Note that the neighbor is not marked with 'offload')

When the driver is reloaded and the existing configuration is replayed,
the driver does not perform the same check regarding existing neighbors
and offloads the previously added one:

 # devlink dev reload pci/0000:01:00.0
 $ ip neigh show dev gre1 nud noarp
 0.0.0.0 lladdr 0.0.0.0 offload NOARP

If the neighbor is later deleted, the driver will ignore the
notification (given the GRE net device is not its upper) and will
therefore keep referencing freed memory, resulting in a use-after-free
[1] when the net device is deleted:

 # ip neigh del 0.0.0.0 lladdr 0.0.0.0 dev gre1
 # ip link del dev gre1

Fix by skipping neighbor replay if the net device for which the replay
is performed is not our upper.

[1]
BUG: KASAN: slab-use-after-free in mlxsw_sp_neigh_entry_update+0x1ea/0x200
Read of size 8 at addr ffff888155b0e420 by task ip/2282
[...]
Call Trace:
 <TASK>
 dump_stack_lvl+0x6f/0xa0
 print_address_description.constprop.0+0x6f/0x350
 print_report+0x108/0x205
 kasan_report+0xdf/0x110
 mlxsw_sp_neigh_entry_update+0x1ea/0x200
 mlxsw_sp_router_rif_gone_sync+0x2a8/0x440
 mlxsw_sp_rif_destroy+0x1e9/0x750
 mlxsw_sp_netdevice_ipip_ol_event+0x3c9/0xdc0
 mlxsw_sp_router_netdevice_event+0x3ac/0x15e0
 notifier_call_chain+0xca/0x150
 call_netdevice_notifiers_info+0x7f/0x100
 unregister_netdevice_many_notify+0xc8c/0x1d90
 rtnl_dellink+0x34e/0xa50
 rtnetlink_rcv_msg+0x6fb/0xb70
 netlink_rcv_skb+0x131/0x360
 netlink_unicast+0x426/0x710
 netlink_sendmsg+0x75a/0xc20
 __sock_sendmsg+0xc1/0x150
 ____sys_sendmsg+0x5aa/0x7b0
 ___sys_sendmsg+0xfc/0x180
 __sys_sendmsg+0x121/0x1b0
 do_syscall_64+0xbb/0x1d0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 8fdb09a7674c ("mlxsw: spectrum_router: Replay neighbours when RIF is made")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Link: https://patch.msgid.link/c53c02c904fde32dad484657be3b1477884e9ad6.1747225701.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 7d6d859cef3f9..511cd92e0e3e7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3014,6 +3014,9 @@ static int mlxsw_sp_neigh_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
 		.rif = rif,
 	};
 
+	if (!mlxsw_sp_dev_lower_is_port(mlxsw_sp_rif_dev(rif)))
+		return 0;
+
 	neigh_for_each(&arp_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
 	if (rms.err)
 		goto err_arp;
-- 
2.39.5




