Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B2277AE11
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 00:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjHMWAS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 18:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjHMV7J (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389E52694
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C22B761B60
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35FBC433C8;
        Sun, 13 Aug 2023 21:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963025;
        bh=mCqvZt7xICFCSiofPWOuaRPTwXVLfS4/Q6cFloz4v4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HBzyXCyOxjLLih0ubKO5rBFdz04bdnFsz9R66wNzMlUaUDJTyHrdPSlFi9ZU2CCOD
         cr6Po3zmE6q7T5i+8UoRCdm+MULBPWwNxyumProIL6c5+dHGy7e32erdf5QdCkXcmq
         PwnGAgyNGcT5sw4+KPXq3MmNlvWIUF177a1+0vds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Richard Tresidder <rtresidd@electromag.com.au>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.15 06/89] dmaengine: pl330: Return DMA_PAUSED when transaction is paused
Date:   Sun, 13 Aug 2023 23:18:57 +0200
Message-ID: <20230813211710.973077723@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit 8cda3ececf07d374774f6a13e5a94bc2dc04c26c upstream.

pl330_pause() does not set anything to indicate paused condition which
causes pl330_tx_status() to return DMA_IN_PROGRESS. This breaks 8250
DMA flush after the fix in commit 57e9af7831dc ("serial: 8250_dma: Fix
DMA Rx rearm race"). The function comment for pl330_pause() claims
pause is supported but resume is not which is enough for 8250 DMA flush
to work as long as DMA status reports DMA_PAUSED when appropriate.

Add PAUSED state for descriptor and mark BUSY descriptors with PAUSED
in pl330_pause(). Return DMA_PAUSED from pl330_tx_status() when the
descriptor is PAUSED.

Reported-by: Richard Tresidder <rtresidd@electromag.com.au>
Tested-by: Richard Tresidder <rtresidd@electromag.com.au>
Fixes: 88987d2c7534 ("dmaengine: pl330: add DMA_PAUSE feature")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-serial/f8a86ecd-64b1-573f-c2fa-59f541083f1a@electromag.com.au/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20230526105434.14959-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/pl330.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -404,6 +404,12 @@ enum desc_status {
 	 */
 	BUSY,
 	/*
+	 * Pause was called while descriptor was BUSY. Due to hardware
+	 * limitations, only termination is possible for descriptors
+	 * that have been paused.
+	 */
+	PAUSED,
+	/*
 	 * Sitting on the channel work_list but xfer done
 	 * by PL330 core
 	 */
@@ -2041,7 +2047,7 @@ static inline void fill_queue(struct dma
 	list_for_each_entry(desc, &pch->work_list, node) {
 
 		/* If already submitted */
-		if (desc->status == BUSY)
+		if (desc->status == BUSY || desc->status == PAUSED)
 			continue;
 
 		ret = pl330_submit_req(pch->thread, desc);
@@ -2326,6 +2332,7 @@ static int pl330_pause(struct dma_chan *
 {
 	struct dma_pl330_chan *pch = to_pchan(chan);
 	struct pl330_dmac *pl330 = pch->dmac;
+	struct dma_pl330_desc *desc;
 	unsigned long flags;
 
 	pm_runtime_get_sync(pl330->ddma.dev);
@@ -2335,6 +2342,10 @@ static int pl330_pause(struct dma_chan *
 	_stop(pch->thread);
 	spin_unlock(&pl330->lock);
 
+	list_for_each_entry(desc, &pch->work_list, node) {
+		if (desc->status == BUSY)
+			desc->status = PAUSED;
+	}
 	spin_unlock_irqrestore(&pch->lock, flags);
 	pm_runtime_mark_last_busy(pl330->ddma.dev);
 	pm_runtime_put_autosuspend(pl330->ddma.dev);
@@ -2425,7 +2436,7 @@ pl330_tx_status(struct dma_chan *chan, d
 		else if (running && desc == running)
 			transferred =
 				pl330_get_current_xferred_count(pch, desc);
-		else if (desc->status == BUSY)
+		else if (desc->status == BUSY || desc->status == PAUSED)
 			/*
 			 * Busy but not running means either just enqueued,
 			 * or finished and not yet marked done
@@ -2442,6 +2453,9 @@ pl330_tx_status(struct dma_chan *chan, d
 			case DONE:
 				ret = DMA_COMPLETE;
 				break;
+			case PAUSED:
+				ret = DMA_PAUSED;
+				break;
 			case PREP:
 			case BUSY:
 				ret = DMA_IN_PROGRESS;


