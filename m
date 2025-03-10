Return-Path: <stable+bounces-122700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AFEA5A0D2
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1F71891012
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABED623237F;
	Mon, 10 Mar 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iKlyB23C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A16E17CA12;
	Mon, 10 Mar 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629247; cv=none; b=K2WjseTFkIQmPudBFU7hQqwiWGiDIDhoMC7nqcPCn/23BsIyT1yzXjFqZ33WjY/yR2DLmpmgj+F98lT0vRq3xv+wNaCnR/Y1W4wIy+h+SCFNyUigbA0ZkCm5PRnK7om0K4qQH9c21/JkAvY4sBoaczPGykZTt5tQczbffr7dRDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629247; c=relaxed/simple;
	bh=/9lUJ1QQySVCmg+rvzrhgMV7MtKPtR17Hi3QjddtraU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WH1A8m6D+LsenQsL8cnz2gvBavymMMXoWqCnESHvYaZFSpoRXG/Gp0SpOVMO0900SH6Ttfhg4nwCp9ZiiZ6Dig9oJ2NUjaUJlgqhzXVrKl+dA/V1L+kRLu3/71Zqqz1BHAH/YyxKwQJSCQtvUKkJERNglQuHdB4qXBEpznTCk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iKlyB23C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD675C4CEE5;
	Mon, 10 Mar 2025 17:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741629247;
	bh=/9lUJ1QQySVCmg+rvzrhgMV7MtKPtR17Hi3QjddtraU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKlyB23C2tDkxa6BOPwZjp7BP9Bg0OU1VboFGgI8jJTRUAuKUWx2vmM0lDyLqrODH
	 2CUAdl8QDt6QKQretYbo1Ei+GuaTM1n51TAt8gYrDZtoyggIuTtWsf3NRImcQ6WURw
	 5ux94pagBz5k7Io0RgCERq4Q2eK30yS7NglrLQMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Delevoryas <peter@pjd.dev>,
	Patrick Williams <patrick@stwcx.xyz>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 229/620] net/ncsi: Add NC-SI 1.2 Get MC MAC Address command
Date: Mon, 10 Mar 2025 18:01:15 +0100
Message-ID: <20250310170554.674471307@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Delevoryas <peter@pjd.dev>

[ Upstream commit b8291cf3d1180b5b61299922f17c9441616a805a ]

This change adds support for the NC-SI 1.2 Get MC MAC Address command,
specified here:

https://www.dmtf.org/sites/default/files/standards/documents/DSP0222_1.2.0.pdf

It serves the exact same function as the existing OEM Get MAC Address
commands, so if a channel reports that it supports NC-SI 1.2, we prefer
to use the standard command rather than the OEM command.

Verified with an invalid MAC address and 2 valid ones:

[   55.137072] ftgmac100 1e690000.ftgmac eth0: NCSI: Received 3 provisioned MAC addresses
[   55.137614] ftgmac100 1e690000.ftgmac eth0: NCSI: MAC address 0: 00:00:00:00:00:00
[   55.138026] ftgmac100 1e690000.ftgmac eth0: NCSI: MAC address 1: fa:ce:b0:0c:20:22
[   55.138528] ftgmac100 1e690000.ftgmac eth0: NCSI: MAC address 2: fa:ce:b0:0c:20:23
[   55.139241] ftgmac100 1e690000.ftgmac eth0: NCSI: Unable to assign 00:00:00:00:00:00 to device
[   55.140098] ftgmac100 1e690000.ftgmac eth0: NCSI: Set MAC address to fa:ce:b0:0c:20:22

Signed-off-by: Peter Delevoryas <peter@pjd.dev>
Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 9e2bbab94b88 ("net/ncsi: fix locking in Get MAC Address handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ncsi/ncsi-cmd.c    |  3 ++-
 net/ncsi/ncsi-manage.c |  9 +++++++--
 net/ncsi/ncsi-pkt.h    | 10 ++++++++++
 net/ncsi/ncsi-rsp.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/net/ncsi/ncsi-cmd.c b/net/ncsi/ncsi-cmd.c
index dda8b76b77988..7be177f551731 100644
--- a/net/ncsi/ncsi-cmd.c
+++ b/net/ncsi/ncsi-cmd.c
@@ -269,7 +269,8 @@ static struct ncsi_cmd_handler {
 	{ NCSI_PKT_CMD_GPS,    0, ncsi_cmd_handler_default },
 	{ NCSI_PKT_CMD_OEM,   -1, ncsi_cmd_handler_oem     },
 	{ NCSI_PKT_CMD_PLDM,   0, NULL                     },
-	{ NCSI_PKT_CMD_GPUUID, 0, ncsi_cmd_handler_default }
+	{ NCSI_PKT_CMD_GPUUID, 0, ncsi_cmd_handler_default },
+	{ NCSI_PKT_CMD_GMCMA,  0, ncsi_cmd_handler_default }
 };
 
 static struct ncsi_request *ncsi_alloc_command(struct ncsi_cmd_arg *nca)
diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 30f5502530374..da7013c407012 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1040,11 +1040,16 @@ static void ncsi_configure_channel(struct ncsi_dev_priv *ndp)
 	case ncsi_dev_state_config_oem_gma:
 		nd->state = ncsi_dev_state_config_clear_vids;
 
-		nca.type = NCSI_PKT_CMD_OEM;
 		nca.package = np->id;
 		nca.channel = nc->id;
 		ndp->pending_req_num = 1;
-		ret = ncsi_gma_handler(&nca, nc->version.mf_id);
+		if (nc->version.major >= 1 && nc->version.minor >= 2) {
+			nca.type = NCSI_PKT_CMD_GMCMA;
+			ret = ncsi_xmit_cmd(&nca);
+		} else {
+			nca.type = NCSI_PKT_CMD_OEM;
+			ret = ncsi_gma_handler(&nca, nc->version.mf_id);
+		}
 		if (ret < 0)
 			schedule_work(&ndp->work);
 
diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
index c9d1da34dc4dc..f2f3b5c1b9412 100644
--- a/net/ncsi/ncsi-pkt.h
+++ b/net/ncsi/ncsi-pkt.h
@@ -338,6 +338,14 @@ struct ncsi_rsp_gpuuid_pkt {
 	__be32                  checksum;
 };
 
+/* Get MC MAC Address */
+struct ncsi_rsp_gmcma_pkt {
+	struct ncsi_rsp_pkt_hdr rsp;
+	unsigned char           address_count;
+	unsigned char           reserved[3];
+	unsigned char           addresses[][ETH_ALEN];
+};
+
 /* AEN: Link State Change */
 struct ncsi_aen_lsc_pkt {
 	struct ncsi_aen_pkt_hdr aen;        /* AEN header      */
@@ -398,6 +406,7 @@ struct ncsi_aen_hncdsc_pkt {
 #define NCSI_PKT_CMD_GPUUID	0x52 /* Get package UUID                 */
 #define NCSI_PKT_CMD_QPNPR	0x56 /* Query Pending NC PLDM request */
 #define NCSI_PKT_CMD_SNPR	0x57 /* Send NC PLDM Reply  */
+#define NCSI_PKT_CMD_GMCMA	0x58 /* Get MC MAC Address */
 
 
 /* NCSI packet responses */
@@ -433,6 +442,7 @@ struct ncsi_aen_hncdsc_pkt {
 #define NCSI_PKT_RSP_GPUUID	(NCSI_PKT_CMD_GPUUID + 0x80)
 #define NCSI_PKT_RSP_QPNPR	(NCSI_PKT_CMD_QPNPR   + 0x80)
 #define NCSI_PKT_RSP_SNPR	(NCSI_PKT_CMD_SNPR   + 0x80)
+#define NCSI_PKT_RSP_GMCMA	(NCSI_PKT_CMD_GMCMA  + 0x80)
 
 /* NCSI response code/reason */
 #define NCSI_PKT_RSP_C_COMPLETED	0x0000 /* Command Completed        */
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index f22d67cb04d37..e28be33bdf2c4 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -1093,6 +1093,44 @@ static int ncsi_rsp_handler_netlink(struct ncsi_request *nr)
 	return ret;
 }
 
+static int ncsi_rsp_handler_gmcma(struct ncsi_request *nr)
+{
+	struct ncsi_dev_priv *ndp = nr->ndp;
+	struct net_device *ndev = ndp->ndev.dev;
+	struct ncsi_rsp_gmcma_pkt *rsp;
+	struct sockaddr saddr;
+	int ret = -1;
+	int i;
+
+	rsp = (struct ncsi_rsp_gmcma_pkt *)skb_network_header(nr->rsp);
+	saddr.sa_family = ndev->type;
+	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+
+	netdev_info(ndev, "NCSI: Received %d provisioned MAC addresses\n",
+		    rsp->address_count);
+	for (i = 0; i < rsp->address_count; i++) {
+		netdev_info(ndev, "NCSI: MAC address %d: %02x:%02x:%02x:%02x:%02x:%02x\n",
+			    i, rsp->addresses[i][0], rsp->addresses[i][1],
+			    rsp->addresses[i][2], rsp->addresses[i][3],
+			    rsp->addresses[i][4], rsp->addresses[i][5]);
+	}
+
+	for (i = 0; i < rsp->address_count; i++) {
+		memcpy(saddr.sa_data, &rsp->addresses[i], ETH_ALEN);
+		ret = ndev->netdev_ops->ndo_set_mac_address(ndev, &saddr);
+		if (ret < 0) {
+			netdev_warn(ndev, "NCSI: Unable to assign %pM to device\n",
+				    saddr.sa_data);
+			continue;
+		}
+		netdev_warn(ndev, "NCSI: Set MAC address to %pM\n", saddr.sa_data);
+		break;
+	}
+
+	ndp->gma_flag = ret == 0;
+	return ret;
+}
+
 static struct ncsi_rsp_handler {
 	unsigned char	type;
 	int             payload;
@@ -1129,7 +1167,8 @@ static struct ncsi_rsp_handler {
 	{ NCSI_PKT_RSP_PLDM,   -1, ncsi_rsp_handler_pldm    },
 	{ NCSI_PKT_RSP_GPUUID, 20, ncsi_rsp_handler_gpuuid  },
 	{ NCSI_PKT_RSP_QPNPR,  -1, ncsi_rsp_handler_pldm    },
-	{ NCSI_PKT_RSP_SNPR,   -1, ncsi_rsp_handler_pldm    }
+	{ NCSI_PKT_RSP_SNPR,   -1, ncsi_rsp_handler_pldm    },
+	{ NCSI_PKT_RSP_GMCMA,  -1, ncsi_rsp_handler_gmcma   },
 };
 
 int ncsi_rcv_rsp(struct sk_buff *skb, struct net_device *dev,
-- 
2.39.5




