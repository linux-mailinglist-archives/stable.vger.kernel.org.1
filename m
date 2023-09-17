Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE727A3BA6
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbjIQUUX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240819AbjIQUUL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:20:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE879191
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:20:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35D3C433C7;
        Sun, 17 Sep 2023 20:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982002;
        bh=UAGG6Rg7gfRtQCEXXMNndJdGYaa9zXZMvJo3O0zwtqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ExBvBF6GwYZP9+LFJIShm2xAfRE59FWYLekVwIWTVg3aZNk5GrkRYNRaKUPkauJOJ
         nuzY5qgsQdkexmWKCc8YygjoK2Krn8hog08LYq4MXyTVdNyjG1UqqTwdwEYDKIn1D3
         wbg9nFBzri4l1NArDRbJDDqTnsrNWfhcCT2ByvSE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liming Sun <limings@nvidia.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 204/219] platform/mellanox: mlxbf-tmfifo: Drop jumbo frames
Date:   Sun, 17 Sep 2023 21:15:31 +0200
Message-ID: <20230917191048.315421134@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liming Sun <limings@nvidia.com>

[ Upstream commit fc4c655821546239abb3cf4274d66b9747aa87dd ]

This commit drops over-sized network packets to avoid tmfifo
queue stuck.

Fixes: 1357dfd7261f ("platform/mellanox: Add TmFifo driver for Mellanox BlueField Soc")
Signed-off-by: Liming Sun <limings@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
Link: https://lore.kernel.org/r/9318936c2447f76db475c985ca6d91f057efcd41.1693322547.git.limings@nvidia.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index ee8648a271fda..a04ff89a7ec44 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -205,7 +205,7 @@ static u8 mlxbf_tmfifo_net_default_mac[ETH_ALEN] = {
 static efi_char16_t mlxbf_tmfifo_efi_name[] = L"RshimMacAddr";
 
 /* Maximum L2 header length. */
-#define MLXBF_TMFIFO_NET_L2_OVERHEAD	36
+#define MLXBF_TMFIFO_NET_L2_OVERHEAD	(ETH_HLEN + VLAN_HLEN)
 
 /* Supported virtio-net features. */
 #define MLXBF_TMFIFO_NET_FEATURES \
@@ -623,13 +623,14 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
  * flag is set.
  */
 static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
-				     struct vring_desc *desc,
+				     struct vring_desc **desc,
 				     bool is_rx, bool *vring_change)
 {
 	struct mlxbf_tmfifo *fifo = vring->fifo;
 	struct virtio_net_config *config;
 	struct mlxbf_tmfifo_msg_hdr hdr;
 	int vdev_id, hdr_len;
+	bool drop_rx = false;
 
 	/* Read/Write packet header. */
 	if (is_rx) {
@@ -649,8 +650,8 @@ static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
 			if (ntohs(hdr.len) >
 			    __virtio16_to_cpu(virtio_legacy_is_little_endian(),
 					      config->mtu) +
-			    MLXBF_TMFIFO_NET_L2_OVERHEAD)
-				return;
+					      MLXBF_TMFIFO_NET_L2_OVERHEAD)
+				drop_rx = true;
 		} else {
 			vdev_id = VIRTIO_ID_CONSOLE;
 			hdr_len = 0;
@@ -665,16 +666,25 @@ static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
 
 			if (!tm_dev2)
 				return;
-			vring->desc = desc;
+			vring->desc = *desc;
 			vring = &tm_dev2->vrings[MLXBF_TMFIFO_VRING_RX];
 			*vring_change = true;
 		}
+
+		if (drop_rx && !IS_VRING_DROP(vring)) {
+			if (vring->desc_head)
+				mlxbf_tmfifo_release_pkt(vring);
+			*desc = &vring->drop_desc;
+			vring->desc_head = *desc;
+			vring->desc = *desc;
+		}
+
 		vring->pkt_len = ntohs(hdr.len) + hdr_len;
 	} else {
 		/* Network virtio has an extra header. */
 		hdr_len = (vring->vdev_id == VIRTIO_ID_NET) ?
 			   sizeof(struct virtio_net_hdr) : 0;
-		vring->pkt_len = mlxbf_tmfifo_get_pkt_len(vring, desc);
+		vring->pkt_len = mlxbf_tmfifo_get_pkt_len(vring, *desc);
 		hdr.type = (vring->vdev_id == VIRTIO_ID_NET) ?
 			    VIRTIO_ID_NET : VIRTIO_ID_CONSOLE;
 		hdr.len = htons(vring->pkt_len - hdr_len);
@@ -723,7 +733,7 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct mlxbf_tmfifo_vring *vring,
 
 	/* Beginning of a packet. Start to Rx/Tx packet header. */
 	if (vring->pkt_len == 0) {
-		mlxbf_tmfifo_rxtx_header(vring, desc, is_rx, &vring_change);
+		mlxbf_tmfifo_rxtx_header(vring, &desc, is_rx, &vring_change);
 		(*avail)--;
 
 		/* Return if new packet is for another ring. */
-- 
2.40.1



