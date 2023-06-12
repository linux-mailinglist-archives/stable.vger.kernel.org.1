Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D65072C1E9
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237485AbjFLLB1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbjFLLBC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:01:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F925B96
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA964624B0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED25AC4339B;
        Mon, 12 Jun 2023 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566885;
        bh=E7DnpHIGcrCuXvnjbUstcKpUxusShExzvXolHgxg54A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P6rkuKYhH6UGZGkY0vpPAfr5NgCeFn2qDyNNNKhKZup6J90LRcr2eVgGtXNr16XJt
         iEq/FHdB2DEI1AHLEwvcF5LI1ccx1mPUnf5wtwAXWj/AioZ9B+SsuJj4lDidcT0rU9
         O5O0jrx37DcPa0zM9EbOohgkx/XMrM6IHoMtg47s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 068/160] bnxt_en: Implement .set_port / .unset_port UDP tunnel callbacks
Date:   Mon, 12 Jun 2023 12:26:40 +0200
Message-ID: <20230612101718.121041875@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Somnath Kotur <somnath.kotur@broadcom.com>

[ Upstream commit 1eb4ef12591348c440ac9d6efcf7521e73cf2b10 ]

As per the new udp tunnel framework, drivers which need to know the
details of a port entry (i.e. port type) when it gets deleted should
use the .set_port / .unset_port callbacks.

Implementing the current .udp_tunnel_sync callback would mean that the
deleted tunnel port entry would be all zeros.  This used to work on
older firmware because it would not check the input when deleting a
tunnel port.  With newer firmware, the delete will now fail and
subsequent tunnel port allocation will fail as a result.

Fixes: 442a35a5a7aa ("bnxt: convert to new udp_tunnel_nic infra")
Reviewed-by: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 25 ++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f14519aa6d4f6..9784e86d4d96a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13062,26 +13062,37 @@ static void bnxt_cfg_ntp_filters(struct bnxt *bp)
 
 #endif /* CONFIG_RFS_ACCEL */
 
-static int bnxt_udp_tunnel_sync(struct net_device *netdev, unsigned int table)
+static int bnxt_udp_tunnel_set_port(struct net_device *netdev, unsigned int table,
+				    unsigned int entry, struct udp_tunnel_info *ti)
 {
 	struct bnxt *bp = netdev_priv(netdev);
-	struct udp_tunnel_info ti;
 	unsigned int cmd;
 
-	udp_tunnel_nic_get_port(netdev, table, 0, &ti);
-	if (ti.type == UDP_TUNNEL_TYPE_VXLAN)
+	if (ti->type == UDP_TUNNEL_TYPE_VXLAN)
 		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN;
 	else
 		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GENEVE;
 
-	if (ti.port)
-		return bnxt_hwrm_tunnel_dst_port_alloc(bp, ti.port, cmd);
+	return bnxt_hwrm_tunnel_dst_port_alloc(bp, ti->port, cmd);
+}
+
+static int bnxt_udp_tunnel_unset_port(struct net_device *netdev, unsigned int table,
+				      unsigned int entry, struct udp_tunnel_info *ti)
+{
+	struct bnxt *bp = netdev_priv(netdev);
+	unsigned int cmd;
+
+	if (ti->type == UDP_TUNNEL_TYPE_VXLAN)
+		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_VXLAN;
+	else
+		cmd = TUNNEL_DST_PORT_FREE_REQ_TUNNEL_TYPE_GENEVE;
 
 	return bnxt_hwrm_tunnel_dst_port_free(bp, cmd);
 }
 
 static const struct udp_tunnel_nic_info bnxt_udp_tunnels = {
-	.sync_table	= bnxt_udp_tunnel_sync,
+	.set_port	= bnxt_udp_tunnel_set_port,
+	.unset_port	= bnxt_udp_tunnel_unset_port,
 	.flags		= UDP_TUNNEL_NIC_INFO_MAY_SLEEP |
 			  UDP_TUNNEL_NIC_INFO_OPEN_ONLY,
 	.tables		= {
-- 
2.39.2



