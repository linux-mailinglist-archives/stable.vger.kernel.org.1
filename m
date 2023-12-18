Return-Path: <stable+bounces-7205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66DF817167
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859452827D8
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363CD15AC0;
	Mon, 18 Dec 2023 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oj54fNRb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1810129EC8;
	Mon, 18 Dec 2023 13:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B597C433C8;
	Mon, 18 Dec 2023 13:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907845;
	bh=jZ1HEnjWeslorziwnbN61AU0OCo6icilpHf8y+cAZgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oj54fNRb64ORgWAv4wJhlyG2tSf7np2+rtDIlAeO5NWSUt8Bb5LEO3bADZTdR4zxT
	 ZFzceOvkIlzx9w1MAX2EVVwNsL82rmIByjOA2I/zswgcAIcKrJvJSj/BpdQOhJu5EN
	 qEVKtHJiyMabWrYDfa40YDLxiHBRZx7A1tqzZG00=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 039/106] dpaa2-switch: do not ask for MDB, VLAN and FDB replay
Date: Mon, 18 Dec 2023 14:50:53 +0100
Message-ID: <20231218135056.707965075@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

From: Ioana Ciornei <ioana.ciornei@nxp.com>

[ Upstream commit f24a49a375f65e8e75ee1b19d806f46dbaae57fd ]

Starting with commit 4e51bf44a03a ("net: bridge: move the switchdev
object replay helpers to "push" mode") the switchdev_bridge_port_offload()
helper was extended with the intention to provide switchdev drivers easy
access to object addition and deletion replays. This works by calling
the replay helpers with non-NULL notifier blocks.

In the same commit, the dpaa2-switch driver was updated so that it
passes valid notifier blocks to the helper. At that moment, no
regression was identified through testing.

In the meantime, the blamed commit changed the behavior in terms of
which ports get hit by the replay. Before this commit, only the initial
port which identified itself as offloaded through
switchdev_bridge_port_offload() got a replay of all port objects and
FDBs. After this, the newly joining port will trigger a replay of
objects on all bridge ports and on the bridge itself.

This behavior leads to errors in dpaa2_switch_port_vlans_add() when a
VLAN gets installed on the same interface multiple times.

The intended mechanism to address this is to pass a non-NULL ctx to the
switchdev_bridge_port_offload() helper and then check it against the
port's private structure. But since the driver does not have any use for
the replayed port objects and FDBs until it gains support for LAG
offload, it's better to fix the issue by reverting the dpaa2-switch
driver to not ask for replay. The pointers will be added back when we
are prepared to ignore replays on unrelated ports.

Fixes: b28d580e2939 ("net: bridge: switchdev: replay all VLAN groups")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://lore.kernel.org/r/20231212164326.2753457-3-ioana.ciornei@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 2b5909fa93cfa..b98ef4ba172f6 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -1978,9 +1978,6 @@ static int dpaa2_switch_port_attr_set_event(struct net_device *netdev,
 	return notifier_from_errno(err);
 }
 
-static struct notifier_block dpaa2_switch_port_switchdev_nb;
-static struct notifier_block dpaa2_switch_port_switchdev_blocking_nb;
-
 static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 					 struct net_device *upper_dev,
 					 struct netlink_ext_ack *extack)
@@ -2023,9 +2020,7 @@ static int dpaa2_switch_port_bridge_join(struct net_device *netdev,
 		goto err_egress_flood;
 
 	err = switchdev_bridge_port_offload(netdev, netdev, NULL,
-					    &dpaa2_switch_port_switchdev_nb,
-					    &dpaa2_switch_port_switchdev_blocking_nb,
-					    false, extack);
+					    NULL, NULL, false, extack);
 	if (err)
 		goto err_switchdev_offload;
 
@@ -2059,9 +2054,7 @@ static int dpaa2_switch_port_restore_rxvlan(struct net_device *vdev, int vid, vo
 
 static void dpaa2_switch_port_pre_bridge_leave(struct net_device *netdev)
 {
-	switchdev_bridge_port_unoffload(netdev, NULL,
-					&dpaa2_switch_port_switchdev_nb,
-					&dpaa2_switch_port_switchdev_blocking_nb);
+	switchdev_bridge_port_unoffload(netdev, NULL, NULL, NULL);
 }
 
 static int dpaa2_switch_port_bridge_leave(struct net_device *netdev)
-- 
2.43.0




