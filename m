Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F68B78AD1C
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjH1Kpz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjH1Kp1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:45:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DA11B4
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:45:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DE7161943
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D01C433C8;
        Mon, 28 Aug 2023 10:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219462;
        bh=aAGzF/oGWN632POR1Rimjxpsnnbgen+mmDEr+XlOFtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHEkKrhnmSyLSW2k1uOdAWOemNZ6LX/1X244Nwnp6ut4uikoxG/SKDYYDxSF1fX4r
         v6ulVFtl3bOJD78YQDLEV9P/D/FM1Qf/w4A4WQeWA2NLmdYcUil2JOnO73Z/4TXTww
         hMvHeBXgI4LO6ZSRBQXQbW5faiJY6FVodZmhie9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Simon Horman <simon.horman@corigine.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 44/89] net/ncsi: make one oem_gma function for all mfr id
Date:   Mon, 28 Aug 2023 12:13:45 +0200
Message-ID: <20230828101151.654151435@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Mikhaylov <fr0st61te@gmail.com>

commit 74b449b98dccdf24288d562f9d207fa066da793d upstream.

Make the one Get Mac Address function for all manufacturers and change
this call in handlers accordingly.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ncsi/ncsi-rsp.c |   88 +++++++++++-----------------------------------------
 1 file changed, 19 insertions(+), 69 deletions(-)

--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -611,14 +611,15 @@ static int ncsi_rsp_handler_snfc(struct
 	return 0;
 }
 
-/* Response handler for Mellanox command Get Mac Address */
-static int ncsi_rsp_handler_oem_mlx_gma(struct ncsi_request *nr)
+/* Response handler for Get Mac Address command */
+static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 {
 	struct ncsi_dev_priv *ndp = nr->ndp;
 	struct net_device *ndev = ndp->ndev.dev;
 	const struct net_device_ops *ops = ndev->netdev_ops;
 	struct ncsi_rsp_oem_pkt *rsp;
 	struct sockaddr saddr;
+	u32 mac_addr_off = 0;
 	int ret = 0;
 
 	/* Get the response header */
@@ -626,7 +627,19 @@ static int ncsi_rsp_handler_oem_mlx_gma(
 
 	saddr.sa_family = ndev->type;
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
-	memcpy(saddr.sa_data, &rsp->data[MLX_MAC_ADDR_OFFSET], ETH_ALEN);
+	if (mfr_id == NCSI_OEM_MFR_BCM_ID)
+		mac_addr_off = BCM_MAC_ADDR_OFFSET;
+	else if (mfr_id == NCSI_OEM_MFR_MLX_ID)
+		mac_addr_off = MLX_MAC_ADDR_OFFSET;
+	else if (mfr_id == NCSI_OEM_MFR_INTEL_ID)
+		mac_addr_off = INTEL_MAC_ADDR_OFFSET;
+
+	memcpy(saddr.sa_data, &rsp->data[mac_addr_off], ETH_ALEN);
+	if (mfr_id == NCSI_OEM_MFR_BCM_ID || mfr_id == NCSI_OEM_MFR_INTEL_ID)
+		eth_addr_inc((u8 *)saddr.sa_data);
+	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
+		return -ENXIO;
+
 	/* Set the flag for GMA command which should only be called once */
 	ndp->gma_flag = 1;
 
@@ -649,41 +662,10 @@ static int ncsi_rsp_handler_oem_mlx(stru
 
 	if (mlx->cmd == NCSI_OEM_MLX_CMD_GMA &&
 	    mlx->param == NCSI_OEM_MLX_CMD_GMA_PARAM)
-		return ncsi_rsp_handler_oem_mlx_gma(nr);
+		return ncsi_rsp_handler_oem_gma(nr, NCSI_OEM_MFR_MLX_ID);
 	return 0;
 }
 
-/* Response handler for Broadcom command Get Mac Address */
-static int ncsi_rsp_handler_oem_bcm_gma(struct ncsi_request *nr)
-{
-	struct ncsi_dev_priv *ndp = nr->ndp;
-	struct net_device *ndev = ndp->ndev.dev;
-	const struct net_device_ops *ops = ndev->netdev_ops;
-	struct ncsi_rsp_oem_pkt *rsp;
-	struct sockaddr saddr;
-	int ret = 0;
-
-	/* Get the response header */
-	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
-
-	saddr.sa_family = ndev->type;
-	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
-	memcpy(saddr.sa_data, &rsp->data[BCM_MAC_ADDR_OFFSET], ETH_ALEN);
-	/* Increase mac address by 1 for BMC's address */
-	eth_addr_inc((u8 *)saddr.sa_data);
-	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
-		return -ENXIO;
-
-	/* Set the flag for GMA command which should only be called once */
-	ndp->gma_flag = 1;
-
-	ret = ops->ndo_set_mac_address(ndev, &saddr);
-	if (ret < 0)
-		netdev_warn(ndev, "NCSI: 'Writing mac address to device failed\n");
-
-	return ret;
-}
-
 /* Response handler for Broadcom card */
 static int ncsi_rsp_handler_oem_bcm(struct ncsi_request *nr)
 {
@@ -695,42 +677,10 @@ static int ncsi_rsp_handler_oem_bcm(stru
 	bcm = (struct ncsi_rsp_oem_bcm_pkt *)(rsp->data);
 
 	if (bcm->type == NCSI_OEM_BCM_CMD_GMA)
-		return ncsi_rsp_handler_oem_bcm_gma(nr);
+		return ncsi_rsp_handler_oem_gma(nr, NCSI_OEM_MFR_BCM_ID);
 	return 0;
 }
 
-/* Response handler for Intel command Get Mac Address */
-static int ncsi_rsp_handler_oem_intel_gma(struct ncsi_request *nr)
-{
-	struct ncsi_dev_priv *ndp = nr->ndp;
-	struct net_device *ndev = ndp->ndev.dev;
-	const struct net_device_ops *ops = ndev->netdev_ops;
-	struct ncsi_rsp_oem_pkt *rsp;
-	struct sockaddr saddr;
-	int ret = 0;
-
-	/* Get the response header */
-	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
-
-	saddr.sa_family = ndev->type;
-	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
-	memcpy(saddr.sa_data, &rsp->data[INTEL_MAC_ADDR_OFFSET], ETH_ALEN);
-	/* Increase mac address by 1 for BMC's address */
-	eth_addr_inc((u8 *)saddr.sa_data);
-	if (!is_valid_ether_addr((const u8 *)saddr.sa_data))
-		return -ENXIO;
-
-	/* Set the flag for GMA command which should only be called once */
-	ndp->gma_flag = 1;
-
-	ret = ops->ndo_set_mac_address(ndev, &saddr);
-	if (ret < 0)
-		netdev_warn(ndev,
-			    "NCSI: 'Writing mac address to device failed\n");
-
-	return ret;
-}
-
 /* Response handler for Intel card */
 static int ncsi_rsp_handler_oem_intel(struct ncsi_request *nr)
 {
@@ -742,7 +692,7 @@ static int ncsi_rsp_handler_oem_intel(st
 	intel = (struct ncsi_rsp_oem_intel_pkt *)(rsp->data);
 
 	if (intel->cmd == NCSI_OEM_INTEL_CMD_GMA)
-		return ncsi_rsp_handler_oem_intel_gma(nr);
+		return ncsi_rsp_handler_oem_gma(nr, NCSI_OEM_MFR_INTEL_ID);
 
 	return 0;
 }


