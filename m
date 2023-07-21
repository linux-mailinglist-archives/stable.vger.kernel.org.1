Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B156F75D488
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjGUTWO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjGUTWL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:22:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE15A30F1
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86BBF61D6D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B35C433C7;
        Fri, 21 Jul 2023 19:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967327;
        bh=ObvbUVw/4OgbXT+tUj1u4DK/ZeG5T70Za7ACJ+QYkWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lEqwYOGg26NPGm8uDXmTWH6vEd2yHMMCtEFktkJ1m5fijCT1HpnGwhb+T/xbt4DbH
         msH8YupyjpnA9kYpASRB6Ilk6V4IRBa3uPdedf7uMkN3JlndCL7lMn2eFE9ER94P5V
         VD5FlE8TFou+tO8ug9RGAA+a2ktTYM7aaYOBdsrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 6.1 124/223] PCI: epf-test: Fix DMA transfer completion initialization
Date:   Fri, 21 Jul 2023 18:06:17 +0200
Message-ID: <20230721160526.166170608@linuxfoundation.org>
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

commit 4aca56f8eae8aa44867ddd6aa107e06f7613226f upstream.

Reinitialize the transfer_complete DMA transfer completion before calling
tx_submit(), to avoid seeing the DMA transfer complete before the
completion is initialized, thus potentially losing the completion
notification.

Link: https://lore.kernel.org/r/20230415023542.77601-4-dlemoal@kernel.org
Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 0f9d2ec822ac..d65419735d2e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -151,10 +151,10 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		return -EIO;
 	}
 
+	reinit_completion(&epf_test->transfer_complete);
 	tx->callback = pci_epf_test_dma_callback;
 	tx->callback_param = epf_test;
 	cookie = tx->tx_submit(tx);
-	reinit_completion(&epf_test->transfer_complete);
 
 	ret = dma_submit_error(cookie);
 	if (ret) {
-- 
2.41.0



