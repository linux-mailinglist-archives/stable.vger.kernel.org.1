Return-Path: <stable+bounces-120306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD05EA4E857
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D488C4BD0
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF642D3A60;
	Tue,  4 Mar 2025 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hyR4XDmT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98F2857C7
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106216; cv=none; b=I5e8UI/BzCbgnvq1F+GhkMUa0S2F8p7Z27cigzALP6IzlT4/pYczuPo1RNHYqzAxSR65TC0fI+k/6vfIFNeKwpBIQzHXcQZS0RmE2U6/1QrY8ItWqYMzhrhcy37donDZ+8H1Ep02zj116adB3zBkDkOL20r8pdG/gmBHwi4rURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106216; c=relaxed/simple;
	bh=+W5D0orlfV29rsGmpKN4ga3J1b2M7fTGakNYU/c2jns=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AYvGIvp+C7lRtRzvRiN5XC2DKIY+nDaA+uqQqkxgRr4dpNdAhSqLQpPv0BWa2vvKGAsvBOEgLvstUrOS31/sT5/l4YTZXIjc25i1BUw40xAK2anm4JylSumB82rVd5mcEUM0dDqilLfgY1IxXCytL8Dnls0c/alRmdc5mnWBPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hyR4XDmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD66C4CEE7;
	Tue,  4 Mar 2025 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106216;
	bh=+W5D0orlfV29rsGmpKN4ga3J1b2M7fTGakNYU/c2jns=;
	h=Subject:To:Cc:From:Date:From;
	b=hyR4XDmTxcxQX+cDwg3f8VX8ogpajiZvhh02+GcyghwKNxgG2ab2Pv3NxQGVOOCeY
	 4AbE0sZfz4dO8Um5WfH2ea4Ny1E2t2hF8WOg0WNoGBRN5A8IsXhvcOOLZJzhzcNt9z
	 9M7XIJJmJAWdwxPcvydbnzjaKoo6U2+AVGZG8b9w=
Subject: FAILED: patch "[PATCH] net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC" failed to apply to 5.4-stable tree
To: wei.fang@nxp.com,kuba@kernel.org,vladimir.oltean@nxp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:36:38 +0100
Message-ID: <2025030438-undertook-shun-b899@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x a562d0c4a893eae3ea51d512c4d90ab858a6b7ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030438-undertook-shun-b899@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a562d0c4a893eae3ea51d512c4d90ab858a6b7ec Mon Sep 17 00:00:00 2001
From: Wei Fang <wei.fang@nxp.com>
Date: Mon, 24 Feb 2025 19:12:47 +0800
Subject: [PATCH] net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC

Actually ENETC VFs do not support HWTSTAMP_TX_ONESTEP_SYNC because only
ENETC PF can access PMa_SINGLE_STEP registers. And there will be a crash
if VFs are used to test one-step timestamp, the crash log as follows.

[  129.110909] Unable to handle kernel paging request at virtual address 00000000000080c0
[  129.287769] Call trace:
[  129.290219]  enetc_port_mac_wr+0x30/0xec (P)
[  129.294504]  enetc_start_xmit+0xda4/0xe74
[  129.298525]  enetc_xmit+0x70/0xec
[  129.301848]  dev_hard_start_xmit+0x98/0x118

Fixes: 41514737ecaa ("enetc: add get_ts_info interface for ethtool")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20250224111251.1061098-5-wei.fang@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 3cb9ebb13b19..e946d8652790 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3244,6 +3244,9 @@ static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
 		new_offloads |= ENETC_F_TX_TSTAMP;
 		break;
 	case HWTSTAMP_TX_ONESTEP_SYNC:
+		if (!enetc_si_is_pf(priv->si))
+			return -EOPNOTSUPP;
+
 		new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
 		new_offloads |= ENETC_F_TX_ONESTEP_SYNC_TSTAMP;
 		break;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index bf34b5bb1e35..ece3ae28ba82 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -832,6 +832,7 @@ static int enetc_set_coalesce(struct net_device *ndev,
 static int enetc_get_ts_info(struct net_device *ndev,
 			     struct kernel_ethtool_ts_info *info)
 {
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	int *phc_idx;
 
 	phc_idx = symbol_get(enetc_phc_index);
@@ -852,8 +853,10 @@ static int enetc_get_ts_info(struct net_device *ndev,
 				SOF_TIMESTAMPING_TX_SOFTWARE;
 
 	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
-			 (1 << HWTSTAMP_TX_ON) |
-			 (1 << HWTSTAMP_TX_ONESTEP_SYNC);
+			 (1 << HWTSTAMP_TX_ON);
+
+	if (enetc_si_is_pf(priv->si))
+		info->tx_types |= (1 << HWTSTAMP_TX_ONESTEP_SYNC);
 
 	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
 			   (1 << HWTSTAMP_FILTER_ALL);


