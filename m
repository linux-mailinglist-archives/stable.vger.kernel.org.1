Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC6575CE7A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjGUQVC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjGUQUW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9D344B9
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6785F61D2F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CA8C433C9;
        Fri, 21 Jul 2023 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956344;
        bh=EUOKYHdjIiACQL8g2qgM+0a8QXKHvE2E86TK95+mhFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NvgrEwQLJlAkuas3mgXkElfR2hEsWnOt4MDiqFbMavr0QCJM2AiWflYO+YJFFe19F
         VV1iqdnUeaafMxpoZruBUC6ZSvZGYcuNZitqZ7q1YkLxzuBwj1Dt/jj0vIwvIUC/ov
         Clj9QVweUBf4IWmipzrpZhqemA0T7vDr2jriZFcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 6.4 174/292] PCI: epf-test: Fix DMA transfer completion initialization
Date:   Fri, 21 Jul 2023 18:04:43 +0200
Message-ID: <20230721160536.375618525@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pci/endpoint/functions/pci-epf-test.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -151,10 +151,10 @@ static int pci_epf_test_data_transfer(st
 		return -EIO;
 	}
 
+	reinit_completion(&epf_test->transfer_complete);
 	tx->callback = pci_epf_test_dma_callback;
 	tx->callback_param = epf_test;
 	cookie = tx->tx_submit(tx);
-	reinit_completion(&epf_test->transfer_complete);
 
 	ret = dma_submit_error(cookie);
 	if (ret) {


