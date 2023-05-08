Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35766FA847
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjEHKjH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjEHKi7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:38:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9325D24A91
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:38:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A96662816
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FFAC4339B;
        Mon,  8 May 2023 10:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542336;
        bh=skFFywk52dAcgXA3YocwB7KdKfo0s77CUk/BIdMXGgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eTkgqE7Dk+BbVb3p6LJBCw/p3abbs9KN5AFepW5O5rBtMZsi6jDb+E3zKUM1tJKlm
         3usXO/hA03HDNTAWhYaOXVQTSfxnA+Ntm/21wFwPtZE+W68ow1UnZoOM+jpCg0UzRK
         9iQgkAhBzw2rwizPuz+cSWpi7btyXI/lVbro/mWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Wang <sean.wang@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Wang Zhao <wang.zhao@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 403/663] wifi: mt76: mt7921e: stop chip reset worker in unregister hook
Date:   Mon,  8 May 2023 11:43:49 +0200
Message-Id: <20230508094441.160529119@linuxfoundation.org>
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

[ Upstream commit 3d78c46423c6567ed25ca033e086865b1b4d5ae1 ]

If the chip reset worker is triggered during the remove process, the chip
DMA may not be properly pushed back to the idle state. This can lead to
corruption of the DMA flow due to the chip reset. Therefore, it is
necessary to stop the chip reset before the DMA is finalized.

To avoid resetting the chip after the reset worker is cancelled, use
__mt7921_mcu_drv_pmctrl() instead of mt7921_mcu_drv_pmctrl(). It is safe to
ignore the pm mutex because the pm worker and wake worker have already been
cancelled.

Fixes: 033ae79b3830 ("mt76: mt7921: refactor init.c to be bus independent")
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Co-developed-by: Wang Zhao <wang.zhao@mediatek.com>
Signed-off-by: Wang Zhao <wang.zhao@mediatek.com>
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index bda92d8359692..aa4ecf008a3c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -115,9 +115,10 @@ static void mt7921e_unregister_device(struct mt7921_dev *dev)
 		napi_disable(&dev->mt76.napi[i]);
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
+	cancel_work_sync(&dev->reset_work);
 
 	mt7921_tx_token_put(dev);
-	mt7921_mcu_drv_pmctrl(dev);
+	__mt7921_mcu_drv_pmctrl(dev);
 	mt7921_dma_cleanup(dev);
 	mt7921_wfsys_reset(dev);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
-- 
2.39.2



