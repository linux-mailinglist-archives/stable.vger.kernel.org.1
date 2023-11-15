Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3197ED475
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344709AbjKOU6J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344664AbjKOU5i (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4EFB7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81321C4166B;
        Wed, 15 Nov 2023 20:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081265;
        bh=BQJTWaQiFuq3CCUAPyDKynzd0EpX0jGzURYc/xTLOI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtWQSBRqkvvjsRuVQd2g9IS8Dxw90nnFfnmjwiofA2KDW4zLAZFzNn34lXtrlzQRz
         Wa8zu9x+1yanNc1vE1aF58JsrweL8O9qjICDQ+3O8JqibAhcYjfJ2qdqL3BAlsnSQK
         TMk03TjVAxcWUzflU1tBxXOyVfUgl00NjdsUnAHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 025/244] mt76: dma: use kzalloc instead of devm_kzalloc for txwi
Date:   Wed, 15 Nov 2023 15:33:37 -0500
Message-ID: <20231115203549.878532040@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 402e01092e79583923579662f244bc538f466f36 ]

dma unmap is already needed for cleanup anyway, so we don't need the extra
tracking and can save a bit of memory here

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Stable-dep-of: 317620593349 ("wifi: mt76: mt7603: improve stuck beacon handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 69e0e68757f53..1344c88729a84 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -16,7 +16,7 @@ mt76_alloc_txwi(struct mt76_dev *dev)
 	int size;
 
 	size = L1_CACHE_ALIGN(dev->drv->txwi_size + sizeof(*t));
-	txwi = devm_kzalloc(dev->dev, size, GFP_ATOMIC);
+	txwi = kzalloc(size, GFP_ATOMIC);
 	if (!txwi)
 		return NULL;
 
@@ -73,9 +73,11 @@ mt76_free_pending_txwi(struct mt76_dev *dev)
 	struct mt76_txwi_cache *t;
 
 	local_bh_disable();
-	while ((t = __mt76_get_txwi(dev)) != NULL)
+	while ((t = __mt76_get_txwi(dev)) != NULL) {
 		dma_unmap_single(dev->dev, t->dma_addr, dev->drv->txwi_size,
 				 DMA_TO_DEVICE);
+		kfree(mt76_get_txwi_ptr(dev, t));
+	}
 	local_bh_enable();
 }
 
-- 
2.42.0



