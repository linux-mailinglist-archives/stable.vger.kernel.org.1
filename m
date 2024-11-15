Return-Path: <stable+bounces-93163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5979CD7B4
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5804281EBB
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35EA18A921;
	Fri, 15 Nov 2024 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K8+CsLKj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713ED188701;
	Fri, 15 Nov 2024 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653017; cv=none; b=swRQz6eoLaFGGaoRgFDpPSWwcrxzaJdxvzxtLN/t6LSlx7lp/igzArlbDSyL/0mvcwuBAs7MQkGQ3q5PgO3JWVYLodxY4TNFluQEX34VuqD5KXH/5n1pVFGVGx5Mf4ycOBMdRFkzjP2dU8e9MMkTt8rznUXXp6RL1jUI4PU4uG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653017; c=relaxed/simple;
	bh=QBTg2KMb9OSEZzlC+i1bY++7i+J0JtzylNZaiPbzays=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzxOGL6U40BK1LUgb/bDQbKdHqiq4EtUSCz1bqx92AUZoV1JtHbvquzJ3Dc8GVwVDgLu8G6winL0rmAUwHQ4+mQ3hnpq0sOqTpFqBj30CW2ZjvGJW3Ld4yXhznDn8nCu/6Y1ZZT27bufQfahh49G99cduMiiP9WXMuD3u8HkerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K8+CsLKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6593C4CECF;
	Fri, 15 Nov 2024 06:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653017;
	bh=QBTg2KMb9OSEZzlC+i1bY++7i+J0JtzylNZaiPbzays=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8+CsLKjK2Gz5fPq9fKfQHLyvNbwzhSorg+g3yXGa1X4dZyGcBpWwyIPJnouSluPt
	 s1F2k2vbD/gKVPgCJOvlLJiDBCX36KbYt19UiHoZgJXeQeSlZ/864HXts4UWrJ+tPC
	 VPISw05sXw7PYfHx+sQwbklHG/EOSoINKJE2GLcc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Fang <wei.fang@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 12/66] net: enetc: set MAC address to the VF net_device
Date: Fri, 15 Nov 2024 07:37:21 +0100
Message-ID: <20241115063723.286509695@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.834793938@linuxfoundation.org>
References: <20241115063722.834793938@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit badccd49b93bb945bf4e5cc8707db67cdc5e27e5 ]

The MAC address of VF can be configured through the mailbox mechanism of
ENETC, but the previous implementation forgot to set the MAC address in
net_device, resulting in the SMAC of the sent frames still being the old
MAC address. Since the MAC address in the hardware has been changed, Rx
cannot receive frames with the DMAC address as the new MAC address. The
most obvious phenomenon is that after changing the MAC address, we can
see that the MAC address of eno0vf0 has not changed through the "ifconfig
eno0vf0" command and the IP address cannot be obtained .

root@ls1028ardb:~# ifconfig eno0vf0 down
root@ls1028ardb:~# ifconfig eno0vf0 hw ether 00:04:9f:3a:4d:56 up
root@ls1028ardb:~# ifconfig eno0vf0
eno0vf0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 66:36:2c:3b:87:76  txqueuelen 1000  (Ethernet)
        RX packets 794  bytes 69239 (69.2 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 11  bytes 2226 (2.2 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Link: https://patch.msgid.link/20241029090406.841836-1-wei.fang@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_vf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index af287b6d5f3b7..85998060df705 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -85,11 +85,18 @@ static int enetc_vf_set_mac_addr(struct net_device *ndev, void *addr)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct sockaddr *saddr = addr;
+	int err;
 
 	if (!is_valid_ether_addr(saddr->sa_data))
 		return -EADDRNOTAVAIL;
 
-	return enetc_msg_vsi_set_primary_mac_addr(priv, saddr);
+	err = enetc_msg_vsi_set_primary_mac_addr(priv, saddr);
+	if (err)
+		return err;
+
+	eth_hw_addr_set(ndev, saddr->sa_data);
+
+	return 0;
 }
 
 static int enetc_vf_set_features(struct net_device *ndev,
-- 
2.43.0




