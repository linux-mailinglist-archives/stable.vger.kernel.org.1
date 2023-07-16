Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D1D755352
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjGPURp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGPURp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:17:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D7F90
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:17:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F365F60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FFBC433C8;
        Sun, 16 Jul 2023 20:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538663;
        bh=4HnyfsApdWx8U2P+xgc8O4ZUYmzNRr2w1a4AjFiJl+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KKb2Ko3oB7/v3v8A+Vg1I/xLZmdhv+AKX7UaqiJDqFnyt6duzYu2qPySognGqbCLV
         eGHE3YeutDH0ZMX820ywYwAKuoWPyo+Ukz87ONVBhpEhj40Wzi8X4Cjm99SFmMc+gx
         L+U9rAEeU/MXS7ZyY52gtFSqS6KCNoUCaZviDL78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 496/800] PCI: endpoint: functions/pci-epf-test: Fix dma_chan direction
Date:   Sun, 16 Jul 2023 21:45:49 +0200
Message-ID: <20230716195000.602382840@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 880d51c729a3fa944794feb19f605eefe55916fc ]

In pci_epf_test_init_dma_chan() epf_test->dma_chan_rx is assigned from
dma_request_channel() with DMA_DEV_TO_MEM as filter.dma_mask.

However, in pci_epf_test_data_transfer() if the dir is DMA_DEV_TO_MEM,
epf->dma_chan_rx should be used but instead we are using
epf_test->dma_chan_tx.

Fix it.

Link: https://lore.kernel.org/r/20230412063447.2841177-1-yoshihiro.shimoda.uh@renesas.com
Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 0f9d2ec822ac6..172e5ac0bd96c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -112,7 +112,7 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 				      size_t len, dma_addr_t dma_remote,
 				      enum dma_transfer_direction dir)
 {
-	struct dma_chan *chan = (dir == DMA_DEV_TO_MEM) ?
+	struct dma_chan *chan = (dir == DMA_MEM_TO_DEV) ?
 				 epf_test->dma_chan_tx : epf_test->dma_chan_rx;
 	dma_addr_t dma_local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
-- 
2.39.2



