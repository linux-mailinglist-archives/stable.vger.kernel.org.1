Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1096FAC7A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjEHLY7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbjEHLYl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:24:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4663B799
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:24:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73C7C62D47
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66145C4339B;
        Mon,  8 May 2023 11:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545076;
        bh=TqNMd/yfqXAPuDwKNDOC/T8ginQj1+uCuWTIMOtBa3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1LzSmE4mwR3oWlAmZOAQvXHZjYQNFmw8fftUq/rDxNUdBlfBYulUptvpvhmq0BJKC
         dijBeKWfGgDKuriFtUKui91iXnK3RdkicQ9sidHb1YtOnfmuLaRIsqeRUa9CEkWosa
         0Lds7KbuPym9tNHZQjUSrJlRxwDomhF/+3BHlVQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kang Chen <void0red@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 575/694] IB/hifi1: add a null check of kzalloc_node in hfi1_ipoib_txreq_init
Date:   Mon,  8 May 2023 11:46:50 +0200
Message-Id: <20230508094453.544862060@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Kang Chen <void0red@gmail.com>

[ Upstream commit c874ad879c2f29ebe040a34b974389875c0d81eb ]

kzalloc_node may fails, check it and do the cleanup.

Fixes: b1151b74ff68 ("IB/hfi1: Fix alloc failure with larger txqueuelen")
Signed-off-by: Kang Chen <void0red@gmail.com>
Link: https://lore.kernel.org/r/20230227100212.910820-1-void0red@gmail.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/ipoib_tx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib_tx.c b/drivers/infiniband/hw/hfi1/ipoib_tx.c
index 5d9a7b09ca37e..349eb41391368 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_tx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_tx.c
@@ -737,10 +737,13 @@ int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv)
 		txq->tx_ring.shift = ilog2(tx_item_size);
 		txq->tx_ring.avail = hfi1_ipoib_ring_hwat(txq);
 		tx_ring = &txq->tx_ring;
-		for (j = 0; j < tx_ring_size; j++)
+		for (j = 0; j < tx_ring_size; j++) {
 			hfi1_txreq_from_idx(tx_ring, j)->sdma_hdr =
 				kzalloc_node(sizeof(*tx->sdma_hdr),
 					     GFP_KERNEL, priv->dd->node);
+			if (!hfi1_txreq_from_idx(tx_ring, j)->sdma_hdr)
+				goto free_txqs;
+		}
 
 		netif_napi_add_tx(dev, &txq->napi, hfi1_ipoib_poll_tx_ring);
 	}
-- 
2.39.2



