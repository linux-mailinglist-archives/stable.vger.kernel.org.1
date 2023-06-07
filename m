Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0D9726F73
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbjFGU63 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbjFGU6T (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:58:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0281BE8
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:57:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7846064885
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:57:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A9CC433A1;
        Wed,  7 Jun 2023 20:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171476;
        bh=AQZkEWPJZCOmrKCeBaK/NgPxSZBRArXcG/4wa1Lksfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XD/MUgH6GsYldOmrskL22jRvOa7BZvIREvX/zvWy37aWvIrcjfTa7Mj/2qc/xNYwo
         2gJCJReQI3fu6v19S75waxFUHsCPIkv1LCzbGj/2Jfb84gDHbV4iuTUMPDyl1fxtqE
         nmwsYzYMJ0oqllsreFl76nkd941Ix0WYNpPiV7WM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 015/159] net: mellanox: mlxbf_gige: Fix skb_panic splat under memory pressure
Date:   Wed,  7 Jun 2023 22:15:18 +0200
Message-ID: <20230607200904.171566470@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>

[ Upstream commit d68cb7cf1fd0ef4287bc0ecd1ed0b6ae8e05fc70 ]

Do skb_put() after a new skb has been successfully allocated otherwise
the reused skb leads to skb_panics or incorrect packet sizes.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230524194908.147145-1-tbogendoerfer@suse.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c    | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
index afa3b92a6905f..0d5a41a2ae010 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c
@@ -245,12 +245,6 @@ static bool mlxbf_gige_rx_packet(struct mlxbf_gige *priv, int *rx_pkts)
 
 		skb = priv->rx_skb[rx_pi_rem];
 
-		skb_put(skb, datalen);
-
-		skb->ip_summed = CHECKSUM_NONE; /* device did not checksum packet */
-
-		skb->protocol = eth_type_trans(skb, netdev);
-
 		/* Alloc another RX SKB for this same index */
 		rx_skb = mlxbf_gige_alloc_skb(priv, MLXBF_GIGE_DEFAULT_BUF_SZ,
 					      &rx_buf_dma, DMA_FROM_DEVICE);
@@ -259,6 +253,13 @@ static bool mlxbf_gige_rx_packet(struct mlxbf_gige *priv, int *rx_pkts)
 		priv->rx_skb[rx_pi_rem] = rx_skb;
 		dma_unmap_single(priv->dev, *rx_wqe_addr,
 				 MLXBF_GIGE_DEFAULT_BUF_SZ, DMA_FROM_DEVICE);
+
+		skb_put(skb, datalen);
+
+		skb->ip_summed = CHECKSUM_NONE; /* device did not checksum packet */
+
+		skb->protocol = eth_type_trans(skb, netdev);
+
 		*rx_wqe_addr = rx_buf_dma;
 	} else if (rx_cqe & MLXBF_GIGE_RX_CQE_PKT_STATUS_MAC_ERR) {
 		priv->stats.rx_mac_errors++;
-- 
2.39.2



