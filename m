Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2927D70C780
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjEVTaS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjEVTaQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:30:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D349C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4B49628E8
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D7AC433EF;
        Mon, 22 May 2023 19:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783814;
        bh=epnC/vfPO5E4R9rDEW28XCxqCp2NACQYaT8nEvZ1UKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pvhqOm3Rc+/bWpCmrRE55o+ukOXQB8EwuWeTu7YjOAE2RWKy1/GVFRDmhrWUEDaQq
         k1IFeRYQ/iZhGyMBSjmTAj+I+aS+TNcFoalaMldCZB1vOw+oyup+DaUdoKRwEVfVbL
         T+GI16TUTxn7ipmYwAdWXpH5p+6hGXU9Rlk1Eicw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 171/292] sfc: disable RXFCS and RXALL features by default
Date:   Mon, 22 May 2023 20:08:48 +0100
Message-Id: <20230522190410.238172161@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>

[ Upstream commit 134120b066044399ef59564ff3ba66ab344cfc5b ]

By default we would not want RXFCS and RXALL features enabled as they are
mainly intended for debugging purposes. This does not stop users from
enabling them later on as needed.

Fixes: 8e57daf70671 ("sfc_ef100: RX path for EF100")
Signed-off-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Co-developed-by: Edward Cree <ecree.xilinx@gmail.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/ef100_netdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/ef100_netdev.c b/drivers/net/ethernet/sfc/ef100_netdev.c
index ddcc325ed5701..c6b9ba6803c8d 100644
--- a/drivers/net/ethernet/sfc/ef100_netdev.c
+++ b/drivers/net/ethernet/sfc/ef100_netdev.c
@@ -372,7 +372,9 @@ int ef100_probe_netdev(struct efx_probe_data *probe_data)
 	efx->net_dev = net_dev;
 	SET_NETDEV_DEV(net_dev, &efx->pci_dev->dev);
 
-	net_dev->features |= efx->type->offload_features;
+	/* enable all supported features except rx-fcs and rx-all */
+	net_dev->features |= efx->type->offload_features &
+			     ~(NETIF_F_RXFCS | NETIF_F_RXALL);
 	net_dev->hw_features |= efx->type->offload_features;
 	net_dev->hw_enc_features |= efx->type->offload_features;
 	net_dev->vlan_features |= NETIF_F_HW_CSUM | NETIF_F_SG |
-- 
2.39.2



