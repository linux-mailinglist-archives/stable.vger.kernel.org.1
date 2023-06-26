Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3BB73E8ED
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjFZSar (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjFZSaU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D126E8
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0818460F39
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AF8C433C0;
        Mon, 26 Jun 2023 18:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804218;
        bh=833KK0nc6tkE4aZuu1pU9pr52LLJ5kHhy1L6KRxmO7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aVL9vtLvBzXuthwMhHb9CLHLZUm4WpOAEomYhVO8Tow38GhWZD6Ev52hxZqjzW+OB
         42+AfXHZSMOwOs7EklLR/kG9FpWGrxRyQUrHf439oW1JUv0xxrXRmLZ0bUX6DVWs8S
         hmRrVdb6tDTatuqCHBFC3ddwXYfC1dKR/Lzp2r8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [PATCH 6.1 053/170] PCI: hv: Fix a race condition in hv_irq_unmask() that can cause panic
Date:   Mon, 26 Jun 2023 20:10:22 +0200
Message-ID: <20230626180802.942125783@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

commit 2738d5ab7929a845b654cd171a1e275c37eb428e upstream.

When the host tries to remove a PCI device, the host first sends a
PCI_EJECT message to the guest, and the guest is supposed to gracefully
remove the PCI device and send a PCI_EJECTION_COMPLETE message to the host;
the host then sends a VMBus message CHANNELMSG_RESCIND_CHANNELOFFER to
the guest (when the guest receives this message, the device is already
unassigned from the guest) and the guest can do some final cleanup work;
if the guest fails to respond to the PCI_EJECT message within one minute,
the host sends the VMBus message CHANNELMSG_RESCIND_CHANNELOFFER and
removes the PCI device forcibly.

In the case of fast device addition/removal, it's possible that the PCI
device driver is still configuring MSI-X interrupts when the guest receives
the PCI_EJECT message; the channel callback calls hv_pci_eject_device(),
which sets hpdev->state to hv_pcichild_ejecting, and schedules a work
hv_eject_device_work(); if the PCI device driver is calling
pci_alloc_irq_vectors() -> ... -> hv_compose_msi_msg(), we can break the
while loop in hv_compose_msi_msg() due to the updated hpdev->state, and
leave data->chip_data with its default value of NULL; later, when the PCI
device driver calls request_irq() -> ... -> hv_irq_unmask(), the guest
crashes in hv_arch_irq_unmask() due to data->chip_data being NULL.

Fix the issue by not testing hpdev->state in the while loop: when the
guest receives PCI_EJECT, the device is still assigned to the guest, and
the guest has one minute to finish the device removal gracefully. We don't
really need to (and we should not) test hpdev->state in the loop.

Fixes: de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230615044451.5580-3-decui@microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/pci-hyperv.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -647,6 +647,11 @@ static void hv_arch_irq_unmask(struct ir
 	pbus = pdev->bus;
 	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
 	int_desc = data->chip_data;
+	if (!int_desc) {
+		dev_warn(&hbus->hdev->device, "%s() can not unmask irq %u\n",
+			 __func__, data->irq);
+		return;
+	}
 
 	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
 
@@ -1915,12 +1920,6 @@ static void hv_compose_msi_msg(struct ir
 		hv_pci_onchannelcallback(hbus);
 		spin_unlock_irqrestore(&channel->sched_lock, flags);
 
-		if (hpdev->state == hv_pcichild_ejecting) {
-			dev_err_once(&hbus->hdev->device,
-				     "the device is being ejected\n");
-			goto enable_tasklet;
-		}
-
 		udelay(100);
 	}
 


