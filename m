Return-Path: <stable+bounces-109527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDD3A16D92
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20DF57A2618
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4C81E1C36;
	Mon, 20 Jan 2025 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ns9rX+YO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01EB1E1C16
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737380610; cv=none; b=oIZZB8VI1HsXfC4mCmZ0BmvXSRMB6tQ3EVC87zeLm/mHhijS1WjtV7TYierOvdKzPCSHaM3xC+Z6cyNUE2/ZBKD+4LdEp8MOI7D95lpHWeshj+blbD1fV4JdVZCwQuALmUbBbp+5URrWCzeNX/Ak4majzTtYZGKyngcC3XOQRIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737380610; c=relaxed/simple;
	bh=LKppw7yNZo62is8uOCecIBdhST9nCk0g8o//jlRIUr0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PVEWuraVZ/0MFCslc1M+QPIn8Xc6D3MrUYJEq5WgxsMx32yRJRhx2C/WqmmXumecdCD9YCG5yHa2XBqg3zI9Ys7/UKw88Z/UlkXO+YVILNo9wI2qif64jPL6EncggadDPONQXhox7S69cwIfFkmKXcldmax/VXwglYa7M3sxkn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ns9rX+YO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46809C4CEDD;
	Mon, 20 Jan 2025 13:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737380610;
	bh=LKppw7yNZo62is8uOCecIBdhST9nCk0g8o//jlRIUr0=;
	h=Subject:To:Cc:From:Date:From;
	b=Ns9rX+YOPoLFOvU1cDzNNBhlywC/Zmuvwddrn8Uo5R5F1uNierWUvnwONl15ltfZ2
	 H3/AZw6xoLVx/B/DjnkS6jBdSAYJ1hC0v/ISdopE/s9RO1YS7xqyeAKk7cIi2FNOEA
	 934ZEN3ZzXciEHbqqCbADT8QeWYMKbpzYm1aFYJs=
Subject: FAILED: patch "[PATCH] net/ncsi: fix locking in Get MAC Address handling" failed to apply to 6.1-stable tree
To: fercerpav@gmail.com,kuba@kernel.org,potin.lai.pt@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jan 2025 14:43:17 +0100
Message-ID: <2025012017-task-neurology-92af@gregkh>
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
git cherry-pick -x 9e2bbab94b88295dcc57c7580393c9ee08d7314d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025012017-task-neurology-92af@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9e2bbab94b88295dcc57c7580393c9ee08d7314d Mon Sep 17 00:00:00 2001
From: Paul Fertser <fercerpav@gmail.com>
Date: Thu, 9 Jan 2025 17:50:54 +0300
Subject: [PATCH] net/ncsi: fix locking in Get MAC Address handling

Obtaining RTNL lock in a response handler is not allowed since it runs
in an atomic softirq context. Postpone setting the MAC address by adding
a dedicated step to the configuration FSM.

Fixes: 790071347a0a ("net/ncsi: change from ndo_set_mac_address to dev_set_mac_address")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20241129-potin-revert-ncsi-set-mac-addr-v1-1-94ea2cb596af@gmail.com
Signed-off-by: Paul Fertser <fercerpav@gmail.com>
Tested-by: Potin Lai <potin.lai.pt@gmail.com>
Link: https://patch.msgid.link/20250109145054.30925-1-fercerpav@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index ef0f8f73826f..4e0842df5234 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -289,6 +289,7 @@ enum {
 	ncsi_dev_state_config_sp	= 0x0301,
 	ncsi_dev_state_config_cis,
 	ncsi_dev_state_config_oem_gma,
+	ncsi_dev_state_config_apply_mac,
 	ncsi_dev_state_config_clear_vids,
 	ncsi_dev_state_config_svf,
 	ncsi_dev_state_config_ev,
@@ -322,6 +323,7 @@ struct ncsi_dev_priv {
 #define NCSI_DEV_RESHUFFLE	4
 #define NCSI_DEV_RESET		8            /* Reset state of NC          */
 	unsigned int        gma_flag;        /* OEM GMA flag               */
+	struct sockaddr     pending_mac;     /* MAC address received from GMA */
 	spinlock_t          lock;            /* Protect the NCSI device    */
 	unsigned int        package_probe_id;/* Current ID during probe    */
 	unsigned int        package_num;     /* Number of packages         */
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 5cf55bde366d..bf276eaf9330 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1038,7 +1038,7 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 			  : ncsi_dev_state_config_clear_vids;
 		break;
 	case ncsi_dev_state_config_oem_gma:
-		nd->state = ncsi_dev_state_config_clear_vids;
+		nd->state = ncsi_dev_state_config_apply_mac;
 
 		nca.package = np->id;
 		nca.channel = nc->id;
@@ -1050,10 +1050,22 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 			nca.type = NCSI_PKT_CMD_OEM;
 			ret = ncsi_gma_handler(&nca, nc->version.mf_id);
 		}
-		if (ret < 0)
+		if (ret < 0) {
+			nd->state = ncsi_dev_state_config_clear_vids;
 			schedule_work(&ndp->work);
+		}
 
 		break;
+	case ncsi_dev_state_config_apply_mac:
+		rtnl_lock();
+		ret = dev_set_mac_address(dev, &ndp->pending_mac, NULL);
+		rtnl_unlock();
+		if (ret < 0)
+			netdev_warn(dev, "NCSI: 'Writing MAC address to device failed\n");
+
+		nd->state = ncsi_dev_state_config_clear_vids;
+
+		fallthrough;
 	case ncsi_dev_state_config_clear_vids:
 	case ncsi_dev_state_config_svf:
 	case ncsi_dev_state_config_ev:
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index e28be33bdf2c..14bd66909ca4 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -628,16 +628,14 @@ static int ncsi_rsp_handler_snfc(struct ncsi_request *nr)
 static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
+	struct sockaddr *saddr = &ndp->pending_mac;
 	struct net_device *ndev = ndp->ndev.dev;
 	struct ncsi_rsp_oem_pkt *rsp;
-	struct sockaddr saddr;
 	u32 mac_addr_off = 0;
-	int ret = 0;
 
 	/* Get the response header */
 	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
 
-	saddr.sa_family = ndev->type;
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	if (mfr_id == NCSI_OEM_MFR_BCM_ID)
 		mac_addr_off = BCM_MAC_ADDR_OFFSET;
@@ -646,22 +644,17 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 	else if (mfr_id == NCSI_OEM_MFR_INTEL_ID)
 		mac_addr_off = INTEL_MAC_ADDR_OFFSET;
 
-	memcpy(saddr.sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
+	saddr->sa_family = ndev->type;
+	memcpy(saddr->sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
 	if (mfr_id == NCSI_OEM_MFR_BCM_ID || mfr_id == NCSI_OEM_MFR_INTEL_ID)
-		eth_addr_inc((u8 *)saddr.sa_data);
-	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
+		eth_addr_inc((u8 *)saddr->sa_data);
+	if (!is_valid_ether_addr((const u8 *)saddr->sa_data))
 		return -ENXIO;
 
 	/* Set the flag for GMA command which should only be called once */
 	ndp->gma_flag = 1;
 
-	rtnl_lock();
-	ret = dev_set_mac_address(ndev, &saddr, NULL);
-	rtnl_unlock();
-	if (ret < 0)
-		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
-
-	return ret;
+	return 0;
 }
 
 /* Response handler for Mellanox card */


