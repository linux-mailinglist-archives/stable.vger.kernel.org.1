Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0717ECD4E
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjKOTfo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbjKOTfm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:35:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACB1A4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:35:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DC5C433C8;
        Wed, 15 Nov 2023 19:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076938;
        bh=2zRyF1NNYAQ8zdx4a2sbeQX2KeMn63C4FvBJBcOfTSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJTnHywl9FyIs04PLXCO4mCbXnHvTUYIiWOwIMvPPecALetREiKQc1yExCzKerVg2
         myTOd7SI1L9wFB/QxX3QYG6X6+rAwmvyl8t/lSK2DkLWgOKs/mQePPj9G0NoJJFGX1
         wH1cwQOgxNEVUIv/TFj3rIOYS6yD4nnSc88dvzN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Baochen Qiang <quic_bqiang@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 074/603] wifi: ath12k: fix DMA unmap warning on NULL DMA address
Date:   Wed, 15 Nov 2023 14:10:19 -0500
Message-ID: <20231115191618.225770681@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baochen Qiang <quic_bqiang@quicinc.com>

[ Upstream commit 9ae8c496d211155a3f220b63da364fba1a794292 ]

In ath12k_dp_tx(), if we reach fail_dma_unmap due to some errors,
current code does DMA unmap unconditionally on skb_cb->paddr_ext_desc.
However, skb_cb->paddr_ext_desc may be NULL and thus we get below
warning:

kernel: [ 8887.076212] WARNING: CPU: 3 PID: 0 at drivers/iommu/dma-iommu.c:1077 iommu_dma_unmap_page+0x79/0x90

Fix it by checking skb_cb->paddr_ext_desc before unmap it.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230830021131.5610-1-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_tx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 8874c815d7faf..16d889fc20433 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -330,8 +330,11 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
 
 fail_unmap_dma:
 	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);
-	dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
-			 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
+
+	if (skb_cb->paddr_ext_desc)
+		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
+				 sizeof(struct hal_tx_msdu_ext_desc),
+				 DMA_TO_DEVICE);
 
 fail_remove_tx_buf:
 	ath12k_dp_tx_release_txbuf(dp, tx_desc, pool_id);
-- 
2.42.0



