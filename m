Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2636FA83F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbjEHKi7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbjEHKil (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:38:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AEF29446
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:38:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6F2361D57
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45E4C433D2;
        Mon,  8 May 2023 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542319;
        bh=dXgEGa6BFCGhBUfTgbDhuBvUxQVevaVdPPhVVcsOdBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UB6Pf71f8zZX/JS6E5rVvn2VXqR6S1QBmddf5jUqPgaPj/6ef52uo11EPLSILTiAn
         5L1oWZj6b6tvAAZyWzkr6HL3c8GupPMncm9ZjWijjwV+rbQmQn5IkBjH+rdg1dPMBA
         zkHpC/MVjAHmZ+DXEBl0E4YsTk9fv8UQhOo5Zq5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quan Zhou <quan.zhou@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 398/663] wifi: mt76: mt7921e: fix probe timeout after reboot
Date:   Mon,  8 May 2023 11:43:44 +0200
Message-Id: <20230508094441.003788560@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Quan Zhou <quan.zhou@mediatek.com>

[ Upstream commit c397fc1e6365a2a9e5540a85b2c1d4ea412aa0e2 ]

In system warm reboot scene, due to the polling timeout(now 1000us)
is too short to wait dma idle in time, it may make driver probe fail
with error code -ETIMEDOUT. Meanwhile, we also found the dma may take
around 70ms to enter idle state. Change the polling idle timeout to
100ms to avoid the probabilistic probe fail.

Tested pass with 5000 times warm reboot on x86 platform.

[4.477496] pci 0000:01:00.0: attach allowed to drvr mt7921e [internal device]
[4.478306] mt7921e 0000:01:00.0: ASIC revision: 79610010
[4.480063] mt7921e: probe of 0000:01:00.0 failed with error -110

Fixes: 0a1059d0f060 ("mt76: mt7921: move mt7921_dma_reset in dma.c")
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index d1f10f6d9adc3..dc4ccfef4b048 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -90,9 +90,9 @@ static int mt7921_dma_disable(struct mt7921_dev *dev, bool force)
 		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO |
 		   MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2);
 
-	if (!mt76_poll(dev, MT_WFDMA0_GLO_CFG,
-		       MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
-		       MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 1000))
+	if (!mt76_poll_msec_tick(dev, MT_WFDMA0_GLO_CFG,
+				 MT_WFDMA0_GLO_CFG_TX_DMA_BUSY |
+				 MT_WFDMA0_GLO_CFG_RX_DMA_BUSY, 0, 100, 1))
 		return -ETIMEDOUT;
 
 	return 0;
-- 
2.39.2



