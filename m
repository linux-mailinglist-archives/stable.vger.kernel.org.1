Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0DC75CEBD
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjGUQXr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjGUQW4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:22:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4714207
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0331061D22
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D600AC4163D;
        Fri, 21 Jul 2023 16:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956404;
        bh=Da9kvro/grYhupv8i8P4kiyuaVqjW9cpnxNRSiFB1/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLKPlvpE+3105Jy2dm/6epdJWeUWGCYUCTkbKBKJT3NKbbslx6GFWnHdQdFj8QK6y
         7P7tEL8p9uVIu66/fvn3RNLvaIMvBXPz9gLHWlQhZMql1dCbtrc7GI/UqwBbRhsalR
         1r/CQ0j43DQhSC8/EtbRu1UOTjn9gnA1sBPpKTa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 6.4 182/292] misc: pci_endpoint_test: Free IRQs before removing the device
Date:   Fri, 21 Jul 2023 18:04:51 +0200
Message-ID: <20230721160536.717982697@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Damien Le Moal <dlemoal@kernel.org>

commit f61b7634a3249d12b9daa36ffbdb9965b6f24c6c upstream.

In pci_endpoint_test_remove(), freeing the IRQs after removing the device
creates a small race window for IRQs to be received with the test device
memory already released, causing the IRQ handler to access invalid memory,
resulting in an oops.

Free the device IRQs before removing the device to avoid this issue.

Link: https://lore.kernel.org/r/20230415023542.77601-15-dlemoal@kernel.org
Fixes: e03327122e2c ("pci_endpoint_test: Add 2 ioctl commands")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/pci_endpoint_test.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -938,6 +938,9 @@ static void pci_endpoint_test_remove(str
 	if (id < 0)
 		return;
 
+	pci_endpoint_test_release_irq(test);
+	pci_endpoint_test_free_irq_vectors(test);
+
 	misc_deregister(&test->miscdev);
 	kfree(misc_device->name);
 	kfree(test->name);
@@ -947,9 +950,6 @@ static void pci_endpoint_test_remove(str
 			pci_iounmap(pdev, test->bar[bar]);
 	}
 
-	pci_endpoint_test_release_irq(test);
-	pci_endpoint_test_free_irq_vectors(test);
-
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 }


