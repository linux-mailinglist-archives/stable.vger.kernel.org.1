Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EB96FAE03
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbjEHLkO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbjEHLj4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:39:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30B83F546
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:39:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76767634BC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64915C4339C;
        Mon,  8 May 2023 11:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545984;
        bh=DpsN/PTfhDbqzQuIHwAoWfdtocOIPa5v5t/5ET8qWOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MkY8dvNSpuoyQszYDVBuWogIdQvHkRIrl5JmJl5TQ4ZJWOMLM26wdsj0NVn+kRJeH
         nzAiQkXMW+HYOQ2x2lQ7ajICaYze381wmAv45Fkj0FTk2G5WXjoRSzelc5gkzITesV
         IR/kMNQliZa9UNQS0LSAMn4TkgH3AIGGKHyQd00s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lorenzo Bianconi <lorenzo@kernel.org>,
        Deren Wu <deren.wu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 218/371] wifi: mt76: add flexible polling wait-interval support
Date:   Mon,  8 May 2023 11:46:59 +0200
Message-Id: <20230508094820.715273275@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

[ Upstream commit 35effe6c0c24adcf0f732bb1c3d75573d4c88e63 ]

The default waiting unit is 10ms and the value is too much for
data path related control. Provide a new API mt76_poll_msec_tick()
to support different cases, such as 1ms polling waiting kick.

Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Stable-dep-of: c397fc1e6365 ("wifi: mt76: mt7921e: fix probe timeout after reboot")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h |  9 +++++----
 drivers/net/wireless/mediatek/mt76/util.c | 10 +++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4e4af6e17b503..eb1fb955b7777 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -820,10 +820,11 @@ bool __mt76_poll(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 
 #define mt76_poll(dev, ...) __mt76_poll(&((dev)->mt76), __VA_ARGS__)
 
-bool __mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
-		      int timeout);
-
-#define mt76_poll_msec(dev, ...) __mt76_poll_msec(&((dev)->mt76), __VA_ARGS__)
+bool ____mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
+			int timeout, int kick);
+#define __mt76_poll_msec(...)         ____mt76_poll_msec(__VA_ARGS__, 10)
+#define mt76_poll_msec(dev, ...)      ____mt76_poll_msec(&((dev)->mt76), __VA_ARGS__, 10)
+#define mt76_poll_msec_tick(dev, ...) ____mt76_poll_msec(&((dev)->mt76), __VA_ARGS__)
 
 void mt76_mmio_init(struct mt76_dev *dev, void __iomem *regs);
 void mt76_pci_disable_aspm(struct pci_dev *pdev);
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index 581964425468f..fc76c66ff1a5a 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -24,23 +24,23 @@ bool __mt76_poll(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 }
 EXPORT_SYMBOL_GPL(__mt76_poll);
 
-bool __mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
-		      int timeout)
+bool ____mt76_poll_msec(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
+			int timeout, int tick)
 {
 	u32 cur;
 
-	timeout /= 10;
+	timeout /= tick;
 	do {
 		cur = __mt76_rr(dev, offset) & mask;
 		if (cur == val)
 			return true;
 
-		usleep_range(10000, 20000);
+		usleep_range(1000 * tick, 2000 * tick);
 	} while (timeout-- > 0);
 
 	return false;
 }
-EXPORT_SYMBOL_GPL(__mt76_poll_msec);
+EXPORT_SYMBOL_GPL(____mt76_poll_msec);
 
 int mt76_wcid_alloc(u32 *mask, int size)
 {
-- 
2.39.2



