Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA379B9F3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbjIKWs3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbjIKO6U (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:58:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8841B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:58:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8946C433C8;
        Mon, 11 Sep 2023 14:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444296;
        bh=0b9jvVATzQ0SWSU+r8d0JzZDfWvkzwKks80cBvHD1V0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vR2Q0njEZNJTvxDxZ1G9KIWXNEt0hriLhhG9Cud1ebK8VTsI306KLTcegGSIC11Dd
         e0Zwk4f5TR30p3RbmwYqS8OBNxdGF60DNbweynNNWXvyZNmCw68oI8no0TpyiCydIY
         LWnoLY2LXAA9ftonA6Rm/g6ih6l+SZfJC6CyWTxE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 6.4 680/737] PCI: hv: Fix a crash in hv_pci_restore_msi_msg() during hibernation
Date:   Mon, 11 Sep 2023 15:48:59 +0200
Message-ID: <20230911134709.532937648@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit 04bbe863241a9be7d57fb4cf217ee4a72f480e70 upstream.

When a Linux VM with an assigned PCI device runs on Hyper-V, if the PCI
device driver is not loaded yet (i.e. MSI-X/MSI is not enabled on the
device yet), doing a VM hibernation triggers a panic in
hv_pci_restore_msi_msg() -> msi_lock_descs(&pdev->dev), because
pdev->dev.msi.data is still NULL.

Avoid the panic by checking if MSI-X/MSI is enabled.

Link: https://lore.kernel.org/r/20230816175939.21566-1-decui@microsoft.com
Fixes: dc2b453290c4 ("PCI: hv: Rework MSI handling")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: sathyanarayanan.kuppuswamy@linux.intel.com
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pci-hyperv.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3983,6 +3983,9 @@ static int hv_pci_restore_msi_msg(struct
 	struct msi_desc *entry;
 	int ret = 0;
 
+	if (!pdev->msi_enabled && !pdev->msix_enabled)
+		return 0;
+
 	msi_lock_descs(&pdev->dev);
 	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		irq_data = irq_get_irq_data(entry->irq);


