Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76B66FAB98
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjEHLPN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjEHLPM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:15:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7913F36CCB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:15:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ED1862BDF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38E5C433EF;
        Mon,  8 May 2023 11:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544510;
        bh=AezFzS6WqfQd7JL/0wiv/83Q8OlHz6O+F7MIEe5+RO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EzFyOx89N7HDr0/brGrlRojPjCUrlq6Y58KVAlFr62MsBe84+i3PsNvNYcpO1k0lS
         AQcnImePIyixaxeZ3gnMPjKT9ObqlvmjANvCbT8CEYNV9Cgql7kFQR5810BpZAMmvk
         FOvqcp57PZU9yfwUYwhWp+SgXJVCfDsNV3uSRgFA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Deren Wu <deren.wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 433/694] wifi: mt76: mt7921: fix PCI DMA hang after reboot
Date:   Mon,  8 May 2023 11:44:28 +0200
Message-Id: <20230508094447.431130001@linuxfoundation.org>
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

From: Deren Wu <deren.wu@mediatek.com>

[ Upstream commit 9270270d62191b7549296721e8d5f3dc0df01563 ]

mt7921 just stop some workers and clean up chip status before reboot.
In stress test, there are working activities still running at the period
of .shutdown callback and that would cause some hosts cannot recover
DMA after reboot. To avoid the floating state in reboot, we use
mt7921_pci_remove() to fully deinit all resources.

Fixes: f23a0cea8bd6 ("wifi: mt76: mt7921e: add pci .shutdown() support")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 41be108e1d5a1..bda92d8359692 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -515,17 +515,7 @@ static int mt7921_pci_resume(struct device *device)
 
 static void mt7921_pci_shutdown(struct pci_dev *pdev)
 {
-	struct mt76_dev *mdev = pci_get_drvdata(pdev);
-	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
-	struct mt76_connac_pm *pm = &dev->pm;
-
-	cancel_delayed_work_sync(&pm->ps_work);
-	cancel_work_sync(&pm->wake_work);
-
-	/* chip cleanup before reboot */
-	mt7921_mcu_drv_pmctrl(dev);
-	mt7921_dma_cleanup(dev);
-	mt7921_wfsys_reset(dev);
+	mt7921_pci_remove(pdev);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(mt7921_pm_ops, mt7921_pci_suspend, mt7921_pci_resume);
-- 
2.39.2



