Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A796FAACF
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjEHLGp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjEHLG0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:06:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84872C921
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C797F62A84
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F67C433EF;
        Mon,  8 May 2023 11:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543922;
        bh=R6qexKvTMJNCeTfeuuWfunLi4lUS6rKWFa1Taf6sDwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wha7JLca14kTZSbAP3kpcis22PUsnsG5Ja1okPuJk05G5h835X8k9A2tAZ/099B+l
         ff2Mk2VbIWR/wRhUlZVnJcgU5qDl5vJ7f1PGzjP5Zr6FK10x/TRwm1dpH7IorRfUAx
         4QAMUTOvsSYaq/TswS/CU0eA9/D3p5cR2dKjN4Yg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jassi Brar <jaswinder.singh@linaro.org>,
        Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 243/694] mailbox: mpfs: switch to txdone_poll
Date:   Mon,  8 May 2023 11:41:18 +0200
Message-Id: <20230508094440.208724843@linuxfoundation.org>
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

From: Conor Dooley <conor.dooley@microchip.com>

[ Upstream commit b5984a9844fc45cd301a28fb56f3de95f7e20f3c ]

The system controller on PolarFire SoC has no interrupt to signify that
the TX has been completed. The interrupt instead signals that a service
requested by the mailbox client has succeeded. If a service fails, there
will be no interrupt delivered.

Switch to polling the busy register to determine whether transmission
has completed.

Fixes: 83d7b1560810 ("mbox: add polarfire soc system controller mailbox")
Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
Tested-by: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox-mpfs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
index 853901acaeec2..08aa840cccaca 100644
--- a/drivers/mailbox/mailbox-mpfs.c
+++ b/drivers/mailbox/mailbox-mpfs.c
@@ -79,6 +79,13 @@ static bool mpfs_mbox_busy(struct mpfs_mbox *mbox)
 	return status & SCB_STATUS_BUSY_MASK;
 }
 
+static bool mpfs_mbox_last_tx_done(struct mbox_chan *chan)
+{
+	struct mpfs_mbox *mbox = (struct mpfs_mbox *)chan->con_priv;
+
+	return !mpfs_mbox_busy(mbox);
+}
+
 static int mpfs_mbox_send_data(struct mbox_chan *chan, void *data)
 {
 	struct mpfs_mbox *mbox = (struct mpfs_mbox *)chan->con_priv;
@@ -182,7 +189,6 @@ static irqreturn_t mpfs_mbox_inbox_isr(int irq, void *data)
 
 	mpfs_mbox_rx_data(chan);
 
-	mbox_chan_txdone(chan, 0);
 	return IRQ_HANDLED;
 }
 
@@ -212,6 +218,7 @@ static const struct mbox_chan_ops mpfs_mbox_ops = {
 	.send_data = mpfs_mbox_send_data,
 	.startup = mpfs_mbox_startup,
 	.shutdown = mpfs_mbox_shutdown,
+	.last_tx_done = mpfs_mbox_last_tx_done,
 };
 
 static int mpfs_mbox_probe(struct platform_device *pdev)
@@ -247,7 +254,8 @@ static int mpfs_mbox_probe(struct platform_device *pdev)
 	mbox->controller.num_chans = 1;
 	mbox->controller.chans = mbox->chans;
 	mbox->controller.ops = &mpfs_mbox_ops;
-	mbox->controller.txdone_irq = true;
+	mbox->controller.txdone_poll = true;
+	mbox->controller.txpoll_period = 10u;
 
 	ret = devm_mbox_controller_register(&pdev->dev, &mbox->controller);
 	if (ret) {
-- 
2.39.2



