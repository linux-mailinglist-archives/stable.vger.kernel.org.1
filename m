Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970A575D489
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbjGUTWQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjGUTWM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:22:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D129230F5
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66FCB61D54
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DFDC433C7;
        Fri, 21 Jul 2023 19:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967329;
        bh=waA/tFiiOjwIo9PFFLVgnfnFjHw1euWEW2h4SMzQ69I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tG5pTfLoAPV9ZKNYxluamT6KxVMmWq/wIF/gbqstg5zt3aaOOXHk4/Hnc7GM00YQN
         Xc0wFtZlGygo7fUZKf28uv1qoTrA5oD+faT++4EXbABDztkO0ptJSZB2qvOJkcJgc/
         M3kutrW9TPaJWIZUmJg+d/H4BAIYFIgb45cVpK20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 6.1 125/223] PCI: epf-test: Fix DMA transfer completion detection
Date:   Fri, 21 Jul 2023 18:06:18 +0200
Message-ID: <20230721160526.207095267@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Damien Le Moal <dlemoal@kernel.org>

commit 933f31a2fe1f20e5b1ee065579f652cd1b317183 upstream.

pci_epf_test_data_transfer() and pci_epf_test_dma_callback() are not
handling DMA transfer completion correctly, leading to completion
notifications to the RC side that are too early. This problem can be
detected when the RC side is running an IOMMU with messages such as:

  pci-endpoint-test 0000:0b:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x001c address=0xfff00000 flags=0x0000]

When running the pcitest.sh tests: the address used for a previous
test transfer generates the above error while the next test transfer is
running.

Fix this by testing the DMA transfer status in pci_epf_test_dma_callback()
and notifying the completion only when the transfer status is DMA_COMPLETE
or DMA_ERROR. Furthermore, in pci_epf_test_data_transfer(), be paranoid and
check again the transfer status and always call dmaengine_terminate_sync()
before returning.

Link: https://lore.kernel.org/r/20230415023542.77601-5-dlemoal@kernel.org
Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 38 +++++++++++++------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d65419735d2e..dbea6eb0dee7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -54,6 +54,9 @@ struct pci_epf_test {
 	struct delayed_work	cmd_handler;
 	struct dma_chan		*dma_chan_tx;
 	struct dma_chan		*dma_chan_rx;
+	struct dma_chan		*transfer_chan;
+	dma_cookie_t		transfer_cookie;
+	enum dma_status		transfer_status;
 	struct completion	transfer_complete;
 	bool			dma_supported;
 	bool			dma_private;
@@ -85,8 +88,14 @@ static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
 static void pci_epf_test_dma_callback(void *param)
 {
 	struct pci_epf_test *epf_test = param;
-
-	complete(&epf_test->transfer_complete);
+	struct dma_tx_state state;
+
+	epf_test->transfer_status =
+		dmaengine_tx_status(epf_test->transfer_chan,
+				    epf_test->transfer_cookie, &state);
+	if (epf_test->transfer_status == DMA_COMPLETE ||
+	    epf_test->transfer_status == DMA_ERROR)
+		complete(&epf_test->transfer_complete);
 }
 
 /**
@@ -120,7 +129,6 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 	struct dma_async_tx_descriptor *tx;
 	struct dma_slave_config sconf = {};
 	struct device *dev = &epf->dev;
-	dma_cookie_t cookie;
 	int ret;
 
 	if (IS_ERR_OR_NULL(chan)) {
@@ -152,25 +160,33 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 	}
 
 	reinit_completion(&epf_test->transfer_complete);
+	epf_test->transfer_chan = chan;
 	tx->callback = pci_epf_test_dma_callback;
 	tx->callback_param = epf_test;
-	cookie = tx->tx_submit(tx);
+	epf_test->transfer_cookie = tx->tx_submit(tx);
 
-	ret = dma_submit_error(cookie);
+	ret = dma_submit_error(epf_test->transfer_cookie);
 	if (ret) {
-		dev_err(dev, "Failed to do DMA tx_submit %d\n", cookie);
-		return -EIO;
+		dev_err(dev, "Failed to do DMA tx_submit %d\n", ret);
+		goto terminate;
 	}
 
 	dma_async_issue_pending(chan);
 	ret = wait_for_completion_interruptible(&epf_test->transfer_complete);
 	if (ret < 0) {
-		dmaengine_terminate_sync(chan);
-		dev_err(dev, "DMA wait_for_completion_timeout\n");
-		return -ETIMEDOUT;
+		dev_err(dev, "DMA wait_for_completion interrupted\n");
+		goto terminate;
 	}
 
-	return 0;
+	if (epf_test->transfer_status == DMA_ERROR) {
+		dev_err(dev, "DMA transfer failed\n");
+		ret = -EIO;
+	}
+
+terminate:
+	dmaengine_terminate_sync(chan);
+
+	return ret;
 }
 
 struct epf_dma_filter {
-- 
2.41.0



