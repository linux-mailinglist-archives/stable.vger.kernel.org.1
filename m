Return-Path: <stable+bounces-120303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83022A4E7D6
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727698A6D3E
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C74296D44;
	Tue,  4 Mar 2025 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ej4NshwO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9742C154C
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106207; cv=none; b=UGOED9NufclzcNIUG1abnzeQmNAjwQwYSO0p916mFOKI5vlRQUU8QppkerFI4uljOFRmjJaCh900amS27NZLeye/1GO0Gv3FNX0KPq/vT9KIxqQXIa1S+u/E8AsTuAdhoqwz1C3T1l+u4We+0cQXfQHJmyzZl/dlA4SrLnV/6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106207; c=relaxed/simple;
	bh=WfDlu5VmiBZ9OfxGke/NabbMvqYAVy36Sl47vLYbBb8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EoA35QNRDDKqwt+2kwgQTr6ajAHsc/NdRfCZcnWgUSwXWJR9aNUNxt7V5BD0xsjf1qwXvlZfHZvkqQs2A9NlfnRnZoSjLdsvfubuYJr+6tEYY2yerLT5glR+b4C5SJvrngmhAcbyCQA5WTJunLF+MpKwvekDMr7W3INHbjsruuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ej4NshwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1FBC4CEE5;
	Tue,  4 Mar 2025 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106207;
	bh=WfDlu5VmiBZ9OfxGke/NabbMvqYAVy36Sl47vLYbBb8=;
	h=Subject:To:Cc:From:Date:From;
	b=ej4NshwOc2zzi4wRSbFdcYu62WEosbks4phXrtvmb8SiI2Ne0c0a2cNoWWXr3sGfu
	 ZXQSIx94VVcTkTVfP11aeerUiS0I3U9A+nh7eOoE6qWF88vhFDbpcp1NrS9h99KuG0
	 VmBMJWnZi/ArqK65jmXESHYV3fJ07sXXHk8z88gU=
Subject: FAILED: patch "[PATCH] net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC" failed to apply to 6.1-stable tree
To: wei.fang@nxp.com,kuba@kernel.org,vladimir.oltean@nxp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:36:36 +0100
Message-ID: <2025030436-plural-dislodge-e1b9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a562d0c4a893eae3ea51d512c4d90ab858a6b7ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030436-plural-dislodge-e1b9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


