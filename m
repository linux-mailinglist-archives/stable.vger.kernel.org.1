Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445C07ECF3A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbjKOTrL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjKOTrK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:47:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F163A19E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:47:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70639C433C8;
        Wed, 15 Nov 2023 19:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077626;
        bh=Xo7gYG5PgFzZOnagYhIE1TIfEz5dHGJSeZrO2k14bIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eed5JkPQFctX5SLGpEKMGXt+Jz8/NQI72mewoFV6i6dzyx88byHzNwhMOkemIaJfz
         e3cWux6WzgAx2lM633vXCWlLh4hFBqCK8PYiSkgFTqmo+Ncjb4BAREBiYsxuk24Mqk
         Z0SthKrqXu4f9V93fCQxoBOGDEuLg9ItBXR9HWrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 397/603] PCI: endpoint: Fix double free in __pci_epc_create()
Date:   Wed, 15 Nov 2023 14:15:42 -0500
Message-ID: <20231115191640.545615035@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit c9501d268944d6c0475ecb3e740a084a7da9cbfe ]

The pci_epc_release() function frees "epc" so the kfree() on the next line
is a double free.  Drop the redundant free.

Fixes: 7711cbb4862a ("PCI: endpoint: Fix WARN() when an endpoint driver is removed")
Link: https://lore.kernel.org/r/2ce68694-87a7-4c06-b8a4-9870c891b580@moroto.mountain
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 5a4a8b0be6262..a7d3a92391a41 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -869,7 +869,6 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 
 put_dev:
 	put_device(&epc->dev);
-	kfree(epc);
 
 err_ret:
 	return ERR_PTR(ret);
-- 
2.42.0



